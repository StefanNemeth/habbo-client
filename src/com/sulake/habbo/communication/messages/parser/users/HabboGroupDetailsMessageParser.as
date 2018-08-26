
package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboGroupDetailsMessageParser implements IMessageParser 
    {

        private var _data:HabboGroupDetailsData;

        public function flush():Boolean
        {
            this._data = null;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._data = new HabboGroupDetailsData(_arg_1);
            return (true);
        }
        public function get data():HabboGroupDetailsData
        {
            return (this._data);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.users

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// HabboGroupDetailsData = "_-13j" (String#16607, DoABC#2)
// HabboGroupDetailsMessageParser = "_-03r" (String#3643, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


