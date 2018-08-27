
package com.sulake.habbo.friendlist
{
    import com.sulake.habbo.friendlist.domain.Friend;
    import flash.utils.Dictionary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.RemoveBuddyMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class FriendRemoveView extends AlertView 
    {

        private var _selected:Array;

        public function FriendRemoveView(_arg_1:HabboFriendList)
        {
            super(_arg_1, "friend_remove_confirm");
            this._selected = _arg_1.categories.getSelectedFriends();
        }
        override public function dispose():void
        {
            this._selected = null;
            super.dispose();
        }
        override function setupContent(_arg_1:IWindowContainer):void
        {
            var _local_3:Friend;
            var _local_4:String;
            var _local_5:Dictionary;
            _arg_1.findChildByName("cancel").procedure = onClose;
            _arg_1.findChildByName("ok").procedure = this.onRemove;
            var _local_2:Array = new Array();
            for each (_local_3 in this._selected) {
                _local_2.push(_local_3.name);
            };
            _local_4 = Util.arrayToString(_local_2);
            _local_5 = new Dictionary();
            friendList.registerParameter("friendlist.removefriendconfirm.userlist", "user_names", _local_4);
        }
        private function onRemove(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_4:Friend;
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            Logger.log("Remove Ok clicked");
            var _local_3:RemoveBuddyMessageComposer = new RemoveBuddyMessageComposer();
            for each (_local_4 in this._selected) {
                _local_3.addRemovedFriend(_local_4.id);
            };
            friendList.send(_local_3);
            this.dispose();
        }

    }
}//package com.sulake.habbo.friendlist

// arrayToString = "_-20L" (String#19026, DoABC#2)
// setupContent = "_-SD" (String#23333, DoABC#2)
// onRemove = "_-Av" (String#22653, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// Util = "_-1ve" (String#445, DoABC#2)
// AlertView = "_-2G6" (String#883, DoABC#2)
// RemoveBuddyMessageComposer = "_-0OX" (String#15009, DoABC#2)
// FriendRemoveView = "_-02W" (String#3618, DoABC#2)
// addRemovedFriend = "_-1BE" (String#16907, DoABC#2)
// onClose = "_-2Ts" (String#54, DoABC#2)


