CLS
NETSH wlan show interfaces | FINDSTR /c:"Signal" && SET online=ONLINE || SET online=OFFLINE
SET primaryLanguage=html
SET useAgile=N
CLS

TITLE Agile2 Site generator
@ECHO OFF

ECHO ====================================================
ECHO                - Website Builder -
ECHO ====================================================
ECHO.

SET /p location="Path to project folder: "
SET /p author="Author: "
SET /p authorURL="Author website: "
SET /p projectTitle="Project title: "
SET /p primaryLanguage="Primary Programming Language: "
SET /p description="Description: "

CD %location%
ECHO.
ECHO.

REM Creating the directories
MD img
MD includes

REM Creating the JSON file
ECHO ^{ >> info.json
ECHO    "Author"^:"%author%"^, >> info.json
ECHO    "Author Website"^:"%authorURL%"^, >> info.json
ECHO    "Title"^:"%projectTitle%"^, >> info.json
ECHO    "Primary Language"^:"%primaryLanguage%"^, >> info.json
ECHO    "Date Created"^:"%date%"^, >> info.json
ECHO    "Description"^:"%description%"^ >> info.json
ECHO ^} >> info.json

ECHO Implement Agile2? Requires GIT as PATH variable and an internet connection.
ECHO Your current network status is %online%
SET /p useAgile="Y/N: "

ECHO.

IF /I %useAgile%==Y (
    REM Getting the latest version of Agile
    git clone https://github.com/NathanNoye/Agile2.git
    CD Agile2
    MOVE css ..
    MOVE fonts ..
    MOVE js ..
    CD ..
    RMDIR Agile2 /s /q

    REM Add link to the agile css stylesheets
    SET cssLink="css/agile.import.css"
    set scriptLink="js/agile.import.js"
) ELSE (
    MD js
    MD fonts
    MD css

    REM Add fallback CSS
    ECHO ^* ^{ >> css/main.css
    ECHO    line-height^: 1.6px^; >> css/main.css
    ECHO ^} >> css/main.css

    REM Add link to the fallback files
    SET cssLink="css/main.css"
    set scriptLink="js/app.js"

    REM Add fallback JS
    ECHO ^/^/App.JS file. Created on %date% for project: %title%>> js/app.js
)


IF /I %primaryLanguage%==PHP (
    GOTO PHPCODEGEN
) ELSE (
    GOTO HTMLCODEGEN
)

:PHPCODEGEN
REM Creating the PHP files
REM Header
ECHO ^<!DOCTYPE html^> >> includes/header.php
ECHO ^<html lang="en"^> >> includes/header.php
ECHO    ^<head^> >> includes/header.php
ECHO        ^<title^>%projectTitle%^</title^> >>includes/header.php
ECHO        ^<meta charset="utf-8"^> >> includes/header.php
ECHO        ^<meta name="viewport" content="width=device-width, initial-scale=1.0"^> >> includes/header.php
ECHO        ^<meta name="description" content="%description%"^> >> includes/header.php
ECHO        ^<link rel="stylesheet" type="text/css" href=%cssLink%^> >> includes/header.php
ECHO    ^</head^> >> includes/header.php
ECHO    ^<body^> >> includes/header.php

REM Main
ECHO ^<^?php >> index.php
ECHO    include ^'includes^/cnn.php^'^; >> index.php
ECHO    include ^'includes^/functions.php^'^; >> index.php
ECHO    include ^'includes^/header.php^'^; >> index.php
ECHO ^?^> >> index.php
ECHO. >> index.php
ECHO ^<^?php >> index.php
ECHO    include ^'includes^/footer.php^'^; >> index.php
ECHO ^?^> >> index.php

REM Footer
ECHO        ^<footer^>^<a href="https://%authorURL%"^>Site developed by %author%^<^/a^>^</footer^> >> includes/footer.php
ECHO        ^<!-- Put JS scripts here --^> >> includes/footer.php
ECHO        ^<script src=%scriptLink%^>^</script^> >> includes/footer.php
ECHO    ^</body^> >> includes/footer.php
ECHO ^</html^> >> includes/footer.php

REM Connection File
ECHO ^<^?php >> includes/cnn.php
ECHO function makeConnection^(^$databaseName^)^{ >> includes/cnn.php
ECHO    ^$server = "localhost"; >> includes/cnn.php
ECHO    ^$user  = ""; >> includes/cnn.php
ECHO    ^$password  = ""; >> includes/cnn.php
ECHO. >> includes/cnn.php
ECHO    $conn = new mysqli($server, $user, $password, $databaseName); >> includes/cnn.php
ECHO. >> includes/cnn.php
ECHO    if ($conn -^> connect_error){ >> includes/cnn.php
ECHO        echo "Error: Failed to make a db connection. Here's why: "; >> includes/cnn.php
ECHO        echo "Error Num: " . $conn -^> connect_errno . "\n"; >> includes/cnn.php
ECHO. >> includes/cnn.php
ECHO        die("Connection Failed " . $conn -^> connect_error); ^/^/Log this on the server >> includes/cnn.php
ECHO    ^} else ^{ >> includes/cnn.php
ECHO        return $conn; >> includes/cnn.php
ECHO    ^} >> includes/cnn.php
ECHO ^} >> includes/cnn.php
ECHO ^?^> >> includes/cnn.php

REM Functions
ECHO ^<^?php >> includes/functions.php
ECHO. >> includes/functions.php
ECHO ^?^> >> includes/functions.php
GOTO END



:HTMLCODEGEN
REM Creating the HTML file
ECHO ^<!DOCTYPE html^> >> index.html
ECHO ^<html lang="en"^> >> index.html
ECHO    ^<head^> >> index.html
ECHO        ^<title^>%projectTitle%^</title^> >>index.html
ECHO        ^<meta charset="utf-8"^> >> index.html
ECHO        ^<meta name="viewport" content="width=device-width, initial-scale=1.0"^> >> index.html
ECHO        ^<meta name="description" content="%description%"^> >> index.html
ECHO        ^<link rel="stylesheet" type="text/css" href=%cssLink%^> >> index.html
ECHO    ^</head^> >> index.html
ECHO    ^<body^> >> index.html
ECHO        ^<header^>^</header^> >> index.html
ECHO        ^<section^>^</section^> >> index.html
ECHO        ^<footer^>^<a href="https://%authorURL%"^>Site developed by %author%^<^/a^>^</footer^> >> index.html
ECHO        ^<!-- Put JS scripts here --^> >> index.html
ECHO        ^<script src=%scriptLink%^>^</script^> >> index.html
ECHO    ^</body^> >> index.html
ECHO ^</html^> >> index.html
GOTO END



:END
REM Opening the folder to get started
START %location%