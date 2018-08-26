
package com.sulake.habbo.ui.widget.roomqueue
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomQueueUpdateEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomQueueMessage;

    public class RoomQueueWidget extends RoomWidgetBase 
    {

        private var _window:IFrameWindow;
        private var _config:IHabboConfigurationManager;
        private var _SafeStr_7082:int;
        private var _SafeStr_7083:Boolean;
        private var _activeTarget:String;
        private var _SafeStr_7085:Boolean;
        private var _isClubQueue:Boolean;

        public function RoomQueueWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager, _arg_5:IHabboConfigurationManager)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            this._config = _arg_5;
        }
        override public function dispose():void
        {
            this.removeWindow();
            this._config = null;
            super.dispose();
        }
        override public function RoomChatWidget(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.addEventListener(RoomWidgetRoomQueueUpdateEvent.RWRQUE_VISITOR_QUEUE_STATUS, this.onQueueStatus);
            _arg_1.addEventListener(RoomWidgetRoomQueueUpdateEvent.RWRQUE_SPECTATOR_QUEUE_STATUS, this.onQueueStatus);
            super.RoomChatWidget(_arg_1);
        }
        override public function RoomChatWidget(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.removeEventListener(RoomWidgetRoomQueueUpdateEvent.RWRQUE_VISITOR_QUEUE_STATUS, this.onQueueStatus);
            _arg_1.removeEventListener(RoomWidgetRoomQueueUpdateEvent.RWRQUE_SPECTATOR_QUEUE_STATUS, this.onQueueStatus);
        }
        private function removeWindow():void
        {
            if (this._window != null){
                this._window.dispose();
                this._window = null;
            };
        }
        private function onQueueStatus(_arg_1:RoomWidgetRoomQueueUpdateEvent):void
        {
            if (_arg_1 == null){
                return;
            };
            if (_arg_1.isActive){
                this._activeTarget = _arg_1.type;
                this._SafeStr_7085 = false;
                this._SafeStr_7082 = _arg_1.position;
            }
            else {
                this._SafeStr_7085 = true;
            };
            this._SafeStr_7083 = _arg_1.hasHabboClub;
            this._isClubQueue = _arg_1.isClubQueue;
            localizations.registerParameter("room.queue.position", "position", this._SafeStr_7082.toString());
            localizations.registerParameter("room.queue.position.hc", "position", this._SafeStr_7082.toString());
            localizations.registerParameter("room.queue.spectator.position", "position", this._SafeStr_7082.toString());
            localizations.registerParameter("room.queue.spectator.position.hc", "position", this._SafeStr_7082.toString());
            this.showInterface();
        }
        private function createWindow():Boolean
        {
            if (this._window != null){
                return (true);
            };
            var _local_1:XmlAsset = (assets.getAssetByName("room_queue") as XmlAsset);
            this._window = (windowManager.buildFromXML((_local_1.content as XML)) as IFrameWindow);
            if (this._window == null){
                return (false);
            };
            this._window.visible = false;
            var _local_2:IWindow = this._window.findChildByTag("close");
            if (_local_2 != null){
                _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.exitQueue);
            };
            _local_2 = this._window.findChildByName("cancel_button");
            if (_local_2 != null){
                _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.exitQueue);
            };
            _local_2 = this._window.findChildByName("link_text");
            if (_local_2 != null){
                _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.openLink);
            };
            _local_2 = this._window.findChildByName("change_button");
            if (_local_2 != null){
                _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.RoomSession);
            };
            this._window.center();
            return (true);
        }
        private function showInterface():void
        {
            if (!this.createWindow()){
                return;
            };
            var _local_1:ITextWindow = (this._window.findChildByName("info_text") as ITextWindow);
            var _local_2:IButtonWindow = (this._window.findChildByName("change_button") as IButtonWindow);
            var _local_3:IWindow = this._window.findChildByName("spectator_info");
            if (((((!((_local_1 == null))) && (!((_local_2 == null))))) && (!((_local_3 == null))))){
                switch (this._activeTarget){
                    case RoomWidgetRoomQueueUpdateEvent.RWRQUE_VISITOR_QUEUE_STATUS:
                        _local_1.caption = ((this._isClubQueue) ? "${room.queue.position.hc}" : "${room.queue.position}");
                        _local_2.caption = "${room.queue.spectatormode}";
                        _local_3.visible = this._SafeStr_7085;
                        break;
                    case RoomWidgetRoomQueueUpdateEvent.RWRQUE_SPECTATOR_QUEUE_STATUS:
                        _local_1.caption = ((this._isClubQueue) ? "${room.queue.spectator.position.hc}" : "${room.queue.spectator.position}");
                        _local_2.caption = "${room.queue.back}";
                        _local_3.visible = false;
                        break;
                };
                _local_2.visible = this._SafeStr_7085;
            };
            var _local_4:IWindowContainer = (this._window.findChildByName("club_container") as IWindowContainer);
            if (_local_4 != null){
                _local_4.visible = !(this._SafeStr_7083);
            };
            this._window.visible = true;
        }
        private function exitQueue(_arg_1:WindowMouseEvent):void
        {
            if (messageListener == null){
                return;
            };
            var _local_2:RoomWidgetRoomQueueMessage = new RoomWidgetRoomQueueMessage(RoomWidgetRoomQueueMessage.RWRQM_EXIT_QUEUE);
            messageListener.processWidgetMessage(_local_2);
            this.removeWindow();
        }
        private function openLink(_arg_1:WindowMouseEvent):void
        {
            messageListener.processWidgetMessage(new RoomWidgetRoomQueueMessage(RoomWidgetRoomQueueMessage.RWRQM_CLUB_LINK));
        }
        private function RoomSession(_arg_1:WindowMouseEvent):void
        {
            var _local_2:RoomWidgetRoomQueueMessage;
            if (messageListener == null){
                return;
            };
            if (this._activeTarget == RoomWidgetRoomQueueUpdateEvent.RWRQUE_VISITOR_QUEUE_STATUS){
                _local_2 = new RoomWidgetRoomQueueMessage(RoomWidgetRoomQueueMessage.CHANGE_TO_SPECTATOR_QUEUE);
            }
            else {
                _local_2 = new RoomWidgetRoomQueueMessage(RoomWidgetRoomQueueMessage.RWRQM_CHANGE_TO_VISITOR_QUEUE);
            };
            messageListener.processWidgetMessage(_local_2);
            this.removeWindow();
        }

    }
}//package com.sulake.habbo.ui.widget.roomqueue

// RoomWidgetBase = "_-0eQ" (String#4398, DoABC#2)
// RoomQueueWidget = "_-09m" (String#3754, DoABC#2)
// RoomWidgetRoomQueueUpdateEvent = "_-0Dx" (String#3826, DoABC#2)
// RoomWidgetRoomQueueMessage = "_-0RV" (String#4123, DoABC#2)
// RWRQM_EXIT_QUEUE = "_-7I" (String#22514, DoABC#2)
// RWRQM_CHANGE_TO_VISITOR_QUEUE = "_-KU" (String#23024, DoABC#2)
// RWRQM_CLUB_LINK = "_-1j3" (String#18248, DoABC#2)
// RoomChatWidget = "_-1yD" (String#1787, DoABC#2)
// RoomChatWidget = "_-0-c" (String#3556, DoABC#2)
// showInterface = "_-121" (String#162, DoABC#2)
// isActive = "_-0q4" (String#4638, DoABC#2)
// _SafeStr_7082 = "_-V2" (String#23450, DoABC#2)
// _SafeStr_7083 = "_-2mI" (String#20931, DoABC#2)
// _activeTarget = "_-0En" (String#3846, DoABC#2)
// _SafeStr_7085 = "_-zE" (String#24661, DoABC#2)
// _isClubQueue = "_-2vy" (String#7200, DoABC#2)
// removeWindow = "_-x0" (String#949, DoABC#2)
// RWRQUE_VISITOR_QUEUE_STATUS = "_-mB" (String#24117, DoABC#2)
// onQueueStatus = "_-0x-" (String#16312, DoABC#2)
// RWRQUE_SPECTATOR_QUEUE_STATUS = "_-UO" (String#23426, DoABC#2)
// hasHabboClub = "_-1pE" (String#18510, DoABC#2)
// isClubQueue = "_-Gv" (String#22888, DoABC#2)
// exitQueue = "_-Rg" (String#23310, DoABC#2)
// openLink = "_-304" (String#21504, DoABC#2)
// RoomSession = "_-2Ye" (String#1898, DoABC#2)


