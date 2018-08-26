
package com.sulake.habbo.window.utils
{
    import com.sulake.habbo.window.utils.ICaption;

    class AlertDialogCaption implements ICaption 
    {

        private var _text:String;
        private var _toolTip:String;
        private var _visible:Boolean;

        public function AlertDialogCaption(_arg_1:String, _arg_2:String, _arg_3:Boolean)
        {
            this._text = _arg_1;
            this._toolTip = _arg_2;
            this._visible = _arg_3;
        }
        public function get text():String
        {
            return (this._text);
        }
        public function set text(_arg_1:String):void
        {
            this._text = _arg_1;
        }
        public function get toolTip():String
        {
            return (this._toolTip);
        }
        public function set toolTip(_arg_1:String):void
        {
            this._toolTip = _arg_1;
        }
        public function get visible():Boolean
        {
            return (this._visible);
        }
        public function set visible(_arg_1:Boolean):void
        {
            this._visible = _arg_1;
        }

    }
}//package com.sulake.habbo.window.utils

// toolTip = "_-1rf" (String#5882, DoABC#2)
// _toolTip = "_-2i-" (String#20771, DoABC#2)
// ICaption = "_-1ZX" (String#5555, DoABC#2)
// AlertDialogCaption = "_-LZ" (String#8115, DoABC#2)
// _visible = "_-1SE" (String#363, DoABC#2)


