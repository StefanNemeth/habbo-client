
package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.utils.IBitmapDataContainer;
    import flash.display.BitmapData;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.graphics.WindowRedrawFlag;
    import com.sulake.core.window.utils.PropertyDefaults;
    import com.sulake.core.window.utils.PropertyStruct;

    public class BitmapWrapperController extends WindowController implements IBitmapWrapperWindow, IBitmapDataContainer 
    {

        protected var _bitmapData:BitmapData;
        protected var _disposesBitmap:Boolean = true;
        protected var _bitmapAssetName:String;

        public function BitmapWrapperController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function=null, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }
        public function get bitmap():BitmapData
        {
            return (this._bitmapData);
        }
        public function set bitmap(_arg_1:BitmapData):void
        {
            if (((((this._disposesBitmap) && (this._bitmapData))) && (!((_arg_1 == this._bitmapData))))){
                this._bitmapData.dispose();
            };
            this._bitmapData = _arg_1;
            _context.invalidate(this, _rectangle, WindowRedrawFlag._SafeStr_9133);
        }
        public function get bitmapData():BitmapData
        {
            return (this._bitmapData);
        }
        public function set bitmapData(_arg_1:BitmapData):void
        {
            this.bitmap = _arg_1;
        }
        public function get bitmapAssetName():String
        {
            return (this._bitmapAssetName);
        }
        public function set bitmapAssetName(_arg_1:String):void
        {
            this._bitmapAssetName = _arg_1;
        }
        public function get disposesBitmap():Boolean
        {
            return (this._disposesBitmap);
        }
        public function set disposesBitmap(_arg_1:Boolean):void
        {
            this._disposesBitmap = _arg_1;
        }
        override public function clone():IWindow
        {
            var _local_1:BitmapWrapperController = (super.clone() as BitmapWrapperController);
            _local_1._bitmapData = this._bitmapData;
            _local_1._disposesBitmap = this._disposesBitmap;
            _local_1._bitmapAssetName = this._bitmapAssetName;
            return (_local_1);
        }
        override public function dispose():void
        {
            if (this._bitmapData){
                if (this._disposesBitmap){
                    this._bitmapData.dispose();
                };
                this._bitmapData = null;
            };
            super.dispose();
        }
        override public function get properties():Array
        {
            var _local_1:Array = super.properties;
            if (this._disposesBitmap != PropertyDefaults._SafeStr_9285){
                _local_1.push(new PropertyStruct(PropertyDefaults._SafeStr_9286, this._disposesBitmap, PropertyStruct._SafeStr_8996, true));
            }
            else {
                _local_1.push(PropertyDefaults._SafeStr_9287);
            };
            if (this._bitmapAssetName != PropertyDefaults._SafeStr_9288){
                _local_1.push(new PropertyStruct(PropertyDefaults._SafeStr_9289, this._bitmapAssetName, PropertyStruct._SafeStr_8998, true));
            }
            else {
                _local_1.push(PropertyDefaults._SafeStr_9290);
            };
            return (_local_1);
        }
        override public function set properties(_arg_1:Array):void
        {
            var _local_2:PropertyStruct;
            for each (_local_2 in _arg_1) {
                switch (_local_2.key){
                    case PropertyDefaults._SafeStr_9286:
                        this._disposesBitmap = (_local_2.value as Boolean);
                        break;
                    case PropertyDefaults._SafeStr_9289:
                        this._bitmapAssetName = (_local_2.value as String);
                        break;
                };
            };
            super.properties = _arg_1;
        }

    }
}//package com.sulake.core.window.components

// WindowContext = "_-2K8" (String#6447, DoABC#2)
// PropertyStruct = "_-t6" (String#24410, DoABC#2)
// PropertyDefaults = "_-3Dd" (String#22019, DoABC#2)
// IBitmapDataContainer = "_-Wa" (String#8336, DoABC#2)
// BitmapWrapperController = "_-2Vt" (String#6681, DoABC#2)
// disposesBitmap = "_-03U" (String#3637, DoABC#2)
// _SafeStr_8996 = "_-0gH" (String#15685, DoABC#2)
// _SafeStr_8998 = "_-1lW" (String#18353, DoABC#2)
// _rectangle = "_-0-q" (String#3560, DoABC#2)
// _SafeStr_9133 = "_-2xy" (String#21391, DoABC#2)
// _disposesBitmap = "_-14w" (String#16650, DoABC#2)
// _bitmapAssetName = "_-rT" (String#24337, DoABC#2)
// bitmapAssetName = "_-1XS" (String#5507, DoABC#2)
// _SafeStr_9285 = "_-Mq" (String#23120, DoABC#2)
// _SafeStr_9286 = "_-0al" (String#15465, DoABC#2)
// _SafeStr_9287 = "_-0AP" (String#14464, DoABC#2)
// _SafeStr_9288 = "_-1j" (String#18244, DoABC#2)
// _SafeStr_9289 = "_-0KD" (String#14851, DoABC#2)
// _SafeStr_9290 = "_-q6" (String#24276, DoABC#2)


