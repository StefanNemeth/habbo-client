
package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetViralFurniMessage;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.ui.widget.events.RoomWidgetTeaserDataUpdateEvent;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionViralFurniStatusEvent;
    import flash.events.Event;

    public class FurnitureTeaserWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get type():String
        {
            return (RoomWidgetEnum.RWE_FURNI_TEASER_WIDGET);
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
        public function IRoomWidgetHandler():Array
        {
            return ([RoomWidgetFurniToWidgetMessage.RWFWM_MESSAGE_REQUEST_TEASER, RoomWidgetViralFurniMessage.RWVFM_VIRAL_FOUND, RoomWidgetViralFurniMessage.RWVFM_OPEN_PRESENT]);
        }
        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_2:RoomWidgetFurniToWidgetMessage;
            var _local_3:IRoomObject;
            var _local_4:RoomWidgetViralFurniMessage;
            var _local_5:IRoomObjectModel;
            var _local_6:String;
            var _local_7:RoomWidgetTeaserDataUpdateEvent;
            var _local_8:String;
            switch (_arg_1.type){
                case RoomWidgetFurniToWidgetMessage.RWFWM_MESSAGE_REQUEST_TEASER:
                    _local_2 = (_arg_1 as RoomWidgetFurniToWidgetMessage);
                    _local_3 = this._container.roomEngine.IRoomSpriteCanvasContainer(_local_2.roomId, _local_2.roomCategory, _local_2.id, _local_2.category);
                    if (_local_3 != null){
                        _local_5 = _local_3.getModel();
                        if (_local_5 != null){
                            _local_6 = _local_5.getString(RoomObjectVariableEnum._SafeStr_7217);
                            _local_7 = new RoomWidgetTeaserDataUpdateEvent(RoomWidgetTeaserDataUpdateEvent.RWTDUE_TEASER_DATA);
                            _local_8 = "+";
                            if (_local_6.indexOf(_local_8) > -1){
                                _local_7.data = _local_6.substring(0, _local_6.indexOf(_local_8));
                                _local_7.campaignID = _local_6.substring((_local_6.indexOf(_local_8) + 1), _local_6.length);
                            }
                            else {
                                _local_7.data = _local_6;
                                _local_7.campaignID = null;
                            };
                            this._container.events.dispatchEvent(_local_7);
                        };
                    };
                    break;
                case RoomWidgetViralFurniMessage.RWVFM_VIRAL_FOUND:
                    if (((!((this._container == null))) && (!((this._container.roomSession == null))))){
                        this._container.roomSession.RoomSession();
                    };
                    break;
                case RoomWidgetViralFurniMessage.RWVFM_OPEN_PRESENT:
                    _local_4 = (_arg_1 as RoomWidgetViralFurniMessage);
                    if (((!((this._container == null))) && (!((this._container.roomSession == null))))){
                        this._container.roomSession.RoomSession(_local_4.objectId);
                    };
                    break;
            };
            return (null);
        }
        public function IRoomWidgetHandler():Array
        {
            return ([RoomSessionViralFurniStatusEvent.RSVFS_STATUS, RoomSessionViralFurniStatusEvent.RSVFS_RECEIVED]);
        }
        public function IRoomWidgetHandler(_arg_1:Event):void
        {
            var _local_2:RoomSessionViralFurniStatusEvent;
            var _local_3:RoomWidgetTeaserDataUpdateEvent;
            if ((((this._container == null)) || ((this._container.events == null)))){
                return;
            };
            switch (_arg_1.type){
                case RoomSessionViralFurniStatusEvent.RSVFS_STATUS:
                    _local_2 = (_arg_1 as RoomSessionViralFurniStatusEvent);
                    _local_3 = new RoomWidgetTeaserDataUpdateEvent(RoomWidgetTeaserDataUpdateEvent.RWTDUE_GIFT_DATA);
                    _local_3.campaignID = _local_2.campaignID;
                    _local_3.objectId = _local_2.objectId;
                    _local_3.status = _local_2.status;
                    _local_3.data = _local_2.shareId;
                    _local_3.itemCategory = _local_2.itemCategory;
                    _local_3.firstClickUserName = _local_2.firstClickUserName;
                    _local_3.ownRealName = this._container.sessionDataManager.realName;
                    this._container.events.dispatchEvent(_local_3);
                    return;
                case RoomSessionViralFurniStatusEvent.RSVFS_RECEIVED:
                    _local_2 = (_arg_1 as RoomSessionViralFurniStatusEvent);
                    _local_3 = new RoomWidgetTeaserDataUpdateEvent(RoomWidgetTeaserDataUpdateEvent.RWTDUE_GIFT_RECEIVED);
                    _local_3.campaignID = _local_2.campaignID;
                    _local_3.status = _local_2.status;
                    _local_3.data = _local_2.shareId;
                    _local_3.itemCategory = _local_2.itemCategory;
                    _local_3.firstClickUserName = _local_2.firstClickUserName;
                    _local_3.giftWasReceived = _local_2.giftWasReceived;
                    this._container.events.dispatchEvent(_local_3);
                    return;
                default:
                    Logger.log(("Error, invalid viral room event type: " + _arg_1.type));
            };
        }
        public function update():void
        {
        }

    }
}//package com.sulake.habbo.ui.handler

// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// IRoomObjectModel = "_-253" (String#6141, DoABC#2)
// RoomSessionViralFurniStatusEvent = "_-2OF" (String#6524, DoABC#2)
// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// FurnitureTeaserWidgetHandler = "_-0uY" (String#16223, DoABC#2)
// RoomWidgetFurniToWidgetMessage = "_-2Rk" (String#6600, DoABC#2)
// RoomWidgetTeaserDataUpdateEvent = "_-Cu" (String#7931, DoABC#2)
// RoomWidgetViralFurniMessage = "_-2jy" (String#6954, DoABC#2)
// RWFWM_MESSAGE_REQUEST_TEASER = "_-2Uv" (String#20235, DoABC#2)
// RWVFM_VIRAL_FOUND = "_-22P" (String#19106, DoABC#2)
// RWVFM_OPEN_PRESENT = "_-Bb" (String#22674, DoABC#2)
// realName = "_-3HH" (String#922, DoABC#2)
// RWE_FURNI_TEASER_WIDGET = "_-2Qe" (String#20070, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// RSVFS_STATUS = "_-W" (String#23492, DoABC#2)
// RSVFS_RECEIVED = "_-3n" (String#22366, DoABC#2)
// shareId = "_-0L" (String#14876, DoABC#2)
// firstClickUserName = "_-0jN" (String#15804, DoABC#2)
// giftWasReceived = "_-1AI" (String#16872, DoABC#2)
// itemCategory = "_-3Bq" (String#21955, DoABC#2)
// campaignID = "_-09Z" (String#14429, DoABC#2)
// IRoomSpriteCanvasContainer = "_-1qD" (String#866, DoABC#2)
// sessionDataManager = "_-0pX" (String#4623, DoABC#2)
// RWTDUE_TEASER_DATA = "_-0sx" (String#16159, DoABC#2)
// RWTDUE_GIFT_DATA = "_-3G0" (String#22116, DoABC#2)
// RWTDUE_GIFT_RECEIVED = "_-io" (String#23991, DoABC#2)
// ownRealName = "_-ZW" (String#23616, DoABC#2)
// roomSession = "_-0cq" (String#4363, DoABC#2)
// IRoomWidgetHandler = "_-1dr" (String#5626, DoABC#2)
// IRoomWidgetHandler = "_-0gb" (String#4436, DoABC#2)
// IRoomWidgetHandler = "_-xT" (String#2223, DoABC#2)
// _SafeStr_7217 = "_-1mr" (String#18416, DoABC#2)
// RoomSession = "_-Zi" (String#8411, DoABC#2)
// RoomSession = "_-3Es" (String#7609, DoABC#2)


