
package com.sulake.core.window.graphics.renderer
{
    import flash.geom.Matrix;
    import com.sulake.core.window.utils.TextStyle;
    import flash.text.TextField;
    import com.sulake.core.window.components.TextLabelController;
    import com.sulake.core.window.utils.TextFieldCache;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindow;
    import flash.display.IBitmapDrawable;
    import flash.geom.Rectangle;

    public class LabelRenderer extends SkinRenderer 
    {

        protected var _SafeStr_4063:Matrix;
        protected var _SafeStr_4064:TextStyle;
        protected var _cachedTextField:TextField;

        public function LabelRenderer(_arg_1:String)
        {
            super(_arg_1);
            this._SafeStr_4063 = new Matrix();
        }
        override public function draw(_arg_1:IWindow, _arg_2:IBitmapDrawable, _arg_3:Rectangle, _arg_4:uint, _arg_5:Boolean):void
        {
            var _local_6:TextLabelController;
            var _local_7:TextStyle;
            var _local_8:uint;
            if (_arg_2 != null){
                _local_6 = TextLabelController(_arg_1);
                _local_7 = _local_6.textStyle;
                if (_local_7 != this._SafeStr_4064){
                    this._cachedTextField = TextFieldCache.TextFieldCache(_local_7);
                    this._SafeStr_4064 = _local_7;
                };
                this._SafeStr_4063.tx = _local_6.drawOffsetX;
                this._SafeStr_4063.ty = _local_6.drawOffsetY;
                this._cachedTextField.text = _local_6.text;
                _local_8 = uint(_local_7.color);
                this._cachedTextField.textColor = ((_local_6.hasTextColor) ? _local_6.textColor : _local_8);
                BitmapData(_arg_2).draw(this._cachedTextField, this._SafeStr_4063, null, null, null, false);
                this._cachedTextField.textColor = _local_8;
            };
        }
        override public function isStateDrawable(_arg_1:uint):Boolean
        {
            return ((_arg_1 == 0));
        }

    }
}//package com.sulake.core.window.graphics.renderer

// TextStyle = "_-0qh" (String#16074, DoABC#2)
// SkinRenderer = "_-bE" (String#8445, DoABC#2)
// LabelRenderer = "_-1NN" (String#5301, DoABC#2)
// TextLabelController = "_-2Hc" (String#6396, DoABC#2)
// TextFieldCache = "_-2LJ" (String#6466, DoABC#2)
// isStateDrawable = "_-0hI" (String#4452, DoABC#2)
// _SafeStr_4063 = "_-09E" (String#808, DoABC#2)
// _SafeStr_4064 = "_-0Xt" (String#15350, DoABC#2)
// TextFieldCache = "_-2pk" (String#21070, DoABC#2)
// drawOffsetX = "_-20-" (String#19010, DoABC#2)
// drawOffsetY = "_-2NC" (String#19931, DoABC#2)
// hasTextColor = "_-2gE" (String#20699, DoABC#2)


