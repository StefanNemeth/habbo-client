
package com.sulake.habbo.room
{
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.room.object.RoomPlaneParser;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.RoomReadyMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomPropertyMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.FloorHeightMapMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.HeightMapMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.HeightMapUpdateMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomVisualizationSettingsEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.FurnitureAliasesMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.PublicRoomObjectsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectAddMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ViralTeaserActiveMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectUpdateMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectDataUpdateMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectsDataUpdateMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectRemoveMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemAddMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemRemoveMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemUpdateMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemDataUpdateMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UsersMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserUpdateMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserRemoveMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserChangeMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.action.WaveMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.action.DanceMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.action.AvatarEffectMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.action.SleepMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.action.CarryObjectMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.action.UseObjectMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.SlideObjectBundleMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.chat.ChatMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.chat.WhisperMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.chat.ShoutMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.chat.UserTypingMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.DiceValueMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.OneWayDoorStatusMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.publicroom.ParkBusDoorMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetExperienceEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.YouArePlayingGameMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.GamePlayerValueMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.UserObjectMessageParser;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.RoomReadyMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.GetFurnitureAliasesMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.GetRoomEntryDataMessageComposer;
    import com.sulake.habbo.communication.messages.parser.room.engine.FurnitureAliasesMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.HeightMapMessageParser;
    import com.sulake.habbo.room.utils.TileHeightMap;
    import com.sulake.habbo.communication.messages.parser.room.engine.HeightMapUpdateMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.RoomVisualizationSettingsParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.RoomPropertyMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.FloorHeightMapMessageParser;
    import com.sulake.habbo.room.utils.LegacyWallGeometry;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectMessageData;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectsMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.PublicRoomObjectMessageData;
    import com.sulake.habbo.communication.messages.parser.room.engine.PublicRoomObjectsMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectAddMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.ViralTeaserActiveMessageParser;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectUpdateMessageParser;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectDataUpdateMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectData;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectsDataUpdateMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectRemoveMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemMessageData;
    import com.sulake.habbo.communication.messages.parser.room.engine.ItemsMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.ItemAddMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.ItemRemoveMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.ItemUpdateMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.ItemDataUpdateMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserMessageData;
    import com.sulake.habbo.communication.messages.parser.room.engine.UsersMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserUpdateMessageData;
    import com.sulake.habbo.communication.messages.incoming.room.engine.AvatarActionMessageData;
    import com.sulake.habbo.communication.messages.parser.room.engine.UserUpdateMessageParser;
    import com.sulake.room.IRoomInstance;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.communication.messages.parser.room.engine.UserRemoveMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.action.WaveMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.action.DanceMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.action.AvatarEffectMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.action.SleepMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.action.CarryObjectMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.action.UseObjectMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.SlideObjectBundleMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.SlideObjectMessageData;
    import com.sulake.habbo.communication.messages.parser.room.chat.ChatMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.chat.UserTypingMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.pets.PetExperienceParser;
    import com.sulake.habbo.communication.messages.parser.room.furniture.DiceValueMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.furniture.OneWayDoorStatusMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.publicroom.ParkBusDoorMessageParser;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.habbo.communication.messages.parser.room.session.YouArePlayingGameMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.session.GamePlayerValueMessageParser;

    public class RoomMessageHandler 
    {

        private var _connection:IConnection = null;
        private var _SafeStr_13372:IRoomCreator = null;
        private var _planeParser:RoomPlaneParser = null;
        private var _SafeStr_13373:int = -1;
        private var _SafeStr_13374:Boolean = true;
        private var _SafeStr_13375:int = -1000000000;
        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _SafeStr_13378:Object;

        public function RoomMessageHandler(_arg_1:IRoomCreator)
        {
            this._SafeStr_13378 = new Object();
            super();
            this._SafeStr_13372 = _arg_1;
            this._planeParser = new RoomPlaneParser();
            this._SafeStr_13374 = true;
        }
        public function dispose():void
        {
            this._connection = null;
            this._SafeStr_13372 = null;
            if (this._planeParser != null){
                this._planeParser.dispose();
                this._planeParser = null;
            };
        }
        public function setCurrentRoom(_arg_1:int, _arg_2:int):void
        {
            if (((!((this._roomId == 0))) || (!((this._roomCategory == 0))))){
                if (this._SafeStr_13372 != null){
                    this._SafeStr_13372.disposeRoom(this._roomId, this._roomCategory);
                };
            };
            this._roomId = _arg_1;
            this._roomCategory = _arg_2;
        }
        public function resetCurrentRoom():void
        {
            this._roomId = 0;
            this._roomCategory = 0;
        }
        private function getRoomId(_arg_1:int):int
        {
            return (this._roomId);
        }
        private function getRoomCategory(_arg_1:int):int
        {
            return (this._roomCategory);
        }
        private function isPublicRoom(_arg_1:int, _arg_2:int):Boolean
        {
            if (this._SafeStr_13372){
                return (this._SafeStr_13372.isPublicRoom(_arg_1, _arg_2));
            };
            return (false);
        }
        public function set connection(_arg_1:IConnection):void
        {
            if (this._connection != null){
                return;
            };
            if (_arg_1 != null){
                this._connection = _arg_1;
                _arg_1.addMessageEvent(new UserObjectEvent(this.onOwnUserEvent));
                _arg_1.addMessageEvent(new RoomReadyMessageEvent(this.onRoomReady));
                _arg_1.addMessageEvent(new RoomPropertyMessageEvent(this.onRoomProperty));
                _arg_1.addMessageEvent(new FloorHeightMapMessageEvent(this.onFloorHeightMap));
                _arg_1.addMessageEvent(new HeightMapMessageEvent(this.onHeightMap));
                _arg_1.addMessageEvent(new HeightMapUpdateMessageEvent(this.onHeightMapUpdate));
                _arg_1.addMessageEvent(new RoomVisualizationSettingsEvent(this.onRoomVisualizationSettings));
                _arg_1.addMessageEvent(new FurnitureAliasesMessageEvent(this.onFurnitureAliases));
                _arg_1.addMessageEvent(new ObjectsMessageEvent(this.onObjects));
                _arg_1.addMessageEvent(new PublicRoomObjectsMessageEvent(this.onPublicRoomObjects));
                _arg_1.addMessageEvent(new ObjectAddMessageEvent(this.onObjectAdd));
                _arg_1.addMessageEvent(new ViralTeaserActiveMessageEvent(this.onObjectInject));
                _arg_1.addMessageEvent(new ObjectUpdateMessageEvent(this.onObjectUpdate));
                _arg_1.addMessageEvent(new ObjectDataUpdateMessageEvent(this.onObjectDataUpdate));
                _arg_1.addMessageEvent(new ObjectsDataUpdateMessageEvent(this.onObjectsDataUpdate));
                _arg_1.addMessageEvent(new ObjectRemoveMessageEvent(this.onObjectRemove));
                _arg_1.addMessageEvent(new ItemsMessageEvent(this.onItems));
                _arg_1.addMessageEvent(new ItemAddMessageEvent(this.onItemAdd));
                _arg_1.addMessageEvent(new ItemRemoveMessageEvent(this.onItemRemove));
                _arg_1.addMessageEvent(new ItemUpdateMessageEvent(this.onItemUpdate));
                _arg_1.addMessageEvent(new ItemDataUpdateMessageEvent(this.onItemDataUpdate));
                _arg_1.addMessageEvent(new UsersMessageEvent(this.onUsers));
                _arg_1.addMessageEvent(new UserUpdateMessageEvent(this.onUserUpdate));
                _arg_1.addMessageEvent(new UserRemoveMessageEvent(this.onUserRemove));
                _arg_1.addMessageEvent(new UserChangeMessageEvent(this.onUserChange));
                _arg_1.addMessageEvent(new WaveMessageEvent(this.onWave));
                _arg_1.addMessageEvent(new DanceMessageEvent(this.onDance));
                _arg_1.addMessageEvent(new AvatarEffectMessageEvent(this.onAvatarEffect));
                _arg_1.addMessageEvent(new SleepMessageEvent(this.onAvatarSleep));
                _arg_1.addMessageEvent(new CarryObjectMessageEvent(this.onCarryObject));
                _arg_1.addMessageEvent(new UseObjectMessageEvent(this.onUseObject));
                _arg_1.addMessageEvent(new SlideObjectBundleMessageEvent(this.onSlideUpdate));
                _arg_1.addMessageEvent(new ChatMessageEvent(this.onChat));
                _arg_1.addMessageEvent(new WhisperMessageEvent(this.onChat));
                _arg_1.addMessageEvent(new ShoutMessageEvent(this.onChat));
                _arg_1.addMessageEvent(new UserTypingMessageEvent(this.onTypingStatus));
                _arg_1.addMessageEvent(new DiceValueMessageEvent(this.onDiceValue));
                _arg_1.addMessageEvent(new OneWayDoorStatusMessageEvent(this.onOneWayDoorStatus));
                _arg_1.addMessageEvent(new ParkBusDoorMessageEvent(this.onParkBusDoor));
                _arg_1.addMessageEvent(new PetExperienceEvent(this.onPetExperience));
                _arg_1.addMessageEvent(new YouArePlayingGameMessageEvent(this.onPlayingGame));
                _arg_1.addMessageEvent(new GamePlayerValueMessageEvent(this.onGamePlayerNumberValue));
            };
        }
        private function onOwnUserEvent(_arg_1:IMessageEvent):void
        {
            var _local_2:UserObjectEvent = (_arg_1 as UserObjectEvent);
            if (_local_2 == null){
                return;
            };
            var _local_3:UserObjectMessageParser = _local_2.getParser();
            if (_local_3 != null){
                this._SafeStr_13373 = _local_3.id;
            };
        }
        private function onRoomReady(_arg_1:IMessageEvent):void
        {
            var _local_2:RoomReadyMessageEvent = (_arg_1 as RoomReadyMessageEvent);
            if ((((((_local_2 == null)) || ((_local_2.getParser() == null)))) || ((_arg_1.connection == null)))){
                return;
            };
            var _local_3:RoomReadyMessageParser = _local_2.getParser();
            if (((!((this._roomId == _local_3.roomId))) || (!((this._roomCategory == _local_3.roomCategory))))){
                this.setCurrentRoom(_local_3.roomId, _local_3.roomCategory);
            };
            var _local_4:String = _local_3.roomType;
            if (this._SafeStr_13372 != null){
                this._SafeStr_13372.setWorldType(_local_3.roomId, _local_3.roomCategory, _local_4);
            };
            if (this._SafeStr_13374){
                _arg_1.connection.send(new GetFurnitureAliasesMessageComposer());
                this._SafeStr_13374 = false;
            }
            else {
                _arg_1.connection.send(new GetRoomEntryDataMessageComposer());
            };
        }
        private function onFurnitureAliases(_arg_1:IMessageEvent):void
        {
            var _local_2:FurnitureAliasesMessageEvent;
            var _local_3:FurnitureAliasesMessageParser;
            var _local_4:int;
            var _local_5:int;
            var _local_6:String;
            var _local_7:String;
            if (this._SafeStr_13372 != null){
                _local_2 = (_arg_1 as FurnitureAliasesMessageEvent);
                if ((((_local_2 == null)) || ((_local_2.getParser() == null)))){
                    return;
                };
                _local_3 = _local_2.getParser();
                if (_local_3 != null){
                    _local_4 = _local_3.aliasCount;
                    _local_5 = 0;
                    while (_local_5 < _local_4) {
                        _local_6 = _local_3.getName(_local_5);
                        _local_7 = _local_3.getAlias(_local_5);
                        this._SafeStr_13372.setRoomObjectAlias(_local_6, _local_7);
                        _local_5++;
                    };
                };
            };
            _arg_1.connection.send(new GetRoomEntryDataMessageComposer());
        }
        private function onHeightMap(_arg_1:IMessageEvent):void
        {
            var _local_10:int;
            var _local_11:Number;
            var _local_12:Boolean;
            var _local_13:Boolean;
            var _local_2:HeightMapMessageEvent = (_arg_1 as HeightMapMessageEvent);
            if ((((_local_2 == null)) || ((_local_2.getParser() == null)))){
                return;
            };
            if (this._SafeStr_13372 == null){
                return;
            };
            var _local_3:HeightMapMessageParser = _local_2.getParser();
            var _local_4:int = this.getRoomId(_local_3.roomId);
            var _local_5:int = this.getRoomCategory(_local_3.roomCategory);
            var _local_6:int = _local_3.width;
            var _local_7:int = _local_3.height;
            var _local_8:TileHeightMap = new TileHeightMap(_local_6, _local_7);
            var _local_9:int;
            while (_local_9 < _local_7) {
                _local_10 = 0;
                while (_local_10 < _local_6) {
                    _local_11 = _local_3.getTileHeight(_local_10, _local_9);
                    _local_12 = _local_3.getTileBlocking(_local_10, _local_9);
                    _local_13 = _local_3.isRoomTile(_local_10, _local_9);
                    _local_8.setTileHeight(_local_10, _local_9, _local_11);
                    _local_8.setTileBlocking(_local_10, _local_9, _local_12);
                    _local_8.setIsRoomTile(_local_10, _local_9, _local_13);
                    _local_10++;
                };
                _local_9++;
            };
            this._SafeStr_13372.setTileHeightMap(_local_4, _local_5, _local_8);
        }
        private function onHeightMapUpdate(_arg_1:IMessageEvent):void
        {
            var _local_10:int;
            var _local_11:Number;
            var _local_12:Boolean;
            var _local_2:HeightMapUpdateMessageEvent = (_arg_1 as HeightMapUpdateMessageEvent);
            if ((((_local_2 == null)) || ((_local_2.getParser() == null)))){
                return;
            };
            if (this._SafeStr_13372 == null){
                return;
            };
            var _local_3:HeightMapUpdateMessageParser = _local_2.getParser();
            var _local_4:int = this.getRoomId(_local_3.roomId);
            var _local_5:int = this.getRoomCategory(_local_3.roomCategory);
            var _local_6:TileHeightMap = this._SafeStr_13372.getTileHeightMap(_local_4, _local_5);
            if (_local_6 == null){
                return;
            };
            var _local_7:int = _local_6.mapWidth;
            var _local_8:int = _local_6.mapHeight;
            var _local_9:int;
            while (_local_9 < _local_8) {
                _local_10 = 0;
                while (_local_10 < _local_7) {
                    _local_11 = _local_6.getTileHeight(_local_10, _local_9);
                    _local_11 = _local_3.getTileHeight(_local_10, _local_9, _local_11, _local_7, _local_8);
                    _local_12 = _local_6.getTileBlocking(_local_10, _local_9);
                    _local_12 = _local_3.getTileBlocking(_local_10, _local_9, _local_12, _local_7, _local_8);
                    _local_6.setTileHeight(_local_10, _local_9, _local_11);
                    _local_6.setTileBlocking(_local_10, _local_9, _local_12);
                    _local_10++;
                };
                _local_9++;
            };
        }
        private function onRoomVisualizationSettings(_arg_1:IMessageEvent):void
        {
            var _local_2:RoomVisualizationSettingsEvent = (_arg_1 as RoomVisualizationSettingsEvent);
            if ((((_local_2 == null)) || ((_local_2.getParser() == null)))){
                return;
            };
            var _local_3:RoomVisualizationSettingsParser = _local_2.getParser();
            var _local_4:int = this.getRoomId(_local_3.roomId);
            var _local_5:int = this.getRoomCategory(_local_3.roomCategory);
            var _local_6 = !(_local_3.wallsHidden);
            var _local_7:Boolean = true;
            var _local_8:Number = _local_3.wallThicknessMultiplier;
            var _local_9:Number = _local_3.floorThicknessMultiplier;
            if (this._SafeStr_13372 != null){
                this._SafeStr_13372.updateObjectRoomVisibilities(_local_4, _local_5, _local_6, _local_7);
                this._SafeStr_13372.updateObjectRoomPlaneThicknesses(_local_4, _local_5, _local_8, _local_9);
            };
        }
        private function onRoomProperty(_arg_1:IMessageEvent):void
        {
            var _local_2:RoomPropertyMessageEvent = (_arg_1 as RoomPropertyMessageEvent);
            if ((((_local_2 == null)) || ((_local_2.getParser() == null)))){
                return;
            };
            var _local_3:RoomPropertyMessageParser = _local_2.getParser();
            var _local_4:int = this.getRoomId(_local_3.roomId);
            var _local_5:int = this.getRoomCategory(_local_3.roomCategory);
            var _local_6:String = _local_3.floorType;
            var _local_7:String = _local_3.wallType;
            var _local_8:String = _local_3.landscapeType;
            if (this._SafeStr_13372 != null){
                this._SafeStr_13372.updateObjectRoom(_local_4, _local_5, _local_6, _local_7, _local_8);
            };
        }
        private function onFloorHeightMap(_arg_1:IMessageEvent):void
        {
            var _local_19:int;
            var _local_20:int;
            var _local_21:Boolean;
            var _local_22:int;
            var _local_23:XML;
            var _local_2:FloorHeightMapMessageEvent = (_arg_1 as FloorHeightMapMessageEvent);
            if ((((_local_2 == null)) || ((_local_2.getParser() == null)))){
                return;
            };
            var _local_3:FloorHeightMapMessageParser = _local_2.getParser();
            var _local_4:int = this.getRoomId(_local_3.roomId);
            var _local_5:int = this.getRoomCategory(_local_3.roomCategory);
            if (this._SafeStr_13372 == null){
                return;
            };
            var _local_6:LegacyWallGeometry = this._SafeStr_13372.getLegacyGeometry(_local_4, _local_5);
            if (_local_6 == null){
                return;
            };
            this._planeParser.reset();
            var _local_7:int = _local_3.width;
            var _local_8:int = _local_3.height;
            this._planeParser.initializeTileMap(_local_7, _local_8);
            var _local_9:Number = -1;
            var _local_10:Number = -1;
            var _local_11:Number = 0;
            var _local_12:Number = 0;
            var _local_13:Boolean = this.isPublicRoom(_local_4, _local_5);
            var _local_14:TileHeightMap = this._SafeStr_13372.getTileHeightMap(_local_4, _local_5);
            if (_local_14 == null){
                return;
            };
            var _local_15:int;
            while (_local_15 < _local_8) {
                _local_19 = 0;
                while (_local_19 < _local_7) {
                    _local_20 = _local_3.getTileHeight(_local_19, _local_15);
                    if (!_local_13){
                        if ((((((((_local_15 > 0)) && ((_local_15 < (_local_8 - 1))))) || ((((_local_19 > 0)) && ((_local_19 < (_local_7 - 1))))))) && (!((_local_20 == RoomPlaneParser._SafeStr_3802))))){
                            if ((((((_local_3.getTileHeight(_local_19, (_local_15 - 1)) == RoomPlaneParser._SafeStr_3802)) && ((_local_3.getTileHeight((_local_19 - 1), _local_15) == RoomPlaneParser._SafeStr_3802)))) && ((_local_3.getTileHeight(_local_19, (_local_15 + 1)) == RoomPlaneParser._SafeStr_3802)))){
                                _local_9 = (_local_19 + 0.5);
                                _local_10 = _local_15;
                                _local_11 = _local_20;
                                _local_12 = 90;
                                if (!_local_14.isRoomTile((_local_19 + 1), _local_15)){
                                    _local_9 = (_local_9 + 1);
                                };
                            };
                            if ((((((_local_3.getTileHeight(_local_19, (_local_15 - 1)) == RoomPlaneParser._SafeStr_3802)) && ((_local_3.getTileHeight((_local_19 - 1), _local_15) == RoomPlaneParser._SafeStr_3802)))) && ((_local_3.getTileHeight((_local_19 + 1), _local_15) == RoomPlaneParser._SafeStr_3802)))){
                                _local_9 = _local_19;
                                _local_10 = (_local_15 + 0.5);
                                _local_11 = _local_20;
                                _local_12 = 180;
                                if (!_local_14.isRoomTile(_local_19, (_local_15 + 1))){
                                    _local_10 = (_local_10 + 1);
                                };
                            };
                        };
                    };
                    _local_21 = _local_14.isRoomTile(_local_19, _local_15);
                    if (!_local_21){
                        _local_20 = RoomPlaneParser._SafeStr_3802;
                    };
                    this._planeParser.setTileHeight(_local_19, _local_15, _local_20);
                    _local_19++;
                };
                _local_15++;
            };
            if (!_local_13){
                this._planeParser.setTileHeight(Math.floor(_local_9), Math.floor(_local_10), _local_11);
            };
            var _local_16 = (_local_5 == 1);
            if (_local_13){
                _local_16 = true;
            };
            this._planeParser.initializeFromTileData(_local_16);
            if (!_local_13){
                this._planeParser.setTileHeight(Math.floor(_local_9), Math.floor(_local_10), (_local_11 + this._planeParser.wallHeight));
            };
            _local_6.scale = _local_3.scale;
            _local_6.initialize(_local_7, _local_8, this._planeParser.floorHeight);
            var _local_17:int = (_local_3.height - 1);
            while (_local_17 >= 0) {
                _local_22 = (_local_3.width - 1);
                while (_local_22 >= 0) {
                    _local_6.setTileHeight(_local_22, _local_17, this._planeParser.getTileHeight(_local_22, _local_17));
                    _local_22--;
                };
                _local_17--;
            };
            var _local_18:XML = this._planeParser.getXML();
            if (!_local_13){
                _local_23 = new (XML)((("<doors>" + (((((((('<door x="' + _local_9) + '" y="') + _local_10) + '" z="') + _local_11) + '" dir="') + _local_12) + '"/>')) + "</doors>"));
                _local_18.appendChild(_local_23);
            };
            this._SafeStr_13372.initializeRoom(_local_4, _local_5, _local_18);
            if (this._SafeStr_13378.objectData){
                this.addActiveObject(_local_4, _local_5, this._SafeStr_13378.objectData);
                this._SafeStr_13378.objectData = null;
            }
            else {
                this._SafeStr_13378.floorReady = true;
            };
        }
        private function onObjects(_arg_1:IMessageEvent):void
        {
            var _local_8:ObjectMessageData;
            var _local_2:ObjectsMessageEvent = (_arg_1 as ObjectsMessageEvent);
            if ((((_local_2 == null)) || ((_local_2.getParser() == null)))){
                return;
            };
            var _local_3:ObjectsMessageParser = _local_2.getParser();
            var _local_4:int = this.getRoomId(_local_3.roomId);
            var _local_5:int = this.getRoomCategory(_local_3.roomCategory);
            var _local_6:int = _local_3.getObjectCount();
            var _local_7:int;
            while (_local_7 < _local_6) {
                _local_8 = _local_3.getObject(_local_7);
                this.addActiveObject(_local_4, _local_5, _local_8);
                _local_7++;
            };
        }
        private function onPublicRoomObjects(_arg_1:IMessageEvent):void
        {
            var _local_8:PublicRoomObjectMessageData;
            var _local_2:PublicRoomObjectsMessageEvent = (_arg_1 as PublicRoomObjectsMessageEvent);
            if ((((_local_2 == null)) || ((_local_2.getParser() == null)))){
                return;
            };
            var _local_3:PublicRoomObjectsMessageParser = _local_2.getParser();
            var _local_4:int = this.getRoomId(_local_3.roomId);
            var _local_5:int = this.getRoomCategory(_local_3.roomCategory);
            var _local_6:int = _local_3.getObjectCount();
            var _local_7:int;
            while (_local_7 < _local_6) {
                _local_8 = _local_3.getObject(_local_7);
                this.addPassiveObject(_local_4, _local_5, _local_8);
                _local_7++;
            };
        }
        private function onObjectAdd(_arg_1:IMessageEvent):void
        {
            var _local_2:ObjectAddMessageEvent = (_arg_1 as ObjectAddMessageEvent);
            if ((((_local_2 == null)) || ((_local_2.getParser() == null)))){
                return;
            };
            var _local_3:ObjectAddMessageParser = _local_2.getParser();
            var _local_4:int = this.getRoomId(_local_3.roomId);
            var _local_5:int = this.getRoomCategory(_local_3.roomCategory);
            var _local_6:ObjectMessageData = _local_3.data;
            this.addActiveObject(_local_4, _local_5, _local_6);
        }
        private function onObjectInject(_arg_1:IMessageEvent):void
        {
            var _local_2:ViralTeaserActiveMessageEvent = (_arg_1 as ViralTeaserActiveMessageEvent);
            if ((((_local_2 == null)) || ((_local_2.getParser() == null)))){
                return;
            };
            var _local_3:ViralTeaserActiveMessageParser = _local_2.getParser();
            var _local_4:int = this.getRoomId(_local_3.roomId);
            var _local_5:int = this.getRoomCategory(_local_3.roomCategory);
            var _local_6:ObjectMessageData = _local_3.data;
            if (this._SafeStr_13378.floorReady){
                this.addActiveObject(_local_4, _local_5, _local_6);
            }
            else {
                this._SafeStr_13378.objectData = _local_6;
            };
        }
        private function onObjectUpdate(_arg_1:IMessageEvent):void
        {
            var _local_7:IVector3d;
            var _local_8:IVector3d;
            var _local_2:ObjectUpdateMessageEvent = (_arg_1 as ObjectUpdateMessageEvent);
            if ((((_local_2 == null)) || ((_local_2.getParser() == null)))){
                return;
            };
            if (this._SafeStr_13372 == null){
                return;
            };
            var _local_3:ObjectUpdateMessageParser = _local_2.getParser();
            var _local_4:int = this.getRoomId(_local_3.roomId);
            var _local_5:int = this.getRoomCategory(_local_3.roomCategory);
            var _local_6:ObjectMessageData = _local_3.data;
            if (_local_6 != null){
                _local_7 = new Vector3d(_local_6.x, _local_6.y, _local_6.z);
                _local_8 = new Vector3d(_local_6.dir);
                this._SafeStr_13372.updateObjectFurniture(_local_4, _local_5, _local_6.id, _local_7, _local_8, _local_6.state, _local_6.data, _local_6.extra);
            };
        }
        private function onObjectDataUpdate(_arg_1:IMessageEvent):void
        {
            var _local_2:ObjectDataUpdateMessageEvent = (_arg_1 as ObjectDataUpdateMessageEvent);
            if ((((_local_2 == null)) || ((_local_2.getParser() == null)))){
                return;
            };
            if (this._SafeStr_13372 == null){
                return;
            };
            var _local_3:ObjectDataUpdateMessageParser = _local_2.getParser();
            var _local_4:int = this.getRoomId(_local_3.roomId);
            var _local_5:int = this.getRoomCategory(_local_3.roomCategory);
            var _local_6:int = _local_3.id;
            var _local_7:int = _local_3.state;
            var _local_8:String = _local_3.data;
            this._SafeStr_13372.updateObjectFurniture(_local_4, _local_5, _local_6, null, null, _local_7, _local_8);
        }
        private function onObjectsDataUpdate(_arg_1:IMessageEvent):void
        {
            var _local_7:ObjectData;
            var _local_8:int;
            var _local_9:int;
            var _local_10:String;
            var _local_2:ObjectsDataUpdateMessageEvent = (_arg_1 as ObjectsDataUpdateMessageEvent);
            if ((((_local_2 == null)) || ((_local_2.getParser() == null)))){
                return;
            };
            if (this._SafeStr_13372 == null){
                return;
            };
            var _local_3:ObjectsDataUpdateMessageParser = _local_2.getParser();
            var _local_4:int = this.getRoomId(_local_3.roomId);
            var _local_5:int = this.getRoomCategory(_local_3.roomCategory);
            var _local_6:int;
            while (_local_6 < _local_3.objectCount) {
                _local_7 = _local_3.getObjectData(_local_6);
                if (_local_7 != null){
                    _local_8 = _local_7.id;
                    _local_9 = _local_7.state;
                    _local_10 = _local_7.data;
                    this._SafeStr_13372.updateObjectFurniture(_local_4, _local_5, _local_8, null, null, _local_9, _local_10);
                };
                _local_6++;
            };
        }
        private function onObjectRemove(_arg_1:IMessageEvent):void
        {
            var _local_2:ObjectRemoveMessageEvent = (_arg_1 as ObjectRemoveMessageEvent);
            if ((((_local_2 == null)) || ((_local_2.getParser() == null)))){
                return;
            };
            if (this._SafeStr_13372 == null){
                return;
            };
            var _local_3:ObjectRemoveMessageParser = _local_2.getParser();
            var _local_4:int = this.getRoomId(_local_3.roomId);
            var _local_5:int = this.getRoomCategory(_local_3.roomCategory);
            var _local_6:int = _local_3.id;
            this._SafeStr_13372.disposeObjectFurniture(_local_4, _local_5, _local_6);
        }
        private function addActiveObject(_arg_1:int, _arg_2:int, _arg_3:ObjectMessageData):void
        {
            if ((((_arg_3 == null)) || ((this._SafeStr_13372 == null)))){
                return;
            };
            var _local_4:IVector3d = new Vector3d(_arg_3.x, _arg_3.y, _arg_3.z);
            var _local_5:IVector3d = new Vector3d(_arg_3.dir);
            if (_arg_3.staticClass != null){
                this._SafeStr_13372.addObjectFurnitureByName(_arg_1, _arg_2, _arg_3.id, _arg_3.staticClass, _local_4, _local_5, _arg_3.state, _arg_3.data, _arg_3.extra);
            }
            else {
                this._SafeStr_13372.addObjectFurniture(_arg_1, _arg_2, _arg_3.id, _arg_3.type, _local_4, _local_5, _arg_3.state, _arg_3.data, _arg_3.extra, _arg_3.expiryTime, _arg_3.knownAsUsable);
            };
        }
        private function addPassiveObject(_arg_1:int, _arg_2:int, _arg_3:PublicRoomObjectMessageData):void
        {
            if ((((_arg_3 == null)) || ((this._SafeStr_13372 == null)))){
                return;
            };
            var _local_4:IVector3d = new Vector3d(_arg_3.x, _arg_3.y, _arg_3.z);
            var _local_5:IVector3d = new Vector3d(_arg_3.dir);
            var _local_6:int = this.getNextPassiveObjectId();
            this._SafeStr_13372.addObjectFurnitureByName(_arg_1, _arg_2, _local_6, _arg_3.type, _local_4, _local_5, 0, "");
        }
        private function getNextPassiveObjectId():int
        {
            if (this._SafeStr_13375 > 0){
                this._SafeStr_13375 = -1000000000;
            };
            return (--this._SafeStr_13375);
        }
        private function onItems(_arg_1:IMessageEvent):void
        {
            var _local_8:ItemMessageData;
            var _local_2:ItemsMessageEvent = (_arg_1 as ItemsMessageEvent);
            if ((((_local_2 == null)) || ((_local_2.getParser() == null)))){
                return;
            };
            var _local_3:ItemsMessageParser = _local_2.getParser();
            var _local_4:int = this.getRoomId(_local_3.roomId);
            var _local_5:int = this.getRoomCategory(_local_3.roomCategory);
            var _local_6:int = _local_3.getItemCount();
            var _local_7:int;
            while (_local_7 < _local_6) {
                _local_8 = _local_3.getItem(_local_7);
                this.addWallItem(_local_4, _local_5, _local_8);
                _local_7++;
            };
        }
        private function onItemAdd(_arg_1:IMessageEvent):void
        {
            var _local_2:ItemAddMessageEvent = (_arg_1 as ItemAddMessageEvent);
            if ((((_local_2 == null)) || ((_local_2.getParser() == null)))){
                return;
            };
            var _local_3:ItemAddMessageParser = _local_2.getParser();
            var _local_4:int = this.getRoomId(_local_3.roomId);
            var _local_5:int = this.getRoomCategory(_local_3.roomCategory);
            var _local_6:ItemMessageData = _local_3.data;
            if (_local_6 != null){
                this.addWallItem(_local_4, _local_5, _local_6);
            };
        }
        private function onItemRemove(_arg_1:IMessageEvent):void
        {
            var _local_2:ItemRemoveMessageEvent = (_arg_1 as ItemRemoveMessageEvent);
            if ((((_local_2 == null)) || ((_local_2.getParser() == null)))){
                return;
            };
            if (this._SafeStr_13372 == null){
                return;
            };
            var _local_3:ItemRemoveMessageParser = _local_2.getParser();
            var _local_4:int = this.getRoomId(_local_3.roomId);
            var _local_5:int = this.getRoomCategory(_local_3.roomCategory);
            this._SafeStr_13372.disposeObjectWallItem(_local_4, _local_5, _local_3.itemId);
        }
        private function onItemUpdate(_arg_1:IMessageEvent):void
        {
            var _local_8:IVector3d;
            var _local_9:IVector3d;
            var _local_2:ItemUpdateMessageEvent = (_arg_1 as ItemUpdateMessageEvent);
            if ((((_local_2 == null)) || ((_local_2.getParser() == null)))){
                return;
            };
            var _local_3:ItemUpdateMessageParser = _local_2.getParser();
            var _local_4:int = this.getRoomId(_local_3.roomId);
            var _local_5:int = this.getRoomCategory(_local_3.roomCategory);
            var _local_6:LegacyWallGeometry = this._SafeStr_13372.getLegacyGeometry(_local_4, _local_5);
            if ((((this._SafeStr_13372 == null)) || ((_local_6 == null)))){
                return;
            };
            var _local_7:ItemMessageData = _local_3.data;
            if (_local_7 != null){
                _local_8 = _local_6.getLocation(_local_7.wallX, _local_7.wallY, _local_7.localX, _local_7.localY, _local_7.dir);
                _local_9 = new Vector3d(_local_6.getDirection(_local_7.dir));
                this._SafeStr_13372.updateObjectWallItem(_local_4, _local_5, _local_7.id, _local_8, _local_9, _local_7.state, _local_7.data);
            };
        }
        private function onItemDataUpdate(_arg_1:IMessageEvent):void
        {
            var _local_2:ItemDataUpdateMessageEvent = (_arg_1 as ItemDataUpdateMessageEvent);
            if ((((_local_2 == null)) || ((_local_2.getParser() == null)))){
                return;
            };
            var _local_3:ItemDataUpdateMessageParser = _local_2.getParser();
            var _local_4:int = this.getRoomId(_local_3.roomId);
            var _local_5:int = this.getRoomCategory(_local_3.roomCategory);
            this._SafeStr_13372.updateObjectWallItemData(_local_4, _local_5, _local_3.id, _local_3.itemData);
        }
        private function addWallItem(_arg_1:int, _arg_2:int, _arg_3:ItemMessageData):void
        {
            if ((((_arg_3 == null)) || ((this._SafeStr_13372 == null)))){
                return;
            };
            var _local_4:LegacyWallGeometry = this._SafeStr_13372.getLegacyGeometry(_arg_1, _arg_2);
            if (_local_4 == null){
                return;
            };
            var _local_5:IVector3d;
            if (!_arg_3.isOldFormat){
                _local_5 = _local_4.getLocation(_arg_3.wallX, _arg_3.wallY, _arg_3.localX, _arg_3.localY, _arg_3.dir);
            }
            else {
                _local_5 = _local_4.getLocationOldFormat(_arg_3.y, _arg_3.z, _arg_3.dir);
            };
            var _local_6:IVector3d = new Vector3d(_local_4.getDirection(_arg_3.dir));
            this._SafeStr_13372.addObjectWallItem(_arg_1, _arg_2, _arg_3.id, _arg_3.type, _local_5, _local_6, _arg_3.state, _arg_3.data, _arg_3.knownAsUsable);
        }
        private function onUsers(_arg_1:IMessageEvent):void
        {
            var _local_7:UserMessageData;
            var _local_8:IVector3d;
            var _local_9:IVector3d;
            var _local_10:int;
            var _local_2:UsersMessageEvent = (_arg_1 as UsersMessageEvent);
            if ((((_local_2 == null)) || ((_local_2.getParser() == null)))){
                return;
            };
            if (this._SafeStr_13372 == null){
                return;
            };
            var _local_3:UsersMessageParser = _local_2.getParser();
            var _local_4:int = this.getRoomId(_local_3.roomId);
            var _local_5:int = this.getRoomCategory(_local_3.roomCategory);
            var _local_6:int;
            while (_local_6 < _local_3.getUserCount()) {
                _local_7 = _local_3.getUser(_local_6);
                if (_local_7 != null){
                    _local_8 = new Vector3d(_local_7.x, _local_7.y, _local_7.z);
                    _local_9 = new Vector3d(_local_7.dir);
                    _local_10 = _local_7.userType;
                    this._SafeStr_13372.addObjectUser(_local_4, _local_5, _local_7.id, _local_8, _local_9, _local_7.dir, _local_10, _local_7.figure);
                    if (_local_7.webID == this._SafeStr_13373){
                        this._SafeStr_13372.setOwnUserId(_local_4, _local_5, _local_7.id);
                    };
                    this._SafeStr_13372.updateObjectUserFigure(_local_4, _local_5, _local_7.id, _local_7.figure, _local_7.sex, _local_7.subType);
                };
                _local_6++;
            };
        }
        private function onUserUpdate(_arg_1:IMessageEvent):void
        {
            var _local_9:UserUpdateMessageData;
            var _local_10:Number;
            var _local_11:IVector3d;
            var _local_12:IVector3d;
            var _local_13:IVector3d;
            var _local_14:String;
            var _local_15:String;
            var _local_16:Boolean;
            var _local_17:Boolean;
            var _local_18:AvatarActionMessageData;
            var _local_2:UserUpdateMessageEvent = (_arg_1 as UserUpdateMessageEvent);
            if ((((_local_2 == null)) || ((_local_2.getParser() == null)))){
                return;
            };
            if (this._SafeStr_13372 == null){
                return;
            };
            var _local_3:UserUpdateMessageParser = _local_2.getParser();
            var _local_4:int = this.getRoomId(_local_3.roomId);
            var _local_5:int = this.getRoomCategory(_local_3.roomCategory);
            var _local_6:IRoomInstance = this._SafeStr_13372.getRoom(_local_4, _local_5);
            if (_local_6 == null){
                return;
            };
            var _local_7:Number = _local_6.getNumber(RoomVariableEnum._SafeStr_13370);
            var _local_8:int;
            while (_local_8 < _local_3.userUpdateCount) {
                _local_9 = _local_3.getUserUpdateData(_local_8);
                if (_local_9 != null){
                    _local_10 = _local_9.localZ;
                    if (_local_7 != 0){
                        _local_10 = (_local_10 / _local_7);
                    };
                    _local_11 = new Vector3d(_local_9.x, _local_9.y, (_local_9.z + _local_10));
                    _local_12 = new Vector3d(_local_9.dir);
                    _local_13 = null;
                    if (_local_9.isMoving){
                        _local_13 = new Vector3d(_local_9.targetX, _local_9.targetY, _local_9.targetZ);
                    };
                    this._SafeStr_13372.updateObjectUser(_local_4, _local_5, _local_9.id, _local_11, _local_13, _local_12, _local_9.dirHead);
                    _local_14 = RoomObjectVariableEnum._SafeStr_13002;
                    _local_15 = "";
                    this._SafeStr_13372.updateObjectUserFlatControl(_local_4, _local_5, _local_9.id, null);
                    _local_16 = false;
                    _local_17 = false;
                    for each (_local_18 in _local_9.actions) {
                        switch (_local_18.actionType){
                            case "flatctrl":
                                this._SafeStr_13372.updateObjectUserFlatControl(_local_4, _local_5, _local_9.id, _local_18.actionParameter);
                                break;
                            case "sign":
                                this._SafeStr_13372.updateObjectUserAction(_local_4, _local_5, _local_9.id, RoomObjectVariableEnum._SafeStr_6556, int(_local_18.actionParameter));
                                break;
                            case "gst":
                                this._SafeStr_13372.updateObjectPetGesture(_local_4, _local_5, _local_9.id, _local_18.actionParameter);
                                break;
                            case "wav":
                            case "mv":
                                _local_17 = true;
                                _local_14 = _local_18.actionType;
                                _local_15 = _local_18.actionParameter;
                                break;
                            case "swim":
                                _local_16 = true;
                                _local_14 = _local_18.actionType;
                                _local_15 = _local_18.actionParameter;
                                break;
                            case "trd":
                                break;
                            default:
                                _local_14 = _local_18.actionType;
                                _local_15 = _local_18.actionParameter;
                        };
                    };
                    if (((!(_local_17)) && (_local_16))){
                        _local_14 = "float";
                    };
                    this._SafeStr_13372.updateObjectUserPosture(_local_4, _local_5, _local_9.id, _local_14, _local_15);
                };
                _local_8++;
            };
        }
        private function onUserRemove(_arg_1:IMessageEvent):void
        {
            var _local_2:UserRemoveMessageEvent = (_arg_1 as UserRemoveMessageEvent);
            if ((((_local_2 == null)) || ((_local_2.getParser() == null)))){
                return;
            };
            if (this._SafeStr_13372 == null){
                return;
            };
            var _local_3:UserRemoveMessageParser = _local_2.getParser();
            var _local_4:int = this.getRoomId(_local_3.roomId);
            var _local_5:int = this.getRoomCategory(_local_3.roomCategory);
            this._SafeStr_13372.disposeObjectUser(_local_4, _local_5, _local_3.id);
        }
        private function onUserChange(_arg_1:IMessageEvent):void
        {
            var _local_2:UserChangeMessageEvent = (_arg_1 as UserChangeMessageEvent);
            if (_local_2 == null){
                return;
            };
            var _local_3:int = this.getRoomId(_local_2.roomId);
            var _local_4:int = this.getRoomCategory(_local_2.roomCategory);
            this._SafeStr_13372.updateObjectUserFigure(_local_3, _local_4, _local_2.id, _local_2.figure, _local_2.sex);
        }
        private function onWave(_arg_1:IMessageEvent):void
        {
            var _local_2:WaveMessageEvent = (_arg_1 as WaveMessageEvent);
            if ((((_local_2 == null)) || ((_local_2.getParser() == null)))){
                return;
            };
            if (this._SafeStr_13372 == null){
                return;
            };
            var _local_3:WaveMessageParser = _local_2.getParser();
            var _local_4:int = this.getRoomId(_local_3.roomId);
            var _local_5:int = this.getRoomCategory(_local_3.roomCategory);
            var _local_6:int = 1;
            if (!_local_3.isWaving){
                _local_6 = 0;
            };
            this._SafeStr_13372.updateObjectUserAction(_local_4, _local_5, _local_3.userId, RoomObjectVariableEnum._SafeStr_6546, _local_6);
        }
        private function onDance(_arg_1:IMessageEvent):void
        {
            var _local_2:DanceMessageEvent = (_arg_1 as DanceMessageEvent);
            if ((((_local_2 == null)) || ((_local_2.getParser() == null)))){
                return;
            };
            if (this._SafeStr_13372 == null){
                return;
            };
            var _local_3:DanceMessageParser = _local_2.getParser();
            var _local_4:int = this.getRoomId(_local_3.roomId);
            var _local_5:int = this.getRoomCategory(_local_3.roomCategory);
            this._SafeStr_13372.updateObjectUserAction(_local_4, _local_5, _local_3.userId, RoomObjectVariableEnum._SafeStr_6550, _local_3.danceStyle);
        }
        private function onAvatarEffect(_arg_1:IMessageEvent):void
        {
            var _local_2:AvatarEffectMessageEvent = (_arg_1 as AvatarEffectMessageEvent);
            if ((((_local_2 == null)) || ((_local_2.getParser() == null)))){
                return;
            };
            if (this._SafeStr_13372 == null){
                return;
            };
            var _local_3:AvatarEffectMessageParser = _local_2.getParser();
            var _local_4:int = this.getRoomId(_local_3.roomId);
            var _local_5:int = this.getRoomCategory(_local_3.roomCategory);
            this._SafeStr_13372.updateObjectUserEffect(_local_4, _local_5, _local_3.userId, _local_3.effectId, _local_3.delayMilliSeconds);
        }
        private function onAvatarSleep(_arg_1:IMessageEvent):void
        {
            var _local_2:SleepMessageEvent = (_arg_1 as SleepMessageEvent);
            if ((((_local_2 == null)) || ((_local_2.getParser() == null)))){
                return;
            };
            if (this._SafeStr_13372 == null){
                return;
            };
            var _local_3:SleepMessageParser = _local_2.getParser();
            var _local_4:int = this.getRoomId(_local_3.roomId);
            var _local_5:int = this.getRoomCategory(_local_3.roomCategory);
            var _local_6:int = 1;
            if (!_local_3.sleeping){
                _local_6 = 0;
            };
            this._SafeStr_13372.updateObjectUserAction(_local_4, _local_5, _local_3.userId, RoomObjectVariableEnum._SafeStr_4374, _local_6);
        }
        private function onCarryObject(_arg_1:IMessageEvent):void
        {
            var _local_2:CarryObjectMessageParser;
            var _local_3:int;
            var _local_4:int;
            if (this._SafeStr_13372 == null){
                return;
            };
            if ((_arg_1 is CarryObjectMessageEvent)){
                _local_2 = (_arg_1 as CarryObjectMessageEvent).getParser();
                _local_3 = this.getRoomId(_local_2.roomId);
                _local_4 = this.getRoomCategory(_local_2.roomCategory);
                this._SafeStr_13372.updateObjectUserAction(_local_3, _local_4, _local_2.userId, RoomObjectVariableEnum._SafeStr_6552, _local_2.itemType, _local_2.itemName);
            };
        }
        private function onUseObject(_arg_1:IMessageEvent):void
        {
            var _local_2:UseObjectMessageParser;
            var _local_3:int;
            var _local_4:int;
            if (this._SafeStr_13372 == null){
                return;
            };
            if ((_arg_1 is UseObjectMessageEvent)){
                _local_2 = (_arg_1 as UseObjectMessageEvent).getParser();
                _local_3 = this.getRoomId(_local_2.roomId);
                _local_4 = this.getRoomCategory(_local_2.roomCategory);
                this._SafeStr_13372.updateObjectUserAction(_local_3, _local_4, _local_2.userId, RoomObjectVariableEnum._SafeStr_6553, _local_2.itemType);
            };
        }
        private function onSlideUpdate(_arg_1:IMessageEvent):void
        {
            var _local_2:SlideObjectBundleMessageParser;
            var _local_3:int;
            var _local_4:int;
            var _local_5:Array;
            var _local_6:int;
            var _local_7:SlideObjectMessageData;
            var _local_8:SlideObjectMessageData;
            var _local_9:String;
            if (this._SafeStr_13372 == null){
                return;
            };
            if ((_arg_1 is SlideObjectBundleMessageEvent)){
                _local_2 = (_arg_1 as SlideObjectBundleMessageEvent).getParser();
                _local_3 = this.getRoomId(_local_2.roomId);
                _local_4 = this.getRoomCategory(_local_2.roomCategory);
                this._SafeStr_13372.updateObjectFurniture(_local_3, _local_4, _local_2.id, null, null, 1, null);
                this._SafeStr_13372.updateObjectFurniture(_local_3, _local_4, _local_2.id, null, null, 2, null);
                _local_5 = _local_2.objectList;
                _local_6 = 0;
                while (_local_6 < _local_5.length) {
                    _local_7 = _local_5[_local_6];
                    if (_local_7 != null){
                        this._SafeStr_13372.updateObjectFurnitureLocation(_local_3, _local_4, _local_7.id, _local_7.loc, _local_7.target);
                    };
                    _local_6++;
                };
                if (_local_2.avatar != null){
                    _local_8 = _local_2.avatar;
                    this._SafeStr_13372.updateObjectUser(_local_3, _local_4, _local_8.id, _local_8.loc, _local_8.target);
                    switch (_local_8.moveType){
                        case SlideObjectMessageData._SafeStr_3800:
                            _local_9 = "mv";
                            break;
                        case SlideObjectMessageData._moveType:
                            _local_9 = "std";
                            break;
                    };
                    this._SafeStr_13372.updateObjectUserPosture(_local_3, _local_4, _local_8.id, _local_9);
                };
            };
        }
        private function onChat(_arg_1:IMessageEvent):void
        {
            var _local_2:ChatMessageParser;
            if (this._SafeStr_13372 == null){
                return;
            };
            if ((_arg_1 is ChatMessageEvent)){
                _local_2 = (_arg_1 as ChatMessageEvent).getParser();
            }
            else {
                if ((_arg_1 is WhisperMessageEvent)){
                    _local_2 = (_arg_1 as WhisperMessageEvent).getParser();
                }
                else {
                    if ((_arg_1 is ShoutMessageEvent)){
                        _local_2 = (_arg_1 as ShoutMessageEvent).getParser();
                    };
                };
            };
            if (_local_2 == null){
                return;
            };
            var _local_3:int = this.getRoomId(_local_2.roomId);
            var _local_4:int = this.getRoomCategory(_local_2.roomCategory);
            this._SafeStr_13372.updateObjectUserGesture(_local_3, _local_4, _local_2.userId, _local_2.gesture);
            this._SafeStr_13372.updateObjectUserAction(_local_3, _local_4, _local_2.userId, RoomObjectVariableEnum._SafeStr_6545, Math.ceil((_local_2.text.length / 10)));
        }
        private function onTypingStatus(_arg_1:IMessageEvent):void
        {
            var _local_2:UserTypingMessageEvent = (_arg_1 as UserTypingMessageEvent);
            if (_local_2 == null){
                return;
            };
            var _local_3:UserTypingMessageParser = _local_2.getParser();
            var _local_4:int = this.getRoomId(_local_3.roomId);
            var _local_5:int = this.getRoomCategory(_local_3.roomCategory);
            var _local_6:int = 1;
            if (!_local_3.isTyping){
                _local_6 = 0;
            };
            this._SafeStr_13372.updateObjectUserAction(_local_4, _local_5, _local_3.userId, RoomObjectVariableEnum._SafeStr_6548, _local_6);
        }
        private function onPetExperience(_arg_1:PetExperienceEvent):void
        {
            if (_arg_1 == null){
                return;
            };
            var _local_2:PetExperienceParser = _arg_1.getParser();
            var _local_3:int = this.getRoomId(_local_2.roomId);
            var _local_4:int = this.getRoomCategory(_local_2.roomCategory);
            this._SafeStr_13372.updateObjectUserAction(_local_3, _local_4, _local_2.petRoomIndex, RoomObjectVariableEnum._SafeStr_4376, _local_2.gainedExperience);
        }
        private function onDiceValue(_arg_1:IMessageEvent):void
        {
            var _local_2:DiceValueMessageEvent = (_arg_1 as DiceValueMessageEvent);
            if ((((_local_2 == null)) || ((_local_2.getParser() == null)))){
                return;
            };
            if (this._SafeStr_13372 == null){
                return;
            };
            var _local_3:DiceValueMessageParser = _local_2.getParser();
            var _local_4:int = this.getRoomId(_local_3.roomId);
            var _local_5:int = this.getRoomCategory(_local_3.roomCategory);
            var _local_6:int = _local_3.id;
            var _local_7:int = _local_3.value;
            var _local_8:String = "";
            this._SafeStr_13372.updateObjectFurniture(_local_4, _local_5, _local_6, null, null, _local_7, _local_8);
        }
        private function onOneWayDoorStatus(_arg_1:IMessageEvent):void
        {
            var _local_2:OneWayDoorStatusMessageEvent = (_arg_1 as OneWayDoorStatusMessageEvent);
            if ((((_local_2 == null)) || ((_local_2.getParser() == null)))){
                return;
            };
            if (this._SafeStr_13372 == null){
                return;
            };
            var _local_3:OneWayDoorStatusMessageParser = _local_2.getParser();
            var _local_4:int = this.getRoomId(_local_3.roomId);
            var _local_5:int = this.getRoomCategory(_local_3.roomCategory);
            var _local_6:int = _local_3.id;
            var _local_7:int = _local_3.status;
            var _local_8:String = "";
            this._SafeStr_13372.updateObjectFurniture(_local_4, _local_5, _local_6, null, null, _local_7, _local_8);
        }
        private function onParkBusDoor(_arg_1:IMessageEvent):void
        {
            var _local_2:ParkBusDoorMessageEvent = (_arg_1 as ParkBusDoorMessageEvent);
            if ((((_local_2 == null)) || ((_local_2.getParser() == null)))){
                return;
            };
            if (this._SafeStr_13372 == null){
                return;
            };
            var _local_3:ParkBusDoorMessageParser = _local_2.getParser();
            var _local_4:int = this.getRoomId(_local_3.roomId);
            var _local_5:int = this.getRoomCategory(_local_3.roomCategory);
            var _local_6:IRoomObject = this._SafeStr_13372.getObjectRoom(_local_4, _local_5);
            if (_local_6 == null){
                return;
            };
            var _local_7:IRoomObjectModelController = (_local_6.getModel() as IRoomObjectModelController);
            if (_local_7 != null){
                _local_7.setNumber(RoomObjectVariableEnum._SafeStr_8505, _local_3.status);
            };
        }
        private function onPlayingGame(_arg_1:YouArePlayingGameMessageEvent):void
        {
            if (_arg_1 == null){
                return;
            };
            var _local_2:YouArePlayingGameMessageParser = _arg_1.getParser();
            var _local_3:int = this.getRoomId(_local_2.roomId);
            var _local_4:int = this.getRoomCategory(_local_2.roomCategory);
            var _local_5:Boolean = _local_2.isPlaying;
            this._SafeStr_13372.setIsPlayingGame(_local_3, _local_4, _local_5);
        }
        private function onGamePlayerNumberValue(_arg_1:IMessageEvent):void
        {
            var _local_2:GamePlayerValueMessageParser;
            var _local_3:int;
            var _local_4:int;
            if (this._SafeStr_13372 == null){
                return;
            };
            if ((_arg_1 is GamePlayerValueMessageEvent)){
                _local_2 = (_arg_1 as GamePlayerValueMessageEvent).getParser();
                _local_3 = this.getRoomId(_local_2.roomId);
                _local_4 = this.getRoomCategory(_local_2.roomCategory);
                this._SafeStr_13372.updateObjectUserAction(_local_3, _local_4, _local_2.userId, RoomObjectVariableEnum._SafeStr_6554, _local_2.value);
            };
        }

    }
}//package com.sulake.habbo.room

// IVector3d = "_-hf" (String#8547, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// _SafeStr_13002 = "_-1mc" (String#18405, DoABC#2)
// getLocationOldFormat = "_-1K8" (String#17279, DoABC#2)
// mapWidth = "_-o8" (String#24195, DoABC#2)
// mapHeight = "_-0xh" (String#16341, DoABC#2)
// setTileBlocking = "_-2eF" (String#20613, DoABC#2)
// setIsRoomTile = "_-0eo" (String#15618, DoABC#2)
// addObjectFurnitureByName = "_-0A-" (String#3757, DoABC#2)
// updateObjectFurniture = "_-136" (String#4935, DoABC#2)
// updateObjectFurnitureLocation = "_-2BD" (String#6272, DoABC#2)
// updateObjectWallItem = "_-1Nf" (String#5305, DoABC#2)
// updateObjectWallItemData = "_-0Op" (String#4066, DoABC#2)
// updateObjectUser = "_-1tl" (String#5916, DoABC#2)
// updateObjectUserFlatControl = "_-TO" (String#8274, DoABC#2)
// updateObjectUserFigure = "_-hw" (String#2161, DoABC#2)
// updateObjectUserAction = "_-2vR" (String#7185, DoABC#2)
// updateObjectPetGesture = "_-2gz" (String#6891, DoABC#2)
// updateObjectRoomVisibilities = "_-0jE" (String#4485, DoABC#2)
// updateObjectRoomPlaneThicknesses = "_-25z" (String#6160, DoABC#2)
// setRoomObjectAlias = "_-3Kt" (String#7720, DoABC#2)
// getLegacyGeometry = "_-0UL" (String#1485, DoABC#2)
// getTileHeightMap = "_-0Hd" (String#1444, DoABC#2)
// _SafeStr_13370 = "_-2PV" (String#20023, DoABC#2)
// _SafeStr_13372 = "_-0jw" (String#15826, DoABC#2)
// _SafeStr_13373 = "_-0MC" (String#14923, DoABC#2)
// _SafeStr_13374 = "_-2wg" (String#21334, DoABC#2)
// _SafeStr_13375 = "_-2Au" (String#19439, DoABC#2)
// _roomId = "_-005" (String#14056, DoABC#2)
// _roomCategory = "_-1T9" (String#17631, DoABC#2)
// _SafeStr_13378 = "_-122" (String#16538, DoABC#2)
// setCurrentRoom = "_-0HS" (String#14737, DoABC#2)
// disposeRoom = "_-2ya" (String#904, DoABC#2)
// resetCurrentRoom = "_-1wU" (String#18820, DoABC#2)
// getRoomId = "_-2gw" (String#6889, DoABC#2)
// getRoomCategory = "_-0Mn" (String#4018, DoABC#2)
// isPublicRoom = "_-18W" (String#1625, DoABC#2)
// onOwnUserEvent = "_-L0" (String#23047, DoABC#2)
// onRoomProperty = "_-bT" (String#23692, DoABC#2)
// onFloorHeightMap = "_-235" (String#19137, DoABC#2)
// onHeightMap = "_-2ZR" (String#20415, DoABC#2)
// onHeightMapUpdate = "_-1mB" (String#18387, DoABC#2)
// onRoomVisualizationSettings = "_-1kj" (String#18319, DoABC#2)
// onFurnitureAliases = "_-1dN" (String#18030, DoABC#2)
// onObjects = "_-ZT" (String#23614, DoABC#2)
// onPublicRoomObjects = "_-3Bv" (String#21956, DoABC#2)
// onObjectAdd = "_-0mO" (String#15912, DoABC#2)
// onObjectInject = "_-09w" (String#14444, DoABC#2)
// onObjectDataUpdate = "_-nP" (String#24167, DoABC#2)
// onObjectsDataUpdate = "_-15h" (String#16683, DoABC#2)
// onObjectRemove = "_-uz" (String#8784, DoABC#2)
// onItems = "_-0Ze" (String#15428, DoABC#2)
// onItemAdd = "_-zH" (String#24664, DoABC#2)
// onItemRemove = "_-VU" (String#23471, DoABC#2)
// onItemUpdate = "_-0a7" (String#15444, DoABC#2)
// onItemDataUpdate = "_-2MS" (String#19904, DoABC#2)
// onUserUpdate = "_-1L0" (String#17313, DoABC#2)
// onWave = "_-Py" (String#23248, DoABC#2)
// onAvatarEffect = "_-18L" (String#16789, DoABC#2)
// onAvatarSleep = "_-6t" (String#22495, DoABC#2)
// onCarryObject = "_-2HU" (String#19705, DoABC#2)
// onUseObject = "_-2FJ" (String#19616, DoABC#2)
// onSlideUpdate = "_-Fw" (String#22849, DoABC#2)
// onChat = "_-FD" (String#22822, DoABC#2)
// onTypingStatus = "_-368" (String#21735, DoABC#2)
// onDiceValue = "_-1GV" (String#17135, DoABC#2)
// onOneWayDoorStatus = "_-2q" (String#21080, DoABC#2)
// onParkBusDoor = "_-2Zt" (String#20435, DoABC#2)
// onPetExperience = "_-191" (String#16818, DoABC#2)
// onPlayingGame = "_-qV" (String#24292, DoABC#2)
// onGamePlayerNumberValue = "_-0Oq" (String#15019, DoABC#2)
// setWorldType = "_-qZ" (String#8718, DoABC#2)
// setTileHeightMap = "_-36n" (String#7446, DoABC#2)
// addActiveObject = "_-D7" (String#22734, DoABC#2)
// addPassiveObject = "_-v-" (String#24490, DoABC#2)
// getNextPassiveObjectId = "_-3Gt" (String#22158, DoABC#2)
// addWallItem = "_-12t" (String#16576, DoABC#2)
// setOwnUserId = "_-0on" (String#4611, DoABC#2)
// getRoom = "_-1jg" (String#1750, DoABC#2)
// getObjectRoom = "_-1HB" (String#5193, DoABC#2)
// setIsPlayingGame = "_-tM" (String#8756, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// IRoomInstance = "_-1j8" (String#5739, DoABC#2)
// IRoomObjectModelController = "_-1yp" (String#6010, DoABC#2)
// UserObjectMessageParser = "_-04X" (String#14223, DoABC#2)
// UserChangeMessageEvent = "_-a9" (String#23638, DoABC#2)
// RoomReadyMessageEvent = "_-1uW" (String#5930, DoABC#2)
// UserObjectEvent = "_-1HL" (String#17163, DoABC#2)
// RoomReadyMessageParser = "_-1zm" (String#18958, DoABC#2)
// LegacyWallGeometry = "_-2Nh" (String#6515, DoABC#2)
// TileHeightMap = "_-0Bg" (String#3789, DoABC#2)
// RoomVariableEnum = "_-0J6" (String#14804, DoABC#2)
// RoomMessageHandler = "_-2kZ" (String#6967, DoABC#2)
// RoomPlaneParser = "_-2Ya" (String#6737, DoABC#2)
// ShoutMessageEvent = "_-Gi" (String#22877, DoABC#2)
// ChatMessageEvent = "_-f7" (String#23850, DoABC#2)
// ChatMessageParser = "_-06O" (String#3689, DoABC#2)
// WhisperMessageEvent = "_-h1" (String#23932, DoABC#2)
// UserRemoveMessageParser = "_-0h" (String#4445, DoABC#2)
// UsersMessageParser = "_-3Iv" (String#7687, DoABC#2)
// UserRemoveMessageEvent = "_-2U" (String#20197, DoABC#2)
// DanceMessageEvent = "_-1dk" (String#18047, DoABC#2)
// UserMessageData = "_-0WX" (String#4238, DoABC#2)
// UsersMessageEvent = "_-2MA" (String#19891, DoABC#2)
// DanceMessageParser = "_-1U0" (String#5432, DoABC#2)
// ObjectRemoveMessageEvent = "_-36g" (String#21754, DoABC#2)
// ObjectRemoveMessageParser = "_-06f" (String#3694, DoABC#2)
// SleepMessageEvent = "_-0J0" (String#14800, DoABC#2)
// ItemRemoveMessageEvent = "_-ex" (String#23842, DoABC#2)
// UserTypingMessageEvent = "_-2Q8" (String#20050, DoABC#2)
// RoomPropertyMessageEvent = "_-1oS" (String#18475, DoABC#2)
// PublicRoomObjectsMessageEvent = "_-25B" (String#6145, DoABC#2)
// ObjectDataUpdateMessageEvent = "_-344" (String#21661, DoABC#2)
// OneWayDoorStatusMessageEvent = "_-316" (String#21542, DoABC#2)
// YouArePlayingGameMessageEvent = "_-0ti" (String#16191, DoABC#2)
// GamePlayerValueMessageEvent = "_-Y5" (String#23566, DoABC#2)
// HeightMapMessageEvent = "_-06-" (String#14282, DoABC#2)
// ItemsMessageEvent = "_-2YD" (String#20365, DoABC#2)
// CarryObjectMessageEvent = "_-0Fw" (String#14680, DoABC#2)
// UserUpdateMessageEvent = "_-0CW" (String#14549, DoABC#2)
// ObjectsMessageEvent = "_-22v" (String#19131, DoABC#2)
// FloorHeightMapMessageEvent = "_-1x5" (String#18851, DoABC#2)
// RoomVisualizationSettingsEvent = "_-2ra" (String#21140, DoABC#2)
// HeightMapUpdateMessageEvent = "_-2Rn" (String#20111, DoABC#2)
// AvatarEffectMessageEvent = "_-1Cw" (String#16979, DoABC#2)
// ParkBusDoorMessageEvent = "_-2UD" (String#20208, DoABC#2)
// GetRoomEntryDataMessageComposer = "_-2cs" (String#20559, DoABC#2)
// ItemAddMessageEvent = "_-1TD" (String#17633, DoABC#2)
// ObjectAddMessageEvent = "_-2WR" (String#20302, DoABC#2)
// PetExperienceEvent = "_-1NJ" (String#17410, DoABC#2)
// GetFurnitureAliasesMessageComposer = "_-2vb" (String#21299, DoABC#2)
// ObjectsDataUpdateMessageEvent = "_-2Gx" (String#6385, DoABC#2)
// ItemDataUpdateMessageEvent = "_-2ga" (String#20714, DoABC#2)
// UseObjectMessageEvent = "_-0WA" (String#15286, DoABC#2)
// ItemUpdateMessageEvent = "_-39z" (String#21884, DoABC#2)
// WaveMessageEvent = "_-47" (String#22383, DoABC#2)
// SlideObjectBundleMessageEvent = "_-35" (String#21695, DoABC#2)
// FurnitureAliasesMessageEvent = "_-11g" (String#16524, DoABC#2)
// ObjectUpdateMessageEvent = "_-06L" (String#14301, DoABC#2)
// DiceValueMessageEvent = "_-1xp" (String#18881, DoABC#2)
// ViralTeaserActiveMessageEvent = "_-2mO" (String#20934, DoABC#2)
// PublicRoomObjectMessageData = "_-6" (String#7780, DoABC#2)
// DiceValueMessageParser = "_-2pq" (String#7073, DoABC#2)
// ItemUpdateMessageParser = "_-1-a" (String#4859, DoABC#2)
// ItemDataUpdateMessageParser = "_-0t7" (String#4709, DoABC#2)
// UserUpdateMessageData = "_-2GW" (String#6378, DoABC#2)
// AvatarEffectMessageParser = "_-17O" (String#5023, DoABC#2)
// ItemMessageData = "_-1Nr" (String#5309, DoABC#2)
// ObjectUpdateMessageParser = "_-3Da" (String#7589, DoABC#2)
// SlideObjectMessageData = "_-Q2" (String#8200, DoABC#2)
// ItemAddMessageParser = "_-2kB" (String#6957, DoABC#2)
// ObjectAddMessageParser = "_-0Cc" (String#3802, DoABC#2)
// UseObjectMessageParser = "_-0la" (String#4537, DoABC#2)
// ObjectsMessageParser = "_-25T" (String#6150, DoABC#2)
// RoomPropertyMessageParser = "_-fP" (String#8503, DoABC#2)
// GamePlayerValueMessageParser = "_-2M3" (String#6485, DoABC#2)
// YouArePlayingGameMessageParser = "_-0w-" (String#4768, DoABC#2)
// HeightMapMessageParser = "_-2Bb" (String#6278, DoABC#2)
// ObjectsDataUpdateMessageParser = "_-fN" (String#8502, DoABC#2)
// CarryObjectMessageParser = "_-2TI" (String#6629, DoABC#2)
// PublicRoomObjectsMessageParser = "_-if" (String#8570, DoABC#2)
// SleepMessageParser = "_-pi" (String#8702, DoABC#2)
// ParkBusDoorMessageParser = "_-1pC" (String#5843, DoABC#2)
// WaveMessageParser = "_-1ck" (String#5615, DoABC#2)
// HeightMapUpdateMessageParser = "_-1HT" (String#5198, DoABC#2)
// UserTypingMessageParser = "_-0cL" (String#4351, DoABC#2)
// ItemRemoveMessageParser = "_-01N" (String#3589, DoABC#2)
// FurnitureAliasesMessageParser = "_-1bc" (String#5591, DoABC#2)
// SlideObjectBundleMessageParser = "_-255" (String#6143, DoABC#2)
// FloorHeightMapMessageParser = "_-9G" (String#7849, DoABC#2)
// ObjectDataUpdateMessageParser = "_-2K4" (String#6444, DoABC#2)
// ObjectMessageData = "_-0jV" (String#4490, DoABC#2)
// ViralTeaserActiveMessageParser = "_-36i" (String#7444, DoABC#2)
// ItemsMessageParser = "_-0XF" (String#4254, DoABC#2)
// ObjectData = "_-D" (String#7932, DoABC#2)
// AvatarActionMessageData = "_-iI" (String#8562, DoABC#2)
// PetExperienceParser = "_-1-V" (String#4858, DoABC#2)
// OneWayDoorStatusMessageParser = "_-0CN" (String#3797, DoABC#2)
// RoomVisualizationSettingsParser = "_-1vY" (String#5952, DoABC#2)
// UserUpdateMessageParser = "_-2BT" (String#6276, DoABC#2)
// userType = "_-0Dh" (String#14596, DoABC#2)
// itemType = "_-De" (String#22756, DoABC#2)
// isTyping = "_-1wh" (String#18831, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// onObjectUpdate = "_-2l-" (String#248, DoABC#2)
// getUserCount = "_-xV" (String#24590, DoABC#2)
// getUser = "_-0C8" (String#14534, DoABC#2)
// webID = "_-2uI" (String#7166, DoABC#2)
// sex = "_-0tG" (String#4712, DoABC#2)
// subType = "_-uO" (String#24467, DoABC#2)
// itemData = "_-1S3" (String#17584, DoABC#2)
// getObjectCount = "_-09y" (String#1415, DoABC#2)
// getObject = "_-1GT" (String#844, DoABC#2)
// floorType = "_-1D4" (String#16985, DoABC#2)
// wallType = "_-0n5" (String#15942, DoABC#2)
// landscapeType = "_-29h" (String#19391, DoABC#2)
// getTileHeight = "_-0Kq" (String#14872, DoABC#2)
// getTileBlocking = "_-2o1" (String#21002, DoABC#2)
// isRoomTile = "_-3Dl" (String#22024, DoABC#2)
// objectCount = "_-2Yw" (String#20393, DoABC#2)
// getObjectData = "_-1Bi" (String#16930, DoABC#2)
// aliasCount = "_-2Xv" (String#20355, DoABC#2)
// getName = "_-D1" (String#931, DoABC#2)
// getAlias = "_-30C" (String#21508, DoABC#2)
// objectList = "_-1qv" (String#18577, DoABC#2)
// _SafeStr_3800 = "_-0hj" (String#15737, DoABC#2)
// _moveType = "_-0q-" (String#16051, DoABC#2)
// _SafeStr_3802 = "_-v4" (String#24495, DoABC#2)
// getItemCount = "_-1vN" (String#18772, DoABC#2)
// getItem = "_-0un" (String#16229, DoABC#2)
// wallsHidden = "_-Nd" (String#23150, DoABC#2)
// wallThicknessMultiplier = "_-0wt" (String#16306, DoABC#2)
// floorThicknessMultiplier = "_-1NT" (String#17417, DoABC#2)
// userUpdateCount = "_-a6" (String#23635, DoABC#2)
// getUserUpdateData = "_-lO" (String#24083, DoABC#2)
// wallX = "_-0Jc" (String#14826, DoABC#2)
// wallY = "_-2VK" (String#20254, DoABC#2)
// extra = "_-2We" (String#6693, DoABC#2)
// expiryTime = "_-1FG" (String#17083, DoABC#2)
// staticClass = "_-1HW" (String#17170, DoABC#2)
// _SafeStr_4374 = "_-GG" (String#22862, DoABC#2)
// _SafeStr_4376 = "_-0Bp" (String#14520, DoABC#2)
// danceStyle = "_-0M0" (String#14915, DoABC#2)
// initializeTileMap = "_-yM" (String#24629, DoABC#2)
// initializeFromTileData = "_-34W" (String#21678, DoABC#2)
// initializeRoom = "_-1SM" (String#1690, DoABC#2)
// getXML = "_-2Oe" (String#6532, DoABC#2)
// disposeObjectFurniture = "_-0Sj" (String#1477, DoABC#2)
// disposeObjectWallItem = "_-0aH" (String#1502, DoABC#2)
// disposeObjectUser = "_-Jw" (String#2086, DoABC#2)
// addObjectFurniture = "_-0G1" (String#1439, DoABC#2)
// addObjectWallItem = "_-J0" (String#2084, DoABC#2)
// addObjectUser = "_-0kK" (String#1540, DoABC#2)
// updateObjectUserGesture = "_-0Yi" (String#1498, DoABC#2)
// updateObjectUserEffect = "_-3-m" (String#1983, DoABC#2)
// updateObjectUserPosture = "_-356" (String#1995, DoABC#2)
// updateObjectRoom = "_-DR" (String#2076, DoABC#2)
// localZ = "_-qW" (String#24293, DoABC#2)
// targetX = "_-1J9" (String#17243, DoABC#2)
// targetY = "_-3HE" (String#22172, DoABC#2)
// targetZ = "_-0iJ" (String#15764, DoABC#2)
// dirHead = "_-2Ej" (String#19594, DoABC#2)
// isMoving = "_-2Cl" (String#19515, DoABC#2)
// isOldFormat = "_-0A1" (String#14448, DoABC#2)
// loc = "_-0fh" (String#15660, DoABC#2)
// actionParameter = "_-2Oa" (String#6531, DoABC#2)
// effectId = "_-0jW" (String#15809, DoABC#2)
// onUsers = "_-1eu" (String#1735, DoABC#2)
// onUserRemove = "_-2FD" (String#6347, DoABC#2)
// onUserChange = "_-0uf" (String#827, DoABC#2)
// onDance = "_-1cS" (String#5609, DoABC#2)
// onRoomReady = "_-0KO" (String#583, DoABC#2)
// _SafeStr_6545 = "_-2IW" (String#19747, DoABC#2)
// _SafeStr_6546 = "_-n1" (String#24155, DoABC#2)
// _SafeStr_6548 = "_-09g" (String#14434, DoABC#2)
// _SafeStr_6550 = "_-aD" (String#23641, DoABC#2)
// _SafeStr_6552 = "_-0ig" (String#15779, DoABC#2)
// _SafeStr_6553 = "_-2wB" (String#21318, DoABC#2)
// _SafeStr_6554 = "_-4J" (String#22390, DoABC#2)
// _SafeStr_6556 = "_-02t" (String#14155, DoABC#2)
// isPlaying = "_-2gK" (String#6876, DoABC#2)
// petRoomIndex = "_-ij" (String#23987, DoABC#2)
// gainedExperience = "_-7m" (String#22533, DoABC#2)
// isWaving = "_-0Ph" (String#15050, DoABC#2)
// delayMilliSeconds = "_-Rk" (String#23313, DoABC#2)
// itemName = "_-1cf" (String#17996, DoABC#2)
// _SafeStr_8505 = "_-2k3" (String#20848, DoABC#2)
// sleeping = "_-2cl" (String#20555, DoABC#2)


