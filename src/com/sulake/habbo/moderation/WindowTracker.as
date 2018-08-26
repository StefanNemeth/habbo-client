
package com.sulake.habbo.moderation
{
    import flash.utils.Dictionary;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IFrameWindow;

    public class WindowTracker 
    {

        public static const _SafeStr_11793:int = 1;
        public static const _SafeStr_11794:int = 2;
        public static const _SafeStr_11779:int = 3;
        public static const _SafeStr_11755:int = 4;
        public static const _SafeStr_11780:int = 5;
        public static const _SafeStr_11795:int = 6;
        public static const _SafeStr_11796:int = 7;
        public static const TYPE_ISSUEHANDLER:int = 8;
        public static const _SafeStr_11797:int = 9;

        private var _SafeStr_11798:Dictionary;

        public function WindowTracker()
        {
            this._SafeStr_11798 = new Dictionary();
            super();
        }
        public function show(_arg_1:TrackedWindow, _arg_2:IFrameWindow, _arg_3:Boolean, _arg_4:Boolean, _arg_5:Boolean):void
        {
            var _local_7:Rectangle;
            var _local_8:int;
            var _local_9:IWindow;
            var _local_6:TrackedWindow = this.removeWindow(_arg_1.getType(), _arg_1.getId());
            if (((!((_local_6 == null))) && (!(_local_6.disposed)))){
                if (_arg_5){
                    _arg_1.dispose();
                    _local_6.dispose();
                    return;
                };
                _arg_1.show();
                _local_7 = _local_6.getFrame().rectangle;
                _arg_1.getFrame().x = _local_7.x;
                _arg_1.getFrame().y = _local_7.y;
                _arg_1.getFrame().width = _local_7.width;
                _arg_1.getFrame().height = _local_7.height;
                this.getWindowsForType(_arg_1.getType())[_arg_1.getId()] = _arg_1;
                _local_6.dispose();
            }
            else {
                if (!_arg_4){
                    _arg_1.show();
                    if (_arg_2 != null){
                        _local_8 = 5;
                        if (_arg_3){
                            _arg_1.getFrame().x = _arg_2.x;
                            _arg_1.getFrame().y = ((_arg_2.y + _arg_2.height) + _local_8);
                        }
                        else {
                            _arg_1.getFrame().x = ((_arg_2.x + _arg_2.width) + _local_8);
                            _arg_1.getFrame().y = _arg_2.y;
                        };
                    }
                    else {
                        _local_9 = _arg_1.getFrame().desktop;
                        _arg_1.getFrame().x = ((_local_9.width / 2) - (_arg_1.getFrame().width / 2));
                        _arg_1.getFrame().y = ((_local_9.height / 2) - (_arg_1.getFrame().height / 2));
                    };
                    _arg_1.getFrame().x = Math.max(0, Math.min(_arg_1.getFrame().x, (_arg_1.getFrame().desktop.width - _arg_1.getFrame().width)));
                    _arg_1.getFrame().y = Math.max(0, Math.min(_arg_1.getFrame().y, (_arg_1.getFrame().desktop.height - _arg_1.getFrame().height)));
                    this.getWindowsForType(_arg_1.getType())[_arg_1.getId()] = _arg_1;
                };
            };
        }
        private function removeWindow(_arg_1:int, _arg_2:String):TrackedWindow
        {
            var _local_3:Dictionary = this.getWindowsForType(_arg_1);
            var _local_4:TrackedWindow = _local_3[_arg_2];
            _local_3[_arg_2] = null;
            return (_local_4);
        }
        private function getWindowsForType(_arg_1:int):Dictionary
        {
            var _local_2:Dictionary = this._SafeStr_11798[_arg_1];
            if (_local_2 == null){
                _local_2 = new Dictionary();
                this._SafeStr_11798[_arg_1] = _local_2;
            };
            return (_local_2);
        }

    }
}//package com.sulake.habbo.moderation

// _SafeStr_11755 = "_-12Z" (String#16561, DoABC#2)
// _SafeStr_11779 = "_-1Ka" (String#17297, DoABC#2)
// _SafeStr_11780 = "_-0Xa" (String#15339, DoABC#2)
// _SafeStr_11793 = "_-37N" (String#21783, DoABC#2)
// _SafeStr_11794 = "_-2pl" (String#21071, DoABC#2)
// _SafeStr_11795 = "_-1mM" (String#18393, DoABC#2)
// _SafeStr_11796 = "_-3FI" (String#22088, DoABC#2)
// _SafeStr_11797 = "_-du" (String#23797, DoABC#2)
// _SafeStr_11798 = "_-FP" (String#22829, DoABC#2)
// getWindowsForType = "_-0yT" (String#16371, DoABC#2)
// WindowTracker = "_-2m9" (String#7008, DoABC#2)
// TrackedWindow = "_-Xp" (String#8365, DoABC#2)
// getFrame = "_-3Jk" (String#923, DoABC#2)
// removeWindow = "_-x0" (String#949, DoABC#2)


