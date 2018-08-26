
package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.room.events.RoomObjectRoomAdEvent;
    import com.sulake.habbo.room.messages.RoomObjectRoomAdUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetInfostandExtraParamEnum;

    public class FurnitureRoomBrandingLogic extends FurnitureLogic 
    {

        public static const _SafeStr_12464:String = "state";
        public static const _SafeStr_12465:String = "imageUrl";
        public static const _SafeStr_12466:String = "clickUrl";
        public static const _SafeStr_12467:String = "offsetX";
        public static const _SafeStr_12468:String = "offsetY";
        public static const _SafeStr_12469:String = "offsetZ";

        protected var _SafeStr_12470:Boolean;
        protected var _SafeStr_12471:Boolean;

        public function FurnitureRoomBrandingLogic()
        {
            this._SafeStr_12470 = true;
            this._SafeStr_12471 = false;
        }
        override public function initialize(_arg_1:XML):void
        {
            super.initialize(_arg_1);
            if (this._SafeStr_12470){
                object.getModelController().setNumber(RoomObjectVariableEnum._SafeStr_12472, 1);
            };
        }
        override public function getEventTypes():Array
        {
            var _local_1:Array = [RoomObjectRoomAdEvent.RORAE_ROOM_AD_LOAD_IMAGE];
            return (ObjectLogicBase(super.getEventTypes(), _local_1));
        }
        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            var _local_2:RoomObjectRoomAdUpdateMessage;
            super.processUpdateMessage(_arg_1);
            if ((_arg_1 is RoomObjectDataUpdateMessage)){
                this.setupImageFromFurnitureData();
            };
            if ((_arg_1 is RoomObjectRoomAdUpdateMessage)){
                _local_2 = (_arg_1 as RoomObjectRoomAdUpdateMessage);
                switch (_local_2.type){
                    case RoomObjectRoomAdUpdateMessage.RORUM_ROOM_BILLBOARD_IMAGE_LOADED:
                        object.getModelController().setNumber(RoomObjectVariableEnum._SafeStr_12474, 1, false);
                        return;
                    case RoomObjectRoomAdUpdateMessage.RORUM_ROOM_BILLBOARD_IMAGE_LOADING_FAILED:
                        object.getModelController().setNumber(RoomObjectVariableEnum._SafeStr_12474, -1);
                        Logger.log(("failed to load billboard image from url " + object.getModelController().getString(RoomObjectVariableEnum._SafeStr_12475)));
                        return;
                };
            };
        }
        private function setupImageFromFurnitureData():Boolean
        {
            var _local_2:String;
            var _local_3:Array;
            var _local_4:String;
            var _local_5:String;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:String;
            var _local_10:String;
            var _local_11:Array;
            var _local_12:String;
            var _local_13:String;
            var _local_14:Number;
            var _local_15:String;
            var _local_16:String;
            var _local_17:int;
            var _local_1:Boolean;
            if (object != null){
                _local_2 = object.getModel().getString(RoomObjectVariableEnum._SafeStr_7217);
                if (_local_2 != null){
                    _local_3 = _local_2.split("\t");
                    if (_local_3 != null){
                        for each (_local_10 in _local_3) {
                            _local_11 = _local_10.split("=", 2);
                            if (((!((_local_11 == null))) && ((_local_11.length == 2)))){
                                _local_12 = _local_11[0];
                                _local_13 = _local_11[1];
                                switch (_local_12){
                                    case _SafeStr_12464:
                                        _local_14 = parseInt(_local_13);
                                        if (!isNaN(_local_14)){
                                            _local_17 = int(_local_14);
                                            if (object.getState(0) != _local_17){
                                                object.setState(_local_17, 0);
                                                _local_1 = true;
                                            };
                                        };
                                        break;
                                    case _SafeStr_12465:
                                        _local_15 = object.getModelController().getString(RoomObjectVariableEnum._SafeStr_12475);
                                        if ((((_local_15 == null)) || (!((_local_15 == _local_13))))){
                                            object.getModelController().setString(RoomObjectVariableEnum._SafeStr_12475, _local_13, false);
                                            object.getModelController().setNumber(RoomObjectVariableEnum._SafeStr_12474, 0, false);
                                            _local_1 = true;
                                        };
                                        break;
                                    case _SafeStr_12466:
                                        _local_16 = object.getModelController().getString(RoomObjectVariableEnum.FURNITURE_BRANDING_CLICK_URL);
                                        if ((((_local_16 == null)) || (!((_local_16 == _local_13))))){
                                            object.getModelController().setString(RoomObjectVariableEnum.FURNITURE_BRANDING_CLICK_URL, _local_13);
                                            _local_1 = true;
                                        };
                                        break;
                                    case _SafeStr_12467:
                                        _local_1 = this.updateOffset(RoomObjectVariableEnum._SafeStr_12477, object.getModelController().getNumber(RoomObjectVariableEnum._SafeStr_12477), parseInt(_local_13));
                                        break;
                                    case _SafeStr_12468:
                                        _local_1 = this.updateOffset(RoomObjectVariableEnum._SafeStr_12478, object.getModelController().getNumber(RoomObjectVariableEnum._SafeStr_12478), parseInt(_local_13));
                                        break;
                                    case _SafeStr_12469:
                                        _local_1 = this.updateOffset(RoomObjectVariableEnum._SafeStr_12479, object.getModelController().getNumber(RoomObjectVariableEnum._SafeStr_12479), parseInt(_local_13));
                                        break;
                                };
                            };
                        };
                    };
                    _local_4 = object.getModelController().getString(RoomObjectVariableEnum._SafeStr_12475);
                    _local_5 = object.getModelController().getString(RoomObjectVariableEnum.FURNITURE_BRANDING_CLICK_URL);
                    _local_6 = object.getModelController().getNumber(RoomObjectVariableEnum._SafeStr_12477);
                    _local_7 = object.getModelController().getNumber(RoomObjectVariableEnum._SafeStr_12478);
                    _local_8 = object.getModelController().getNumber(RoomObjectVariableEnum._SafeStr_12479);
                    if (_local_4 != null){
                        eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent(RoomObjectRoomAdEvent.RORAE_ROOM_AD_LOAD_IMAGE, object.getId(), object.getType(), _local_4, _local_5));
                    };
                    _local_9 = (((_SafeStr_12465 + "=") + (((_local_4)!=null) ? _local_4 : "")) + "\t");
                    if (this._SafeStr_12471){
                        _local_9 = (_local_9 + (((_SafeStr_12466 + "=") + (((_local_5)!=null) ? _local_5 : "")) + "\t"));
                    };
                    _local_9 = (_local_9 + (((_SafeStr_12467 + "=") + _local_6) + "\t"));
                    _local_9 = (_local_9 + (((_SafeStr_12468 + "=") + _local_7) + "\t"));
                    _local_9 = (_local_9 + (((_SafeStr_12469 + "=") + _local_8) + "\t"));
                    object.getModelController().setString(RoomWidgetInfostandExtraParamEnum.RWEIEP_INFOSTAND_EXTRA_PARAM, (RoomWidgetInfostandExtraParamEnum.RWEIEP_BRANDING_OPTIONS + _local_9));
                };
            };
            return (_local_1);
        }
        private function updateOffset(_arg_1:String, _arg_2:int, _arg_3:int):Boolean
        {
            if (_arg_2 != _arg_3){
                object.getModelController().setNumber(_arg_1, _arg_3);
                return (true);
            };
            return (false);
        }

    }
}//package com.sulake.habbo.room.object.logic.furniture

// _SafeStr_12464 = "_-0c5" (String#15517, DoABC#2)
// _SafeStr_12465 = "_-0eN" (String#15602, DoABC#2)
// _SafeStr_12466 = "_-2xe" (String#21380, DoABC#2)
// _SafeStr_12467 = "_-ss" (String#24397, DoABC#2)
// _SafeStr_12468 = "_-0mR" (String#15914, DoABC#2)
// _SafeStr_12469 = "_-Zt" (String#23627, DoABC#2)
// _SafeStr_12470 = "_-1t0" (String#18678, DoABC#2)
// _SafeStr_12471 = "_-2eH" (String#20615, DoABC#2)
// _SafeStr_12472 = "_-1zi" (String#18956, DoABC#2)
// setupImageFromFurnitureData = "_-1co" (String#18003, DoABC#2)
// _SafeStr_12474 = "_-1cM" (String#17984, DoABC#2)
// _SafeStr_12475 = "_-19Q" (String#16834, DoABC#2)
// updateOffset = "_-0kA" (String#15838, DoABC#2)
// _SafeStr_12477 = "_-2MO" (String#19901, DoABC#2)
// _SafeStr_12478 = "_-0cY" (String#15536, DoABC#2)
// _SafeStr_12479 = "_-0Kb" (String#14864, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// FurnitureLogic = "_-001" (String#14053, DoABC#2)
// FurnitureRoomBrandingLogic = "_-3JR" (String#7693, DoABC#2)
// RoomObjectUpdateMessage = "_-73" (String#22503, DoABC#2)
// RoomObjectRoomAdUpdateMessage = "_-070" (String#14324, DoABC#2)
// RoomObjectDataUpdateMessage = "_-2N4" (String#19928, DoABC#2)
// RoomWidgetInfostandExtraParamEnum = "_-2ru" (String#7121, DoABC#2)
// RWEIEP_INFOSTAND_EXTRA_PARAM = "_-3J-" (String#22238, DoABC#2)
// RWEIEP_BRANDING_OPTIONS = "_-1ob" (String#18481, DoABC#2)
// ObjectLogicBase = "_-uN" (String#24466, DoABC#2)
// processUpdateMessage = "_-FX" (String#7984, DoABC#2)
// RORAE_ROOM_AD_LOAD_IMAGE = "_-0MN" (String#14928, DoABC#2)
// _SafeStr_7217 = "_-1mr" (String#18416, DoABC#2)
// RoomObjectRoomAdEvent = "_-mk" (String#24139, DoABC#2)
// RORUM_ROOM_BILLBOARD_IMAGE_LOADED = "_-MO" (String#23100, DoABC#2)
// RORUM_ROOM_BILLBOARD_IMAGE_LOADING_FAILED = "_-1jn" (String#18276, DoABC#2)


