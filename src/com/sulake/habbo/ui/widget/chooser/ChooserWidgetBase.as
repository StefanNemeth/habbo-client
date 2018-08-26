
package com.sulake.habbo.ui.widget.chooser
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;

    public class ChooserWidgetBase extends RoomWidgetBase 
    {

        public function ChooserWidgetBase(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary=null, _arg_4:IHabboLocalizationManager=null)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
        }
        public function choose(_arg_1:int, _arg_2:int):void
        {
            var _local_3:RoomWidgetRoomObjectMessage = new RoomWidgetRoomObjectMessage(RoomWidgetRoomObjectMessage.RWROM_SELECT_OBJECT, _arg_1, _arg_2);
            messageListener.processWidgetMessage(_local_3);
        }

    }
}//package com.sulake.habbo.ui.widget.chooser

// RoomWidgetBase = "_-0eQ" (String#4398, DoABC#2)
// ChooserWidgetBase = "_-1UM" (String#5439, DoABC#2)
// RWROM_SELECT_OBJECT = "_-1RI" (String#17557, DoABC#2)
// choose = "_-14o" (String#16647, DoABC#2)


