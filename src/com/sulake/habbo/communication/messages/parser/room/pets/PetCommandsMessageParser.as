
package com.sulake.habbo.communication.messages.parser.room.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetCommandsMessageParser implements IMessageParser 
    {

        private var _id:int;
        private var _allCommands:Array;
        private var _enabledCommands:Array;

        public function get petId():int
        {
            return (this._id);
        }
        public function get allCommands():Array
        {
            return (this._allCommands);
        }
        public function get enabledCommands():Array
        {
            return (this._enabledCommands);
        }
        public function flush():Boolean
        {
            this._id = -1;
            this._allCommands = null;
            this._enabledCommands = null;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null){
                return (false);
            };
            this._id = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            this._allCommands = new Array();
            while (_local_2-- > 0) {
                this._allCommands.push(_arg_1.readInteger());
            };
            var _local_3:int = _arg_1.readInteger();
            this._enabledCommands = new Array();
            while (_local_3-- > 0) {
                this._enabledCommands.push(_arg_1.readInteger());
            };
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.pets

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// PetCommandsMessageParser = "_-fp" (String#8509, DoABC#2)
// _id = "_-0VE" (String#148, DoABC#2)
// petId = "_-JP" (String#8074, DoABC#2)
// allCommands = "_-2QF" (String#20056, DoABC#2)
// enabledCommands = "_-0yX" (String#16375, DoABC#2)
// _allCommands = "_-1VM" (String#5464, DoABC#2)
// _enabledCommands = "_-1GF" (String#843, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


