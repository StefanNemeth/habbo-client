
package com.sulake.habbo.room
{
    import com.sulake.room.renderer.IRoomRenderingCanvasMouseListener;
    import com.sulake.core.utils.Map;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.habbo.room.object.RoomObjectOperationEnum;
    import com.sulake.habbo.room.utils.SelectedRoomObjectData;
    import com.sulake.room.object.IRoomObjectController;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.room.events.RoomEngineObjectEvent;
    import flash.events.MouseEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.events.RoomObjectMouseEvent;
    import com.sulake.habbo.room.events.RoomObjectStateChangeEvent;
    import com.sulake.habbo.room.events.RoomObjectDimmerStateUpdateEvent;
    import com.sulake.habbo.room.events.RoomObjectMoveEvent;
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
    import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
    import com.sulake.habbo.room.events.RoomObjectFloorHoleEvent;
    import com.sulake.habbo.room.events.RoomObjectRoomAdEvent;
    import com.sulake.habbo.room.events.RoomObjectRoomActionEvent;
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.habbo.room.events.RoomObjectTileMouseEvent;
    import com.sulake.habbo.room.events.RoomObjectWallMouseEvent;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectVisibilityUpdateMessage;
    import com.sulake.habbo.room.utils.TileHeightMap;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.room.events.RoomEngineSoundMachineEvent;
    import com.sulake.habbo.communication.messages.outgoing.room.publicroom.ChangeRoomMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.publicroom.TryBusMessageComposer;
    import com.sulake.habbo.room.events.RoomEngineDimmerStateEvent;
    import com.sulake.habbo.room.messages.RoomObjectAvatarSelectedMessage;
    import com.sulake.habbo.communication.messages.outgoing.room.avatar.LookToMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.SetObjectDataMessageComposer;
    import com.sulake.habbo.room.utils.LegacyWallGeometry;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.MoveObjectMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.PickupObjectMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.MoveWallItemMessageComposer;
    import com.sulake.habbo.room.object.RoomObjectTypeEnum;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.PlacePetMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.PlacePostItMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.PlaceObjectMessageComposer;
    import com.sulake.habbo.room.events.RoomEngineObjectPlacedEvent;
    import flash.external.ExternalInterface;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.UseFurnitureMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.SetRandomStateMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.UseWallItemMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.ThrowDiceMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.DiceOffMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.SpinWheelOfFortuneMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.GetItemDataMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.ViralFurniStatusMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.EnterOneWayDoorMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.QuestVendingWallItemMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.SetItemDataMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.RemoveItemMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.MoveAvatarMessageComposer;

    public class RoomObjectEventHandler implements IRoomRenderingCanvasMouseListener 
    {

        private var _roomEngine:IRoomEngineServices = null;
        private var _eventIds:Map = null;
        private var _selectedAvatarId:int = -1;

        public function RoomObjectEventHandler(_arg_1:IRoomEngineServices)
        {
            this._eventIds = new Map();
            this._roomEngine = _arg_1;
        }
        public function dispose():void
        {
            if (this._eventIds != null){
                this._eventIds.dispose();
                this._eventIds = null;
            };
            this._roomEngine = null;
        }
        public function initializeRoomObjectInsert(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:String=null):Boolean
        {
            var _local_7:IVector3d = new Vector3d(-100, -100);
            var _local_8:IVector3d = new Vector3d(0);
            this.setSelectedObjectData(_arg_1, _arg_2, _arg_3, _arg_4, _local_7, _local_8, RoomObjectOperationEnum.OBJECT_PLACE, _arg_5, _arg_6);
            if (this._roomEngine != null){
                this._roomEngine.setObjectMoverIconSprite(_arg_5, _arg_4, false, _arg_6);
                this._roomEngine.setObjectMoverIconSpriteVisible(false);
            };
            return (true);
        }
        public function cancelRoomObjectInsert(_arg_1:int, _arg_2:int):Boolean
        {
            this.resetSelectedObjectData(_arg_1, _arg_2);
            return (true);
        }
        private function getSelectedObjectData(_arg_1:int, _arg_2:int):SelectedRoomObjectData
        {
            if (this._roomEngine == null){
                return (null);
            };
            var _local_3:ISelectedRoomObjectData = this._roomEngine.getSelectedObjectData(_arg_1, _arg_2);
            return ((_local_3 as SelectedRoomObjectData));
        }
        private function setSelectedObjectData(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:IVector3d, _arg_6:IVector3d, _arg_7:String, _arg_8:int=0, _arg_9:String=null):void
        {
            this.resetSelectedObjectData(_arg_1, _arg_2);
            if (this._roomEngine == null){
                return;
            };
            var _local_10:SelectedRoomObjectData = new SelectedRoomObjectData(_arg_3, _arg_4, _arg_7, _arg_5, _arg_6, _arg_8, _arg_9);
            this._roomEngine.setSelectedObjectData(_arg_1, _arg_2, _local_10);
        }
        private function updateSelectedObjectData(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:IVector3d, _arg_6:IVector3d, _arg_7:String, _arg_8:int=0, _arg_9:String=null):void
        {
            if (this._roomEngine == null){
                return;
            };
            var _local_10:SelectedRoomObjectData = new SelectedRoomObjectData(_arg_3, _arg_4, _arg_7, _arg_5, _arg_6, _arg_8, _arg_9);
            this._roomEngine.setSelectedObjectData(_arg_1, _arg_2, _local_10);
        }
        private function resetSelectedObjectData(_arg_1:int, _arg_2:int):void
        {
            var _local_4:IRoomObjectController;
            var _local_5:int;
            var _local_6:int;
            if (this._roomEngine == null){
                return;
            };
            if (this._roomEngine != null){
                this._roomEngine.removeObjectMoverIconSprite();
            };
            var _local_3:SelectedRoomObjectData = this.getSelectedObjectData(_arg_1, _arg_2);
            if (_local_3 != null){
                if (_local_3.operation == RoomObjectOperationEnum.OBJECT_MOVE){
                    _local_4 = (this._roomEngine.getRoomObject(_arg_1, _arg_2, _local_3.id, _local_3.category) as IRoomObjectController);
                    if (_local_4 != null){
                        _local_4.setLocation(_local_3.loc);
                        _local_4.setDirection(_local_3.dir);
                    };
                    this.setObjectAlphaMultiplier(_local_4, 1);
                    if (_local_3.category == RoomObjectCategoryEnum._SafeStr_4330){
                        this._roomEngine.updateObjectRoomWindow(_arg_1, _arg_2, _local_3.id, true);
                    };
                };
                if (_local_3.operation == RoomObjectOperationEnum.OBJECT_PLACE){
                    _local_5 = _local_3.id;
                    _local_6 = _local_3.category;
                    switch (_local_6){
                        case RoomObjectCategoryEnum._SafeStr_4329:
                            this._roomEngine.disposeObjectFurniture(_arg_1, _arg_2, _local_5);
                            break;
                        case RoomObjectCategoryEnum._SafeStr_4330:
                            this._roomEngine.disposeObjectWallItem(_arg_1, _arg_2, _local_5);
                            break;
                        case RoomObjectCategoryEnum.OBJECT_CATEGORY_USER:
                            this._roomEngine.disposeObjectUser(_arg_1, _arg_2, _local_5);
                            break;
                    };
                };
                this._roomEngine.setSelectedObjectData(_arg_1, _arg_2, null);
            };
        }
        public function setSelectedObject(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
            if (this._roomEngine == null){
                return;
            };
            var _local_5:IEventDispatcher = this._roomEngine.events;
            if (_local_5 == null){
                return;
            };
            switch (_arg_4){
                case RoomObjectCategoryEnum.OBJECT_CATEGORY_USER:
                case RoomObjectCategoryEnum._SafeStr_4329:
                case RoomObjectCategoryEnum._SafeStr_4330:
                    if (_arg_4 == RoomObjectCategoryEnum.OBJECT_CATEGORY_USER){
                        this.setSelectedAvatar(_arg_1, _arg_2, _arg_3, true);
                    }
                    else {
                        this.setSelectedAvatar(_arg_1, _arg_2, 0, false);
                    };
                    _local_5.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.REOE_OBJECT_SELECTED, _arg_1, _arg_2, _arg_3, _arg_4));
                    return;
            };
        }
        public function processRoomCanvasMouseEvent(_arg_1:RoomSpriteMouseEvent, _arg_2:IRoomObject, _arg_3:IRoomGeometry):void
        {
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return;
            };
            var _local_4:String = _arg_2.getType();
            var _local_5:int = this._roomEngine.getRoomObjectCategory(_local_4);
            if (_local_5 != RoomObjectCategoryEnum._SafeStr_13133){
                if (!this._roomEngine.getIsPlayingGame(this._roomEngine.activeRoomId, this._roomEngine.activeRoomCategory)){
                    _local_5 = RoomObjectCategoryEnum._SafeStr_4962;
                }
                else {
                    if (_local_5 != RoomObjectCategoryEnum.OBJECT_CATEGORY_USER){
                        _local_5 = RoomObjectCategoryEnum._SafeStr_4962;
                    };
                };
            };
            var _local_6:String = this.getMouseEventId(_local_5, _arg_1.type);
            if (_local_6 == _arg_1.eventId){
                if ((((((((((_arg_1.type == MouseEvent.CLICK)) || ((_arg_1.type == MouseEvent.DOUBLE_CLICK)))) || ((_arg_1.type == MouseEvent.MOUSE_DOWN)))) || ((_arg_1.type == MouseEvent.MOUSE_UP)))) || ((_arg_1.type == MouseEvent.MOUSE_MOVE)))){
                    return;
                };
            }
            else {
                if (_arg_1.eventId != null){
                    this.setMouseEventId(_local_5, _arg_1.type, _arg_1.eventId);
                };
            };
            if (_arg_2.getMouseHandler() != null){
                _arg_2.getMouseHandler().mouseEvent(_arg_1, _arg_3);
            };
        }
        public function handleRoomObjectEvent(_arg_1:RoomObjectEvent, _arg_2:int, _arg_3:int):void
        {
            if (_arg_1 == null){
                return;
            };
            if ((_arg_1 is RoomObjectMouseEvent)){
                this.handleRoomObjectMouseEvent((_arg_1 as RoomObjectMouseEvent), _arg_2, _arg_3);
                return;
            };
            switch (_arg_1.type){
                case RoomObjectStateChangeEvent.ROSCE_STATE_CHANGE:
                    this.handleObjectStateChange((_arg_1 as RoomObjectStateChangeEvent), _arg_2, _arg_3);
                    return;
                case RoomObjectStateChangeEvent.ROSCE_STATE_RANDOM:
                    this.handleObjectRandomStateChange((_arg_1 as RoomObjectStateChangeEvent), _arg_2, _arg_3);
                    return;
                case RoomObjectDimmerStateUpdateEvent.RWDSUE_DIMMER_STATE:
                    this.handleObjectDimmerStateEvent(_arg_1, _arg_2, _arg_3);
                    return;
                case RoomObjectMoveEvent.ROME_POSITION_CHANGED:
                    this.handleSelectedObjectMove(_arg_1, _arg_2, _arg_3);
                    return;
                case RoomObjectMoveEvent.ROME_OBJECT_REMOVED:
                    this.handleSelectedObjectRemove(_arg_1, _arg_2, _arg_3);
                    return;
                case RoomObjectWidgetRequestEvent.REOE_WIDGET_REQUEST_PLACEHOLDER:
                case RoomObjectWidgetRequestEvent.ROOM_OBJECT_WIDGET_REQUEST_CREDITFURNI:
                case RoomObjectWidgetRequestEvent.REOE_WIDGET_REQUEST_STICKIE:
                case RoomObjectWidgetRequestEvent.REOE_WIDGET_REQUEST_PRESENT:
                case RoomObjectWidgetRequestEvent.REOE_WIDGET_REQUEST_TROPHY:
                case RoomObjectWidgetRequestEvent.REOE_WIDGET_REQUEST_TEASER:
                case RoomObjectWidgetRequestEvent.REOE_WIDGET_REQUEST_ECOTRONBOX:
                case RoomObjectWidgetRequestEvent.REOE_WIDGET_REQUEST_DIMMER:
                case RoomObjectWidgetRequestEvent.REOR_REMOVE_DIMMER:
                case RoomObjectWidgetRequestEvent.REOR_REQUEST_CLOTHING_CHANGE:
                case RoomObjectWidgetRequestEvent.REOR_WIDGET_REQUEST_PLAYLIST_EDITOR:
                    this.handleObjectWidgetRequestEvent(_arg_1, _arg_2, _arg_3);
                    return;
                case RoomObjectFurnitureActionEvent.ROFCAE_DICE_ACTIVATE:
                case RoomObjectFurnitureActionEvent.ROFCAE_DICE_OFF:
                case RoomObjectFurnitureActionEvent.ROFCAE_USE_HABBOWHEEL:
                case RoomObjectFurnitureActionEvent.ROFCAE_STICKIE:
                case RoomObjectFurnitureActionEvent.ROFCAE_VIRAL_GIFT:
                case RoomObjectFurnitureActionEvent.ROFCAE_ENTER_ONEWAYDOOR:
                case RoomObjectFurnitureActionEvent.ROFCAE_QUEST_VENDING:
                    this.handleObjectActionEvent(_arg_1, _arg_2, _arg_3);
                    return;
                case RoomObjectFurnitureActionEvent.ROFCAE_SOUND_MACHINE_INIT:
                case RoomObjectFurnitureActionEvent.ROFCAE_SOUND_MACHINE_START:
                case RoomObjectFurnitureActionEvent.ROFCAE_SOUND_MACHINE_STOP:
                case RoomObjectFurnitureActionEvent.ROFCAE_SOUND_MACHINE_DISPOSE:
                    this.handleObjectSoundMachineEvent(_arg_1, _arg_2, _arg_3);
                    return;
                case RoomObjectFurnitureActionEvent.ROFCAE_JUKEBOX_INIT:
                case RoomObjectFurnitureActionEvent.ROFCAE_JUKEBOX_START:
                case RoomObjectFurnitureActionEvent.ROFCAE_JUKEBOX_MACHINE_STOP:
                case RoomObjectFurnitureActionEvent.ROFCAE_JUKEBOX_DISPOSE:
                    this.handleObjectJukeboxEvent(_arg_1, _arg_2, _arg_3);
                    return;
                case RoomObjectFloorHoleEvent.RORPFHUM_ADD:
                case RoomObjectFloorHoleEvent.RORPFHUM_REMOVE:
                    this.handleObjectFloorHoleEvent(_arg_1, _arg_2, _arg_3);
                    return;
                case RoomObjectRoomAdEvent.RORAE_ROOM_AD_FURNI_CLICK:
                case RoomObjectRoomAdEvent.RORAE_ROOM_AD_FURNI_DOUBLE_CLICK:
                case RoomObjectRoomAdEvent.RORAE_ROOM_AD_TOOLTIP_SHOW:
                case RoomObjectRoomAdEvent.RORAE_ROOM_AD_TOOLTIP_HIDE:
                case RoomObjectRoomAdEvent.RORAE_ROOM_AD_LOAD_IMAGE:
                    this.handleObjectRoomAdEvent(_arg_1, _arg_2, _arg_3);
                    return;
                case RoomObjectRoomActionEvent.RORAE_CHANGE_ROOM:
                case RoomObjectRoomActionEvent.RORAE_LEAVE_ROOM:
                case RoomObjectRoomActionEvent.RORAE_TRY_BUS:
                    this.handleRoomActionEvent(_arg_1, _arg_2, _arg_3);
                    return;
                case RoomObjectFurnitureActionEvent.ROFCAE_MOUSE_ARROW:
                case RoomObjectFurnitureActionEvent.ROFCAE_MOUSE_BUTTON:
                    this.handleRoomActionMouseRequestEvent(_arg_1, _arg_2, _arg_3);
                    return;
                default:
                    Logger.log("*** Unhandled room object event in RoomObjectEventHandler::handleRoomObjectEvent !!! ***");
            };
        }
        private function setMouseEventId(_arg_1:int, _arg_2:String, _arg_3:String):void
        {
            var _local_4:Map = (this._eventIds.getValue(String(_arg_1)) as Map);
            if (_local_4 == null){
                _local_4 = new Map();
                this._eventIds.add(_arg_1, _local_4);
            };
            _local_4.remove(_arg_2);
            _local_4.add(_arg_2, _arg_3);
        }
        private function getMouseEventId(_arg_1:int, _arg_2:String):String
        {
            var _local_3:Map = (this._eventIds.getValue(String(_arg_1)) as Map);
            if (_local_3 == null){
                return (null);
            };
            return ((_local_3.getValue(_arg_2) as String));
        }
        private function handleRoomObjectMouseEvent(_arg_1:RoomObjectMouseEvent, _arg_2:int, _arg_3:int):void
        {
            switch (_arg_1.type){
                case RoomObjectMouseEvent.ROE_MOUSE_CLICK:
                    this.handleRoomObjectMouseClick(_arg_1, _arg_2, _arg_3);
                    return;
                case RoomObjectMouseEvent.ROE_MOUSE_MOVE:
                    this.handleRoomObjectMouseMove(_arg_1, _arg_2, _arg_3);
                    return;
                case RoomObjectMouseEvent.ROE_MOUSE_DOWN:
                    this.handleRoomObjectMouseDown(_arg_1, _arg_2, _arg_3);
                    return;
                case RoomObjectMouseEvent.ROE_MOUSE_ENTER:
                    this.handleRoomObjectMouseEnter(_arg_1, _arg_2, _arg_3);
                    return;
                case RoomObjectMouseEvent.ROE_MOUSE_LEAVE:
                    this.handleRoomObjectMouseLeave(_arg_1, _arg_2, _arg_3);
                    return;
            };
        }
        private function handleRoomObjectMouseClick(_arg_1:RoomObjectMouseEvent, _arg_2:int, _arg_3:int):void
        {
            var _local_13:Boolean;
            var _local_14:Boolean;
            var _local_15:String;
            var _local_16:String;
            var _local_17:IEventDispatcher;
            if (_arg_1 == null){
                return;
            };
            var _local_4:String = RoomObjectOperationEnum.OBJECT_UNDEFINED;
            var _local_5:SelectedRoomObjectData = this.getSelectedObjectData(_arg_2, _arg_3);
            if (_local_5 != null){
                _local_4 = _local_5.operation;
            };
            var _local_6:int = _arg_1.objectId;
            var _local_7:String = _arg_1.objectType;
            var _local_8:int = this._roomEngine.getRoomObjectCategory(_local_7);
            var _local_9:int = _local_8;
            var _local_10:String = _arg_1.eventId;
            var _local_11:RoomObjectTileMouseEvent = (_arg_1 as RoomObjectTileMouseEvent);
            var _local_12:RoomObjectWallMouseEvent = (_arg_1 as RoomObjectWallMouseEvent);
            switch (_local_4){
                case RoomObjectOperationEnum.OBJECT_MOVE:
                    if (_local_8 == RoomObjectCategoryEnum._SafeStr_13133){
                        if (_local_5 != null){
                            this.modifyRoomObject(_arg_2, _arg_3, _local_5.id, _local_5.category, RoomObjectOperationEnum.OBJECT_MOVE_TO);
                        };
                    };
                    break;
                case RoomObjectOperationEnum.OBJECT_PLACE:
                    if (_local_8 == RoomObjectCategoryEnum._SafeStr_13133){
                        this.placeObject(_arg_2, _arg_3, !((_local_11 == null)), !((_local_12 == null)));
                    };
                    break;
                case RoomObjectOperationEnum.OBJECT_UNDEFINED:
                    if (_local_8 == RoomObjectCategoryEnum._SafeStr_13133){
                        if (_local_11 != null){
                            this.walkTo((_local_11.tileX + 0.499), (_local_11.tileY + 0.499));
                        };
                    }
                    else {
                        this.setSelectedObject(_arg_2, _arg_3, _local_6, _local_8);
                        _local_13 = false;
                        _local_14 = false;
                        if (_local_8 == RoomObjectCategoryEnum.OBJECT_CATEGORY_USER){
                            if (!this._roomEngine.getIsPlayingGame(this._roomEngine.activeRoomId, this._roomEngine.activeRoomCategory)){
                                _local_13 = true;
                            }
                            else {
                                _local_14 = true;
                            };
                        }
                        else {
                            if ((((_local_8 == RoomObjectCategoryEnum._SafeStr_4329)) || ((_local_8 == RoomObjectCategoryEnum._SafeStr_4330)))){
                                if (((_arg_1.ctrlKey) || (_arg_1.shiftKey))){
                                    if (_arg_1.shiftKey){
                                        if (_local_8 == RoomObjectCategoryEnum._SafeStr_4329){
                                            this.modifyRoomObject(_arg_2, _arg_3, _local_6, _local_8, RoomObjectOperationEnum.OBJECT_ROTATE_POSITIVE);
                                        };
                                    }
                                    else {
                                        this.modifyRoomObject(_arg_2, _arg_3, _local_6, _local_8, RoomObjectOperationEnum.OBJECT_PICKUP);
                                    };
                                    if (!this._roomEngine.getIsPlayingGame(this._roomEngine.activeRoomId, this._roomEngine.activeRoomCategory)){
                                        _local_13 = true;
                                    }
                                    else {
                                        _local_14 = true;
                                    };
                                };
                            };
                        };
                        if (_local_10 != null){
                            if (_local_13){
                                this.setMouseEventId(RoomObjectCategoryEnum._SafeStr_13133, MouseEvent.CLICK, _local_10);
                            };
                            if (_local_14){
                                this.setMouseEventId(RoomObjectCategoryEnum._SafeStr_4962, MouseEvent.CLICK, _local_10);
                            };
                        };
                    };
                    break;
            };
            if (_local_8 == RoomObjectCategoryEnum._SafeStr_13133){
                _local_15 = this.getMouseEventId(RoomObjectCategoryEnum._SafeStr_4962, MouseEvent.CLICK);
                _local_16 = this.getMouseEventId(RoomObjectCategoryEnum.OBJECT_CATEGORY_USER, MouseEvent.CLICK);
                if (((!((_local_15 == _local_10))) && (!((_local_16 == _local_10))))){
                    _local_17 = this._roomEngine.events;
                    if (_local_17 != null){
                        _local_17.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.REOE_OBJECT_DESELECTED, _arg_2, _arg_3, -1, RoomObjectCategoryEnum._SafeStr_4962));
                    };
                    this.setSelectedAvatar(_arg_2, _arg_3, 0, false);
                };
            };
        }
        private function handleRoomObjectMouseMove(_arg_1:RoomObjectMouseEvent, _arg_2:int, _arg_3:int):void
        {
            var _local_8:IRoomObjectController;
            var _local_9:RoomObjectTileMouseEvent;
            var _local_10:RoomObjectUpdateMessage;
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            if (_arg_1 == null){
                return;
            };
            var _local_4:String = RoomObjectOperationEnum.OBJECT_UNDEFINED;
            var _local_5:SelectedRoomObjectData = this.getSelectedObjectData(_arg_2, _arg_3);
            if (_local_5 != null){
                _local_4 = _local_5.operation;
            };
            var _local_6:String = _arg_1.objectType;
            var _local_7:int = this._roomEngine.getRoomObjectCategory(_local_6);
            if (this._roomEngine != null){
                _local_8 = this._roomEngine.getTileCursor(_arg_2, _arg_3);
                if (((!((_local_8 == null))) && (!((_local_8.getEventHandler() == null))))){
                    _local_9 = (_arg_1 as RoomObjectTileMouseEvent);
                    _local_10 = null;
                    if (_local_9 != null){
                        _local_11 = (_local_9.tileX + 0.499);
                        _local_12 = (_local_9.tileY + 0.499);
                        _local_13 = (_local_9.tileZ + 0.499);
                        _local_10 = new RoomObjectUpdateMessage(new Vector3d(_local_11, _local_12, _local_13), null);
                        _local_8.getEventHandler().processUpdateMessage(_local_10);
                        _local_10 = new RoomObjectVisibilityUpdateMessage(RoomObjectVisibilityUpdateMessage.ROVUM_ENABLED);
                    }
                    else {
                        _local_10 = new RoomObjectVisibilityUpdateMessage(RoomObjectVisibilityUpdateMessage.ROVUM_DISABLED);
                    };
                    _local_8.getEventHandler().processUpdateMessage(_local_10);
                };
            };
            switch (_local_4){
                case RoomObjectOperationEnum.OBJECT_MOVE:
                    if (_local_7 == RoomObjectCategoryEnum._SafeStr_13133){
                        this.handleObjectMove(_arg_1, _arg_2, _arg_3);
                    };
                    return;
                case RoomObjectOperationEnum.OBJECT_PLACE:
                    if (_local_7 == RoomObjectCategoryEnum._SafeStr_13133){
                        this.handleObjectPlace(_arg_1, _arg_2, _arg_3);
                    };
            };
        }
        private function handleRoomObjectMouseEnter(_arg_1:RoomObjectMouseEvent, _arg_2:int, _arg_3:int):void
        {
            var _local_4:IEventDispatcher = this._roomEngine.events;
            if (_local_4 != null){
                _local_4.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.ROE_MOUSE_ENTER, _arg_2, _arg_3, _arg_1.objectId, this._roomEngine.getRoomObjectCategory(_arg_1.objectType)));
            };
        }
        private function handleRoomObjectMouseLeave(_arg_1:RoomObjectMouseEvent, _arg_2:int, _arg_3:int):void
        {
            var _local_4:IEventDispatcher = this._roomEngine.events;
            if (_local_4 != null){
                _local_4.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.ROE_MOUSE_LEAVE, _arg_2, _arg_3, _arg_1.objectId, this._roomEngine.getRoomObjectCategory(_arg_1.objectType)));
            };
        }
        private function handleRoomObjectMouseDown(_arg_1:RoomObjectMouseEvent, _arg_2:int, _arg_3:int):void
        {
            var _local_10:IEventDispatcher;
            if (_arg_1 == null){
                return;
            };
            var _local_4:String = RoomObjectOperationEnum.OBJECT_UNDEFINED;
            var _local_5:SelectedRoomObjectData = this.getSelectedObjectData(_arg_2, _arg_3);
            if (_local_5 != null){
                _local_4 = _local_5.operation;
            };
            var _local_6:int = _arg_1.objectId;
            var _local_7:String = _arg_1.objectType;
            var _local_8:int = this._roomEngine.getRoomObjectCategory(_local_7);
            var _local_9:int = _local_8;
            switch (_local_4){
                case RoomObjectOperationEnum.OBJECT_UNDEFINED:
                    if ((((_local_8 == RoomObjectCategoryEnum._SafeStr_4329)) || ((_local_8 == RoomObjectCategoryEnum._SafeStr_4330)))){
                        if (_arg_1.altKey){
                            _local_10 = this._roomEngine.events;
                            if (_local_10 != null){
                                _local_10.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.REOB_OBJECT_REQUEST_MOVE, _arg_2, _arg_3, _local_6, _local_8));
                            };
                        };
                    };
                    return;
            };
        }
        private function handleObjectMove(_arg_1:RoomObjectMouseEvent, _arg_2:int, _arg_3:int):void
        {
            var _local_7:Boolean;
            var _local_8:TileHeightMap;
            var _local_9:RoomObjectTileMouseEvent;
            var _local_10:RoomObjectWallMouseEvent;
            var _local_11:IVector3d;
            var _local_12:IVector3d;
            var _local_13:IVector3d;
            var _local_14:Number;
            var _local_15:Number;
            var _local_16:Number;
            if ((((_arg_1 == null)) || ((this._roomEngine == null)))){
                return;
            };
            var _local_4:IEventDispatcher = this._roomEngine.events;
            if (_local_4 == null){
                return;
            };
            var _local_5:SelectedRoomObjectData = this.getSelectedObjectData(_arg_2, _arg_3);
            if (_local_5 == null){
                return;
            };
            var _local_6:IRoomObjectController = (this._roomEngine.getRoomObject(_arg_2, _arg_3, _local_5.id, _local_5.category) as IRoomObjectController);
            if (_local_6 != null){
                _local_7 = true;
                if (_local_5.category == RoomObjectCategoryEnum._SafeStr_4329){
                    _local_8 = this._roomEngine.getTileHeightMap(_arg_2, _arg_3);
                    _local_9 = (_arg_1 as RoomObjectTileMouseEvent);
                    if (!((!((_local_9 == null))) && (this.handleFurnitureMove(_local_6, _local_5, (_local_9.tileX + 0.5), (_local_9.tileY + 0.5), _local_8)))){
                        this.handleFurnitureMove(_local_6, _local_5, _local_5.loc.x, _local_5.loc.y, _local_8);
                        _local_7 = false;
                    };
                }
                else {
                    if (_local_5.category == RoomObjectCategoryEnum._SafeStr_4330){
                        _local_7 = false;
                        _local_10 = (_arg_1 as RoomObjectWallMouseEvent);
                        if (_local_10 != null){
                            _local_11 = _local_10.wallLocation;
                            _local_12 = _local_10.wallWidth;
                            _local_13 = _local_10.wallHeight;
                            _local_14 = _local_10.x;
                            _local_15 = _local_10.y;
                            _local_16 = _local_10.direction;
                            if (this.handleWallItemMove(_local_6, _local_5, _local_11, _local_12, _local_13, _local_14, _local_15, _local_16)){
                                _local_7 = true;
                            };
                        };
                        if (!_local_7){
                            _local_6.setLocation(_local_5.loc);
                            _local_6.setDirection(_local_5.dir);
                        };
                        this._roomEngine.updateObjectRoomWindow(_arg_2, _arg_3, _local_5.id, _local_7);
                    };
                };
                if (_local_7){
                    this.setObjectAlphaMultiplier(_local_6, 0.5);
                    this._roomEngine.setObjectMoverIconSpriteVisible(false);
                }
                else {
                    this.setObjectAlphaMultiplier(_local_6, 0);
                    this._roomEngine.setObjectMoverIconSpriteVisible(true);
                };
            };
        }
        private function handleObjectPlace(_arg_1:RoomObjectMouseEvent, _arg_2:int, _arg_3:int):void
        {
            var _local_9:Array;
            var _local_10:IVector3d;
            var _local_11:Boolean;
            var _local_12:TileHeightMap;
            var _local_13:IVector3d;
            var _local_14:IVector3d;
            var _local_15:IVector3d;
            var _local_16:Number;
            var _local_17:Number;
            var _local_18:Number;
            if ((((_arg_1 == null)) || ((this._roomEngine == null)))){
                return;
            };
            var _local_4:IEventDispatcher = this._roomEngine.events;
            if (_local_4 == null){
                return;
            };
            var _local_5:SelectedRoomObjectData = this.getSelectedObjectData(_arg_2, _arg_3);
            if (_local_5 == null){
                return;
            };
            var _local_6:IRoomObjectController = (this._roomEngine.getRoomObject(_arg_2, _arg_3, _local_5.id, _local_5.category) as IRoomObjectController);
            var _local_7:RoomObjectTileMouseEvent = (_arg_1 as RoomObjectTileMouseEvent);
            var _local_8:RoomObjectWallMouseEvent = (_arg_1 as RoomObjectWallMouseEvent);
            if (_local_6 == null){
                if ((((_local_5.category == RoomObjectCategoryEnum._SafeStr_4329)) && (!((_local_7 == null))))){
                    this._roomEngine.addObjectFurniture(_arg_2, _arg_3, _local_5.id, _local_5.typeId, _local_5.loc, _local_5.dir, 0, null, Number(_local_5.instanceData));
                }
                else {
                    if ((((_local_5.category == RoomObjectCategoryEnum._SafeStr_4330)) && (!((_local_8 == null))))){
                        this._roomEngine.addObjectWallItem(_arg_2, _arg_3, _local_5.id, _local_5.typeId, _local_5.loc, _local_5.dir, 0, _local_5.instanceData, false);
                    }
                    else {
                        if ((((_local_5.category == RoomObjectCategoryEnum.OBJECT_CATEGORY_USER)) && (!((_local_7 == null))))){
                            this._roomEngine.addObjectUser(_arg_2, _arg_3, _local_5.id, new Vector3d(), new Vector3d(180), 180, _local_5.typeId, _local_5.instanceData);
                        };
                    };
                };
                _local_6 = (this._roomEngine.getRoomObject(_arg_2, _arg_3, _local_5.id, _local_5.category) as IRoomObjectController);
                if (_local_6 != null){
                    if (_local_5.category == RoomObjectCategoryEnum._SafeStr_4329){
                        if (_local_6.getModel() != null){
                            _local_9 = _local_6.getModel().getNumberArray(RoomObjectVariableEnum._SafeStr_12446);
                            if (((!((_local_9 == null))) && ((_local_9.length > 0)))){
                                _local_10 = new Vector3d(_local_9[0]);
                                _local_6.setDirection(_local_10);
                                this.updateSelectedObjectData(_arg_2, _arg_3, _local_5.id, _local_5.category, _local_5.loc, _local_10, _local_5.operation, _local_5.typeId, _local_5.instanceData);
                                _local_5 = this.getSelectedObjectData(_arg_2, _arg_3);
                                if (_local_5 == null){
                                    return;
                                };
                            };
                        };
                    };
                };
                this.setObjectAlphaMultiplier(_local_6, 0.5);
                this._roomEngine.setObjectMoverIconSpriteVisible(true);
            };
            if (_local_6 != null){
                _local_11 = true;
                _local_12 = this._roomEngine.getTileHeightMap(_arg_2, _arg_3);
                if (_local_5.category == RoomObjectCategoryEnum._SafeStr_4329){
                    if (!((!((_local_7 == null))) && (this.handleFurnitureMove(_local_6, _local_5, (_local_7.tileX + 0.5), (_local_7.tileY + 0.5), _local_12)))){
                        this._roomEngine.disposeObjectFurniture(_arg_2, _arg_3, _local_5.id);
                        _local_11 = false;
                    };
                }
                else {
                    if (_local_5.category == RoomObjectCategoryEnum._SafeStr_4330){
                        _local_11 = false;
                        if (_local_8 != null){
                            _local_13 = _local_8.wallLocation;
                            _local_14 = _local_8.wallWidth;
                            _local_15 = _local_8.wallHeight;
                            _local_16 = _local_8.x;
                            _local_17 = _local_8.y;
                            _local_18 = _local_8.direction;
                            if (this.handleWallItemMove(_local_6, _local_5, _local_13, _local_14, _local_15, _local_16, _local_17, _local_18)){
                                _local_11 = true;
                            };
                        };
                        if (!_local_11){
                            this._roomEngine.disposeObjectWallItem(_arg_2, _arg_3, _local_5.id);
                        };
                        this._roomEngine.updateObjectRoomWindow(_arg_2, _arg_3, _local_5.id, _local_11);
                    }
                    else {
                        if (_local_5.category == RoomObjectCategoryEnum.OBJECT_CATEGORY_USER){
                            if (!((!((_local_7 == null))) && (this.handleUserMove(_local_6, _local_5, (_local_7.tileX + 0.5), (_local_7.tileY + 0.5), _local_12)))){
                                this._roomEngine.disposeObjectUser(_arg_2, _arg_3, _local_5.id);
                                _local_11 = false;
                            };
                        };
                    };
                };
                this._roomEngine.setObjectMoverIconSpriteVisible(!(_local_11));
            };
        }
        private function handleObjectStateChange(_arg_1:RoomObjectStateChangeEvent, _arg_2:int, _arg_3:int):void
        {
            if (_arg_1 == null){
                return;
            };
            this.changeObjectState(_arg_2, _arg_3, _arg_1.objectId, _arg_1.objectType, _arg_1.param, false);
        }
        private function handleObjectRandomStateChange(_arg_1:RoomObjectStateChangeEvent, _arg_2:int, _arg_3:int):void
        {
            if (_arg_1 == null){
                return;
            };
            this.changeObjectState(_arg_2, _arg_3, _arg_1.objectId, _arg_1.objectType, _arg_1.param, true);
        }
        private function handleObjectWidgetRequestEvent(_arg_1:RoomObjectEvent, _arg_2:int, _arg_3:int):void
        {
            if ((((this._roomEngine == null)) || ((_arg_1 == null)))){
                return;
            };
            var _local_4:int = _arg_1.objectId;
            var _local_5:String = _arg_1.objectType;
            var _local_6:int = this._roomEngine.getRoomObjectCategory(_local_5);
            var _local_7:IEventDispatcher = this._roomEngine.events;
            if (_local_7 != null){
                switch (_arg_1.type){
                    case RoomObjectWidgetRequestEvent.REOE_WIDGET_REQUEST_PLACEHOLDER:
                        _local_7.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.REOE_WIDGET_REQUEST_PLACEHOLDER, _arg_2, _arg_3, _local_4, _local_6));
                        return;
                    case RoomObjectWidgetRequestEvent.ROOM_OBJECT_WIDGET_REQUEST_CREDITFURNI:
                        _local_7.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.ROOM_OBJECT_WIDGET_REQUEST_CREDITFURNI, _arg_2, _arg_3, _local_4, _local_6));
                        return;
                    case RoomObjectWidgetRequestEvent.REOE_WIDGET_REQUEST_STICKIE:
                        _local_7.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.REOE_WIDGET_REQUEST_STICKIE, _arg_2, _arg_3, _local_4, _local_6));
                        return;
                    case RoomObjectWidgetRequestEvent.REOE_WIDGET_REQUEST_PRESENT:
                        _local_7.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.REOE_WIDGET_REQUEST_PRESENT, _arg_2, _arg_3, _local_4, _local_6));
                        return;
                    case RoomObjectWidgetRequestEvent.REOE_WIDGET_REQUEST_TROPHY:
                        _local_7.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.REOE_WIDGET_REQUEST_TROPHY, _arg_2, _arg_3, _local_4, _local_6));
                        return;
                    case RoomObjectWidgetRequestEvent.REOE_WIDGET_REQUEST_TEASER:
                        _local_7.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.REOE_WIDGET_REQUEST_TEASER, _arg_2, _arg_3, _local_4, _local_6));
                        return;
                    case RoomObjectWidgetRequestEvent.REOE_WIDGET_REQUEST_ECOTRONBOX:
                        _local_7.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.REOE_WIDGET_REQUEST_ECOTRONBOX, _arg_2, _arg_3, _local_4, _local_6));
                        return;
                    case RoomObjectWidgetRequestEvent.REOE_WIDGET_REQUEST_DIMMER:
                        _local_7.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.REOE_WIDGET_REQUEST_DIMMER, _arg_2, _arg_3, _local_4, _local_6));
                        return;
                    case RoomObjectWidgetRequestEvent.REOR_REMOVE_DIMMER:
                        _local_7.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.REOR_REMOVE_DIMMER, _arg_2, _arg_3, _local_4, _local_6));
                        return;
                    case RoomObjectWidgetRequestEvent.REOR_REQUEST_CLOTHING_CHANGE:
                        _local_7.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.REOR_REQUEST_CLOTHING_CHANGE, _arg_2, _arg_3, _local_4, _local_6));
                        return;
                    case RoomObjectWidgetRequestEvent.REOR_WIDGET_REQUEST_PLAYLIST_EDITOR:
                        _local_7.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.REOR_WIDGET_REQUEST_PLAYLIST_EDITOR, _arg_2, _arg_3, _local_4, _local_6));
                        return;
                };
            };
        }
        private function handleObjectRoomAdEvent(_arg_1:RoomObjectEvent, _arg_2:int, _arg_3:int):void
        {
            var _local_7:String;
            var _local_8:RoomObjectRoomAdEvent;
            if ((((((this._roomEngine == null)) || ((this._roomEngine.events == null)))) || ((_arg_1 == null)))){
                return;
            };
            var _local_4:int = _arg_1.objectId;
            var _local_5:String = _arg_1.objectType;
            var _local_6:int = this._roomEngine.getRoomObjectCategory(_local_5);
            switch (_arg_1.type){
                case RoomObjectRoomAdEvent.RORAE_ROOM_AD_FURNI_CLICK:
                    this._roomEngine.events.dispatchEvent(_arg_1);
                    _local_7 = RoomEngineObjectEvent.REOE_ROOM_AD_FURNI_CLICK;
                    break;
                case RoomObjectRoomAdEvent.RORAE_ROOM_AD_FURNI_DOUBLE_CLICK:
                    _local_7 = RoomEngineObjectEvent.REOE_ROOM_AD_FURNI_DOUBLE_CLICK;
                    break;
                case RoomObjectRoomAdEvent.RORAE_ROOM_AD_TOOLTIP_SHOW:
                    _local_7 = RoomEngineObjectEvent.REOE_ROOM_AD_TOOLTIP_SHOW;
                    break;
                case RoomObjectRoomAdEvent.RORAE_ROOM_AD_TOOLTIP_HIDE:
                    _local_7 = RoomEngineObjectEvent.REOE_ROOM_AD_TOOLTIP_HIDE;
                    break;
                case RoomObjectRoomAdEvent.RORAE_ROOM_AD_LOAD_IMAGE:
                    if ((_arg_1 is RoomObjectRoomAdEvent)){
                        _local_8 = (_arg_1 as RoomObjectRoomAdEvent);
                        this._roomEngine.requestRoomAdImage(_arg_2, _arg_3, _local_4, _local_6, _local_8.imageUrl, _local_8.clickUrl);
                    };
                    break;
            };
            if (_local_7 == null){
                return;
            };
            this._roomEngine.events.dispatchEvent(new RoomEngineObjectEvent(_local_7, _arg_2, _arg_3, _local_4, _local_6));
        }
        private function handleObjectActionEvent(_arg_1:RoomObjectEvent, _arg_2:int, _arg_3:int):void
        {
            if (_arg_1 == null){
                return;
            };
            this.useObject(_arg_2, _arg_3, _arg_1.objectId, _arg_1.objectType, _arg_1.type);
        }
        private function handleObjectSoundMachineEvent(_arg_1:RoomObjectEvent, _arg_2:int, _arg_3:int):void
        {
            if (_arg_1 == null){
                return;
            };
            var _local_4:int = this._roomEngine.getRoomObjectCategory(_arg_1.objectType);
            var _local_5:SelectedRoomObjectData = this.getSelectedObjectData(_arg_2, _arg_3);
            if (_local_5 != null){
                if ((((_local_5.category == _local_4)) && ((_local_5.id == _arg_1.objectId)))){
                    if (_local_5.operation == RoomObjectOperationEnum.OBJECT_PLACE){
                        return;
                    };
                };
            };
            switch (_arg_1.type){
                case RoomObjectFurnitureActionEvent.ROFCAE_SOUND_MACHINE_INIT:
                    this._roomEngine.events.dispatchEvent(new RoomEngineSoundMachineEvent(RoomEngineSoundMachineEvent.ROSM_SOUND_MACHINE_INIT, _arg_2, _arg_3, _arg_1.objectId, _local_4));
                    return;
                case RoomObjectFurnitureActionEvent.ROFCAE_SOUND_MACHINE_START:
                    this._roomEngine.events.dispatchEvent(new RoomEngineSoundMachineEvent(RoomEngineSoundMachineEvent.ROSM_SOUND_MACHINE_SWITCHED_ON, _arg_2, _arg_3, _arg_1.objectId, _local_4));
                    return;
                case RoomObjectFurnitureActionEvent.ROFCAE_SOUND_MACHINE_STOP:
                    this._roomEngine.events.dispatchEvent(new RoomEngineSoundMachineEvent(RoomEngineSoundMachineEvent.ROSM_SOUND_MACHINE_SWITCHED_OFF, _arg_2, _arg_3, _arg_1.objectId, _local_4));
                    return;
                case RoomObjectFurnitureActionEvent.ROFCAE_SOUND_MACHINE_DISPOSE:
                    this._roomEngine.events.dispatchEvent(new RoomEngineSoundMachineEvent(RoomEngineSoundMachineEvent.ROSM_SOUND_MACHINE_DISPOSE, _arg_2, _arg_3, _arg_1.objectId, _local_4));
                    return;
            };
        }
        private function handleObjectJukeboxEvent(_arg_1:RoomObjectEvent, _arg_2:int, _arg_3:int):void
        {
            if (_arg_1 == null){
                return;
            };
            var _local_4:int = this._roomEngine.getRoomObjectCategory(_arg_1.objectType);
            var _local_5:SelectedRoomObjectData = this.getSelectedObjectData(_arg_2, _arg_3);
            if (_local_5 != null){
                if ((((_local_5.category == _local_4)) && ((_local_5.id == _arg_1.objectId)))){
                    if (_local_5.operation == RoomObjectOperationEnum.OBJECT_PLACE){
                        return;
                    };
                };
            };
            switch (_arg_1.type){
                case RoomObjectFurnitureActionEvent.ROFCAE_JUKEBOX_INIT:
                    this._roomEngine.events.dispatchEvent(new RoomEngineSoundMachineEvent(RoomEngineSoundMachineEvent.ROSM_JUKEBOX_INIT, _arg_2, _arg_3, _arg_1.objectId, _local_4));
                    return;
                case RoomObjectFurnitureActionEvent.ROFCAE_JUKEBOX_START:
                    this._roomEngine.events.dispatchEvent(new RoomEngineSoundMachineEvent(RoomEngineSoundMachineEvent.ROSM_JUKEBOX_SWITCHED_ON, _arg_2, _arg_3, _arg_1.objectId, _local_4));
                    return;
                case RoomObjectFurnitureActionEvent.ROFCAE_JUKEBOX_MACHINE_STOP:
                    this._roomEngine.events.dispatchEvent(new RoomEngineSoundMachineEvent(RoomEngineSoundMachineEvent.ROSM_JUKEBOX_SWITCHED_OFF, _arg_2, _arg_3, _arg_1.objectId, _local_4));
                    return;
                case RoomObjectFurnitureActionEvent.ROFCAE_JUKEBOX_DISPOSE:
                    this._roomEngine.events.dispatchEvent(new RoomEngineSoundMachineEvent(RoomEngineSoundMachineEvent.ROSM_JUKEBOX_DISPOSE, _arg_2, _arg_3, _arg_1.objectId, _local_4));
                    return;
            };
        }
        private function handleObjectFloorHoleEvent(_arg_1:RoomObjectEvent, _arg_2:int, _arg_3:int):void
        {
            if (_arg_1 == null){
                return;
            };
            switch (_arg_1.type){
                case RoomObjectFloorHoleEvent.RORPFHUM_ADD:
                    this._roomEngine.addFloorHole(_arg_2, _arg_3, _arg_1.objectId);
                    return;
                case RoomObjectFloorHoleEvent.RORPFHUM_REMOVE:
                    this._roomEngine.removeFloorHole(_arg_2, _arg_3, _arg_1.objectId);
                    return;
            };
        }
        private function handleRoomActionEvent(_arg_1:RoomObjectEvent, _arg_2:int, _arg_3:int):void
        {
            var _local_4:RoomObjectRoomActionEvent;
            if (_arg_1 == null){
                return;
            };
            if (((!((this._roomEngine == null))) && (!((this._roomEngine.connection == null))))){
                switch (_arg_1.type){
                    case RoomObjectRoomActionEvent.RORAE_CHANGE_ROOM:
                        _local_4 = (_arg_1 as RoomObjectRoomActionEvent);
                        if (_local_4 != null){
                            this._roomEngine.connection.send(new ChangeRoomMessageComposer(_local_4.param));
                        };
                        return;
                    case RoomObjectRoomActionEvent.RORAE_TRY_BUS:
                        this._roomEngine.connection.send(new TryBusMessageComposer());
                        return;
                };
            };
        }
        private function handleRoomActionMouseRequestEvent(_arg_1:RoomObjectEvent, _arg_2:int, _arg_3:int):void
        {
            this._roomEngine.requestMouseCursor(_arg_1.type, _arg_1.objectId, _arg_1.objectType);
        }
        private function handleObjectInitializeEvent(_arg_1:RoomObjectEvent, _arg_2:int, _arg_3:int):void
        {
            if (_arg_1 == null){
                return;
            };
            this.initializeObject(_arg_2, _arg_3, _arg_1.objectId, _arg_1.objectType, _arg_1.type);
        }
        private function handleObjectDimmerStateEvent(_arg_1:RoomObjectEvent, _arg_2:int, _arg_3:int):void
        {
            var _local_5:RoomObjectDimmerStateUpdateEvent;
            var _local_6:RoomEngineDimmerStateEvent;
            var _local_4:int = _arg_1.objectId;
            if (((!((this._roomEngine == null))) && (!((this._roomEngine.connection == null))))){
                switch (_arg_1.type){
                    case RoomObjectDimmerStateUpdateEvent.RWDSUE_DIMMER_STATE:
                        _local_5 = (_arg_1 as RoomObjectDimmerStateUpdateEvent);
                        if (_local_5 != null){
                            _local_6 = new RoomEngineDimmerStateEvent(_arg_2, _arg_3, _local_5.state, _local_5.presetId, _local_5.effectId, _local_5.color, _local_5.brightness);
                            this._roomEngine.events.dispatchEvent(_local_6);
                        };
                        return;
                };
            };
        }
        private function handleSelectedObjectMove(_arg_1:RoomObjectEvent, _arg_2:int, _arg_3:int):void
        {
            var _local_9:IVector3d;
            var _local_10:RoomObjectUpdateMessage;
            if (this._roomEngine == null){
                return;
            };
            var _local_4:int = _arg_1.objectId;
            var _local_5:String = _arg_1.objectType;
            var _local_6:int = this._roomEngine.getRoomObjectCategory(_local_5);
            var _local_7:IRoomObjectController = (this._roomEngine.getRoomObject(_arg_2, _arg_3, _local_4, _local_6) as IRoomObjectController);
            var _local_8:IRoomObjectController = this._roomEngine.getSelectionArrow(_arg_2, _arg_3);
            if (((((!((_local_7 == null))) && (!((_local_8 == null))))) && (!((_local_8.getEventHandler() == null))))){
                _local_9 = _local_7.getLocation();
                _local_10 = new RoomObjectUpdateMessage(_local_9, null);
                _local_8.getEventHandler().processUpdateMessage(_local_10);
            };
        }
        private function handleSelectedObjectRemove(_arg_1:RoomObjectEvent, _arg_2:int, _arg_3:int):void
        {
            this.setSelectedAvatar(_arg_2, _arg_3, 0, false);
        }
        private function handleFurnitureMove(_arg_1:IRoomObjectController, _arg_2:SelectedRoomObjectData, _arg_3:int, _arg_4:int, _arg_5:TileHeightMap):Boolean
        {
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return (false);
            };
            var _local_6:Vector3d = new Vector3d();
            _local_6.assign(_arg_1.getDirection());
            _arg_1.setDirection(_arg_2.dir);
            var _local_7:Vector3d = new Vector3d(_arg_3, _arg_4, 0);
            var _local_8:Vector3d = new Vector3d();
            _local_8.assign(_arg_1.getDirection());
            var _local_9:Vector3d = this.validateFurnitureLocation(_arg_1, _local_7, _arg_2.loc, _arg_2.dir, _arg_5);
            if (_local_9 == null){
                _local_8.x = this.getValidFurnitureDirection(_arg_1, true);
                _arg_1.setDirection(_local_8);
                _local_9 = this.validateFurnitureLocation(_arg_1, _local_7, _arg_2.loc, _arg_2.dir, _arg_5);
            };
            if (_local_9 == null){
                _arg_1.setDirection(_local_6);
                return (false);
            };
            _arg_1.setLocation(_local_9);
            if (_local_8){
                _arg_1.setDirection(_local_8);
            };
            return (true);
        }
        private function handleWallItemMove(_arg_1:IRoomObjectController, _arg_2:SelectedRoomObjectData, _arg_3:IVector3d, _arg_4:IVector3d, _arg_5:IVector3d, _arg_6:Number, _arg_7:Number, _arg_8:Number):Boolean
        {
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return (false);
            };
            var _local_9:Vector3d = new Vector3d(_arg_8);
            var _local_10:Vector3d = this.validateWallItemLocation(_arg_1, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_2);
            if (_local_10 == null){
                return (false);
            };
            _arg_1.setLocation(_local_10);
            _arg_1.setDirection(_local_9);
            return (true);
        }
        private function handleUserMove(_arg_1:IRoomObjectController, _arg_2:SelectedRoomObjectData, _arg_3:int, _arg_4:int, _arg_5:TileHeightMap):Boolean
        {
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return (false);
            };
            var _local_6:Vector3d = new Vector3d(_arg_3, _arg_4, 0);
            var _local_7:Vector3d = this.validateUserLocation(_arg_1, _local_6, _arg_2.loc, _arg_2.dir, _arg_5);
            if (_local_7 == null){
                return (false);
            };
            _arg_1.setLocation(_local_7);
            return (true);
        }
        private function validateFurnitureDirection(_arg_1:IRoomObject, _arg_2:IVector3d, _arg_3:TileHeightMap):Boolean
        {
            if ((((((_arg_1 == null)) || ((_arg_1.getModel() == null)))) || ((_arg_2 == null)))){
                return (false);
            };
            var _local_4:IVector3d = _arg_1.getDirection();
            var _local_5:IVector3d = _arg_1.getLocation();
            if ((((_local_4 == null)) || ((_local_5 == null)))){
                return (false);
            };
            if ((_local_4.x % 180) == (_arg_2.x % 180)){
                return (true);
            };
            var _local_6:int = _arg_1.getModel().getNumber(RoomObjectVariableEnum._SafeStr_12442);
            var _local_7:int = _arg_1.getModel().getNumber(RoomObjectVariableEnum._SafeStr_12443);
            if (_local_6 < 1){
                _local_6 = 1;
            };
            if (_local_7 < 1){
                _local_7 = 1;
            };
            var _local_8:int = _local_6;
            var _local_9:int = _local_7;
            var _local_10:int;
            var _local_11:int = ((int((_arg_2.x + 45)) % 360) / 90);
            if ((((_local_11 == 1)) || ((_local_11 == 3)))){
                _local_10 = _local_6;
                _local_6 = _local_7;
                _local_7 = _local_10;
            };
            _local_11 = ((int((_local_4.x + 45)) % 360) / 90);
            if ((((_local_11 == 1)) || ((_local_11 == 3)))){
                _local_10 = _local_8;
                _local_8 = _local_9;
                _local_9 = _local_10;
            };
            if (((!((_arg_3 == null))) && (!((_local_5 == null))))){
                if (_arg_3.validateLocation(_local_5.x, _local_5.y, _local_6, _local_7, _local_5.x, _local_5.y, _local_8, _local_9)){
                    return (true);
                };
                return (false);
            };
            return (false);
        }
        private function validateFurnitureLocation(_arg_1:IRoomObject, _arg_2:IVector3d, _arg_3:IVector3d, _arg_4:IVector3d, _arg_5:TileHeightMap):Vector3d
        {
            var _local_15:Vector3d;
            if ((((((_arg_1 == null)) || ((_arg_1.getModel() == null)))) || ((_arg_2 == null)))){
                return (null);
            };
            var _local_6:IVector3d = _arg_1.getDirection();
            if (_local_6 == null){
                return (null);
            };
            if ((((_arg_3 == null)) || ((_arg_4 == null)))){
                return (null);
            };
            if ((((_arg_2.x == _arg_3.x)) && ((_arg_2.y == _arg_3.y)))){
                if (_local_6.x == _arg_4.x){
                    _local_15 = new Vector3d();
                    _local_15.assign(_arg_3);
                    return (_local_15);
                };
            };
            var _local_7:int = _arg_1.getModel().getNumber(RoomObjectVariableEnum._SafeStr_12442);
            var _local_8:int = _arg_1.getModel().getNumber(RoomObjectVariableEnum._SafeStr_12443);
            if (_local_7 < 1){
                _local_7 = 1;
            };
            if (_local_8 < 1){
                _local_8 = 1;
            };
            var _local_9:int = _arg_3.x;
            var _local_10:int = _arg_3.y;
            var _local_11:int = _local_7;
            var _local_12:int = _local_8;
            var _local_13:int;
            var _local_14:int = ((int((_local_6.x + 45)) % 360) / 90);
            if ((((_local_14 == 1)) || ((_local_14 == 3)))){
                _local_13 = _local_7;
                _local_7 = _local_8;
                _local_8 = _local_13;
            };
            _local_14 = ((int((_arg_4.x + 45)) % 360) / 90);
            if ((((_local_14 == 1)) || ((_local_14 == 3)))){
                _local_13 = _local_11;
                _local_11 = _local_12;
                _local_12 = _local_13;
            };
            if (((!((_arg_5 == null))) && (!((_arg_2 == null))))){
                if (_arg_5.validateLocation(_arg_2.x, _arg_2.y, _local_7, _local_8, _local_9, _local_10, _local_11, _local_12)){
                    return (new Vector3d(_arg_2.x, _arg_2.y, _arg_5.getTileHeight(_arg_2.x, _arg_2.y)));
                };
                return (null);
            };
            return (null);
        }
        private function validateWallItemLocation(_arg_1:IRoomObject, _arg_2:IVector3d, _arg_3:IVector3d, _arg_4:IVector3d, _arg_5:Number, _arg_6:Number, _arg_7:SelectedRoomObjectData):Vector3d
        {
            if ((((((((((((_arg_1 == null)) || ((_arg_1.getModel() == null)))) || ((_arg_2 == null)))) || ((_arg_3 == null)))) || ((_arg_4 == null)))) || ((_arg_7 == null)))){
                return (null);
            };
            var _local_8:Number = _arg_1.getModel().getNumber(RoomObjectVariableEnum._SafeStr_12442);
            var _local_9:Number = _arg_1.getModel().getNumber(RoomObjectVariableEnum._SafeStr_4992);
            var _local_10:Number = _arg_1.getModel().getNumber(RoomObjectVariableEnum._SafeStr_4993);
            if ((((((((_arg_5 < (_local_8 / 2))) || ((_arg_5 > (_arg_3.length - (_local_8 / 2)))))) || ((_arg_6 < _local_10)))) || ((_arg_6 > (_arg_4.length - (_local_9 - _local_10)))))){
                if ((((_arg_5 < (_local_8 / 2))) && ((_arg_5 <= (_arg_3.length - (_local_8 / 2)))))){
                    _arg_5 = (_local_8 / 2);
                }
                else {
                    if ((((_arg_5 >= (_local_8 / 2))) && ((_arg_5 > (_arg_3.length - (_local_8 / 2)))))){
                        _arg_5 = (_arg_3.length - (_local_8 / 2));
                    };
                };
                if ((((_arg_6 < _local_10)) && ((_arg_6 <= (_arg_4.length - (_local_9 - _local_10)))))){
                    _arg_6 = _local_10;
                }
                else {
                    if ((((_arg_6 >= _local_10)) && ((_arg_6 > (_arg_4.length - (_local_9 - _local_10)))))){
                        _arg_6 = (_arg_4.length - (_local_9 - _local_10));
                    };
                };
            };
            if ((((((((_arg_5 < (_local_8 / 2))) || ((_arg_5 > (_arg_3.length - (_local_8 / 2)))))) || ((_arg_6 < _local_10)))) || ((_arg_6 > (_arg_4.length - (_local_9 - _local_10)))))){
                return (null);
            };
            var _local_11:Vector3d = Vector3d.sum(Vector3d.product(_arg_3, (_arg_5 / _arg_3.length)), Vector3d.product(_arg_4, (_arg_6 / _arg_4.length)));
            return (Vector3d.sum(_arg_2, _local_11));
        }
        private function validateUserLocation(_arg_1:IRoomObject, _arg_2:IVector3d, _arg_3:IVector3d, _arg_4:IVector3d, _arg_5:TileHeightMap):Vector3d
        {
            if ((((_arg_2 == null)) || ((_arg_5 == null)))){
                return (null);
            };
            if (_arg_5.isRoomTile(_arg_2.x, _arg_2.y)){
                return (new Vector3d(_arg_2.x, _arg_2.y, _arg_5.getTileHeight(_arg_2.x, _arg_2.y)));
            };
            return (null);
        }
        private function setObjectAlphaMultiplier(_arg_1:IRoomObjectController, _arg_2:Number):void
        {
            if (((!((_arg_1 == null))) && (!((_arg_1.getModelController() == null))))){
                _arg_1.getModelController().setNumber(RoomObjectVariableEnum._SafeStr_5760, _arg_2);
            };
        }
        public function setSelectedAvatar(roomId:int, roomCategory:int, objectId:int, isSelected:Boolean):void
        {
            if (this._roomEngine == null){
                return;
            };
            var category:int = RoomObjectCategoryEnum.OBJECT_CATEGORY_USER;
            var object:IRoomObjectController = (this._roomEngine.getRoomObject(roomId, roomCategory, this._selectedAvatarId, category) as IRoomObjectController);
            if (((!((object == null))) && (!((object.getEventHandler() == null))))){
                object.getEventHandler().processUpdateMessage(new RoomObjectAvatarSelectedMessage(false));
                this._selectedAvatarId = -1;
            };
            var wasSelected:Boolean;
            if (isSelected){
                object = (this._roomEngine.getRoomObject(roomId, roomCategory, objectId, category) as IRoomObjectController);
                if (((!((object == null))) && (!((object.getEventHandler() == null))))){
                    object.getEventHandler().processUpdateMessage(new RoomObjectAvatarSelectedMessage(true));
                    wasSelected = true;
                    this._selectedAvatarId = objectId;
                    try {
                        this._roomEngine.connection.send(new LookToMessageComposer(object.getLocation().x, object.getLocation().y));
                    }
                    catch(e:Error) {
                    };
                };
            };
            var selectionArrow:IRoomObjectController = this._roomEngine.getSelectionArrow(roomId, roomCategory);
            if (((!((selectionArrow == null))) && (!((selectionArrow.getEventHandler() == null))))){
                if (((wasSelected) && (!(this._roomEngine.getIsPlayingGame(this._roomEngine.activeRoomId, this._roomEngine.activeRoomCategory))))){
                    selectionArrow.getEventHandler().processUpdateMessage(new RoomObjectVisibilityUpdateMessage(RoomObjectVisibilityUpdateMessage.ROVUM_ENABLED));
                }
                else {
                    selectionArrow.getEventHandler().processUpdateMessage(new RoomObjectVisibilityUpdateMessage(RoomObjectVisibilityUpdateMessage.ROVUM_DISABLED));
                };
            };
        }
        public function getSelectedAvatarId():int
        {
            return (this._selectedAvatarId);
        }
        private function getValidFurnitureDirection(_arg_1:IRoomObjectController, _arg_2:Boolean):int
        {
            var _local_5:int;
            var _local_6:int;
            if ((((_arg_1 == null)) || ((_arg_1.getModel() == null)))){
                return (0);
            };
            var _local_3:Array;
            if (_arg_1.getModel() != null){
                _local_3 = _arg_1.getModel().getNumberArray(RoomObjectVariableEnum._SafeStr_12446);
            };
            var _local_4:int = _arg_1.getDirection().x;
            if (((!((_local_3 == null))) && ((_local_3.length > 0)))){
                _local_5 = _local_3.indexOf(_local_4);
                if (_local_5 < 0){
                    _local_5 = 0;
                    _local_6 = 0;
                    while (_local_6 < _local_3.length) {
                        if (_local_4 <= _local_3[_local_6]) break;
                        _local_5++;
                        _local_6++;
                    };
                    _local_5 = (_local_5 % _local_3.length);
                };
                if (_arg_2){
                    _local_5 = ((_local_5 + 1) % _local_3.length);
                }
                else {
                    _local_5 = (((_local_5 - 1) + _local_3.length) % _local_3.length);
                };
                _local_4 = _local_3[_local_5];
            };
            return (_local_4);
        }
        public function modifyRoomObjectData(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:String, _arg_6:Map):Boolean
        {
            if (this._roomEngine == null){
                return (false);
            };
            var _local_7:IRoomObjectController = (this._roomEngine.getRoomObject(_arg_1, _arg_2, _arg_3, _arg_4) as IRoomObjectController);
            if (_local_7 == null){
                return (false);
            };
            switch (_arg_5){
                case RoomObjectOperationEnum.OBJECT_SAVE_STUFF_DATA:
                    if (this._roomEngine.connection){
                        this._roomEngine.connection.send(new SetObjectDataMessageComposer(_arg_3, _arg_6));
                    };
                    break;
                default:
                    Logger.log(("could not modify room object data, unknown operation " + _arg_5));
            };
            return (true);
        }
        public function modifyRoomObject(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:String):Boolean
        {
            var _local_11:LegacyWallGeometry;
            var _local_12:String;
            if (this._roomEngine == null){
                return (false);
            };
            var _local_6:IRoomObjectController = (this._roomEngine.getRoomObject(_arg_1, _arg_2, _arg_3, _arg_4) as IRoomObjectController);
            if (_local_6 == null){
                return (false);
            };
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_10:Boolean = true;
            switch (_arg_5){
                case RoomObjectOperationEnum.OBJECT_ROTATE_POSITIVE:
                case RoomObjectOperationEnum.OBJECT_ROTATE_NEGATIVE:
                    if (this._roomEngine.connection){
                        if (_arg_5 == RoomObjectOperationEnum.OBJECT_ROTATE_NEGATIVE){
                            _local_9 = this.getValidFurnitureDirection(_local_6, false);
                        }
                        else {
                            _local_9 = this.getValidFurnitureDirection(_local_6, true);
                        };
                        _local_7 = _local_6.getLocation().x;
                        _local_8 = _local_6.getLocation().y;
                        if (this.validateFurnitureDirection(_local_6, new Vector3d(_local_9), this._roomEngine.getTileHeightMap(_arg_1, _arg_2))){
                            _local_9 = int((_local_9 / 45));
                            this._roomEngine.connection.send(new MoveObjectMessageComposer(_arg_3, _local_7, _local_8, _local_9));
                        };
                    };
                    break;
                case RoomObjectOperationEnum.OBJECT_PICKUP:
                    if (this._roomEngine.connection){
                        this._roomEngine.connection.send(new PickupObjectMessageComposer(_arg_3, _arg_4));
                    };
                    break;
                case RoomObjectOperationEnum.OBJECT_MOVE:
                    _local_10 = false;
                    this.setObjectAlphaMultiplier(_local_6, 0.5);
                    this.setSelectedObjectData(_arg_1, _arg_2, _local_6.getId(), _arg_4, _local_6.getLocation(), _local_6.getDirection(), _arg_5);
                    this._roomEngine.setObjectMoverIconSprite(_local_6.getId(), _arg_4, true);
                    this._roomEngine.setObjectMoverIconSpriteVisible(false);
                    break;
                case RoomObjectOperationEnum.OBJECT_MOVE_TO:
                    this.setObjectAlphaMultiplier(_local_6, 1);
                    this._roomEngine.removeObjectMoverIconSprite();
                    if (this._roomEngine.connection){
                        if (_arg_4 == RoomObjectCategoryEnum._SafeStr_4329){
                            _local_9 = (int(_local_6.getDirection().x) % 360);
                            _local_7 = _local_6.getLocation().x;
                            _local_8 = _local_6.getLocation().y;
                            _local_9 = int((_local_9 / 45));
                            this._roomEngine.connection.send(new MoveObjectMessageComposer(_arg_3, _local_7, _local_8, _local_9));
                        }
                        else {
                            if (_arg_4 == RoomObjectCategoryEnum._SafeStr_4330){
                                _local_9 = (int(_local_6.getDirection().x) % 360);
                                _local_11 = this._roomEngine.getLegacyGeometry(_arg_1, _arg_2);
                                if (((this._roomEngine.connection) && (_local_11))){
                                    _local_12 = _local_11.getOldLocationString(_local_6.getLocation(), _local_9);
                                    if (_local_12 != null){
                                        this._roomEngine.connection.send(new MoveWallItemMessageComposer(_arg_3, RoomObjectCategoryEnum._SafeStr_4330, _local_12));
                                    };
                                };
                            };
                        };
                    };
                    break;
            };
            if (_local_10){
                this.resetSelectedObjectData(_arg_1, _arg_2);
            };
            return (true);
        }
        private function placeObject(_arg_1:int, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean):void
        {
            var _local_8:IRoomObjectController;
            var _local_15:IVector3d;
            var _local_16:LegacyWallGeometry;
            var _local_17:Boolean;
            var _local_5:SelectedRoomObjectData = this.getSelectedObjectData(_arg_1, _arg_2);
            if (_local_5 == null){
                return;
            };
            var _local_6:int = _local_5.id;
            var _local_7:int = _local_5.category;
            var _local_9:String = "";
            var _local_10:Number = 0;
            var _local_11:Number = 0;
            var _local_12:Number = 0;
            var _local_13:int;
            if (((!((this._roomEngine == null))) && (!((this._roomEngine.connection == null))))){
                _local_8 = (this._roomEngine.getRoomObject(_arg_1, _arg_2, _local_6, _local_7) as IRoomObjectController);
                if (_local_8 != null){
                    _local_13 = _local_8.getDirection().x;
                    _local_15 = _local_8.getLocation();
                    if ((((_local_7 == RoomObjectCategoryEnum._SafeStr_4329)) || ((_local_7 == RoomObjectCategoryEnum.OBJECT_CATEGORY_USER)))){
                        _local_10 = _local_15.x;
                        _local_11 = _local_15.y;
                        _local_12 = _local_15.z;
                    }
                    else {
                        if (_local_7 == RoomObjectCategoryEnum._SafeStr_4330){
                            _local_10 = _local_15.x;
                            _local_11 = _local_15.y;
                            _local_12 = _local_15.z;
                            _local_16 = this._roomEngine.getLegacyGeometry(_arg_1, _arg_2);
                            if (_local_16 != null){
                                _local_9 = _local_16.getOldLocationString(_local_15, _local_13);
                            };
                        };
                    };
                    _local_13 = ((((_local_13 / 45) % 8) + 8) % 8);
                    if ((((_local_7 == RoomObjectCategoryEnum.OBJECT_CATEGORY_USER)) && ((_local_5.typeId == RoomObjectTypeEnum._SafeStr_3747)))){
                        this._roomEngine.connection.send(new PlacePetMessageComposer(_local_6, int(_local_10), int(_local_11)));
                    }
                    else {
                        if (_local_8.getModelController().getString(RoomObjectVariableEnum._SafeStr_12459) != null){
                            this._roomEngine.connection.send(new PlacePostItMessageComposer(_local_6, _local_9));
                        }
                        else {
                            this._roomEngine.connection.send(new PlaceObjectMessageComposer(_local_6, _local_7, _local_9, int(_local_10), int(_local_11), _local_13));
                        };
                    };
                };
            };
            var _local_14:SelectedRoomObjectData = new SelectedRoomObjectData(_local_5.id, _local_5.category, null, null, null);
            this._roomEngine.setPlacedObjectData(_arg_1, _arg_2, _local_14);
            this.resetSelectedObjectData(_arg_1, _arg_2);
            if (((this._roomEngine) && (this._roomEngine.events))){
                _local_17 = ((_local_8) && ((_local_8.getId() == _local_5.id)));
                this._roomEngine.events.dispatchEvent(new RoomEngineObjectPlacedEvent(RoomEngineObjectEvent.REOB_OBJECT_PLACED, _arg_1, _arg_2, _local_6, _local_7, _local_9, _local_10, _local_11, _local_12, _local_13, _local_17, _arg_3, _arg_4, _local_5.instanceData));
            };
        }
        private function changeObjectState(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:int, _arg_6:Boolean):void
        {
            var _local_7:int = this._roomEngine.getRoomObjectCategory(_arg_4);
            this.changeRoomObjectState(_arg_1, _arg_2, _arg_3, _local_7, _arg_5, _arg_6);
        }
        private function changeRoomObjectState(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:Boolean):Boolean
        {
            if (((!((this._roomEngine == null))) && (!((this._roomEngine.connection == null))))){
                if (_arg_4 == RoomObjectCategoryEnum._SafeStr_4329){
                    if (!_arg_6){
                        ExternalInterface.call("FlashExternalInterface.triggerFloorItem", _arg_3);
                        this._roomEngine.connection.send(new UseFurnitureMessageComposer(_arg_3, _arg_5));
                    }
                    else {
                        this._roomEngine.connection.send(new SetRandomStateMessageComposer(_arg_3, _arg_5));
                    };
                }
                else {
                    if (_arg_4 == RoomObjectCategoryEnum._SafeStr_4330){
                        this._roomEngine.connection.send(new UseWallItemMessageComposer(_arg_3, _arg_5));
                    };
                };
            };
            return (true);
        }
        private function useObject(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:String):void
        {
            if (((!((this._roomEngine == null))) && (!((this._roomEngine.connection == null))))){
                switch (_arg_5){
                    case RoomObjectFurnitureActionEvent.ROFCAE_DICE_ACTIVATE:
                        this._roomEngine.connection.send(new ThrowDiceMessageComposer(_arg_3));
                        return;
                    case RoomObjectFurnitureActionEvent.ROFCAE_DICE_OFF:
                        this._roomEngine.connection.send(new DiceOffMessageComposer(_arg_3));
                        return;
                    case RoomObjectFurnitureActionEvent.ROFCAE_USE_HABBOWHEEL:
                        this._roomEngine.connection.send(new SpinWheelOfFortuneMessageComposer(_arg_3));
                        return;
                    case RoomObjectFurnitureActionEvent.ROFCAE_STICKIE:
                        this._roomEngine.connection.send(new GetItemDataMessageComposer(_arg_3));
                        return;
                    case RoomObjectFurnitureActionEvent.ROFCAE_VIRAL_GIFT:
                        this._roomEngine.connection.send(new ViralFurniStatusMessageComposer(_arg_3));
                        return;
                    case RoomObjectFurnitureActionEvent.ROFCAE_ENTER_ONEWAYDOOR:
                        this._roomEngine.connection.send(new EnterOneWayDoorMessageComposer(_arg_3));
                        return;
                    case RoomObjectFurnitureActionEvent.ROFCAE_QUEST_VENDING:
                        this._roomEngine.connection.send(new QuestVendingWallItemMessageComposer(_arg_3));
                };
            };
        }
        private function initializeObject(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:String):void
        {
        }
        public function modifyWallItemData(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String):Boolean
        {
            if ((((this._roomEngine == null)) || ((this._roomEngine.connection == null)))){
                return (false);
            };
            this._roomEngine.connection.send(new SetItemDataMessageComposer(_arg_3, _arg_4, _arg_1, _arg_2));
            return (true);
        }
        public function deleteWallItem(_arg_1:int, _arg_2:int, _arg_3:int):Boolean
        {
            if ((((this._roomEngine == null)) || ((this._roomEngine.connection == null)))){
                return (false);
            };
            this._roomEngine.connection.send(new RemoveItemMessageComposer(_arg_3, _arg_1, _arg_2));
            return (true);
        }
        private function walkTo(_arg_1:int, _arg_2:int):void
        {
            if (this._roomEngine == null){
                return;
            };
            if (this._roomEngine.connection){
                this._roomEngine.connection.send(new MoveAvatarMessageComposer(_arg_1, _arg_2));
            };
        }

    }
}//package com.sulake.habbo.room

// getSelectedObjectData = "_-2oq" (String#899, DoABC#2)
// IRoomEngineServices = "_-28G" (String#6208, DoABC#2)
// _SafeStr_12442 = "_-0vN" (String#16252, DoABC#2)
// _SafeStr_12443 = "_-7h" (String#22530, DoABC#2)
// _SafeStr_12446 = "_-1bD" (String#17943, DoABC#2)
// _SafeStr_12459 = "_-2sB" (String#21166, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// _SafeStr_13133 = "_-2xl" (String#21386, DoABC#2)
// getOldLocationString = "_-1DO" (String#16999, DoABC#2)
// validateLocation = "_-2fO" (String#20664, DoABC#2)
// getRoomObjectCategory = "_-L3" (String#8103, DoABC#2)
// updateObjectRoomWindow = "_-LV" (String#8113, DoABC#2)
// setObjectMoverIconSprite = "_-gt" (String#8532, DoABC#2)
// setObjectMoverIconSpriteVisible = "_-2Wi" (String#6694, DoABC#2)
// removeObjectMoverIconSprite = "_-1t-" (String#5901, DoABC#2)
// setSelectedObjectData = "_-mH" (String#2183, DoABC#2)
// setPlacedObjectData = "_-2bg" (String#6788, DoABC#2)
// getLegacyGeometry = "_-0UL" (String#1485, DoABC#2)
// getTileHeightMap = "_-0Hd" (String#1444, DoABC#2)
// getSelectionArrow = "_-01q" (String#3599, DoABC#2)
// getTileCursor = "_-qa" (String#8719, DoABC#2)
// getIsPlayingGame = "_-xX" (String#8834, DoABC#2)
// requestRoomAdImage = "_-296" (String#6229, DoABC#2)
// requestMouseCursor = "_-11O" (String#4903, DoABC#2)
// _selectedAvatarId = "_-3FH" (String#22087, DoABC#2)
// resetSelectedObjectData = "_-2yz" (String#21426, DoABC#2)
// updateSelectedObjectData = "_-04t" (String#14237, DoABC#2)
// setObjectAlphaMultiplier = "_-1ew" (String#18094, DoABC#2)
// setSelectedObject = "_-2rr" (String#21149, DoABC#2)
// setSelectedAvatar = "_-0N6" (String#14961, DoABC#2)
// processRoomCanvasMouseEvent = "_-02d" (String#3621, DoABC#2)
// getMouseEventId = "_-0er" (String#15620, DoABC#2)
// setMouseEventId = "_-1Ag" (String#16888, DoABC#2)
// getMouseHandler = "_-EC" (String#7957, DoABC#2)
// handleRoomObjectEvent = "_-0uq" (String#16232, DoABC#2)
// handleRoomObjectMouseEvent = "_-2AN" (String#19421, DoABC#2)
// ISelectedRoomObjectData = "_-J6" (String#8063, DoABC#2)
// handleObjectStateChange = "_-2aH" (String#20455, DoABC#2)
// handleObjectRandomStateChange = "_-gj" (String#23920, DoABC#2)
// handleObjectDimmerStateEvent = "_-36r" (String#21759, DoABC#2)
// handleSelectedObjectMove = "_-0HZ" (String#14740, DoABC#2)
// handleSelectedObjectRemove = "_-2oi" (String#21033, DoABC#2)
// handleObjectWidgetRequestEvent = "_-SP" (String#23342, DoABC#2)
// handleObjectActionEvent = "_-1jH" (String#18256, DoABC#2)
// handleObjectSoundMachineEvent = "_-2Ay" (String#19441, DoABC#2)
// handleObjectJukeboxEvent = "_-2LU" (String#19867, DoABC#2)
// handleObjectFloorHoleEvent = "_-1L6" (String#17319, DoABC#2)
// handleObjectRoomAdEvent = "_-1rJ" (String#18596, DoABC#2)
// handleRoomActionEvent = "_-1iP" (String#18224, DoABC#2)
// handleRoomActionMouseRequestEvent = "_-2vS" (String#21295, DoABC#2)
// handleRoomObjectMouseClick = "_-HB" (String#22897, DoABC#2)
// handleRoomObjectMouseMove = "_-2UQ" (String#20217, DoABC#2)
// handleRoomObjectMouseDown = "_-0lQ" (String#15880, DoABC#2)
// handleRoomObjectMouseEnter = "_-2vL" (String#21290, DoABC#2)
// handleRoomObjectMouseLeave = "_-1vb" (String#18780, DoABC#2)
// placeObject = "_-0gv" (String#15706, DoABC#2)
// walkTo = "_-vY" (String#24510, DoABC#2)
// getEventHandler = "_-1dG" (String#5618, DoABC#2)
// handleObjectMove = "_-Yo" (String#23592, DoABC#2)
// handleObjectPlace = "_-0N4" (String#14960, DoABC#2)
// handleFurnitureMove = "_-vk" (String#24518, DoABC#2)
// handleWallItemMove = "_-1Rt" (String#17578, DoABC#2)
// handleUserMove = "_-2k" (String#20844, DoABC#2)
// handleObjectInitializeEvent = "_-0Zk" (String#15433, DoABC#2)
// initializeObject = "_-1hW" (String#18191, DoABC#2)
// validateFurnitureLocation = "_-nW" (String#24172, DoABC#2)
// getValidFurnitureDirection = "_-2Ha" (String#19709, DoABC#2)
// validateWallItemLocation = "_-1FS" (String#17092, DoABC#2)
// validateUserLocation = "_-cG" (String#23726, DoABC#2)
// validateFurnitureDirection = "_-0JE" (String#14810, DoABC#2)
// modifyWallItemData = "_-1xa" (String#18872, DoABC#2)
// deleteWallItem = "_-82" (String#22545, DoABC#2)
// IRoomObjectController = "_-17p" (String#5034, DoABC#2)
// RoomEngineObjectEvent = "_-10r" (String#16492, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// RoomEngineObjectPlacedEvent = "_-2zd" (String#21445, DoABC#2)
// PlaceObjectMessageComposer = "_-1To" (String#17657, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// RoomEngineDimmerStateEvent = "_-kD" (String#24044, DoABC#2)
// SelectedRoomObjectData = "_-0MS" (String#4010, DoABC#2)
// LegacyWallGeometry = "_-2Nh" (String#6515, DoABC#2)
// TileHeightMap = "_-0Bg" (String#3789, DoABC#2)
// RoomObjectUpdateMessage = "_-73" (String#22503, DoABC#2)
// IRoomRenderingCanvasMouseListener = "_-Qz" (String#8227, DoABC#2)
// RoomObjectEventHandler = "_-0NF" (String#4024, DoABC#2)
// RoomObjectMouseEvent = "_-20k" (String#19042, DoABC#2)
// RoomObjectFurnitureActionEvent = "_-2H6" (String#19689, DoABC#2)
// UseFurnitureMessageComposer = "_-0I2" (String#14759, DoABC#2)
// RoomSpriteMouseEvent = "_-wc" (String#8815, DoABC#2)
// RoomObjectStateChangeEvent = "_-2D1" (String#19524, DoABC#2)
// RoomObjectWidgetRequestEvent = "_-0Oy" (String#15023, DoABC#2)
// RoomObjectVisibilityUpdateMessage = "_-1ye" (String#18914, DoABC#2)
// RoomObjectWallMouseEvent = "_-2ed" (String#20631, DoABC#2)
// RoomObjectTileMouseEvent = "_-0QU" (String#15080, DoABC#2)
// RoomObjectRoomActionEvent = "_-2rh" (String#21144, DoABC#2)
// RoomObjectAvatarSelectedMessage = "_-1fk" (String#18125, DoABC#2)
// RoomObjectMoveEvent = "_-2gn" (String#20720, DoABC#2)
// RoomObjectFloorHoleEvent = "_-2j-" (String#20806, DoABC#2)
// RoomObjectDimmerStateUpdateEvent = "_-08I" (String#14375, DoABC#2)
// RoomObjectTypeEnum = "_-2hK" (String#20744, DoABC#2)
// PlacePetMessageComposer = "_-1qF" (String#18553, DoABC#2)
// SetRandomStateMessageComposer = "_-1mS" (String#18398, DoABC#2)
// PlacePostItMessageComposer = "_-CG" (String#22700, DoABC#2)
// LookToMessageComposer = "_-29v" (String#19401, DoABC#2)
// TryBusMessageComposer = "_-0ym" (String#16382, DoABC#2)
// ViralFurniStatusMessageComposer = "_-1Nk" (String#17427, DoABC#2)
// SetObjectDataMessageComposer = "_-Go" (String#22882, DoABC#2)
// DiceOffMessageComposer = "_-0ZY" (String#15425, DoABC#2)
// PickupObjectMessageComposer = "_-0Oc" (String#15012, DoABC#2)
// UseWallItemMessageComposer = "_-4c" (String#22401, DoABC#2)
// RemoveItemMessageComposer = "_-0KW" (String#14861, DoABC#2)
// MoveObjectMessageComposer = "_-0e6" (String#15589, DoABC#2)
// MoveAvatarMessageComposer = "_-1xR" (String#18866, DoABC#2)
// ThrowDiceMessageComposer = "_-zR" (String#24670, DoABC#2)
// MoveWallItemMessageComposer = "_-13v" (String#16614, DoABC#2)
// EnterOneWayDoorMessageComposer = "_-0qR" (String#16068, DoABC#2)
// GetItemDataMessageComposer = "_-i7" (String#23970, DoABC#2)
// ChangeRoomMessageComposer = "_-12g" (String#16566, DoABC#2)
// SpinWheelOfFortuneMessageComposer = "_-0Bc" (String#14512, DoABC#2)
// SetItemDataMessageComposer = "_-29t" (String#19399, DoABC#2)
// QuestVendingWallItemMessageComposer = "_-1Tf" (String#17651, DoABC#2)
// RoomObjectOperationEnum = "_-0Zp" (String#15436, DoABC#2)
// brightness = "_-kZ" (String#24053, DoABC#2)
// _SafeStr_3747 = "_-gF" (String#23903, DoABC#2)
// getTileHeight = "_-0Kq" (String#14872, DoABC#2)
// isRoomTile = "_-3Dl" (String#22024, DoABC#2)
// _SafeStr_4329 = "_-bN" (String#23687, DoABC#2)
// _SafeStr_4330 = "_-0cQ" (String#15531, DoABC#2)
// activeRoomId = "_-kJ" (String#2172, DoABC#2)
// activeRoomCategory = "_-1qo" (String#1770, DoABC#2)
// disposeObjectFurniture = "_-0Sj" (String#1477, DoABC#2)
// disposeObjectWallItem = "_-0aH" (String#1502, DoABC#2)
// disposeObjectUser = "_-Jw" (String#2086, DoABC#2)
// _SafeStr_4962 = "_-1WC" (String#17750, DoABC#2)
// addObjectFurniture = "_-0G1" (String#1439, DoABC#2)
// addObjectWallItem = "_-J0" (String#2084, DoABC#2)
// addObjectUser = "_-0kK" (String#1540, DoABC#2)
// changeRoomObjectState = "_-W1" (String#8322, DoABC#2)
// changeObjectState = "_-3Dq" (String#2025, DoABC#2)
// getRoomObject = "_-1qD" (String#866, DoABC#2)
// _SafeStr_4992 = "_-0BD" (String#14494, DoABC#2)
// _SafeStr_4993 = "_-2qH" (String#21091, DoABC#2)
// operation = "_-0Ag" (String#3770, DoABC#2)
// loc = "_-0fh" (String#15660, DoABC#2)
// objectType = "_-23O" (String#19148, DoABC#2)
// RORAE_ROOM_AD_FURNI_CLICK = "_-0v3" (String#16239, DoABC#2)
// RORAE_ROOM_AD_TOOLTIP_SHOW = "_-1bW" (String#17956, DoABC#2)
// RORAE_ROOM_AD_TOOLTIP_HIDE = "_-37a" (String#21790, DoABC#2)
// processUpdateMessage = "_-FX" (String#7984, DoABC#2)
// mouseEvent = "_-0Um" (String#4199, DoABC#2)
// RORAE_CHANGE_ROOM = "_-1pw" (String#18539, DoABC#2)
// RORAE_TRY_BUS = "_-3A5" (String#21887, DoABC#2)
// wallLocation = "_-12C" (String#16544, DoABC#2)
// REOE_OBJECT_SELECTED = "_-Ss" (String#23359, DoABC#2)
// REOE_OBJECT_DESELECTED = "_-1yB" (String#18894, DoABC#2)
// REOB_OBJECT_PLACED = "_-2hu" (String#20768, DoABC#2)
// REOB_OBJECT_REQUEST_MOVE = "_-0np" (String#15970, DoABC#2)
// ROE_MOUSE_ENTER = "_-9-" (String#22579, DoABC#2)
// ROE_MOUSE_LEAVE = "_-0o9" (String#15981, DoABC#2)
// REOE_WIDGET_REQUEST_PLACEHOLDER = "_-0mW" (String#15918, DoABC#2)
// REOE_WIDGET_REQUEST_STICKIE = "_-IJ" (String#22941, DoABC#2)
// REOE_WIDGET_REQUEST_PRESENT = "_-3D0" (String#21997, DoABC#2)
// REOE_WIDGET_REQUEST_TROPHY = "_-0gt" (String#15704, DoABC#2)
// REOE_WIDGET_REQUEST_TEASER = "_-0u1" (String#16204, DoABC#2)
// REOE_WIDGET_REQUEST_ECOTRONBOX = "_-mP" (String#24123, DoABC#2)
// REOE_WIDGET_REQUEST_DIMMER = "_-2Sl" (String#20149, DoABC#2)
// REOR_REMOVE_DIMMER = "_-1pt" (String#18537, DoABC#2)
// REOR_REQUEST_CLOTHING_CHANGE = "_-8e" (String#22566, DoABC#2)
// REOR_WIDGET_REQUEST_PLAYLIST_EDITOR = "_-0k" (String#15828, DoABC#2)
// REOE_ROOM_AD_FURNI_CLICK = "_-Ox" (String#23204, DoABC#2)
// REOE_ROOM_AD_FURNI_DOUBLE_CLICK = "_-2ph" (String#21068, DoABC#2)
// REOE_ROOM_AD_TOOLTIP_SHOW = "_-PN" (String#23220, DoABC#2)
// REOE_ROOM_AD_TOOLTIP_HIDE = "_-yL" (String#24628, DoABC#2)
// RWDSUE_DIMMER_STATE = "_-0A5" (String#14451, DoABC#2)
// presetId = "_-37i" (String#21795, DoABC#2)
// effectId = "_-0jW" (String#15809, DoABC#2)
// ROFCAE_DICE_OFF = "_-2dW" (String#20585, DoABC#2)
// ROFCAE_DICE_ACTIVATE = "_-HX" (String#22914, DoABC#2)
// ROFCAE_USE_HABBOWHEEL = "_-2y5" (String#21397, DoABC#2)
// ROFCAE_STICKIE = "_-28f" (String#19358, DoABC#2)
// ROFCAE_VIRAL_GIFT = "_-2T4" (String#20166, DoABC#2)
// ROFCAE_ENTER_ONEWAYDOOR = "_-1nd" (String#18446, DoABC#2)
// ROFCAE_QUEST_VENDING = "_-0z-" (String#16393, DoABC#2)
// ROFCAE_SOUND_MACHINE_INIT = "_-0Ww" (String#15313, DoABC#2)
// ROFCAE_SOUND_MACHINE_START = "_-0gM" (String#15688, DoABC#2)
// ROFCAE_SOUND_MACHINE_STOP = "_-1Ps" (String#17503, DoABC#2)
// ROFCAE_SOUND_MACHINE_DISPOSE = "_-7t" (String#22538, DoABC#2)
// ROFCAE_JUKEBOX_INIT = "_-uC" (String#24458, DoABC#2)
// ROFCAE_JUKEBOX_START = "_-0DL" (String#14583, DoABC#2)
// ROFCAE_JUKEBOX_MACHINE_STOP = "_-24A" (String#19183, DoABC#2)
// ROFCAE_JUKEBOX_DISPOSE = "_-00m" (String#14084, DoABC#2)
// ROFCAE_MOUSE_BUTTON = "_-Sz" (String#23363, DoABC#2)
// ROFCAE_MOUSE_ARROW = "_-2VP" (String#20258, DoABC#2)
// ROSCE_STATE_CHANGE = "_-RU" (String#23304, DoABC#2)
// ROSCE_STATE_RANDOM = "_-0Ov" (String#15021, DoABC#2)
// wallWidth = "_-GS" (String#22870, DoABC#2)
// tileX = "_-2UH" (String#20211, DoABC#2)
// tileY = "_-04c" (String#14226, DoABC#2)
// tileZ = "_-2Ii" (String#19757, DoABC#2)
// RORAE_LEAVE_ROOM = "_-38d" (String#21827, DoABC#2)
// ROME_POSITION_CHANGED = "_-114" (String#16501, DoABC#2)
// ROME_OBJECT_REMOVED = "_-0PW" (String#15043, DoABC#2)
// RORPFHUM_ADD = "_-wb" (String#24555, DoABC#2)
// RORPFHUM_REMOVE = "_-0CG" (String#14540, DoABC#2)
// RORAE_ROOM_AD_LOAD_IMAGE = "_-0MN" (String#14928, DoABC#2)
// RORAE_ROOM_AD_FURNI_DOUBLE_CLICK = "_-2bv" (String#20520, DoABC#2)
// ROSM_SOUND_MACHINE_INIT = "_-Tk" (String#23396, DoABC#2)
// ROSM_SOUND_MACHINE_SWITCHED_ON = "_-0SZ" (String#15156, DoABC#2)
// ROSM_SOUND_MACHINE_SWITCHED_OFF = "_-1o2" (String#18464, DoABC#2)
// ROSM_SOUND_MACHINE_DISPOSE = "_-1pK" (String#18515, DoABC#2)
// ROSM_JUKEBOX_INIT = "_-vy" (String#24527, DoABC#2)
// ROSM_JUKEBOX_SWITCHED_ON = "_-nf" (String#24178, DoABC#2)
// ROSM_JUKEBOX_SWITCHED_OFF = "_-3x" (String#22374, DoABC#2)
// ROSM_JUKEBOX_DISPOSE = "_-gi" (String#23919, DoABC#2)
// _SafeStr_5760 = "_-2gS" (String#20707, DoABC#2)
// ROVUM_ENABLED = "_-0f3" (String#15631, DoABC#2)
// ROVUM_DISABLED = "_-18v" (String#16811, DoABC#2)
// ROE_MOUSE_MOVE = "_-f9" (String#23852, DoABC#2)
// ROE_MOUSE_CLICK = "_-2sU" (String#21178, DoABC#2)
// addFloorHole = "_-u-" (String#8766, DoABC#2)
// removeFloorHole = "_-1hN" (String#5693, DoABC#2)
// product = "_-Bd" (String#22675, DoABC#2)
// eventId = "_-3ER" (String#22053, DoABC#2)
// ROE_MOUSE_DOWN = "_-va" (String#24512, DoABC#2)
// getSelectedAvatarId = "_-2j0" (String#6933, DoABC#2)
// modifyRoomObjectData = "_-0Eh" (String#3843, DoABC#2)
// modifyRoomObject = "_-09k" (String#3753, DoABC#2)
// cancelRoomObjectInsert = "_-0w6" (String#4772, DoABC#2)
// initializeRoomObjectInsert = "_-QC" (String#8205, DoABC#2)
// RoomObjectRoomAdEvent = "_-mk" (String#24139, DoABC#2)
// RoomObjectCategoryEnum = "_-1eh" (String#5639, DoABC#2)
// useObject = "_-0zi" (String#1594, DoABC#2)


