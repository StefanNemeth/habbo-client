
package com.sulake.habbo.moderation
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.IssueMessageData;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ICheckBoxWindow;
    import flash.utils.getTimer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.communication.messages.outgoing.moderator.GetCfhChatlogMessageComposer;

    public class IssueHandler implements TrackedWindow 
    {

        private var _SafeStr_11757:ModerationManager;
        private var _SafeStr_11880:IssueBundle;
        private var _window:IFrameWindow;
        private var _SafeStr_11881:UserInfoCtrl;
        private var _SafeStr_11882:UserInfoCtrl;
        private var _disposed:Boolean;

        public function IssueHandler(_arg_1:ModerationManager, _arg_2:IssueBundle)
        {
            this._SafeStr_11757 = _arg_1;
            this._SafeStr_11880 = _arg_2;
        }
        public function getType():int
        {
            return (WindowTracker.TYPE_ISSUEHANDLER);
        }
        public function getId():String
        {
            return (("" + this._SafeStr_11880.id));
        }
        public function getFrame():IFrameWindow
        {
            return (this._window);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            if (this._disposed){
                return;
            };
            this._disposed = true;
            if (this._window != null){
                this._window.dispose();
                this._window = null;
            };
            if (this._SafeStr_11881 != null){
                this._SafeStr_11881.dispose();
                this._SafeStr_11881 = null;
            };
            if (this._SafeStr_11882 != null){
                this._SafeStr_11882.dispose();
                this._SafeStr_11882 = null;
            };
            this._SafeStr_11757 = null;
            this._SafeStr_11880 = null;
        }
        public function show():void
        {
            this.createView();
        }
        private function createView():void
        {
            var _local_6:IItemListWindow;
            var _local_7:IWindow;
            if (this._window != null){
                return;
            };
            if ((((this._SafeStr_11757.windowManager == null)) || ((this._SafeStr_11757.assets == null)))){
                return;
            };
            var _local_1:XmlAsset = (this._SafeStr_11757.assets.getAssetByName("issue_handler_xml") as XmlAsset);
            if ((((_local_1 == null)) || ((_local_1.content == null)))){
                return;
            };
            this._window = (this._SafeStr_11757.windowManager.buildFromXML((_local_1.content as XML)) as IFrameWindow);
            if (this._window == null){
                return;
            };
            var _local_2:IWindow = this._window.findChildByTag("close");
            if (_local_2 != null){
                _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.PollOfferDialog);
            };
            _local_2 = this._window.findChildByName("issue_cont");
            if (_local_2 != null){
                _local_2.addEventListener(WindowEvent.WE_RESIZED, this.IssueHandler);
            };
            this.setProc("close_useless", this.IssueHandler);
            this.setProc("close_abusive", this.IssueHandler);
            this.setProc("close_resolved", this.IssueHandler);
            this.setProc("release", this.IssueHandler);
            this.setProc("move_to_player_support", this.IssueHandler);
            this.setProc("show_chatlog", this.IssueHandler);
            this._SafeStr_11757.disableButton(this._SafeStr_11757.initMsg.chatlogsPermission, this._window, "show_chatlog");
            _local_2 = this._window.findChildByName("move_to_player_support");
            if (_local_2 != null){
                _local_2.disable();
            };
            var _local_3:IssueMessageData = this._SafeStr_11880.getHighestPriorityIssue();
            this._SafeStr_11881 = new UserInfoCtrl(this._window, this._SafeStr_11757, _local_3.message);
            this._SafeStr_11882 = new UserInfoCtrl(this._window, this._SafeStr_11757, _local_3.message);
            this._SafeStr_11881.load(IWindowContainer(this._window.findChildByName("caller_user_info")), _local_3.reporterUserId);
            var _local_4:IWindowContainer = IWindowContainer(this._window.findChildByName("reported_user_info"));
            if (this._SafeStr_11880.reportedUserId > 0){
                this._SafeStr_11882.load(_local_4, this._SafeStr_11880.reportedUserId);
            }
            else {
                _local_6 = IItemListWindow(this._window.findChildByName("issue_cont"));
                _local_7 = this._window.findChildByName("reported_user_info_caption");
                _local_6.removeListItem(_local_7);
                _local_6.removeListItem(_local_4);
            };
            var _local_5:ICheckBoxWindow = (this._window.findChildByName("handle_next_checkbox") as ICheckBoxWindow);
            if (_local_5 != null){
                _local_5.select();
            };
            Logger.log(("HARASSER: " + this._SafeStr_11880.reportedUserId));
            this.IssueHandler();
            this.IssueHandler();
        }
        private function IssueHandler(_arg_1:WindowEvent):void
        {
            if (_arg_1 == null){
                return;
            };
            var _local_2:IItemListWindow = (_arg_1.window as IItemListWindow);
            if (_local_2 == null){
                return;
            };
            var _local_3:IItemListWindow = (_local_2.getListItemByName("issues_item_list") as IItemListWindow);
            var _local_4:IItemListWindow = (_local_2.getListItemByName("msg_item_list") as IItemListWindow);
            if ((((_local_3 == null)) || ((_local_4 == null)))){
                return;
            };
            var _local_5:int = ((((_local_2.height - _local_2.scrollableRegion.height) + _local_3.height) + _local_4.height) * 0.5);
            _local_2.autoArrangeItems = false;
            _local_3.height = _local_5;
            _local_4.height = _local_5;
            _local_2.autoArrangeItems = true;
        }
        private function IssueHandler():void
        {
            var _local_4:IWindowContainer;
            var _local_7:IssueMessageData;
            var _local_9:XmlAsset;
            var _local_10:IWindowContainer;
            var _local_11:IWindow;
            var _local_12:IWindow;
            if (this._window == null){
                return;
            };
            var _local_1:IItemListWindow = (this._window.findChildByName("issues_item_list") as IItemListWindow);
            if (_local_1 == null){
                return;
            };
            var _local_2:Array = this._SafeStr_11880.issues;
            var _local_3:int;
            var _local_5:int = _local_1.numListItems;
            var _local_6:int = _local_2.length;
            if (_local_5 < _local_6){
                _local_9 = (this._SafeStr_11757.assets.getAssetByName("issue_handler_issue_info_xml") as XmlAsset);
                if ((((_local_9 == null)) || ((_local_9.content == null)))){
                    return;
                };
                _local_4 = (this._SafeStr_11757.windowManager.buildFromXML((_local_9.content as XML)) as IWindowContainer);
                if (_local_4 == null){
                    return;
                };
                _local_1.addListItem(_local_4);
                _local_3 = 1;
                while (_local_3 < (_local_6 - _local_5)) {
                    _local_10 = (_local_4.clone() as IWindowContainer);
                    if (_local_10 == null){
                        return;
                    };
                    _local_1.addListItem(_local_10);
                    _local_3++;
                };
            }
            else {
                if (_local_5 > _local_6){
                    _local_3 = 0;
                    while (_local_3 < (_local_5 - _local_6)) {
                        _local_11 = _local_1.IItemListWindow(0);
                        _local_11.dispose();
                        _local_3++;
                    };
                };
            };
            var _local_8:int = getTimer();
            _local_3 = 0;
            for each (_local_7 in _local_2) {
                _local_4 = (_local_1.getListItemAt(_local_3) as IWindowContainer);
                if (_local_4 == null){
                    return;
                };
                _local_4.background = ((_local_3++ % 2) == 0);
                _local_12 = _local_4.findChildByName("reporter");
                if (_local_12 != null){
                    _local_12.caption = _local_7.reporterUserName;
                    _local_12.id = _local_7.reporterUserId;
                    _local_12.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.IssueHandler);
                    _local_12.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.IssueHandler);
                };
                this.IssueHandler(_local_4.findChildByName("category"), IssueCategoryNames.getCategoryName(_local_7.reportedCategoryId));
                this.IssueHandler(_local_4.findChildByName("room"), _local_7.roomName);
                this.IssueHandler(_local_4.findChildByName("time_open"), _local_7.getOpenTime(_local_8));
            };
        }
        private function IssueHandler():void
        {
            var _local_4:ITextWindow;
            var _local_7:IssueMessageData;
            var _local_8:XmlAsset;
            var _local_9:ITextWindow;
            var _local_10:IWindow;
            if (this._window == null){
                return;
            };
            var _local_1:IItemListWindow = (this._window.findChildByName("msg_item_list") as IItemListWindow);
            if (_local_1 == null){
                return;
            };
            var _local_2:Array = this._SafeStr_11880.issues;
            var _local_3:int;
            var _local_5:int = _local_1.numListItems;
            var _local_6:int = _local_2.length;
            if (_local_5 < _local_6){
                _local_8 = (this._SafeStr_11757.assets.getAssetByName("issue_handler_message_list_item_xml") as XmlAsset);
                if ((((_local_8 == null)) || ((_local_8.content == null)))){
                    return;
                };
                _local_4 = (this._SafeStr_11757.windowManager.buildFromXML((_local_8.content as XML)) as ITextWindow);
                if (_local_4 == null){
                    return;
                };
                _local_1.addListItem(_local_4);
                _local_3 = 1;
                while (_local_3 < (_local_6 - _local_5)) {
                    _local_9 = (_local_4.clone() as ITextWindow);
                    if (_local_9 == null){
                        return;
                    };
                    _local_1.addListItem(_local_9);
                    _local_3++;
                };
            }
            else {
                if (_local_5 > _local_6){
                    _local_3 = 0;
                    while (_local_3 < (_local_5 - _local_6)) {
                        _local_10 = _local_1.IItemListWindow(0);
                        _local_10.dispose();
                        _local_3++;
                    };
                };
            };
            _local_3 = 0;
            for each (_local_7 in _local_2) {
                _local_4 = (_local_1.getListItemAt(_local_3) as ITextWindow);
                if (_local_4 == null){
                    return;
                };
                _local_4.width = _local_1.width;
                _local_4.background = ((_local_3++ % 2) == 0);
                _local_4.caption = ((_local_7.reporterUserName + ": ") + _local_7.message);
                _local_4.height = (_local_4.textHeight + 10);
            };
        }
        private function IssueHandler(_arg_1:IWindow, _arg_2:String):void
        {
            if (_arg_1 != null){
                _arg_1.caption = _arg_2;
            };
        }
        private function setProc(_arg_1:String, _arg_2:Function):void
        {
            this._window.findChildByName(_arg_1).addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, _arg_2);
        }
        private function PollOfferDialog(_arg_1:WindowMouseEvent):void
        {
            if (((((!((this._SafeStr_11757 == null))) && (!((this._SafeStr_11757.issueManager == null))))) && (!((this._SafeStr_11880 == null))))){
                this._SafeStr_11757.issueManager.removeHandler(this._SafeStr_11880.id);
            };
            this.dispose();
        }
        private function IssueHandler(_arg_1:WindowMouseEvent):void
        {
            Logger.log("Close useless clicked");
            this._SafeStr_11757.issueManager.closeBundle(this._SafeStr_11880.id, 1);
            this.IssueHandler();
            this.dispose();
        }
        private function IssueHandler(_arg_1:WindowMouseEvent):void
        {
            Logger.log("Close abusive clicked");
            this._SafeStr_11757.issueManager.closeBundle(this._SafeStr_11880.id, 2);
            this.IssueHandler();
            this.dispose();
        }
        private function IssueHandler(_arg_1:WindowMouseEvent):void
        {
            Logger.log("Close resolved clicked");
            this._SafeStr_11757.issueManager.closeBundle(this._SafeStr_11880.id, 3);
            this.IssueHandler();
            this.dispose();
        }
        private function IssueHandler(_arg_1:WindowMouseEvent):void
        {
            Logger.log("Release clicked");
            this._SafeStr_11757.issueManager.releaseBundle(this._SafeStr_11880.id);
            this.IssueHandler();
            this.dispose();
        }
        private function IssueHandler(_arg_1:WindowMouseEvent):void
        {
            Logger.log("Move to player support clicked");
        }
        private function IssueHandler(_arg_1:WindowMouseEvent):void
        {
            Logger.log("Show chatlog clicked");
            var _local_2:int = this._SafeStr_11880.getHighestPriorityIssue().issueId;
            this._SafeStr_11757.windowTracker.show(new ChatlogCtrl(new GetCfhChatlogMessageComposer(_local_2), this._SafeStr_11757, WindowTracker._SafeStr_11779, _local_2), this._window, false, false, true);
        }
        private function IssueHandler(_arg_1:WindowMouseEvent):void
        {
            var _local_3:IssueMessageData;
            var _local_2:int = _arg_1.window.id;
            if (_local_2 != 0){
                if (this._SafeStr_11881 != null){
                    this._SafeStr_11881.dispose();
                };
                _local_3 = this._SafeStr_11880.getHighestPriorityIssue();
                this._SafeStr_11881 = new UserInfoCtrl(this._window, this._SafeStr_11757, _local_3.message);
                this._SafeStr_11881.load(IWindowContainer(this._window.findChildByName("caller_user_info")), _local_2);
            };
        }
        public function update():void
        {
            this.IssueHandler();
            this.IssueHandler();
        }
        private function IssueHandler():void
        {
            if ((((((this._window == null)) || ((this._SafeStr_11757 == null)))) || ((this._SafeStr_11757.issueManager == null)))){
                return;
            };
            var _local_1:ICheckBoxWindow = (this._window.findChildByName("handle_next_checkbox") as ICheckBoxWindow);
            if (((!((_local_1 == null))) && (_local_1.isSelected))){
                this._SafeStr_11757.issueManager.autoPick();
            };
        }

    }
}//package com.sulake.habbo.moderation

// disableButton = "_-24c" (String#19207, DoABC#2)
// initMsg = "_-MD" (String#23092, DoABC#2)
// windowTracker = "_-1CG" (String#16953, DoABC#2)
// issueManager = "_-277" (String#19296, DoABC#2)
// _SafeStr_11757 = "_-6S" (String#2051, DoABC#2)
// autoPick = "_-Ot" (String#23201, DoABC#2)
// _SafeStr_11779 = "_-1Ka" (String#17297, DoABC#2)
// _SafeStr_11880 = "_-2p-" (String#21041, DoABC#2)
// _SafeStr_11881 = "_-09K" (String#14422, DoABC#2)
// _SafeStr_11882 = "_-29C" (String#19373, DoABC#2)
// IssueHandler = "_-3L7" (String#22329, DoABC#2)
// setProc = "_-333" (String#1990, DoABC#2)
// IssueHandler = "_-1rh" (String#18617, DoABC#2)
// IssueHandler = "_-1bJ" (String#17949, DoABC#2)
// IssueHandler = "_-1TN" (String#17641, DoABC#2)
// IssueHandler = "_-2Qb" (String#6571, DoABC#2)
// IssueHandler = "_-0tb" (String#16184, DoABC#2)
// IssueHandler = "_-Qf" (String#23273, DoABC#2)
// getHighestPriorityIssue = "_-22z" (String#19134, DoABC#2)
// IssueHandler = "_-1uU" (String#18736, DoABC#2)
// IssueHandler = "_-da" (String#23785, DoABC#2)
// IssueHandler = "_-0gC" (String#15681, DoABC#2)
// getCategoryName = "_-0mq" (String#15933, DoABC#2)
// removeHandler = "_-mr" (String#24145, DoABC#2)
// closeBundle = "_-06c" (String#14311, DoABC#2)
// IssueHandler = "_-2TB" (String#20171, DoABC#2)
// releaseBundle = "_-2Nx" (String#19962, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// ICheckBoxWindow = "_-1zu" (String#1793, DoABC#2)
// WindowTracker = "_-2m9" (String#7008, DoABC#2)
// GetCfhChatlogMessageComposer = "_-1Za" (String#17873, DoABC#2)
// TrackedWindow = "_-Xp" (String#8365, DoABC#2)
// ChatlogCtrl = "_-2GT" (String#6377, DoABC#2)
// UserInfoCtrl = "_-ip" (String#8573, DoABC#2)
// IssueMessageData = "_-0K1" (String#3952, DoABC#2)
// IssueHandler = "_-2xf" (String#7231, DoABC#2)
// IssueBundle = "_-1x4" (String#18850, DoABC#2)
// IssueCategoryNames = "_-2eJ" (String#6840, DoABC#2)
// WE_RESIZED = "_-76" (String#22505, DoABC#2)
// scrollableRegion = "_-2ku" (String#6976, DoABC#2)
// getFrame = "_-3Jk" (String#923, DoABC#2)
// PollOfferDialog = "_-2Ts" (String#54, DoABC#2)
// IItemListWindow = "_-Td" (String#8279, DoABC#2)
// chatlogsPermission = "_-Cg" (String#22712, DoABC#2)
// issueId = "_-1yh" (String#18916, DoABC#2)
// reportedCategoryId = "_-eV" (String#23822, DoABC#2)
// reporterUserId = "_-8I" (String#22554, DoABC#2)
// reporterUserName = "_-2fY" (String#20671, DoABC#2)
// getOpenTime = "_-P3" (String#23209, DoABC#2)
// IssueHandler = "_-rz" (String#8735, DoABC#2)


