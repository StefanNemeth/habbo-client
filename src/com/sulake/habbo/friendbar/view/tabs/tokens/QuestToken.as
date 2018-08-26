
package com.sulake.habbo.friendbar.view.tabs.tokens
{
    import com.sulake.habbo.friendbar.data.IFriendEntity;
    import com.sulake.habbo.friendbar.data.FriendNotification;
    import com.sulake.habbo.localization.IHabboLocalizationManager;

    public class QuestToken extends Token 
    {

        public function QuestToken(_arg_1:IFriendEntity, _arg_2:FriendNotification, _arg_3:Boolean, _arg_4:IHabboLocalizationManager)
        {
            super(_arg_2);
            var _local_5 = (("${quests." + _arg_2.message) + ".name}");
            prepare("${friendbar.notify.quest}", _local_5, "message_piece_xml", "event_notification_icon_png", "small_ach_notification_icon_png", _arg_3);
        }
    }
}//package com.sulake.habbo.friendbar.view.tabs.tokens

// IFriendEntity = "_-2nQ" (String#7031, DoABC#2)
// QuestToken = "_-8N" (String#7829, DoABC#2)


