
package com.sulake.habbo.avatar.common
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Dictionary;
    import com.sulake.core.assets.IAsset;
    import flash.display.BitmapData;
    import com.sulake.core.window.utils.PropertyStruct;
    import flash.geom.Point;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.avatar.AvatarEditorView;
    import com.sulake.core.window.components.IBitmapWrapperWindow;

    public class CategoryBaseView 
    {

        protected var _windowManager:IHabboWindowManager;
        protected var _assetLibrary:IAssetLibrary;
        protected var _window:IWindowContainer;
        protected var _SafeStr_5402:Dictionary;
        protected var _SafeStr_5400:String = "";
        protected var _SafeStr_6466:String = "";
        protected var _modelController:IAvatarEditorCategoryModel;
        protected var _isInitialized:Boolean;

        public function CategoryBaseView(_arg_1:IHabboWindowManager, _arg_2:IAssetLibrary, _arg_3:IAvatarEditorCategoryModel)
        {
            this._assetLibrary = _arg_2;
            this._windowManager = _arg_1;
            this._modelController = _arg_3;
        }
        public function dispose():void
        {
            var _local_1:AvatarEditorGridView;
            if (this._SafeStr_5402){
                for each (_local_1 in this._SafeStr_5402) {
                    _local_1.dispose();
                    _local_1 = null;
                };
                this._SafeStr_5402 = null;
            };
            if (this._window){
                this._window.dispose();
                this._window = null;
            };
            this._assetLibrary = null;
            this._windowManager = null;
            this._modelController = null;
            this._isInitialized = false;
        }
        public function init():void
        {
        }
        public function reset():void
        {
            var _local_1:AvatarEditorGridView;
            for each (_local_1 in this._SafeStr_5402) {
                _local_1.dispose();
            };
            this._SafeStr_5402 = null;
            this._SafeStr_5400 = "";
            this._SafeStr_6466 = "";
            this._isInitialized = false;
        }
        public function getWindowContainer():IWindowContainer
        {
            if (!this._isInitialized){
                this.init();
            };
            return (this._window);
        }
        public function showPalettes(_arg_1:String, _arg_2:int):void
        {
            if (!this._SafeStr_5402){
                return;
            };
            if (!this._isInitialized){
                this.init();
            };
            var _local_3:AvatarEditorGridView = (this._SafeStr_5402[_arg_1] as AvatarEditorGridView);
            if (!_local_3){
                return;
            };
            _local_3.showPalettes(_arg_2);
        }
        protected function setElementImage(bmpWindow:IBitmapWrapperWindow, active:Boolean):void
        {
            var asset:IAsset;
            var assetName:String;
            var src:BitmapData;
            if (!this._assetLibrary){
                return;
            };
            if (bmpWindow == null){
                return;
            };
            var result:Array = bmpWindow.properties.filter(function (_arg_1:*, _arg_2:int, _arg_3:Array):Boolean
            {
                return ((PropertyStruct(_arg_1).key == "bitmap_asset_name"));
            });
            var offset:Point = new Point();
            if (((result) && (result.length))){
                assetName = (PropertyStruct(result[0]).value as String);
                if (active){
                    assetName = assetName.replace("_on", "");
                };
                asset = this._assetLibrary.getAssetByName(assetName);
                if (((asset) && ((asset is BitmapDataAsset)))){
                    bmpWindow.bitmap = new BitmapData(bmpWindow.width, bmpWindow.height, false, AvatarEditorView._SafeStr_9966);
                    src = (asset.content as BitmapData);
                    offset.x = ((bmpWindow.width - src.width) / 2);
                    offset.y = ((bmpWindow.height - src.height) / 2);
                    bmpWindow.bitmap.copyPixels(src, src.rect, offset);
                };
            };
        }
        protected function updateGridView():void
        {
            var _local_1:IWindowContainer = (this._window.findChildByName("grid_container") as IWindowContainer);
            if (_local_1 == null){
                return;
            };
            _local_1.removeChildAt(0);
            var _local_2:AvatarEditorGridView = this._SafeStr_5402[this._SafeStr_5400];
            if (_local_2 == null){
                return;
            };
            var _local_3:IWindowContainer = _local_2.window;
            if (_local_3 == null){
                return;
            };
            _local_1.visible = true;
            _local_1.addChild(_local_3);
            _local_1.invalidate();
            if (_local_2.firstView){
                _local_2.initFromList();
            };
        }
        protected function activateTab(_arg_1:String):void
        {
            var _local_3:IBitmapWrapperWindow;
            if (!this._window){
                return;
            };
            var _local_2:IWindowContainer = (this._window.findChildByName(_arg_1) as IWindowContainer);
            if (_local_2){
                _local_3 = (_local_2.findChildByTag("bitmap") as IBitmapWrapperWindow);
                this.setElementImage(_local_3, true);
            };
        }
        protected function inactivateTab(_arg_1:String):void
        {
            var _local_3:IBitmapWrapperWindow;
            if (!this._window){
                return;
            };
            var _local_2:IWindowContainer = (this._window.findChildByName(_arg_1) as IWindowContainer);
            if (_local_2){
                _local_3 = (_local_2.findChildByTag("bitmap") as IBitmapWrapperWindow);
                this.setElementImage(_local_3, false);
            };
        }
        protected function attachImages():void
        {
            var _local_2:IBitmapWrapperWindow;
            if (!this._window){
                return;
            };
            var _local_1:Array = new Array();
            this._window.groupChildrenWithTag("bitmap", _local_1, true);
            for each (_local_2 in _local_1) {
                this.setElementImage(_local_2, false);
            };
        }

    }
}//package com.sulake.habbo.avatar.common

// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// PropertyStruct = "_-t6" (String#24410, DoABC#2)
// IAvatarEditorCategoryModel = "_-1mx" (String#5798, DoABC#2)
// AvatarEditorView = "_-06P" (String#3690, DoABC#2)
// CategoryBaseView = "_-2Mf" (String#6492, DoABC#2)
// AvatarEditorGridView = "_-28U" (String#6213, DoABC#2)
// setElementImage = "_-1IU" (String#302, DoABC#2)
// _modelController = "_-0XB" (String#112, DoABC#2)
// getWindowContainer = "_-v8" (String#313, DoABC#2)
// showPalettes = "_-3AL" (String#7520, DoABC#2)
// _SafeStr_5400 = "_-1zp" (String#18961, DoABC#2)
// _SafeStr_5402 = "_-0Lb" (String#14897, DoABC#2)
// initFromList = "_-ME" (String#23093, DoABC#2)
// updateGridView = "_-BT" (String#22671, DoABC#2)
// attachImages = "_-2jH" (String#6942, DoABC#2)
// activateTab = "_-339" (String#21625, DoABC#2)
// inactivateTab = "_-SE" (String#23334, DoABC#2)
// _SafeStr_6466 = "_-1DU" (String#17001, DoABC#2)
// groupChildrenWithTag = "_-cU" (String#2141, DoABC#2)
// _SafeStr_9966 = "_-T9" (String#23371, DoABC#2)
// firstView = "_-L" (String#23045, DoABC#2)


