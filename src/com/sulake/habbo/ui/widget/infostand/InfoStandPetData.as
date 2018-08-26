
package com.sulake.habbo.ui.widget.infostand
{
    import flash.display.BitmapData;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPetInfoUpdateEvent;

    public class InfoStandPetData 
    {

        private var _level:int;
        private var _levelMax:int;
        private var _experience:int;
        private var _experienceMax:int;
        private var _energy:int;
        private var _energyMax:int;
        private var _nutrition:int;
        private var _nutritionMax:int;
        private var _petRespect:int;
        private var _name:String = "";
        private var _id:int = -1;
        private var _type:int;
        private var _race:int;
        private var _image:BitmapData;
        private var _isOwnPet:Boolean;
        private var _ownerId:int;
        private var _ownerName:String;
        private var _canOwnerBeKicked:Boolean;
        private var _roomIndex:int;
        private var _age:int;

        public function get name():String
        {
            return (this._name);
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get type():int
        {
            return (this._type);
        }
        public function get race():int
        {
            return (this._race);
        }
        public function get image():BitmapData
        {
            return (this._image);
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
        public function get petRespect():int
        {
            return (this._petRespect);
        }
        public function get roomIndex():int
        {
            return (this._roomIndex);
        }
        public function setData(_arg_1:RoomWidgetPetInfoUpdateEvent):void
        {
            this._name = _arg_1.name;
            this._id = _arg_1.id;
            this._type = _arg_1.petType;
            this._race = _arg_1.petRace;
            this._image = _arg_1.image;
            this._isOwnPet = _arg_1.isOwnPet;
            this._ownerId = _arg_1.ownerId;
            this._ownerName = _arg_1.ownerName;
            this._canOwnerBeKicked = _arg_1.canOwnerBeKicked;
            this._level = _arg_1.level;
            this._levelMax = _arg_1.levelMax;
            this._experience = _arg_1.experience;
            this._experienceMax = _arg_1.experienceMax;
            this._energy = _arg_1.energy;
            this._energyMax = _arg_1.energyMax;
            this._nutrition = _arg_1.nutrition;
            this._nutritionMax = _arg_1.nutritionMax;
            this._petRespect = _arg_1.petRespect;
            this._roomIndex = _arg_1.roomIndex;
            this._age = _arg_1.age;
        }

    }
}//package com.sulake.habbo.ui.widget.infostand

// setData = "_-1x" (String#18846, DoABC#2)
// _levelMax = "_-2Te" (String#1885, DoABC#2)
// _experienceMax = "_-23q" (String#1806, DoABC#2)
// _energyMax = "_-2st" (String#1959, DoABC#2)
// _nutritionMax = "_-0-S" (String#1381, DoABC#2)
// _isOwnPet = "_-2jW" (String#6946, DoABC#2)
// petRace = "_-10K" (String#16475, DoABC#2)
// isOwnPet = "_-1g3" (String#18141, DoABC#2)
// RoomWidgetPetInfoUpdateEvent = "_-KB" (String#8087, DoABC#2)
// InfoStandPetData = "_-1oA" (String#5821, DoABC#2)
// _id = "_-0VE" (String#148, DoABC#2)
// _roomIndex = "_-1S2" (String#362, DoABC#2)
// ownerName = "_-1e1" (String#1730, DoABC#2)
// _experience = "_-0Rh" (String#434, DoABC#2)
// _image = "_-35u" (String#78, DoABC#2)
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
// _race = "_-R-" (String#8229, DoABC#2)


