# function_h
### A fun game using voice rec!

## Setting up the Flash Builder project

1. Run the speech_setup script to clone the native extension and move
   the ane to your project. To do this, run ```sh setup_ane.sh``` in the
   repo directory.
2. Make a new ActionScript in Flash Builder.
3. Point the project location at the game folder.
4. Click "Next".
5. On the "Build Paths" page, under the "Native Extensions", add the
   "libs/SpeechExtension.ane" ANE.
6. Click "Finish".
7. Right click the project in Package Explorer, go to "Properties", then
   "Actionscript Build Packaging".
8. Under the "Native Extensions" tab, check the Package check box.

Now your game project should have the access to the Speech Command ANE!
Yay!
