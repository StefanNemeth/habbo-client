
package com.sulake.habbo.ui.widget.events
{
    import flash.display.BitmapData;

    public class RoomWidgetFurniInfoUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWFIUE_FURNI:String = "RWFIUE_FURNI";

        private var _id:int = 0;
        private var _category:int = 0;
        private var _name:String = "";
        private var _description:String = "";
        private var _image:BitmapData = null;
        private var _isWallItem:Boolean = false;
        private var _isStickie:Boolean = false;
        private var _isRoomOwner:Boolean = false;
        private var _isRoomController:Boolean = false;
        private var _isAnyRoomController:Boolean = false;
        private var _expiration:int = -1;
        private var _catalogPageId:int = -1;
        private var _offerId:int = -1;
        private var _extraParam:String = "";

        public function RoomWidgetFurniInfoUpdateEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3);
        }
        public function set id(_arg_1:int):void
        {
            this._id = _arg_1;
        }
        public function get id():int
        {
            return (this._id);
        }
        public function set category(_arg_1:int):void
        {
            this._category = _arg_1;
        }
        public function get category():int
        {
            return (this._category);
        }
        public function set name(_arg_1:String):void
        {
            this._name = _arg_1;
        }
        public function get name():String
        {
            return (this._name);
        }
        public function set description(_arg_1:String):void
        {
            this._description = _arg_1;
        }
        public function get description():String
        {
            return (this._description);
        }
        public function set image(_arg_1:BitmapData):void
        {
            this._image = _arg_1;
        }
        public function get image():BitmapData
        {
            return (this._image);
        }
        public function set isWallItem(_arg_1:Boolean):void
        {
            this._isWallItem = _arg_1;
        }
        public function get isWallItem():Boolean
        {
            return (this._isWallItem);
        }
        public function set isStickie(_arg_1:Boolean):void
        {
            this._isStickie = _arg_1;
        }
        public function get isStickie():Boolean
        {
            return (this._isStickie);
        }
        public function set isRoomOwner(_arg_1:Boolean):void
        {
            this._isRoomOwner = _arg_1;
        }
        public function get isRoomOwner():Boolean
        {
            return (this._isRoomOwner);
        }
        public function set isRoomController(_arg_1:Boolean):void
        {
            this._isRoomController = _arg_1;
        }
        public function get isRoomController():Boolean
        {
            return (this._isRoomController);
        }
        public function set isAnyRoomController(_arg_1:Boolean):void
        {
            this._isAnyRoomController = _arg_1;
        }
        public function get isAnyRoomController():Boolean
        {
            return (this._isAnyRoomController);
        }
        public function set expiration(_arg_1:int):void
        {
            this._expiration = _arg_1;
        }
        public function get expiration():int
        {
            return (this._expiration);
        }
        public function set catalogPageId(_arg_1:int):void
        {
            this._catalogPageId = _arg_1;
        }
        public function get catalogPageId():int
        {
            return (this._catalogPageId);
        }
        public function set offerId(_arg_1:int):void
        {
            this._offerId = _arg_1;
        }
        public function get offerId():int
        {
            return (this._offerId);
        }
        public function set extraParam(_arg_1:String):void
        {
            this._extraParam = _arg_1;
        }
        public function get extraParam():String
        {
            return (this._extraParam);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// _isRoomOwner = "_-1fq" (String#1738, DoABC#2)
// _isRoomController = "_-2YY" (String#6736, DoABC#2)
// _isAnyRoomController = "_-wS" (String#8810, DoABC#2)
// _isWallItem = "_-02w" (String#14158, DoABC#2)
// _isStickie = "_-RT" (String#23303, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetFurniInfoUpdateEvent = "_-1V1" (String#5455, DoABC#2)
// _image = "_-35u" (String#78, DoABC#2)
// _offerId = "_-0i7" (String#125, DoABC#2)
// offerId = "_-9g" (String#928, DoABC#2)
// extraParam = "_-AM" (String#7874, DoABC#2)
// expiration = "_-1G1" (String#1648, DoABC#2)
// _extraParam = "_-2Ad" (String#880, DoABC#2)
// _expiration = "_-2ZN" (String#1901, DoABC#2)
// _description = "_-1a7" (String#164, DoABC#2)
// isRoomController = "_-xz" (String#8838, DoABC#2)
// isRoomOwner = "_-ZP" (String#8405, DoABC#2)
// isAnyRoomController = "_-2IH" (String#6407, DoABC#2)
// RWFIUE_FURNI = "_-U0" (String#23409, DoABC#2)
// catalogPageId = "_-2oc" (String#7050, DoABC#2)
// isStickie = "_-15M" (String#16668, DoABC#2)
// isWallItem = "_-92" (String#22582, DoABC#2)
// _catalogPageId = "_-35n" (String#1999, DoABC#2)


