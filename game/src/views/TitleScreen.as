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
	
	public class TitleScreen extends Sprite
	{
		private var current_stage:String= "enter"
		
		public var play_btn:Sprite;
		private var textbox:TextField;
		
		private var blinkSpeed:uint = 15;
		private var cursorString:String = "▐";
		private var blinkCounter:uint = 0;
		
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
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event = null):void {
			textbox = new TextField();
			addChild(textbox);

//			if(parent) {
//				this.width = parent.stage.stageWidth;
//				this.height = parent.stage.stageHeight;
//				this.scaleX = 1;
//				this.scaleY = 1;
//			}
			
			textbox.width = 700;
			textbox.height = 580;
			textbox.x = 10;
			textbox.y = 10;
			var newFormat:TextFormat = new TextFormat();
			newFormat.size = 12;
			newFormat.font = "Courier";
			textbox.defaultTextFormat = newFormat;
			textbox.selectable = false;
			textbox.multiline = true;
			textbox.text = "Welcome to\n"+titleASCII+"\npress Enter to begin";
			textbox.textColor = 0xFFFFFF;
			textbox.addEventListener(Event.SCROLL, keyDown);
			startCursorBlink();
			addEventListener(KeyboardEvent.KEY_UP, keyPress);
			addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		}
		
		private function startCursorBlink():void {
			removeEventListener(Event.ENTER_FRAME, blinkCursor);
			addEventListener(Event.ENTER_FRAME, blinkCursor);
			blinkCounter = 0;
		}
		
		private function stopCursorBlink():void {
			removeEventListener(Event.ENTER_FRAME, blinkCursor);
			removeCursor();
		}
		
		protected function keyPress(event:KeyboardEvent):void
		{
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
				else if(event.keyCode == Keyboard.ENTER && usernameIn.length > 0) {
					current_stage = "checking_user";
					stopCursorBlink();
					textbox.appendText("\nchecking username availability...");
					FMSConnection.instance.checkUsername(usernameIn, checkUsernameResponse);
				}
			}
		}
		
		protected function keyDown(event:Event):void {
			textbox.scrollV = textbox.numLines;
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
		
		protected function blinkCursor(event:Event = null):void
		{
			var charIndex:int = textbox.text.indexOf(cursorString);
			if(++blinkCounter >= blinkSpeed) {
				blinkCounter = 0;
				if(charIndex == -1)
					textbox.appendText(cursorString);
				else
					removeCursor();
			}
		}
		
		private function removeCursor():void
		{
			textbox.text = textbox.text.replace(cursorString, "");
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