
package com.sulake.habbo.communication.messages.parser.room.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetInfoMessageParser implements IMessageParser 
    {

        private var _id:int;
        private var _name:String;
        private var _level:int;
        private var _maxLevel:int;
        private var _experience:int;
        private var _energy:int;
        private var _nutrition:int;
        private var _figure:String;
        private var _experienceRequiredToLevel:int;
        private var _maxEnergy:int;
        private var _maxNutrition:int;
        private var _respect:int;
        private var _ownerId:int;
        private var _ownerName:String;
        private var _age:int;

        public function get petId():int
        {
            return (this._id);
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get level():int
        {
            return (this._level);
        }
        public function get maxLevel():int
        {
            return (this._maxLevel);
        }
        public function get experience():int
        {
            return (this._experience);
        }
        public function get energy():int
        {
            return (this._energy);
        }
        public function get nutrition():int
        {
            return (this._nutrition);
        }
        public function get figure():String
        {
            return (this._figure);
        }
        public function get experienceRequiredToLevel():int
        {
            return (this._experienceRequiredToLevel);
        }
        public function get maxEnergy():int
        {
            return (this._maxEnergy);
        }
        public function get maxNutrition():int
        {
            return (this._maxNutrition);
        }
        public function get respect():int
        {
            return (this._respect);
        }
        public function get ownerId():int
        {
            return (this._ownerId);
        }
        public function get ownerName():String
        {
            return (this._ownerName);
        }
        public function get age():int
        {
            return (this._age);
        }
        public function flush():Boolean
        {
            this._id = -1;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null){
                return (false);
            };
            this._id = _arg_1.readInteger();
            this._name = _arg_1.readString();
            this._level = _arg_1.readInteger();
            this._maxLevel = _arg_1.readInteger();
            this._experience = _arg_1.readInteger();
            this._experienceRequiredToLevel = _arg_1.readInteger();
            this._energy = _arg_1.readInteger();
            this._maxEnergy = _arg_1.readInteger();
            this._nutrition = _arg_1.readInteger();
            this._maxNutrition = _arg_1.readInteger();
            this._figure = _arg_1.readString();
            this._respect = _arg_1.readInteger();
            this._ownerId = _arg_1.readInteger();
            this._age = _arg_1.readInteger();
            this._ownerName = _arg_1.readString();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.pets

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// PetInfoMessageParser = "_-0zJ" (String#4833, DoABC#2)
// _id = "_-0VE" (String#148, DoABC#2)
// petId = "_-JP" (String#8074, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _figure = "_-20u" (String#75, DoABC#2)
// ownerName = "_-1e1" (String#1730, DoABC#2)
// _experience = "_-0Rh" (String#434, DoABC#2)
// _level = "_-3FE" (String#250, DoABC#2)
// _respect = "_-1aM" (String#1712, DoABC#2)
// maxLevel = "_-2ur" (String#21271, DoABC#2)
// experienceRequiredToLevel = "_-RG" (String#23294, DoABC#2)
// maxEnergy = "_-Ns" (String#23159, DoABC#2)
// nutrition = "_-0yZ" (String#4819, DoABC#2)
// maxNutrition = "_-LR" (String#23063, DoABC#2)
// ownerId = "_-0Kl" (String#3968, DoABC#2)
// _ownerId = "_-2Ze" (String#622, DoABC#2)
// _maxLevel = "_-221" (String#19091, DoABC#2)
// _experienceRequiredToLevel = "_-2zv" (String#21457, DoABC#2)
// _maxEnergy = "_-PU" (String#23225, DoABC#2)
// _maxNutrition = "_-12q" (String#16574, DoABC#2)
// _age = "_-07p" (String#581, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


