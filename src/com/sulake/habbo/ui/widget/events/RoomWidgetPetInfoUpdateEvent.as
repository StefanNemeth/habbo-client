
package com.sulake.habbo.ui.widget.events
{
    import flash.display.BitmapData;

    public class RoomWidgetPetInfoUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const PET_INFO:String = "RWPIUE_PET_INFO";

        private var _level:int;
        private var _levelMax:int;
        private var _experience:int;
        private var _experienceMax:int;
        private var _energy:int;
        private var _energyMax:int;
        private var _nutrition:int;
        private var _nutritionMax:int;
        private var _petRespectLeft:int;
        private var _petRespect:int;
        private var _age:int;
        private var _name:String;
        private var _id:int;
        private var _image:BitmapData;
        private var _petType:int;
        private var _petRace:int;
        private var _isOwnPet:Boolean;
        private var _ownerId:int;
        private var _ownerName:String;
        private var _canOwnerBeKicked:Boolean;
        private var _roomIndex:int;

        public function RoomWidgetPetInfoUpdateEvent(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:BitmapData, _arg_6:Boolean, _arg_7:int, _arg_8:String, _arg_9:int, _arg_10:Boolean=false, _arg_11:Boolean=false)
        {
            super(RoomWidgetPetInfoUpdateEvent.PET_INFO, _arg_10, _arg_11);
            this._petType = _arg_1;
            this._petRace = _arg_2;
            this._name = _arg_3;
            this._id = _arg_4;
            this._image = _arg_5;
            this._isOwnPet = _arg_6;
            this._ownerId = _arg_7;
            this._ownerName = _arg_8;
            this._roomIndex = _arg_9;
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get image():BitmapData
        {
            return (this._image);
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get petType():int
        {
            return (this._petType);
        }
        public function get petRace():int
        {
            return (this._petRace);
        }
        public function get isOwnPet():Boolean
        {
            return (this._isOwnPet);
        }
        public function get ownerId():int
        {
            return (this._ownerId);
        }
        public function get ownerName():String
        {
            return (this._ownerName);
        }
        public function get canOwnerBeKicked():Boolean
        {
            return (this._canOwnerBeKicked);
        }
        public function get roomIndex():int
        {
            return (this._roomIndex);
        }
        public function get age():int
        {
            return (this._age);
        }
        public function get level():int
        {
            return (this._level);
        }
        public function get levelMax():int
        {
            return (this._levelMax);
        }
        public function get experience():int
        {
            return (this._experience);
        }
        public function get experienceMax():int
        {
            return (this._experienceMax);
        }
        public function get energy():int
        {
            return (this._energy);
        }
        public function get energyMax():int
        {
            return (this._energyMax);
        }
        public function get nutrition():int
        {
            return (this._nutrition);
        }
        public function get nutritionMax():int
        {
            return (this._nutritionMax);
        }
        public function get petRespectLeft():int
        {
            return (this._petRespectLeft);
        }
        public function get petRespect():int
        {
            return (this._petRespect);
        }
        public function set level(_arg_1:int):void
        {
            this._level = _arg_1;
        }
        public function set levelMax(_arg_1:int):void
        {
            this._levelMax = _arg_1;
        }
        public function set experience(_arg_1:int):void
        {
            this._experience = _arg_1;
        }
        public function set experienceMax(_arg_1:int):void
        {
            this._experienceMax = _arg_1;
        }
        public function set energy(_arg_1:int):void
        {
            this._energy = _arg_1;
        }
        public function set energyMax(_arg_1:int):void
        {
            this._energyMax = _arg_1;
        }
        public function set nutrition(_arg_1:int):void
        {
            this._nutrition = _arg_1;
        }
        public function set nutritionMax(_arg_1:int):void
        {
            this._nutritionMax = _arg_1;
        }
        public function set petRespectLeft(_arg_1:int):void
        {
            this._petRespectLeft = _arg_1;
        }
        public function set canOwnerBeKicked(_arg_1:Boolean):void
        {
            this._canOwnerBeKicked = _arg_1;
        }
        public function set petRespect(_arg_1:int):void
        {
            this._petRespect = _arg_1;
        }
        public function set age(_arg_1:int):void
        {
            this._age = _arg_1;
        }

    }
}//package com.sulake.habbo.ui.widget.events

// _levelMax = "_-2Te" (String#1885, DoABC#2)
// _experienceMax = "_-23q" (String#1806, DoABC#2)
// _energyMax = "_-2st" (String#1959, DoABC#2)
// _nutritionMax = "_-0-S" (String#1381, DoABC#2)
// _petRace = "_-1um" (String#18749, DoABC#2)
// _isOwnPet = "_-2jW" (String#6946, DoABC#2)
// petRace = "_-10K" (String#16475, DoABC#2)
// isOwnPet = "_-1g3" (String#18141, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetPetInfoUpdateEvent = "_-KB" (String#8087, DoABC#2)
// _roomIndex = "_-1S2" (String#362, DoABC#2)
// _petRespectLeft = "_-36a" (String#913, DoABC#2)
// petRespectLeft = "_-0wV" (String#4782, DoABC#2)
// ownerName = "_-1e1" (String#1730, DoABC#2)
// _experience = "_-0Rh" (String#434, DoABC#2)
// _image = "_-35u" (String#78, DoABC#2)
// _petType = "_-0zB" (String#439, DoABC#2)
// petType = "_-0GK" (String#3877, DoABC#2)
// _level = "_-3FE" (String#250, DoABC#2)
// levelMax = "_-2dd" (String#6823, DoABC#2)
// experienceMax = "_-1bq" (String#5596, DoABC#2)
// energyMax = "_-8m" (String#7836, DoABC#2)
// nutrition = "_-0yZ" (String#4819, DoABC#2)
// nutritionMax = "_-1m9" (String#5783, DoABC#2)
// ownerId = "_-0Kl" (String#3968, DoABC#2)
// _ownerId = "_-2Ze" (String#622, DoABC#2)
// _age = "_-07p" (String#581, DoABC#2)
// petRespect = "_-2a9" (String#6762, DoABC#2)
// canOwnerBeKicked = "_-2Yz" (String#20395, DoABC#2)


