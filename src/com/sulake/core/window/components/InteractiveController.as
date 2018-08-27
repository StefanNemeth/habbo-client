
package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowController;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.utils.PropertyDefaults;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.utils.PropertyStruct;
    import com.sulake.core.window.enum.MouseCursorType;

    public class InteractiveController extends WindowController implements IInteractiveWindow 
    {

        protected var _toolTipDelay:uint = 500;
        protected var _toolTipCaption:String = "";
        protected var _cursorByState:Map;

        public function InteractiveController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            _arg_4 = (_arg_4 | WindowParam._SafeStr_7434);
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }
        public static function processInteractiveWindowEvents(_arg_1:IInteractiveWindow, _arg_2:WindowEvent):void
        {
            if (_arg_1.toolTipCaption != PropertyDefaults.){
                if (_arg_2.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER){
                    _arg_1.context.getWindowServices().getToolTipAgentService().begin(_arg_1);
                }
                else {
                    if (_arg_2.type != WindowMouseEvent.WME_MOVE){
                        if (_arg_2.type == WindowMouseEvent.WME_OUT){
                            _arg_1.context.getWindowServices().getToolTipAgentService().end(_arg_1);
                        };
                    };
                };
            };
        }
        public static function readInteractiveWindowProperties(_arg_1:IInteractiveWindow, _arg_2:Array):void
        {
            var _local_3:PropertyStruct;
            for each (_local_3 in _arg_2) {
                switch (_local_3.key){
                    case PropertyDefaults._SafeStr_9233:
                        if (_local_3.value != _arg_1.toolTipCaption){
                            _arg_1.toolTipCaption = (_local_3.value as String);
                        };
                        break;
                    case PropertyDefaults._SafeStr_9234:
                        if (_local_3.value != _arg_1.toolTipDelay){
                            _arg_1.toolTipDelay = (_local_3.value as uint);
                        };
                        break;
                };
            };
        }
        public static function writeInteractiveWindowProperties(_arg_1:IInteractiveWindow, _arg_2:Array):Array
        {
            if (_arg_1.toolTipCaption != PropertyDefaults.){
                _arg_2.push(new PropertyStruct(PropertyDefaults._SafeStr_9233, _arg_1.toolTipCaption, PropertyStruct._SafeStr_8998, true));
            }
            else {
                _arg_2.push(PropertyDefaults._SafeStr_9235);
            };
            if (_arg_1.toolTipDelay != PropertyDefaults._SafeStr_9236){
                _arg_2.push(new PropertyStruct(PropertyDefaults._SafeStr_9234, _arg_1.toolTipDelay, PropertyStruct._SafeStr_8993, true));
            }
            else {
                _arg_2.push(PropertyDefaults.TOOL_TIP_DELAY);
            };
            return (_arg_2);
        }

        public function set toolTipCaption(_arg_1:String):void
        {
            this._toolTipCaption = (((_arg_1 == null)) ? PropertyDefaults. : _arg_1);
        }
        public function get toolTipCaption():String
        {
            return (this._toolTipCaption);
        }
        public function set toolTipDelay(_arg_1:uint):void
        {
            this._toolTipDelay = _arg_1;
        }
        public function get toolTipDelay():uint
        {
            return (this._toolTipDelay);
        }
        public function setMouseCursorForState(_arg_1:uint, _arg_2:uint):uint
        {
            if (!this._cursorByState){
                this._cursorByState = new Map();
            };
            var _local_3:uint = this._cursorByState[_arg_1];
            if ((((_arg_2 == MouseCursorType._SafeStr_3729)) || ((_arg_2 == -1)))){
                this._cursorByState.remove(_arg_1);
            }
            else {
                this._cursorByState[_arg_1] = _arg_2;
            };
            return (_local_3);
        }
        public function getMouseCursorByState(_arg_1:uint):uint
        {
            if (!this._cursorByState){
                return (MouseCursorType._SafeStr_3729);
            };
            return (this._cursorByState.getValue(_arg_1));
        }
        override public function update(_arg_1:WindowController, _arg_2:WindowEvent):Boolean
        {
            if (_arg_1 == this){
                processInteractiveWindowEvents(this, _arg_2);
            };
            return (super.update(_arg_1, _arg_2));
        }
        public function showToolTip(_arg_1:IToolTipWindow):void
        {
        }
        public function hideToolTip():void
        {
        }
        override public function get properties():Array
        {
            return (writeInteractiveWindowProperties(this, super.properties));
        }
        override public function set properties(_arg_1:Array):void
        {
            readInteractiveWindowProperties(this, _arg_1);
            super.properties = _arg_1;
        }

    }
}//package com.sulake.core.window.components

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// WindowContext = "_-2K8" (String#6447, DoABC#2)
// IInteractiveWindow = "_-0KX" (String#1454, DoABC#2)
// MouseCursorType = "_-031" (String#14164, DoABC#2)
// IToolTipWindow = "_-0GV" (String#3884, DoABC#2)
// PropertyStruct = "_-t6" (String#24410, DoABC#2)
// PropertyDefaults = "_-3Dd" (String#22019, DoABC#2)
// InteractiveController = "_-25D" (String#6146, DoABC#2)
// _SafeStr_3729 = "_-06z" (String#14322, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// WME_MOVE = "_-1ee" (String#18084, DoABC#2)
// setMouseCursorForState = "_-1lf" (String#5777, DoABC#2)
// toolTipCaption = "_-0cC" (String#4347, DoABC#2)
// _SafeStr_7434 = "_-2xA" (String#21356, DoABC#2)
// _SafeStr_8993 = "_-O-" (String#23167, DoABC#2)
// _SafeStr_8998 = "_-1lW" (String#18353, DoABC#2)
// toolTipDelay = "_-2W1" (String#6685, DoABC#2)
// hideToolTip = "_-2VZ" (String#1889, DoABC#2)
// getMouseCursorByState = "_-0Bd" (String#3788, DoABC#2)
// _toolTipDelay = "_-0Bo" (String#810, DoABC#2)
// _toolTipCaption = "_-03Q" (String#806, DoABC#2)
// processInteractiveWindowEvents = "_-10V" (String#16483, DoABC#2)
// writeInteractiveWindowProperties = "_-3LB" (String#22332, DoABC#2)
//  = "_-0Mq" (String#14946, DoABC#2)
// _SafeStr_9233 = "_-2rP" (String#21134, DoABC#2)
// _SafeStr_9234 = "_-0nj" (String#15965, DoABC#2)
// _SafeStr_9235 = "_-0BF" (String#14496, DoABC#2)
// _SafeStr_9236 = "_-2xT" (String#21370, DoABC#2)


