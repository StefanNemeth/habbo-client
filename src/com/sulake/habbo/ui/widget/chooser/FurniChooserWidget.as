
package com.sulake.habbo.ui.widget.chooser
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.widget.events.RoomWidgetChooserContentEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;

    public class FurniChooserWidget extends ChooserWidgetBase 
    {

        private var _SafeStr_6592:ChooserView;

        public function FurniChooserWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary=null, _arg_4:IHabboLocalizationManager=null)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
        }
        override public function dispose():void
        {
            if (this._SafeStr_6592 != null){
                this._SafeStr_6592.dispose();
                this._SafeStr_6592 = null;
            };
            super.dispose();
        }
        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.addEventListener(RoomWidgetChooserContentEvent.RWCCE_FURNI_CHOOSER_CONTENT, this.onChooserContent);
            _arg_1.addEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_FURNI_REMOVED, this.onUpdateFurniChooser);
            _arg_1.addEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_FURNI_ADDED, this.onUpdateFurniChooser);
            super.registerUpdateEvents(_arg_1);
        }
        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.removeEventListener(RoomWidgetChooserContentEvent.RWCCE_FURNI_CHOOSER_CONTENT, this.onChooserContent);
            _arg_1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_FURNI_REMOVED, this.onUpdateFurniChooser);
            _arg_1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_FURNI_ADDED, this.onUpdateFurniChooser);
        }
        private function onChooserContent(_arg_1:RoomWidgetChooserContentEvent):void
        {
            if ((((_arg_1 == null)) || ((_arg_1.items == null)))){
                return;
            };
            if (this._SafeStr_6592 == null){
                this._SafeStr_6592 = new ChooserView(this, "${widget.chooser.furni.title}");
            };
            this._SafeStr_6592.populate(_arg_1.items, _arg_1.isAnyRoomController);
        }
        private function onUpdateFurniChooser(_arg_1:RoomWidgetRoomObjectUpdateEvent):void
        {
            if ((((this._SafeStr_6592 == null)) || (!(this._SafeStr_6592.isOpen())))){
                return;
            };
            var _local_2:RoomWidgetRequestWidgetMessage = new RoomWidgetRequestWidgetMessage(RoomWidgetRequestWidgetMessage.RWRWM_FURNI_CHOOSER);
            messageListener.processWidgetMessage(_local_2);
        }

    }
}//package com.sulake.habbo.ui.widget.chooser

// ChooserWidgetBase = "_-1UM" (String#5439, DoABC#2)
// FurniChooserWidget = "_-0WS" (String#4236, DoABC#2)
// RoomWidgetRoomObjectUpdateEvent = "_-37T" (String#7457, DoABC#2)
// RoomWidgetChooserContentEvent = "_-12l" (String#16570, DoABC#2)
// RoomWidgetRequestWidgetMessage = "_-XQ" (String#8356, DoABC#2)
// ChooserView = "_-2b-" (String#6772, DoABC#2)
// RWRWM_FURNI_CHOOSER = "_-0pQ" (String#16032, DoABC#2)
// registerUpdateEvents = "_-1yD" (String#1787, DoABC#2)
// RWROUE_FURNI_REMOVED = "_-2L6" (String#19851, DoABC#2)
// unregisterUpdateEvents = "_-0-c" (String#3556, DoABC#2)
// isOpen = "_-2i4" (String#897, DoABC#2)
// _SafeStr_6592 = "_-11H" (String#16508, DoABC#2)
// RWCCE_FURNI_CHOOSER_CONTENT = "_-2tc" (String#21225, DoABC#2)
// onChooserContent = "_-2U6" (String#6648, DoABC#2)
// onUpdateFurniChooser = "_-3FU" (String#22098, DoABC#2)
// RWROUE_FURNI_ADDED = "_-2ER" (String#19583, DoABC#2)
// isAnyRoomController = "_-2IH" (String#6407, DoABC#2)


