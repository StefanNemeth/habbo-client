
package com.sulake.habbo.advertisement.events
{
    import flash.events.Event;
    import flash.display.BitmapData;

    public class AdEvent extends Event 
    {

        public static const AE_ROOM_AD_IMAGE_LOADED:String = "AE_ROOM_AD_IMAGE_LOADED";
        public static const AE_ROOM_AD_IMAGE_LOADING_FAILED:String = "AE_ROOM_AD_IMAGE_LOADING_FAILED";
        public static const AE_ROOM_AD_SHOW:String = "AE_ROOM_AD_SHOW";

        private var _image:BitmapData;
        private var _roomId:int;
        private var _roomCategory:int;
        private var _imageUrl:String;
        private var _clickUrl:String;
        private var _adWarningL:BitmapData;
        private var _adWarningR:BitmapData;
        private var _objectId:int;
        private var _objectCategory:int;

        public function AdEvent(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:BitmapData=null, _arg_5:String="", _arg_6:String="", _arg_7:BitmapData=null, _arg_8:BitmapData=null, _arg_9:int=-1, _arg_10:int=-1, _arg_11:Boolean=false, _arg_12:Boolean=false)
        {
            super(_arg_1, _arg_11, _arg_12);
            this._image = _arg_4;
            this._roomId = _arg_2;
            this._roomCategory = _arg_3;
            this._imageUrl = _arg_5;
            this._clickUrl = _arg_6;
            this._adWarningL = _arg_7;
            this._adWarningR = _arg_8;
            this._objectId = _arg_9;
            this._objectCategory = _arg_10;
        }
        public function get image():BitmapData
        {
            return (this._image);
        }
        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }
        public function get imageUrl():String
        {
            return (this._imageUrl);
        }
        public function get clickUrl():String
        {
            return (this._clickUrl);
        }
        public function get adWarningL():BitmapData
        {
            return (this._adWarningL);
        }
        public function get adWarningR():BitmapData
        {
            return (this._adWarningR);
        }
        public function get objectId():int
        {
            return (this._objectId);
        }
        public function get objectCategory():int
        {
            return (this._objectCategory);
        }

    }
}//package com.sulake.habbo.advertisement.events

// _objectId = "_-1YP" (String#18, DoABC#2)
// _objectCategory = "_-2Bf" (String#367, DoABC#2)
// _image = "_-35u" (String#78, DoABC#2)
// _clickUrl = "_-2-C" (String#303, DoABC#2)
// AE_ROOM_AD_IMAGE_LOADED = "_-1jE" (String#18253, DoABC#2)
// AE_ROOM_AD_IMAGE_LOADING_FAILED = "_-27D" (String#19300, DoABC#2)
// AE_ROOM_AD_SHOW = "_-18f" (String#16799, DoABC#2)
// _adWarningL = "_-0Bq" (String#14521, DoABC#2)
// _adWarningR = "_-70" (String#22501, DoABC#2)
// adWarningR = "_-1PS" (String#17486, DoABC#2)
// AdEvent = "_-1xT" (String#18868, DoABC#2)


