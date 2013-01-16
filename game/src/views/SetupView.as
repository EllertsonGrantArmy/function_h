package views
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class SetupView extends TextBasedView
	{
		public function SetupView()
		{
			super();
		}
		
		override protected function init(event:Event=null):void
		{
			super.init(event);
			textbox.text = "This game is equipped with voice recognition abilities," +
				"\nchecking to see if they support your device...";
			checkForANE();
		}
			
		override protected function keyPress(event:KeyboardEvent):void {
			if(current_stage == "start") {
				if(event.keyCode == Keyboard.L) {
					startTutorial()				
				}
				else if(event.keyCode == Keyboard.T) {
					startTest()				
				}
				else if(event.keyCode == Keyboard.S) {
					dispatchEvent(new Event(Event.COMPLETE));	
				}
			}
		}
		
		private function startTutorial():void
		{
			// TODO Auto Generated method stub
			
		}
		
		private function startTest():void
		{
			// TODO Auto Generated method stub
			
		}
		
		private function checkForANE():void
		{
			var ANESupport:Boolean = true
			if(ANESupport) {
				appendText("\nVoice Extension supported!" +
					"\n\nChoose one of the following options, would you like to:" +
					"\nl - learn how to use your voice recognition" +
					"\nt - test your voice recognition" +
					"\ns - skip all this");
				startCursorBlink();
			}
			else {
				appendText("\nVoice Extension not supported!" +
					"\n\nAccess denied!");
			}
		}
		
	}
}