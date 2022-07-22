@ECHO OFF
@SETLOCAL
@SET CHAINEDCALL=true
@SET MODE=Debug
@FOR %%A IN (%*) DO @IF "%%A"=="nochain" @SET CHAINEDCALL=false
@FOR %%A IN (%*) DO @IF "%%A"=="Release" @SET MODE=Release

@SET SOLU="src\dotnetHelloWorld\dotnetHelloWorld.csproj"
@SET PROFILE="src\dotnetHelloWorld\bin\%MODE%\staging"

  
@SET MSBUILDDIR=C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\MSBuild\15.0\Bin

@ECHO Hello Word Publishing to folder in %MODE% mode..
@SET StartTime=%Time%
@ECHO %SOLU%
@ECHO %PROFILE%
@dotnet build %SOLU% /p:PublishProfile=Release /p:PackageLocation="%PROFILE%\package.zip" /p:DeployOnBuild=true /p:WebPublishMethod=Package /p:PackageAsSingleFile=true /p:platform="Any CPU" /p:configuration="Release"
@SET EndTime=%Time%
@SET BUILD_STATUS=%ERRORLEVEL% 
@IF not %BUILD_STATUS%==0 goto fail 
@ECHO Build Start: %StartTime%
@ECHO Build End:   %EndTime%
@ECHO.


@IF NOT "%CHAINEDCALL%"=="true" PAUSE
@ENDLOCAL
@GOTO End

:fail 
@EXIT /b 1 

:End
