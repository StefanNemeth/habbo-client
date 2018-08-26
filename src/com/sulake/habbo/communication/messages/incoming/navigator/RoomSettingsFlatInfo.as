
package com.sulake.habbo.communication.messages.incoming.navigator
{
    public class RoomSettingsFlatInfo 
    {

        public static const _SafeStr_5334:int = 0;
        public static const _SafeStr_4188:int = 1;
        public static const _SafeStr_4148:int = 2;
        public static const _password:Array = ["open", "closed", "password"];

        private var _allowFurniMoving:Boolean;
        private var _doorMode:int;
        private var _id:int;
        private var _ownerName:String;
        private var _type:String;
        private var _name:String;
        private var _description:String;
        private var _showOwnerName:Boolean;
        private var _allowTrading:Boolean;
        private var _categoryAlertKey:Boolean;
        private var _password:String;

        public function get allowFurniMoving():Boolean
        {
            return (this._allowFurniMoving);
        }
        public function get doorMode():int
        {
            return (this._doorMode);
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get ownerName():String
        {
            return (this._ownerName);
        }
        public function get type():String
        {
            return (this._type);
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get description():String
        {
            return (this._description);
        }
        public function get showOwnerName():Boolean
        {
            return (this._showOwnerName);
        }
        public function get allowTrading():Boolean
        {
            return (this._allowTrading);
        }
        public function get categoryAlertKey():Boolean
        {
            return (this._categoryAlertKey);
        }
        public function get password():String
        {
            return (this._password);
        }
        public function set allowFurniMoving(_arg_1:Boolean):void
        {
            this._allowFurniMoving = _arg_1;
        }
        public function set doorMode(_arg_1:int):void
        {
            this._doorMode = _arg_1;
        }
        public function set id(_arg_1:int):void
        {
            this._id = _arg_1;
        }
        public function set ownerName(_arg_1:String):void
        {
            this._ownerName = _arg_1;
        }
        public function set type(_arg_1:String):void
        {
            this._type = _arg_1;
        }
        public function set name(_arg_1:String):void
        {
            this._name = _arg_1;
        }
        public function set description(_arg_1:String):void
        {
            this._description = _arg_1;
        }
        public function set showOwnerName(_arg_1:Boolean):void
        {
            this._showOwnerName = _arg_1;
        }
        public function set allowTrading(_arg_1:Boolean):void
        {
            this._allowTrading = _arg_1;
        }
        public function set categoryAlertKey(_arg_1:Boolean):void
        {
            this._categoryAlertKey = _arg_1;
        }
        public function set password(_arg_1:String):void
        {
            this._password = _arg_1;
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.navigator

// RoomSettingsFlatInfo = "_-0K6" (String#14847, DoABC#2)
// doorMode = "_-2zu" (String#21456, DoABC#2)
// _SafeStr_4148 = "_-1IG" (String#17204, DoABC#2)
// _SafeStr_4188 = "_-1xJ" (String#18860, DoABC#2)
// ownerName = "_-1e1" (String#1730, DoABC#2)
// _description = "_-1a7" (String#164, DoABC#2)
// _SafeStr_5334 = "_-25s" (String#19252, DoABC#2)
// _password = "_-1Is" (String#17231, DoABC#2)
// _doorMode = "_-83" (String#926, DoABC#2)
// allowTrading = "_-0ZL" (String#15416, DoABC#2)
// _allowTrading = "_-2Pj" (String#6556, DoABC#2)
// _allowFurniMoving = "_-0wv" (String#16307, DoABC#2)
// _showOwnerName = "_-05L" (String#14257, DoABC#2)
// _categoryAlertKey = "_-1oV" (String#18477, DoABC#2)
// allowFurniMoving = "_-29d" (String#19389, DoABC#2)
// showOwnerName = "_-7T" (String#22521, DoABC#2)
// categoryAlertKey = "_-33Z" (String#21644, DoABC#2)


