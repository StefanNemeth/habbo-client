
package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.window.components.IItemGridWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColoursEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetMultiColoursEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import flash.geom.Point;
    import flash.geom.ColorTransform;
    import flash.geom.Rectangle;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColourIndexEvent;

    public class ColourGridCatalogWidget extends CatalogWidget implements ICatalogWidget 
    {

        private var _colours:Array;
        private var _SafeStr_10432:IItemGridWindow;
        private var _SafeStr_10433:XML;
        private var _SafeStr_9934:BitmapData;
        private var _SafeStr_9935:BitmapData;
        private var _SafeStr_9936:BitmapData;
        private var _SafeStr_8482:IWindowContainer;

        public function ColourGridCatalogWidget(_arg_1:IWindowContainer)
        {
            super(_arg_1);
        }
        override public function dispose():void
        {
            if (!this._SafeStr_10432.disposed){
                this._SafeStr_10432.destroyGridItems();
                this._SafeStr_10432.dispose();
            };
            this._SafeStr_10432 = null;
            this._SafeStr_10433 = null;
            this._SafeStr_8482 = null;
            events.removeEventListener(WidgetEvent.CWE_COLOUR_ARRAY, this.onAvailableColours);
            events.removeEventListener(WidgetEvent.CWE_MULTI_COLOUR_ARRAY, this.onAvailableMultiColours);
            super.dispose();
        }
        override public function init():Boolean
        {
            if (!super.init()){
                return (false);
            };
            this._SafeStr_10432 = (_window.findChildByName("colourGrid") as IItemGridWindow);
            var _local_1:XmlAsset = (page.viewer.catalog.assets.getAssetByName("color_chooser_cell") as XmlAsset);
            this._SafeStr_10433 = (_local_1.content as XML);
            events.addEventListener(WidgetEvent.CWE_COLOUR_ARRAY, this.onAvailableColours);
            events.addEventListener(WidgetEvent.CWE_MULTI_COLOUR_ARRAY, this.onAvailableMultiColours);
            return (true);
        }
        private function onAvailableColours(_arg_1:CatalogWidgetColoursEvent):void
        {
            var _local_2:int;
            var _local_3:BitmapDataAsset;
            var _local_4:BitmapDataAsset;
            var _local_5:BitmapDataAsset;
            this._colours = [];
            for each (_local_2 in _arg_1.colours) {
                this._colours.push([_local_2]);
            };
            _local_3 = (page.viewer.catalog.assets.getAssetByName(_arg_1.backgroundAssetName) as BitmapDataAsset);
            this._SafeStr_9934 = (_local_3.content as BitmapData);
            _local_4 = (page.viewer.catalog.assets.getAssetByName(_arg_1.colourAssetName) as BitmapDataAsset);
            this._SafeStr_9935 = (_local_4.content as BitmapData);
            _local_5 = (page.viewer.catalog.assets.getAssetByName(_arg_1.chosenColourAssetName) as BitmapDataAsset);
            this._SafeStr_9936 = (_local_5.content as BitmapData);
            this.populateColourGrid();
            this.select((this._SafeStr_10432.IItemGridWindow(_arg_1.index) as IWindowContainer));
        }
        private function onAvailableMultiColours(_arg_1:CatalogWidgetMultiColoursEvent):void
        {
            var _local_2:Array;
            var _local_3:BitmapDataAsset;
            var _local_4:BitmapDataAsset;
            var _local_5:BitmapDataAsset;
            this._colours = [];
            for each (_local_2 in _arg_1.colours) {
                this._colours.push(_local_2.slice());
            };
            _local_3 = (page.viewer.catalog.assets.getAssetByName(_arg_1.backgroundAssetName) as BitmapDataAsset);
            this._SafeStr_9934 = (_local_3.content as BitmapData);
            _local_4 = (page.viewer.catalog.assets.getAssetByName(_arg_1.colourAssetName) as BitmapDataAsset);
            this._SafeStr_9935 = (_local_4.content as BitmapData);
            _local_5 = (page.viewer.catalog.assets.getAssetByName(_arg_1.chosenColourAssetName) as BitmapDataAsset);
            this._SafeStr_9936 = (_local_5.content as BitmapData);
            this.populateColourGrid();
            this.select((this._SafeStr_10432.IItemGridWindow(0) as IWindowContainer));
        }
        private function select(_arg_1:IWindowContainer):void
        {
            var _local_2:IWindow;
            Logger.log(("[ColourGridCatalogWidget] Select: " + _arg_1));
            if (this._SafeStr_8482 != null){
                _local_2 = this._SafeStr_8482.getChildByName("chosen");
                if (_local_2 != null){
                    _local_2.visible = false;
                };
            };
            this._SafeStr_8482 = _arg_1;
            if (this._SafeStr_8482 != null){
                _local_2 = this._SafeStr_8482.getChildByName("chosen");
            };
            if (_local_2 != null){
                _local_2.visible = true;
            };
        }
        private function populateColourGrid():void
        {
            var _local_1:Array;
            var _local_2:IWindowContainer;
            var _local_3:IBitmapWrapperWindow;
            var _local_4:IBitmapWrapperWindow;
            var _local_5:IBitmapWrapperWindow;
            var _local_6:uint;
            var _local_7:uint;
            var _local_8:uint;
            var _local_9:BitmapData;
            var _local_10:BitmapData;
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            Logger.log(("[ColourGridCatalogWidget] Display colors: " + [this._colours.length, this._SafeStr_10432.numGridItems]));
            this._SafeStr_10432.destroyGridItems();
            this._SafeStr_8482 = null;
            for each (_local_1 in this._colours) {
                if (_local_1.length > 0){
                    _local_2 = (page.viewer.catalog.windowManager.buildFromXML(this._SafeStr_10433) as IWindowContainer);
                    _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClick);
                    _local_2.background = true;
                    _local_2.color = 0xFFFFFFFF;
                    _local_2.width = this._SafeStr_9934.width;
                    _local_2.height = this._SafeStr_9934.height;
                    this._SafeStr_10432.IItemGridWindow(_local_2);
                    _local_3 = (_local_2.findChildByTag("BG_BORDER") as IBitmapWrapperWindow);
                    if (_local_3 != null){
                        _local_3.bitmap = new BitmapData(this._SafeStr_9934.width, this._SafeStr_9934.height, true, 0);
                        _local_3.bitmap.copyPixels(this._SafeStr_9934, this._SafeStr_9934.rect, new Point(0, 0));
                    };
                    _local_4 = (_local_2.findChildByTag("COLOR_IMAGE") as IBitmapWrapperWindow);
                    if (_local_4 != null){
                        _local_4.bitmap = new BitmapData(this._SafeStr_9935.width, this._SafeStr_9935.height, true, 0);
                        _local_6 = 0xFF;
                        _local_7 = 0xFF;
                        _local_8 = 0xFF;
                        _local_9 = null;
                        _local_10 = null;
                        _local_11 = _local_1[0];
                        if (_local_11 >= 0){
                            _local_6 = ((_local_11 >> 16) & 0xFF);
                            _local_7 = ((_local_11 >> 8) & 0xFF);
                            _local_8 = ((_local_11 >> 0) & 0xFF);
                        };
                        _local_9 = this._SafeStr_9935.clone();
                        _local_9.colorTransform(_local_9.rect, new ColorTransform((_local_6 / 0xFF), (_local_7 / 0xFF), (_local_8 / 0xFF)));
                        if (_local_1.length > 1){
                            _local_12 = _local_1[1];
                            if (_local_12 >= 0){
                                _local_6 = ((_local_12 >> 16) & 0xFF);
                                _local_7 = ((_local_12 >> 8) & 0xFF);
                                _local_8 = ((_local_12 >> 0) & 0xFF);
                            };
                            _local_10 = this._SafeStr_9935.clone();
                            _local_10.colorTransform(_local_10.rect, new ColorTransform((_local_6 / 0xFF), (_local_7 / 0xFF), (_local_8 / 0xFF)));
                        };
                        _local_4.bitmap.copyPixels(_local_9, _local_9.rect, new Point(0, 0));
                        _local_9.dispose();
                        if (_local_10 != null){
                            _local_13 = (_local_10.width / 2);
                            _local_4.bitmap.copyPixels(_local_10, new Rectangle(_local_13, 0, (_local_10.width - _local_13), _local_10.height), new Point((_local_10.width / 2), 0));
                            _local_10.dispose();
                        };
                    };
                    _local_5 = (_local_2.findChildByTag("COLOR_CHOSEN") as IBitmapWrapperWindow);
                    if (_local_5 != null){
                        _local_5.bitmap = new BitmapData(this._SafeStr_9936.width, this._SafeStr_9936.height, true, 0xFFFFFF);
                        _local_5.bitmap.copyPixels(this._SafeStr_9936, this._SafeStr_9936.rect, new Point(0, 0), null, null, true);
                        _local_5.visible = false;
                    };
                };
            };
        }
        private function onClick(_arg_1:WindowMouseEvent):void
        {
            this.select((_arg_1.target as IWindowContainer));
            var _local_2:int = this._SafeStr_10432.getGridItemIndex((_arg_1.target as IWindow));
            events.dispatchEvent(new CatalogWidgetColourIndexEvent(_local_2));
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets

// backgroundAssetName = "_-4z" (String#22418, DoABC#2)
// colourAssetName = "_-3EE" (String#22045, DoABC#2)
// chosenColourAssetName = "_-1cN" (String#17985, DoABC#2)
// _SafeStr_10432 = "_-oE" (String#24200, DoABC#2)
// _SafeStr_10433 = "_-zm" (String#24679, DoABC#2)
// onAvailableColours = "_-2cn" (String#20557, DoABC#2)
// onAvailableMultiColours = "_-1qc" (String#18568, DoABC#2)
// populateColourGrid = "_-1l1" (String#5765, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// IItemGridWindow = "_-265" (String#1809, DoABC#2)
// CatalogWidget = "_-1pJ" (String#5844, DoABC#2)
// ICatalogWidget = "_-016" (String#3585, DoABC#2)
// ColourGridCatalogWidget = "_-Vd" (String#23478, DoABC#2)
// CatalogWidgetColourIndexEvent = "_-00G" (String#3567, DoABC#2)
// CatalogWidgetMultiColoursEvent = "_-ov" (String#8688, DoABC#2)
// CatalogWidgetColoursEvent = "_-2Vi" (String#6678, DoABC#2)
// IItemGridWindow = "_-2vh" (String#7192, DoABC#2)
// colours = "_-2hm" (String#6902, DoABC#2)
// IItemGridWindow = "_-B9" (String#7890, DoABC#2)
// onClick = "_-2US" (String#368, DoABC#2)
// _colours = "_-2V3" (String#891, DoABC#2)
// _SafeStr_8482 = "_-2IF" (String#618, DoABC#2)
// _SafeStr_9934 = "_-1LC" (String#5265, DoABC#2)
// _SafeStr_9935 = "_-0pG" (String#4618, DoABC#2)
// _SafeStr_9936 = "_-0IR" (String#3923, DoABC#2)


