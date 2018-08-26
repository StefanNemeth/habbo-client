
package com.sulake.habbo.ui.widget.infostand
{
    import flash.geom.Rectangle;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class TagListRenderer 
    {

        private const _SafeStr_11458:int = 5;
        private const _SafeStr_11459:int = 5;

        private var _widget:InfostandWidget;
        private var _messageListener:Function;
        private var _offsetX:int;
        private var _originalOffsetY:int;
        private var _rectangle:Rectangle = null;
        private var _SafeStr_11460:int = 0;
        private var _SafeStr_14069:Array;

        public function TagListRenderer(_arg_1:InfostandWidget, _arg_2:Function)
        {
            this._widget = _arg_1;
            this._messageListener = _arg_2;
        }
        public function dispose():void
        {
            this._widget = null;
            this._messageListener = null;
        }
        public function renderTags(_arg_1:Array, _arg_2:IWindowContainer, _arg_3:Array):int
        {
            var _local_4:ITextWindow;
            var _local_8:Array;
            var _local_9:String;
            this._SafeStr_14069 = _arg_3;
            if (this._SafeStr_14069 != null){
                _local_8 = [];
                while ((_local_9 = _arg_1.pop()) != null) {
                    if (_arg_3.indexOf(_local_9) != -1){
                        _local_8.unshift(_local_9);
                    }
                    else {
                        _local_8.push(_local_9);
                    };
                };
                _arg_1 = _local_8;
            };
            do  {
            } while (_arg_2.removeChildAt(0) != null);
            this._SafeStr_11460 = 0;
            this._offsetX = 0;
            this._originalOffsetY = 0;
            this._rectangle = _arg_2.rectangle.clone();
            this._rectangle.height = 150;
            var _local_5:int;
            while (_local_5 < _arg_1.length) {
                _local_4 = this.createTag((_arg_1[_local_5] as String));
                if (this.fit(_local_4.rectangle)){
                    _arg_2.addChild(_local_4);
                }
                else {
                    _local_4.dispose();
                };
                _local_5++;
            };
            var _local_6:int = _arg_2.numChildren;
            if (_local_6 == 0){
                return (0);
            };
            var _local_7:IWindow = _arg_2.getChildAt((_arg_2.numChildren - 1));
            return (_local_7.rectangle.bottom);
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
        private function createTag(_arg_1:String):ITextWindow
        {
            var _local_2:XmlAsset;
            if (((!((this._SafeStr_14069 == null))) && (!((this._SafeStr_14069.indexOf(_arg_1) == -1))))){
                _local_2 = (this._widget.assets.getAssetByName("user_tag_highlighted") as XmlAsset);
            }
            else {
                _local_2 = (this._widget.assets.getAssetByName("user_tag") as XmlAsset);
            };
            if (_local_2 == null){
                return (null);
            };
            var _local_3:ITextWindow = (this._widget.windowManager.buildFromXML((_local_2.content as XML)) as ITextWindow);
            if (_local_3 == null){
                throw (new Error("Failed to construct window from XML!"));
            };
            _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this._messageListener);
            _local_3.caption = _arg_1;
            return (_local_3);
        }

    }
}//package com.sulake.habbo.ui.widget.infostand

// _SafeStr_11458 = "_-MP" (String#8130, DoABC#2)
// _SafeStr_11459 = "_-0pC" (String#4616, DoABC#2)
// _SafeStr_11460 = "_-0Ax" (String#3775, DoABC#2)
// fit = "_-18P" (String#5045, DoABC#2)
// renderTags = "_-2qk" (String#21112, DoABC#2)
// _SafeStr_14069 = "_-e" (String#23801, DoABC#2)
// createTag = "_-2hL" (String#20745, DoABC#2)
// TagListRenderer = "_-Z0" (String#8393, DoABC#2)
// _rectangle = "_-1d7" (String#857, DoABC#2)
// _originalOffsetY = "_-hb" (String#375, DoABC#2)
// _messageListener = "_-16t" (String#833, DoABC#2)


