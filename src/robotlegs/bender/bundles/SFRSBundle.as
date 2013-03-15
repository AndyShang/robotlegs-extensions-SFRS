package robotlegs.bender.bundles
{
	import robotlegs.bender.extensions.commandCenter.CommandCenterExtension;
	import robotlegs.bender.extensions.contextView.ContextViewExtension;
	import robotlegs.bender.extensions.contextView.ContextViewListenerConfig;
	import robotlegs.bender.extensions.enhancedLogging.InjectableLoggerExtension;
	import robotlegs.bender.extensions.enhancedLogging.TraceLoggingExtension;
	import robotlegs.bender.extensions.eventCommandMap.EventCommandMapExtension;
	import robotlegs.bender.extensions.eventDispatcher.EventDispatcherExtension;
	import robotlegs.bender.extensions.localEventMap.LocalEventMapExtension;
	import robotlegs.bender.extensions.mediatorMap.MediatorMapExtension;
	import robotlegs.bender.extensions.modularity.ModularityExtension;
	import robotlegs.bender.extensions.sfrs.SFRSIntegrationExtension;
	import robotlegs.bender.extensions.sfrs.SFRSStageSyncExtension;
	import robotlegs.bender.extensions.signalCommandMap.SignalCommandMapExtension;
	import robotlegs.bender.extensions.viewManager.ManualStageObserverExtension;
	import robotlegs.bender.extensions.viewManager.StageObserverExtension;
	import robotlegs.bender.extensions.viewManager.ViewManagerExtension;
	import robotlegs.bender.framework.api.IBundle;
	import robotlegs.bender.framework.api.IContext;

	/**
	 * The <code>SARSBundle</code> class will include all extensions which are required
	 * to create functioning SARS/MVCS application.
	 *
	 * <p><i>Note: Extensions loaded by this bundle are in precise order since some
	 * extensions require injections which are mapped in other extensions.</i></p>
	 */
	public class SFRSBundle implements IBundle
	{
		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/
		/** @inheritDoc **/
		public function extend(context:IContext):void
		{
			context.install( //
				TraceLoggingExtension //
				, InjectableLoggerExtension //
				, ContextViewExtension //
				, SFRSIntegrationExtension //
				, EventDispatcherExtension //
				, ModularityExtension //
				, CommandCenterExtension //
				, EventCommandMapExtension //
				, LocalEventMapExtension //
				, ViewManagerExtension //
				, StageObserverExtension //
				, ManualStageObserverExtension //
				, MediatorMapExtension //
				, SignalCommandMapExtension //
				, SFRSStageSyncExtension);
			context.configure(ContextViewListenerConfig);
		}
	}
}
