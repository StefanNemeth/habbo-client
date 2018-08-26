
package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class IssueDeletedMessageParser implements IMessageParser 
    {

        private var _issueId:int;

        public function get issueId():int
        {
            return (this._issueId);
        }
        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._issueId = parseInt(_arg_1.readString());
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.moderation

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// IssueDeletedMessageParser = "_-1t1" (String#5902, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _issueId = "_-1kS" (String#5759, DoABC#2)
// issueId = "_-1yh" (String#18916, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


