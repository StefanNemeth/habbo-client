
package com.sulake.core.window.graphics.renderer
{
    import flash.geom.Matrix;
    import com.sulake.core.window.utils.TextStyleManager;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.utils.ITextFieldContainer;
    import flash.text.TextField;
    import com.sulake.core.window.components.ITextWindow;
    import flash.text.TextFieldAutoSize;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindow;
    import flash.display.IBitmapDrawable;
    import flash.geom.Rectangle;

    public class TextSkinRenderer extends SkinRenderer 
    {

        protected var _SafeStr_4063:Matrix;

        public function TextSkinRenderer(_arg_1:String)
        {
            super(_arg_1);
            this._SafeStr_4063 = new Matrix();
        }
        override public function parse(_arg_1:IAsset, _arg_2:XMLList, _arg_3:IAssetLibrary):void
        {
            var _local_4:String = _arg_1.content.toString();
            TextStyleManager.TextStyleManager(TextStyleManager.parseCSS(_local_4));
        }
        override public function draw(_arg_1:IWindow, _arg_2:IBitmapDrawable, _arg_3:Rectangle, _arg_4:uint, _arg_5:Boolean):void
        {
            var _local_6:ITextFieldContainer;
            var _local_7:String;
            var _local_8:TextField;
            if (_arg_2 != null){
                _local_6 = ITextFieldContainer(_arg_1);
                _local_7 = ITextWindow(_arg_1).autoSize;
                _local_8 = _local_6.textField;
                this._SafeStr_4063.tx = _local_6.margins.left;
                this._SafeStr_4063.ty = _local_6.margins.top;
                if (_local_7 == TextFieldAutoSize.RIGHT){
                    this._SafeStr_4063.tx = Math.floor((_arg_1.width - _local_8.width));
                }
                else {
                    if (_local_7 == TextFieldAutoSize.CENTER){
                        this._SafeStr_4063.tx = Math.floor(((_arg_1.width / 2) - (_local_8.width / 2)));
                    };
                };
                BitmapData(_arg_2).draw(_local_8, this._SafeStr_4063, null, null, null, false);
            };
        }
        override public function isStateDrawable(_arg_1:uint):Boolean
        {
            return ((_arg_1 == 0));
        }

    }
}//package com.sulake.core.window.graphics.renderer

// ITextFieldContainer = "_-kP" (String#8609, DoABC#2)
// SkinRenderer = "_-bE" (String#8445, DoABC#2)
// TextSkinRenderer = "_-wx" (String#8824, DoABC#2)
// TextStyleManager = "_-a7" (String#23636, DoABC#2)
// isStateDrawable = "_-0hI" (String#4452, DoABC#2)
// _SafeStr_4063 = "_-09E" (String#808, DoABC#2)
// TextStyleManager = "_-11y" (String#16535, DoABC#2)


