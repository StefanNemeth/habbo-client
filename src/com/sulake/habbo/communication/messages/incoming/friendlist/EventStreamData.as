
package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class EventStreamData 
    {

        public static const _SafeStr_10771:uint = 0;
        public static const _SafeStr_10772:uint = 1;
        public static const _SafeStr_10773:uint = 2;
        public static const _SafeStr_10774:uint = 3;
        public static const _SafeStr_10775:uint = 3;
        public static const _SafeStr_10776:int = 0;
        public static const _SafeStr_10777:int = 1;
        public static const _SafeStr_10778:int = 2;
        public static const _SafeStr_10779:int = 3;
        public static const LINK_TARGET_OPEN_MOTTO_CHANGER:int = 4;
        public static const _SafeStr_10780:int = 5;

        private var _id:int;
        private var _actionId:int;
        private var _accountId:String;
        private var _accountName:String;
        private var _accountGender:String;
        private var _imageFilePath:String;
        private var _minutesSinceEvent:int;
        private var _linkTargetType:int;
        private var _numberOfLikes:int;
        private var _isLikable:Boolean;
        private var _extraDataStruct:Object;

        public function EventStreamData(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:String, _arg_7:int, _arg_8:int, _arg_9:int, _arg_10:Boolean, _arg_11:IMessageDataWrapper)
        {
            this._id = _arg_1;
            this._actionId = _arg_2;
            this._accountId = _arg_3;
            this._accountName = _arg_4;
            this._accountGender = _arg_5;
            this._imageFilePath = _arg_6;
            this._minutesSinceEvent = _arg_7;
            this._linkTargetType = _arg_8;
            this._numberOfLikes = _arg_9;
            this._isLikable = _arg_10;
            this._extraDataStruct = parse(_arg_2, _arg_11);
        }
        protected static function parse(_arg_1:int, _arg_2:IMessageDataWrapper):Object
        {
            var _local_3:Object = new Object();
            switch (_arg_1){
                case _SafeStr_10771:
                    _local_3.friendId = _arg_2.readString();
                    _local_3.friendName = _arg_2.readString();
                    break;
                case _SafeStr_10772:
                    _local_3.roomId = _arg_2.readString();
                    _local_3.roomName = _arg_2.readString();
                    break;
                case _SafeStr_10773:
                    _local_3.achievementCode = _arg_2.readString();
                    break;
                case _SafeStr_10774:
                    _local_3.motto = _arg_2.readString();
            };
            return (_local_3);
        }

        public function get id():int
        {
            return (this._id);
        }
        public function get actionId():int
        {
            return (this._actionId);
        }
        public function get accountId():String
        {
            return (this._accountId);
        }
        public function get accountName():String
        {
            return (this._accountName);
        }
        public function get imageFilePath():String
        {
            return (this._imageFilePath);
        }
        public function get minutesSinceEvent():int
        {
            return (this._minutesSinceEvent);
        }
        public function get linkTargetType():int
        {
            return (this._linkTargetType);
        }
        public function get numberOfLikes():int
        {
            return (this._numberOfLikes);
        }
        public function get isLikable():Boolean
        {
            return (this._isLikable);
        }
        public function get extraDataStruct():Object
        {
            return (this._extraDataStruct);
        }
        public function get accountGender():String
        {
            return (this._accountGender);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.friendlist

class Struct 
{

}
class FriendMadeStruct extends Struct 
{

    public var friendId:String;
    public var friendName:String;

    public function FriendMadeStruct(_arg_1:String, _arg_2:String)
    {
        this.friendId = _arg_1;
        this.friendName = _arg_2;
    }
}
class RoomLikedStruct extends Struct 
{

    public var roomId:String;
    public var roomName:String;

    public function RoomLikedStruct(_arg_1:String, _arg_2:String)
    {
        this.roomId = _arg_1;
        this.roomName = _arg_2;
    }
}
class AchievementEarnedStruct extends Struct 
{

    public var achievementCode:String;

    public function AchievementEarnedStruct(_arg_1:String)
    {
        this.achievementCode = _arg_1;
    }
}

// _SafeStr_10771 = "_-kc" (String#24054, DoABC#2)
// _SafeStr_10772 = "_-3Ji" (String#22272, DoABC#2)
// _SafeStr_10773 = "_-Rp" (String#23317, DoABC#2)
// _SafeStr_10774 = "_-2Sx" (String#20159, DoABC#2)
// _SafeStr_10775 = "_-1N5" (String#17403, DoABC#2)
// _SafeStr_10776 = "_-QJ" (String#23263, DoABC#2)
// _SafeStr_10777 = "_-SO" (String#23341, DoABC#2)
// _SafeStr_10778 = "_-056" (String#14247, DoABC#2)
// _SafeStr_10779 = "_-0X5" (String#15318, DoABC#2)
// _SafeStr_10780 = "_-16V" (String#16718, DoABC#2)
// _actionId = "_-2oX" (String#21025, DoABC#2)
// _accountId = "_-1Bk" (String#16932, DoABC#2)
// _accountName = "_-1SK" (String#17595, DoABC#2)
// _accountGender = "_-3A" (String#21885, DoABC#2)
// _imageFilePath = "_-1i6" (String#5712, DoABC#2)
// _minutesSinceEvent = "_-2WI" (String#20296, DoABC#2)
// _linkTargetType = "_-2sT" (String#21177, DoABC#2)
// _numberOfLikes = "_-0oA" (String#15982, DoABC#2)
// _isLikable = "_-bF" (String#23679, DoABC#2)
// _extraDataStruct = "_-31v" (String#21575, DoABC#2)
// actionId = "_-05Y" (String#14265, DoABC#2)
// accountId = "_-dV" (String#23781, DoABC#2)
// accountName = "_-0Bf" (String#14514, DoABC#2)
// imageFilePath = "_-18y" (String#16814, DoABC#2)
// minutesSinceEvent = "_-0ik" (String#15782, DoABC#2)
// linkTargetType = "_-26M" (String#19268, DoABC#2)
// numberOfLikes = "_-aS" (String#23651, DoABC#2)
// isLikable = "_-0TJ" (String#15183, DoABC#2)
// accountGender = "_-0Dw" (String#14604, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)


