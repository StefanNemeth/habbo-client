
package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomInviteErrorMessageParser implements IMessageParser 
    {

        private var _errorCode:int;
        private var _failedRecipients:Array;

        public function flush():Boolean
        {
            this._failedRecipients = new Array();
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:int;
            var _local_3:int;
            this._errorCode = _arg_1.readInteger();
            if (this._errorCode == 1){
                _local_2 = _arg_1.readInteger();
                _local_3 = 0;
                while (_local_3 < _local_2) {
                    this._failedRecipients.push(_arg_1.readInteger());
                    _local_3++;
                };
            };
            return (true);
        }
        public function get errorCode():int
        {
            return (this._errorCode);
        }
        public function get failedRecipients():Array
        {
            return (this._failedRecipients);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.friendlist

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// RoomInviteErrorMessageParser = "_-1Fp" (String#5168, DoABC#2)
// _errorCode = "_-2il" (String#127, DoABC#2)
// _failedRecipients = "_-24r" (String#19217, DoABC#2)
// failedRecipients = "_-X3" (String#23524, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


