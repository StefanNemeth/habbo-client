
package com.sulake.habbo.friendbar.view.utils
{
    import com.sulake.core.runtime.IDisposable;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFieldAutoSize;
    import com.sulake.core.window.components.ITextWindow;

    public class TextCropper implements IDisposable 
    {

        private var _disposed:Boolean = false;
        private var _SafeStr_5284:TextField;
        private var _SafeStr_5285:TextFormat;
        private var _SafeStr_5286:String = "...";
        private var _SafeStr_5287:int = 20;

        public function TextCropper()
        {
            this._SafeStr_5284 = new TextField();
            this._SafeStr_5284.autoSize = TextFieldAutoSize.LEFT;
            this._SafeStr_5285 = this._SafeStr_5284.defaultTextFormat;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            if (!this._disposed){
                this._SafeStr_5284 = null;
                this._disposed = true;
            };
        }
        public function crop(_arg_1:ITextWindow):void
        {
            var _local_3:int;
            this._SafeStr_5285.font = _arg_1.fontFace;
            this._SafeStr_5285.size = _arg_1.fontSize;
            this._SafeStr_5285.bold = _arg_1.bold;
            this._SafeStr_5285.italic = _arg_1.italic;
            this._SafeStr_5284.setTextFormat(this._SafeStr_5285);
            this._SafeStr_5284.text = _arg_1.getLineText(0);
            var _local_2:int = this._SafeStr_5284.textWidth;
            if (_local_2 > _arg_1.width){
                _local_3 = this._SafeStr_5284.getCharIndexAtPoint((_arg_1.width - this._SafeStr_5287), (this._SafeStr_5284.textHeight / 2));
                _arg_1.text = (_arg_1.text.slice(0, _local_3) + this._SafeStr_5286);
            };
        }

    }
}//package com.sulake.habbo.friendbar.view.utils

// TextCropper = "_-58" (String#22425, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _SafeStr_5284 = "_-c5" (String#23717, DoABC#2)
// _SafeStr_5285 = "_-1Dv" (String#17021, DoABC#2)
// _SafeStr_5286 = "_-1df" (String#18042, DoABC#2)
// _SafeStr_5287 = "_-2fL" (String#20661, DoABC#2)
// fontFace = "_-hD" (String#2155, DoABC#2)


