
package com.sulake.habbo.friendlist
{
    import flash.utils.Timer;
    import com.sulake.core.window.IWindowContainer;
    import flash.events.TimerEvent;
    import flash.geom.Point;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.window.enum.HabboWindowParam;

    public class PopupCtrl 
    {

        private var _friendList:HabboFriendList;
        private var _SafeStr_11205:String;
        private var _SafeStr_11275:int;
        private var _popupIndentLeft:int;
        private var _SafeStr_11276:Timer;
        private var _SafeStr_11277:Timer;
        private var _SafeStr_11278:IWindowContainer;

        public function PopupCtrl(_arg_1:HabboFriendList, _arg_2:int, _arg_3:int, _arg_4:String)
        {
            this._SafeStr_11276 = new Timer(500, 1);
            this._SafeStr_11277 = new Timer(100, 1);
            super();
            this._friendList = _arg_1;
            this._SafeStr_11205 = _arg_4;
            this._SafeStr_11275 = _arg_2;
            this._popupIndentLeft = _arg_3;
            this._SafeStr_11276.addEventListener(TimerEvent.TIMER, this.onDisplayTimer);
            this._SafeStr_11277.addEventListener(TimerEvent.TIMER, this.onHideTimer);
        }
        public function get friendList():HabboFriendList
        {
            return (this._friendList);
        }
        public function showPopup(_arg_1:IWindowContainer, _arg_2:IWindow):void
        {
            if (this._SafeStr_11278 == null){
                this._SafeStr_11278 = IWindowContainer(this._friendList.getXmlWindow(this._SafeStr_11205));
                this._SafeStr_11278.visible = false;
                _arg_1.addChild(this._SafeStr_11278);
            };
            this.refreshContent(this._SafeStr_11278);
            this._SafeStr_11278.width = (Util.getRightmostPoint(this._SafeStr_11278) + 10);
            this._SafeStr_11278.height = (Util.getLowestPoint(this._SafeStr_11278) + 10);
            var _local_3:Point = new Point();
            var _local_4:Point = new Point();
            _arg_1.getGlobalPosition(_local_3);
            _arg_2.getGlobalPosition(_local_4);
            this._SafeStr_11278.x = (((_local_4.x - _local_3.x) + this._SafeStr_11275) + _arg_2.width);
            this._SafeStr_11278.y = (((_local_4.y - _local_3.y) - (this._SafeStr_11278.height * 0.5)) + (_arg_2.height * 0.5));
            var _local_5:Point = new Point();
            this._SafeStr_11278.getGlobalPosition(_local_5);
            if ((_local_5.x + this._SafeStr_11278.width) > this._SafeStr_11278.desktop.width){
                this._SafeStr_11278.x = (((-(this._SafeStr_11278.width) + _local_4.x) - _local_3.x) + this._popupIndentLeft);
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
                    _local_5 = this._friendList.getButton(_local_4, _local_4, null);
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
        public function refreshContent(_arg_1:IWindowContainer):void
        {
        }

    }
}//package com.sulake.habbo.friendlist

// getRightmostPoint = "_-2iX" (String#20789, DoABC#2)
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
// HabboWindowParam = "_-29D" (String#6233, DoABC#2)
// Util = "_-1ve" (String#445, DoABC#2)
// PopupCtrl = "_-0f4" (String#818, DoABC#2)
// showPopup = "_-0pi" (String#16042, DoABC#2)
// closePopup = "_-1eW" (String#18078, DoABC#2)
// getLowestPoint = "_-0t0" (String#16161, DoABC#2)
// _SafeStr_6023 = "_-Mr" (String#23121, DoABC#2)
// getButton = "_-1sK" (String#18645, DoABC#2)


