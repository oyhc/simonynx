package modules.loading
{
	import modules.loading.controller.LoadFacadeShutdownCommand;
	import modules.loading.controller.LoadFacadeStartupCommand;
	import modules.loading.signals.LoadSignals;
	import modules.loading.signals.LoadViewSignals;

	import tempest.common.mvc.TFacade;

	public class LoadFacade extends TFacade
	{
		private static var _instance:LoadFacade;

		public function LoadFacade()
		{
			super();
			if (_instance)
			{
				throw new Error("LoadFacade is Singleton");
			}
		}

		public static function get instance():LoadFacade
		{
			return _instance ||= new LoadFacade();
		}

		public override function startup():void
		{
			inject.mapSingleton(LoadSignals);
			inject.mapSingleton(LoadViewSignals);

			commandMap.map([this.startupSignal], LoadFacadeStartupCommand, true);
			commandMap.map([this.shutdownSignal], LoadFacadeShutdownCommand, true);
			super.startup();
		}
	}
}
