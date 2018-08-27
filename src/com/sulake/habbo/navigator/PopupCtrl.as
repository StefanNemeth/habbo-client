
package com.sulake.habbo.navigator
{
    import flash.utils.Timer;
    import com.sulake.core.window.IWindowContainer;
    import flash.events.TimerEvent;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Point;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class PopupCtrl 
    {

        private var _navigator:HabboNavigator;
        private var _SafeStr_11205:String;
        private var _SafeStr_11275:int;
        private var _popupIndentLeft:int;
        private var _SafeStr_11276:Timer;
        private var _SafeStr_11277:Timer;
        private var _SafeStr_11278:IWindowContainer;

        public function PopupCtrl(_arg_1:HabboNavigator, _arg_2:int, _arg_3:int, _arg_4:String)
        {
            this._SafeStr_11276 = new Timer(500, 1);
            this._SafeStr_11277 = new Timer(100, 1);
            super();
            this._navigator = _arg_1;
            this._SafeStr_11205 = _arg_4;
            this._SafeStr_11275 = _arg_2;
            this._popupIndentLeft = _arg_3;
            this._SafeStr_11276.addEventListener(TimerEvent.TIMER, this.onDisplayTimer);
            this._SafeStr_11277.addEventListener(TimerEvent.TIMER, this.onHideTimer);
        }
        public function get navigator():HabboNavigator
        {
            return (this._navigator);
        }
        public function dispose():void
        {
            this._navigator = null;
            if (this._SafeStr_11276){
                this._SafeStr_11276.removeEventListener(TimerEvent.TIMER, this.onDisplayTimer);
                this._SafeStr_11276.reset();
                this._SafeStr_11276 = null;
            };
            if (this._SafeStr_11277){
                this._SafeStr_11277.removeEventListener(TimerEvent.TIMER, this.onHideTimer);
                this._SafeStr_11277.reset();
                this._SafeStr_11277 = null;
            };
        }
        public function showPopup(_arg_1:IWindow):void
        {
            if (this._SafeStr_11278 == null){
                this._SafeStr_11278 = IWindowContainer(this._navigator.getXmlWindow(this._SafeStr_11205));
                this._SafeStr_11278.visible = false;
                this._SafeStr_11278.setParamFlag(HabboWindowParam._SafeStr_3731, true);
                this._SafeStr_11278.procedure = this.onPopup;
            };
            Util.hideChildren(this._SafeStr_11278);
            this.refreshContent(this._SafeStr_11278);
            this._SafeStr_11278.height = (Util.getLowestPoint(this._SafeStr_11278) + 5);
            var _local_2:Point = new Point();
            _arg_1.getGlobalPosition(_local_2);
            this._SafeStr_11278.x = ((_local_2.x + this._SafeStr_11275) + _arg_1.width);
            this._SafeStr_11278.y = ((_local_2.y - (this._SafeStr_11278.height * 0.5)) + (_arg_1.height * 0.5));
            var _local_3:Point = new Point();
            this._SafeStr_11278.getGlobalPosition(_local_3);
            if ((_local_3.x + this._SafeStr_11278.width) > this._SafeStr_11278.desktop.width){
                this._SafeStr_11278.x = ((-(this._SafeStr_11278.width) + _local_2.x) + this._popupIndentLeft);
                this.refreshPopupArrows(this._SafeStr_11278, false);
            }
            else {
                this.refreshPopupArrows(this._SafeStr_11278, true);
            };
            if (!this._SafeStr_11278.visible){
                this._SafeStr_11276.reset();
                this._SafeStr_11276.start();
            };
            this._SafeStr_11277.reset();
            this._SafeStr_11278.activate();
        }
        public function closePopup():void
        {
            this._SafeStr_11277.reset();
            this._SafeStr_11276.reset();
            this._SafeStr_11277.start();
        }
        private function refreshPopupArrows(_arg_1:IWindowContainer, _arg_2:Boolean):void
        {
            this.refreshPopupArrow(_arg_1, true, _arg_2);
            this.refreshPopupArrow(_arg_1, false, !(_arg_2));
        }
        private function refreshPopupArrow(_arg_1:IWindowContainer, _arg_2:Boolean, _arg_3:Boolean):void
        {
            var _local_4:String = ("popup_arrow_" + ((_arg_2) ? "left" : "right"));
            var _local_5:IBitmapWrapperWindow = IBitmapWrapperWindow(_arg_1.findChildByName(_local_4));
            if (!_arg_3){
                if (_local_5 != null){
                    _local_5.visible = false;
                };
            }
            else {
                if (_local_5 == null){
                    _local_5 = this._navigator.getButton(_local_4, _local_4, null);
                    _local_5.setParamFlag(HabboWindowParam._SafeStr_6023, false);
                    _arg_1.addChild(_local_5);
                };
                _local_5.visible = true;
                _local_5.y = ((_arg_1.height * 0.5) - (_local_5.height * 0.5));
                _local_5.x = ((_arg_2) ? (1 - _local_5.width) : (_arg_1.width - 1));
            };
        }
        private function onDisplayTimer(_arg_1:TimerEvent):void
        {
            this._SafeStr_11278.visible = true;
            this._SafeStr_11278.activate();
        }
        private function onHideTimer(_arg_1:TimerEvent):void
        {
            if (this._SafeStr_11278 != null){
                this._SafeStr_11278.visible = false;
            };
        }
        public function hideInstantly():void
        {
            if (this._SafeStr_11278 != null){
                this._SafeStr_11278.visible = false;
            };
            this._SafeStr_11276.reset();
            this._SafeStr_11277.reset();
        }
        public function get visible():Boolean
        {
            return (((!((this._SafeStr_11278 == null))) && (this._SafeStr_11278.visible)));
        }
        public function refreshContent(_arg_1:IWindowContainer):void
        {
        }
        private function onPopup(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if ((_arg_1 as WindowMouseEvent) == null){
                return;
            };
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER){
                this._SafeStr_11277.reset();
            }
            else {
                if (_arg_1.type == WindowMouseEvent.WME_OUT){
                    if (!Util.containsMouse(this._SafeStr_11278)){
                        this.closePopup();
                    };
                };
            };
        }

    }
}//package com.sulake.habbo.navigator

// _SafeStr_11205 = "_-2Cx" (String#881, DoABC#2)
// _SafeStr_11275 = "_-321" (String#7347, DoABC#2)
// _SafeStr_11276 = "_-Qx" (String#8226, DoABC#2)
// _SafeStr_11277 = "_-2ZJ" (String#6750, DoABC#2)
// _SafeStr_11278 = "_-js" (String#8598, DoABC#2)
// onDisplayTimer = "_-0bX" (String#1508, DoABC#2)
// onHideTimer = "_-lJ" (String#2176, DoABC#2)
// refreshContent = "_-2Ec" (String#19590, DoABC#2)
// refreshPopupArrows = "_-2aJ" (String#6763, DoABC#2)
// refreshPopupArrow = "_-6W" (String#7795, DoABC#2)
// onPopup = "_-2Lk" (String#19874, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// HabboWindowParam = "_-29D" (String#6233, DoABC#2)
// Util = "_-1ve" (String#445, DoABC#2)
// PopupCtrl = "_-0f4" (String#818, DoABC#2)
// _SafeStr_3731 = "_-B" (String#22654, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// hideChildren = "_-14q" (String#1615, DoABC#2)
// showPopup = "_-0pi" (String#16042, DoABC#2)
// containsMouse = "_-0ij" (String#15781, DoABC#2)
// closePopup = "_-1eW" (String#18078, DoABC#2)
// hideInstantly = "_-DX" (String#22750, DoABC#2)
// getLowestPoint = "_-0t0" (String#16161, DoABC#2)
// _SafeStr_6023 = "_-Mr" (String#23121, DoABC#2)
// getButton = "_-1sK" (String#18645, DoABC#2)


