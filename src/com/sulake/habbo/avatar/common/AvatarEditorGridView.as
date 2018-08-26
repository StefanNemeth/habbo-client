
package com.sulake.habbo.avatar.common
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class AvatarEditorGridView 
    {

        private const each:int = 2;

        private var _windowManager:IHabboWindowManager;
        private var _assetLibrary:IAssetLibrary;
        private var _view:IWindowContainer;
        private var _firstView:Boolean = true;
        private var _SafeStr_4830:IAvatarEditorCategoryModel;
        private var _categoryId:String;
        private var _SafeStr_9969:IItemGridWindow;
        private var _SafeStr_9970:Array;

        public function AvatarEditorGridView(_arg_1:IAvatarEditorCategoryModel, _arg_2:String, _arg_3:IHabboWindowManager, _arg_4:IAssetLibrary)
        {
            this._SafeStr_4830 = _arg_1;
            this._categoryId = _arg_2;
            this._assetLibrary = _arg_4;
            this._windowManager = _arg_3;
            var _local_5:XmlAsset = (this._assetLibrary.getAssetByName("AvatarEditorGrid") as XmlAsset);
            this._view = IWindowContainer(this._windowManager.buildFromXML((_local_5.content as XML)));
            if (this._view != null){
                this._SafeStr_9969 = (this._view.findChildByName("part_thumbs") as IItemGridWindow);
                this._SafeStr_9970 = new Array();
                this._SafeStr_9970.push((this._view.findChildByName("palette0") as IItemGridWindow));
                this._SafeStr_9970.push((this._view.findChildByName("palette1") as IItemGridWindow));
            };
        }
        public function dispose():void
        {
            var _local_1:IItemGridWindow;
            if (this._SafeStr_9969){
                this._SafeStr_9969.dispose();
                this._SafeStr_9969 = null;
            };
            if (this._SafeStr_9970){
                for each (_local_1 in this._SafeStr_9970) {
                    if (_local_1 != null){
                        _local_1.dispose();
                        _local_1 = null;
                    };
                };
                this._SafeStr_9970 = null;
            };
            this._SafeStr_4830 = null;
            if (this._view){
                this._view.dispose();
                this._view = null;
            };
            this._windowManager = null;
            this._assetLibrary = null;
        }
        public function get window():IWindowContainer
        {
            if (this._view == null){
                return (null);
            };
            if (this._view.disposed){
                return (null);
            };
            return (this._view);
        }
        public function AvatarEditorGridView():void
        {
            var _local_2:AvatarEditorGridPartItem;
            var _local_3:int;
            var _local_4:Array;
            var _local_5:IItemGridWindow;
            var _local_6:AvatarEditorGridColorItem;
            var _local_1:CategoryData = this._SafeStr_4830.getCategoryData(this._categoryId);
            if (!_local_1){
                return;
            };
            this._SafeStr_9969.IItemGridWindow();
            for each (_local_2 in _local_1.parts) {
                if (_local_2){
                    this._SafeStr_9969.IItemGridWindow(_local_2.view);
                    _local_2.view.procedure = this.partEventProc;
                    if (_local_2.isSelected){
                        this.showPalettes(_local_2.colorLayerCount);
                    };
                };
            };
            _local_3 = 0;
            while (_local_3 < this.each) {
                _local_4 = _local_1.getPalette(_local_3);
                _local_5 = (this._SafeStr_9970[_local_3] as IItemGridWindow);
                if (!((!(_local_4)) || (!(_local_5)))){
                    for each (_local_6 in _local_4) {
                        _local_5.IItemGridWindow(_local_6.view);
                        _local_6.view.procedure = this.paletteEventProc;
                    };
                };
                _local_3++;
            };
            this._firstView = false;
        }
        public function showPalettes(_arg_1:int):void
        {
            var _local_2:IWindowContainer = (this._view.findChildByName("palette_container0") as IWindowContainer);
            var _local_3:IWindowContainer = (this._view.findChildByName("palette_container1") as IWindowContainer);
            if (((!(_local_2)) || (!(_local_3)))){
                return;
            };
            var _local_4:ITextWindow = (this._view.findChildByName("palette_desc_0") as ITextWindow);
            var _local_5:ITextWindow = (this._view.findChildByName("palette_desc_1") as ITextWindow);
            if (((!(_local_4)) || (!(_local_5)))){
                return;
            };
            var _local_6 = 318;
            var _local_7 = 156;
            if (_arg_1 <= 1){
                _local_2.width = _local_6;
                _local_3.visible = false;
                _local_4.visible = false;
                _local_5.visible = false;
            }
            else {
                _local_2.width = _local_7;
                _local_3.width = _local_7;
                _local_3.visible = true;
                _local_4.visible = true;
                _local_5.visible = true;
            };
        }
        public function get firstView():Boolean
        {
            return (this._firstView);
        }
        public function updatePart(_arg_1:int, _arg_2:IWindowContainer):void
        {
            var _local_3:IWindow = this._SafeStr_9969.IItemGridWindow(_arg_1);
            if (!_local_3){
                return;
            };
            _local_3 = _arg_2;
        }
        private function partEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:int;
            if (_arg_1.type == WindowMouseEvent.WME_DOWN){
                _local_3 = this._SafeStr_9969.getGridItemIndex(_arg_1.window);
                this._SafeStr_4830._SafeStr_4847(this._categoryId, _local_3);
            };
        }
        private function paletteEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:int;
            var _local_4:IItemGridWindow;
            var _local_5:int;
            var _local_6:IWindow;
            var _local_7:int;
            if (_arg_1.type == WindowMouseEvent.WME_DOWN){
                _local_6 = _arg_1.window;
                _local_7 = 0;
                while (_local_7 < this.each) {
                    if (this._SafeStr_9970.length > _local_7){
                        _local_4 = (this._SafeStr_9970[_local_7] as IItemGridWindow);
                        _local_5 = _local_4.getGridItemIndex(_local_6);
                        if (_local_5 > -1){
                            this._SafeStr_4830.selectColor(this._categoryId, _local_5, _local_7);
                            return;
                        };
                    };
                    _local_7++;
                };
            };
        }

    }
}//package com.sulake.habbo.avatar.common

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IItemGridWindow = "_-265" (String#1809, DoABC#2)
// IAvatarEditorCategoryModel = "_-1mx" (String#5798, DoABC#2)
// AvatarEditorGridColorItem = "_-14G" (String#4963, DoABC#2)
// CategoryData = "_-2jI" (String#6943, DoABC#2)
// AvatarEditorGridPartItem = "_-xW" (String#8833, DoABC#2)
// AvatarEditorGridView = "_-28U" (String#6213, DoABC#2)
// WME_DOWN = "_-hL" (String#23944, DoABC#2)
// _SafeStr_4830 = "_-0XB" (String#112, DoABC#2)
// IItemGridWindow = "_-1Bp" (String#5106, DoABC#2)
// IItemGridWindow = "_-2vh" (String#7192, DoABC#2)
// showPalettes = "_-3AL" (String#7520, DoABC#2)
// getCategoryData = "_-2rW" (String#7114, DoABC#2)
// _SafeStr_4847 = "continue" (String#9328, DoABC#2)
// _categoryId = "_-1If" (String#186, DoABC#2)
// AvatarEditorGridView = "_-ME" (String#23093, DoABC#2)
// selectColor = "_-2lm" (String#6999, DoABC#2)
// IItemGridWindow = "_-B9" (String#7890, DoABC#2)
// colorLayerCount = "_-0xO" (String#16327, DoABC#2)
// firstView = "_-L" (String#23045, DoABC#2)
// _firstView = "_-2C1" (String#19483, DoABC#2)
// _SafeStr_9969 = "_-5O" (String#22439, DoABC#2)
// _SafeStr_9970 = "_-2Nl" (String#19955, DoABC#2)
// partEventProc = "_-2Q5" (String#20047, DoABC#2)
// paletteEventProc = "_-rX" (String#24340, DoABC#2)
// updatePart = "_-1C9" (String#5112, DoABC#2)


