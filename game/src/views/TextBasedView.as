package views
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class TextBasedView extends Sprite
	{
		
		protected var textbox:TextField;
		
		protected var blinkSpeed:uint = 15;
		protected var cursorString:String = "▐";
		private var blinkCounter:uint = 0;
		
		protected var current_stage:String = "start";
		
		public function TextBasedView() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		protected function init(event:Event = null):void {
			textbox = new TextField();
			addChild(textbox);
			
			var _areaWidth:int = 720, 
					_areaHeight:int = 600;
			if(parent) {
				_areaWidth = parent.stage.stageWidth;
				_areaHeight = parent.stage.stageHeight;
			}
			
			textbox.width = _areaWidth-20;
			textbox.height = _areaHeight-20;
			textbox.x = 10;
			textbox.y = 10;
			var newFormat:TextFormat = new TextFormat();
			newFormat.size = 12;
			newFormat.font = "Courier";
			textbox.defaultTextFormat = newFormat;
			textbox.selectable = false;
			textbox.multiline = true;
			textbox.textColor = 0xFFFFFF;
			textbox.addEventListener(Event.SCROLL, keyDown);
			addEventListener(KeyboardEvent.KEY_UP, internalKeyPress);
			stage.focus = this;
			stage.stageFocusRect = false;
		}
		
		protected function internalKeyPress(event:KeyboardEvent):void
		{
			if(this["keyPress"])
				this["keyPress"](event);
		}
		
		protected function startCursorBlink():void {
			removeEventListener(Event.ENTER_FRAME, blinkCursor);
			addEventListener(Event.ENTER_FRAME, blinkCursor);
			blinkCounter = 0;
		}
		
		protected function stopCursorBlink():void {
			removeEventListener(Event.ENTER_FRAME, blinkCursor);
			removeCursor();
		}
		
		protected function blinkCursor(event:Event = null):void {
			var charIndex:int = textbox.text.indexOf(cursorString);
			if(++blinkCounter >= blinkSpeed) {
				blinkCounter = 0;
				if(charIndex == -1)
					textbox.appendText(cursorString);
				else
					removeCursor();
			}
		}
		
		protected function removeCursor():void {
			textbox.text = textbox.text.replace(cursorString, "");
		}
		
		protected function keyDown(event:Event):void {
			textbox.scrollV = textbox.numLines;
		}
		
		protected function keyPress(event:KeyboardEvent):void {}
		
		protected function appendText(toAdd:String):void {
			textbox.appendText(toAdd);
		}
	}
}