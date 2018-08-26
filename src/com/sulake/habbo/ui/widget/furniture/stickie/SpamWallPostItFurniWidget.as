
package com.sulake.habbo.ui.widget.furniture.stickie
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.ui.widget.events.RoomWidgetSpamWallPostItEditEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.ui.widget.events.RoomWidgetStickieDataUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetSpamWallPostItFinishEditingMessage;

    public class SpamWallPostItFurniWidget extends StickieFurniWidget 
    {

        private var _location:String = "";

        public function SpamWallPostItFurniWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary=null)
        {
            _SafeStr_5170 = "spamwall_postit_container";
            super(_arg_1, _arg_2, _arg_3);
        }
        override public function dispose():void
        {
            _objectId = -1;
            this._location = "";
            super.dispose();
        }
        override public function RoomChatWidget(_arg_1:IEventDispatcher):void
        {
            _arg_1.addEventListener(RoomWidgetSpamWallPostItEditEvent.RWSWPUE_OPEN_EDITOR, this.onEditPostItRequest);
            super.RoomChatWidget(_arg_1);
        }
        override public function RoomChatWidget(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.removeEventListener(RoomWidgetSpamWallPostItEditEvent.RWSWPUE_OPEN_EDITOR, this.onEditPostItRequest);
        }
        override protected function onObjectUpdate(_arg_1:RoomWidgetStickieDataUpdateEvent):void
        {
        }
        private function onEditPostItRequest(_arg_1:RoomWidgetSpamWallPostItEditEvent):void
        {
            hideInterface(false);
            _objectId = _arg_1.objectId;
            this._location = _arg_1.location;
            _objectType = _arg_1.objectType;
            _text = "";
            _colorHex = "FFFF33";
            _controller = true;
            showInterface();
        }
        override protected function sendUpdate():void
        {
            var _local_1:RoomWidgetSpamWallPostItFinishEditingMessage;
            if (_objectId != -1){
                StickieFurniWidget();
                Logger.log("Spamwall Post-It Widget Send Update");
                if (messageListener != null){
                    _local_1 = new RoomWidgetSpamWallPostItFinishEditingMessage(RoomWidgetSpamWallPostItFinishEditingMessage.RWSWPFEE_SEND_POSTIT_DATA, _objectId, this._location, _text, _colorHex);
                    messageListener.processWidgetMessage(_local_1);
                };
                hideInterface(false);
            };
        }
        override protected function sendSetColor(_arg_1:uint):void
        {
            StickieFurniWidget();
            var _local_2:String = _arg_1.toString(16).toUpperCase();
            if (_local_2.length > 6){
                _local_2 = _local_2.slice((_local_2.length - 6), _local_2.length);
            };
            if (_local_2 == _colorHex){
                return;
            };
            _colorHex = _local_2;
            showInterface();
        }
        override protected function sendDelete():void
        {
            hideInterface(false);
        }

    }
}//package com.sulake.habbo.ui.widget.furniture.stickie

// StickieFurniWidget = "_-2ud" (String#7171, DoABC#2)
// SpamWallPostItFurniWidget = "_-x1" (String#8825, DoABC#2)
// RoomWidgetStickieDataUpdateEvent = "_-1X9" (String#5500, DoABC#2)
// RoomWidgetSpamWallPostItFinishEditingMessage = "_-zJ" (String#24665, DoABC#2)
// RoomWidgetSpamWallPostItEditEvent = "_-0n1" (String#15941, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// _colorHex = "_-0io" (String#821, DoABC#2)
// RWSWPFEE_SEND_POSTIT_DATA = "_-35M" (String#21708, DoABC#2)
// _location = "_-245" (String#244, DoABC#2)
// _controller = "_-18D" (String#59, DoABC#2)
// hideInterface = "_-29" (String#304, DoABC#2)
// RoomChatWidget = "_-1yD" (String#1787, DoABC#2)
// onObjectUpdate = "_-2l-" (String#248, DoABC#2)
// RoomChatWidget = "_-0-c" (String#3556, DoABC#2)
// showInterface = "_-121" (String#162, DoABC#2)
// _objectType = "_-eP" (String#939, DoABC#2)
// _SafeStr_5170 = "_-6r" (String#22493, DoABC#2)
// objectType = "_-23O" (String#19148, DoABC#2)
// sendUpdate = "_-iA" (String#8556, DoABC#2)
// StickieFurniWidget = "_-24P" (String#19195, DoABC#2)
// sendSetColor = "_-0lK" (String#4530, DoABC#2)
// sendDelete = "_-13W" (String#4943, DoABC#2)
// RWSWPUE_OPEN_EDITOR = "_-1kX" (String#18309, DoABC#2)
// onEditPostItRequest = "_-0Q6" (String#15065, DoABC#2)


