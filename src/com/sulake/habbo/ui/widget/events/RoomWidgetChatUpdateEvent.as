
package com.sulake.habbo.ui.widget.events
{
    import flash.display.BitmapData;

    public class RoomWidgetChatUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWCUE_EVENT_CHAT:String = "RWCUE_EVENT_CHAT";
        public static const _SafeStr_3620:int = 0;
        public static const _SafeStr_3621:int = 1;
        public static const _SafeStr_3622:int = 2;
        public static const _SafeStr_4788:int = 3;
        public static const _SafeStr_4789:int = 4;

        private var _userId:int = 0;
        private var _text:String = "";
        private var _chatType:int = 0;
        private var _userName:String;
        private var _links:Array;
        private var _userX:Number;
        private var _userY:Number;
        private var _userImage:BitmapData;
        private var _userColor:uint;
        private var _roomId:int;
        private var _roomCategory:int;
        private var _userCategory:int;

        public function RoomWidgetChatUpdateEvent(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:String, _arg_5:int, _arg_6:Number, _arg_7:Number, _arg_8:BitmapData, _arg_9:uint, _arg_10:int, _arg_11:int, _arg_12:int=0, _arg_13:Array=null, _arg_14:Boolean=false, _arg_15:Boolean=false)
        {
            super(_arg_1, _arg_14, _arg_15);
            this._userId = _arg_2;
            this._text = _arg_3;
            this._chatType = _arg_12;
            this._userName = _arg_4;
            this._userCategory = _arg_5;
            this._links = _arg_13;
            this._userX = _arg_6;
            this._userY = _arg_7;
            this._userImage = _arg_8;
            this._userColor = _arg_9;
            this._roomId = _arg_10;
            this._roomCategory = _arg_11;
        }
        public function get userId():int
        {
            return (this._userId);
        }
        public function get text():String
        {
            return (this._text);
        }
        public function get chatType():int
        {
            return (this._chatType);
        }
        public function get userName():String
        {
            return (this._userName);
        }
        public function get userCategory():int
        {
            return (this._userCategory);
        }
        public function get links():Array
        {
            return (this._links);
        }
        public function get userX():Number
        {
            return (this._userX);
        }
        public function get userY():Number
        {
            return (this._userY);
        }
        public function get userImage():BitmapData
        {
            return (this._userImage);
        }
        public function get userColor():uint
        {
            return (this._userColor);
        }
        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// _userX = "_-kU" (String#24051, DoABC#2)
// _userY = "_-5P" (String#22440, DoABC#2)
// _userImage = "_-sh" (String#24387, DoABC#2)
// _userColor = "_-0XT" (String#15333, DoABC#2)
// _userCategory = "_-0Kr" (String#14873, DoABC#2)
// userCategory = "_-1Fd" (String#17100, DoABC#2)
// userY = "_-3Je" (String#22270, DoABC#2)
// userImage = "_-tl" (String#24438, DoABC#2)
// userColor = "_-lM" (String#24081, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// _SafeStr_3620 = "_-xF" (String#24578, DoABC#2)
// _SafeStr_3621 = "_-0Bz" (String#14526, DoABC#2)
// _SafeStr_3622 = "_-0O5" (String#14992, DoABC#2)
// _chatType = "_-0Dp" (String#812, DoABC#2)
// chatType = "_-TQ" (String#23382, DoABC#2)
// _SafeStr_4788 = "_-1rK" (String#18597, DoABC#2)
// _SafeStr_4789 = "_-2ut" (String#21273, DoABC#2)
// _links = "_-Qt" (String#2105, DoABC#2)
// RWCUE_EVENT_CHAT = "_-02A" (String#14133, DoABC#2)


