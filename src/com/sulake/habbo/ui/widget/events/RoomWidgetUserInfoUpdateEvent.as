
package com.sulake.habbo.ui.widget.events
{
    import flash.display.BitmapData;

    public class RoomWidgetUserInfoUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWUIUE_OWN_USER:String = "RWUIUE_OWN_USER";
        public static const BOT:String = "RWUIUE_BOT";
        public static const RWUIUE_PEER:String = "RWUIUE_PEER";
        public static const TRADE_REASON_OK:int = 0;
        public static const _SafeStr_6864:int = 2;
        public static const _SafeStr_6865:int = 3;
        public static const BOT:String = "BOT";

        private var _name:String = "";
        private var _motto:String = "";
        private var _achievementScore:int;
        private var _webID:int = 0;
        private var _xp:int = 0;
        private var _figure:String = "";
        private var _image:BitmapData = null;
        private var _badges:Array;
        private var _groupId:int = 0;
        private var _groupBadgeId:String = "";
        private var _carryItem:int = 0;
        private var _userRoomId:int = 0;
        private var _isSpectatorMode:Boolean = false;
        private var _realName:String = "";
        private var _allowNameChange:Boolean = false;
        private var _canBeAskedAsFriend:Boolean = false;
        private var _canBeKicked:Boolean = true;
        private var _respectLeft:int = 0;
        private var _isIgnored:Boolean = false;
        private var _amIOwner:Boolean = false;
        private var _amIController:Boolean = false;
        private var _amIAnyRoomController:Boolean = false;
        private var _hasFlatControl:Boolean = false;
        private var _canTrade:Boolean = false;
        private var _canTradeReason:int = 0;
        private var _isRoomOwner:Boolean = false;

        public function RoomWidgetUserInfoUpdateEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            this._badges = [];
            super(_arg_1, _arg_2, _arg_3);
        }
        public function set name(_arg_1:String):void
        {
            this._name = _arg_1;
        }
        public function get name():String
        {
            return (this._name);
        }
        public function set motto(_arg_1:String):void
        {
            this._motto = _arg_1;
        }
        public function get motto():String
        {
            return (this._motto);
        }
        public function set achievementScore(_arg_1:int):void
        {
            this._achievementScore = _arg_1;
        }
        public function get achievementScore():int
        {
            return (this._achievementScore);
        }
        public function set webID(_arg_1:int):void
        {
            this._webID = _arg_1;
        }
        public function get webID():int
        {
            return (this._webID);
        }
        public function set xp(_arg_1:int):void
        {
            this._xp = _arg_1;
        }
        public function get xp():int
        {
            return (this._xp);
        }
        public function set figure(_arg_1:String):void
        {
            this._figure = _arg_1;
        }
        public function get figure():String
        {
            return (this._figure);
        }
        public function set image(_arg_1:BitmapData):void
        {
            this._image = _arg_1;
        }
        public function get image():BitmapData
        {
            return (this._image);
        }
        public function set badges(_arg_1:Array):void
        {
            this._badges = _arg_1;
        }
        public function get badges():Array
        {
            return (this._badges);
        }
        public function set groupId(_arg_1:int):void
        {
            this._groupId = _arg_1;
        }
        public function get groupId():int
        {
            return (this._groupId);
        }
        public function set groupBadgeId(_arg_1:String):void
        {
            this._groupBadgeId = _arg_1;
        }
        public function get groupBadgeId():String
        {
            return (this._groupBadgeId);
        }
        public function set canBeAskedAsFriend(_arg_1:Boolean):void
        {
            this._canBeAskedAsFriend = _arg_1;
        }
        public function get canBeAskedAsFriend():Boolean
        {
            return (this._canBeAskedAsFriend);
        }
        public function set respectLeft(_arg_1:int):void
        {
            this._respectLeft = _arg_1;
        }
        public function get respectLeft():int
        {
            return (this._respectLeft);
        }
        public function set isIgnored(_arg_1:Boolean):void
        {
            this._isIgnored = _arg_1;
        }
        public function get isIgnored():Boolean
        {
            return (this._isIgnored);
        }
        public function set amIOwner(_arg_1:Boolean):void
        {
            this._amIOwner = _arg_1;
        }
        public function get amIOwner():Boolean
        {
            return (this._amIOwner);
        }
        public function set amIController(_arg_1:Boolean):void
        {
            this._amIController = _arg_1;
        }
        public function get amIController():Boolean
        {
            return (this._amIController);
        }
        public function set amIAnyRoomController(_arg_1:Boolean):void
        {
            this._amIAnyRoomController = _arg_1;
        }
        public function get amIAnyRoomController():Boolean
        {
            return (this._amIAnyRoomController);
        }
        public function set hasFlatControl(_arg_1:Boolean):void
        {
            this._hasFlatControl = _arg_1;
        }
        public function get hasFlatControl():Boolean
        {
            return (this._hasFlatControl);
        }
        public function set canTrade(_arg_1:Boolean):void
        {
            this._canTrade = _arg_1;
        }
        public function get canTrade():Boolean
        {
            return (this._canTrade);
        }
        public function set canTradeReason(_arg_1:int):void
        {
            this._canTradeReason = _arg_1;
        }
        public function get canTradeReason():int
        {
            return (this._canTradeReason);
        }
        public function set canBeKicked(_arg_1:Boolean):void
        {
            this._canBeKicked = _arg_1;
        }
        public function get canBeKicked():Boolean
        {
            return (this._canBeKicked);
        }
        public function set isRoomOwner(_arg_1:Boolean):void
        {
            this._isRoomOwner = _arg_1;
        }
        public function get isRoomOwner():Boolean
        {
            return (this._isRoomOwner);
        }
        public function set carryItem(_arg_1:int):void
        {
            this._carryItem = _arg_1;
        }
        public function get carryItem():int
        {
            return (this._carryItem);
        }
        public function set userRoomId(_arg_1:int):void
        {
            this._userRoomId = _arg_1;
        }
        public function get userRoomId():int
        {
            return (this._userRoomId);
        }
        public function set isSpectatorMode(_arg_1:Boolean):void
        {
            this._isSpectatorMode = _arg_1;
        }
        public function get isSpectatorMode():Boolean
        {
            return (this._isSpectatorMode);
        }
        public function set realName(_arg_1:String):void
        {
            this._realName = _arg_1;
        }
        public function get realName():String
        {
            return (this._realName);
        }
        public function set allowNameChange(_arg_1:Boolean):void
        {
            this._allowNameChange = _arg_1;
        }
        public function get allowNameChange():Boolean
        {
            return (this._allowNameChange);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// _isRoomOwner = "_-1fq" (String#1738, DoABC#2)
// _isSpectatorMode = "_-FL" (String#7978, DoABC#2)
// _groupBadgeId = "_-33" (String#7366, DoABC#2)
// _carryItem = "_-2IR" (String#6411, DoABC#2)
// _userRoomId = "_-Og" (String#8177, DoABC#2)
// _canBeAskedAsFriend = "_-0i5" (String#15752, DoABC#2)
// _canBeKicked = "_-11i" (String#16526, DoABC#2)
// _isIgnored = "_-0c8" (String#15520, DoABC#2)
// _amIOwner = "_-390" (String#21845, DoABC#2)
// _amIController = "_-0BL" (String#14498, DoABC#2)
// _amIAnyRoomController = "_-2pL" (String#21052, DoABC#2)
// _hasFlatControl = "_-1DF" (String#16993, DoABC#2)
// _canTrade = "_-Ky" (String#23043, DoABC#2)
// _canTradeReason = "_-1yM" (String#18903, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetUserInfoUpdateEvent = "_-28z" (String#6226, DoABC#2)
// _groupId = "_-nB" (String#641, DoABC#2)
// _motto = "_-2ti" (String#453, DoABC#2)
// webID = "_-2uI" (String#7166, DoABC#2)
// achievementScore = "_-16Z" (String#5005, DoABC#2)
// _figure = "_-20u" (String#75, DoABC#2)
// _achievementScore = "_-2Iu" (String#449, DoABC#2)
// _respectLeft = "_-1Pr" (String#853, DoABC#2)
// realName = "_-3HH" (String#922, DoABC#2)
// respectLeft = "_-2Yo" (String#6743, DoABC#2)
// RWUIUE_OWN_USER = "_-13K" (String#16592, DoABC#2)
// _image = "_-35u" (String#78, DoABC#2)
// _badges = "_-0Gg" (String#298, DoABC#2)
// _webID = "_-1Ez" (String#1639, DoABC#2)
// _xp = "_-0GE" (String#1441, DoABC#2)
// RWUIUE_PEER = "_-2Tv" (String#20195, DoABC#2)
// isRoomOwner = "_-ZP" (String#8405, DoABC#2)
// isSpectatorMode = "_-10C" (String#4874, DoABC#2)
// allowNameChange = "_-KQ" (String#23022, DoABC#2)
// amIAnyRoomController = "_-09r" (String#14441, DoABC#2)
// amIController = "_-01W" (String#14111, DoABC#2)
// amIOwner = "_-15r" (String#16691, DoABC#2)
// canBeAskedAsFriend = "_-0c9" (String#15521, DoABC#2)
// canBeKicked = "_-34-" (String#21658, DoABC#2)
// canTrade = "_-07S" (String#14342, DoABC#2)
// canTradeReason = "_-01A" (String#14098, DoABC#2)
// hasFlatControl = "_-282" (String#19332, DoABC#2)
// isIgnored = "_-0NV" (String#4031, DoABC#2)
// _allowNameChange = "_-21h" (String#1802, DoABC#2)
// _SafeStr_6864 = "_-19C" (String#16825, DoABC#2)
// _SafeStr_6865 = "_-2u2" (String#21240, DoABC#2)
// carryItem = "_-0WF" (String#15289, DoABC#2)
// BOT = "_-1T3" (String#17627, DoABC#2)
// groupBadgeId = "_-s" (String#24362, DoABC#2)


