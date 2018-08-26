
package com.sulake.habbo.friendbar.view.tabs.tokens
{
    import com.sulake.habbo.friendbar.data.IFriendEntity;
    import com.sulake.habbo.friendbar.data.FriendNotification;

    public class RoomEventToken extends Token 
    {

        public function RoomEventToken(_arg_1:IFriendEntity, _arg_2:FriendNotification, _arg_3:Boolean)
        {
            super(_arg_2);
            prepare("${friendbar.notify.event}", _arg_2.message, "message_piece_xml", "event_notification_icon_png", "small_event_notification_icon_png", _arg_3);
        }
    }
}//package com.sulake.habbo.friendbar.view.tabs.tokens

// IFriendEntity = "_-2nQ" (String#7031, DoABC#2)
// RoomEventToken = "_-2wU" (String#7213, DoABC#2)


