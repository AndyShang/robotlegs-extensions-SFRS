// ------------------------------------------------------------------------------
// Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
// NOTICE: You are permitted to use, modify, and distribute this file
// in accordance with the terms of the license agreement accompanying it.
// ------------------------------------------------------------------------------
package robotlegs.bender.extensions.sfrs.impl
{
	import flare.basic.Scene3D;
	import flare.core.Pivot3D;
	import flash.events.Event;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.extensions.sfrs.api.IFlare3DViewMap;

	/**
	 * The <code>Flare3DViewMap</code> class performs managing Flare3D scene and
	 * views automatic mediation. When view is added or removed from scene, it will
	 * automatically create or destroy its mediator.
	 */
	public class Flare3DViewMap implements IFlare3DViewMap
	{

		/*============================================================================*/
		/* Public Properties                                                         */
		/*============================================================================*/
		[Inject]
		/** Instance of View3D which contains scene receiving display objects. **/
		public var scene3D:Scene3D;

		[Inject]
		/** Map for mediating views. **/
		public var mediatorMap:IMediatorMap;

		/*============================================================================*/
		/* Constructor
		/*============================================================================*/
		[PostConstruct]
		/**
		 * Initialize listeners on Flare3D scene.
		 */
		public function init():void
		{
			// listen for ObjectContainer3D events
			scene3D.addEventListener("addedToScene", onSceneAdded);
			scene3D.addEventListener("removedFromScene", onSceneRemoved);
			// add scene as view to allow a Flare3D Scene Mediator
			// Note : we don't support swapping scenes now - one scene will do.
			addFlare3DView(scene3D);
		}

		/*============================================================================*/
		/* Public Methods
		/*============================================================================*/
		/** @inheritDoc **/
		public function addFlare3DView(view:*):void
		{
			if (validateView(view))
			{
				mediatorMap.mediate(view);
			}
			else
				throw new Error("Not sure what to do with this view type..");
		}

		/** @inheritDoc **/
		public function removeFlare3DView(view:*):void
		{
			mediatorMap.unmediate(view);
		}

		/*============================================================================*/
		/* Private Methods
		/*============================================================================*/
		/**
		 * Validate if view added on scene is of type either <code>Scene3D</code> or
		 * <code>ObjectContainer3D</code>, and this is required since <code>Scene3D</code>
		 * doesn't extend <code>ObjectContainer3D</code>.
		 *
		 * @param view View that needs to be validated.
		 *
		 * @return Returns <code>true</code> if view is of valid type, or <code>false</code>
		 * otherwise.
		 */
		private function validateView(view:*):Boolean
		{
			if (view is Scene3D || view is Pivot3D)
			{
				return true;
			}
			else
				return false;
		}

		/**
		 * Handle view added to scene.
		 *
		 * @param event View added to scene.
		 */
		private function onSceneAdded(event:Event):void
		{
			addFlare3DView(event.currentTarget as Scene3D);
		}

		/**
		 * Handle view removed from scene.
		 *
		 * @param event View removed from scene.
		 */
		private function onSceneRemoved(event:Event):void
		{
			removeFlare3DView(event.currentTarget as Scene3D);
		}
	}
}
