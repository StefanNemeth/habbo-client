
package com.sulake.core.window.utils.tablet
{
    import com.sulake.core.window.utils.GenericEventQueue;
    import flash.geom.Point;
    import flash.events.IEventDispatcher;

    public class TabletEventQueue extends GenericEventQueue 
    {

        protected var _touchPosition:Point;

        public function TabletEventQueue(_arg_1:IEventDispatcher)
        {
            super(_arg_1);
            this._touchPosition = new Point();
        }
        public function get touchPosition():Point
        {
            return (this._touchPosition);
        }
        override public function dispose():void
        {
            if (!_disposed){
                super.dispose();
            };
        }

    }
}//package com.sulake.core.window.utils.tablet

// GenericEventQueue = "_-0Tz" (String#4181, DoABC#2)
// TabletEventQueue = "_-0sJ" (String#16135, DoABC#2)
// _touchPosition = "_-3Jm" (String#22274, DoABC#2)
// touchPosition = "_-1U8" (String#17672, DoABC#2)


