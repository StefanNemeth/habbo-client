
package com.sulake.habbo.ui
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import flash.geom.Rectangle;

    public class DesktopLayoutManager 
    {

        private static const _SafeStr_14341:String = "room_view";
        private static const _SafeStr_14342:String = "room_widget";
        private static const BOTTOM_MARGIN:int = 47;

        private var _SafeStr_14343:IWindowContainer;
        private var _SafeStr_14344:XML = null;

        public function dispose():void
        {
            if (this._SafeStr_14343 != null){
                this._SafeStr_14343.dispose();
            };
        }
        public function setLayout(_arg_1:XML, _arg_2:IHabboWindowManager, _arg_3:IHabboConfigurationManager):void
        {
            var _local_5:IWindow;
            var _local_7:int;
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                throw (new Error("Unable to set room desktop layout."));
            };
            this._SafeStr_14344 = _arg_1.copy();
            this._SafeStr_14343 = (_arg_2.buildFromXML(_arg_1, 0) as IWindowContainer);
            if (this._SafeStr_14343 == null){
                throw (new Error("Failed to build layout from XML."));
            };
            this._SafeStr_14343.width = this._SafeStr_14343.desktop.width;
            this._SafeStr_14343.height = this._SafeStr_14343.desktop.height;
            var _local_4:IWindowContainer = (this._SafeStr_14343.desktop as IWindowContainer);
            _local_4.addChildAt(this._SafeStr_14343, 0);
            this._SafeStr_14343.findChildByTag("room_widget_infostand").y = (this._SafeStr_14343.findChildByTag("room_widget_infostand").y - BOTTOM_MARGIN);
            var _local_6:int;
            while (_local_6 < this._SafeStr_14343.numChildren) {
                _local_5 = this._SafeStr_14343.getChildAt(_local_6);
                _local_7 = ((WindowParam._SafeStr_9503) || (WindowParam._SafeStr_9500));
                if (_local_5.IWindow(_local_7)){
                    _local_5.addEventListener(WindowEvent.WE_CHILD_RESIZED, this.trimContainer);
                };
                _local_6++;
            };
        }
        private function trimContainer(_arg_1:WindowEvent):void
        {
            var _local_2:IWindowContainer = (_arg_1.window as IWindowContainer);
            if (_local_2 == null){
                return;
            };
            if (_local_2.numChildren != 1){
                return;
            };
            var _local_3:IWindow = _local_2.getChildAt(0);
            if (_local_3 == null){
                return;
            };
            _local_2.width = _local_3.width;
            _local_2.height = _local_3.height;
        }
        private function getWidgetContainer(_arg_1:String, _arg_2:IWindow):IWindowContainer
        {
            var _local_4:String;
            var _local_7:IWindowContainer;
            if (_arg_2 == null){
                return (null);
            };
            if (_arg_1 == RoomWidgetEnum.RWE_CHAT_INPUT_WIDGET){
                return ((this._SafeStr_14343.getChildByName("background_widgets") as IWindowContainer));
            };
            var _local_3:Array = _arg_2.tags;
            var _local_5:int;
            while (_local_5 < _local_3.length) {
                if (String(_local_3[_local_5]).indexOf(_SafeStr_14342) == 0){
                    _local_4 = (_local_3[_local_5] as String);
                    break;
                };
                _local_5++;
            };
            if (_local_4 == null){
                return (null);
            };
            return ((this._SafeStr_14343.WindowController(_local_4) as IWindowContainer));
        }
        public function addWidgetWindow(_arg_1:String, _arg_2:IWindow):Boolean
        {
            if (_arg_2 == null){
                return (false);
            };
            var _local_3:IWindowContainer = this.getWidgetContainer(_arg_1, _arg_2);
            if (_local_3 == null){
                return (false);
            };
            if (_arg_1 == RoomWidgetEnum.RWE_CHAT_INPUT_WIDGET){
                _local_3.addChild(_arg_2);
                return (true);
            };
            _arg_2.x = 0;
            _arg_2.y = 0;
            _local_3.addChild(_arg_2);
            _local_3.width = _arg_2.width;
            _local_3.height = _arg_2.height;
            return (true);
        }
        public function removeWidgetWindow(_arg_1:String, _arg_2:IWindow):void
        {
            var _local_3:IWindowContainer = this.getWidgetContainer(_arg_1, _arg_2);
            if (_local_3 != null){
                _local_3.removeChild(_arg_2);
            };
        }
        public function addRoomView(_arg_1:IWindow):Boolean
        {
            if (_arg_1 == null){
                return (false);
            };
            var _local_2:IWindowContainer = (this._SafeStr_14343.WindowController(_SafeStr_14341) as IWindowContainer);
            if (_local_2 == null){
                return (false);
            };
            _local_2.addChild(_arg_1);
            return (true);
        }
        public function get roomViewRect():Rectangle
        {
            if (this._SafeStr_14343 == null){
                return (null);
            };
            var _local_1:IWindowContainer = (this._SafeStr_14343.findChildByTag(_SafeStr_14341) as IWindowContainer);
            if (!_local_1){
                return (null);
            };
            var _local_2:Rectangle = _local_1.rectangle.clone();
            if (!_local_2){
                return (null);
            };
            _local_2.offset(this._SafeStr_14343.x, this._SafeStr_14343.y);
            return (_local_2);
        }
        public function DesktopLayoutManager():IWindow
        {
            if (this._SafeStr_14343 == null){
                return (null);
            };
            var _local_1:IWindowContainer = (this._SafeStr_14343.findChildByTag(_SafeStr_14341) as IWindowContainer);
            if (((!((_local_1 == null))) && ((_local_1.numChildren > 0)))){
                return (_local_1.getChildAt(0));
            };
            return (null);
        }

    }
}//package com.sulake.habbo.ui

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// setLayout = "_-3F5" (String#22081, DoABC#2)
// addWidgetWindow = "_-0YC" (String#15365, DoABC#2)
// roomViewRect = "_-37z" (String#21803, DoABC#2)
// removeWidgetWindow = "_-2wZ" (String#21330, DoABC#2)
// addRoomView = "_-2Bj" (String#19471, DoABC#2)
// DesktopLayoutManager = "_-eY" (String#23824, DoABC#2)
// _SafeStr_14341 = "_-sg" (String#24386, DoABC#2)
// _SafeStr_14342 = "_-1fU" (String#18116, DoABC#2)
// _SafeStr_14343 = "_-0fH" (String#15641, DoABC#2)
// _SafeStr_14344 = "_-0fN" (String#15646, DoABC#2)
// trimContainer = "_-2ic" (String#20793, DoABC#2)
// getWidgetContainer = "_-17z" (String#16773, DoABC#2)
// DesktopLayoutManager = "_-g4" (String#8513, DoABC#2)
// RWE_CHAT_INPUT_WIDGET = "_-L1" (String#23048, DoABC#2)
// IWindow = "_-1ml" (String#5794, DoABC#2)
// WE_CHILD_RESIZED = "_-i1" (String#23965, DoABC#2)
// WindowController = "_-tP" (String#2212, DoABC#2)
// _SafeStr_9500 = "_-3G5" (String#22121, DoABC#2)
// _SafeStr_9503 = "_-0es" (String#15621, DoABC#2)


