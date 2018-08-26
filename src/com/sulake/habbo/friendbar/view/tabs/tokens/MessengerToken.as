
package com.sulake.habbo.friendbar.view.tabs.tokens
{
    import com.sulake.habbo.friendbar.data.IFriendEntity;
    import com.sulake.habbo.friendbar.data.FriendNotification;

    public class MessengerToken extends Token 
    {

        public function MessengerToken(_arg_1:IFriendEntity, _arg_2:FriendNotification, _arg_3:Boolean)
        {
            super(_arg_2);
            prepare("${friendbar.notify.messenger}", _arg_2.message, "message_piece_xml", "imnew_notification_icon_png", "small_imnew_notification_icon_png", _arg_3);
        }
    }
}//package com.sulake.habbo.friendbar.view.tabs.tokens

// IFriendEntity = "_-2nQ" (String#7031, DoABC#2)
// MessengerToken = "_-1ao" (String#5574, DoABC#2)


