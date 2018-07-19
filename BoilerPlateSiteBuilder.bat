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

ECHO Implement Agile2? Requires GIT as PATH variable and an internet connection.
SET /p useAgile="Y/N: "

IF /I %useAgile%==Y (
    REM Getting the latest version of Agile
    git clone https://github.com/NathanNoye/Agile2.git
    CD Agile2
    MOVE css ..
    CD ..
    RMDIR Agile2 /s /q

    REM Add link to the agile css stylesheets
    SET cssLink="css/agile.import.css"
) ELSE (
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