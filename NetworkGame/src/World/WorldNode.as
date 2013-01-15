package World
{
	import away3d.containers.ObjectContainer3D;
	import away3d.lights.LightBase;
	import away3d.materials.BitmapFileMaterial;
	import away3d.materials.ColorMaterial;
	import away3d.materials.methods.OutlineMethod;
	import away3d.primitives.Cube;
	
	import com.greensock.TweenLite;
	
	public class WorldNode extends ObjectContainer3D
	{
		private var _cubes:Vector.<Cube>;
		private var _mats:Vector.<BitmapFileMaterial>;
		private var _normalMat:BitmapFileMaterial;
		private var _hackedMat:ColorMaterial;
		private var _hackNum:Number = 0;
		
		public function WorldNode(lightRef:Array)
		{
			super();
			
			
			_normalMat = new BitmapFileMaterial("assets/texture.jpg");
			_normalMat.gloss = 2;
			_normalMat.specular = 4;
			_normalMat.lights = lightRef;
			
			var cubeSize:int = 8;
			var cubeNum:int = 4;
			_mats = new Vector.<BitmapFileMaterial>();
			_cubes = new Vector.<Cube>();
			
			for(var i:int = 0; i < cubeNum; i++)
			{
				for(var j:int = 0; j < cubeNum; j++)
				{
					for(var k:int = 0; k < cubeNum; k++)
					{
						var hackedMat:BitmapFileMaterial = new BitmapFileMaterial("assets/texture_red.jpg");
						//hackedMat.lights = lightRef;
						_mats.push(hackedMat);
						var cube:Cube = new Cube(_normalMat, cubeSize, cubeSize, cubeSize);
						cube.x = i * (cubeSize);
						cube.y = j * (cubeSize);
						cube.z = k * (cubeSize);
						addChild(cube);
						_cubes.push(cube);
					}
				}
			}
		}
		
		public function animateHack():void
		{
			_hackNum += .125;
			for(var i:int = 0; i < _cubes.length; i++)
			{
				if(i < _hackNum){
					var cube:Cube = _cubes[i];
					cube.material = _mats[i];
					TweenLite.to(_mats[i], .5, {alpha: 0});
				}
			}
			
		}
	}
}