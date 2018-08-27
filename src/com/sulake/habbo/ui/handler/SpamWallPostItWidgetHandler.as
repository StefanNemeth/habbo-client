
package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.RequestSpamWallPostItMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.RequestSpamWallPostItMessageParser;
    import com.sulake.habbo.inventory.items.IItem;
    import com.sulake.habbo.inventory.enum.FurniModelCategory;
    import com.sulake.habbo.ui.widget.events.RoomWidgetSpamWallPostItEditEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetSpamWallPostItFinishEditingMessage;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.AddSpamWallPostItMessageComposer;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import flash.events.Event;

    public class SpamWallPostItWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer;
        private var _connection:IConnection = null;
        private var _SafeStr_7375:IMessageEvent;

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get type():String
        {
            return (RoomWidgetEnum.RWE_SPAMWALL_POSTIT_WIDGET);
        }
        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            this._container = _arg_1;
        }
        public function set connection(_arg_1:IConnection):void
        {
            this._SafeStr_7375 = new RequestSpamWallPostItMessageEvent(this.onSpamWallPostItRequest);
            this._connection = _arg_1;
            this._connection.addMessageEvent(this._SafeStr_7375);
        }
        public function dispose():void
        {
            if (!this._disposed){
                this._disposed = true;
                this._connection.removeMessageEvent(this._SafeStr_7375);
                this._connection = null;
            };
        }
        private function onSpamWallPostItRequest(_arg_1:RequestSpamWallPostItMessageEvent):void
        {
            var _local_7:String;
            if (_arg_1 == null){
                return;
            };
            var _local_2:RequestSpamWallPostItMessageParser = _arg_1.getParser();
            var _local_3:int = _local_2.itemId;
            var _local_4:String = _local_2.location;
            var _local_5:String = "post_it";
            var _local_6:IItem;
            if (this._container.inventory != null){
                _local_6 = this._container.inventory.getItemById(FurniModelCategory.I, _local_3);
            };
            if (((!((_local_6 == null))) && (!((this._container.roomEngine == null))))){
                _local_7 = this._container.roomEngine.getWallItemType(_local_6.type);
                _local_5 = ((_local_7.match("vd")) ? "post_it_vd" : "post_it");
            };
            if (this._container != null){
                if (this._container.events != null){
                    this._container.events.dispatchEvent(new RoomWidgetSpamWallPostItEditEvent(RoomWidgetSpamWallPostItEditEvent.RWSWPUE_OPEN_EDITOR, _local_3, _local_4, _local_5));
                };
            };
        }
        public function getWidgetMessages():Array
        {
            return ([RoomWidgetSpamWallPostItEditEvent.RWSWPUE_OPEN_EDITOR, RoomWidgetSpamWallPostItFinishEditingMessage.RWSWPFEE_SEND_POSTIT_DATA]);
        }
        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_2:RoomWidgetSpamWallPostItFinishEditingMessage;
            var _local_3:AddSpamWallPostItMessageComposer;
            switch (_arg_1.type){
                case RoomWidgetSpamWallPostItFinishEditingMessage.RWSWPFEE_SEND_POSTIT_DATA:
                    _local_2 = (_arg_1 as RoomWidgetSpamWallPostItFinishEditingMessage);
                    if (_local_2 != null){
                        if (this._connection != null){
                            _local_3 = new AddSpamWallPostItMessageComposer(_local_2.objectId, _local_2.location, ((_local_2.colorHex + " ") + _local_2.text));
                            this._connection.send(_local_3);
                        };
                    };
                    break;
            };
            return (null);
        }
        public function getProcessedEvents():Array
        {
            return ([]);
        }
        public function processEvent(_arg_1:Event):void
        {
        }
        public function update():void
        {
        }

    }
}//package com.sulake.habbo.ui.handler

// IItem = "_-1-k" (String#4863, DoABC#2)
// FurniModelCategory = "_-1a8" (String#5563, DoABC#2)
// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// AddSpamWallPostItMessageComposer = "_-0aU" (String#15454, DoABC#2)
// RequestSpamWallPostItMessageEvent = "_-1v-" (String#18755, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// SpamWallPostItWidgetHandler = "_-2z5" (String#7266, DoABC#2)
// RoomWidgetSpamWallPostItFinishEditingMessage = "_-zJ" (String#24665, DoABC#2)
// RoomWidgetSpamWallPostItEditEvent = "_-0n1" (String#15941, DoABC#2)
// RequestSpamWallPostItMessageParser = "_-0QR" (String#4101, DoABC#2)
// colorHex = "_-3I3" (String#22203, DoABC#2)
// RWSWPFEE_SEND_POSTIT_DATA = "_-35M" (String#21708, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// RWE_SPAMWALL_POSTIT_WIDGET = "_-SH" (String#23335, DoABC#2)
// RWSWPUE_OPEN_EDITOR = "_-1kX" (String#18309, DoABC#2)
// I = "_-3-D" (String#21470, DoABC#2)
// removeMessageEvent = "_-0vh" (String#4760, DoABC#2)
// getWidgetMessages = "_-1dr" (String#5626, DoABC#2)
// getProcessedEvents = "_-0gb" (String#4436, DoABC#2)
// processEvent = "_-xT" (String#2223, DoABC#2)
// _SafeStr_7375 = "_-Na" (String#23149, DoABC#2)
// onSpamWallPostItRequest = "_-3Dp" (String#22027, DoABC#2)
// getItemById = "_-Ap" (String#7883, DoABC#2)
// getWallItemType = "_-0BC" (String#3783, DoABC#2)


