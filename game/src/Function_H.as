package
{
	import connections.FMSConnection;
	
	import events.FunctionHEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import views.MainGameView;
	
	import views.*;
	
	[SWF(height=600,width=800,backgroundColor="0x000000")]
	public class Function_H extends Sprite {
		private var titleScreen:TitleScreen;
		private var setupView:SetupView;
		private var roomSelectView:RoomSelectView;
		private var waitingForPlayView:WaitingForPlayView;
		private var mainGameView:MainGameView;
		
		public function Function_H() {
			this.addEventListener(Event.ADDED_TO_STAGE, function ():void {
				showTitleScreen();
			});
		}
		
		private function showTitleScreen():void {
			titleScreen = new TitleScreen();
			addChild(titleScreen);
			titleScreen.addEventListener(FunctionHEvent.PLAY, showLogin);
		}
		
		private function showLogin(event:Event = null):void {
			if(!contains(titleScreen)) {
				clearStage();
				showTitleScreen();
				showLogin();
			}
			titleScreen.showLoginForm();
			titleScreen.addEventListener(FunctionHEvent.LOGIN, showSetup);
		}
		
		protected function showSetup(event:Event = null):void {
			clearStage();
			setupView = new SetupView();
			addChild(setupView);
			setupView.addEventListener(Event.COMPLETE, showRoomSelect);
		}
		
		protected function showRoomSelect(event:Event = null):void {
			clearStage();
			roomSelectView = new RoomSelectView();
			addChild(roomSelectView);
			roomSelectView.addEventListener(Event.SELECT, showWaitingForPlayView);
		}
		
		protected function showWaitingForPlayView(event:Event = null):void {
			clearStage();
			waitingForPlayView = new WaitingForPlayView();
			addChild(waitingForPlayView);
			FMSConnection.instance.addEventListener(FunctionHEvent.GAME_READY, playGame);
		}
		
		protected function playGame(event:Event = null):void
		{
			clearStage();
			mainGameView = new MainGameView();
			mainGameView.addEventListener(FunctionHEvent.GAME_END, showRoomSelect);
		}
		
		private function clearStage():void {
			// if you want more things to be removed, add them to this array
			var toRemove:Array = [titleScreen, setupView, roomSelectView, 
														waitingForPlayView, mainGameView];
			for (var i:String in toRemove) {
				if(toRemove[i] && contains(toRemove[i]))
					removeChild(toRemove[i]);
			}
		}
	}
}