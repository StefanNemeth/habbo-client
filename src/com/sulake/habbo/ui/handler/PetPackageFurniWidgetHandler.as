
package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.avatar.IPetImageListener;
    import com.sulake.habbo.avatar.pets.IPetDataListener;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenPetPackageMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionPetPackageEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPetPackageUpdateEvent;
    import com.sulake.habbo.avatar.pets.IPetData;
    import flash.display.BitmapData;
    import flash.events.Event;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import com.sulake.room.utils.Vector3d;

    public class PetPackageFurniWidgetHandler implements IRoomWidgetHandler, IPetImageListener, IPetDataListener, IGetImageListener 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;
        private var _objectId:int = -1;
        private var _petType:int = -1;
        private var _breed:int = -1;
        private var _color:String = "";

        public function get type():String
        {
            return (RoomWidgetEnum.RWE_FURNI_PET_PACKAGE_WIDGET);
        }
        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            this._container = _arg_1;
        }
        public function getWidgetMessages():Array
        {
            return ([RoomWidgetOpenPetPackageMessage.RWOPPM_OPEN_PET_PACKAGE]);
        }
        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_2:RoomWidgetOpenPetPackageMessage;
            switch (_arg_1.type){
                case RoomWidgetOpenPetPackageMessage.RWOPPM_OPEN_PET_PACKAGE:
                    _local_2 = (_arg_1 as RoomWidgetOpenPetPackageMessage);
                    if (((!((this._container == null))) && (!((this._container.roomSession == null))))){
                        this._container.roomSession.sendOpenPetPackageMessage(_local_2.objectId, _local_2.name);
                    };
                    break;
            };
            return (null);
        }
        public function getProcessedEvents():Array
        {
            return ([RoomSessionPetPackageEvent.RSOPPE_OPEN_PET_PACKAGE_REQUESTED, RoomSessionPetPackageEvent.RSOPPE_OPEN_PET_PACKAGE_RESULT]);
        }
        public function processEvent(_arg_1:Event):void
        {
            var _local_2:RoomSessionPetPackageEvent;
            var _local_3:RoomWidgetPetPackageUpdateEvent;
            var _local_4:IPetData;
            var _local_5:BitmapData;
            var _local_6:int;
            var _local_7:String;
            if (_arg_1 == null){
                return;
            };
            if (((((!((this._container == null))) && (!((this._container.events == null))))) && (!((_arg_1 == null))))){
                switch (_arg_1.type){
                    case RoomSessionPetPackageEvent.RSOPPE_OPEN_PET_PACKAGE_REQUESTED:
                        _local_2 = (_arg_1 as RoomSessionPetPackageEvent);
                        this._objectId = _local_2.objectId;
                        this._petType = _local_2.petType;
                        this._breed = _local_2.breed;
                        this._color = _local_2.color;
                        _local_4 = this._container.avatarRenderManager.petDataManager.getPetData(this._petType, this);
                        _local_5 = this.getPetImage();
                        _local_3 = new RoomWidgetPetPackageUpdateEvent(RoomWidgetPetPackageUpdateEvent.RWOPPUE_OPEN_PET_PACKAGE_REQUESTED, this._objectId, _local_5, -1, null);
                        this._container.events.dispatchEvent(_local_3);
                        return;
                    case RoomSessionPetPackageEvent.RSOPPE_OPEN_PET_PACKAGE_RESULT:
                        _local_2 = (_arg_1 as RoomSessionPetPackageEvent);
                        this._objectId = _local_2.objectId;
                        _local_6 = _local_2.nameValidationStatus;
                        _local_7 = _local_2.nameValidationInfo;
                        _local_3 = new RoomWidgetPetPackageUpdateEvent(RoomWidgetPetPackageUpdateEvent.RWOPPUE_OPEN_PET_PACKAGE_RESULT, this._objectId, null, _local_6, _local_7);
                        this._container.events.dispatchEvent(_local_3);
                        return;
                };
            };
        }
        public function update():void
        {
        }
        public function dispose():void
        {
            this._disposed = true;
            this._container = null;
            this._objectId = -1;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function petImageReady(_arg_1:String):void
        {
            var _local_2:BitmapData = this.getPetImage();
            var _local_3:RoomWidgetPetPackageUpdateEvent = new RoomWidgetPetPackageUpdateEvent(RoomWidgetPetPackageUpdateEvent.RWOPPUE_OPEN_PET_PACKAGE_UPDATE_PET_IMAGE, this._objectId, _local_2, -1, null);
            this._container.events.dispatchEvent(_local_3);
        }
        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            var _local_3:RoomWidgetPetPackageUpdateEvent = new RoomWidgetPetPackageUpdateEvent(RoomWidgetPetPackageUpdateEvent.RWOPPUE_OPEN_PET_PACKAGE_UPDATE_PET_IMAGE, this._objectId, _arg_2, -1, null);
            this._container.events.dispatchEvent(_local_3);
        }
        public function petDataReady():void
        {
            this.petImageReady("");
        }
        private function getPetImage():BitmapData
        {
            var _local_1:uint;
            var _local_2:IAvatarImage;
            var _local_3:uint;
            var _local_4:ImageResult;
            if (this._petType < 8){
                _local_1 = parseInt(this._color, 16);
                _local_2 = this._container.avatarRenderManager.createPetImage(this._petType, this._breed, _local_1, AvatarScaleType._SafeStr_4336, this);
                if (_local_2 != null){
                    return (_local_2.getCroppedImage(AvatarSetType._SafeStr_4457));
                };
            }
            else {
                _local_3 = 0;
                _local_4 = this._container.roomEngine.getPetImage(this._petType, this._breed, new Vector3d(90), 64, this, _local_3);
                if (_local_4 != null){
                    return (_local_4.data);
                };
            };
            return (null);
        }

    }
}//package com.sulake.habbo.ui.handler

// ImageResult = "_-31w" (String#21576, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// AvatarScaleType = "_-2lF" (String#20893, DoABC#2)
// RoomSessionPetPackageEvent = "_-0sq" (String#4702, DoABC#2)
// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// IPetData = "_-0mZ" (String#4560, DoABC#2)
// IPetDataListener = "_-r6" (String#8726, DoABC#2)
// IGetImageListener = "_-2i7" (String#6909, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// PetPackageFurniWidgetHandler = "_-j0" (String#24001, DoABC#2)
// RoomWidgetPetPackageUpdateEvent = "_-2N6" (String#6503, DoABC#2)
// RoomWidgetOpenPetPackageMessage = "_-0jy" (String#4501, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// RWOPPM_OPEN_PET_PACKAGE = "_-2Bv" (String#19479, DoABC#2)
// _breed = "_-0BH" (String#297, DoABC#2)
// RWE_FURNI_PET_PACKAGE_WIDGET = "_-0tQ" (String#16176, DoABC#2)
// _SafeStr_4336 = "_-1wM" (String#18815, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// _SafeStr_4457 = "_-2mY" (String#20943, DoABC#2)
// petImageReady = "_-WW" (String#8332, DoABC#2)
// RSOPPE_OPEN_PET_PACKAGE_REQUESTED = "_-FG" (String#22824, DoABC#2)
// RSOPPE_OPEN_PET_PACKAGE_RESULT = "_-2JR" (String#19786, DoABC#2)
// _petType = "_-0zB" (String#439, DoABC#2)
// petType = "_-0GK" (String#3877, DoABC#2)
// getCroppedImage = "_-2Ez" (String#6342, DoABC#2)
// roomSession = "_-0cq" (String#4363, DoABC#2)
// getWidgetMessages = "_-1dr" (String#5626, DoABC#2)
// getProcessedEvents = "_-0gb" (String#4436, DoABC#2)
// processEvent = "_-xT" (String#2223, DoABC#2)
// sendOpenPetPackageMessage = "_-0nV" (String#4580, DoABC#2)
// getPetData = "_-2Tw" (String#6646, DoABC#2)
// petDataManager = "_-0y0" (String#4809, DoABC#2)
// getPetImage = "_-0Zc" (String#437, DoABC#2)
// RWOPPUE_OPEN_PET_PACKAGE_REQUESTED = "_-0lb" (String#15884, DoABC#2)
// RWOPPUE_OPEN_PET_PACKAGE_RESULT = "_-0zY" (String#16409, DoABC#2)
// RWOPPUE_OPEN_PET_PACKAGE_UPDATE_PET_IMAGE = "_-tS" (String#24425, DoABC#2)
// petDataReady = "_-0Wh" (String#4242, DoABC#2)
// createPetImage = "_-0Qk" (String#4105, DoABC#2)


