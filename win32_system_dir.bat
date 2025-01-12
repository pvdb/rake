@ECHO OFF

ECHO ---------------------------------------------------------------
ruby -I lib -r rake -e "print '    platform: ' + (Rake::Win32.windows? ? 'Windows' : 'Unix')"
ruby -e "puts ' / branch: ' + %%x{git symbolic-ref --quiet --short HEAD}.chomp"
ECHO:

GOTO:main

:echoWindowsEnv
ECHO [Windows] %%HOME%%=%HOME%
ECHO [Windows] %%HOMEDRIVE%%=%HOMEDRIVE%
ECHO [Windows] %%HOMEPATH%%=%HOMEPATH%
ECHO [Windows] %%APPDATA%%=%APPDATA%
ECHO [Windows] %%USERPROFILE%%=%USERPROFILE%
ECHO:
goto:eof

:putsRubyEnv
ruby -e 'puts "[Ruby] ENV[\"HOME\"] = " + ENV.fetch("HOME", "nil")'
ruby -e 'puts "[Ruby] ENV[\"HOMEDRIVE\"] = " + ENV.fetch("HOMEDRIVE", "nil")'
ruby -e 'puts "[Ruby] ENV[\"HOMEPATH\"] = " + ENV.fetch("HOMEPATH", "nil")'
ruby -e 'puts "[Ruby] ENV[\"APPDATA\"] = " + ENV.fetch("APPDATA", "nil")'
ruby -e 'puts "[Ruby] ENV[\"USERPROFILE\"] = " + ENV.fetch("USERPROFILE", "nil")'
ECHO:
goto:eof

:putsRubyDirHome
ruby -e 'puts "[Ruby] File.join(Dir.home, \"Rake\")           => " + File.join(Dir.home, "Rake")'
goto:eof

:putsRakeSystemDir
REM
REM the following two Ruby commands are functionally identical
REM but the first one cannot be executed on the feature branch
REM as the "win32_system_dir()" method gets deleted in the PR!
REM
REM so we're using the second one, even though that one requires the
REM use of "send" to invoke "standard_system_dir()" which is private
REM
REM ruby -I lib -r rake -e 'puts "[Rake] Rake::Win32::win32_system_dir         => " + Rake::Win32::win32_system_dir'
REM
ruby -I lib -r rake -e 'puts "[Rake] Rake::Application.standard_system_dir => " + Rake::Application.new().send(:standard_system_dir)'
goto:eof

:main

ECHO ---------------------------------------------------------------
ECHO 1/5 - %%HOME%% set in Windows env
ECHO ---------------------------------------------------------------

SET HOME=C:\HP
SET HOMEDRIVE=
SET HOMEPATH=
SET APPDATA=
SET USERPROFILE=

CALL:echoWindowsEnv
CALL:putsRubyEnv

CALL:putsRubyDirHome
CALL:putsRakeSystemDir

ECHO:

ECHO ---------------------------------------------------------------
ECHO 2/5 - %%HOMEDRIVE%% and %%HOMEPATH%% set in Windows env
ECHO ---------------------------------------------------------------

SET HOME=
SET HOMEDRIVE=C:
SET HOMEPATH=\HP
SET APPDATA=
SET USERPROFILE=

CALL:echoWindowsEnv
CALL:putsRubyEnv


CALL:putsRubyDirHome
CALL:putsRakeSystemDir

ECHO:

ECHO ---------------------------------------------------------------
ECHO 3/5 - %%USERPROFILE%% set in Windows env
ECHO ---------------------------------------------------------------

SET HOME=
SET HOMEDRIVE=
SET HOMEPATH=
SET APPDATA=
SET USERPROFILE=C:\Documents and Settings\HP

CALL:echoWindowsEnv
CALL:putsRubyEnv

CALL:putsRubyDirHome
CALL:putsRakeSystemDir

ECHO:

ECHO ---------------------------------------------------------------
ECHO 4/5 - %%APPDATA%% set in Windows env
ECHO ---------------------------------------------------------------

SET HOME=
SET HOMEDRIVE=
SET HOMEPATH=
SET APPDATA=C:\Documents and Settings\HP\Application Data
SET USERPROFILE=

CALL:echoWindowsEnv
CALL:putsRubyEnv

CALL:putsRubyDirHome
CALL:putsRakeSystemDir

ECHO:

ECHO ---------------------------------------------------------------
ECHO 5/5 - nothing set in Windows env
ECHO ---------------------------------------------------------------

SET HOME=
SET HOMEDRIVE=
SET HOMEPATH=
SET APPDATA=
SET USERPROFILE=

CALL:echoWindowsEnv
CALL:putsRubyEnv

CALL:putsRubyDirHome
CALL:putsRakeSystemDir

ECHO:

ECHO ----------------------------------
ECHO:

