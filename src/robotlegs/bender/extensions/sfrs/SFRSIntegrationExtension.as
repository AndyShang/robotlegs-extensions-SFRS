//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.sfrs
{
	import flare.basic.Scene3D;
	import org.hamcrest.object.instanceOf;
	import robotlegs.bender.extensions.sfrs.api.IFlare3DViewMap;
	import robotlegs.bender.extensions.sfrs.api.IStarlingViewMap;
	import robotlegs.bender.extensions.sfrs.api.StarlingCollection;
	import robotlegs.bender.extensions.sfrs.impl.Flare3DViewMap;
	import robotlegs.bender.extensions.sfrs.impl.StarlingViewMap;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IExtension;
	import robotlegs.bender.framework.api.ILogger;
	import robotlegs.bender.framework.impl.UID;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;

	/**
	 * <p>This Extension will map all Starling view instances and View3D instance in
	 * injector as well as create view maps for automatic mediation when instances are
	 * added on stage/scene.</p>
	 */
	public class SFRSIntegrationExtension implements IExtension
	{
		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/
		/** Extension UID. **/
		private const _uid:String = UID.create(SFRSIntegrationExtension);

		/** Context being initialized. **/
		private var _context:IContext;

		/** Logger used to log messaged when using this extension. **/
		private var _logger:ILogger;

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/
		/** @inheritDoc **/
		public function extend(context:IContext):void
		{
			_context = context;
			_logger = context.getLogger(this);
			_context.addConfigHandler(instanceOf(StarlingCollection), handleStarlingCollection);
			_context.addConfigHandler(instanceOf(Scene3D), handleScene3D);
		}

		/**
		 * Returns the string representation of the specified object.
		 */
		public function toString():String
		{
			return _uid;
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/
		/**
		 * Map all Starling view instances to injector with their defined name and map
		 * and initialize Starling view map which will mediate display instances.
		 *
		 * @param collection Collection of Starling view instances used in context.
		 */
		private function handleStarlingCollection(s:StarlingCollection):void
		{
			_logger.debug("Mapping provided Starling instances...");
			_context.injector.map(StarlingCollection).toValue(s);
			var key:String;

			for (key in s.items)
			{
				_context.injector.map(DisplayObjectContainer, key).toValue(Starling(s.items[key]).stage);
			}
			_context.injector.map(IStarlingViewMap).toSingleton(StarlingViewMap);
			_context.injector.getInstance(IStarlingViewMap);
		}

		/**
		 * Map Scene3D instance to injector and map and initialize Flare3D view map
		 * which will mediate display instances.
		 *
		 * @param view3D View3D instance which will be used in context.
		 */
		private function handleScene3D(scene3D:Scene3D):void
		{
			_logger.debug("Mapping provided Scene3D as Flare3D contextView...");
			_context.injector.map(Scene3D).toValue(scene3D);
			_context.injector.map(IFlare3DViewMap).toSingleton(Flare3DViewMap);
			_context.injector.getInstance(IFlare3DViewMap);
		}
	}
}
