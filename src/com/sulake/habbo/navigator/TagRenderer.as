
package com.sulake.habbo.navigator
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.*;
    import com.sulake.core.window.events.*;
    import com.sulake.core.window.*;
    import com.sulake.core.window.enum.*;

    public class TagRenderer 
    {

        private var _navigator:HabboNavigator;
        private var _SafeStr_12031:Function;

        public function TagRenderer(_arg_1:HabboNavigator, _arg_2:Function=null)
        {
            this._navigator = _arg_1;
            this._SafeStr_12031 = _arg_2;
        }
        public function dispose():void
        {
            this._navigator = null;
            this._SafeStr_12031 = null;
        }
        public function refreshTags(_arg_1:IWindowContainer, _arg_2:Array):void
        {
            var _local_3:IWindowContainer = IWindowContainer(_arg_1.findChildByName("tags"));
            var _local_4:int;
            while (_local_4 < 4) {
                this.refreshTag(_local_3, _local_4, _arg_2[_local_4]);
                _local_4++;
            };
            var _local_5:int = (_arg_1.width - _local_3.x);
            Util.layoutChildrenInArea(_local_3, _local_5, 14);
            _local_3.height = Util.getLowestPoint(_local_3);
            _local_3.visible = (_arg_2.length > 0);
            Logger.log(((((("REFRESHED TAGS: " + _arg_2.length) + ", ") + _local_3.visible) + ", ") + _local_3));
        }
        public function refreshTag(_arg_1:IWindowContainer, _arg_2:int, _arg_3:String):void
        {
            var _local_6:ITextWindow;
            var _local_4:String = ("tag." + _arg_2);
            var _local_5:IWindowContainer = IWindowContainer(_arg_1.getChildByName(_local_4));
            if ((((_arg_3 == null)) || ((_arg_3 == "")))){
                if (_local_5 != null){
                    _local_5.visible = false;
                };
            }
            else {
                if (_local_5 == null){
                    _local_5 = IWindowContainer(this._navigator.getXmlWindow("iro_tag"));
                    _local_5.name = _local_4;
                    _arg_1.addChild(_local_5);
                    _local_5.procedure = this.onTagClick;
                };
                _local_6 = ITextWindow(_local_5.findChildByName("txt"));
                _local_6.text = _arg_3;
                _local_6.width = (_local_6.textWidth + 5);
                _local_5.width = (_local_6.width + 3);
                this.refreshTagBg(_local_5, false);
                _local_5.visible = true;
            };
        }
        private function refreshTagBg(_arg_1:IWindowContainer, _arg_2:Boolean):void
        {
            this.refreshBgPiece(_arg_1, "l", _arg_2);
            this.refreshBgPiece(_arg_1, "m", _arg_2);
            this.refreshBgPiece(_arg_1, "r", _arg_2);
        }
        private function onTagClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_4:ITextWindow;
            var _local_5:String;
            var _local_3:IWindowContainer = (_arg_2 as IWindowContainer);
            if (_local_3 == null){
                return;
            };
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER){
                this.refreshTagBg(_local_3, true);
            }
            else {
                if (_arg_1.type == WindowMouseEvent.WME_OUT){
                    this.refreshTagBg(_local_3, false);
                }
                else {
                    if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                        _local_4 = ITextWindow(_local_3.findChildByName("txt"));
                        _local_5 = _local_4.text;
                        Logger.log(("TAG CLICKED: " + _local_5));
                        this._navigator.performTagSearch(_local_5);
                        if (this._SafeStr_12031 != null){
                            this._SafeStr_12031();
                        };
                    };
                };
            };
        }
        private function refreshBgPiece(_arg_1:IWindowContainer, _arg_2:String, _arg_3:Boolean):void
        {
            var _local_5:String;
            var _local_4:IBitmapWrapperWindow = IBitmapWrapperWindow(_arg_1.findChildByName(("bg_" + _arg_2)));
            if (_local_4.tags[0] != ("" + _arg_3)){
                Logger.log(("Redraw tag bg: " + _arg_3));
                _local_4.tags.splice(0, _local_4.tags.length);
                _local_4.tags.push(("" + _arg_3));
                _local_5 = (("tag_" + _arg_2) + ((_arg_3) ? "_reactive" : ""));
                _local_4.bitmap = this._navigator.getButtonImage(_local_5);
                _local_4.invalidate();
            };
        }

    }
}//package com.sulake.habbo.navigator

// _SafeStr_12031 = "_-0ZM" (String#15417, DoABC#2)
// onTagClick = "_-0L-" (String#14877, DoABC#2)
// refreshTagBg = "_-0dZ" (String#15567, DoABC#2)
// refreshBgPiece = "_-1zY" (String#18949, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// Util = "_-1ve" (String#445, DoABC#2)
// TagRenderer = "_-35E" (String#7412, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// refreshTag = "_-1-R" (String#16445, DoABC#2)
// layoutChildrenInArea = "_-0f9" (String#15635, DoABC#2)
// getLowestPoint = "_-0t0" (String#16161, DoABC#2)
// performTagSearch = "_-29O" (String#6238, DoABC#2)
// refreshTags = "_-0s5" (String#16127, DoABC#2)


