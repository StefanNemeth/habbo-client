
package com.sulake.habbo.ui.widget.infostand
{
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;

    public class InfostandUserData 
    {

        private var _userId:int = 0;
        private var _userName:String = "";
        private var _badges:Array;
        private var _groupId:int = 0;
        private var _groupBadgeId:String = "";
        private var _respectLeft:int = 0;
        private var _carryItem:int = 0;
        private var _userRoomId:int = 0;
        private var _type:String;
        private var _petRespectLeft:int = 0;

        public function InfostandUserData()
        {
            this._badges = [];
            super();
        }
        public function set userId(_arg_1:int):void
        {
            this._userId = _arg_1;
        }
        public function set userName(_arg_1:String):void
        {
            this._userName = _arg_1;
        }
        public function set badges(_arg_1:Array):void
        {
            this._badges = _arg_1;
        }
        public function set groupId(_arg_1:int):void
        {
            this._groupId = _arg_1;
        }
        public function set groupBadgeId(_arg_1:String):void
        {
            this._groupBadgeId = _arg_1;
        }
        public function set respectLeft(_arg_1:int):void
        {
            this._respectLeft = _arg_1;
        }
        public function set carryItem(_arg_1:int):void
        {
            this._carryItem = _arg_1;
        }
        public function set userRoomId(_arg_1:int):void
        {
            this._userRoomId = _arg_1;
        }
        public function set type(_arg_1:String):void
        {
            this._type = _arg_1;
        }
        public function set petRespectLeft(_arg_1:int):void
        {
            this._petRespectLeft = _arg_1;
        }
        public function get userId():int
        {
            return (this._userId);
        }
        public function get userName():String
        {
            return (this._userName);
        }
        public function get badges():Array
        {
            return (this._badges.slice());
        }
        public function get groupId():int
        {
            return (this._groupId);
        }
        public function get groupBadgeId():String
        {
            return (this._groupBadgeId);
        }
        public function get respectLeft():int
        {
            return (this._respectLeft);
        }
        public function get carryItem():int
        {
            return (this._carryItem);
        }
        public function get userRoomId():int
        {
            return (this._userRoomId);
        }
        public function get type():String
        {
            return (this._type);
        }
        public function get petRespectLeft():int
        {
            return (this._petRespectLeft);
        }
        public function isBot():Boolean
        {
            return ((this.type == RoomWidgetUserInfoUpdateEvent.BOT));
        }
        public function setData(_arg_1:RoomWidgetUserInfoUpdateEvent):void
        {
            this.userId = _arg_1.webID;
            this.userName = _arg_1.name;
            this.badges = _arg_1.badges;
            this.groupId = _arg_1.groupId;
            this.groupBadgeId = _arg_1.groupBadgeId;
            this.respectLeft = _arg_1.respectLeft;
            this.carryItem = _arg_1.carryItem;
            this.userRoomId = _arg_1.userRoomId;
            this.type = _arg_1.type;
        }

    }
}//package com.sulake.habbo.ui.widget.infostand

// setData = "_-1x" (String#18846, DoABC#2)
// _groupBadgeId = "_-33" (String#7366, DoABC#2)
// _carryItem = "_-2IR" (String#6411, DoABC#2)
// _userRoomId = "_-Og" (String#8177, DoABC#2)
// isBot = "_-14m" (String#16645, DoABC#2)
// RoomWidgetUserInfoUpdateEvent = "_-28z" (String#6226, DoABC#2)
// InfostandUserData = "_-nJ" (String#8664, DoABC#2)
// _groupId = "_-nB" (String#641, DoABC#2)
// webID = "_-2uI" (String#7166, DoABC#2)
// _respectLeft = "_-1Pr" (String#853, DoABC#2)
// _petRespectLeft = "_-36a" (String#913, DoABC#2)
// respectLeft = "_-2Yo" (String#6743, DoABC#2)
// petRespectLeft = "_-0wV" (String#4782, DoABC#2)
// _badges = "_-0Gg" (String#298, DoABC#2)
// carryItem = "_-0WF" (String#15289, DoABC#2)
// groupBadgeId = "_-s" (String#24362, DoABC#2)


