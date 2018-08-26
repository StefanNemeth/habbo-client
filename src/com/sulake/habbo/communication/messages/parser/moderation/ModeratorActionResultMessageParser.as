
package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ModeratorActionResultMessageParser implements IMessageParser 
    {

        private var _userId:int;
        private var _success:Boolean;

        public function get userId():int
        {
            return (this._userId);
        }
        public function get success():Boolean
        {
            return (this._success);
        }
        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._userId = _arg_1.readInteger();
            this._success = _arg_1.readBoolean();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.moderation

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// ModeratorActionResultMessageParser = "_-2-r" (String#6043, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// _success = "_-0Vx" (String#1489, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


