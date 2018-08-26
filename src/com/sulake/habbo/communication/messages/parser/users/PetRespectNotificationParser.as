
package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetRespectNotificationParser implements IMessageParser 
    {

        private var _respect:int;
        private var _petOwnerId:int;
        private var _petData:PetData;

        public function flush():Boolean
        {
            this._petData = null;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._respect = _arg_1.readInteger();
            this._petOwnerId = _arg_1.readInteger();
            this._petData = new PetData(_arg_1);
            return (true);
        }
        public function get petOwnerId():int
        {
            return (this._petOwnerId);
        }
        public function get respect():int
        {
            return (this._respect);
        }
        public function get petData():PetData
        {
            return (this._petData);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.users

// PetData = "_-01G" (String#1387, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// PetRespectNotificationParser = "_-1Te" (String#5426, DoABC#2)
// _respect = "_-1aM" (String#1712, DoABC#2)
// _petOwnerId = "_-079" (String#14331, DoABC#2)
// petOwnerId = "_-0vG" (String#16247, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


