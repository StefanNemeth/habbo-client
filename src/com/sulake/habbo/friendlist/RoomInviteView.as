
package com.sulake.habbo.friendlist
{
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import flash.ui.Keyboard;
    import com.sulake.habbo.friendlist.domain.Friend;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.SendRoomInviteMessageComposer;

    public class RoomInviteView extends AlertView 
    {

        private var _selected:Array;
        private var _SafeStr_11284:ITextFieldWindow;

        public function RoomInviteView(_arg_1:HabboFriendList)
        {
            super(_arg_1, "room_invite_confirm");
            this._selected = _arg_1.categories.getSelectedFriends();
        }
        override public function dispose():void
        {
            this._selected = null;
            this._SafeStr_11284 = null;
            super.dispose();
        }
        override function setupContent(_arg_1:IWindowContainer):void
        {
            friendList.registerParameter("friendlist.invite.summary", "count", ("" + this._selected.length));
            this._SafeStr_11284 = ITextFieldWindow(_arg_1.findChildByName("message_input"));
            this._SafeStr_11284.addEventListener(WindowKeyboardEvent.WKE_KEY_DOWN, this.onMessageInput);
            _arg_1.findChildByName("cancel").procedure = onClose;
            _arg_1.findChildByName("ok").procedure = this.onInvite;
        }
        private function onInvite(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            Logger.log("Invite Ok clicked");
            this.sendMsg();
            this.dispose();
        }
        private function onMessageInput(_arg_1:WindowKeyboardEvent):void
        {
            var _local_3:int;
            var _local_4:String;
            var _local_2:IWindow = IWindow(_arg_1.target);
            Logger.log(((((("Test key event " + _arg_1) + ", ") + _arg_1.type) + " ") + _local_2.name));
            if (_arg_1.charCode == Keyboard.ENTER){
                this.sendMsg();
            }
            else {
                _local_3 = 120;
                _local_4 = this._SafeStr_11284.text;
                if (_local_4.length > _local_3){
                    this._SafeStr_11284.text = _local_4.substring(0, _local_3);
                };
            };
        }
        private function sendMsg():void
        {
            var _local_3:Friend;
            var _local_1:String = this._SafeStr_11284.text;
            Logger.log(("Send msg: " + _local_1));
            if (_local_1 == ""){
                new SimpleAlertView(friendList, "${friendlist.invite.emptyalert.title}", "${friendlist.invite.emptyalert.text}").show();
                return;
            };
            var _local_2:SendRoomInviteMessageComposer = new SendRoomInviteMessageComposer(_local_1);
            for each (_local_3 in this._selected) {
                _local_2.addInvitedFriend(_local_3.id);
            };
            friendList.send(_local_2);
            this.dispose();
        }

    }
}//package com.sulake.habbo.friendlist

// setupContent = "_-SD" (String#23333, DoABC#2)
// _SafeStr_11284 = "_-1X1" (String#5497, DoABC#2)
// onMessageInput = "_-37F" (String#7451, DoABC#2)
// onInvite = "_-1fV" (String#18117, DoABC#2)
// sendMsg = "_-38W" (String#7482, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// ITextFieldWindow = "_-3EL" (String#2027, DoABC#2)
// WindowKeyboardEvent = "_-0Di" (String#1433, DoABC#2)
// AlertView = "_-2G6" (String#883, DoABC#2)
// SendRoomInviteMessageComposer = "_-2fR" (String#20666, DoABC#2)
// RoomInviteView = "_-1xW" (String#5981, DoABC#2)
// addInvitedFriend = "_-2SM" (String#20131, DoABC#2)
// onClose = "_-2Ts" (String#54, DoABC#2)
// WKE_KEY_DOWN = "_-fs" (String#23884, DoABC#2)


