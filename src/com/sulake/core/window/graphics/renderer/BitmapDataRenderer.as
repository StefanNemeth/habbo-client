
package com.sulake.core.window.graphics.renderer
{
    import flash.geom.Matrix;
    import flash.geom.ColorTransform;
    import com.sulake.core.window.utils.IBitmapDataContainer;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindow;
    import flash.display.IBitmapDrawable;
    import flash.geom.Rectangle;

    public class BitmapDataRenderer extends SkinRenderer 
    {

        private var _SafeStr_4063:Matrix;
        private var _colorTransform:ColorTransform;

        public function BitmapDataRenderer(_arg_1:String)
        {
            super(_arg_1);
            this._SafeStr_4063 = new Matrix();
            this._colorTransform = new ColorTransform();
        }
        override public function draw(_arg_1:IWindow, _arg_2:IBitmapDrawable, _arg_3:Rectangle, _arg_4:uint, _arg_5:Boolean):void
        {
            var _local_6:BitmapData = IBitmapDataContainer(_arg_1).bitmapData;
            var _local_7:BitmapData = BitmapData(_arg_2);
            if (((!((_arg_2 == null))) && (!((_local_6 == null))))){
                this._SafeStr_4063.a = (_arg_1.width / _local_6.width);
                this._SafeStr_4063.d = (_arg_1.height / _local_6.height);
                this._colorTransform.redMultiplier = (((_arg_1.color & 0xFF0000) >> 16) / 0xFF);
                this._colorTransform.greenMultiplier = (((_arg_1.color & 0xFF00) >> 8) / 0xFF);
                this._colorTransform.blueMultiplier = ((_arg_1.color & 0xFF) / 0xFF);
                _local_7.lock();
                _local_7.draw(_local_6, this._SafeStr_4063, this._colorTransform, null, null, false);
                _local_7.unlock();
            };
        }
        override public function isStateDrawable(_arg_1:uint):Boolean
        {
            return ((_arg_1 == 0));
        }

    }
}//package com.sulake.core.window.graphics.renderer

// SkinRenderer = "_-bE" (String#8445, DoABC#2)
// IBitmapDataContainer = "_-Wa" (String#8336, DoABC#2)
// isStateDrawable = "_-0hI" (String#4452, DoABC#2)
// _SafeStr_4063 = "_-09E" (String#808, DoABC#2)
// _colorTransform = "_-0yf" (String#300, DoABC#2)


