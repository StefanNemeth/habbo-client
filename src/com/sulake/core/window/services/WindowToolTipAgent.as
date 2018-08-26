
package com.sulake.core.window.services
{
    import com.sulake.core.window.components.IToolTipWindow;
    import flash.utils.Timer;
    import flash.geom.Point;
    import flash.display.DisplayObject;
    import com.sulake.core.window.components.IInteractiveWindow;
    import flash.events.TimerEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.enum.WindowType;
    import com.sulake.core.window.enum.WindowParam;

    public class WindowToolTipAgent extends WindowMouseOperator implements IToolTipAgentService 
    {

        protected var _toolTipCaption:String;
        protected var _SafeStr_9653:IToolTipWindow;
        protected var _SafeStr_9654:Timer;
        protected var _SafeStr_9655:Point;
        protected var _pointerOffset:Point;
        protected var _toolTipDelay:uint;

        public function WindowToolTipAgent(_arg_1:DisplayObject)
        {
            this._pointerOffset = new Point();
            this._SafeStr_9655 = new Point(20, 20);
            this._toolTipDelay = 500;
            super(_arg_1);
        }
        override public function begin(_arg_1:IWindow, _arg_2:uint=0):IWindow
        {
            if (((_arg_1) && (!(_arg_1.disposed)))){
                if ((_arg_1 is IInteractiveWindow)){
                    this._toolTipCaption = IInteractiveWindow(_arg_1).toolTipCaption;
                    this._toolTipDelay = IInteractiveWindow(_arg_1).toolTipDelay;
                }
                else {
                    this._toolTipCaption = _arg_1.caption;
                    this._toolTipDelay = 500;
                };
                _mouse.x = _root.mouseX;
                _mouse.y = _root.mouseY;
                WindowMouseOperator(_arg_1, _mouse, this._pointerOffset);
                if (((!((this._toolTipCaption == null))) && (!((this._toolTipCaption == ""))))){
                    if (this._SafeStr_9654 == null){
                        this._SafeStr_9654 = new Timer(this._toolTipDelay, 1);
                        this._SafeStr_9654.addEventListener(TimerEvent.TIMER, this.showToolTip);
                    };
                    this._SafeStr_9654.reset();
                    this._SafeStr_9654.start();
                };
            };
            return (super.begin(_arg_1, _arg_2));
        }
        override public function end(_arg_1:IWindow):IWindow
        {
            if (this._SafeStr_9654 != null){
                this._SafeStr_9654.stop();
                this._SafeStr_9654.removeEventListener(TimerEvent.TIMER, this.showToolTip);
                this._SafeStr_9654 = null;
            };
            this.hideToolTip();
            return (super.end(_arg_1));
        }
        override public function GestureAgentService(_arg_1:int, _arg_2:int):void
        {
            if (((_window) && (!(_window.disposed)))){
                _mouse.x = _arg_1;
                _mouse.y = _arg_2;
                WindowMouseOperator(_window, _mouse, this._pointerOffset);
                if (((!((this._SafeStr_9653 == null))) && (!(this._SafeStr_9653.disposed)))){
                    this._SafeStr_9653.x = (_arg_1 + this._SafeStr_9655.x);
                    this._SafeStr_9653.y = (_arg_2 + this._SafeStr_9655.y);
                };
            };
        }
        protected function showToolTip(_arg_1:TimerEvent):void
        {
            var _local_2:Point;
            if (this._SafeStr_9654 != null){
                this._SafeStr_9654.reset();
            };
            if (((_window) && (!(_window.disposed)))){
                if ((((this._SafeStr_9653 == null)) || (this._SafeStr_9653.disposed))){
                    this._SafeStr_9653 = (_window.context.create((_window.name + "::ToolTip"), this._toolTipCaption, WindowType._SafeStr_9432, _window.style, (WindowParam._SafeStr_7445 | WindowParam._SafeStr_7433), null, null, null, 0, null, null) as IToolTipWindow);
                };
                _local_2 = new Point();
                _window.getGlobalPosition(_local_2);
                this._SafeStr_9653.x = ((_local_2.x + this._pointerOffset.x) + this._SafeStr_9655.x);
                this._SafeStr_9653.y = ((_local_2.y + this._pointerOffset.y) + this._SafeStr_9655.y);
            };
        }
        protected function hideToolTip():void
        {
            if (((!((this._SafeStr_9653 == null))) && (!(this._SafeStr_9653.disposed)))){
                this._SafeStr_9653.destroy();
                this._SafeStr_9653 = null;
            };
        }

    }
}//package com.sulake.core.window.services

// WindowType = "_-1yl" (String#6008, DoABC#2)
// IInteractiveWindow = "_-0KX" (String#1454, DoABC#2)
// IToolTipWindow = "_-0GV" (String#3884, DoABC#2)
// IToolTipAgentService = "_-0Sl" (String#4154, DoABC#2)
// WindowMouseOperator = "_-1Tv" (String#5430, DoABC#2)
// WindowToolTipAgent = "_-3Gu" (String#7645, DoABC#2)
// destroy = "_-25R" (String#615, DoABC#2)
// toolTipCaption = "_-0cC" (String#4347, DoABC#2)
// _SafeStr_7433 = "_-222" (String#19092, DoABC#2)
// _SafeStr_7445 = "_-3Kg" (String#22311, DoABC#2)
// toolTipDelay = "_-2W1" (String#6685, DoABC#2)
// hideToolTip = "_-2VZ" (String#1889, DoABC#2)
// _toolTipDelay = "_-0Bo" (String#810, DoABC#2)
// _toolTipCaption = "_-03Q" (String#806, DoABC#2)
// _pointerOffset = "_-38-" (String#7471, DoABC#2)
// _SafeStr_9432 = "_-oz" (String#24234, DoABC#2)
// WindowMouseOperator = "_-1xh" (String#18875, DoABC#2)
// GestureAgentService = "_-0n2" (String#4567, DoABC#2)
// _SafeStr_9653 = "_-1-J" (String#16441, DoABC#2)
// _SafeStr_9654 = "_-2-0" (String#18971, DoABC#2)
// _SafeStr_9655 = "_-2cj" (String#20553, DoABC#2)


