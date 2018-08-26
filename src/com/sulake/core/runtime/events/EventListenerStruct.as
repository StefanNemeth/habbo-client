
package com.sulake.core.runtime.events
{
    import flash.utils.Dictionary;

    public class EventListenerStruct 
    {

        private var _SafeStr_8890:Dictionary;
        public var _SafeStr_8891:Boolean;
        public var priority:int;
        public var _SafeStr_8892:Boolean;

        public function EventListenerStruct(_arg_1:Function, _arg_2:Boolean=false, _arg_3:int=0, _arg_4:Boolean=false)
        {
            this._SafeStr_8890 = new Dictionary(_arg_4);
            this.callback = _arg_1;
            this._SafeStr_8891 = _arg_2;
            this.priority = _arg_3;
            this._SafeStr_8892 = _arg_4;
        }
        public function set callback(_arg_1:Function):void
        {
            var _local_2:Object;
            for (_local_2 in this._SafeStr_8890) {
                delete this._SafeStr_8890[_local_2];
            };
            this._SafeStr_8890[_arg_1] = null;
        }
        public function get callback():Function
        {
            var _local_1:Object;
            for (_local_1 in this._SafeStr_8890) {
                return ((_local_1 as Function));
            };
            return (null);
        }

    }
}//package com.sulake.core.runtime.events

// EventListenerStruct = "_-Pi" (String#8197, DoABC#2)
// _SafeStr_8890 = "_-0EV" (String#3839, DoABC#2)
// _SafeStr_8891 = "_-l-" (String#24072, DoABC#2)
// _SafeStr_8892 = "_-2ew" (String#20642, DoABC#2)


