
package com.sulake.habbo.ui.widget.chooser
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetChooserContentEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
    import flash.events.IEventDispatcher;

    public class UserChooserWidget extends ChooserWidgetBase 
    {

        private const _SafeStr_6598:int = 0;
        private const _state:int = 1;

        private var _SafeStr_6600:ChooserView;

        public function UserChooserWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary=null, _arg_4:IHabboLocalizationManager=null)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
        }
        override public function get state():int
        {
            if (((!((this._SafeStr_6600 == null))) && (this._SafeStr_6600.isOpen()))){
                return (this._state);
            };
            return (this._SafeStr_6598);
        }
        override public function initialize(_arg_1:int=0):void
        {
            var _local_2:RoomWidgetRequestWidgetMessage;
            super.initialize(_arg_1);
            if (_arg_1 == this._state){
                _local_2 = new RoomWidgetRequestWidgetMessage(RoomWidgetRequestWidgetMessage.RWRWM_USER_CHOOSER);
                messageListener.processWidgetMessage(_local_2);
            };
        }
        override public function dispose():void
        {
            if (this._SafeStr_6600 != null){
                this._SafeStr_6600.dispose();
                this._SafeStr_6600 = null;
            };
            super.dispose();
        }
        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.addEventListener(RoomWidgetChooserContentEvent.RWCCE_USER_CHOOSER_CONTENT, this.onChooserContent);
            _arg_1.addEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_USER_REMOVED, this.onUpdateUserChooser);
            _arg_1.addEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_USER_ADDED, this.onUpdateUserChooser);
            super.registerUpdateEvents(_arg_1);
        }
        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.removeEventListener(RoomWidgetChooserContentEvent.RWCCE_USER_CHOOSER_CONTENT, this.onChooserContent);
            _arg_1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_USER_REMOVED, this.onUpdateUserChooser);
            _arg_1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_USER_ADDED, this.onUpdateUserChooser);
        }
        private function onChooserContent(_arg_1:RoomWidgetChooserContentEvent):void
        {
            if ((((_arg_1 == null)) || ((_arg_1.items == null)))){
                return;
            };
            if (this._SafeStr_6600 == null){
                this._SafeStr_6600 = new ChooserView(this, "${widget.chooser.user.title}");
            };
            this._SafeStr_6600.populate(_arg_1.items, false);
        }
        private function onUpdateUserChooser(_arg_1:RoomWidgetRoomObjectUpdateEvent):void
        {
            if ((((this._SafeStr_6600 == null)) || (!(this._SafeStr_6600.isOpen())))){
                return;
            };
            var _local_2:RoomWidgetRequestWidgetMessage = new RoomWidgetRequestWidgetMessage(RoomWidgetRequestWidgetMessage.RWRWM_USER_CHOOSER);
            messageListener.processWidgetMessage(_local_2);
        }

    }
}//package com.sulake.habbo.ui.widget.chooser

// ChooserWidgetBase = "_-1UM" (String#5439, DoABC#2)
// UserChooserWidget = "_-2hs" (String#6903, DoABC#2)
// RoomWidgetRoomObjectUpdateEvent = "_-37T" (String#7457, DoABC#2)
// RoomWidgetChooserContentEvent = "_-12l" (String#16570, DoABC#2)
// RoomWidgetRequestWidgetMessage = "_-XQ" (String#8356, DoABC#2)
// ChooserView = "_-2b-" (String#6772, DoABC#2)
// RWRWM_USER_CHOOSER = "_-3HZ" (String#22183, DoABC#2)
// registerUpdateEvents = "_-1yD" (String#1787, DoABC#2)
// unregisterUpdateEvents = "_-0-c" (String#3556, DoABC#2)
// isOpen = "_-2i4" (String#897, DoABC#2)
// onChooserContent = "_-2U6" (String#6648, DoABC#2)
// _SafeStr_6598 = "_-0Q9" (String#15068, DoABC#2)
// _state = "_-3Cf" (String#21981, DoABC#2)
// _SafeStr_6600 = "_-2mR" (String#20937, DoABC#2)
// RWCCE_USER_CHOOSER_CONTENT = "_-2YV" (String#20377, DoABC#2)
// RWROUE_USER_REMOVED = "_-02u" (String#14156, DoABC#2)
// onUpdateUserChooser = "_-26y" (String#19291, DoABC#2)
// RWROUE_USER_ADDED = "_-0wr" (String#16305, DoABC#2)


