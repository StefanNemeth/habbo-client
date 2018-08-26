
package com.sulake.habbo.ui.widget.events
{
    import flash.display.BitmapData;

    public class RoomWidgetUserFigureUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWUTUE_USER_FIGURE:String = "RWUTUE_USER_FIGURE";

        private var _userId:int;
        private var _image:BitmapData;
        private var _isOwnUser:Boolean;
        private var _customInfo:String = "";
        private var _achievementScore:int;

        public function RoomWidgetUserFigureUpdateEvent(_arg_1:int, _arg_2:BitmapData, _arg_3:Boolean, _arg_4:String, _arg_5:int, _arg_6:Boolean=false, _arg_7:Boolean=false)
        {
            super(RWUTUE_USER_FIGURE, _arg_6, _arg_7);
            this._userId = _arg_1;
            this._image = _arg_2;
            this._isOwnUser = _arg_3;
            this._customInfo = _arg_4;
            this._achievementScore = _arg_5;
        }
        public function get userId():int
        {
            return (this._userId);
        }
        public function get image():BitmapData
        {
            return (this._image);
        }
        public function get isOwnUser():Boolean
        {
            return (this._isOwnUser);
        }
        public function get customInfo():String
        {
            return (this._customInfo);
        }
        public function get achievementScore():int
        {
            return (this._achievementScore);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// _isOwnUser = "_-1AC" (String#5081, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetUserFigureUpdateEvent = "_-3DM" (String#22010, DoABC#2)
// achievementScore = "_-16Z" (String#5005, DoABC#2)
// _customInfo = "_-290" (String#1821, DoABC#2)
// _achievementScore = "_-2Iu" (String#449, DoABC#2)
// customInfo = "_-2Mk" (String#19916, DoABC#2)
// _image = "_-35u" (String#78, DoABC#2)
// RWUTUE_USER_FIGURE = "_-0QV" (String#15081, DoABC#2)
// isOwnUser = "_-Je" (String#22991, DoABC#2)


