
package com.sulake.habbo.session.events
{
    import flash.events.Event;

    public class UserNameUpdateEvent extends Event 
    {

        public static const _SafeStr_4791:String = "unue_name_updated";

        private var _name:String;

        public function UserNameUpdateEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(_SafeStr_4791, _arg_2, _arg_3);
            this._name = _arg_1;
        }
        public function get name():String
        {
            return (this._name);
        }

    }
}//package com.sulake.habbo.session.events

// UserNameUpdateEvent = "_-1FC" (String#17079, DoABC#2)
// _SafeStr_4791 = "_-28D" (String#19339, DoABC#2)


