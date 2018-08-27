
package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomQueueMessage;
    import com.sulake.habbo.session.events.RoomSessionQueueEvent;
    import com.sulake.habbo.catalog.enum.CatalogPageName;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomQueueUpdateEvent;
    import flash.events.Event;

    public class RoomQueueWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get type():String
        {
            return (RoomWidgetEnum.RWE_CHAT_WIDGET);
        }
        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            this._container = _arg_1;
        }
        public function dispose():void
        {
            this._disposed = true;
            this._container = null;
        }
        public function getWidgetMessages():Array
        {
            var _local_1:Array = [];
            _local_1.push(RoomWidgetRoomQueueMessage.RWRQM_EXIT_QUEUE);
            _local_1.push(RoomWidgetRoomQueueMessage.CHANGE_TO_SPECTATOR_QUEUE);
            _local_1.push(RoomWidgetRoomQueueMessage.RWRQM_CHANGE_TO_VISITOR_QUEUE);
            _local_1.push(RoomWidgetRoomQueueMessage.RWRQM_CLUB_LINK);
            return (_local_1);
        }
        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            if ((((this._container == null)) || ((this._container.roomSession == null)))){
                return (null);
            };
            var _local_2:RoomWidgetRoomQueueMessage = (_arg_1 as RoomWidgetRoomQueueMessage);
            if (_local_2 == null){
                return (null);
            };
            switch (_arg_1.type){
                case RoomWidgetRoomQueueMessage.RWRQM_EXIT_QUEUE:
                    this._container.roomSession.quit();
                    break;
                case RoomWidgetRoomQueueMessage.CHANGE_TO_SPECTATOR_QUEUE:
                    this._container.roomSession.changeQueue(RoomSessionQueueEvent._SafeStr_4778);
                    break;
                case RoomWidgetRoomQueueMessage.RWRQM_CHANGE_TO_VISITOR_QUEUE:
                    this._container.roomSession.changeQueue(RoomSessionQueueEvent._SafeStr_4777);
                    break;
                case RoomWidgetRoomQueueMessage.RWRQM_CLUB_LINK:
                    if (this._container.catalog != null){
                        this._container.catalog.openCatalogPage(CatalogPageName._SafeStr_5382, true);
                    };
                    break;
            };
            return (null);
        }
        public function getProcessedEvents():Array
        {
            return ([RoomSessionQueueEvent.RSQE_QUEUE_STATUS]);
        }
        public function processEvent(_arg_1:Event):void
        {
            var _local_2:RoomSessionQueueEvent;
            var _local_3:String;
            var _local_4:Boolean;
            var _local_5:Array;
            var _local_6:int;
            var _local_7:Boolean;
            var _local_8:RoomWidgetRoomQueueUpdateEvent;
            if ((((this._container == null)) || ((this._container.events == null)))){
                return;
            };
            switch (_arg_1.type){
                case RoomSessionQueueEvent.RSQE_QUEUE_STATUS:
                    _local_2 = (_arg_1 as RoomSessionQueueEvent);
                    if (_local_2 == null){
                        return;
                    };
                    switch (_local_2.queueSetTarget){
                        case RoomSessionQueueEvent._SafeStr_4777:
                            _local_3 = RoomWidgetRoomQueueUpdateEvent.RWRQUE_VISITOR_QUEUE_STATUS;
                            break;
                        case RoomSessionQueueEvent._SafeStr_4778:
                            _local_3 = RoomWidgetRoomQueueUpdateEvent.RWRQUE_SPECTATOR_QUEUE_STATUS;
                            break;
                    };
                    if (_local_3 == null){
                        return;
                    };
                    _local_4 = true;
                    if (this._container.inventory != null){
                        _local_4 = (this._container.inventory.clubDays > 0);
                    };
                    _local_5 = _local_2.queueTypes;
                    _local_7 = false;
                    if (_local_5.length > 1){
                        if (((_local_4) && (!((_local_2.queueTypes.indexOf(RoomSessionQueueEvent._SafeStr_4775) == -1))))){
                            _local_6 = (_local_2.getQueueSize(RoomSessionQueueEvent._SafeStr_4775) + 1);
                            _local_7 = true;
                        }
                        else {
                            _local_6 = (_local_2.getQueueSize(RoomSessionQueueEvent._SafeStr_4776) + 1);
                        };
                    }
                    else {
                        _local_6 = (_local_2.getQueueSize(_local_5[0]) + 1);
                    };
                    _local_8 = new RoomWidgetRoomQueueUpdateEvent(_local_3, _local_6, _local_4, _local_2.isActive, _local_7);
                    this._container.events.dispatchEvent(_local_8);
                    return;
            };
        }
        public function update():void
        {
        }

    }
}//package com.sulake.habbo.ui.handler

// CatalogPageName = "_-mv" (String#24149, DoABC#2)
// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomSessionQueueEvent = "_-0n4" (String#4569, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomQueueWidgetHandler = "_-1bF" (String#17945, DoABC#2)
// RoomWidgetRoomQueueUpdateEvent = "_-0Dx" (String#3826, DoABC#2)
// RoomWidgetRoomQueueMessage = "_-0RV" (String#4123, DoABC#2)
// RWRQM_EXIT_QUEUE = "_-7I" (String#22514, DoABC#2)
// RWRQM_CHANGE_TO_VISITOR_QUEUE = "_-KU" (String#23024, DoABC#2)
// RWRQM_CLUB_LINK = "_-1j3" (String#18248, DoABC#2)
// isActive = "_-0q4" (String#4638, DoABC#2)
// RWE_CHAT_WIDGET = "_-2dZ" (String#20586, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// RSQE_QUEUE_STATUS = "_-0JP" (String#14818, DoABC#2)
// _SafeStr_4775 = "_-2sn" (String#21191, DoABC#2)
// _SafeStr_4776 = "_-1pn" (String#18535, DoABC#2)
// _SafeStr_4777 = "_-0DD" (String#14577, DoABC#2)
// _SafeStr_4778 = "_-06D" (String#14293, DoABC#2)
// queueSetTarget = "_-O2" (String#23170, DoABC#2)
// queueTypes = "_-1Hm" (String#17182, DoABC#2)
// getQueueSize = "_-2ar" (String#20482, DoABC#2)
// _SafeStr_5382 = "_-lc" (String#24094, DoABC#2)
// roomSession = "_-0cq" (String#4363, DoABC#2)
// RWRQUE_VISITOR_QUEUE_STATUS = "_-mB" (String#24117, DoABC#2)
// RWRQUE_SPECTATOR_QUEUE_STATUS = "_-UO" (String#23426, DoABC#2)
// changeQueue = "_-2Ye" (String#1898, DoABC#2)
// getWidgetMessages = "_-1dr" (String#5626, DoABC#2)
// getProcessedEvents = "_-0gb" (String#4436, DoABC#2)
// processEvent = "_-xT" (String#2223, DoABC#2)
// quit = "_-3A4" (String#7513, DoABC#2)


