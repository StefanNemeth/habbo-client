
package com.sulake.habbo.moderation
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorUserInfoData;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.outgoing.moderator.GetModeratorUserInfoMessageComposer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.communication.messages.outgoing.moderator.GetUserChatlogMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class UserInfoCtrl implements IDisposable 
    {

        private static const _SafeStr_11844:int = 60;
        private static const _SafeStr_11845:int = (60 * 60);//3600
        private static const _SafeStr_11846:int = ((60 * 60) * 24);//86400
        private static const _SafeStr_11847:int = (((60 * 60) * 24) * 365);//31536000

        private var _callerFrame:IFrameWindow;
        private var _help:ModerationManager;
        private var _userId:int;
        private var _SafeStr_11848:String;
        private var _data:ModeratorUserInfoData;
        private var _SafeStr_11849:IWindowContainer;
        private var _SafeStr_11850:Boolean;
        private var _disposed:Boolean;

        public function UserInfoCtrl(_arg_1:IFrameWindow, _arg_2:ModerationManager, _arg_3:String, _arg_4:Boolean=false)
        {
            this._callerFrame = _arg_1;
            this._help = _arg_2;
            this._SafeStr_11848 = _arg_3;
            this._SafeStr_11850 = _arg_4;
        }
        public static function UserInfoCtrl(_arg_1:int):String
        {
            if (_arg_1 < (2 * _SafeStr_11844)){
                return ((_arg_1 + " secs ago"));
            };
            if (_arg_1 < (2 * _SafeStr_11845)){
                return ((Math.round((_arg_1 / _SafeStr_11844)) + " mins ago"));
            };
            if (_arg_1 < (2 * _SafeStr_11846)){
                return ((Math.round((_arg_1 / _SafeStr_11845)) + " hours ago"));
            };
            if (_arg_1 < (2 * _SafeStr_11847)){
                return ((Math.round((_arg_1 / _SafeStr_11846)) + " days ago"));
            };
            return ((Math.round((_arg_1 / _SafeStr_11847)) + " years ago"));
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function load(_arg_1:IWindowContainer, _arg_2:int):void
        {
            this._SafeStr_11849 = _arg_1;
            this._userId = _arg_2;
            this._data = null;
            this.refresh();
            this._help.messageHandler.addUserInfoListener(this);
            this._help.connection.send(new GetModeratorUserInfoMessageComposer(_arg_2));
        }
        public function InfostandWidget(_arg_1:ModeratorUserInfoData):void
        {
            if (_arg_1.userId != this._userId){
                return;
            };
            this._data = _arg_1;
            this.refresh();
        }
        public function refresh():void
        {
            if (this._SafeStr_11849.disposed){
                return;
            };
            var _local_1:IWindowContainer = this.prepare();
            if (this._data == null){
                _local_1.findChildByName("fields").visible = false;
                _local_1.findChildByName("loading_txt").visible = true;
                return;
            };
            _local_1.findChildByName("fields").visible = true;
            _local_1.findChildByName("loading_txt").visible = false;
            this.UserInfoCtrl(_local_1, "name_txt", this._data.userName);
            this.UserInfoCtrl(_local_1, "cfh_count_txt", ("" + this._data._SafeStr_6425));
            this.UserInfoCtrl(_local_1, "abusive_cfh_count_txt", this._data.abusiveCfhCount, false);
            this.UserInfoCtrl(_local_1, "caution_count_txt", this._data.cautionCount, true);
            this.UserInfoCtrl(_local_1, "ban_count_txt", this._data.banCount, true);
            this.UserInfoCtrl(_local_1, "registered_txt", UserInfoCtrl((this._data.minutesSinceRegistration * 60)));
            this.UserInfoCtrl(_local_1, "last_login_txt", UserInfoCtrl((this._data.minutesSinceLastLogin * 60)));
            this.UserInfoCtrl(_local_1, "online_txt", ((this._data.online) ? "Yes" : "No"));
            Logger.log(((((("USER: " + this._data.userName) + ", ") + this._data.banCount) + ", ") + this._data.cautionCount));
        }
        public function dispose():void
        {
            if (this._disposed){
                return;
            };
            this._disposed = true;
            this._help.messageHandler.removeUserInfoListener(this);
            this._callerFrame = null;
            this._help = null;
            this._data = null;
            this._SafeStr_11849 = null;
        }
        private function prepare():IWindowContainer
        {
            var _local_1:IWindowContainer = IWindowContainer(this._SafeStr_11849.findChildByName("user_info"));
            if (_local_1 == null){
                _local_1 = IWindowContainer(this._help.getXmlWindow("user_info"));
                this._SafeStr_11849.addChild(_local_1);
                this._help.disableButton(this._help.initMsg.chatlogsPermission, _local_1, "chatlog_but");
                this._help.disableButton(this._help.initMsg.alertPermission, _local_1, "message_but");
                this._help.disableButton(((((this._help.initMsg.alertPermission) || (this._help.initMsg.kickPermission))) || (this._help.initMsg.banPermission)), _local_1, "modaction_but");
            };
            _local_1.findChildByName("chatlog_but").procedure = this.UserInfoCtrl;
            _local_1.findChildByName("roomvisits_but").procedure = this.UserInfoCtrl;
            _local_1.findChildByName("habboinfotool_but").procedure = this.UserInfoCtrl;
            _local_1.findChildByName("message_but").procedure = this.UserInfoCtrl;
            _local_1.findChildByName("modaction_but").procedure = this.UserInfoCtrl;
            _local_1.findChildByName("view_caution_count_txt").procedure = this.UserInfoCtrl;
            _local_1.findChildByName("view_ban_count_txt").procedure = this.UserInfoCtrl;
            return (_local_1);
        }
        private function UserInfoCtrl(_arg_1:IWindowContainer, _arg_2:String, _arg_3:int, _arg_4:Boolean):void
        {
            var _local_5:ITextWindow = ITextWindow(_arg_1.findChildByName(_arg_2));
            var _local_6:ITextWindow = ITextWindow(_arg_1.findChildByName(("view_" + _arg_2)));
            if (_local_6 != null){
                _local_6.visible = (_arg_3 > 0);
            };
            _local_5.visible = (_arg_3 > 0);
            _local_5.text = ("" + _arg_3);
        }
        private function UserInfoCtrl(_arg_1:IWindowContainer, _arg_2:String, _arg_3:String):void
        {
            var _local_4:ITextWindow = ITextWindow(_arg_1.findChildByName(_arg_2));
            _local_4.text = _arg_3;
        }
        private function UserInfoCtrl(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this._help.windowTracker.show(new ChatlogCtrl(new GetUserChatlogMessageComposer(this._data.userId), this._help, WindowTracker._SafeStr_11780, this._data.userId), this._callerFrame, this._SafeStr_11850, false, true);
        }
        private function UserInfoCtrl(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this._help.windowTracker.show(new RoomVisitsCtrl(this._help, this._data.userId), this._callerFrame, this._SafeStr_11850, false, true);
        }
        private function UserInfoCtrl(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this._help.openHkPage("habboinfotool.url", this._data.userName);
        }
        private function UserInfoCtrl(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this._help.windowTracker.show(new SendMsgsCtrl(this._help, this._data.userId, this._data.userName, this._SafeStr_11848), this._callerFrame, this._SafeStr_11850, false, true);
        }
        private function UserInfoCtrl(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this._help.windowTracker.show(new ModActionCtrl(this._help, this._data.userId, this._data.userName, this._SafeStr_11848), this._callerFrame, this._SafeStr_11850, false, true);
        }
        private function UserInfoCtrl(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this.UserInfoCtrl();
        }
        private function UserInfoCtrl(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this.UserInfoCtrl();
        }
        private function UserInfoCtrl():void
        {
            this._help.openHkPage("moderatoractionlog.url", this._data.userName);
        }

    }
}//package com.sulake.habbo.moderation

// _help = "_-3HG" (String#114, DoABC#2)
// UserInfoCtrl = "_-1xm" (String#5987, DoABC#2)
// disableButton = "_-24c" (String#19207, DoABC#2)
// initMsg = "_-MD" (String#23092, DoABC#2)
// windowTracker = "_-1CG" (String#16953, DoABC#2)
// _SafeStr_11780 = "_-0Xa" (String#15339, DoABC#2)
// addUserInfoListener = "_-1z6" (String#18931, DoABC#2)
// removeUserInfoListener = "_-2us" (String#21272, DoABC#2)
// messageHandler = "_-2T6" (String#20168, DoABC#2)
// UserInfoCtrl = "_-0zx" (String#4847, DoABC#2)
// openHkPage = "_-mj" (String#24138, DoABC#2)
// _SafeStr_11844 = "_-1ip" (String#18238, DoABC#2)
// _SafeStr_11845 = "_-1ly" (String#18374, DoABC#2)
// _SafeStr_11846 = "_-28Y" (String#19352, DoABC#2)
// _SafeStr_11847 = "_-1Q-" (String#17509, DoABC#2)
// _SafeStr_11848 = "_-2-7" (String#1795, DoABC#2)
// _SafeStr_11849 = "_-0DU" (String#14587, DoABC#2)
// _SafeStr_11850 = "_-qj" (String#24304, DoABC#2)
// UserInfoCtrl = "_-1to" (String#18709, DoABC#2)
// UserInfoCtrl = "_-2jc" (String#20830, DoABC#2)
// UserInfoCtrl = "_-2zq" (String#21454, DoABC#2)
// UserInfoCtrl = "_-4M" (String#22392, DoABC#2)
// UserInfoCtrl = "_-Ew" (String#22809, DoABC#2)
// UserInfoCtrl = "_-vH" (String#24500, DoABC#2)
// UserInfoCtrl = "_-02v" (String#14157, DoABC#2)
// UserInfoCtrl = "_-12Q" (String#16555, DoABC#2)
// UserInfoCtrl = "_-1L5" (String#17318, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// WindowTracker = "_-2m9" (String#7008, DoABC#2)
// GetModeratorUserInfoMessageComposer = "_-2fD" (String#20655, DoABC#2)
// GetUserChatlogMessageComposer = "_-Pp" (String#23241, DoABC#2)
// ChatlogCtrl = "_-2GT" (String#6377, DoABC#2)
// UserInfoCtrl = "_-ip" (String#8573, DoABC#2)
// RoomVisitsCtrl = "_-2rD" (String#7106, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// ModeratorUserInfoData = "_-0Cn" (String#3805, DoABC#2)
// SendMsgsCtrl = "_-Ls" (String#8122, DoABC#2)
// ModActionCtrl = "_-0HN" (String#3902, DoABC#2)
// InfostandWidget = "_-2pH" (String#623, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// minutesSinceRegistration = "_-35X" (String#21714, DoABC#2)
// minutesSinceLastLogin = "_-1gG" (String#18150, DoABC#2)
// _SafeStr_6425 = "super" (String#46908, DoABC#2)
// abusiveCfhCount = "_-qT" (String#24291, DoABC#2)
// cautionCount = "_-KY" (String#23025, DoABC#2)
// banCount = "_-0ys" (String#16386, DoABC#2)
// chatlogsPermission = "_-Cg" (String#22712, DoABC#2)
// alertPermission = "_-1B8" (String#16904, DoABC#2)
// kickPermission = "_-0-P" (String#14029, DoABC#2)
// banPermission = "_-1Gj" (String#17141, DoABC#2)


