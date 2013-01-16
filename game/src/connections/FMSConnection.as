package connections
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class FMSConnection extends EventDispatcher
	{
		private static var _instance:FMSConnection;

		public function FMSConnection(target:IEventDispatcher=null)
		{
			_instance = this;
		}
		
		public function checkUsername(name:String, callback:Function):void {
			callback(false);
		}
		
		public static function get instance():FMSConnection {
			if(!_instance)
				_instance = new FMSConnection;
			return _instance;
		}
	}
}