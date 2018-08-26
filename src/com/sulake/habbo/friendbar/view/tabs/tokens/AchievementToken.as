
package com.sulake.habbo.friendbar.view.tabs.tokens
{
    import com.sulake.habbo.friendbar.data.IFriendEntity;
    import com.sulake.habbo.friendbar.data.FriendNotification;
    import com.sulake.habbo.localization.IHabboLocalizationManager;

    public class AchievementToken extends Token 
    {

        public function AchievementToken(_arg_1:IFriendEntity, _arg_2:FriendNotification, _arg_3:Boolean, _arg_4:IHabboLocalizationManager)
        {
            super(_arg_2);
            var _local_5:String = _arg_4.getBadgeName(_arg_2.message);
            prepare("${friendbar.notify.achievement}", _local_5, "message_piece_xml", "event_notification_icon_png", "small_ach_notification_icon_png", _arg_3);
        }
    }
}//package com.sulake.habbo.friendbar.view.tabs.tokens

// IFriendEntity = "_-2nQ" (String#7031, DoABC#2)
// AchievementToken = "_-2Zn" (String#6755, DoABC#2)


