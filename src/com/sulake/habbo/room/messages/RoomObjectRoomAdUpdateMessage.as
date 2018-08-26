
package com.sulake.habbo.room.messages
{
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import flash.display.BitmapData;

    public class RoomObjectRoomAdUpdateMessage extends RoomObjectUpdateMessage 
    {

        public static const RORUM_ROOM_AD_ACTIVATE:String = "RORUM_ROOM_AD_ACTIVATE";
        public static const RORUM_ROOM_BILLBOARD_IMAGE_LOADED:String = "RORUM_ROOM_BILLBOARD_IMAGE_LOADED";
        public static const RORUM_ROOM_BILLBOARD_IMAGE_LOADING_FAILED:String = "RORUM_ROOM_BILLBOARD_IMAGE_LOADING_FAILED";

        private var _type:String;
        private var _asset:String;
        private var _clickUrl:String;
        private var _objectId:int;
        private var _bitmapData:BitmapData;

        public function RoomObjectRoomAdUpdateMessage(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:int=-1, _arg_5:BitmapData=null)
        {
            super(null, null);
            this._type = _arg_1;
            this._asset = _arg_2;
            this._clickUrl = _arg_3;
            this._objectId = _arg_4;
            this._bitmapData = _arg_5;
        }
        public function get type():String
        {
            return (this._type);
        }
        public function get asset():String
        {
            return (this._asset);
        }
        public function get clickUrl():String
        {
            return (this._clickUrl);
        }
        public function get objectId():int
        {
            return (this._objectId);
        }
        public function get bitmapData():BitmapData
        {
            return (this._bitmapData);
        }

    }
}//package com.sulake.habbo.room.messages

// RoomObjectUpdateMessage = "_-73" (String#22503, DoABC#2)
// RoomObjectRoomAdUpdateMessage = "_-070" (String#14324, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// _asset = "_-1S7" (String#442, DoABC#2)
// _clickUrl = "_-2-C" (String#303, DoABC#2)
// RORUM_ROOM_AD_ACTIVATE = "_-1jv" (String#18281, DoABC#2)
// RORUM_ROOM_BILLBOARD_IMAGE_LOADED = "_-MO" (String#23100, DoABC#2)
// RORUM_ROOM_BILLBOARD_IMAGE_LOADING_FAILED = "_-1jn" (String#18276, DoABC#2)


