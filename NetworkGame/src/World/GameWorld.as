package World
{
	import away3d.cameras.Camera3D;
	import away3d.cameras.SpringCam;
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.View3D;
	import away3d.debug.AwayStats;
	import away3d.entities.Sprite3D;
	import away3d.lights.DirectionalLight;
	import away3d.lights.LightBase;
	import away3d.lights.PointLight;
	import away3d.materials.BitmapFileMaterial;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.Cube;
	import away3d.primitives.Plane;
	
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Vector3D;
	import flash.ui.Keyboard;
	
	public class GameWorld extends MovieClip
	{
		private var _view : View3D;					// View to the 3D world
		private var _viewLayer_mc:MovieClip;			// Movie Clip which _view resides on
		private var _hudLayer_mc:MovieClip;			// Movie Clip which lies above viewLayer_mc
		private var _cam:Camera3D;
		private var _lights:Array = [];
		private var _stage:Object;
		private var _keyList:Vector.<Boolean>;
		private var _node:WorldNode;
		private var _frameCounter:int = 0;
		
		public function GameWorld(stageRef:Object)
		{
			super();
			initView();
			_keyList = new Vector.<Boolean>(300);
			_stage = stageRef;
			_stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			_stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			
		}
		
		protected function enterFrameHandler(event:Event):void
		{
			processKeys();
			_frameCounter++;
			if(_frameCounter > 180){
				_node.animateHack();
			}
			_view.render();
		}
		
		private function initView():void
		{
			_cam = new Camera3D();
			_cam.z = -300;
			_cam.lens.far = 5000;
			_viewLayer_mc = new MovieClip();
			_hudLayer_mc = new MovieClip();
			addChild(_viewLayer_mc);
			addChild(_hudLayer_mc);
			_view = new View3D(null, _cam);
			_viewLayer_mc.addChild(_view);
			
			_view.width = 1280;
			_view.height = 720;
			_view.antiAlias = 4;
			
			var _light:DirectionalLight = new DirectionalLight(); // DirectionalLight();
			_light.x = -1000;
			_light.y = 200;
			_light.z = -1400;
			_light.color = 0xffFFFF;
			_light.specular = 0.1;
			_light.castsShadows = true;
			_lights.push(_light);
			
			_light = new DirectionalLight(); // DirectionalLight();
			_light.x = 1000;
			_light.y = 200;
			_light.z = 700;
			_light.color = 0xFFFFff;
			_light.specular = 0.1;
			_lights.push(_light);
			
			_view.scene.addChild(_light);
			
			_node = new WorldNode(_lights);
			_node.y = -20;
			_view.scene.addChild(_node);
			
			var ui_mc:UI = new UI();
			_hudLayer_mc.addChild(ui_mc);
		}
		
		private function processKeys():void
		{
			if(_keyList[Keyboard.W]){
				var xComponent:Number = Math.sin( _view.camera.rotationY * Math.PI / 180 ) * 1;
				var zComponent:Number = Math.cos( _view.camera.rotationY * Math.PI / 180 ) * 1;
				_view.camera.position = new Vector3D(
				_view.camera.x + xComponent, _view.camera.y, _view.camera.z + zComponent );
			}
			if(_keyList[Keyboard.A]){
				xComponent = Math.cos( _view.camera.rotationY * Math.PI / 180 ) * -1;
				zComponent = Math.sin( _view.camera.rotationY * Math.PI / 180 ) * 1;
				_view.camera.position = new Vector3D(
					_view.camera.x + xComponent, _view.camera.y, _view.camera.z + zComponent );
			}
			if(_keyList[Keyboard.S]){
				xComponent = Math.sin( _view.camera.rotationY * Math.PI / 180 ) * 1;
				zComponent = Math.cos( _view.camera.rotationY * Math.PI / 180 ) * 1;
				_view.camera.position = new Vector3D(
					_view.camera.x - xComponent, _view.camera.y, _view.camera.z - zComponent );
			}
			if(_keyList[Keyboard.D]){
				xComponent = Math.cos( _view.camera.rotationY * Math.PI / 180 ) * 1;
				zComponent = Math.sin( _view.camera.rotationY * Math.PI / 180 ) * -1;
				_view.camera.position = new Vector3D(
					_view.camera.x + xComponent, _view.camera.y, _view.camera.z + zComponent );
			}
			if(_keyList[Keyboard.UP]){
				_view.camera.rotationX -= 2;
			}
			if(_keyList[Keyboard.DOWN]){
				_view.camera.rotationX += 2;
			}
			if(_keyList[Keyboard.LEFT]){
				_view.camera.rotationY -= 2;
			}
			if(_keyList[Keyboard.RIGHT]){
				_view.camera.rotationY += 2;
			}
		}
		
		private function keyDownHandler(event:KeyboardEvent):void
		{
			if(event.keyCode < _keyList.length){
				_keyList[event.keyCode] = true;
			}
		}
		
		private function keyUpHandler(event:KeyboardEvent):void
		{
			if(event.keyCode < _keyList.length){
				_keyList[event.keyCode] = false;
			}
		}
	}
}