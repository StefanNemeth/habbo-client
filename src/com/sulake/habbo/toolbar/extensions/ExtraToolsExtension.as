
package com.sulake.habbo.toolbar.extensions
{
    import com.sulake.habbo.toolbar.HabboToolbar;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.assets.XmlAsset;
    import flash.geom.Point;
    import flash.external.ExternalInterface;
    import com.sulake.core.window.events.WindowEvent;

    public class ExtraToolsExtension 
    {

        private static const _SafeStr_6250:uint = 0xFFFFFF;
        private static const _SafeStr_5584:uint = 12247545;
        private static const HELP:String = "HELP";
        private static const MENU_ROOMINFO:String = "ROOMINFO";

        private var _toolbar:HabboToolbar;
        private var _windowManager:IHabboWindowManager;
        private var _assets:IAssetLibrary;
        private var _events:IEventDispatcher;
        private var _config:IHabboConfigurationManager;
        private var _window:IWindowContainer;
        private var _content:IItemListWindow;
        private var _SafeStr_6253:IWindow;
        private var _SafeStr_6254:IWindowContainer;

        public function ExtraToolsExtension(_arg_1:HabboToolbar, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IEventDispatcher, _arg_5:IHabboConfigurationManager)
        {
            var _local_8:IWindow;
            super();
            this._toolbar = _arg_1;
            this._windowManager = _arg_2;
            this._assets = _arg_3;
            this._events = _arg_4;
            this._config = _arg_5;
            this._window = (this.createWindow("logout_xml") as IWindowContainer);
            var _local_6:IBitmapWrapperWindow = (this._window.findChildByName("roominfo_icon") as IBitmapWrapperWindow);
            _local_6.bitmap = (BitmapDataAsset(_arg_3.getAssetByName("roominfo_icon")).content as BitmapData);
            _local_6.disposesBitmap = false;
            this.insertLocalizations();
            this._SafeStr_6253 = this._window.findChildByName("roominfo_region");
            this._content = (this._window.findChildByName("list") as IItemListWindow);
            var _local_7:Array = [];
            this._content.groupListItemsWithTag("REGION", _local_7);
            for each (_local_8 in _local_7) {
                _local_8.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onMouseOver);
                _local_8.addEventListener(WindowMouseEvent.WME_OUT, this.onMouseOut);
            };
            this.hideRoomInfo();
        }
        public function get window():IWindow
        {
            return (this._window);
        }
        private function insertLocalizations():void
        {
            var _local_1:IWindow;
            _local_1 = this._window.findChildByName("roominfo_text");
            _local_1.caption = ((("$" + "{") + _local_1.caption) + "}");
            _local_1 = this._window.findChildByName("help_text");
            _local_1.caption = ((("$" + "{") + _local_1.caption) + "}");
            _local_1 = this._window.findChildByName("logout_text");
            _local_1.caption = ((("$" + "{") + _local_1.caption) + "}");
        }
        public function dispose():void
        {
            this._toolbar = null;
            this._windowManager = null;
            this._assets = null;
            this._events = null;
            this._config = null;
            if (this._window){
                this._window.dispose();
                this._window = null;
            };
            if (this._SafeStr_6254){
                this._SafeStr_6254.dispose();
                this._SafeStr_6254 = null;
            };
        }
        public function hideRoomInfo():void
        {
            this._content.removeListItem(this._SafeStr_6253);
        }
        public function showRoomInfo():void
        {
            this._content.addListItemAt(this._SafeStr_6253, 0);
        }
        private function onMouseOver(_arg_1:WindowMouseEvent):void
        {
            var _local_2:ITextWindow = (IWindowContainer(_arg_1.window).findChildByTag("TEXT") as ITextWindow);
            _local_2.textColor = _SafeStr_5584;
        }
        private function onMouseOut(_arg_1:WindowMouseEvent):void
        {
            var _local_2:ITextWindow = (IWindowContainer(_arg_1.window).findChildByTag("TEXT") as ITextWindow);
            _local_2.textColor = _SafeStr_6250;
        }
        private function createWindow(_arg_1:String):IWindow
        {
            var _local_2:XmlAsset = (this._assets.getAssetByName(_arg_1) as XmlAsset);
            var _local_3:IWindow = this._windowManager.buildFromXML((_local_2.content as XML));
            _local_3.procedure = this.onClick;
            return (_local_3);
        }
        private function showConfirmation():void
        {
            var _local_1:Point;
            if (!this._SafeStr_6254){
                this._SafeStr_6254 = (this.createWindow("logout_confirmation_xml") as IWindowContainer);
                _local_1 = new Point();
                this._window.getGlobalPosition(_local_1);
                this._SafeStr_6254.x = ((_local_1.x + this._window.width) - this._SafeStr_6254.width);
                this._SafeStr_6254.y = (((_local_1.y + this._window.height) - this._SafeStr_6254.height) + 100);
            };
        }
        private function closeConfirmation():void
        {
            if (this._SafeStr_6254){
                this._SafeStr_6254.dispose();
                this._SafeStr_6254 = null;
            };
        }
        private function onClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            switch (_arg_2.name){
                case "logout_region":
                    this.showConfirmation();
                    return;
                case "help_region":
                    this._toolbar.toggleWindowVisibility(HELP);
                    return;
                case "roominfo_region":
                    this._toolbar.toggleWindowVisibility(MENU_ROOMINFO);
                    return;
                case "confirm":
                    if (ExternalInterface.available){
                        ExternalInterface.call("FlashExternalInterface.logout");
                    };
                    this.closeConfirmation();
                    return;
                case "cancel":
                    this.closeConfirmation();
                    return;
            };
        }

    }
}//package com.sulake.habbo.toolbar.extensions

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// ExtraToolsExtension = "_-1Ws" (String#5490, DoABC#2)
// addListItemAt = "_-2CT" (String#6293, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// _content = "_-1Q8" (String#74, DoABC#2)
// onMouseOver = "_-21W" (String#613, DoABC#2)
// onMouseOut = "_-1ap" (String#608, DoABC#2)
// closeConfirmation = "_-2PG" (String#6548, DoABC#2)
// _SafeStr_5584 = "_-3IQ" (String#7678, DoABC#2)
// _SafeStr_6250 = "_-1V3" (String#17705, DoABC#2)
// HELP = "_-2N7" (String#19929, DoABC#2)
// _toolbar = "_-1LG" (String#93, DoABC#2)
// _SafeStr_6253 = "_-037" (String#3630, DoABC#2)
// _SafeStr_6254 = "_-04u" (String#14238, DoABC#2)
// disposesBitmap = "_-03U" (String#3637, DoABC#2)
// insertLocalizations = "_-03Z" (String#14184, DoABC#2)
// groupListItemsWithTag = "_-0gQ" (String#4432, DoABC#2)
// hideRoomInfo = "_-08z" (String#14406, DoABC#2)
// showRoomInfo = "_-1rC" (String#18590, DoABC#2)
// onClick = "_-2US" (String#368, DoABC#2)
// toggleWindowVisibility = "_-0g0" (String#15672, DoABC#2)


