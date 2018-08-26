
package com.sulake.habbo.communication.messages.outgoing.roomsettings
{
    public class SaveableRoomSettingsData 
    {

        private var _roomId:int;
        private var _name:String;
        private var _description:String;
        private var _doorMode:int;
        private var _password:String;
        private var _categoryId:int;
        private var _maximumVisitors:int;
        private var _tags:Array;
        private var _controllers:Array;
        private var _allowPets:Boolean;
        private var _allowFoodConsume:Boolean;
        private var _allowWalkThrough:Boolean;
        private var _hideWalls:Boolean;
        private var _wallThickness:int;
        private var _floorThickness:int;

        public function get allowPets():Boolean
        {
            return (this._allowPets);
        }
        public function set allowPets(_arg_1:Boolean):void
        {
            this._allowPets = _arg_1;
        }
        public function get allowFoodConsume():Boolean
        {
            return (this._allowFoodConsume);
        }
        public function set allowFoodConsume(_arg_1:Boolean):void
        {
            this._allowFoodConsume = _arg_1;
        }
        public function get allowWalkThrough():Boolean
        {
            return (this._allowWalkThrough);
        }
        public function set allowWalkThrough(_arg_1:Boolean):void
        {
            this._allowWalkThrough = _arg_1;
        }
        public function get hideWalls():Boolean
        {
            return (this._hideWalls);
        }
        public function set hideWalls(_arg_1:Boolean):void
        {
            this._hideWalls = _arg_1;
        }
        public function get wallThickness():int
        {
            return (this._wallThickness);
        }
        public function set wallThickness(_arg_1:int):void
        {
            this._wallThickness = _arg_1;
        }
        public function get floorThickness():int
        {
            return (this._floorThickness);
        }
        public function set floorThickness(_arg_1:int):void
        {
            this._floorThickness = _arg_1;
        }
        public function get roomId():int
        {
            return (this._roomId);
        }
        public function set roomId(_arg_1:int):void
        {
            this._roomId = _arg_1;
        }
        public function get name():String
        {
            return (this._name);
        }
        public function set name(_arg_1:String):void
        {
            this._name = _arg_1;
        }
        public function get description():String
        {
            return (this._description);
        }
        public function set description(_arg_1:String):void
        {
            this._description = _arg_1;
        }
        public function get doorMode():int
        {
            return (this._doorMode);
        }
        public function set doorMode(_arg_1:int):void
        {
            this._doorMode = _arg_1;
        }
        public function get password():String
        {
            return (this._password);
        }
        public function set password(_arg_1:String):void
        {
            this._password = _arg_1;
        }
        public function get categoryId():int
        {
            return (this._categoryId);
        }
        public function set categoryId(_arg_1:int):void
        {
            this._categoryId = _arg_1;
        }
        public function get maximumVisitors():int
        {
            return (this._maximumVisitors);
        }
        public function set maximumVisitors(_arg_1:int):void
        {
            this._maximumVisitors = _arg_1;
        }
        public function get tags():Array
        {
            return (this._tags);
        }
        public function set tags(_arg_1:Array):void
        {
            this._tags = _arg_1;
        }
        public function get controllers():Array
        {
            return (this._controllers);
        }
        public function set controllers(_arg_1:Array):void
        {
            this._controllers = _arg_1;
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.roomsettings

// SaveableRoomSettingsData = "_-Yk" (String#8388, DoABC#2)
// _tags = "_-1NU" (String#163, DoABC#2)
// doorMode = "_-2zu" (String#21456, DoABC#2)
// _description = "_-1a7" (String#164, DoABC#2)
// _doorMode = "_-83" (String#926, DoABC#2)
// _categoryId = "_-1If" (String#186, DoABC#2)
// _maximumVisitors = "_-0Dj" (String#3821, DoABC#2)
// _controllers = "_-0ZC" (String#4284, DoABC#2)
// _allowPets = "_-7k" (String#2056, DoABC#2)
// _allowFoodConsume = "_-08A" (String#3723, DoABC#2)
// _allowWalkThrough = "_-OD" (String#8169, DoABC#2)
// _wallThickness = "_-2Og" (String#6533, DoABC#2)
// _floorThickness = "_-10Y" (String#4883, DoABC#2)
// allowPets = "_-2Zu" (String#20436, DoABC#2)
// allowFoodConsume = "_-18w" (String#16812, DoABC#2)
// allowWalkThrough = "_-1aX" (String#17916, DoABC#2)
// hideWalls = "_-2O7" (String#19970, DoABC#2)
// wallThickness = "_-bn" (String#23705, DoABC#2)
// maximumVisitors = "_-1Ex" (String#17069, DoABC#2)
// controllers = "_-0A4" (String#14450, DoABC#2)


