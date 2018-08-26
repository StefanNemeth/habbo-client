
package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPresentOpenMessage;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPresentDataUpdateEvent;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import flash.display.BitmapData;
    import com.sulake.habbo.session.events.RoomSessionPresentEvent;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.catalog.enum.ProductTypeEnum;
    import flash.events.Event;

    public class FurniturePresentWidgetHandler implements IRoomWidgetHandler, IGetImageListener 
    {

        private static const _SafeStr_7291:String = "floor";
        private static const _SafeStr_7292:String = "wallpaper";
        private static const TYPE_LANDSCAPE:String = "landscape";
        private static const _FurniturePresentWidgetHandler:String = "poster";

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;
        private var _objectId:int = -1;
        private var _name:String = "";

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get type():String
        {
            return (RoomWidgetEnum.RWE_FURNI_PRESENT_WIDGET);
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
            return ([RoomWidgetFurniToWidgetMessage.RWFWM_MESSAGE_REQUEST_PRESENT, RoomWidgetPresentOpenMessage.RWVFM_OPEN_PRESENT]);
        }
        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_2:RoomWidgetFurniToWidgetMessage;
            var _local_3:IRoomObject;
            var _local_4:RoomWidgetPresentOpenMessage;
            var _local_5:IRoomObjectModel;
            var _local_6:String;
            var _local_7:int;
            var _local_8:String;
            var _local_9:ImageResult;
            var _local_10:Boolean;
            var _local_11:RoomWidgetPresentDataUpdateEvent;
            switch (_arg_1.type){
                case RoomWidgetFurniToWidgetMessage.RWFWM_MESSAGE_REQUEST_PRESENT:
                    _local_2 = (_arg_1 as RoomWidgetFurniToWidgetMessage);
                    _local_3 = this._container.roomEngine.IRoomSpriteCanvasContainer(_local_2.roomId, _local_2.roomCategory, _local_2.id, _local_2.category);
                    if (_local_3 != null){
                        _local_5 = _local_3.getModel();
                        if (_local_5 != null){
                            this._objectId = _local_2.id;
                            _local_6 = _local_5.getString(RoomObjectVariableEnum._SafeStr_7217);
                            if (_local_6 == null){
                                _local_6 = "";
                            };
                            _local_6 = _local_6.substr(1);
                            _local_7 = _local_5.getNumber(RoomObjectVariableEnum._SafeStr_7294);
                            _local_8 = _local_5.getString(RoomObjectVariableEnum._SafeStr_7295);
                            _local_9 = this._container.roomEngine.getFurnitureImage(_local_7, new Vector3d(180), 64, null, 0, _local_8);
                            _local_10 = ((this._container.roomSession.isRoomOwner) || (this._container.sessionDataManager.isAnyRoomController));
                            _local_11 = new RoomWidgetPresentDataUpdateEvent(RoomWidgetPresentDataUpdateEvent.RWEBDUE_PACKAGEINFO, _local_2.id, _local_6, _local_10, _local_9.data);
                            this._container.events.dispatchEvent(_local_11);
                        };
                    };
                    break;
                case RoomWidgetPresentOpenMessage.RWVFM_OPEN_PRESENT:
                    _local_4 = (_arg_1 as RoomWidgetPresentOpenMessage);
                    if (_local_4.objectId != this._objectId){
                        return (null);
                    };
                    if (((!((this._container == null))) && (!((this._container.roomSession == null))))){
                        this._container.roomSession.RoomSession(_local_4.objectId);
                    };
                    break;
            };
            return (null);
        }
        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            if (((this.disposed) || ((this._container == null)))){
                return;
            };
            var _local_3:RoomWidgetPresentDataUpdateEvent = new RoomWidgetPresentDataUpdateEvent(RoomWidgetPresentDataUpdateEvent.RWEBDUE_CONTENTS, 0, this._name, false, _arg_2);
            this._container.events.dispatchEvent(_local_3);
        }
        public function IRoomWidgetHandler():Array
        {
            return ([RoomSessionPresentEvent.RSPE_PRESENT_OPENED]);
        }
        public function IRoomWidgetHandler(_arg_1:Event):void
        {
            var _local_2:RoomSessionPresentEvent;
            var _local_3:IFurnitureData;
            var _local_4:ImageResult;
            var _local_5:RoomWidgetPresentDataUpdateEvent;
            var _local_6:IProductData;
            if (_arg_1 == null){
                return;
            };
            if (((((!((this._container == null))) && (!((this._container.events == null))))) && (!((_arg_1 == null))))){
                switch (_arg_1.type){
                    case RoomSessionPresentEvent.RSPE_PRESENT_OPENED:
                        _local_2 = (_arg_1 as RoomSessionPresentEvent);
                        if (_local_2 != null){
                            this._name = "";
                            _local_4 = null;
                            if (_local_2.itemType == ProductTypeEnum._SafeStr_5017){
                                _local_3 = this._container.sessionDataManager.SessionDataManager(_local_2.classId);
                            }
                            else {
                                if (_local_2.itemType == ProductTypeEnum._SafeStr_5019){
                                    _local_3 = this._container.sessionDataManager.SessionDataManager(_local_2.classId);
                                };
                            };
                            switch (_local_2.itemType){
                                case ProductTypeEnum._SafeStr_5019:
                                    if (((!((_local_3 == null))) && ((_local_3.name == _SafeStr_7291)))){
                                        _local_5 = new RoomWidgetPresentDataUpdateEvent(RoomWidgetPresentDataUpdateEvent.RWPDUE_CONTENTS_FLOOR, 0, this._container.localization.getKey("inventory.furni.item.floor.name"), false, null);
                                    }
                                    else {
                                        if (((!((_local_3 == null))) && ((_local_3.name == TYPE_LANDSCAPE)))){
                                            _local_5 = new RoomWidgetPresentDataUpdateEvent(RoomWidgetPresentDataUpdateEvent.RWPDUE_CONTENTS_LANDSCAPE, 0, this._container.localization.getKey("inventory.furni.item.landscape.name"), false, null);
                                        }
                                        else {
                                            if (((!((_local_3 == null))) && ((_local_3.name == _SafeStr_7292)))){
                                                _local_5 = new RoomWidgetPresentDataUpdateEvent(RoomWidgetPresentDataUpdateEvent.RWPDUE_CONTENTS_WALLPAPER, 0, this._container.localization.getKey("inventory.furni.item.wallpaper.name"), false, null);
                                            }
                                            else {
                                                if (((!((_local_3 == null))) && ((_local_3.name == _FurniturePresentWidgetHandler)))) break;
                                                _local_4 = this._container.roomEngine.getWallItemIcon(_local_2.classId, this);
                                                if (_local_3 != null){
                                                    this._name = _local_3.title;
                                                };
                                                if (_local_4 != null){
                                                    _local_5 = new RoomWidgetPresentDataUpdateEvent(RoomWidgetPresentDataUpdateEvent.RWEBDUE_CONTENTS, 0, this._name, false, _local_4.data);
                                                };
                                            };
                                        };
                                    };
                                    break;
                                case ProductTypeEnum._SafeStr_5023:
                                    _local_5 = new RoomWidgetPresentDataUpdateEvent(RoomWidgetPresentDataUpdateEvent.RWPDUE_CONTENTS_CLUB, 0, this._container.localization.getKey("widget.furni.present.hc"), false, null);
                                    break;
                                default:
                                    _local_4 = this._container.roomEngine.getFurnitureImage(_local_2.classId, new Vector3d(180), 32, this);
                                    _local_6 = this._container.sessionDataManager.getProductData(_local_2.productCode);
                                    if (_local_6 != null){
                                        this._name = _local_6.name;
                                    }
                                    else {
                                        if (_local_3 != null){
                                            this._name = _local_3.title;
                                        };
                                    };
                                    if (_local_4 != null){
                                        _local_5 = new RoomWidgetPresentDataUpdateEvent(RoomWidgetPresentDataUpdateEvent.RWEBDUE_CONTENTS, 0, this._name, false, _local_4.data);
                                    };
                            };
                            if (_local_5 != null){
                                this._container.events.dispatchEvent(_local_5);
                            };
                        };
                };
            };
        }
        public function update():void
        {
        }

    }
}//package com.sulake.habbo.ui.handler

// ImageResult = "_-31w" (String#21576, DoABC#2)
// IFurnitureData = "_-pe" (String#8701, DoABC#2)
// IProductData = "_-0jc" (String#4494, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// ProductTypeEnum = "_-11z" (String#16536, DoABC#2)
// IRoomObjectModel = "_-253" (String#6141, DoABC#2)
// RoomSessionPresentEvent = "_-30Q" (String#7312, DoABC#2)
// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// IGetImageListener = "_-2i7" (String#6909, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// FurniturePresentWidgetHandler = "_-0ku" (String#15861, DoABC#2)
// RoomWidgetFurniToWidgetMessage = "_-2Rk" (String#6600, DoABC#2)
// RoomWidgetPresentOpenMessage = "_-1ti" (String#18706, DoABC#2)
// RoomWidgetPresentDataUpdateEvent = "_-03a" (String#14185, DoABC#2)
// RWFWM_MESSAGE_REQUEST_PRESENT = "_-2XY" (String#20344, DoABC#2)
// RWVFM_OPEN_PRESENT = "_-Bb" (String#22674, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// itemType = "_-De" (String#22756, DoABC#2)
// classId = "_-1mV" (String#18401, DoABC#2)
// RWEBDUE_PACKAGEINFO = "_-1FM" (String#17088, DoABC#2)
// RWEBDUE_CONTENTS = "_-k8" (String#24041, DoABC#2)
// RWE_FURNI_PRESENT_WIDGET = "_-2S0" (String#20119, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// RSPE_PRESENT_OPENED = "_-1eK" (String#18071, DoABC#2)
// productCode = "_-2co" (String#20558, DoABC#2)
// RWPDUE_CONTENTS_CLUB = "_-06W" (String#14307, DoABC#2)
// RWPDUE_CONTENTS_FLOOR = "_-OX" (String#23188, DoABC#2)
// RWPDUE_CONTENTS_LANDSCAPE = "_-1cD" (String#17979, DoABC#2)
// RWPDUE_CONTENTS_WALLPAPER = "_-o9" (String#24196, DoABC#2)
// IRoomSpriteCanvasContainer = "_-1qD" (String#866, DoABC#2)
// _SafeStr_5017 = "_-1-l" (String#16457, DoABC#2)
// _SafeStr_5019 = "_-Ok" (String#23195, DoABC#2)
// _SafeStr_5023 = "_-hJ" (String#23942, DoABC#2)
// sessionDataManager = "_-0pX" (String#4623, DoABC#2)
// isRoomOwner = "_-ZP" (String#8405, DoABC#2)
// isAnyRoomController = "_-2IH" (String#6407, DoABC#2)
// roomSession = "_-0cq" (String#4363, DoABC#2)
// IRoomWidgetHandler = "_-1dr" (String#5626, DoABC#2)
// IRoomWidgetHandler = "_-0gb" (String#4436, DoABC#2)
// IRoomWidgetHandler = "_-xT" (String#2223, DoABC#2)
// _SafeStr_7217 = "_-1mr" (String#18416, DoABC#2)
// RoomSession = "_-3Es" (String#7609, DoABC#2)
// SessionDataManager = "_-08L" (String#3728, DoABC#2)
// SessionDataManager = "_-Hc" (String#8029, DoABC#2)
// _SafeStr_7291 = "_-00x" (String#1383, DoABC#2)
// _SafeStr_7292 = "_-aU" (String#8428, DoABC#2)
// _FurniturePresentWidgetHandler = "_-2iw" (String#6930, DoABC#2)
// _SafeStr_7294 = "_-Uf" (String#23433, DoABC#2)
// _SafeStr_7295 = "_-2nE" (String#20969, DoABC#2)


