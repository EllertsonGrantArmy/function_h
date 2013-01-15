package
{
	import World.GameWorld;
	
	import flash.display.Sprite;
	
	[SWF(backgroundColor="#000000", frameRate="60", width="1280", height="720")]
	
	public class NetworkGame extends Sprite
	{
		public function NetworkGame()
		{
			var gameWorld:GameWorld = new GameWorld(stage);
			addChild(gameWorld);
		}
	}
}