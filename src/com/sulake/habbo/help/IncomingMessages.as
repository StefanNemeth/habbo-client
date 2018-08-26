
package com.sulake.habbo.help
{
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.communication.messages.incoming.help.CallForHelpReplyMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.CallForHelpResultMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.CallForHelpPendingCallsDeletedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.FaqClientFaqsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.FaqCategoriesMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.FaqTextMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.FaqSearchResultsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.FaqCategoryMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.RoomReadyMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.GetGuestRoomResultEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
    import com.sulake.habbo.communication.messages.incoming.users.UserNameChangedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UsersMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.IssueCloseNotificationMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.TutorialStatusMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.avatar.ChangeUserNameResultMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.avatar.CheckUserNameResultMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.HotelMergeNameChangeEvent;
    import com.sulake.habbo.communication.messages.parser.help.CallForHelpReplyMessageParser;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.session.RoomReadyMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.GetGuestRoomResultMessageParser;
    import com.sulake.habbo.communication.messages.parser.handshake.UserObjectMessageParser;
    import com.sulake.habbo.communication.messages.parser.users.UserNameChangedMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserChangeMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserMessageData;
    import com.sulake.habbo.communication.messages.parser.room.engine.UsersMessageParser;
    import com.sulake.habbo.room.object.RoomObjectTypeEnum;
    import com.sulake.habbo.help.enum.HabboHelpViewEnum;
    import com.sulake.habbo.communication.messages.parser.help.IssueCloseNotificationMessageParser;
    import com.sulake.habbo.communication.messages.parser.help.CallForHelpResultMessageParser;
    import com.sulake.habbo.help.enum.CallForHelpResultEnum;
    import com.sulake.habbo.help.help.data.FaqCategory;
    import com.sulake.habbo.communication.messages.parser.help.FaqClientFaqsMessageParser;
    import com.sulake.habbo.help.help.data.FaqIndex;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.communication.messages.parser.help.FaqCategoriesMessageParser;
    import com.sulake.habbo.communication.messages.parser.help.FaqCategoryMessageParser;
    import com.sulake.habbo.communication.messages.parser.help.FaqTextMessageParser;
    import com.sulake.habbo.help.help.data.FaqItem;
    import com.sulake.habbo.communication.messages.parser.help.FaqSearchResultsMessageParser;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.parser.help.TutorialStatusMessageParser;

    public class IncomingMessages 
    {

        private var _component:HabboHelp;
        private var _userId:int = -1;
        private var _SafeStr_5260:int = -1;

        public function IncomingMessages(_arg_1:HabboHelp, _arg_2:IHabboCommunicationManager)
        {
            this._component = _arg_1;
            var _local_3:IHabboCommunicationManager = _arg_2;
            _local_3.HabboCommunicationManager(new CallForHelpReplyMessageEvent(this.onCallForHelpReply));
            _local_3.HabboCommunicationManager(new CallForHelpResultMessageEvent(this.onCallForHelpResult));
            _local_3.HabboCommunicationManager(new CallForHelpPendingCallsDeletedMessageEvent(this.onPendingCallsForHelpDeleted));
            _local_3.HabboCommunicationManager(new FaqClientFaqsMessageEvent(this.onFaqClientFaqs));
            _local_3.HabboCommunicationManager(new FaqCategoriesMessageEvent(this.onFaqCategories));
            _local_3.HabboCommunicationManager(new FaqTextMessageEvent(this.onFaqText));
            _local_3.HabboCommunicationManager(new FaqSearchResultsMessageEvent(this.onFaqSearchResults));
            _local_3.HabboCommunicationManager(new FaqCategoryMessageEvent(this.onFaqCategory));
            _local_3.HabboCommunicationManager(new RoomEntryInfoMessageEvent(this.onRoomEntryInfo));
            _local_3.HabboCommunicationManager(new RoomReadyMessageEvent(this.SessionDataManager));
            _local_3.HabboCommunicationManager(new GetGuestRoomResultEvent(this.onGuestRoomResult));
            _local_3.HabboCommunicationManager(new UserObjectEvent(this.onUserObject));
            _local_3.HabboCommunicationManager(new UserNameChangedMessageEvent(this.onUserNameChange));
            _local_3.HabboCommunicationManager(new UsersMessageEvent(this.RoomMessageHandler));
            _local_3.HabboCommunicationManager(new IssueCloseNotificationMessageEvent(this.onIssueClose));
            _local_3.HabboCommunicationManager(new TutorialStatusMessageEvent(this.onTutorialStatus));
            _local_3.HabboCommunicationManager(new ChangeUserNameResultMessageEvent(this.onChangeUserNameResult));
            _local_3.HabboCommunicationManager(new CheckUserNameResultMessageEvent(this.onCheckUserNameResult));
            _local_3.HabboCommunicationManager(new HotelMergeNameChangeEvent(this.onHotelMergeNameChange));
        }
        private function onCallForHelpReply(_arg_1:IMessageEvent):void
        {
            var _local_2:CallForHelpReplyMessageParser = CallForHelpReplyMessageEvent(_arg_1).getParser();
            this._component.HelpUI(_local_2.message);
        }
        private function onRoomEntryInfo(_arg_1:IMessageEvent):void
        {
            var _local_2:RoomEntryInfoMessageParser = RoomEntryInfoMessageEvent(_arg_1).getParser();
            if (((_local_2.privateRoom) && (_local_2.owner))){
                this._component.enableCallForGuideBotUI();
            }
            else {
                this._component.disableCallForGuideBotUI();
            };
        }
        private function SessionDataManager(_arg_1:IMessageEvent):void
        {
            var _local_2:RoomReadyMessageParser = RoomReadyMessageEvent(_arg_1).getParser();
            if (_local_2.roomType.indexOf("model_") == 0){
                return;
            };
            var _local_3 = (((("nav_venue_" + _local_2.roomType) + "/") + 0) + "_name");
            this._component.userRegistry.registerRoom(this._component.localization.getKey(_local_3));
        }
        private function onGuestRoomResult(_arg_1:IMessageEvent):void
        {
            var _local_2:GetGuestRoomResultMessageParser = GetGuestRoomResultEvent(_arg_1).getParser();
            this._component.userRegistry.registerRoom(_local_2.data.roomName);
        }
        private function onUserObject(_arg_1:IMessageEvent):void
        {
            var _local_2:UserObjectMessageParser = UserObjectEvent(_arg_1).getParser();
            this._userId = _local_2.id;
            this._component.ownUserName = _local_2.name;
        }
        private function onUserNameChange(_arg_1:IMessageEvent):void
        {
            var _local_2:UserNameChangedMessageParser = UserNameChangedMessageEvent(_arg_1).getParser();
            if (this._userId != _local_2.webId){
                return;
            };
            this._component.ownUserName = _local_2.newName;
            if (this._component.tutorialUI){
                this._component.tutorialUI.onUserNameChanged(_local_2.newName);
            };
            if (this._component.hotelMergeUI){
                this._component.hotelMergeUI.onUserNameChanged(_local_2.newName);
            };
        }
        private function onUserChange(_arg_1:IMessageEvent):void
        {
            var _local_2:UserChangeMessageEvent = UserChangeMessageEvent(_arg_1);
            if (this._SafeStr_5260 != _local_2.id){
                return;
            };
            if ((((this._component == null)) || ((this._component.tutorialUI == null)))){
                return;
            };
            this._component.tutorialUI.onUserChanged();
        }
        private function RoomMessageHandler(_arg_1:IMessageEvent):void
        {
            var _local_5:UserMessageData;
            var _local_2:UsersMessageEvent = (_arg_1 as UsersMessageEvent);
            var _local_3:UsersMessageParser = _local_2.getParser();
            var _local_4:int;
            while (_local_4 < _local_3.UsersMessageParser()) {
                _local_5 = _local_3.UsersMessageParser(_local_4);
                if (((!((_local_5.webID == this._userId))) && ((_local_5.userType == RoomObjectTypeEnum._SafeStr_3740)))){
                    this._component.userRegistry.registerUser(_local_5.webID, _local_5.name);
                };
                if (_local_5.webID == this._userId){
                    this._SafeStr_5260 = _local_5.id;
                };
                _local_4++;
            };
            this._component.tellUI(HabboHelpViewEnum.HHVE_REPORT_USER_SELECT);
        }
        private function onIssueClose(_arg_1:IMessageEvent):void
        {
            var _local_2:IssueCloseNotificationMessageEvent = (_arg_1 as IssueCloseNotificationMessageEvent);
            var _local_3:IssueCloseNotificationMessageParser = _local_2.getParser();
            this._component.windowManager.alert("${mod.alert.title}", (("${help.cfh.closed." + this.getCloseReasonKey(_local_3.closeReason)) + "}"), 0, this.SessionDataManager);
        }
        private function getCloseReasonKey(_arg_1:int):String
        {
            if (_arg_1 == 1){
                return ("useless");
            };
            if (_arg_1 == 2){
                return ("abusive");
            };
            return ("resolved");
        }
        private function onCallForHelpResult(_arg_1:IMessageEvent):void
        {
            var _local_4:String;
            var _local_2:CallForHelpResultMessageParser = CallForHelpResultMessageEvent(_arg_1).getParser();
            var _local_3:int = _local_2.resultType;
            switch (_local_3){
                case 1:
                    _local_4 = CallForHelpResultEnum.CFHRE_ERROR_TOO_MANY_PENDING;
                    break;
                case 2:
                    _local_4 = CallForHelpResultEnum.CFHRE_HAS_ABUSIVE_CALL;
                    break;
                default:
                    _local_4 = CallForHelpResultEnum.CFHRE_SENT_OK;
            };
            this._component.HelpUI(_local_4);
        }
        private function onPendingCallsForHelpDeleted(_arg_1:IMessageEvent):void
        {
            this._component.showUI(HabboHelpViewEnum.HHVE_CFG_TOPIC_SELECT);
        }
        private function onFaqClientFaqs(_arg_1:IMessageEvent):void
        {
            var _local_6:FaqCategory;
            var _local_7:int;
            var _local_2:FaqClientFaqsMessageParser = FaqClientFaqsMessageEvent(_arg_1).getParser();
            var _local_3:FaqIndex = this._component.getFaq();
            var _local_4:Map = _local_2.urgentData;
            var _local_5:Map = _local_2.normalData;
            if ((((((_local_3 == null)) || ((_local_4 == null)))) || ((_local_5 == null)))){
                return;
            };
            _local_6 = _local_3.getFrontPageUrgentCategory();
            _local_6.reset();
            _local_6.setTimeStamp();
            _local_7 = 0;
            while (_local_7 < _local_4.length) {
                _local_6.storeItem(_local_4.getKey(_local_7), _local_4.getWithIndex(_local_7));
                _local_7++;
            };
            _local_6 = _local_3.getFrontPageNormalCategory();
            _local_6.reset();
            _local_6.setTimeStamp();
            _local_7 = 0;
            while (_local_7 < _local_5.length) {
                _local_6.storeItem(_local_5.getKey(_local_7), _local_5.getWithIndex(_local_7));
                _local_7++;
            };
            this._component.tellUI(HabboHelpViewEnum.HHVE_HELP_FRONTPAGE);
        }
        private function onFaqCategories(_arg_1:IMessageEvent):void
        {
            var _local_6:int;
            var _local_7:Map;
            var _local_8:String;
            var _local_9:FaqCategory;
            var _local_2:FaqCategoriesMessageParser = FaqCategoriesMessageEvent(_arg_1).getParser();
            var _local_3:FaqIndex = this._component.getFaq();
            var _local_4:Map = _local_2.data;
            if ((((_local_3 == null)) || ((_local_4 == null)))){
                return;
            };
            var _local_5:int;
            while (_local_5 < _local_4.length) {
                _local_6 = _local_4.getKey(_local_5);
                _local_7 = _local_4.getWithIndex(_local_5);
                _local_8 = _local_7.getValue("name");
                _local_9 = _local_3.getCategory(_local_6, _local_8, true);
                _local_9.itemCount = _local_7.getValue("count");
                _local_5++;
            };
            this._component.showUI(HabboHelpViewEnum.HHVE_FAQ_TOP);
        }
        private function onFaqCategory(_arg_1:IMessageEvent):void
        {
            var _local_8:int;
            var _local_9:String;
            var _local_2:FaqCategoryMessageParser = FaqCategoryMessageEvent(_arg_1).getParser();
            var _local_3:FaqIndex = this._component.getFaq();
            var _local_4:Map = _local_2.data;
            if ((((_local_3 == null)) || ((_local_4 == null)))){
                return;
            };
            var _local_5:int = _local_2.categoryId;
            var _local_6:FaqCategory = _local_3.getCategory(_local_5);
            if (_local_6 == null){
                return;
            };
            _local_6.description = _local_2.description;
            _local_6.setTimeStamp();
            var _local_7:int;
            while (_local_7 < _local_4.length) {
                _local_8 = _local_4.getKey(_local_7);
                _local_9 = _local_4.getWithIndex(_local_7);
                _local_6.storeItem(_local_8, _local_9);
                _local_7++;
            };
            this._component.tellUI(HabboHelpViewEnum.HHVE_FAQ_CATEGORY, _local_6);
        }
        private function onFaqText(_arg_1:IMessageEvent):void
        {
            var _local_2:FaqTextMessageParser = FaqTextMessageEvent(_arg_1).getParser();
            var _local_3:FaqIndex = this._component.getFaq();
            if (_local_3 == null){
                return;
            };
            _local_3.storeAnswerText(_local_2.questionId, _local_2.answerText);
            var _local_4:FaqItem = _local_3.GroupItem(_local_2.questionId);
            if (_local_4 != null){
                this._component.tellUI(HabboHelpViewEnum.HHVE_FAQ_TOPICS, _local_4);
            };
        }
        private function onFaqSearchResults(_arg_1:IMessageEvent):void
        {
            var _local_2:FaqSearchResultsMessageParser = FaqSearchResultsMessageEvent(_arg_1).getParser();
            var _local_3:FaqIndex = this._component.getFaq();
            var _local_4:Map = _local_2.data;
            if ((((_local_3 == null)) || ((_local_4 == null)))){
                return;
            };
            var _local_5:FaqCategory = _local_3.getSearchResultCategory();
            _local_5.reset();
            _local_5.setTimeStamp();
            var _local_6:int;
            while (_local_6 < _local_4.length) {
                _local_5.storeItem(_local_4.getKey(_local_6), _local_4.getWithIndex(_local_6));
                _local_6++;
            };
            this._component.showUI(HabboHelpViewEnum.HHVE_FAQ_SEARCH);
            this._component.tellUI(HabboHelpViewEnum.HHVE_FAQ_SEARCH, _local_5);
        }
        private function SessionDataManager(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
        }
        private function onTutorialStatus(_arg_1:IMessageEvent):void
        {
            if (this._component == null){
                return;
            };
            var _local_2:TutorialStatusMessageParser = (_arg_1 as TutorialStatusMessageEvent).getParser();
            this._component.updateTutorial(_local_2.hasChangedLooks, _local_2.hasChangedName, _local_2.hasCalledGuideBot);
        }
        private function onChangeUserNameResult(_arg_1:ChangeUserNameResultMessageEvent):void
        {
            if (!this._component){
                return;
            };
            if (this._component.tutorialUI){
                this._component.tutorialUI.onChangeUserNameResult(_arg_1);
            };
            if (this._component.hotelMergeUI){
                this._component.hotelMergeUI.onChangeUserNameResult(_arg_1);
            };
        }
        private function onCheckUserNameResult(_arg_1:CheckUserNameResultMessageEvent):void
        {
            if (!this._component){
                return;
            };
            if (this._component.tutorialUI){
                this._component.tutorialUI.onCheckUserNameResult(_arg_1);
            };
            if (this._component.hotelMergeUI){
                this._component.hotelMergeUI.onCheckUserNameResult(_arg_1);
            };
        }
        private function onHotelMergeNameChange(_arg_1:HotelMergeNameChangeEvent):void
        {
            if (!this._component){
                return;
            };
            this._component.initHotelMergeUI();
        }

    }
}//package com.sulake.habbo.help

// onUserObject = "_-2A9" (String#617, DoABC#2)
// getCategory = "_-Ir" (String#22962, DoABC#2)
// storeAnswerText = "_-21O" (String#19067, DoABC#2)
// getFrontPageUrgentCategory = "_-zh" (String#24676, DoABC#2)
// getFrontPageNormalCategory = "_-Ij" (String#22955, DoABC#2)
// getSearchResultCategory = "_-2O6" (String#19969, DoABC#2)
// storeItem = "_-1Tt" (String#17661, DoABC#2)
// setTimeStamp = "_-2L" (String#19846, DoABC#2)
// HelpUI = "_-1DY" (String#17005, DoABC#2)
// HelpUI = "_-0VS" (String#15260, DoABC#2)
// onUserNameChanged = "_-dO" (String#23776, DoABC#2)
// onChangeUserNameResult = "_-06v" (String#1405, DoABC#2)
// onCheckUserNameResult = "_-2F9" (String#6344, DoABC#2)
// ownUserName = "_-19l" (String#16846, DoABC#2)
// onUserChanged = "_-0NZ" (String#14975, DoABC#2)
// onCallForHelpReply = "_-1nX" (String#18441, DoABC#2)
// onCallForHelpResult = "_-1fF" (String#18106, DoABC#2)
// onPendingCallsForHelpDeleted = "_-1Uu" (String#17700, DoABC#2)
// onFaqClientFaqs = "_-aB" (String#23639, DoABC#2)
// onFaqCategories = "_-p9" (String#24239, DoABC#2)
// onFaqText = "_-0Z8" (String#15409, DoABC#2)
// onFaqSearchResults = "_-C8" (String#22697, DoABC#2)
// onFaqCategory = "_-1N" (String#17400, DoABC#2)
// onRoomEntryInfo = "_-1Vh" (String#17728, DoABC#2)
// onGuestRoomResult = "_-0mJ" (String#15908, DoABC#2)
// onTutorialStatus = "_-24C" (String#19185, DoABC#2)
// onHotelMergeNameChange = "_-2Ik" (String#19758, DoABC#2)
// enableCallForGuideBotUI = "_-0RC" (String#15111, DoABC#2)
// disableCallForGuideBotUI = "_-26s" (String#19286, DoABC#2)
// tutorialUI = "_-09R" (String#14427, DoABC#2)
// hotelMergeUI = "_-0WV" (String#15299, DoABC#2)
// getCloseReasonKey = "_-V6" (String#23452, DoABC#2)
// SessionDataManager = "_-34G" (String#309, DoABC#2)
// updateTutorial = "_-3KM" (String#22297, DoABC#2)
// initHotelMergeUI = "_-2MZ" (String#19909, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// IncomingMessages = "_-2Xb" (String#216, DoABC#2)
// FaqIndex = "_-3I0" (String#7667, DoABC#2)
// HabboHelpViewEnum = "_-1e7" (String#18062, DoABC#2)
// ChangeUserNameResultMessageEvent = "_-3HW" (String#22180, DoABC#2)
// UserObjectMessageParser = "_-04X" (String#14223, DoABC#2)
// UserChangeMessageEvent = "_-a9" (String#23638, DoABC#2)
// RoomReadyMessageEvent = "_-1uW" (String#5930, DoABC#2)
// UserNameChangedMessageParser = "_-1TI" (String#17637, DoABC#2)
// UserNameChangedMessageEvent = "_-1J2" (String#17238, DoABC#2)
// UserObjectEvent = "_-1HL" (String#17163, DoABC#2)
// RoomReadyMessageParser = "_-1zm" (String#18958, DoABC#2)
// UsersMessageParser = "_-3Iv" (String#7687, DoABC#2)
// UserMessageData = "_-0WX" (String#4238, DoABC#2)
// UsersMessageEvent = "_-2MA" (String#19891, DoABC#2)
// GetGuestRoomResultMessageParser = "_-0lh" (String#4540, DoABC#2)
// GetGuestRoomResultEvent = "_-2XI" (String#20334, DoABC#2)
// RoomObjectTypeEnum = "_-2hK" (String#20744, DoABC#2)
// CallForHelpResultEnum = "_-2DX" (String#6313, DoABC#2)
// FaqCategory = "_-0JM" (String#3941, DoABC#2)
// FaqItem = "_-1u6" (String#5923, DoABC#2)
// CheckUserNameResultMessageEvent = "_-2Tb" (String#20186, DoABC#2)
// IssueCloseNotificationMessageParser = "_-02p" (String#3626, DoABC#2)
// FaqCategoriesMessageParser = "_-4R" (String#7755, DoABC#2)
// HotelMergeNameChangeEvent = "_-32D" (String#21589, DoABC#2)
// FaqTextMessageEvent = "_-0Cr" (String#14565, DoABC#2)
// FaqTextMessageParser = "_-1tS" (String#5910, DoABC#2)
// CallForHelpResultMessageParser = "_-0Hy" (String#3915, DoABC#2)
// FaqSearchResultsMessageEvent = "_-Pm" (String#23238, DoABC#2)
// FaqSearchResultsMessageParser = "_-0wG" (String#4775, DoABC#2)
// FaqClientFaqsMessageParser = "_-2iS" (String#6919, DoABC#2)
// IssueCloseNotificationMessageEvent = "_-SY" (String#23348, DoABC#2)
// CallForHelpReplyMessageParser = "_-1RQ" (String#5384, DoABC#2)
// TutorialStatusMessageEvent = "_-II" (String#22940, DoABC#2)
// FaqCategoryMessageParser = "_-1hX" (String#5698, DoABC#2)
// TutorialStatusMessageParser = "_-1ZY" (String#5556, DoABC#2)
// FaqClientFaqsMessageEvent = "_-0vA" (String#16244, DoABC#2)
// CallForHelpPendingCallsDeletedMessageEvent = "_-342" (String#21659, DoABC#2)
// FaqCategoryMessageEvent = "_-248" (String#19181, DoABC#2)
// CallForHelpResultMessageEvent = "_-07k" (String#14353, DoABC#2)
// FaqCategoriesMessageEvent = "_-0OG" (String#14999, DoABC#2)
// CallForHelpReplyMessageEvent = "_-0-F" (String#14022, DoABC#2)
// userType = "_-0Dh" (String#14596, DoABC#2)
// questionId = "_-3-c" (String#21486, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// UsersMessageParser = "_-xV" (String#24590, DoABC#2)
// UsersMessageParser = "_-0C8" (String#14534, DoABC#2)
// webID = "_-2uI" (String#7166, DoABC#2)
// _SafeStr_3740 = "_-39-" (String#21844, DoABC#2)
// GroupItem = "_-0un" (String#16229, DoABC#2)
// privateRoom = "_-26S" (String#19271, DoABC#2)
// owner = "_-1S6" (String#17586, DoABC#2)
// HabboCommunicationManager = "_-0r" (String#4663, DoABC#2)
// _SafeStr_5260 = "_-3Hm" (String#7661, DoABC#2)
// registerRoom = "_-30l" (String#21530, DoABC#2)
// registerUser = "_-Hq" (String#22924, DoABC#2)
// webId = "_-27Z" (String#19314, DoABC#2)
// newName = "_-2Fm" (String#19634, DoABC#2)
// _component = "_-2cU" (String#305, DoABC#2)
// itemCount = "_-1fH" (String#18108, DoABC#2)
// RoomMessageHandler = "_-1eu" (String#1735, DoABC#2)
// onUserChange = "_-0uf" (String#827, DoABC#2)
// onUserNameChange = "_-37e" (String#2005, DoABC#2)
// SessionDataManager = "_-0KO" (String#583, DoABC#2)
// hasChangedName = "_-33G" (String#7371, DoABC#2)
// HHVE_HELP_FRONTPAGE = "_-2WD" (String#20292, DoABC#2)
// HHVE_FAQ_TOP = "_-0et" (String#15622, DoABC#2)
// HHVE_FAQ_CATEGORY = "_-1AU" (String#16879, DoABC#2)
// HHVE_FAQ_TOPICS = "_-ed" (String#23829, DoABC#2)
// HHVE_FAQ_SEARCH = "_-0zM" (String#16402, DoABC#2)
// HHVE_CFG_TOPIC_SELECT = "_-2-u" (String#19007, DoABC#2)
// CFHRE_SENT_OK = "_-0ru" (String#16119, DoABC#2)
// HHVE_REPORT_USER_SELECT = "_-0Cm" (String#14561, DoABC#2)
// CFHRE_ERROR_TOO_MANY_PENDING = "_-1b1" (String#17935, DoABC#2)
// CFHRE_HAS_ABUSIVE_CALL = "_-3KC" (String#22290, DoABC#2)
// closeReason = "_-1kC" (String#18296, DoABC#2)
// answerText = "_-3JS" (String#22262, DoABC#2)
// resultType = "_-3m" (String#22365, DoABC#2)
// urgentData = "_-2HK" (String#19697, DoABC#2)
// normalData = "_-2ag" (String#20473, DoABC#2)
// hasChangedLooks = "_-32V" (String#21597, DoABC#2)
// hasCalledGuideBot = "_-l6" (String#24074, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// RoomEntryInfoMessageParser = "_-2Z9" (String#6747, DoABC#2)
// RoomEntryInfoMessageEvent = "_-nk" (String#24182, DoABC#2)


