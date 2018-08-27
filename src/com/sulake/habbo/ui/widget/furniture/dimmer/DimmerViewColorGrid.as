
package com.sulake.habbo.ui.widget.furniture.dimmer
{
    import com.sulake.core.window.components.IItemGridWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.ColorTransform;
    import com.sulake.core.window.events.WindowMouseEvent;
    import flash.geom.Point;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.assets.BitmapDataAsset;

    public class DimmerViewColorGrid 
    {

        private var _SafeStr_13963:IItemGridWindow;
        private var _view:DimmerView;
        private var _SafeStr_13964:XML;
        private var _SafeStr_13965:BitmapData;
        private var _SafeStr_13966:BitmapData;
        private var _SafeStr_13967:BitmapData;
        private var _SafeStr_8482:IWindowContainer;

        public function DimmerViewColorGrid(_arg_1:DimmerView, _arg_2:IItemGridWindow, _arg_3:IHabboWindowManager, _arg_4:IAssetLibrary)
        {
            this._view = _arg_1;
            this._SafeStr_13963 = _arg_2;
            this.storeAssets(_arg_4);
            this.populate(_arg_3);
        }
        public function dispose():void
        {
            this._view = null;
            this._SafeStr_13963 = null;
            this._SafeStr_13964 = null;
            this._SafeStr_13965 = null;
            this._SafeStr_13966 = null;
            this._SafeStr_13967 = null;
        }
        public function setSelectedColorIndex(_arg_1:int):void
        {
            if (this._SafeStr_13963 == null){
                return;
            };
            if ((((_arg_1 < 0)) || ((_arg_1 >= this._SafeStr_13963.numGridItems)))){
                return;
            };
            this.select((this._SafeStr_13963.getGridItemAt(_arg_1) as IWindowContainer));
        }
        private function populate(_arg_1:IHabboWindowManager):void
        {
            if ((((this._view == null)) || ((this._SafeStr_13963 == null)))){
                return;
            };
            this.populateColourGrid(_arg_1);
        }
        private function select(_arg_1:IWindowContainer):void
        {
            var _local_2:IWindow;
            if (this._SafeStr_8482 != null){
                _local_2 = this._SafeStr_8482.getChildByName("chosen");
                if (_local_2 != null){
                    _local_2.visible = false;
                };
            };
            this._SafeStr_8482 = _arg_1;
            _local_2 = this._SafeStr_8482.getChildByName("chosen");
            if (_local_2 != null){
                _local_2.visible = true;
            };
        }
        private function populateColourGrid(_arg_1:IHabboWindowManager):void
        {
            var _local_2:uint;
            var _local_3:IWindowContainer;
            var _local_4:IBitmapWrapperWindow;
            var _local_5:IBitmapWrapperWindow;
            var _local_6:IBitmapWrapperWindow;
            var _local_7:uint;
            var _local_8:uint;
            var _local_9:uint;
            var _local_10:Number;
            var _local_11:Number;
            var _local_12:Number;
            var _local_13:ColorTransform;
            var _local_14:BitmapData;
            this._SafeStr_13963.destroyGridItems();
            this._SafeStr_8482 = null;
            for each (_local_2 in this.colors) {
                _local_3 = (_arg_1.buildFromXML(this._SafeStr_13964) as IWindowContainer);
                _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClick);
                _local_3.background = true;
                _local_3.color = 0xFFFFFFFF;
                _local_3.width = this._SafeStr_13965.width;
                _local_3.height = this._SafeStr_13965.height;
                this._SafeStr_13963.addGridItem(_local_3);
                _local_4 = (_local_3.findChildByTag("BG_BORDER") as IBitmapWrapperWindow);
                if (_local_4 != null){
                    _local_4.bitmap = new BitmapData(this._SafeStr_13965.width, this._SafeStr_13965.height, true, 0);
                    _local_4.bitmap.copyPixels(this._SafeStr_13965, this._SafeStr_13965.rect, new Point(0, 0));
                };
                _local_5 = (_local_3.findChildByTag("COLOR_IMAGE") as IBitmapWrapperWindow);
                if (_local_5 != null){
                    _local_5.bitmap = new BitmapData(this._SafeStr_13966.width, this._SafeStr_13966.height, true, 0);
                    _local_7 = ((_local_2 >> 16) & 0xFF);
                    _local_8 = ((_local_2 >> 8) & 0xFF);
                    _local_9 = ((_local_2 >> 0) & 0xFF);
                    _local_10 = ((_local_7 / 0xFF) * 1);
                    _local_11 = ((_local_8 / 0xFF) * 1);
                    _local_12 = ((_local_9 / 0xFF) * 1);
                    _local_13 = new ColorTransform(_local_10, _local_11, _local_12);
                    _local_14 = this._SafeStr_13966.clone();
                    _local_14.colorTransform(_local_14.rect, _local_13);
                    _local_5.bitmap.copyPixels(_local_14, _local_14.rect, new Point(0, 0));
                };
                _local_6 = (_local_3.findChildByTag("COLOR_CHOSEN") as IBitmapWrapperWindow);
                if (_local_6 != null){
                    _local_6.bitmap = new BitmapData(this._SafeStr_13967.width, this._SafeStr_13967.height, true, 0xFFFFFF);
                    _local_6.bitmap.copyPixels(this._SafeStr_13967, this._SafeStr_13967.rect, new Point(0, 0), null, null, true);
                    _local_6.visible = false;
                };
            };
        }
        private function onClick(_arg_1:WindowMouseEvent):void
        {
            var _local_2:int = this._SafeStr_13963.getGridItemIndex((_arg_1.target as IWindow));
            this.setSelectedColorIndex(_local_2);
            this._view.selectedColorIndex = _local_2;
        }
        private function storeAssets(_arg_1:IAssetLibrary):void
        {
            var _local_2:XmlAsset;
            var _local_3:BitmapDataAsset;
            if (_arg_1 == null){
                return;
            };
            _local_2 = XmlAsset(_arg_1.getAssetByName("dimmer_color_chooser_cell"));
            this._SafeStr_13964 = XML(_local_2.content);
            _local_3 = BitmapDataAsset(_arg_1.getAssetByName("dimmer_color_frame"));
            this._SafeStr_13965 = BitmapData(_local_3.content);
            _local_3 = BitmapDataAsset(_arg_1.getAssetByName("dimmer_color_button"));
            this._SafeStr_13966 = BitmapData(_local_3.content);
            _local_3 = BitmapDataAsset(_arg_1.getAssetByName("dimmer_color_selected"));
            this._SafeStr_13967 = BitmapData(_local_3.content);
        }
        private function get colors():Array
        {
            if (this._view == null){
                return ([]);
            };
            return (this._view.colors);
        }

    }
}//package com.sulake.habbo.ui.widget.furniture.dimmer

// populateColourGrid = "_-1l1" (String#5765, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// selectedColorIndex = "_-3HF" (String#22173, DoABC#2)
// setSelectedColorIndex = "_-2Ki" (String#19832, DoABC#2)
// _SafeStr_13963 = "_-1Wl" (String#17770, DoABC#2)
// _SafeStr_13964 = "_-1rw" (String#18628, DoABC#2)
// _SafeStr_13965 = "_-1of" (String#18482, DoABC#2)
// _SafeStr_13966 = "_-2WZ" (String#20306, DoABC#2)
// _SafeStr_13967 = "_-06w" (String#14320, DoABC#2)
// IItemGridWindow = "_-265" (String#1809, DoABC#2)
// DimmerView = "_-1QW" (String#5361, DoABC#2)
// DimmerViewColorGrid = "_-2WW" (String#6690, DoABC#2)
// addGridItem = "_-2vh" (String#7192, DoABC#2)
// getGridItemAt = "_-B9" (String#7890, DoABC#2)
// onClick = "_-2US" (String#368, DoABC#2)
// _SafeStr_8482 = "_-2IF" (String#618, DoABC#2)


