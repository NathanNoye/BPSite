CLS
NETSH wlan show interfaces | FINDSTR /c:"Signal" && SET online=ONLINE || SET online=OFFLINE
CLS

TITLE Agile2 Site generator
@ECHO OFF

ECHO ====================================================
ECHO                - Website Builder -
ECHO ====================================================
ECHO.

SET /p location="Path to project folder: "
SET /p author="Author: "
SET /p company="Company: "
SET /p companyURL="Company website: "
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
ECHO    "Company"^:"%company%"^, >> info.json
ECHO    "Company Website"^:"%companyURL%"^, >> info.json
ECHO    "Title"^:"%projectTitle%"^, >> info.json
ECHO    "Primary Language"^:"%primaryLanguage%"^, >> info.json
ECHO    "Date"^:"%date%"^, >> info.json
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
    set scriptLink="js/primary.js"

    REM Add fallback JS
    ECHO ^/^/Primary.JS file. Created on %date% for project: %title%>> js/primary.js
)




REM Creating the HTML file
ECHO ^<!DOCTYPE html^> >> index.html
ECHO ^<html lang="en"^> >> index.html
ECHO    ^<head^> >> index.html
ECHO        ^<title^>^</title^> >>index.html
ECHO        ^<meta charset="utf-8"^> >> index.html
ECHO        ^<meta name="viewport" content="width=device-width, initial-scale=1.0"^> >> index.html
ECHO        ^<link rel="stylesheet" type="text/css" href=%cssLink%^> >> index.html
ECHO    ^</head^> >> index.html
ECHO    ^<body^> >> index.html
ECHO        ^<header^>^</header^> >> index.html
ECHO        ^<section^>^</section^> >> index.html
ECHO        ^<footer^>^</footer^> >> index.html
ECHO        ^<!-- Put JS scripts here --^> >> index.html
ECHO        ^<script src=%scriptLink%^>^</script^> >> index.html
ECHO    ^</body^> >> index.html
ECHO ^</html^> >> index.html

REM Opening the folder to get started
START %location%