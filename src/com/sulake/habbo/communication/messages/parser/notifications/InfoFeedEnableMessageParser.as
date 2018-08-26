
package com.sulake.habbo.communication.messages.parser.notifications
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class InfoFeedEnableMessageParser implements IMessageParser 
    {

        private var _enabled:Boolean;

        public function flush():Boolean
        {
            this._enabled = false;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._enabled = _arg_1.readBoolean();
            return (true);
        }
        public function get enabled():Boolean
        {
            return (this._enabled);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.notifications

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// InfoFeedEnableMessageParser = "_-Ic" (String#8054, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// enabled = "_-0Kh" (String#14868, DoABC#2)
// _enabled = "_-38q" (String#2010, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


