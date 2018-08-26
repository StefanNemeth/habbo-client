
package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class OpenPetPackageResultMessageParser implements IMessageParser 
    {

        private var _objectId:int = 0;
        private var _nameValidationStatus:int = 0;
        private var _nameValidationInfo:String = null;

        public function get objectId():int
        {
            return (this._objectId);
        }
        public function get nameValidationStatus():int
        {
            return (this._nameValidationStatus);
        }
        public function get nameValidationInfo():String
        {
            return (this._nameValidationInfo);
        }
        public function flush():Boolean
        {
            this._objectId = 0;
            this._nameValidationStatus = 0;
            this._nameValidationInfo = null;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null){
                return (false);
            };
            this._objectId = _arg_1.readInteger();
            this._nameValidationStatus = _arg_1.readInteger();
            this._nameValidationInfo = _arg_1.readString();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.furniture

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// OpenPetPackageResultMessageParser = "_-09b" (String#3750, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _nameValidationStatus = "_-1hU" (String#1745, DoABC#2)
// _nameValidationInfo = "_-2R" (String#619, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


