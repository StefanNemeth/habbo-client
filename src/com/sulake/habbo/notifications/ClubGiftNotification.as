
package com.sulake.habbo.notifications
{
    import com.sulake.core.window.components.IBorderWindow;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    import com.sulake.habbo.catalog.enum.CatalogPageName;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IIconWindow;

    public class ClubGiftNotification 
    {

        private static const _SafeStr_12093:String = "club_gift_notification";
        private static const _SafeStr_6263:uint = 0xFFFFFF;
        private static const _SafeStr_6264:uint = 12247545;
        private static const _SafeStr_5377:int = 13;
        private static const _SafeStr_5378:int = 14;

        private var _window:IBorderWindow;
        private var _catalog:IHabboCatalog;
        private var _toolbar:IHabboToolbar;
        private var _SafeStr_12094:ITextWindow;

        public function ClubGiftNotification(_arg_1:int, _arg_2:IAssetLibrary, _arg_3:IHabboWindowManager, _arg_4:IHabboCatalog, _arg_5:IHabboToolbar)
        {
            if (((((!(_arg_2)) || (!(_arg_3)))) || (!(_arg_4)))){
                return;
            };
            this._catalog = _arg_4;
            this._toolbar = _arg_5;
            var _local_6:XmlAsset = (_arg_2.getAssetByName("club_gift_notification_xml") as XmlAsset);
            if (_local_6 == null){
                return;
            };
            this._window = (_arg_3.buildFromXML((_local_6.content as XML)) as IBorderWindow);
            if (this._window == null){
                return;
            };
            this._window.procedure = this.eventHandler;
            this._toolbar.extensionView.attachExtension(_SafeStr_12093, this._window);
            this._SafeStr_12094 = (this._window.findChildByName("cancel_link") as ITextWindow);
            var _local_7:IRegionWindow = (this._window.findChildByName("cancel_link_region") as IRegionWindow);
            if (_local_7){
                _local_7.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onMouseOver);
                _local_7.addEventListener(WindowMouseEvent.WME_OUT, this.onMouseOut);
            };
            if (this._catalog.getPurse().isVIP){
                this.setClubIcon(_SafeStr_5378);
            }
            else {
                this.setClubIcon(_SafeStr_5377);
            };
        }
        public function get visible():Boolean
        {
            return (((this._window) && (this._window.visible)));
        }
        public function dispose():void
        {
            if (this._toolbar){
                this._toolbar.extensionView.detachExtension(_SafeStr_12093);
            };
            if (this._window != null){
                this._window.dispose();
                this._window = null;
            };
            this._catalog = null;
        }
        private function setImage(_arg_1:String, _arg_2:BitmapData):void
        {
            if (this._window == null){
                return;
            };
            var _local_3:IBitmapWrapperWindow = (this._window.findChildByName(_arg_1) as IBitmapWrapperWindow);
            if (_local_3 == null){
                return;
            };
            var _local_4:BitmapData = new BitmapData(_local_3.width, _local_3.height, true, 0);
            var _local_5:int = ((_local_4.width * 0.5) - _arg_2.width);
            var _local_6:int = ((_local_4.height * 0.5) - _arg_2.height);
            _local_4.draw(_arg_2, new Matrix(2, 0, 0, 2, _local_5, _local_6));
            _local_3.bitmap = _local_4;
        }
        private function eventHandler(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            switch (_arg_2.name){
                case "open_catalog_button":
                    if (this._catalog){
                        this._catalog.openCatalogPage(CatalogPageName._SafeStr_6006, true);
                    };
                    this.dispose();
                    return;
                case "cancel_link_region":
                case "cancel_link":
                    this.dispose();
                    return;
            };
        }
        private function onMouseOver(_arg_1:WindowMouseEvent):void
        {
            this._SafeStr_12094.textColor = _SafeStr_6264;
        }
        private function onMouseOut(_arg_1:WindowMouseEvent):void
        {
            this._SafeStr_12094.textColor = _SafeStr_6263;
        }
        private function setClubIcon(_arg_1:int):void
        {
            var _local_2:IIconWindow;
            if (this._window){
                _local_2 = (this._window.findChildByName("club_icon") as IIconWindow);
                if (_local_2){
                    _local_2.style = _arg_1;
                    _local_2.invalidate();
                };
            };
        }

    }
}//package com.sulake.habbo.notifications

// _SafeStr_12093 = "_-0fy" (String#1523, DoABC#2)
// _SafeStr_12094 = "_-2C" (String#19482, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// ClubGiftNotification = "_-10I" (String#4877, DoABC#2)
// CatalogPageName = "_-mv" (String#24149, DoABC#2)
// IIconWindow = "_-1ph" (String#1764, DoABC#2)
// IBorderWindow = "_-0Br" (String#1422, DoABC#2)
// IRegionWindow = "_-dg" (String#2146, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// eventHandler = "_-34P" (String#217, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// onMouseOver = "_-21W" (String#613, DoABC#2)
// onMouseOut = "_-1ap" (String#608, DoABC#2)
// setImage = "_-1NZ" (String#603, DoABC#2)
// isVIP = "_-3K4" (String#7705, DoABC#2)
// _SafeStr_5377 = "_-0wg" (String#1581, DoABC#2)
// _SafeStr_5378 = "_-374" (String#2003, DoABC#2)
// setClubIcon = "_-1YR" (String#1707, DoABC#2)
// _SafeStr_6006 = "_-1xO" (String#18863, DoABC#2)
// _toolbar = "_-1LG" (String#93, DoABC#2)
// _SafeStr_6263 = "_-W7" (String#2122, DoABC#2)
// _SafeStr_6264 = "_-xC" (String#2222, DoABC#2)
// extensionView = "_-qR" (String#8717, DoABC#2)
// detachExtension = "_-gb" (String#8524, DoABC#2)
// attachExtension = "_-01F" (String#3587, DoABC#2)
// IHabboToolbar = "_-0Wr" (String#4245, DoABC#2)


