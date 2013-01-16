package events
{
	import flash.events.Event;
	
	public class FunctionHEvent extends Event
	{
		public static var GAME_READY:String = "function_h.game_ready";
		public static var GAME_END:String = "function_h.game_end";
		public static var PLAY:String = "function_h.play";
		public static var LOGIN:String = "function_h.login";
		
		
		public function FunctionHEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}