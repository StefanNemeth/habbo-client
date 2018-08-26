
package com.sulake.habbo.ui.widget.events
{
    import flash.display.BitmapData;

    public class RoomWidgetPetPackageUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWOPPUE_OPEN_PET_PACKAGE_REQUESTED:String = "RWOPPUE_OPEN_PET_PACKAGE_REQUESTED";
        public static const RWOPPUE_OPEN_PET_PACKAGE_RESULT:String = "RWOPPUE_OPEN_PET_PACKAGE_RESULT";
        public static const RWOPPUE_OPEN_PET_PACKAGE_UPDATE_PET_IMAGE:String = "RWOPPUE_OPEN_PET_PACKAGE_UPDATE_PET_IMAGE";

        private var _objectId:int = -1;
        private var _image:BitmapData = null;
        private var _nameValidationStatus:int = 0;
        private var _nameValidationInfo:String = null;

        public function RoomWidgetPetPackageUpdateEvent(_arg_1:String, _arg_2:int, _arg_3:BitmapData, _arg_4:int, _arg_5:String, _arg_6:Boolean=false, _arg_7:Boolean=false)
        {
            super(_arg_1, _arg_6, _arg_7);
            this._objectId = _arg_2;
            this._image = _arg_3;
            this._nameValidationStatus = _arg_4;
            this._nameValidationInfo = _arg_5;
        }
        public function get nameValidationStatus():int
        {
            return (this._nameValidationStatus);
        }
        public function get nameValidationInfo():String
        {
            return (this._nameValidationInfo);
        }
        public function get image():BitmapData
        {
            return (this._image);
        }
        public function get objectId():int
        {
            return (this._objectId);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetPetPackageUpdateEvent = "_-2N6" (String#6503, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// _image = "_-35u" (String#78, DoABC#2)
// _nameValidationStatus = "_-1hU" (String#1745, DoABC#2)
// _nameValidationInfo = "_-2R" (String#619, DoABC#2)
// RWOPPUE_OPEN_PET_PACKAGE_REQUESTED = "_-0lb" (String#15884, DoABC#2)
// RWOPPUE_OPEN_PET_PACKAGE_RESULT = "_-0zY" (String#16409, DoABC#2)
// RWOPPUE_OPEN_PET_PACKAGE_UPDATE_PET_IMAGE = "_-tS" (String#24425, DoABC#2)


