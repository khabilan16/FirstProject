@ECHO off
@SETLOCAL
@SET MODE=Release
@FOR %%A IN (%*) DO @IF "%%A"=="Debug" @SET MODE=Debug

REM Provide solution path and sonar key for the service
@SET SOLU="dotnetHelloWorld.sln"
@SET SOLUPATH="."


@SET MSBUILDDIR=C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\MSBuild\15.0\Bin


@ECHO *** Build Script Execution Starts ***

@ECHO *** Restore Nuget Package ***
REM "%SOLUPATH%\.nuget\NuGet.exe" restore %SOLU%
CD %SOLUPATH% 
dotnet restore --configfile ".nuget\nuget.config"
@ECHO *** Restoration of Nuget package completed ***


@ECHO *** Rebuild the solution in %MODE% Mode ***

@SET MSBUILDARGS=/t:Rebuild /v:m /m:2 /p:Configuration=%MODE% /clp:ErrorsOnly 

@SET StartTime=%Time%
@"%MSBUILDDIR%\msbuild.exe" %SOLU% %MSBUILDARGS% /fl /flp:ErrorsOnly;WarningsOnly
@SET EndTime=%Time%
@SET BUILD_STATUS=%ERRORLEVEL% 
@IF not %BUILD_STATUS%==0 goto fail 
@ECHO Build Start: %StartTime%
@ECHO Build End:   %EndTime%
@ECHO *** Rebuild in %MODE% mode completed ***


@IF NOT "%CHAINEDCALL%"=="true" PAUSE
@ENDLOCAL
@GOTO End

:fail 
@EXIT /b 1 

:End

@ECHO *** Build Script Execution completed ***
