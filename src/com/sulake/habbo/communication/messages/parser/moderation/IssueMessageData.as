
package com.sulake.habbo.communication.messages.parser.moderation
{
    public class IssueMessageData 
    {

        public static const _SafeStr_7173:int = 1;
        public static const _SafeStr_7174:int = 2;
        public static const _SafeStr_7175:int = 3;

        private var _issueId:int;
        private var _state:int;
        private var _categoryId:int;
        private var _reportedCategoryId:int;
        private var _timeStamp:int;
        private var _priority:int;
        private var _temporalPriority:int = 0;
        private var _reporterUserId:int;
        private var _reporterUserName:String;
        private var _reportedUserId:int;
        private var _reportedUserName:String;
        private var _pickerUserId:int;
        private var _pickerUserName:String;
        private var _message:String;
        private var _chatRecordId:int;
        private var _roomName:String;
        private var _roomType:int;
        private var _flatType:String;
        private var _flatId:int;
        private var _flatOwnerName:String;
        private var _roomResources:String;
        private var _unitPort:int;
        private var _worldId:int;

        public function IssueMessageData(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int, _arg_7:int, _arg_8:String, _arg_9:int, _arg_10:String, _arg_11:int, _arg_12:String, _arg_13:String, _arg_14:int, _arg_15:String, _arg_16:int, _arg_17:String, _arg_18:int, _arg_19:String, _arg_20:String, _arg_21:int, _arg_22:int)
        {
            this._issueId = _arg_1;
            this._state = _arg_2;
            this._categoryId = _arg_3;
            this._reportedCategoryId = _arg_4;
            this._timeStamp = _arg_5;
            this._priority = _arg_6;
            this._reporterUserId = _arg_7;
            this._reporterUserName = _arg_8;
            this._reportedUserId = _arg_9;
            this._reportedUserName = _arg_10;
            this._pickerUserId = _arg_11;
            this._pickerUserName = _arg_12;
            this._message = _arg_13;
            this._chatRecordId = _arg_14;
            this._roomName = _arg_15;
            this._roomType = _arg_16;
            this._flatType = _arg_17;
            this._flatId = _arg_18;
            this._flatOwnerName = _arg_19;
            this._roomResources = _arg_20;
            this._unitPort = _arg_21;
            this._worldId = _arg_22;
        }
        public function get issueId():int
        {
            return (this._issueId);
        }
        public function get state():int
        {
            return (this._state);
        }
        public function get categoryId():int
        {
            return (this._categoryId);
        }
        public function get reportedCategoryId():int
        {
            return (this._reportedCategoryId);
        }
        public function get timeStamp():int
        {
            return (this._timeStamp);
        }
        public function get priority():int
        {
            return ((this._priority + this._temporalPriority));
        }
        public function get reporterUserId():int
        {
            return (this._reporterUserId);
        }
        public function get reporterUserName():String
        {
            return (this._reporterUserName);
        }
        public function get reportedUserId():int
        {
            return (this._reportedUserId);
        }
        public function get reportedUserName():String
        {
            return (this._reportedUserName);
        }
        public function get pickerUserId():int
        {
            return (this._pickerUserId);
        }
        public function get pickerUserName():String
        {
            return (this._pickerUserName);
        }
        public function get message():String
        {
            return (this._message);
        }
        public function get chatRecordId():int
        {
            return (this._chatRecordId);
        }
        public function get roomName():String
        {
            return (this._roomName);
        }
        public function get roomType():int
        {
            return (this._roomType);
        }
        public function get flatType():String
        {
            return (this._flatType);
        }
        public function get flatId():int
        {
            return (this._flatId);
        }
        public function get flatOwnerName():String
        {
            return (this._flatOwnerName);
        }
        public function get roomResources():String
        {
            return (this._roomResources);
        }
        public function get unitPort():int
        {
            return (this._unitPort);
        }
        public function get worldId():int
        {
            return (this._worldId);
        }
        public function set temporalPriority(_arg_1:int):void
        {
            this._temporalPriority = _arg_1;
        }
        public function getOpenTime(_arg_1:int):String
        {
            var _local_2:int = ((_arg_1 - this._timeStamp) / 1000);
            var _local_3:int = (_local_2 % 60);
            var _local_4:int = (_local_2 / 60);
            var _local_5:int = (_local_4 % 60);
            var _local_6:int = (_local_4 / 60);
            var _local_7:String = (((_local_3)<10) ? ("0" + _local_3) : ("" + _local_3));
            var _local_8:String = (((_local_5)<10) ? ("0" + _local_5) : ("" + _local_5));
            var _local_9:String = (((_local_6)<10) ? ("0" + _local_6) : ("" + _local_6));
            return (((((_local_9 + ":") + _local_8) + ":") + _local_7));
        }

    }
}//package com.sulake.habbo.communication.messages.parser.moderation

// IssueMessageData = "_-0K1" (String#3952, DoABC#2)
// flatId = "_-3CK" (String#21973, DoABC#2)
// worldId = "_-2Ip" (String#19760, DoABC#2)
// _roomType = "_-2D8" (String#1834, DoABC#2)
// _categoryId = "_-1If" (String#186, DoABC#2)
// _roomName = "_-bX" (String#253, DoABC#2)
// _reportedUserId = "_-0gc" (String#819, DoABC#2)
// _reportedUserName = "_-1yn" (String#6009, DoABC#2)
// _flatId = "_-2Al" (String#135, DoABC#2)
// _chatRecordId = "_-9i" (String#7857, DoABC#2)
// chatRecordId = "_-M6" (String#23087, DoABC#2)
// _worldId = "_-pp" (String#944, DoABC#2)
// _unitPort = "_-0vq" (String#1579, DoABC#2)
// unitPort = "_-2js" (String#20840, DoABC#2)
// _timeStamp = "_-1IA" (String#845, DoABC#2)
// _issueId = "_-1kS" (String#5759, DoABC#2)
// issueId = "_-1yh" (String#18916, DoABC#2)
// _SafeStr_7173 = "_-bS" (String#23691, DoABC#2)
// _SafeStr_7174 = "_-Tr" (String#23401, DoABC#2)
// _SafeStr_7175 = "_-1BF" (String#16908, DoABC#2)
// _temporalPriority = "_-14g" (String#16640, DoABC#2)
// _reporterUserId = "_-1V6" (String#17707, DoABC#2)
// _reporterUserName = "_-0UT" (String#15223, DoABC#2)
// _pickerUserId = "_-jY" (String#8588, DoABC#2)
// _pickerUserName = "_-1ez" (String#18096, DoABC#2)
// _flatType = "_-2vC" (String#21285, DoABC#2)
// _flatOwnerName = "_-091" (String#14410, DoABC#2)
// _roomResources = "_-1mQ" (String#5788, DoABC#2)
// reportedCategoryId = "_-eV" (String#23822, DoABC#2)
// reporterUserId = "_-8I" (String#22554, DoABC#2)
// reporterUserName = "_-2fY" (String#20671, DoABC#2)
// pickerUserId = "_-4E" (String#22387, DoABC#2)
// pickerUserName = "_-6G" (String#22476, DoABC#2)
// flatType = "_-0DY" (String#14590, DoABC#2)
// flatOwnerName = "_-2TE" (String#20172, DoABC#2)
// roomResources = "_-9r" (String#7860, DoABC#2)
// temporalPriority = "_-1v7" (String#18761, DoABC#2)
// getOpenTime = "_-P3" (String#23209, DoABC#2)


