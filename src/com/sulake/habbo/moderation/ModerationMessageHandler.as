
package com.sulake.habbo.moderation
{
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.communication.messages.incoming.moderation.IssueInfoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorInitMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.IssuePickFailedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.IssueDeletedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorUserInfoEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorRoomInfoEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.CfhChatlogEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.UserChatlogEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.RoomChatlogEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.RoomVisitsEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.PublicSpaceCastLibsEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorActionResultMessageEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.IssueInfoMessageParser;
    import com.sulake.habbo.communication.messages.parser.moderation.IssueMessageData;
    import com.sulake.habbo.communication.messages.parser.moderation.ModeratorInitMessageParser;
    import com.sulake.habbo.communication.messages.parser.moderation.ModeratorInitData;
    import com.sulake.habbo.communication.messages.parser.moderation.IssuePickFailedMessageParser;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.IssueDeletedMessageParser;
    import com.sulake.habbo.communication.messages.parser.moderation.ModeratorUserInfoMessageParser;
    import com.sulake.habbo.communication.messages.parser.moderation.ModeratorRoomInfoMessageParser;
    import com.sulake.habbo.communication.messages.parser.moderation.CfhChatlogMessageParser;
    import flash.utils.Dictionary;
    import com.sulake.habbo.communication.messages.parser.moderation.RoomChatlogMessageParser;
    import com.sulake.habbo.communication.messages.parser.moderation.UserChatlogMessageParser;
    import com.sulake.habbo.communication.messages.parser.moderation.RoomVisitsMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.PublicSpaceCastLibsMessageParser;
    import com.sulake.habbo.communication.messages.parser.moderation.ModeratorActionResultMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.moderator.GetModeratorUserInfoMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.moderation.*;
    import com.sulake.habbo.communication.messages.parser.moderation.*;

    public class ModerationMessageHandler 
    {

        private var _connection:IConnection;
        private var _SafeStr_11757:ModerationManager;
        private var _SafeStr_11758:Array;
        private var _SafeStr_11759:Array;
        private var _SafeStr_11760:Array;
        private var _SafeStr_11761:Array;
        private var _SafeStr_11762:Array;

        public function ModerationMessageHandler(_arg_1:ModerationManager)
        {
            this._SafeStr_11758 = new Array();
            this._SafeStr_11759 = new Array();
            this._SafeStr_11760 = new Array();
            this._SafeStr_11761 = new Array();
            this._SafeStr_11762 = new Array();
            super();
            this._SafeStr_11757 = _arg_1;
            this._connection = _arg_1.connection;
            this._connection.addMessageEvent(new IssueInfoMessageEvent(this.onIssueInfo));
            this._connection.addMessageEvent(new ModeratorInitMessageEvent(this.onModeratorInit));
            this._connection.addMessageEvent(new IssuePickFailedMessageEvent(this.onIssuePickFailed));
            this._connection.addMessageEvent(new IssueDeletedMessageEvent(this.onIssueDeleted));
            this._connection.addMessageEvent(new ModeratorUserInfoEvent(this.InfostandWidget));
            this._connection.addMessageEvent(new ModeratorRoomInfoEvent(this.IncomingMessages));
            this._connection.addMessageEvent(new CfhChatlogEvent(this.onCfhChatlog));
            this._connection.addMessageEvent(new UserChatlogEvent(this.onUserChatlog));
            this._connection.addMessageEvent(new RoomChatlogEvent(this.onRoomChatlog));
            this._connection.addMessageEvent(new RoomVisitsEvent(this.RoomVisitsCtrl));
            this._connection.addMessageEvent(new RoomEntryInfoMessageEvent(this.onRoomEnter));
            this._connection.addMessageEvent(new PublicSpaceCastLibsEvent(this.IncomingMessages));
            this._connection.addMessageEvent(new CloseConnectionMessageEvent(this.HabboGroupInfoManager));
            this._connection.addMessageEvent(new ModeratorActionResultMessageEvent(this.onModeratorActionResult));
        }
        private function onIssueInfo(_arg_1:IssueInfoMessageEvent):void
        {
            if ((((_arg_1 == null)) || ((this._SafeStr_11757 == null)))){
                return;
            };
            var _local_2:IssueInfoMessageParser = _arg_1.getParser();
            if (_local_2 == null){
                return;
            };
            var _local_3:IssueMessageData = _local_2.issueData;
            this._SafeStr_11757.issueManager.playSound(_local_3);
            this._SafeStr_11757.issueManager.updateIssue(_local_3);
        }
        private function onModeratorInit(_arg_1:ModeratorInitMessageEvent):void
        {
            var _local_6:IssueMessageData;
            if ((((_arg_1 == null)) || ((this._SafeStr_11757 == null)))){
                return;
            };
            var _local_2:ModeratorInitMessageParser = _arg_1.getParser();
            if (_local_2 == null){
                return;
            };
            var _local_3:ModeratorInitData = _local_2.data;
            var _local_4:Array = _local_3.issues;
            var _local_5:Array = _local_3.messageTemplates;
            for each (_local_6 in _local_4) {
                this._SafeStr_11757.issueManager.updateIssue(_local_6);
            };
            this._SafeStr_11757.issueManager.updatePriorities();
            this._SafeStr_11757.initMsg = _local_3;
            this._SafeStr_11757.startPanel.show();
        }
        private function onIssuePickFailed(event:IssuePickFailedMessageEvent):void
        {
            var parser:IssuePickFailedMessageParser = event.getParser();
            if (parser == null){
                return;
            };
            var alert:Boolean = true;
            var issues:Array = parser.issues;
            var retryEnabled:Boolean = parser.retryEnabled;
            var retryCount:int = parser.retryCount;
            var pickedAlready:Boolean = this._SafeStr_11757.issueManager.issuePickFailed(issues);
            if (pickedAlready){
                if (retryEnabled){
                    if (retryCount < 10){
                        alert = false;
                        this._SafeStr_11757.issueManager.autoPick(retryEnabled, retryCount);
                    };
                };
            };
            if (alert){
                this._SafeStr_11757.windowManager.alert("Error", "Issue picking failed", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                {
                    _arg_1.dispose();
                });
            };
        }
        private function onIssueDeleted(_arg_1:IssueDeletedMessageEvent):void
        {
            if ((((_arg_1 == null)) || ((this._SafeStr_11757 == null)))){
                return;
            };
            var _local_2:IssueDeletedMessageParser = _arg_1.getParser();
            if (_local_2 == null){
                return;
            };
            this._SafeStr_11757.issueManager.removeIssue(_local_2.issueId);
        }
        private function InfostandWidget(_arg_1:ModeratorUserInfoEvent):void
        {
            var _local_3:UserInfoCtrl;
            var _local_2:ModeratorUserInfoMessageParser = _arg_1.getParser();
            Logger.log(((("GOT USER INFO: " + _local_2.data.userId) + ", ") + _local_2.data.cautionCount));
            for each (_local_3 in this._SafeStr_11758) {
                _local_3.InfostandWidget(_local_2.data);
            };
        }
        private function IncomingMessages(_arg_1:ModeratorRoomInfoEvent):void
        {
            var _local_3:RoomToolCtrl;
            var _local_2:ModeratorRoomInfoMessageParser = _arg_1.getParser();
            for each (_local_3 in this._SafeStr_11761) {
                _local_3.IncomingMessages(_local_2.data);
            };
        }
        private function onCfhChatlog(_arg_1:CfhChatlogEvent):void
        {
            var _local_2:CfhChatlogMessageParser = _arg_1.getParser();
            var _local_3:Array = new Array();
            _local_3.push(_local_2.data.room);
            var _local_4:Dictionary = new Dictionary();
            _local_4[_local_2.data.callerUserId] = "yes";
            _local_4[_local_2.data.reportedUserId] = "yes";
            this.ChatlogCtrl(("Call For Help Chatlog: " + _local_2.data.chatRecordId), WindowTracker._SafeStr_11779, _local_2.data.callId, _local_3, _local_4);
        }
        private function onRoomChatlog(_arg_1:RoomChatlogEvent):void
        {
            var _local_2:RoomChatlogMessageParser = _arg_1.getParser();
            var _local_3:Array = new Array();
            _local_3.push(_local_2.data);
            var _local_4:Dictionary = new Dictionary();
            this.ChatlogCtrl(("Room Chatlog: " + _local_2.data.roomName), WindowTracker._SafeStr_11755, _local_2.data.roomId, _local_3, _local_4);
        }
        private function onUserChatlog(_arg_1:UserChatlogEvent):void
        {
            var _local_2:UserChatlogMessageParser = _arg_1.getParser();
            var _local_3:Dictionary = new Dictionary();
            _local_3[_local_2.data.userId] = "yes";
            this.ChatlogCtrl(("User Chatlog: " + _local_2.data.userName), WindowTracker._SafeStr_11780, _local_2.data.userId, _local_2.data.rooms, _local_3);
        }
        private function ChatlogCtrl(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:Array, _arg_5:Dictionary):void
        {
            var _local_6:ChatlogCtrl;
            var _local_7:Array = this._SafeStr_11760.concat();
            for each (_local_6 in _local_7) {
                _local_6.ChatlogCtrl(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
            };
        }
        private function RoomVisitsCtrl(_arg_1:RoomVisitsEvent):void
        {
            var _local_3:RoomVisitsCtrl;
            var _local_2:RoomVisitsMessageParser = _arg_1.getParser();
            var _local_4:Array = this._SafeStr_11759.concat();
            for each (_local_3 in _local_4) {
                _local_3.RoomVisitsCtrl(_local_2.data);
            };
        }
        private function onRoomEnter(_arg_1:RoomEntryInfoMessageEvent):void
        {
            var _local_3:RoomToolCtrl;
            var _local_2:RoomEntryInfoMessageParser = _arg_1.getParser();
            if (_local_2.privateRoom){
                this._SafeStr_11757.currentFlatId = _local_2.guestRoomId;
                this._SafeStr_11757.startPanel.StartPanelCtrl(_local_2);
            }
            else {
                this._SafeStr_11757.currentFlatId = 0;
            };
            for each (_local_3 in this._SafeStr_11762) {
                _local_3.RoomToolCtrl();
            };
        }
        private function IncomingMessages(_arg_1:PublicSpaceCastLibsEvent):void
        {
            var _local_2:PublicSpaceCastLibsMessageParser = _arg_1.getParser();
            this._SafeStr_11757.startPanel.StartPanelCtrl(_local_2);
        }
        private function HabboGroupInfoManager(_arg_1:CloseConnectionMessageEvent):void
        {
            var _local_2:RoomToolCtrl;
            this._SafeStr_11757.currentFlatId = 0;
            this._SafeStr_11757.startPanel.StartPanelCtrl();
            for each (_local_2 in this._SafeStr_11762) {
                _local_2.RoomToolCtrl();
            };
        }
        private function onModeratorActionResult(_arg_1:ModeratorActionResultMessageEvent):void
        {
            var _local_2:ModeratorActionResultMessageParser = _arg_1.getParser();
            Logger.log(((("GOT MOD ACTION RESULT: " + _local_2.userId) + ", ") + _local_2.success));
            if (_local_2.success){
                this._SafeStr_11757.connection.send(new GetModeratorUserInfoMessageComposer(_local_2.userId));
            }
            else {
                this._SafeStr_11757.windowManager.alert("Alert", "Moderation action failed", 0, this.SessionDataManager);
            };
        }
        public function addUserInfoListener(_arg_1:UserInfoCtrl):void
        {
            this._SafeStr_11758.push(_arg_1);
        }
        public function removeUserInfoListener(_arg_1:UserInfoCtrl):void
        {
            var _local_3:UserInfoCtrl;
            var _local_2:Array = new Array();
            for each (_local_3 in this._SafeStr_11758) {
                if (_local_3 != _arg_1){
                    _local_2.push(_local_3);
                };
            };
            this._SafeStr_11758 = _local_2;
        }
        public function addRoomInfoListener(_arg_1:RoomToolCtrl):void
        {
            this._SafeStr_11761.push(_arg_1);
        }
        public function removeRoomInfoListener(_arg_1:RoomToolCtrl):void
        {
            var _local_3:RoomToolCtrl;
            var _local_2:Array = new Array();
            for each (_local_3 in this._SafeStr_11761) {
                if (_local_3 != _arg_1){
                    _local_2.push(_local_3);
                };
            };
            this._SafeStr_11761 = _local_2;
        }
        public function addRoomEnterListener(_arg_1:RoomToolCtrl):void
        {
            this._SafeStr_11762.push(_arg_1);
        }
        public function removeRoomEnterListener(_arg_1:RoomToolCtrl):void
        {
            var _local_3:RoomToolCtrl;
            var _local_2:Array = new Array();
            for each (_local_3 in this._SafeStr_11762) {
                if (_local_3 != _arg_1){
                    _local_2.push(_local_3);
                };
            };
            this._SafeStr_11762 = _local_2;
        }
        public function addRoomVisitsListener(_arg_1:RoomVisitsCtrl):void
        {
            this._SafeStr_11759.push(_arg_1);
        }
        public function removeRoomVisitsListener(_arg_1:RoomVisitsCtrl):void
        {
            var _local_3:RoomVisitsCtrl;
            var _local_2:Array = new Array();
            for each (_local_3 in this._SafeStr_11759) {
                if (_local_3 != _arg_1){
                    _local_2.push(_local_3);
                };
            };
            this._SafeStr_11759 = _local_2;
        }
        public function addChatlogListener(_arg_1:ChatlogCtrl):void
        {
            this._SafeStr_11760.push(_arg_1);
        }
        public function removeChatlogListener(_arg_1:ChatlogCtrl):void
        {
            var _local_3:ChatlogCtrl;
            var _local_2:Array = new Array();
            for each (_local_3 in this._SafeStr_11760) {
                if (_local_3 != _arg_1){
                    _local_2.push(_local_3);
                };
            };
            this._SafeStr_11760 = _local_2;
        }
        private function SessionDataManager(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
        }

    }
}//package com.sulake.habbo.moderation

// SessionDataManager = "_-34G" (String#309, DoABC#2)
// StartPanelCtrl = "_-03g" (String#14190, DoABC#2)
// StartPanelCtrl = "_-2P5" (String#20006, DoABC#2)
// StartPanelCtrl = "_-2fB" (String#20654, DoABC#2)
// initMsg = "_-MD" (String#23092, DoABC#2)
// _SafeStr_11755 = "_-12Z" (String#16561, DoABC#2)
// issueManager = "_-277" (String#19296, DoABC#2)
// _SafeStr_11757 = "_-6S" (String#2051, DoABC#2)
// _SafeStr_11758 = "_-0f8" (String#15634, DoABC#2)
// _SafeStr_11759 = "_-2gb" (String#20715, DoABC#2)
// _SafeStr_11760 = "_-0r6" (String#16090, DoABC#2)
// _SafeStr_11761 = "_-Sk" (String#23354, DoABC#2)
// _SafeStr_11762 = "_-183" (String#16778, DoABC#2)
// onIssueInfo = "_-2Vw" (String#20279, DoABC#2)
// onModeratorInit = "_-0cO" (String#15529, DoABC#2)
// onIssuePickFailed = "_-GQ" (String#22869, DoABC#2)
// onIssueDeleted = "_-UB" (String#23414, DoABC#2)
// IncomingMessages = "_-az" (String#2136, DoABC#2)
// onCfhChatlog = "_-0dX" (String#15566, DoABC#2)
// onUserChatlog = "_-08d" (String#14392, DoABC#2)
// onRoomChatlog = "_-fi" (String#23876, DoABC#2)
// RoomVisitsCtrl = "_-hX" (String#8545, DoABC#2)
// IncomingMessages = "_-0X3" (String#4251, DoABC#2)
// updateIssue = "_-3KL" (String#22296, DoABC#2)
// startPanel = "_-2XW" (String#20343, DoABC#2)
// issuePickFailed = "_-1oX" (String#18478, DoABC#2)
// autoPick = "_-Ot" (String#23201, DoABC#2)
// removeIssue = "_-25y" (String#19257, DoABC#2)
// ChatlogCtrl = "_-Ps" (String#2103, DoABC#2)
// _SafeStr_11779 = "_-1Ka" (String#17297, DoABC#2)
// _SafeStr_11780 = "_-0Xa" (String#15339, DoABC#2)
// currentFlatId = "_-2HL" (String#19698, DoABC#2)
// RoomToolCtrl = "_-2JA" (String#19774, DoABC#2)
// addUserInfoListener = "_-1z6" (String#18931, DoABC#2)
// removeUserInfoListener = "_-2us" (String#21272, DoABC#2)
// addRoomInfoListener = "_-33D" (String#21629, DoABC#2)
// removeRoomInfoListener = "_-hl" (String#23956, DoABC#2)
// addRoomEnterListener = "_-d0" (String#23757, DoABC#2)
// removeRoomEnterListener = "_-8C" (String#22549, DoABC#2)
// addRoomVisitsListener = "_-2Zz" (String#20439, DoABC#2)
// removeRoomVisitsListener = "_-0DH" (String#14580, DoABC#2)
// addChatlogListener = "_-2oH" (String#21014, DoABC#2)
// removeChatlogListener = "_-1MZ" (String#17381, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// ModerationMessageHandler = "_-0Cg" (String#3804, DoABC#2)
// WindowTracker = "_-2m9" (String#7008, DoABC#2)
// ModeratorInitData = "_-0W" (String#4229, DoABC#2)
// PublicSpaceCastLibsEvent = "_-ms" (String#24146, DoABC#2)
// PublicSpaceCastLibsMessageParser = "_-3Dk" (String#7592, DoABC#2)
// ModeratorActionResultMessageEvent = "_-2a-" (String#20441, DoABC#2)
// IssueDeletedMessageEvent = "_-0By" (String#14525, DoABC#2)
// UserChatlogEvent = "_-1AF" (String#16869, DoABC#2)
// RoomChatlogEvent = "_-13V" (String#16599, DoABC#2)
// IssuePickFailedMessageEvent = "_-3Ej" (String#22064, DoABC#2)
// ModeratorInitMessageEvent = "_-3CW" (String#21976, DoABC#2)
// IssueInfoMessageEvent = "_-Ab" (String#22639, DoABC#2)
// ModeratorRoomInfoEvent = "_-0m0" (String#15897, DoABC#2)
// GetModeratorUserInfoMessageComposer = "_-2fD" (String#20655, DoABC#2)
// CfhChatlogEvent = "_-ax" (String#23668, DoABC#2)
// RoomVisitsEvent = "_-L-" (String#23046, DoABC#2)
// ModeratorUserInfoEvent = "_-24q" (String#19216, DoABC#2)
// ChatlogCtrl = "_-2GT" (String#6377, DoABC#2)
// RoomToolCtrl = "_-0Tu" (String#4178, DoABC#2)
// ModeratorUserInfoMessageParser = "_-0E5" (String#3829, DoABC#2)
// UserInfoCtrl = "_-ip" (String#8573, DoABC#2)
// IssuePickFailedMessageParser = "_-Bc" (String#7903, DoABC#2)
// ModeratorRoomInfoMessageParser = "_-1aP" (String#5567, DoABC#2)
// RoomChatlogMessageParser = "_-0Iw" (String#3933, DoABC#2)
// IssueInfoMessageParser = "_-2NS" (String#6511, DoABC#2)
// UserChatlogMessageParser = "_-2Oi" (String#6535, DoABC#2)
// RoomVisitsCtrl = "_-2rD" (String#7106, DoABC#2)
// IssueDeletedMessageParser = "_-1t1" (String#5902, DoABC#2)
// CfhChatlogMessageParser = "_-2Gb" (String#6379, DoABC#2)
// ModeratorInitMessageParser = "_-1ZK" (String#5549, DoABC#2)
// RoomVisitsMessageParser = "_-2zM" (String#7274, DoABC#2)
// ModeratorActionResultMessageParser = "_-2-r" (String#6043, DoABC#2)
// IssueMessageData = "_-0K1" (String#3952, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// privateRoom = "_-26S" (String#19271, DoABC#2)
// guestRoomId = "_-1NR" (String#17415, DoABC#2)
// InfostandWidget = "_-2pH" (String#623, DoABC#2)
// cautionCount = "_-KY" (String#23025, DoABC#2)
// callerUserId = "_-0hf" (String#15734, DoABC#2)
// chatRecordId = "_-M6" (String#23087, DoABC#2)
// issueData = "_-0Ah" (String#14476, DoABC#2)
// messageTemplates = "_-oF" (String#24201, DoABC#2)
// issueId = "_-1yh" (String#18916, DoABC#2)
// RoomEntryInfoMessageParser = "_-2Z9" (String#6747, DoABC#2)
// RoomEntryInfoMessageEvent = "_-nk" (String#24182, DoABC#2)
// CloseConnectionMessageEvent = "_-2cv" (String#6811, DoABC#2)
// onRoomEnter = "_-El" (String#460, DoABC#2)
// HabboGroupInfoManager = "_-0Na" (String#356, DoABC#2)


