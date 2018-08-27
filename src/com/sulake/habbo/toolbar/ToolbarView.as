
package com.sulake.habbo.toolbar
{
    import flash.geom.Point;
    import com.sulake.core.window.IWindowContainer;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.core.utils.Map;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.localization.ILocalization;
    import com.sulake.habbo.catalog.event.CatalogEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IBorderWindow;
    import com.sulake.core.assets.IAsset;
    import flash.display.BitmapDataChannel;

    public class ToolbarView 
    {

        private static const _SafeStr_10176:Point = new Point(3, 3);
        private static const _SafeStr_13745:uint = 7433577;
        private static const _SafeStr_13746:uint = 5723213;
        private static const _SafeStr_13747:String = "_hover";
        private static const _SafeStr_13748:String = "_normal";
        private static const _SafeStr_11641:int = 5;
        private static const _SafeStr_13749:int = 600;
        private static const _SafeStr_13750:int = 80;
        private static const _SafeStr_13751:int = 74;
        private static const ICON_SPACING_NORMAL:int = 10;
        private static const _SafeStr_13752:int = -2;
        private static const _SafeStr_13753:int = 5;
        private static const _SafeStr_13754:int = 10;

        private var _window:IWindowContainer;
        private var _events:IEventDispatcher;
        private var _config:IHabboConfigurationManager;
        private var _disposed:Boolean;
        private var _toolbar:HabboToolbar;
        private var _assets:IAssetLibrary;
        private var _windowManager:IHabboWindowManager;
        private var _catalog:IHabboCatalog;
        private var _SafeStr_13755:Map;
        private var _SafeStr_13756:IWindowContainer;
        private var _SafeStr_13757:Boolean;
        private var _SafeStr_13758:Boolean;
        private var _SafeStr_13759:BitmapData;
        private var _SafeStr_13760:BitmapData;

        public function ToolbarView(_arg_1:HabboToolbar, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IConnection, _arg_5:IHabboCatalog, _arg_6:IEventDispatcher, _arg_7:IHabboConfigurationManager)
        {
            var _local_10:IWindowContainer;
            var _local_11:IBitmapWrapperWindow;
            var _local_12:XmlAsset;
            super();
            this._toolbar = _arg_1;
            this._windowManager = _arg_2;
            this._assets = _arg_3;
            this._events = _arg_6;
            this._config = _arg_7;
            this._SafeStr_13755 = new Map();
            var _local_8:XmlAsset = (_arg_3.getAssetByName("toolbar_view_with_achievements_xml") as XmlAsset);
            this._window = (_arg_2.buildFromXML((_local_8.content as XML), 2) as IWindowContainer);
            if (this._window == null){
                throw (new Error("Failed to construct window from XML!"));
            };
            this._window.position = _SafeStr_10176;
            this._window.addEventListener(WindowEvent.WE_PARENT_RESIZED, this.onParentResized);
            var _local_9:Array = new Array();
            this._window.groupChildrenWithTag("ICON_REG", _local_9, true);
            for each (_local_10 in _local_9) {
                if (_local_10){
                    _local_10.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onIconMouseEvent);
                    _local_10.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onIconHoverMouseEvent);
                    _local_10.addEventListener(WindowMouseEvent.WME_OUT, this.onIconHoverMouseEvent);
                };
            };
            _local_9 = new Array();
            this._window.groupChildrenWithTag("ICON_BMP", _local_9, true);
            for each (_local_11 in _local_9) {
                this.setIconHoverState(_local_11, _SafeStr_13748);
            };
            this.iconVisibility("QUESTS", false);
            this.iconVisibility("MEMENU", false);
            this.iconVisibility("INVENTORY", false);
            _local_12 = (_arg_3.getAssetByName("new_items_label_xml") as XmlAsset);
            this._SafeStr_13756 = (_arg_2.buildFromXML((_local_12.content as XML), 2) as IWindowContainer);
            if (this._SafeStr_13756 == null){
                throw (new Error("Failed to construct toolbar label from XML!"));
            };
            var _local_13:IWindowContainer = (this._window.findChildByName("CATALOGUE") as IWindowContainer);
            _local_13.addChild(this._SafeStr_13756);
            var _local_14:ITextWindow = (this._SafeStr_13756.findChildByName("new_textfield") as ITextWindow);
            var _local_15:ILocalization = _arg_5.localization.getLocalization("toolbar.new_additions.notification");
            if (_local_15 != null){
                _local_14.text = _local_15.value;
            };
            this._SafeStr_13756.visible = false;
            this._SafeStr_13756.x = ((_local_13.width - this._SafeStr_13756.width) - _SafeStr_11641);
            this._SafeStr_13756.y = _SafeStr_11641;
            this._SafeStr_13757 = this.isNewItemsNotificationEnabled();
            this._catalog = _arg_5;
            if (this._catalog != null){
                this.disableCatalogIcon();
                this._catalog.events.addEventListener(CatalogEvent.CATALOG_INITIALIZED, this.onCatalogEvent);
                this._catalog.events.addEventListener(CatalogEvent.CATALOG_NOT_READY, this.onCatalogEvent);
                this._catalog.events.addEventListener(CatalogEvent.CATALOG_NEW_ITEMS_SHOW, this.onCatalogEvent);
                this._catalog.events.addEventListener(CatalogEvent.CATALOG_NEW_ITEMS_HIDE, this.onCatalogEvent);
            };
            this.checkSize(true);
        }
        private function onParentResized(_arg_1:WindowEvent):void
        {
            this.checkSize();
        }
        private function checkSize(_arg_1:Boolean=false):void
        {
            var _local_6:IWindow;
            if (((!(this._window)) || (!(this._windowManager)))){
                return;
            };
            var _local_2 = (this._windowManager.getDesktop(2).height < _SafeStr_13749);
            if (((!(_arg_1)) && ((_local_2 == this._SafeStr_13758)))){
                return;
            };
            this._SafeStr_13758 = _local_2;
            var _local_3:int = ((_local_2) ? _SafeStr_13751 : _SafeStr_13750);
            var _local_4:int = ((_local_2) ? _SafeStr_13752 : ICON_SPACING_NORMAL);
            var _local_5:Array = new Array();
            this._window.groupChildrenWithTag("ICON_REG", _local_5);
            var _local_7:int;
            while (_local_7 < _local_5.length) {
                _local_6 = _local_5[_local_7];
                _local_6.height = _local_3;
                _local_6.y = (_SafeStr_13753 + (_local_7 * (_local_3 + _local_4)));
                _local_7++;
            };
            this._window.height = (_local_6.rectangle.bottom + _SafeStr_13754);
        }
        public function dispose():void
        {
            if (this._SafeStr_13755 != null){
                this._SafeStr_13755.dispose();
                this._SafeStr_13755 = null;
            };
            if (this._window != null){
                this._window.dispose();
                this._window = null;
            };
            if (this._SafeStr_13756 != null){
                this._SafeStr_13756.dispose();
                this._SafeStr_13756 = null;
            };
            this._toolbar = null;
            this._windowManager = null;
            this._assets = null;
            this._config = null;
            this._disposed = true;
            if (this._events){
                this._events = null;
            };
            if (this._catalog != null){
                this._catalog.events.removeEventListener(CatalogEvent.CATALOG_INITIALIZED, this.onCatalogEvent);
                this._catalog.events.removeEventListener(CatalogEvent.CATALOG_NOT_READY, this.onCatalogEvent);
                this._catalog.events.removeEventListener(CatalogEvent.CATALOG_NEW_ITEMS_SHOW, this.onCatalogEvent);
                this._catalog.events.removeEventListener(CatalogEvent.CATALOG_NEW_ITEMS_HIDE, this.onCatalogEvent);
                this._catalog = null;
            };
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get window():IWindow
        {
            return (this._window);
        }
        private function disableCatalogIcon():void
        {
            var _local_1:IWindowContainer = (this._window.findChildByName("CATALOGUE") as IWindowContainer);
            _local_1.blend = 0.5;
            _local_1.disable();
        }
        private function onCatalogEvent(_arg_1:CatalogEvent):void
        {
            var _local_2:IWindowContainer;
            switch (_arg_1.type){
                case CatalogEvent.CATALOG_INITIALIZED:
                    _local_2 = (this._window.findChildByName("CATALOGUE") as IWindowContainer);
                    _local_2.blend = 1;
                    _local_2.enable();
                    return;
                case CatalogEvent.CATALOG_NOT_READY:
                    this.disableCatalogIcon();
                    return;
                case CatalogEvent.CATALOG_NEW_ITEMS_SHOW:
                    if (((!((this._SafeStr_13756 == null))) && (this._SafeStr_13757))){
                        this._SafeStr_13756.visible = true;
                    };
                    return;
                case CatalogEvent.CATALOG_NEW_ITEMS_HIDE:
                    if (this._SafeStr_13756 != null){
                        this._SafeStr_13756.visible = false;
                    };
                    return;
            };
        }
        public function setToolbarState(_arg_1:String):void
        {
            var _local_3:Boolean;
            var _local_4:IWindowContainer;
            var _local_2:Array = new Array();
            this._window.groupChildrenWithTag("VIEW_STATE_TOGGLE", _local_2, true);
            switch (_arg_1){
                case HabboToolbarEnum.HTE_STATE_HOTEL_VIEW:
                    _local_3 = false;
                    break;
                case HabboToolbarEnum.HTE_STATE_ROOM_VIEW:
                    _local_3 = true;
                    break;
            };
            for each (_local_4 in _local_2) {
                if (_local_4){
                    _local_4.visible = _local_3;
                };
            };
        }
        private function iconVisibility(_arg_1:String, _arg_2:Boolean):void
        {
            var _local_3:IWindowContainer = (this._window.findChildByName(_arg_1) as IWindowContainer);
            if (_local_3){
                _local_3.visible = _arg_2;
            };
        }
        private function onIconHoverMouseEvent(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IWindowContainer = (_arg_1.target as IWindowContainer);
            if (!_local_2){
                return;
            };
            var _local_3:IBorderWindow = (_local_2.findChildByTag("ICON_BORDER") as IBorderWindow);
            var _local_4:IBitmapWrapperWindow = (_local_2.findChildByTag("ICON_BMP") as IBitmapWrapperWindow);
            switch (_arg_1.type){
                case WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER:
                    this.setIconHoverState(_local_4, _SafeStr_13747);
                    this.setIconBgHoverState(_local_3, _SafeStr_13747);
                    return;
                case WindowMouseEvent.WME_OUT:
                    this.setIconHoverState(_local_4, _SafeStr_13748);
                    this.setIconBgHoverState(_local_3, _SafeStr_13748);
                    return;
            };
        }
        private function setIconHoverState(_arg_1:IBitmapWrapperWindow, _arg_2:String):void
        {
            var _local_4:BitmapData;
            var _local_5:String;
            var _local_6:IAsset;
            if (!_arg_1){
                return;
            };
            var _local_3:String = _arg_1.name;
            if (_local_3 == "icon_me_menu"){
                _local_4 = (((_arg_2 == _SafeStr_13747)) ? this._SafeStr_13760 : this._SafeStr_13759);
            }
            else {
                _local_5 = (_local_3 + _arg_2);
                _local_6 = this._assets.getAssetByName(_local_5);
                if (!_local_6){
                    Logger.log(("Error, could not locate toolbar icon asset: " + _local_3));
                }
                else {
                    _local_4 = (_local_6.content as BitmapData);
                };
            };
            if (_local_4){
                this.drawIconBitmap(_arg_1, _local_4);
            };
        }
        private function setIconBgHoverState(_arg_1:IWindowContainer, _arg_2:String):void
        {
            if (!_arg_1){
                return;
            };
            if (_arg_2 == _SafeStr_13747){
                _arg_1.color = _SafeStr_13745;
            }
            else {
                _arg_1.color = _SafeStr_13746;
            };
        }
        private function onIconMouseEvent(_arg_1:WindowMouseEvent):void
        {
            var _local_2:String = IWindow(_arg_1.target).name;
            this._toolbar.toggleWindowVisibility(_local_2);
        }
        public function setIconBitmap(_arg_1:String, _arg_2:BitmapData):void
        {
            var _local_3:String;
            if (!_arg_2){
                return;
            };
            switch (_arg_1){
                case HabboToolbarIconEnum.MEMENU:
                    _local_3 = "icon_me_menu";
                    this.setMeMenuIconBitmaps(_arg_2);
                    break;
            };
            var _local_4:IBitmapWrapperWindow = (this._window.findChildByName(_local_3) as IBitmapWrapperWindow);
            if (_local_4){
                this.setIconHoverState(_local_4, _SafeStr_13748);
            };
        }
        public function getIconVerticalLocation(_arg_1:String):int
        {
            switch (_arg_1){
                case HabboToolbarIconEnum.NAVIGATOR:
                    return (((this._SafeStr_13758) ? 45 : 50));
                case HabboToolbarIconEnum.QUESTS:
                    return (((this._SafeStr_13758) ? 125 : 140));
            };
            return (0);
        }
        private function setMeMenuIconBitmaps(_arg_1:BitmapData):void
        {
            if (this._SafeStr_13759){
                this._SafeStr_13759.dispose();
            };
            this._SafeStr_13759 = this.addShadow(_arg_1, new Point(2, 3), 4280426782);
            if (this._SafeStr_13760){
                this._SafeStr_13760.dispose();
            };
            this._SafeStr_13760 = this.addShadow(_arg_1, new Point(4, 5), 4281150249);
            _arg_1.dispose();
        }
        private function addShadow(_arg_1:BitmapData, _arg_2:Point, _arg_3:uint):BitmapData
        {
            var _local_4:BitmapData = new BitmapData(_arg_1.width, _arg_1.height, true, 0);
            _local_4.fillRect(_local_4.rect, _arg_3);
            _local_4.copyChannel(_arg_1, _arg_1.rect, new Point(0, 0), BitmapDataChannel.ALPHA, BitmapDataChannel.ALPHA);
            var _local_5:BitmapData = new BitmapData((_arg_1.width + _arg_2.x), (_arg_1.height + _arg_2.y), true, 0);
            _local_5.copyPixels(_local_4, _local_4.rect, _arg_2);
            _local_5.copyPixels(_arg_1, _arg_1.rect, new Point(0, 0), null, null, true);
            _local_4.dispose();
            return (_local_5);
        }
        private function drawIconBitmap(_arg_1:IBitmapWrapperWindow, _arg_2:BitmapData):void
        {
            if (!_arg_1.bitmap){
                _arg_1.bitmap = new BitmapData(_arg_1.width, _arg_1.height, true, 0);
            }
            else {
                _arg_1.bitmap.fillRect(_arg_1.bitmap.rect, 0);
            };
            var _local_3:Point = new Point(int(((_arg_1.width - _arg_2.width) / 2)), int(((_arg_1.height - _arg_2.height) / 2)));
            _arg_1.bitmap.copyPixels(_arg_2, _arg_2.rect, _local_3, null, null, true);
            _arg_1.invalidate();
        }
        public function setUnseenItemCount(_arg_1:String, _arg_2:int):void
        {
            var _local_3:IWindowContainer = this.getUnseenItemCounter(_arg_1);
            if (!_local_3){
                return;
            };
            if (_arg_2 > 0){
                _local_3.visible = true;
                _local_3.findChildByName("count").caption = _arg_2.toString();
            }
            else {
                _local_3.visible = false;
            };
        }
        public function getUnseenItemCounter(_arg_1:String):IWindowContainer
        {
            var _local_3:XmlAsset;
            var _local_4:IWindowContainer;
            if (_arg_1 != HabboToolbarIconEnum.INVENTORY){
                return (null);
            };
            var _local_2:IWindowContainer = (this._SafeStr_13755.getValue(_arg_1) as IWindowContainer);
            if (!_local_2){
                _local_3 = (this._assets.getAssetByName("unseen_items_counter_xml") as XmlAsset);
                _local_2 = (this._windowManager.buildFromXML((_local_3.content as XML)) as IWindowContainer);
                _local_4 = (this._window.findChildByName("INVENTORY") as IWindowContainer);
                _local_4.addChild(_local_2);
                _local_2.x = ((_local_4.width - _local_2.width) - _SafeStr_11641);
                _local_2.y = _SafeStr_11641;
                this._SafeStr_13755.add(_arg_1, _local_2);
            };
            return (_local_2);
        }
        public function isNewItemsNotificationEnabled():Boolean
        {
            return ((this._config.getKey("toolbar.new_additions.notification.enabled", "false") == "true"));
        }

    }
}//package com.sulake.habbo.toolbar

// _SafeStr_10176 = "_-25d" (String#875, DoABC#2)
// onIconMouseEvent = "_-1ZI" (String#5547, DoABC#2)
// getIconVerticalLocation = "_-1P2" (String#5334, DoABC#2)
// _SafeStr_11641 = "_-1xb" (String#5983, DoABC#2)
// setUnseenItemCount = "_-1B5" (String#5095, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// ILocalization = "_-2EY" (String#1839, DoABC#2)
// CatalogEvent = "_-Sw" (String#23361, DoABC#2)
// HTE_STATE_HOTEL_VIEW = "_-25X" (String#19240, DoABC#2)
// HTE_STATE_ROOM_VIEW = "_-0lU" (String#15882, DoABC#2)
// _SafeStr_13745 = "_-0v4" (String#16240, DoABC#2)
// _SafeStr_13746 = "_-2hO" (String#20747, DoABC#2)
// _SafeStr_13747 = "_-0PR" (String#15040, DoABC#2)
// _SafeStr_13748 = "_-1j7" (String#18249, DoABC#2)
// _SafeStr_13749 = "_-3KK" (String#22295, DoABC#2)
// _SafeStr_13750 = "_-1T" (String#17624, DoABC#2)
// _SafeStr_13751 = "_-0Fp" (String#14675, DoABC#2)
// _SafeStr_13752 = "_-0dG" (String#15558, DoABC#2)
// _SafeStr_13753 = "_-2kU" (String#20864, DoABC#2)
// _SafeStr_13754 = "_-2nT" (String#20977, DoABC#2)
// _SafeStr_13755 = "_-2J0" (String#19766, DoABC#2)
// _SafeStr_13756 = "_-0oY" (String#15996, DoABC#2)
// _SafeStr_13757 = "_-1KY" (String#17295, DoABC#2)
// _SafeStr_13758 = "_-1if" (String#18233, DoABC#2)
// _SafeStr_13759 = "_-0S5" (String#15140, DoABC#2)
// _SafeStr_13760 = "_-1Mt" (String#17395, DoABC#2)
// onParentResized = "_-3I6" (String#22206, DoABC#2)
// onIconHoverMouseEvent = "_-1J8" (String#17242, DoABC#2)
// setIconHoverState = "_-1wB" (String#18805, DoABC#2)
// iconVisibility = "_-3-Y" (String#21484, DoABC#2)
// disableCatalogIcon = "_-2Um" (String#20228, DoABC#2)
// onCatalogEvent = "_-1TC" (String#17632, DoABC#2)
// checkSize = "_-g" (String#23890, DoABC#2)
// setToolbarState = "_-2Gw" (String#6384, DoABC#2)
// setIconBgHoverState = "_-2iQ" (String#20785, DoABC#2)
// drawIconBitmap = "_-0Eu" (String#14640, DoABC#2)
// setMeMenuIconBitmaps = "_-2Ei" (String#19593, DoABC#2)
// addShadow = "_-2ES" (String#19584, DoABC#2)
// getUnseenItemCounter = "_-d2" (String#23758, DoABC#2)
// IBorderWindow = "_-0Br" (String#1422, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// HabboToolbarEnum = "_-1RO" (String#17561, DoABC#2)
// ToolbarView = "_-16z" (String#5015, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// WE_PARENT_RESIZED = "_-0GO" (String#14697, DoABC#2)
// _toolbar = "_-1LG" (String#93, DoABC#2)
// toggleWindowVisibility = "_-0g0" (String#15672, DoABC#2)
// setIconBitmap = "_-27Q" (String#1818, DoABC#2)
// groupChildrenWithTag = "_-cU" (String#2141, DoABC#2)


