
package com.sulake.core.window.components
{
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.enum.MouseCursorType;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.events.WindowEvent;

    public class RegionController extends ContainerController implements IRegionWindow 
    {

        protected static const _SafeStr_9392:String = "tool_tip_caption";
        protected static const :String = "";
        protected static const KEY_TOOLTIP_DELAY:String = "tool_tip_delay";
        protected static const _properties:uint = 500;

        protected var _toolTipDelay:uint = 500;
        protected var _toolTipCaption:String = "";
        protected var _cursorByState:Map;

        public function RegionController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function=null, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            _arg_4 = (_arg_4 | WindowParam._SafeStr_7434);
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }
        public function set toolTipCaption(_arg_1:String):void
        {
            this._toolTipCaption = (((_arg_1 == null)) ? "" : _arg_1);
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
        public function showToolTip(_arg_1:IToolTipWindow):void
        {
        }
        public function hideToolTip():void
        {
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
        public function MouseEventProcessor(_arg_1:uint):uint
        {
            if (!this._cursorByState){
                return (MouseCursorType._SafeStr_3729);
            };
            return (this._cursorByState.getValue(_arg_1));
        }
        override public function update(_arg_1:WindowController, _arg_2:WindowEvent):Boolean
        {
            var _local_3:Boolean = super.update(_arg_1, _arg_2);
            if (_arg_1 == this){
                InteractiveController.InteractiveController(this, _arg_2);
            };
            return (_local_3);
        }
        override public function get properties():Array
        {
            return (InteractiveController.InteractiveController(this, super.properties));
        }
        override public function set properties(_arg_1:Array):void
        {
            InteractiveController.readInteractiveWindowProperties(this, _arg_1);
            super.properties = _arg_1;
        }

    }
}//package com.sulake.core.window.components

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// WindowContext = "_-2K8" (String#6447, DoABC#2)
// IRegionWindow = "_-dg" (String#2146, DoABC#2)
// ContainerController = "_-1v4" (String#5943, DoABC#2)
// MouseCursorType = "_-031" (String#14164, DoABC#2)
// IToolTipWindow = "_-0GV" (String#3884, DoABC#2)
// InteractiveController = "_-25D" (String#6146, DoABC#2)
// RegionController = "_-1kV" (String#5760, DoABC#2)
// _SafeStr_3729 = "_-06z" (String#14322, DoABC#2)
// setMouseCursorForState = "_-1lf" (String#5777, DoABC#2)
// toolTipCaption = "_-0cC" (String#4347, DoABC#2)
// _SafeStr_7434 = "_-2xA" (String#21356, DoABC#2)
// toolTipDelay = "_-2W1" (String#6685, DoABC#2)
// hideToolTip = "_-2VZ" (String#1889, DoABC#2)
// MouseEventProcessor = "_-0Bd" (String#3788, DoABC#2)
// _toolTipDelay = "_-0Bo" (String#810, DoABC#2)
// _toolTipCaption = "_-03Q" (String#806, DoABC#2)
// InteractiveController = "_-10V" (String#16483, DoABC#2)
// InteractiveController = "_-3LB" (String#22332, DoABC#2)
// _SafeStr_9392 = "_-0EX" (String#14626, DoABC#2)
//  = "_-1jR" (String#18262, DoABC#2)
// _properties = "_-39B" (String#21853, DoABC#2)


