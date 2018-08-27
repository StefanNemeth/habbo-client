
package com.sulake.habbo.catalog.navigation
{
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.communication.messages.incoming.catalog.NodeData;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.window.enum.HabboIconType;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.geom.ColorTransform;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;

    public class CatalogNodeRenderable extends CatalogNode 
    {

        private static const _SafeStr_10318:Number = 4285716709;
        private static var _listSubItemWindowLayout:XML;
        private static var _SafeStr_10319:XML;
        private static var _SafeStr_10320:XML;

        private var _SafeStr_10321:Number = 0xFFFFFFFF;
        private var _icon:BitmapData;
        private var _window:IWindowContainer;
        private var _SafeStr_10322:IWindowContainer;
        private var _content:IItemListWindow;
        private var _isOpen:Boolean = false;

        public function CatalogNodeRenderable(_arg_1:ICatalogNavigator, _arg_2:NodeData, _arg_3:int)
        {
            var _local_4:XmlAsset;
            super(_arg_1, _arg_2, _arg_3);
            if (_listSubItemWindowLayout == null){
                _local_4 = (_arg_1.catalog.assets.getAssetByName("navigation_list_subitem") as XmlAsset);
                _listSubItemWindowLayout = (_local_4.content as XML);
            };
            if (_SafeStr_10319 == null){
                _local_4 = (_arg_1.catalog.assets.getAssetByName("navigation_list_item") as XmlAsset);
                _SafeStr_10319 = (_local_4.content as XML);
            };
            if (_SafeStr_10320 == null){
                _local_4 = (_arg_1.catalog.assets.getAssetByName("list_item_list") as XmlAsset);
                _SafeStr_10320 = (_local_4.content as XML);
            };
        }
        public function set icon(_arg_1:BitmapData):void
        {
            this._icon = _arg_1;
        }
        public function get window():IWindowContainer
        {
            return (this._window);
        }
        override public function get icon():BitmapData
        {
            return (this._icon);
        }
        override public function get isOpen():Boolean
        {
            return (this._isOpen);
        }
        override public function dispose():void
        {
            if (this._isOpen){
                this.close();
                this.deActivate();
            };
            this._icon = null;
            this._window = null;
            this._SafeStr_10322 = null;
            this._content = null;
            super.dispose();
        }
        public function addToList(_arg_1:IItemListWindow):void
        {
            if (this._window == null){
                this.createWindow();
            };
            _arg_1.addListItem(this._window);
            if (isBranch){
                if (this._content == null){
                    this.createList();
                };
                _arg_1.addListItem(this._content);
            };
        }
        public function removeFromList(_arg_1:IItemListWindow):void
        {
            _arg_1.removeListItem(this._window);
            if (isBranch){
                _arg_1.removeListItem(this._content);
            };
        }
        override public function activate():void
        {
            var _local_1:IWindow = this._window.findChildByTag("SELECTION_COLOR");
            if (_local_1 != null){
                if (this._SafeStr_10321 == 0xFFFFFFFF){
                    this._SafeStr_10321 = _local_1.color;
                };
                _local_1.color = _SafeStr_10318;
            };
        }
        override public function deActivate():void
        {
            var _local_1:IWindow = this._window.findChildByTag("SELECTION_COLOR");
            if (_local_1 != null){
                _local_1.color = this._SafeStr_10321;
            };
        }
        override public function open():void
        {
            var _local_1:IWindow;
            this.showChildren();
            this._isOpen = true;
            if (isBranch){
                _local_1 = this._window.findChildByTag("DOWNBTN");
                if (_local_1 != null){
                    _local_1.style = HabboIconType._SafeStr_7422;
                };
            };
        }
        override public function close():void
        {
            var _local_1:IWindow;
            this.removeChildren();
            this._isOpen = false;
            if (isBranch){
                _local_1 = this._window.findChildByTag("DOWNBTN");
                if (_local_1 != null){
                    _local_1.style = HabboIconType._SafeStr_7420;
                };
            };
        }
        private function showChildren():void
        {
            var _local_1:ICatalogNode;
            if (this._content == null){
                this.createList();
            };
            for each (_local_1 in children) {
                if (_local_1.isNavigateable){
                    (_local_1 as CatalogNodeRenderable).addToList(this._content);
                };
            };
            if (this._content != null){
                this._content.visible = true;
                this._content.height = (this._content.numListItems * 21);
            };
        }
        private function removeChildren():void
        {
            var _local_1:ICatalogNode;
            for each (_local_1 in children) {
                if (_local_1.isNavigateable){
                    (_local_1 as CatalogNodeRenderable).removeFromList(this._content);
                };
            };
            if (this._content != null){
                this._content.height = 0;
                this._content.visible = false;
                this._content.x = 0;
            };
        }
        private function createList():void
        {
            this._content = (navigator.catalog.windowManager.buildFromXML(_SafeStr_10320) as IItemListWindow);
            if (this._content == null){
                throw (new Error("Failed to construct list-item-list from XML!"));
            };
            this.removeChildren();
        }
        private function createWindow():void
        {
            if (depth == 1){
                this._window = (navigator.catalog.windowManager.buildFromXML(_SafeStr_10319) as IWindowContainer);
            }
            else {
                this._window = (navigator.catalog.windowManager.buildFromXML(_listSubItemWindowLayout) as IWindowContainer);
            };
            if (this._window == null){
                throw (new Error("Failed to construct window from XML!"));
            };
            var _local_1:ITextWindow = (this._window.findChildByTag("ITEM_TITLE") as ITextWindow);
            var _local_2:IWindow = this._window.findChildByTag("DOWNBTN");
            if (_local_1 != null){
                _local_1.caption = localization;
            };
            if (isLeaf){
                if (_local_2 != null){
                    _local_2.visible = false;
                };
            };
            this.setElementImage("iconBackgroundBitmap", "icon_bg_img", true, color);
            this.initIcon();
            this._window.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onButtonClicked);
            if (_local_2 != null){
                _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onButtonClicked);
            };
        }
        private function getLocalizationKey(_arg_1:String, _arg_2:String=""):String
        {
            var _local_3:ICoreLocalizationManager = (navigator.catalog as HabboCatalog).localization;
            if (_local_3 == null){
                return (_arg_2);
            };
            return (_local_3.getKey(_arg_1, _arg_2));
        }
        private function onButtonClicked(_arg_1:WindowMouseEvent):void
        {
            navigator.activateNode(this);
        }
        private function initIcon():void
        {
            var _local_1:String = "icon";
            var _local_2:String = iconName;
            if (_local_2 == ""){
                return;
            };
            if (navigator.catalog.assets.hasAsset(_local_2)){
                this.setElementImage(_local_1, _local_2);
            }
            else {
                this.retrieveIconImage(_local_2);
            };
        }
        private function setElementImage(_arg_1:String, _arg_2:String, _arg_3:Boolean=true, _arg_4:uint=0):void
        {
            var _local_6:BitmapDataAsset;
            var _local_7:BitmapData;
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_13:Number;
            var _local_14:Number;
            var _local_15:Number;
            var _local_16:ColorTransform;
            if (this._window == null){
                return;
            };
            var _local_5:IBitmapWrapperWindow = (this._window.findChildByName(_arg_1) as IBitmapWrapperWindow);
            if (_local_5 != null){
                _local_6 = (navigator.catalog.assets.getAssetByName(_arg_2) as BitmapDataAsset);
                if (_local_6 == null){
                    return;
                };
                _local_7 = (_local_6.content as BitmapData);
                _local_5.bitmap = new BitmapData(_local_5.width, _local_5.height, true, 0);
                _local_8 = 0;
                _local_9 = 0;
                if (_arg_3){
                    _local_8 = ((_local_5.width - _local_7.width) / 2);
                    _local_9 = ((_local_5.height - _local_7.height) / 2);
                };
                if (_arg_4 > 0){
                    _local_7 = _local_7.clone();
                    _local_10 = ((_arg_4 >> 16) & 0xFF);
                    _local_11 = ((_arg_4 >> 8) & 0xFF);
                    _local_12 = ((_arg_4 >> 0) & 0xFF);
                    _local_13 = ((_local_10 / 0xFF) * 1);
                    _local_14 = ((_local_11 / 0xFF) * 1);
                    _local_15 = ((_local_12 / 0xFF) * 1);
                    _local_16 = new ColorTransform(_local_13, _local_14, _local_15);
                    _local_7.colorTransform(_local_7.rect, _local_16);
                };
                _local_5.bitmap.copyPixels(_local_7, _local_7.rect, new Point(_local_8, _local_9));
            }
            else {
                Logger.log(("[CatalogNodeRenderable] Could not find element: " + _arg_1));
            };
        }
        private function retrieveIconImage(_arg_1:String):void
        {
            if (_arg_1 == ""){
                return;
            };
            var _local_2:String = navigator.catalog.configuration.getKey("image.library.catalogue.url");
            var _local_3 = ((_local_2 + _arg_1) + ".png");
            var _local_4:URLRequest = new URLRequest(_local_3);
            var _local_5:AssetLoaderStruct = navigator.catalog.assets.loadAssetFromFile(_arg_1, _local_4, "image/gif");
            _local_5.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.onIconImageReady);
        }
        private function onIconImageReady(_arg_1:AssetLoaderEvent):void
        {
            var _local_3:String;
            var _local_2:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            if (_local_2 != null){
                _local_3 = _local_2.assetName;
                this.setElementImage("icon", _local_3);
            };
        }

    }
}//package com.sulake.habbo.catalog.navigation

// isNavigateable = "_-1Ts" (String#5429, DoABC#2)
// addToList = "_-24g" (String#19209, DoABC#2)
// isBranch = "_-0o2" (String#4593, DoABC#2)
// isLeaf = "_-2Tk" (String#6641, DoABC#2)
// _SafeStr_10318 = "_-0xl" (String#16344, DoABC#2)
// _SafeStr_10319 = "_-7O" (String#22517, DoABC#2)
// _SafeStr_10320 = "_-0bI" (String#15488, DoABC#2)
// _SafeStr_10321 = "_-0fd" (String#15657, DoABC#2)
// _SafeStr_10322 = "_-1kD" (String#18297, DoABC#2)
// createList = "_-1CJ" (String#16956, DoABC#2)
// removeFromList = "_-2pA" (String#21047, DoABC#2)
// showChildren = "_-0l0" (String#4522, DoABC#2)
// removeChildren = "_-om" (String#24227, DoABC#2)
// getLocalizationKey = "_-3B0" (String#21922, DoABC#2)
// retrieveIconImage = "_-1A1" (String#16859, DoABC#2)
// onIconImageReady = "_-3T" (String#22355, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// ICatalogNavigator = "_-24D" (String#6126, DoABC#2)
// HabboIconType = "_-23Y" (String#6115, DoABC#2)
// NodeData = "_-02P" (String#3615, DoABC#2)
// ICatalogNode = "_-0Td" (String#4172, DoABC#2)
// CatalogNode = "_-148" (String#4959, DoABC#2)
// CatalogNodeRenderable = "_-20S" (String#6056, DoABC#2)
// onButtonClicked = "_-2k0" (String#247, DoABC#2)
// setElementImage = "_-1IU" (String#302, DoABC#2)
// _content = "_-1Q8" (String#74, DoABC#2)
// isOpen = "_-2i4" (String#897, DoABC#2)
// initIcon = "_-0Fm" (String#1437, DoABC#2)
// _SafeStr_7420 = "_-24I" (String#19189, DoABC#2)
// _SafeStr_7422 = "_-075" (String#14328, DoABC#2)
// iconName = "_-1Xn" (String#5513, DoABC#2)
// _isOpen = "_-by" (String#2139, DoABC#2)
// AssetLoaderStruct = "_-0R2" (String#4112, DoABC#2)


