
package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.WelcomeGiftStatusEvent;
    import com.sulake.habbo.communication.messages.incoming.users.ChangeEmailResultEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.WelcomeGiftStatusParser;
    import com.sulake.habbo.ui.widget.events.RoomWidgetWelcomeGiftUpdateEvent;
    import com.sulake.habbo.communication.messages.parser.users.ChangeEmailResultParser;
    import com.sulake.habbo.ui.widget.events.RoomWidgetChangeEmailResultEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniActionMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetChangeEmailMessage;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.OpenWelcomeGiftComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.ChangeEmailComposer;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import flash.events.Event;

    public class WelcomeGiftWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;
        private var _WelcomeGiftWidgetHandler:Array;

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            if (!this._disposed){
                this.WelcomeGiftWidgetHandler();
                this._container = null;
                this._disposed = true;
            };
        }
        public function get type():String
        {
            return (RoomWidgetEnum.RWE_WELCOME_GIFT);
        }
        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            this._container = _arg_1;
            this.WelcomeGiftWidgetHandler();
        }
        private function WelcomeGiftWidgetHandler():void
        {
            var _local_1:IMessageEvent;
            if (((!(this._container)) || (!(this._container.connection)))){
                return;
            };
            this._WelcomeGiftWidgetHandler = [];
            this._WelcomeGiftWidgetHandler.push(new WelcomeGiftStatusEvent(this.onWelcomeGiftStatus));
            this._WelcomeGiftWidgetHandler.push(new ChangeEmailResultEvent(this.onChangeEmailResult));
            for each (_local_1 in this._WelcomeGiftWidgetHandler) {
                this._container.connection.addMessageEvent(_local_1);
            };
        }
        private function WelcomeGiftWidgetHandler():void
        {
            var _local_1:IMessageEvent;
            if (((((!(this._container)) || (!(this._container.connection)))) || (!(this._WelcomeGiftWidgetHandler)))){
                return;
            };
            for each (_local_1 in this._WelcomeGiftWidgetHandler) {
                this._container.connection.SocketConnection(_local_1);
                _local_1.dispose();
            };
            this._WelcomeGiftWidgetHandler = null;
        }
        private function onWelcomeGiftStatus(_arg_1:WelcomeGiftStatusEvent):void
        {
            var _local_2:WelcomeGiftStatusParser = _arg_1.getParser();
            var _local_3:RoomWidgetWelcomeGiftUpdateEvent = new RoomWidgetWelcomeGiftUpdateEvent();
            _local_3.email = _local_2.email;
            _local_3.isVerified = _local_2.isVerified;
            _local_3.allowEmailChange = _local_2.allowChange;
            _local_3.furniId = _local_2.furniId;
            _local_3.requestedByUser = _local_2.requestedByUser;
            this._container.events.dispatchEvent(_local_3);
        }
        private function onChangeEmailResult(_arg_1:ChangeEmailResultEvent):void
        {
            var _local_2:ChangeEmailResultParser = _arg_1.getParser();
            this._container.events.dispatchEvent(new RoomWidgetChangeEmailResultEvent(_local_2.result));
        }
        public function IRoomWidgetHandler():Array
        {
            var _local_1:Array = [];
            _local_1.push(RoomWidgetFurniActionMessage.RWFAM_OPEN_WELCOME_GIFT);
            _local_1.push(RoomWidgetChangeEmailMessage._SafeStr_3493);
            return (_local_1);
        }
        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_2:RoomWidgetFurniActionMessage;
            var _local_3:RoomWidgetChangeEmailMessage;
            if (!_arg_1){
                return (null);
            };
            switch (_arg_1.type){
                case RoomWidgetFurniActionMessage.RWFAM_OPEN_WELCOME_GIFT:
                    _local_2 = (_arg_1 as RoomWidgetFurniActionMessage);
                    this._container.connection.send(new OpenWelcomeGiftComposer(_local_2.furniId));
                    break;
                case RoomWidgetChangeEmailMessage._SafeStr_3493:
                    _local_3 = (_arg_1 as RoomWidgetChangeEmailMessage);
                    this._container.connection.send(new ChangeEmailComposer(_local_3.newEmail));
                    break;
            };
            return (null);
        }
        public function IRoomWidgetHandler():Array
        {
            return ([]);
        }
        public function IRoomWidgetHandler(_arg_1:Event):void
        {
        }
        public function update():void
        {
        }

    }
}//package com.sulake.habbo.ui.handler

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// OpenWelcomeGiftComposer = "_-8F" (String#22551, DoABC#2)
// WelcomeGiftStatusEvent = "_-gn" (String#23923, DoABC#2)
// ChangeEmailResultEvent = "_-1v9" (String#18763, DoABC#2)
// ChangeEmailComposer = "_-CY" (String#22707, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// WelcomeGiftWidgetHandler = "_-cY" (String#23734, DoABC#2)
// RoomWidgetWelcomeGiftUpdateEvent = "_-1ad" (String#5570, DoABC#2)
// RoomWidgetFurniActionMessage = "_-02g" (String#3622, DoABC#2)
// RoomWidgetChangeEmailMessage = "_-2iU" (String#6920, DoABC#2)
// RoomWidgetChangeEmailResultEvent = "_-1i2" (String#5710, DoABC#2)
// ChangeEmailResultParser = "_-1nm" (String#5814, DoABC#2)
// furniId = "_-2KO" (String#6454, DoABC#2)
// RWFAM_OPEN_WELCOME_GIFT = "_-2ef" (String#20633, DoABC#2)
// _SafeStr_3493 = "_-1A8" (String#16863, DoABC#2)
// newEmail = "_-3EG" (String#22047, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// RWE_WELCOME_GIFT = "_-OF" (String#23177, DoABC#2)
// _WelcomeGiftWidgetHandler = "_-bQ" (String#938, DoABC#2)
// WelcomeGiftWidgetHandler = "_-9U" (String#22598, DoABC#2)
// WelcomeGiftWidgetHandler = "_-aI" (String#23644, DoABC#2)
// onWelcomeGiftStatus = "_-2nV" (String#20979, DoABC#2)
// onChangeEmailResult = "_-1Nu" (String#17431, DoABC#2)
// SocketConnection = "_-0vh" (String#4760, DoABC#2)
// isVerified = "_-0hd" (String#15732, DoABC#2)
// allowEmailChange = "_-FE" (String#22823, DoABC#2)
// allowChange = "_-2Ma" (String#19910, DoABC#2)
// requestedByUser = "_-1cw" (String#18009, DoABC#2)
// IRoomWidgetHandler = "_-1dr" (String#5626, DoABC#2)
// IRoomWidgetHandler = "_-0gb" (String#4436, DoABC#2)
// IRoomWidgetHandler = "_-xT" (String#2223, DoABC#2)


