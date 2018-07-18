@ECHO OFF

SET /p location="Path to project folder: "
SET /p author="Author: "
SET /p company="Company: "
SET /p projectTitle="Project title: "
SET /p description="Description: "

REM Creating the directories
MD %location%\css
MD %location%\js
MD %location%\img
MD %location%\fonts
MD %location%\includes

REM Creating the HTML file
ECHO ^<!DOCTYPE html^> >> %location%/index.html
ECHO ^<html lang="en"^> >> %location%/index.html
ECHO    ^<head^> >> %location%/index.html
ECHO        ^<title^>^</title^> >> %location%/index.html
ECHO        ^<meta charset="utf-8"^> >> %location%/index.html
ECHO        ^<meta name="viewport" content="width=device-width, initial-scale=1.0"^> >> %location%/index.html
ECHO        ^<link rel="stylesheet" type="text/css" href="css/agile.import.css"^> >> %location%/index.html
ECHO    ^</head^> >> %location%/index.html
ECHO    ^<body^> >> %location%/index.html
ECHO        ^<header^>^</header^> >> %location%/index.html
ECHO        ^<section^>^</section^> >> %location%/index.html
ECHO        ^<footer^>^</footer^> >> %location%/index.html
ECHO        ^<!-- Put JS scripts here --^> >> %location%/index.html
ECHO        ^<script src="js/primary.js"^>^</script^> >> %location%/index.html
ECHO    ^</body^> >> %location%/index.html
ECHO ^</html^> >> %location%/index.html


REM Creating the JSON file
ECHO ^{ >> %location%/info.json
ECHO    "Author"^:"%author%"^, >> %location%/info.json
ECHO    "Company"^:"%company%"^, >> %location%/info.json
ECHO    "Title"^:"%projectTitle%"^, >> %location%/info.json
ECHO    "Date"^:"%date%"^, >> %location%/info.json
ECHO    "Description"^:"%description%"^ >> %location%/info.json
ECHO ^} >> %location%/info.json


REM Creating the primary JS file
ECHO ^/^/Primary.JS file. Created on %date% for project: %title%>> %location%/js/primary.js

REM Opening the folder to get started
START %location%