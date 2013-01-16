package views
{
	import connections.FMSConnection;
	
	import events.FunctionHEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	
	public class TitleScreen extends TextBasedView
	{		
		private var titleASCII:String = 
			" _______  __    __  .__   __.   ______ .___________. __    ______   .__   __.      __    __  \n" +
			"|   ____||  |  |  | |  \\ |  |  /      ||           ||  |  /  __  \\  |  \\ |  |     |  |  |  | \n" +
			"|  |__   |  |  |  | |   \\|  | |  ,----'`---|  |----`|  | |  |  |  | |   \\|  |     |  |__|  | \n" +
			"|   __|  |  |  |  | |  . `  | |  |         |  |     |  | |  |  |  | |  . `  |     |   __   | \n" +
			"|  |     |  `--'  | |  |\\   | |  `----.    |  |     |  | |  `--'  | |  |\\   |     |  |  |  | \n" +
			"|__|      \\______/  |__| \\__|  \\______|    |__|     |__|  \\______/  |__| \\__|_____|__|  |__| \n" +
			"                                                                            |______|         \n"

		private var usernameIn:String = "";
		
		public function TitleScreen()	{
			current_stage = "enter"
		}
		
		override protected function init(event:Event = null):void {
			super.init(event);
			textbox.text = "Welcome to\n"+titleASCII+"\npress Enter to begin";
			startCursorBlink();
			
		}
		
		override protected function keyPress(event:KeyboardEvent):void {
			if(current_stage == "enter" && event.keyCode == Keyboard.ENTER) {
				dispatchEvent(new Event(FunctionHEvent.PLAY));
			}
			else if(current_stage == "username") {
				if((event.keyCode >= 48 && event.keyCode <= 90)) {
					var letter:String = String.fromCharCode(event.keyCode).toLowerCase();
					usernameIn += letter;
					removeCursor();
					textbox.appendText(letter);
					blinkCursor();
					textbox.scrollV = textbox.numLines;
				}
				else if(event.keyCode == Keyboard.BACKSPACE && usernameIn.length > 0) {
					usernameIn = usernameIn.substring(0,usernameIn.length-1);
					if(textbox.text.indexOf(cursorString) == -1) {
						textbox.text = textbox.text.substr(0,textbox.text.length-1);
					}
					else {
						removeCursor();
						textbox.text = textbox.text.substr(0,textbox.text.length-1) + cursorString;
					}
				}
				else if(event.keyCode == Keyboard.ENTER) {
					if(usernameIn.length > 0) {
						current_stage = "checking_user";
						stopCursorBlink();
						textbox.appendText("\nchecking username availability...");
						FMSConnection.instance.checkUsername(usernameIn, checkUsernameResponse);
					}
					else {
						removeCursor();
						textbox.appendText("\nusername: ");
						blinkCursor();
					}
				}
			}
		}
		
		public function checkUsernameResponse(available:Boolean):void {
			if(available) {
				textbox.appendText("\nusername accepted!");
				dispatchEvent(new Event(FunctionHEvent.LOGIN));
			}
			else {
				textbox.appendText("\nusername unavailable.");
				showLoginForm();
			}
			textbox.scrollV = textbox.numLines;
		}
		
		public function showLoginForm():void {
			current_stage = "username";
			usernameIn = "";
			removeCursor();
			textbox.appendText("\n\nLogin\n‾‾‾‾‾\nusername: ");
			startCursorBlink();
		}
	}
}