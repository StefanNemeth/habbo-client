
package com.sulake.habbo.moderation
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.PublicSpaceCastLibsMessageParser;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.outgoing.moderator.GetRoomChatlogMessageComposer;

    public class StartPanelCtrl implements IDisposable 
    {

        private var _help:ModerationManager;
        private var _frame:IFrameWindow;
        private var _userId:int;
        private var _SafeStr_11743:Boolean;
        private var _roomId:int;
        private var _disposed:Boolean = false;

        public function StartPanelCtrl(_arg_1:ModerationManager)
        {
            this._help = _arg_1;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            if (!this._disposed){
                this._help = null;
                if (this._frame){
                    this._frame.dispose();
                    this._frame = null;
                };
            };
        }
        public function userSelected(_arg_1:int, _arg_2:String):void
        {
            if (this._frame == null){
                return;
            };
            this._userId = _arg_1;
            var _local_3:IButtonWindow = IButtonWindow(this._frame.findChildByName("userinfo_but"));
            _local_3.enable();
            _local_3.caption = ("User info: " + _arg_2);
        }
        public function StartPanelCtrl(_arg_1:RoomEntryInfoMessageParser):void
        {
            if ((((this._frame == null)) || ((_arg_1 == null)))){
                return;
            };
            this._frame.findChildByName("room_tool_but").enable();
            this.StartPanelCtrl();
            this._SafeStr_11743 = true;
            this._roomId = _arg_1.guestRoomId;
        }
        public function StartPanelCtrl(_arg_1:PublicSpaceCastLibsMessageParser):void
        {
            if ((((this._frame == null)) || ((_arg_1 == null)))){
                return;
            };
            this._frame.findChildByName("room_tool_but").disable();
            this.StartPanelCtrl();
            this._SafeStr_11743 = false;
            this._roomId = _arg_1.nodeId;
        }
        public function StartPanelCtrl():void
        {
            if (this._frame == null){
                return;
            };
            this._frame.findChildByName("room_tool_but").disable();
            this._frame.findChildByName("chatlog_but").disable();
        }
        public function show():void
        {
            if (this._frame == null){
                this._frame = IFrameWindow(this._help.getXmlWindow("start_panel"));
                this._frame.findChildByName("room_tool_but").procedure = this.StartPanelCtrl;
                this._frame.findChildByName("chatlog_but").procedure = this.UserInfoCtrl;
                this._frame.findChildByName("ticket_queue_but").procedure = this.StartPanelCtrl;
                this._frame.findChildByName("userinfo_but").procedure = this.StartPanelCtrl;
                this._frame.findChildByName("userinfo_but").disable();
                this._frame.findChildByName("room_tool_but").disable();
                this._frame.findChildByName("chatlog_but").disable();
                this._help.disableButton(this._help.initMsg.cfhPermission, this._frame, "ticket_queue_but");
                this._help.disableButton(this._help.initMsg.chatlogsPermission, this._frame, "chatlog_but");
            };
            this._frame.visible = true;
        }
        private function StartPanelCtrl():void
        {
            if (this._help.initMsg.chatlogsPermission){
                this._frame.findChildByName("chatlog_but").enable();
            };
        }
        private function StartPanelCtrl(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this._help.windowTracker.show(new RoomToolCtrl(this._help, this._roomId), this._frame, false, false, true);
        }
        private function UserInfoCtrl(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this._help.windowTracker.show(new ChatlogCtrl(new GetRoomChatlogMessageComposer(((this._SafeStr_11743) ? 0 : 1), this._roomId), this._help, WindowTracker._SafeStr_11755, this._roomId), this._frame, false, false, true);
        }
        private function StartPanelCtrl(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this._help.windowTracker.show(new UserInfoFrameCtrl(this._help, this._userId), this._frame, false, false, true);
        }
        private function StartPanelCtrl(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this._help.issueManager.init();
        }

    }
}//package com.sulake.habbo.moderation

// _help = "_-3HG" (String#114, DoABC#2)
// _SafeStr_11743 = "_-1E-" (String#17026, DoABC#2)
// StartPanelCtrl = "_-03g" (String#14190, DoABC#2)
// StartPanelCtrl = "_-Cv" (String#22723, DoABC#2)
// StartPanelCtrl = "_-2P5" (String#20006, DoABC#2)
// StartPanelCtrl = "_-2fB" (String#20654, DoABC#2)
// StartPanelCtrl = "_-1US" (String#17683, DoABC#2)
// UserInfoCtrl = "_-1xm" (String#5987, DoABC#2)
// StartPanelCtrl = "_-0qG" (String#16060, DoABC#2)
// StartPanelCtrl = "_-06g" (String#14313, DoABC#2)
// disableButton = "_-24c" (String#19207, DoABC#2)
// initMsg = "_-MD" (String#23092, DoABC#2)
// windowTracker = "_-1CG" (String#16953, DoABC#2)
// _SafeStr_11755 = "_-12Z" (String#16561, DoABC#2)
// issueManager = "_-277" (String#19296, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// StartPanelCtrl = "_-0Ej" (String#3844, DoABC#2)
// WindowTracker = "_-2m9" (String#7008, DoABC#2)
// PublicSpaceCastLibsMessageParser = "_-3Dk" (String#7592, DoABC#2)
// GetRoomChatlogMessageComposer = "_-2AI" (String#19416, DoABC#2)
// UserInfoFrameCtrl = "_-1D1" (String#5125, DoABC#2)
// ChatlogCtrl = "_-2GT" (String#6377, DoABC#2)
// RoomToolCtrl = "_-0Tu" (String#4178, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// guestRoomId = "_-1NR" (String#17415, DoABC#2)
// nodeId = "_-3K6" (String#22286, DoABC#2)
// cfhPermission = "_-0zz" (String#16426, DoABC#2)
// chatlogsPermission = "_-Cg" (String#22712, DoABC#2)
// RoomEntryInfoMessageParser = "_-2Z9" (String#6747, DoABC#2)


