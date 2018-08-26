
package com.sulake.habbo.ui.widget.infostand
{
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class InfoStandBotView extends InfoStandUserView 
    {

        public function InfoStandBotView(_arg_1:InfostandWidget, _arg_2:String)
        {
            super(_arg_1, _arg_2);
        }
        override protected function createWindow(_arg_1:String, _arg_2:Boolean):void
        {
            var _local_3:ITextWindow;
            super.createWindow(_arg_1, true);
            _local_3 = (_SafeStr_13990.getListItemByName("score_spacer") as ITextWindow);
            _SafeStr_13990.removeListItem(_local_3);
            _local_3 = (_SafeStr_13990.getListItemByName("score_text") as ITextWindow);
            _SafeStr_13990.removeListItem(_local_3);
            _local_3 = (_SafeStr_13990.getListItemByName("score_value") as ITextWindow);
            _SafeStr_13990.removeListItem(_local_3);
        }
        override public function update(_arg_1:RoomWidgetUserInfoUpdateEvent):void
        {
            InfoStandUserView();
            InfoStandUserView([]);
            this.InfoStandUserView(_arg_1);
            InfoStandUserView(_arg_1);
            InfoStandUserView();
        }
        override protected function InfoStandUserView(_arg_1:RoomWidgetUserInfoUpdateEvent):void
        {
            InfoStandUserView("friend", false);
            InfoStandUserView("respect", false);
            InfoStandUserView("ignore", false);
            InfoStandUserView("unignore", false);
            InfoStandUserView("kick", _arg_1.canBeKicked);
            InfoStandUserView("ban", false);
            InfoStandUserView("whisper", false);
            InfoStandUserView(false, false);
            InfoStandUserView("trade", false);
            InfoStandUserView("report", false);
            InfoStandUserView("give_badge", false);
            _SafeStr_13989.visible = _arg_1.canBeKicked;
        }
        override protected function InfoStandUserView(_arg_1:WindowMouseEvent):void
        {
            var _local_3:int;
            var _local_2:IWindow = (_arg_1.target as IWindow);
            if (_local_2.name == "kick"){
                _local_3 = _widget.userData.userRoomId;
                _widget.messageListener.processWidgetMessage(new RoomWidgetUserActionMessage(RoomWidgetUserActionMessage.RWUAM_KICK_BOT, _local_3));
            };
        }

    }
}//package com.sulake.habbo.ui.widget.infostand

// InfoStandUserView = "_-jx" (String#8602, DoABC#2)
// _SafeStr_13989 = "_-1WU" (String#5481, DoABC#2)
// _SafeStr_13990 = "_-38U" (String#2009, DoABC#2)
// InfoStandUserView = "_-37K" (String#21781, DoABC#2)
// InfoStandUserView = "_-6H" (String#22477, DoABC#2)
// InfoStandUserView = "_-1Oq" (String#17461, DoABC#2)
// RoomWidgetUserInfoUpdateEvent = "_-28z" (String#6226, DoABC#2)
// InfoStandUserView = "_-5X" (String#7772, DoABC#2)
// InfoStandBotView = "_-0DT" (String#3817, DoABC#2)
// RoomWidgetUserActionMessage = "_-22U" (String#19109, DoABC#2)
// RWUAM_KICK_BOT = "_-0BZ" (String#14509, DoABC#2)
// InfoStandUserView = "_-2k0" (String#247, DoABC#2)
// InfoStandUserView = "_-i5" (String#942, DoABC#2)
// canBeKicked = "_-34-" (String#21658, DoABC#2)
// InfoStandUserView = "_-2s1" (String#451, DoABC#2)
// InfoStandUserView = "_-P4" (String#461, DoABC#2)


