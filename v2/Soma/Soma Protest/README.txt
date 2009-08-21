How to compile Soma Protest

Fonts

Add the 4 required fonts in your system that are located in /source/front-end/assets/
- FFF Mono01.ttf
- FFF Star Bold Condensed.ttf
- FFF Star Condensed.ttf
- stan0755.ttf

Flash IDE user

Open the 3 Flash files located in "/source/front-end/src/"
- Preloader.fla
- Main.fla
- ExternalSWF.fla
Menu > Control > Test Movie (or cmd/control + Enter)

Non Flash IDE user

- source folder: /source/front-end/src/
- deploy folder: /www/
- library folder: /source/front-end/libs/

To compile the Preloader movie, the AS class entry point is the class "/source/front-end/src/com/somaprotest/Preloader.as". The output is "/www/Preloader.swf". You must add a compiler parameter to include the library Preloader.swc (contains fonts) to your movie:
-include-libraries PATH_TO_YOUR_PROJECT/source/front-end/libs/Preloader.swc

To compile the Main movie, the AS class entry point is the "/source/front-end/src/com/somaprotest/Main.as". The output is "/www/Main.swf". You must add a compiler parameter to include the library Main.swc (contains components, fonts, movieclip, images, etc) to your movie:
-include-libraries PATH_TO_YOUR_PROJECT/source/front-end/libs/Main.swc

To compile the ExternalSWF movie, the AS class entry point is the "/source/front-end/src/com/somaprotest/pages/ExternalSWF.as". The output is "/www/ExternalSWF.swf". You must add a compiler parameter to include the library ExternalSWF.swc (contains components and fonts) to your movie:
-include-libraries PATH_TO_YOUR_PROJECT/source/front-end/libs/ExternalSWF.swc

Any trouble?
http://www.soundstep.com/forum/
