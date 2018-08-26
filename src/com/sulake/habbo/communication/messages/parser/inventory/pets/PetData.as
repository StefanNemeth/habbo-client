
package com.sulake.habbo.communication.messages.parser.inventory.pets
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetData 
    {

        private var _id:int;
        private var _name:String;
        private var _type:int;
        private var _breed:int;
        private var _color:String;

        public function PetData(_arg_1:IMessageDataWrapper)
        {
            this._id = _arg_1.readInteger();
            this._name = _arg_1.readString();
            this._type = _arg_1.readInteger();
            this._breed = _arg_1.readInteger();
            this._color = _arg_1.readString();
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get type():int
        {
            return (this._type);
        }
        public function get breed():int
        {
            return (this._breed);
        }
        public function get color():String
        {
            return (this._color);
        }
        public function get figureString():String
        {
            return (((((this._type + " ") + this.breed) + " ") + this.color));
        }

    }
}//package com.sulake.habbo.communication.messages.parser.inventory.pets

// PetData = "_-01G" (String#1387, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// _breed = "_-0BH" (String#297, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// figureString = "_-P1" (String#23207, DoABC#2)


