@ECHO OFF

ECHO ====================================================
ECHO                - Website Builder -
ECHO ====================================================
ECHO.

SET /p location="Path to project folder: "
SET /p author="Author: "
SET /p company="Company: "
SET /p projectTitle="Project title: "
SET /p primaryLanguage="Primary Programming Language: "
SET /p description="Description: "

CD %location%
ECHO.
ECHO.

REM Creating the directories
MD js
MD img
MD fonts
MD includes

REM Creating the JSON file
ECHO ^{ >> info.json
ECHO    "Author"^:"%author%"^, >> info.json
ECHO    "Company"^:"%company%"^, >> info.json
ECHO    "Title"^:"%projectTitle%"^, >> info.json
ECHO    "Primary_Language"^:"%primaryLanguage%"^, >> info.json
ECHO    "Date"^:"%date%"^, >> info.json
ECHO    "Description"^:"%description%"^ >> info.json
ECHO ^} >> info.json


REM Creating the primary JS file
ECHO ^/^/Primary.JS file. Created on %date% for project: %title%>> js/primary.js



ECHO Make sure you are connected to the internet before proceeding and have GIT installed.
ECHO If not - you can still proceed but without implementing the Agile2 framework.
PAUSE
NETSH wlan show interfaces | FINDSTR /c:"Signal" && SET netSts=online || SET netSts=offline

REM ========================================================================================================
REM ========================================================================================================
REM SET git=1
REM DO A CHECK TO SEE IF THE USER HAS GIT INSTALLED. IF NOT - FALL BACK TO THE DEFAULT MAIN.CSS FILE
REM ========================================================================================================
REM ========================================================================================================

REM Checking if there is an internet connection. If so - the latest version of Agile2 will download.
REM If not - the fallback method will create a css dir.
IF %netSts% == online(
    REM Getting the latest version of Agile
    git clone https://github.com/NathanNoye/Agile2.git
    CD Agile2
    MOVE css ..
    CD ..
    RMDIR Agile2 /s /q

    REM Add link to the agile css stylesheets
    SET cssLink="css/agile.import.css"
) ELSE (
    ECHO  ------- No Connection found. Executing fallback method. -------
    MD css
    ECHO ^* ^{ >> css/main.css
    ECHO    line-height^: 1.6px^; >> css/main.css
    ECHO ^} >> css/main.css

    REM Add link to the fallback css
    SET cssLink="css/main.css"
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
ECHO        ^<script src="js/primary.js"^>^</script^> >> index.html
ECHO    ^</body^> >> index.html
ECHO ^</html^> >> index.html


REM Opening the folder to get started
START %location%