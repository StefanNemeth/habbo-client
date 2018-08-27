
package com.sulake.habbo.session
{
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import flash.events.IEventDispatcher;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.communication.messages.incoming.room.session.RoomReadyMessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupBadgesMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupsWhereMemberMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupJoinFailedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupBadgesMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsData;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;

    public class HabboGroupInfoManager 
    {

        private var _SafeStr_13621:SessionDataManager;
        private var _communication:IHabboCommunicationManager;
        private var _events:IEventDispatcher;
        private var _badges:Map;
        private var _SafeStr_13622:GroupDetailsView;

        public function HabboGroupInfoManager(_arg_1:SessionDataManager, _arg_2:IEventDispatcher)
        {
            this._SafeStr_13621 = _arg_1;
            this._badges = new Map();
            this._events = _arg_2;
        }
        public function dispose():void
        {
            this._communication = null;
        }
        public function set communication(_arg_1:IHabboCommunicationManager):void
        {
            this._communication = _arg_1;
            this._communication.addHabboConnectionMessageEvent((new RoomReadyMessageEvent(this.onRoomReady) as IMessageEvent));
            this._communication.addHabboConnectionMessageEvent(new HabboGroupBadgesMessageEvent(this.onHabboGroupBadges));
            this._communication.addHabboConnectionMessageEvent(new HabboGroupDetailsMessageEvent(this.onGroupDetails));
            this._communication.addHabboConnectionMessageEvent(new HabboGroupsWhereMemberMessageEvent(this.onGroupsWhereMember));
            this._communication.addHabboConnectionMessageEvent(new HabboGroupJoinFailedMessageEvent(this.onJoinFailed));
            this._communication.addHabboConnectionMessageEvent(new CloseConnectionMessageEvent(this.onRoomExit));
        }
        private function onRoomReady(_arg_1:IMessageEvent):void
        {
            this._communication.getHabboMainConnection(null).send(new GetHabboGroupBadgesMessageComposer());
        }
        private function onHabboGroupBadges(_arg_1:IMessageEvent):void
        {
            var _local_4:int;
            var _local_5:String;
            var _local_2:HabboGroupBadgesMessageEvent = (_arg_1 as HabboGroupBadgesMessageEvent);
            var _local_3:Map = _local_2.badges;
            var _local_6:int;
            while (_local_6 < _local_3.length) {
                _local_4 = _local_3.getKey(_local_6);
                if (this._badges.getValue(_local_4) != null){
                    this._badges.remove(_local_4);
                };
                this._badges.add(_local_4, _local_3.getWithIndex(_local_6));
                _local_6++;
            };
        }
        private function onGroupDetails(_arg_1:IMessageEvent):void
        {
            var _local_2:HabboGroupDetailsData = HabboGroupDetailsMessageEvent(_arg_1).data;
            this.getGroupDetailsView().onGroupDetails(_local_2);
        }
        private function onGroupsWhereMember(_arg_1:IMessageEvent):void
        {
            var _local_2:Array = HabboGroupsWhereMemberMessageEvent(_arg_1).groups;
            this.getGroupDetailsView().onGroups(_local_2);
        }
        private function onJoinFailed(_arg_1:IMessageEvent):void
        {
            var _local_2:int = HabboGroupJoinFailedMessageEvent(_arg_1).reason;
            var _local_3:String = ("group.joinfail." + _local_2);
            var _local_4:String = this._SafeStr_13621.localization.getKey(_local_3, _local_3);
            this._SafeStr_13621.windowManager.alert("${group.joinfail.title}", _local_4, 0, this.onAlertClose);
        }
        private function onRoomExit(_arg_1:IMessageEvent):void
        {
            if (this._SafeStr_13622 != null){
                this._SafeStr_13622.close();
            };
        }
        private function getGroupDetailsView():GroupDetailsView
        {
            if (this._SafeStr_13622 == null){
                this._SafeStr_13622 = new GroupDetailsView(this._SafeStr_13621);
            };
            return (this._SafeStr_13622);
        }
        public function getBadgeId(_arg_1:int):String
        {
            return (this._badges.getValue(_arg_1));
        }
        private function onAlertClose(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
        }

    }
}//package com.sulake.habbo.session

// onAlertClose = "_-34G" (String#309, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// _SafeStr_13621 = "_-2nA" (String#7025, DoABC#2)
// _SafeStr_13622 = "_-0Gs" (String#14713, DoABC#2)
// onHabboGroupBadges = "_-9l" (String#22608, DoABC#2)
// onGroupDetails = "_-u1" (String#8767, DoABC#2)
// onGroupsWhereMember = "_-uh" (String#24479, DoABC#2)
// onJoinFailed = "_-0ZV" (String#15423, DoABC#2)
// getGroupDetailsView = "_-xi" (String#24599, DoABC#2)
// onGroups = "_-2bX" (String#20506, DoABC#2)
// HabboGroupInfoManager = "_-1EL" (String#5150, DoABC#2)
// GroupDetailsView = "_-7M" (String#7812, DoABC#2)
// RoomReadyMessageEvent = "_-1uW" (String#5930, DoABC#2)
// HabboGroupsWhereMemberMessageEvent = "_-1Yk" (String#5538, DoABC#2)
// HabboGroupBadgesMessageEvent = "_-3L2" (String#7723, DoABC#2)
// HabboGroupDetailsMessageEvent = "_-2uh" (String#7173, DoABC#2)
// GetHabboGroupBadgesMessageComposer = "_-1Z4" (String#17854, DoABC#2)
// HabboGroupJoinFailedMessageEvent = "_-1sF" (String#5890, DoABC#2)
// HabboGroupDetailsData = "_-13j" (String#16607, DoABC#2)
// reason = "_-053" (String#14245, DoABC#2)
// communication = "_-3HD" (String#22171, DoABC#2)
// addHabboConnectionMessageEvent = "_-0r" (String#4663, DoABC#2)
// getHabboMainConnection = "_-0AQ" (String#809, DoABC#2)
// _badges = "_-0Gg" (String#298, DoABC#2)
// onRoomReady = "_-0KO" (String#583, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// getBadgeId = "_-Jj" (String#22995, DoABC#2)
// CloseConnectionMessageEvent = "_-2cv" (String#6811, DoABC#2)
// onRoomExit = "_-0Na" (String#356, DoABC#2)


