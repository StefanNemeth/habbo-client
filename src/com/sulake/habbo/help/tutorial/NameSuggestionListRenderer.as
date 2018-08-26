
package com.sulake.habbo.help.tutorial
{
    import com.sulake.habbo.help.INameChangeUI;
    import flash.geom.Rectangle;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContainer;

    public class NameSuggestionListRenderer 
    {

        private const _SafeStr_11458:int = 5;
        private const _SafeStr_11459:int = 5;

        private var _help:INameChangeUI;
        private var _offsetX:int;
        private var _originalOffsetY:int;
        private var _rectangle:Rectangle = null;
        private var _SafeStr_11460:int = 0;

        public function NameSuggestionListRenderer(_arg_1:INameChangeUI)
        {
            this._help = _arg_1;
        }
        public function dispose():void
        {
            this._help = null;
        }
        public function render(_arg_1:Array, _arg_2:IWindowContainer):int
        {
            var _local_3:ITextWindow;
            do  {
            } while (_arg_2.removeChildAt(0) != null);
            this._SafeStr_11460 = 0;
            this._offsetX = 0;
            this._originalOffsetY = 0;
            this._rectangle = _arg_2.rectangle.clone();
            this._rectangle.height = 150;
            var _local_4:int;
            while (_local_4 < _arg_1.length) {
                _local_3 = this.createItem((_arg_1[_local_4] as String));
                if (this.fit(_local_3.rectangle)){
                    _arg_2.addChild(_local_3);
                }
                else {
                    _local_3.dispose();
                };
                _local_4++;
            };
            var _local_5:int = _arg_2.numChildren;
            if (_local_5 == 0){
                return (0);
            };
            var _local_6:IWindow = _arg_2.getChildAt((_arg_2.numChildren - 1));
            return (_local_6.rectangle.bottom);
        }
        private function fit(_arg_1:Rectangle):Boolean
        {
            if (_arg_1.width > this._rectangle.width){
                return (false);
            };
            if ((this._originalOffsetY + _arg_1.height) > this._rectangle.height){
                return (false);
            };
            if ((this._offsetX + _arg_1.width) > this._rectangle.width){
                this._offsetX = 0;
                this._originalOffsetY = (this._originalOffsetY + (_arg_1.height + this._SafeStr_11459));
                return (this.fit(_arg_1));
            };
            _arg_1.offset(this._offsetX, this._originalOffsetY);
            this._offsetX = (this._offsetX + (_arg_1.width + this._SafeStr_11458));
            return (true);
        }
        private function createItem(_arg_1:String):ITextWindow
        {
            var _local_2:ITextWindow = (this._help.buildXmlWindow("tutorial_name_suggestion_item") as ITextWindow);
            if (_local_2 == null){
                return (null);
            };
            _local_2.text = _arg_1;
            return (_local_2);
        }

    }
}//package com.sulake.habbo.help.tutorial

// _help = "_-3HG" (String#114, DoABC#2)
// _SafeStr_11458 = "_-MP" (String#8130, DoABC#2)
// _SafeStr_11459 = "_-0pC" (String#4616, DoABC#2)
// _SafeStr_11460 = "_-0Ax" (String#3775, DoABC#2)
// createItem = "_-R4" (String#23286, DoABC#2)
// fit = "_-18P" (String#5045, DoABC#2)
// INameChangeUI = "_-34B" (String#7392, DoABC#2)
// NameSuggestionListRenderer = "_-Gn" (String#8013, DoABC#2)
// _rectangle = "_-1d7" (String#857, DoABC#2)
// _originalOffsetY = "_-hb" (String#375, DoABC#2)


