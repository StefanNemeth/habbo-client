
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetOpenPetPackageMessage extends RoomWidgetMessage 
    {

        public static const RWOPPM_OPEN_PET_PACKAGE:String = "RWOPPM_OPEN_PET_PACKAGE";

        private var _objectId:int;
        private var _name:String;

        public function RoomWidgetOpenPetPackageMessage(_arg_1:String, _arg_2:int, _arg_3:String)
        {
            super(_arg_1);
            this._objectId = _arg_2;
            this._name = _arg_3;
        }
        public function get objectId():int
        {
            return (this._objectId);
        }
        public function get name():String
        {
            return (this._name);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetOpenPetPackageMessage = "_-0jy" (String#4501, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// RWOPPM_OPEN_PET_PACKAGE = "_-2Bv" (String#19479, DoABC#2)


