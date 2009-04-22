package net.boyblack.robotlegs.demos.helloflex.view.mediators
{
	import flash.events.MouseEvent;

	import net.boyblack.robotlegs.demos.helloflex.model.events.UserProxyEvent;
	import net.boyblack.robotlegs.demos.helloflex.model.proxies.UserProxy;
	import net.boyblack.robotlegs.demos.helloflex.remote.services.IAuthService;
	import net.boyblack.robotlegs.demos.helloflex.view.components.LogoutButton;
	import net.boyblack.robotlegs.mvcs.FlexMediator;

	public class LogoutButtonMediator extends FlexMediator
	{
		[Inject]
		public var logoutButton:LogoutButton;

		[Inject]
		public var userProxy:UserProxy;

		[Inject]
		public var authService:IAuthService;

		public function LogoutButtonMediator()
		{
		}

		override public function onRegisterComplete():void
		{
			// Yes, this could use binding instead
			logoutButton.enabled = userProxy.userLoggedIn;
			// view listeners
			addEventListenerTo( logoutButton, MouseEvent.CLICK, onLogoutClick );
			// context listeners
			addEventListenerTo( eventDispatcher, UserProxyEvent.USER_LOGGED_IN, whenUserLoggedIn );
			addEventListenerTo( eventDispatcher, UserProxyEvent.USER_LOGGED_OUT, whenUserLoggedOut );
		}

		private function onLogoutClick( e:MouseEvent ):void
		{
			authService.logout();
		}

		private function whenUserLoggedIn( e:UserProxyEvent ):void
		{
			logoutButton.enabled = true;
		}

		private function whenUserLoggedOut( e:UserProxyEvent ):void
		{
			logoutButton.enabled = false;
		}

	}
}