
package com.sulake.core.window.services
{
    import com.sulake.core.window.enum.MouseListenerType;
    import flash.display.DisplayObject;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import flash.geom.Point;
    import flash.events.Event;

    public class WindowMouseListener extends WindowMouseOperator implements IMouseListenerService 
    {

        private var _eventTypes:Array;
        private var _areaLimit:uint;

        public function WindowMouseListener(_arg_1:DisplayObject)
        {
            this._eventTypes = new Array();
            this._areaLimit = MouseListenerType._SafeStr_9481;
            super(_arg_1);
        }
        public function get eventTypes():Array
        {
            return (this._eventTypes);
        }
        public function get areaLimit():uint
        {
            return (this._areaLimit);
        }
        public function set areaLimit(_arg_1:uint):void
        {
            this._areaLimit = _arg_1;
        }
        override public function end(_arg_1:IWindow):IWindow
        {
            var _local_2:int = this._eventTypes.length;
            while (_local_2 > 0) {
                this._eventTypes.pop();
                _local_2--;
            };
            return (super.end(_arg_1));
        }
        override protected function handler(_arg_1:Event):void
        {
            var _local_2:Boolean;
            if (((_working) && (!(_window.disposed)))){
                if (this._eventTypes.indexOf(_arg_1.type) >= 0){
                    if ((_arg_1 is WindowMouseEvent)){
                        _local_2 = _window.hitTestGlobalPoint(new Point(WindowMouseEvent(_arg_1).stageX, WindowMouseEvent(_arg_1).stageY));
                        if ((((this._areaLimit == MouseListenerType._SafeStr_9482)) && (!(_local_2)))){
                            return;
                        };
                        if ((((this._areaLimit == MouseListenerType._SafeStr_9483)) && (_local_2))){
                            return;
                        };
                    };
                    _window.update(null, WindowMouseEvent(_arg_1));
                };
            };
        }
        override public function GestureAgentService(_arg_1:int, _arg_2:int):void
        {
        }

    }
}//package com.sulake.core.window.services

// MouseListenerType = "_-0a" (String#4300, DoABC#2)
// IMouseListenerService = "_-0s7" (String#4688, DoABC#2)
// WindowMouseOperator = "_-1Tv" (String#5430, DoABC#2)
// WindowMouseListener = "_-2tW" (String#7147, DoABC#2)
// handler = "_-06s" (String#1404, DoABC#2)
// _SafeStr_9481 = "_-09P" (String#14426, DoABC#2)
// _SafeStr_9482 = "_-2AL" (String#19419, DoABC#2)
// _SafeStr_9483 = "_-1ot" (String#18494, DoABC#2)
// eventTypes = "_-iE" (String#8559, DoABC#2)
// areaLimit = "_-1I0" (String#5207, DoABC#2)
// GestureAgentService = "_-0n2" (String#4567, DoABC#2)
// _eventTypes = "_-1AH" (String#16871, DoABC#2)
// _areaLimit = "_-1Mc" (String#17384, DoABC#2)


