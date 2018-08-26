
package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupEntryData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboGroupsWhereMemberMessageParser implements IMessageParser 
    {

        private var _groups:Array;

        public function flush():Boolean
        {
            this._groups = null;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._groups = new Array();
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._groups.push(new HabboGroupEntryData(_arg_1));
                _local_3++;
            };
            return (true);
        }
        public function get groups():Array
        {
            return (this._groups);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.users

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// HabboGroupEntryData = "_-sd" (String#24384, DoABC#2)
// HabboGroupsWhereMemberMessageParser = "_-1yA" (String#5998, DoABC#2)
// _groups = "_-3S" (String#2047, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


