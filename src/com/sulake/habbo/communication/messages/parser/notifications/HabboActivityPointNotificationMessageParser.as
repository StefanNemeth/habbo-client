
package com.sulake.habbo.communication.messages.parser.notifications
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboActivityPointNotificationMessageParser implements IMessageParser 
    {

        private var _amount:int = 0;
        private var _change:int = 0;
        private var _type:int;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._amount = _arg_1.readInteger();
            this._change = _arg_1.readInteger();
            this._type = _arg_1.readInteger();
            return (true);
        }
        public function get amount():int
        {
            return (this._amount);
        }
        public function get change():int
        {
            return (this._change);
        }
        public function get type():int
        {
            return (this._type);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.notifications

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// HabboActivityPointNotificationMessageParser = "_-2G8" (String#6368, DoABC#2)
// _amount = "_-LN" (String#8109, DoABC#2)
// change = "_-Bl" (String#7908, DoABC#2)
// _change = "_-069" (String#14289, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


