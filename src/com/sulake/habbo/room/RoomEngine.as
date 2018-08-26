
package com.sulake.habbo.room
{
    import com.sulake.core.runtime.Component;
    import com.sulake.room.IRoomManagerListener;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.room.IRoomManager;
    import com.sulake.room.renderer.IRoomRendererFactory;
    import com.sulake.room.IRoomObjectFactory;
    import com.sulake.room.object.IRoomObjectVisualizationFactory;
    import com.sulake.habbo.advertisement.IAdManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.room.utils.NumberBank;
    import com.sulake.core.utils.Map;
    import flash.display.DisplayObjectContainer;
    import flash.display.LoaderInfo;
    import com.sulake.iid.IIDRoomObjectFactory;
    import com.sulake.iid.IIDRoomObjectVisualizationFactory;
    import com.sulake.iid.IIDRoomManager;
    import com.sulake.iid.IIDRoomRendererFactory;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboAdManager;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDHabboRoomSessionManager;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.core.runtime.IContext;
    import com.sulake.habbo.room.utils.RoomInstanceData;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.habbo.room.utils.TileHeightMap;
    import com.sulake.habbo.room.utils.LegacyWallGeometry;
    import com.sulake.habbo.room.utils.RoomCamera;
    import com.sulake.habbo.room.utils.SelectedRoomObjectData;
    import com.sulake.room.IRoomInstance;
    import flash.ui.Mouse;
    import flash.ui.MouseCursor;
    import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import com.sulake.room.object.IRoomObjectController;
    import com.sulake.habbo.room.messages.RoomObjectRoomFloorHoleUpdateMessage;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.room.utils.FurnitureData;
    import flash.utils.getTimer;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.renderer.IRoomRenderingCanvas;
    import flash.geom.Rectangle;
    import com.sulake.room.utils.Vector3d;
    import flash.geom.Point;
    import flash.geom.Matrix;
    import com.sulake.room.utils.RoomGeometry;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import flash.events.Event;
    import com.sulake.habbo.advertisement.events.AdEvent;
    import com.sulake.habbo.session.events.RoomSessionEvent;
    import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
    import com.sulake.habbo.room.utils.RoomData;
    import com.sulake.habbo.room.events.RoomEngineEvent;
    import com.sulake.habbo.room.messages.RoomObjectRoomUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectRoomMaskUpdateMessage;
    import com.sulake.room.utils.XMLValidator;
    import com.sulake.habbo.room.messages.RoomObjectRoomColorUpdateMessage;
    import com.sulake.habbo.room.events.RoomEngineRoomColorEvent;
    import com.sulake.habbo.room.messages.RoomObjectRoomPlaneVisibilityUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectRoomPlanePropertyUpdateMessage;
    import flash.display.Sprite;
    import com.sulake.room.renderer.IRoomRenderer;
    import flash.display.DisplayObject;
    import com.sulake.room.utils.IRoomGeometry;
    import flash.events.MouseEvent;
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.habbo.room.events.RoomEngineObjectEvent;
    import com.sulake.room.events.RoomObjectMouseEvent;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import com.sulake.room.object.logic.IRoomObjectEventHandler;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectMoveUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectItemDataUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarFigureUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarFlatControlUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectUpdateStateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarChatUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarWaveUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarSleepUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarTypingUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarCarryObjectUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarUseObjectUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarDanceUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarExperienceUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarPlayerValueUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarSignUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarPostureUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarGestureUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarPetGestureUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarEffectUpdateMessage;
    import com.sulake.habbo.room.object.RoomPlaneParser;
    import com.sulake.room.object.visualization.IRoomObjectSpriteVisualization;
    import com.sulake.room.object.visualization.IRoomObjectVisualization;
    import com.sulake.habbo.room.messages.RoomObjectRoomAdUpdateMessage;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.iid.*;
    import com.sulake.room.object.*;

    public class RoomEngine extends Component implements IRoomEngine, IRoomManagerListener, IRoomCreator, IRoomEngineServices, IUpdateReceiver 
    {

        private static const _SafeStr_13436:String = "temporary_room";
        private static const _SafeStr_13437:int = -1;
        private static const _SafeStr_13438:String = "room";
        private static const _SafeStr_13439:int = -2;
        private static const _SafeStr_13440:String = "tile_cursor";
        private static const _SafeStr_13441:int = -3;
        private static const _SafeStr_13442:String = "selection_arrow";
        private static const OVERLAY_SPRITE:String = "overlay";
        private static const _SafeStr_13443:String = "object_icon_sprite";
        private static const _SafeStr_13444:int = 15;
        private static const _SafeStr_13445:int = 40;

        private var _communication:IHabboCommunicationManager = null;
        private var _connection:IConnection = null;
        private var _roomManager:IRoomManager = null;
        private var _roomRendererFactory:IRoomRendererFactory = null;
        private var _SafeStr_13446:IRoomObjectFactory = null;
        private var _visualizationFactory:IRoomObjectVisualizationFactory = null;
        private var _adManager:IAdManager = null;
        private var _sessionDataManager:ISessionDataManager = null;
        private var _roomSessionManager:IRoomSessionManager = null;
        private var _toolbar:IHabboToolbar = null;
        private var _habboConfiguration:IHabboConfigurationManager;
        private var _SafeStr_13448:RoomObjectEventHandler = null;
        private var _SafeStr_13449:RoomMessageHandler = null;
        private var _SafeStr_13450:RoomContentLoader = null;
        private var _SafeStr_13451:Boolean = false;
        private var _SafeStr_13452:NumberBank;
        private var _SafeStr_13453:Map;
        private var _isInitialized:Boolean = false;
        private var _activeRoomId:int = 0;
        private var _activeRoomCategory:int = 0;
        private var _SafeStr_13457:int = -1;
        private var _SafeStr_13458:int = 0;
        private var _SafeStr_13459:int = 0;
        private var _SafeStr_13460:Boolean = false;
        private var _SafeStr_13461:Boolean = false;
        private var _SafeStr_13462:int = 0;
        private var _SafeStr_13463:int = 0;
        private var _SafeStr_13464:int = 0;
        private var _SafeStr_13465:int = 0;
        private var _SafeStr_13466:Boolean = false;
        private var _SafeStr_13467:Map = null;
        private var _SafeStr_13468:Map = null;
        private var _SafeStr_13469:Boolean = false;
        private var _SafeStr_13470:Array;
        private var _SafeStr_13471:Boolean;

        public function RoomEngine(_arg_1:IContext, _arg_2:uint=0)
        {
            this._SafeStr_13470 = new Array();
            super(_arg_1, _arg_2);
            this._SafeStr_13468 = new Map();
            this._SafeStr_13452 = new NumberBank(1000);
            this._SafeStr_13453 = new Map();
            this._SafeStr_13467 = new Map();
            this._SafeStr_13448 = new RoomObjectEventHandler(this);
            this._SafeStr_13449 = new RoomMessageHandler(this);
            var _local_3:DisplayObjectContainer = _arg_1.displayObjectContainer;
            var _local_4:LoaderInfo = _local_3.loaderInfo;
            this._SafeStr_13450 = new RoomContentLoader(_local_4.loaderURL);
            queueInterface(new IIDRoomObjectFactory(), this.RoomEngine);
            queueInterface(new IIDRoomObjectVisualizationFactory(), this.RoomEngine);
            queueInterface(new IIDRoomManager(), this.RoomEngine);
            queueInterface(new IIDRoomRendererFactory(), this.RoomEngine);
            queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationReady);
            queueInterface(new IIDHabboConfigurationManager(), this.RoomEngine);
            queueInterface(new IIDHabboAdManager(), this.onAdManagerReady);
            queueInterface(new IIDSessionDataManager(), this.onSessionDataManagerReady);
            queueInterface(new IIDHabboRoomSessionManager(), this.onRoomSessionManagerReady);
            queueInterface(new IIDHabboToolbar(), this.onToolbarReady);
            this.initialize();
            IContext(this, 1);
        }
        public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }
        public function get roomManager():IRoomManager
        {
            return (this._roomManager);
        }
        public function get connection():IConnection
        {
            return (this._connection);
        }
        public function get activeRoomId():int
        {
            return (this._activeRoomId);
        }
        public function get activeRoomCategory():int
        {
            return (this._activeRoomCategory);
        }
        private function get useOffsetScrolling():Boolean
        {
            return (true);
        }
        public function RoomEngine(_arg_1:String):Boolean
        {
            if (this._SafeStr_13450 != null){
                return (this._SafeStr_13450.RoomEngine(_arg_1));
            };
            return (false);
        }
        override public function dispose():void
        {
            var _local_1:int;
            var _local_2:RoomInstanceData;
            removeUpdateReceiver(this);
            if (this._SafeStr_13446 != null){
                this._SafeStr_13446.release(new IIDRoomObjectFactory());
                this._SafeStr_13446 = null;
            };
            if (this._visualizationFactory != null){
                this._visualizationFactory.release(new IIDRoomObjectVisualizationFactory());
                this._visualizationFactory = null;
            };
            if (this._roomManager != null){
                this._roomManager.release(new IIDRoomManager());
                this._roomManager = null;
            };
            if (this._roomRendererFactory != null){
                this._roomRendererFactory.release(new IIDRoomRendererFactory());
                this._roomRendererFactory = null;
            };
            if (this._communication != null){
                this._communication.release(new IIDHabboCommunicationManager());
                this._communication = null;
            };
            if (this._habboConfiguration != null){
                this._habboConfiguration.release(new IIDHabboConfigurationManager());
                this._habboConfiguration = null;
            };
            if (this._toolbar != null){
                this._toolbar.events.removeEventListener(HabboToolbarEvent.HTE_TOOLBAR_CLICK, this.RoomEngine);
                this._toolbar.release(new IIDHabboToolbar());
                this._toolbar = null;
            };
            if (this._adManager){
                this._adManager.release(new IIDHabboAdManager());
                this._adManager = null;
            };
            if (this._sessionDataManager){
                this._sessionDataManager.release(new IIDSessionDataManager());
                this._sessionDataManager = null;
            };
            if (this._roomSessionManager){
                this._roomSessionManager.release(new IIDHabboRoomSessionManager());
                this._roomSessionManager = null;
            };
            this._connection = null;
            if (this._SafeStr_13452 != null){
                this._SafeStr_13452.dispose();
                this._SafeStr_13452 = null;
            };
            if (this._SafeStr_13453 != null){
                this._SafeStr_13453.dispose();
            };
            if (this._SafeStr_13448 != null){
                this._SafeStr_13448.dispose();
                this._SafeStr_13448 = null;
            };
            if (this._SafeStr_13449 != null){
                this._SafeStr_13449.dispose();
                this._SafeStr_13449 = null;
            };
            if (this._SafeStr_13450 != null){
                this._SafeStr_13450.dispose();
                this._SafeStr_13450 = null;
            };
            if (this._SafeStr_13467 != null){
                this._SafeStr_13467.dispose();
                this._SafeStr_13467 = null;
            };
            if (this._SafeStr_13468 != null){
                _local_1 = 0;
                while (_local_1 < this._SafeStr_13468.length) {
                    _local_2 = (this._SafeStr_13468.getWithIndex(_local_1) as RoomInstanceData);
                    if (_local_2 != null){
                        _local_2.dispose();
                    };
                    _local_1++;
                };
                this._SafeStr_13468.dispose();
                this._SafeStr_13468 = null;
            };
            super.dispose();
        }
        private function initialize():void
        {
        }
        private function RoomEngine(_arg_1:int, _arg_2:int):RoomInstanceData
        {
            var _local_3:String = this.getRoomIdentifier(_arg_1, _arg_2);
            var _local_4:RoomInstanceData;
            if (this._SafeStr_13468 != null){
                _local_4 = (this._SafeStr_13468.getValue(_local_3) as RoomInstanceData);
                if (_local_4 == null){
                    _local_4 = new RoomInstanceData(_arg_1, _arg_2);
                    this._SafeStr_13468.add(_local_3, _local_4);
                };
            };
            return (_local_4);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:TileHeightMap):void
        {
            var _local_4:RoomInstanceData = this.RoomEngine(_arg_1, _arg_2);
            if (_local_4 != null){
                _local_4.tileHeightMap = _arg_3;
            };
        }
        public function RoomEngine(_arg_1:int, _arg_2:int):TileHeightMap
        {
            var _local_3:RoomInstanceData = this.RoomEngine(_arg_1, _arg_2);
            if (_local_3 != null){
                return (_local_3.tileHeightMap);
            };
            return (null);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:String):void
        {
            var _local_4:RoomInstanceData = this.RoomEngine(_arg_1, _arg_2);
            if (_local_4 != null){
                _local_4.worldType = _arg_3;
            };
        }
        public function RoomEngine(_arg_1:int, _arg_2:int):String
        {
            var _local_3:RoomInstanceData = this.RoomEngine(_arg_1, _arg_2);
            if (_local_3 != null){
                return (_local_3.worldType);
            };
            return (null);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int):LegacyWallGeometry
        {
            var _local_3:RoomInstanceData = this.RoomEngine(_arg_1, _arg_2);
            if (_local_3 != null){
                return (_local_3.legacyGeometry);
            };
            return (null);
        }
        private function RoomEngine():RoomCamera
        {
            return (this.RoomEngine(this._activeRoomId, this._activeRoomCategory));
        }
        private function RoomEngine(_arg_1:int, _arg_2:int):RoomCamera
        {
            var _local_3:RoomInstanceData = this.RoomEngine(_arg_1, _arg_2);
            if (_local_3 != null){
                return (_local_3.roomCamera);
            };
            return (null);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:SelectedRoomObjectData):void
        {
            var _local_4:RoomInstanceData = this.RoomEngine(_arg_1, _arg_2);
            if (_local_4 != null){
                _local_4.selectedObject = _arg_3;
                if (_arg_3 != null){
                    _local_4.placedObject = null;
                };
            };
        }
        public function RoomEngine(_arg_1:int, _arg_2:int):ISelectedRoomObjectData
        {
            var _local_3:RoomInstanceData = this.RoomEngine(_arg_1, _arg_2);
            if (_local_3 != null){
                return (_local_3.selectedObject);
            };
            return (null);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:SelectedRoomObjectData):void
        {
            var _local_4:RoomInstanceData = this.RoomEngine(_arg_1, _arg_2);
            if (_local_4 != null){
                _local_4.placedObject = _arg_3;
            };
        }
        public function RoomEngine(_arg_1:int, _arg_2:int):ISelectedRoomObjectData
        {
            var _local_3:RoomInstanceData = this.RoomEngine(_arg_1, _arg_2);
            if (_local_3 != null){
                return (_local_3.placedObject);
            };
            return (null);
        }
        public function update(_arg_1:uint):void
        {
            var _local_2:int;
            var _local_3:IRoomInstance;
            if (this._roomManager != null){
                this.RoomEngine();
                this._roomManager.update(_arg_1);
                _local_2 = 0;
                while (_local_2 < this._roomManager.getRoomCount()) {
                    _local_3 = this._roomManager.getRoomWithIndex(_local_2);
                    if (((!((_local_3 == null))) && (!((_local_3.RoomInstance() == null))))){
                        _local_3.RoomInstance().update(_arg_1);
                    };
                    _local_2++;
                };
                this.RoomEngine(_arg_1);
                if (this._SafeStr_13471){
                    this.RoomEngine();
                };
            };
        }
        private function RoomEngine():void
        {
            this._SafeStr_13471 = false;
            if (((this._SafeStr_13470) && ((this._SafeStr_13470.length > 0)))){
                Mouse.cursor = MouseCursor.BUTTON;
            }
            else {
                Mouse.cursor = MouseCursor.ARROW;
            };
            this._SafeStr_13471 = false;
        }
        public function RoomEngine(_arg_1:String, _arg_2:int, _arg_3:String):void
        {
            var _local_4:int = this.RoomEngine(_arg_3);
            switch (_arg_1){
                case RoomObjectFurnitureActionEvent.ROFCAE_MOUSE_BUTTON:
                    this.RoomEngine(_local_4, _arg_2);
                    return;
                default:
                    this.RoomEngine(_local_4, _arg_2);
            };
        }
        private function RoomEngine(_arg_1:int, _arg_2:int):void
        {
            if (!this._SafeStr_13470){
                return;
            };
            var _local_3:IRoomSession = this._roomSessionManager.getSession(this._activeRoomId, this._activeRoomCategory);
            if ((((((_arg_1 == RoomObjectCategoryEnum._SafeStr_4329)) || ((_arg_1 == RoomObjectCategoryEnum._SafeStr_4330)))) && (!(_local_3.isRoomController)))){
                return;
            };
            var _local_4:String = ((_arg_1 + "_") + _arg_2);
            var _local_5:int = this._SafeStr_13470.indexOf(_local_4);
            if (_local_5 == -1){
                this._SafeStr_13470.push(_local_4);
                this._SafeStr_13471 = true;
            };
        }
        private function RoomEngine(_arg_1:int, _arg_2:int):void
        {
            if (!this._SafeStr_13470){
                return;
            };
            var _local_3:String = ((_arg_1 + "_") + _arg_2);
            var _local_4:int = this._SafeStr_13470.indexOf(_local_3);
            if (_local_4 > -1){
                this._SafeStr_13470.splice(_local_4, 1);
                this._SafeStr_13471 = true;
            };
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            var _local_4:IRoomObjectController;
            var _local_5:IRoomObjectController;
            var _local_6:String;
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            if (_arg_3 >= 0){
                _local_4 = this.RoomEngine(_arg_1, _arg_2);
                _local_5 = this.RoomEngine(_arg_1, _arg_2, _arg_3);
                if (((((((!((_local_5 == null))) && (!((_local_5.getModel() == null))))) && (!((_local_4 == null))))) && (!((_local_4.getEventHandler() == null))))){
                    _local_6 = RoomObjectRoomFloorHoleUpdateMessage.RORPFHUM_ADD;
                    _local_7 = _local_5.getLocation().x;
                    _local_8 = _local_5.getLocation().y;
                    _local_9 = _local_5.getModel().getNumber(RoomObjectVariableEnum._SafeStr_12442);
                    _local_10 = _local_5.getModel().getNumber(RoomObjectVariableEnum._SafeStr_12443);
                    _local_4.getEventHandler().processUpdateMessage(new RoomObjectRoomFloorHoleUpdateMessage(_local_6, _arg_3, _local_7, _local_8, _local_9, _local_10));
                };
            };
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            var _local_4:IRoomObjectController;
            var _local_5:String;
            if (_arg_3 >= 0){
                _local_4 = this.RoomEngine(_arg_1, _arg_2);
                if (((!((_local_4 == null))) && (!((_local_4.getEventHandler() == null))))){
                    _local_5 = RoomObjectRoomFloorHoleUpdateMessage.RORPFHUM_REMOVE;
                    _local_4.getEventHandler().processUpdateMessage(new RoomObjectRoomFloorHoleUpdateMessage(_local_5, _arg_3));
                };
            };
        }
        private function RoomEngine():void
        {
            var _local_3:int;
            var _local_4:RoomInstanceData;
            var _local_5:int;
            var _local_6:FurnitureData;
            if (this._SafeStr_13469){
                this._SafeStr_13469 = false;
                return;
            };
            var _local_1:int = getTimer();
            var _local_2:int = 5;
            for each (_local_4 in this._SafeStr_13468) {
                _local_5 = 0;
                _local_6 = null;
                while ((_local_6 = _local_4.getFurnitureData()) != null) {
                    this.RoomEngine(_local_4.roomId, _local_4.roomCategory, _local_6.id, _local_6);
                    if ((++_local_5 % _local_2) == 0){
                        _local_3 = getTimer();
                        if ((_local_3 - _local_1) >= _SafeStr_13445){
                            this._SafeStr_13469 = true;
                            break;
                        };
                    };
                };
                while (((!(this._SafeStr_13469)) && (!(((_local_6 = _local_4.SessionDataManager()) == null))))) {
                    this.RoomEngine(_local_4.roomId, _local_4.roomCategory, _local_6.id, _local_6);
                    if ((++_local_5 % _local_2) == 0){
                        _local_3 = getTimer();
                        if ((_local_3 - _local_1) >= _SafeStr_13445){
                            this._SafeStr_13469 = true;
                            break;
                        };
                    };
                };
                if (this._SafeStr_13469){
                    return;
                };
            };
        }
        private function RoomEngine(_arg_1:uint):void
        {
            var _local_5:RoomInstanceData;
            var _local_6:RoomCamera;
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:IRoomObject;
            var _local_2:int = 1;
            var _local_3:int;
            while (_local_3 < this._SafeStr_13468.length) {
                _local_5 = (this._SafeStr_13468.getWithIndex(_local_3) as RoomInstanceData);
                _local_6 = null;
                _local_7 = 0;
                _local_8 = 0;
                if (_local_5 != null){
                    _local_6 = _local_5.roomCamera;
                    _local_7 = _local_5.roomId;
                    _local_8 = _local_5.roomCategory;
                };
                if (_local_6 != null){
                    _local_9 = _local_6.targetId;
                    _local_10 = _local_6.targetCategory;
                    _local_11 = this.IRoomSpriteCanvasContainer(_local_7, _local_8, _local_9, _local_10);
                    if (_local_11 != null){
                        if (((((!((_local_7 == this._activeRoomId))) || (!((_local_8 == this._activeRoomCategory))))) || (!(this._SafeStr_13460)))){
                            this.RoomEngine(_local_7, _local_8, _local_2, _local_11.getLocation(), _arg_1);
                        };
                    };
                };
                _local_3++;
            };
            var _local_4:IRoomRenderingCanvas = this.RoomEngine(this._activeRoomId, this._activeRoomCategory, _local_2);
            if (_local_4 != null){
                if (this._SafeStr_13460){
                    _local_4.screenOffsetX = (_local_4.screenOffsetX + this._SafeStr_13464);
                    _local_4.screenOffsetY = (_local_4.screenOffsetY + this._SafeStr_13465);
                    this._SafeStr_13464 = 0;
                    this._SafeStr_13465 = 0;
                };
            };
        }
        private function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:IVector3d, _arg_5:uint):void
        {
            var _local_11:Number;
            var _local_12:Rectangle;
            var _local_13:int;
            var _local_14:int;
            var _local_15:Rectangle;
            var _local_16:Vector3d;
            var _local_17:Number;
            var _local_18:Number;
            var _local_19:Number;
            var _local_20:Number;
            var _local_21:Number;
            var _local_22:Number;
            var _local_23:Number;
            var _local_24:Point;
            var _local_25:Number;
            var _local_26:Number;
            var _local_27:Matrix;
            var _local_28:Number;
            var _local_29:Number;
            var _local_30:Number;
            var _local_31:Number;
            var _local_32:Number;
            var _local_33:Number;
            var _local_34:Point;
            var _local_35:Boolean;
            var _local_36:Boolean;
            var _local_37:Boolean;
            var _local_38:Boolean;
            var _local_39:Number;
            var _local_40:Number;
            var _local_41:Number;
            var _local_42:Number;
            var _local_43:Number;
            var _local_44:int;
            var _local_45:int;
            var _local_46:Point;
            var _local_47:Vector3d;
            var _local_6:IRoomRenderingCanvas = this.RoomEngine(_arg_1, _arg_2, _arg_3);
            var _local_7:RoomInstanceData = this.RoomEngine(_arg_1, _arg_2);
            if ((((_local_6 == null)) || ((_local_7 == null)))){
                return;
            };
            var _local_8:RoomGeometry = (_local_6.geometry as RoomGeometry);
            var _local_9:RoomCamera = _local_7.roomCamera;
            var _local_10:IRoomInstance = this.getRoom(_arg_1, _arg_2);
            if (((((!((_local_8 == null))) && (!((_local_9 == null))))) && (!((_local_10 == null))))){
                _local_11 = (Math.floor(_arg_4.z) + 1);
                _local_12 = this.RoomEngine(_arg_1, _arg_2, _arg_3);
                if (_local_12 != null){
                    _local_13 = Math.round(_local_12.width);
                    _local_14 = Math.round(_local_12.height);
                    _local_15 = this.RoomEngine(_arg_3);
                    if (((!((_local_15 == null))) && ((((((((_local_15.right < 0)) || ((_local_15.bottom < 0)))) || ((_local_15.left >= _local_13)))) || ((_local_15.top >= _local_14)))))){
                        _local_9.reset();
                    };
                    if (((((((((((!((_local_9.screenWd == _local_13))) || (!((_local_9.screenHt == _local_14))))) || (!((_local_9.scale == _local_8.scale))))) || (!((_local_9.geometryUpdateId == _local_8.updateId))))) || (!(Vector3d.isEqual(_arg_4, _local_9.targetObjectLoc))))) || (_local_9.isMoving))){
                        _local_9.targetObjectLoc = _arg_4;
                        _local_16 = new Vector3d();
                        _local_16.assign(_arg_4);
                        _local_16.x = Math.round(_local_16.x);
                        _local_16.y = Math.round(_local_16.y);
                        _local_17 = (_local_10.getNumber(RoomVariableEnum._SafeStr_13365) - 0.5);
                        _local_18 = (_local_10.getNumber(RoomVariableEnum._SafeStr_13367) - 0.5);
                        _local_19 = (_local_10.getNumber(RoomVariableEnum._SafeStr_13366) + 0.5);
                        _local_20 = (_local_10.getNumber(RoomVariableEnum._SafeStr_13368) + 0.5);
                        _local_21 = Math.round(((_local_17 + _local_19) / 2));
                        _local_22 = Math.round(((_local_18 + _local_20) / 2));
                        _local_23 = 2;
                        _local_24 = new Point((_local_16.x - _local_21), (_local_16.y - _local_22));
                        _local_25 = (_local_8.scale / Math.sqrt(2));
                        _local_26 = (_local_25 / 2);
                        _local_27 = new Matrix();
                        _local_27.rotate(((-((_local_8.direction.x + 90)) / 180) * Math.PI));
                        _local_24 = _local_27.transformPoint(_local_24);
                        _local_24.y = (_local_24.y * (_local_26 / _local_25));
                        _local_28 = (((_local_12.width / 2) / _local_25) - 1);
                        _local_29 = (((_local_12.height / 2) / _local_26) - 1);
                        _local_30 = 0;
                        _local_31 = 0;
                        _local_32 = 0;
                        _local_33 = 0;
                        _local_34 = _local_8.RoomGeometry(new Vector3d(_local_21, _local_22, _local_23));
                        _local_34.x = (_local_34.x + Math.round((_local_12.width / 2)));
                        _local_34.y = (_local_34.y + Math.round((_local_12.height / 2)));
                        if (_local_15 != null){
                            _local_15.offset(-(_local_6.screenOffsetX), -(_local_6.screenOffsetY));
                            if ((((_local_15.width > 1)) && ((_local_15.height > 1)))){
                                _local_30 = (((_local_15.left - _local_34.x) - (_local_8.scale * 0.25)) / _local_25);
                                _local_32 = (((_local_15.right - _local_34.x) + (_local_8.scale * 0.25)) / _local_25);
                                _local_31 = (((_local_15.top - _local_34.y) - (_local_8.scale * 0.5)) / _local_26);
                                _local_33 = (((_local_15.bottom - _local_34.y) + (_local_8.scale * 0.5)) / _local_26);
                            }
                            else {
                                _local_8.RoomGeometry(new Vector3d(-30, -30), 25);
                                return;
                            };
                        }
                        else {
                            _local_8.RoomGeometry(new Vector3d(0, 0), 25);
                            return;
                        };
                        _local_35 = false;
                        _local_36 = false;
                        _local_37 = false;
                        _local_38 = false;
                        _local_39 = Math.round(((_local_32 - _local_30) * _local_25));
                        if (_local_39 < _local_12.width){
                            _local_11 = 2;
                            _local_24.x = ((_local_32 + _local_30) / 2);
                            _local_37 = true;
                        }
                        else {
                            if (_local_24.x > (_local_32 - _local_28)){
                                _local_24.x = (_local_32 - _local_28);
                                _local_35 = true;
                            };
                            if (_local_24.x < (_local_30 + _local_28)){
                                _local_24.x = (_local_30 + _local_28);
                                _local_35 = true;
                            };
                        };
                        _local_40 = Math.round(((_local_33 - _local_31) * _local_26));
                        if (_local_40 < _local_12.height){
                            _local_11 = 2;
                            _local_24.y = ((_local_33 + _local_31) / 2);
                            _local_38 = true;
                        }
                        else {
                            if (_local_24.y > (_local_33 - _local_29)){
                                _local_24.y = (_local_33 - _local_29);
                                _local_36 = true;
                            };
                            if (_local_24.y < (_local_31 + _local_29)){
                                _local_24.y = (_local_31 + _local_29);
                                _local_36 = true;
                            };
                            if (_local_36){
                                _local_24.y = (_local_24.y / (_local_26 / _local_25));
                            };
                        };
                        _local_27.invert();
                        _local_24 = _local_27.transformPoint(_local_24);
                        _local_24.x = (_local_24.x + _local_21);
                        _local_24.y = (_local_24.y + _local_22);
                        _local_41 = 0.35;
                        _local_42 = 0.2;
                        _local_43 = 0.2;
                        _local_44 = 10;
                        _local_45 = 10;
                        if ((_local_43 * _local_13) > 100){
                            _local_43 = (100 / _local_13);
                        };
                        if ((_local_41 * _local_14) > 150){
                            _local_41 = (150 / _local_14);
                        };
                        if ((_local_42 * _local_14) > 150){
                            _local_42 = (150 / _local_14);
                        };
                        if (((((_local_9.limitedLocationX) && ((_local_9.screenWd == _local_13)))) && ((_local_9.screenHt == _local_14)))){
                            _local_43 = 0;
                        };
                        if (((((_local_9.limitedLocationY) && ((_local_9.screenWd == _local_13)))) && ((_local_9.screenHt == _local_14)))){
                            _local_41 = 0;
                            _local_42 = 0;
                        };
                        _local_12.right = (_local_12.right * (1 - (_local_43 * 2)));
                        _local_12.bottom = (_local_12.bottom * (1 - (_local_41 + _local_42)));
                        if (_local_12.right < _local_44){
                            _local_12.right = _local_44;
                        };
                        if (_local_12.bottom < _local_45){
                            _local_12.bottom = _local_45;
                        };
                        if ((_local_41 + _local_42) > 0){
                            _local_12.offset((-(_local_12.width) / 2), (-(_local_12.height) * (_local_42 / (_local_41 + _local_42))));
                        }
                        else {
                            _local_12.offset((-(_local_12.width) / 2), (-(_local_12.height) / 2));
                        };
                        _local_34 = _local_8.RoomGeometry(_local_16);
                        if (_local_34 != null){
                            _local_34.x = (_local_34.x + _local_6.screenOffsetX);
                            _local_34.y = (_local_34.y + _local_6.screenOffsetY);
                            _local_16.z = _local_11;
                            _local_16.x = (Math.round((_local_24.x * 2)) / 2);
                            _local_16.y = (Math.round((_local_24.y * 2)) / 2);
                            if (_local_9.location == null){
                                _local_8.location = _local_16;
                                if (this.useOffsetScrolling){
                                    _local_9.initializeLocation(new Vector3d(0, 0, 0));
                                }
                                else {
                                    _local_9.initializeLocation(_local_16);
                                };
                            };
                            _local_46 = _local_8.RoomGeometry(_local_16);
                            _local_47 = new Vector3d(0, 0, 0);
                            if (_local_46 != null){
                                _local_47.x = _local_46.x;
                                _local_47.y = _local_46.y;
                            };
                            if ((((((((((((((((_local_34.x < _local_12.left)) || ((_local_34.x > _local_12.right)))) && (!(_local_9.centeredLocX)))) || ((((((_local_34.y < _local_12.top)) || ((_local_34.y > _local_12.bottom)))) && (!(_local_9.centeredLocY)))))) || (((((_local_37) && (!(_local_9.centeredLocX)))) && (!((_local_9.screenWd == _local_13))))))) || (((((_local_38) && (!(_local_9.centeredLocY)))) && (!((_local_9.screenHt == _local_14))))))) || (((!((_local_9.roomWd == _local_15.width))) || (!((_local_9.roomHt == _local_15.height))))))) || (((!((_local_9.screenWd == _local_13))) || (!((_local_9.screenHt == _local_14))))))){
                                _local_9.limitedLocationX = _local_35;
                                _local_9.limitedLocationY = _local_36;
                                if (this.useOffsetScrolling){
                                    _local_9.target = _local_47;
                                }
                                else {
                                    _local_9.target = _local_16;
                                };
                            }
                            else {
                                if (!_local_35){
                                    _local_9.limitedLocationX = false;
                                };
                                if (!_local_36){
                                    _local_9.limitedLocationY = false;
                                };
                            };
                        };
                        _local_9.centeredLocX = _local_37;
                        _local_9.centeredLocY = _local_38;
                        _local_9.screenWd = _local_13;
                        _local_9.screenHt = _local_14;
                        _local_9.scale = _local_8.scale;
                        _local_9.geometryUpdateId = _local_8.updateId;
                        _local_9.roomWd = _local_15.width;
                        _local_9.roomHt = _local_15.height;
                        if (this.useOffsetScrolling){
                            _local_9.update(_arg_5, 8);
                        }
                        else {
                            _local_9.update(_arg_5, 0.5);
                        };
                        if (this.useOffsetScrolling){
                            _local_6.screenOffsetX = -(_local_9.location.x);
                            _local_6.screenOffsetY = -(_local_9.location.y);
                        }
                        else {
                            _local_8.RoomGeometry(_local_9.location, 25);
                        };
                    }
                    else {
                        _local_9.limitedLocationX = false;
                        _local_9.limitedLocationY = false;
                        _local_9.centeredLocX = false;
                        _local_9.centeredLocY = false;
                    };
                };
            };
        }
        private function RoomEngine(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._SafeStr_13446 = (_arg_2 as IRoomObjectFactory);
            this.RoomEngine();
            this.RoomEngine();
        }
        private function RoomEngine(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._visualizationFactory = (_arg_2 as IRoomObjectVisualizationFactory);
            if (this._SafeStr_13450 != null){
                this._SafeStr_13450.visualizationFactory = this._visualizationFactory;
            };
            this.RoomEngine();
        }
        private function RoomEngine(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._roomManager = (_arg_2 as IRoomManager);
            if (this._roomManager != null){
                this._roomManager.addObjectUpdateCategory(RoomObjectCategoryEnum._SafeStr_4329);
                this._roomManager.addObjectUpdateCategory(RoomObjectCategoryEnum._SafeStr_4330);
                this._roomManager.addObjectUpdateCategory(RoomObjectCategoryEnum.OBJECT_CATEGORY_USER);
                this._roomManager.addObjectUpdateCategory(RoomObjectCategoryEnum._SafeStr_13134);
                this._roomManager.addObjectUpdateCategory(RoomObjectCategoryEnum._SafeStr_13133);
                this._roomManager.setContentLoader(this._SafeStr_13450);
            };
            this.RoomEngine();
        }
        private function RoomEngine(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._roomRendererFactory = (_arg_2 as IRoomRendererFactory);
            this.RoomEngine();
        }
        private function onCommunicationReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._communication = (_arg_2 as IHabboCommunicationManager);
            if (this._communication != null){
                this._connection = this._communication.HabboCommunicationManager(this.onConnectionReady);
                if (this._connection != null){
                    this.onConnectionReady(this._connection);
                };
            };
            this.RoomEngine();
        }
        private function onConnectionReady(_arg_1:IConnection):void
        {
            if (disposed){
                return;
            };
            if (_arg_1 != null){
                this._connection = _arg_1;
                if (this._SafeStr_13449 != null){
                    this._SafeStr_13449.connection = _arg_1;
                };
            };
        }
        private function RoomEngine(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._habboConfiguration = (_arg_2 as IHabboConfigurationManager);
            if (this._SafeStr_13450 != null){
                events.addEventListener(RoomContentLoader.RCL_LOADER_READY, this.RoomEngine);
                this._SafeStr_13450.initialize(events, this._habboConfiguration);
            };
            this._SafeStr_13466 = (this._habboConfiguration.getKey("room.dragging.always_center", "0") == "1");
            this.RoomEngine();
        }
        private function RoomEngine(_arg_1:Event):void
        {
            if (((!((_arg_1 == null))) && ((_arg_1.type == RoomContentLoader.RCL_LOADER_READY)))){
                this._SafeStr_13451 = true;
                this.RoomEngine();
            };
        }
        private function onAdManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._adManager = (_arg_2 as IAdManager);
            this._adManager.events.addEventListener(AdEvent.AE_ROOM_AD_SHOW, this.RoomEngine);
            this._adManager.events.addEventListener(AdEvent.AE_ROOM_AD_IMAGE_LOADED, this.RoomEngine);
            this._adManager.events.addEventListener(AdEvent.AE_ROOM_AD_IMAGE_LOADING_FAILED, this.RoomEngine);
        }
        private function onSessionDataManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._sessionDataManager = (_arg_2 as ISessionDataManager);
            this._SafeStr_13450.sessionDataManager = this._sessionDataManager;
        }
        private function onRoomSessionManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._roomSessionManager = (_arg_2 as IRoomSessionManager);
            this._roomSessionManager.events.addEventListener(RoomSessionEvent.RSE_STARTED, this.RoomEngine);
            this._roomSessionManager.events.addEventListener(RoomSessionEvent.RSE_ENDED, this.RoomEngine);
        }
        private function RoomEngine(_arg_1:RoomSessionEvent):void
        {
            switch (_arg_1.type){
                case RoomSessionEvent.RSE_STARTED:
                    if (this._SafeStr_13449){
                        this._SafeStr_13449.setCurrentRoom(_arg_1.session.roomId, _arg_1.session.roomCategory);
                    };
                    return;
                case RoomSessionEvent.RSE_ENDED:
                    if (this._SafeStr_13449){
                        this._SafeStr_13449.resetCurrentRoom();
                        this.disposeRoom(_arg_1.session.roomId, _arg_1.session.roomCategory);
                    };
                    return;
            };
        }
        private function onToolbarReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._toolbar = (_arg_2 as IHabboToolbar);
            this._toolbar.events.addEventListener(HabboToolbarEvent.HTE_TOOLBAR_CLICK, this.RoomEngine);
        }
        private function RoomEngine(_arg_1:HabboToolbarEvent):void
        {
            var _local_2:RoomCamera;
            if (_arg_1.iconId == HabboToolbarIconEnum.MEMENU){
                _local_2 = this.RoomEngine();
                if (_local_2){
                    _local_2.reset();
                };
            };
        }
        private function RoomEngine():void
        {
            if (this._SafeStr_13446 != null){
                this._SafeStr_13446.addObjectEventListener(this.roomObjectEventHandler);
            };
        }
        private function RoomEngine():void
        {
            if ((((((((((((((this._SafeStr_13446 == null)) || ((this._visualizationFactory == null)))) || ((this._roomManager == null)))) || ((this._roomRendererFactory == null)))) || ((this._communication == null)))) || ((this._habboConfiguration == null)))) || (!(this._SafeStr_13451)))){
                return;
            };
            this._roomManager.initialize(<nothing/>
            , this);
        }
        public function roomManagerInitialized(_arg_1:Boolean=true):void
        {
            var _local_2:int;
            var _local_3:RoomData;
            if (_arg_1){
                this._isInitialized = true;
                events.dispatchEvent(new RoomEngineEvent(RoomEngineEvent.REE_ENGINE_INITIALIZED, 0, 0));
                _local_2 = 0;
                while (_local_2 < this._SafeStr_13467.length) {
                    _local_3 = (this._SafeStr_13467.getWithIndex(_local_2) as RoomData);
                    if (_local_3 != null){
                        this.RoomEngine(_local_3.roomId, _local_3.roomCategory, _local_3.data);
                    };
                    _local_2++;
                };
            };
        }
        public function setActiveRoom(_arg_1:int, _arg_2:int):void
        {
            this._activeRoomId = _arg_1;
            this._activeRoomCategory = _arg_2;
        }
        public function getRoomIdentifier(_arg_1:int, _arg_2:int):String
        {
            return (String(((_arg_1 + "_") + _arg_2)));
        }
        private function RoomEngine(_arg_1:String):int
        {
            var _local_2:Array;
            if (_arg_1 != null){
                _local_2 = _arg_1.split("_");
                if (_local_2.length > 0){
                    return (_local_2[0]);
                };
            };
            return (-1);
        }
        private function RoomEngine(_arg_1:String):int
        {
            var _local_2:Array;
            if (_arg_1 != null){
                _local_2 = _arg_1.split("_");
                if (_local_2.length > 1){
                    return (_local_2[1]);
                };
            };
            return (-1);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int):Boolean
        {
            return (this.RoomEngine(this.RoomEngine(_arg_1, _arg_2)));
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:String):Number
        {
            var _local_4:IRoomInstance = this.getRoom(_arg_1, _arg_2);
            if (_local_4 != null){
                return (_local_4.getNumber(_arg_3));
            };
            return (NaN);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:String):String
        {
            var _local_4:IRoomInstance = this.getRoom(_arg_1, _arg_2);
            if (_local_4 != null){
                return (_local_4.getString(_arg_3));
            };
            return (null);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:Boolean):void
        {
            var _local_5:int;
            var _local_4:IRoomInstance = this.getRoom(_arg_1, _arg_2);
            if (_local_4 != null){
                _local_5 = ((_arg_3) ? 1 : 0);
                _local_4.setNumber(RoomVariableEnum._SafeStr_13371, _local_5);
                if (_local_5 == 0){
                    events.dispatchEvent(new RoomEngineEvent(RoomEngineEvent.REE_NORMAL_MODE, _arg_1, _arg_2));
                }
                else {
                    events.dispatchEvent(new RoomEngineEvent(RoomEngineEvent.REE_GAME_MODE, _arg_1, _arg_2));
                };
            };
        }
        public function RoomEngine(_arg_1:int, _arg_2:int):Boolean
        {
            var _local_4:Number;
            var _local_3:IRoomInstance = this.getRoom(_arg_1, _arg_2);
            if (_local_3 != null){
                _local_4 = _local_3.getNumber(RoomVariableEnum._SafeStr_13371);
                if (_local_4 > 0){
                    return (true);
                };
            };
            return (false);
        }
        public function getRoom(_arg_1:int, _arg_2:int):IRoomInstance
        {
            if (!this._isInitialized){
                return (null);
            };
            var _local_3:String = this.getRoomIdentifier(_arg_1, _arg_2);
            return (this._roomManager.getRoom(_local_3));
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:XML):void
        {
            var _local_4:String = this.getRoomIdentifier(_arg_1, _arg_2);
            var _local_5:RoomData;
            var _local_6:String = "111";
            var _local_7:String = "201";
            var _local_8:String = "1";
            if (!this._isInitialized){
                _local_5 = this._SafeStr_13467.remove(_local_4);
                if (_local_5 != null){
                    _local_6 = _local_5.floorType;
                    _local_7 = _local_5.wallType;
                    _local_8 = _local_5.landscapeType;
                };
                _local_5 = new RoomData(_arg_1, _arg_2, _arg_3);
                _local_5.floorType = _local_6;
                _local_5.wallType = _local_7;
                _local_5.landscapeType = _local_8;
                this._SafeStr_13467.add(_local_4, _local_5);
                Logger.log("Room Engine not initilized yet, can not create room. Room data stored for later initialization.");
                return;
            };
            if (_arg_3 == null){
                Logger.log("Room property messages received before floor height map, will initialize when floor height map received.");
                return;
            };
            _local_5 = this._SafeStr_13467.remove(_local_4);
            if (_local_5 != null){
                if (((!((_local_5.floorType == null))) && ((_local_5.floorType.length > 0)))){
                    _local_6 = _local_5.floorType;
                };
                if (((!((_local_5.wallType == null))) && ((_local_5.wallType.length > 0)))){
                    _local_7 = _local_5.wallType;
                };
                if (((!((_local_5.landscapeType == null))) && ((_local_5.landscapeType.length > 0)))){
                    _local_8 = _local_5.landscapeType;
                };
            };
            var _local_9:IRoomInstance = this.createRoom(_local_4, _arg_3, _local_6, _local_7, _local_8, this.RoomEngine(_arg_1, _arg_2));
            if (_local_9 == null){
                return;
            };
            events.dispatchEvent(new RoomEngineEvent(RoomEngineEvent.REE_INITIALIZED, _arg_1, _arg_2));
        }
        private function createRoom(_arg_1:String, _arg_2:XML, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:String):IRoomInstance
        {
            var _local_11:String;
            var _local_12:int;
            var _local_13:int;
            var _local_14:XML;
            var _local_15:Number;
            var _local_16:Number;
            var _local_17:Number;
            var _local_18:Number;
            var _local_19:RoomObjectRoomUpdateMessage;
            var _local_20:XMLList;
            var _local_21:Array;
            var _local_22:RoomObjectRoomMaskUpdateMessage;
            var _local_23:int;
            var _local_24:XML;
            var _local_25:Number;
            var _local_26:Number;
            var _local_27:Number;
            var _local_28:Number;
            var _local_29:String;
            var _local_30:String;
            var _local_31:Vector3d;
            if (!this._isInitialized){
                return (null);
            };
            var _local_7:IRoomInstance = this._roomManager.createRoom(_arg_1, _arg_2);
            if (_local_7 == null){
                return (null);
            };
            var _local_8:int = RoomObjectCategoryEnum._SafeStr_13133;
            var _local_9:IRoomObjectController;
            var _local_10:Number = 1;
            if (this.RoomEngine(_arg_6)){
                _local_11 = this._SafeStr_13450.getPublicRoomContentType(_arg_6);
                _local_9 = (_local_7.createRoomObject(_SafeStr_13437, _local_11, _local_8) as IRoomObjectController);
                _local_9.getModelController().setString(RoomObjectVariableEnum._SafeStr_8503, _arg_6, true);
                _local_7.setNumber(RoomVariableEnum._SafeStr_13369, 1, true);
                _local_12 = parseInt(this._habboConfiguration.getKey("ads.billboard.displayDelayMillis", "1000"));
                _local_9.getModelController().setNumber(RoomVariableEnum._SafeStr_5321, _local_12, true);
                if (this._SafeStr_13450 != null){
                    _local_10 = this._SafeStr_13450.getPublicRoomWorldHeightScale(_arg_6);
                };
            }
            else {
                _local_9 = (_local_7.createRoomObject(_SafeStr_13437, _SafeStr_13438, _local_8) as IRoomObjectController);
                _local_7.setNumber(RoomVariableEnum._SafeStr_13369, 0, true);
            };
            _local_7.setNumber(RoomVariableEnum._SafeStr_13370, _local_10, true);
            if (_arg_2 != null){
                _local_13 = 0;
                if (_arg_2.dimensions.length() == 1){
                    _local_14 = _arg_2.dimensions[0];
                    _local_15 = Number(_local_14.@minX);
                    _local_16 = Number(_local_14.@maxX);
                    _local_17 = Number(_local_14.@minY);
                    _local_18 = Number(_local_14.@maxY);
                    _local_7.setNumber(RoomVariableEnum._SafeStr_13365, _local_15);
                    _local_7.setNumber(RoomVariableEnum._SafeStr_13366, _local_16);
                    _local_7.setNumber(RoomVariableEnum._SafeStr_13367, _local_17);
                    _local_7.setNumber(RoomVariableEnum._SafeStr_13368, _local_18);
                    _local_13 = (_local_13 + ((((_local_15 * 423) + (_local_16 * 671)) + (_local_17 * 913)) + (_local_18 * 7509)));
                    if (((!((_local_9 == null))) && (!((_local_9.getModelController() == null))))){
                        _local_9.getModelController().setNumber(RoomObjectVariableEnum._SafeStr_12943, _local_13, true);
                    };
                };
            };
            if (((!((_local_9 == null))) && (!((_local_9.getEventHandler() == null))))){
                _local_9.getEventHandler().initialize(_arg_2);
                _local_19 = null;
                if (_arg_3 != null){
                    _local_19 = new RoomObjectRoomUpdateMessage(RoomObjectRoomUpdateMessage.RORUM_ROOM_FLOOR_UPDATE, _arg_3);
                    _local_9.getEventHandler().processUpdateMessage(_local_19);
                    _local_7.setString(RoomObjectVariableEnum._SafeStr_5784, _arg_3);
                };
                if (_arg_4 != null){
                    _local_19 = new RoomObjectRoomUpdateMessage(RoomObjectRoomUpdateMessage.RORUM_ROOM_WALL_UPDATE, _arg_4);
                    _local_9.getEventHandler().processUpdateMessage(_local_19);
                    _local_7.setString(RoomObjectVariableEnum._SafeStr_5786, _arg_4);
                };
                if (_arg_5 != null){
                    _local_19 = new RoomObjectRoomUpdateMessage(RoomObjectRoomUpdateMessage.RORUM_ROOM_LANDSCAPE_UPDATE, _arg_5);
                    _local_9.getEventHandler().processUpdateMessage(_local_19);
                    _local_7.setString(RoomObjectVariableEnum._SafeStr_5788, _arg_5);
                };
                if (_arg_2 != null){
                    if (_arg_2.doors.door.length() > 0){
                        _local_20 = _arg_2.doors.door;
                        _local_21 = ["x", "y", "z", "dir"];
                        _local_22 = null;
                        _local_23 = 0;
                        while (_local_23 < _local_20.length()) {
                            _local_24 = _local_20[_local_23];
                            if (XMLValidator.checkRequiredAttributes(_local_24, _local_21)){
                                _local_25 = Number(_local_24.@x);
                                _local_26 = Number(_local_24.@y);
                                _local_27 = Number(_local_24.@z);
                                _local_28 = Number(_local_24.@dir);
                                _local_29 = RoomObjectRoomMaskUpdateMessage._SafeStr_8203;
                                _local_30 = ("door_" + _local_23);
                                _local_31 = new Vector3d(_local_25, _local_26, _local_27);
                                _local_22 = new RoomObjectRoomMaskUpdateMessage(RoomObjectRoomMaskUpdateMessage.RORMUM_ADD_MASK, _local_30, _local_29, _local_31, RoomObjectRoomMaskUpdateMessage._SafeStr_5793);
                                _local_9.getEventHandler().processUpdateMessage(_local_22);
                                if ((((_local_28 == 90)) || ((_local_28 == 180)))){
                                    if (_local_28 == 90){
                                        _local_7.setNumber(RoomObjectVariableEnum._SafeStr_13004, (_local_25 - 0.5), true);
                                        _local_7.setNumber(RoomObjectVariableEnum._SafeStr_13005, _local_26, true);
                                    };
                                    if (_local_28 == 180){
                                        _local_7.setNumber(RoomObjectVariableEnum._SafeStr_13004, _local_25, true);
                                        _local_7.setNumber(RoomObjectVariableEnum._SafeStr_13005, (_local_26 - 0.5), true);
                                    };
                                    _local_7.setNumber(RoomObjectVariableEnum._SafeStr_13006, _local_27, true);
                                    _local_7.setNumber(RoomObjectVariableEnum._SafeStr_13007, _local_28, true);
                                };
                            };
                            _local_23++;
                        };
                    };
                };
            };
            _local_7.createRoomObject(_SafeStr_13439, _SafeStr_13440, RoomObjectCategoryEnum._SafeStr_13134);
            if (this._habboConfiguration.getKey("avatar.widget.enabled", "0") == "0"){
                _local_7.createRoomObject(_SafeStr_13441, _SafeStr_13442, RoomObjectCategoryEnum._SafeStr_13134);
            };
            return (_local_7);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int):IRoomObjectController
        {
            return (this.RoomInstance(this.getRoomIdentifier(_arg_1, _arg_2), _SafeStr_13437, RoomObjectCategoryEnum._SafeStr_13133));
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:String=null, _arg_4:String=null, _arg_5:String=null, _arg_6:Boolean=false):Boolean
        {
            var _local_10:String;
            var _local_11:RoomData;
            var _local_7:IRoomObjectController = this.RoomEngine(_arg_1, _arg_2);
            var _local_8:IRoomInstance = this.getRoom(_arg_1, _arg_2);
            if (_local_7 == null){
                _local_10 = this.getRoomIdentifier(_arg_1, _arg_2);
                _local_11 = this._SafeStr_13467.getValue(_local_10);
                if (_local_11 == null){
                    _local_11 = new RoomData(_arg_1, _arg_2, null);
                    this._SafeStr_13467.add(_local_10, _local_11);
                };
                if (_arg_3 != null){
                    _local_11.floorType = _arg_3;
                };
                if (_arg_4 != null){
                    _local_11.wallType = _arg_4;
                };
                if (_arg_5 != null){
                    _local_11.landscapeType = _arg_5;
                };
                return (true);
            };
            if (_local_7.getEventHandler() == null){
                return (false);
            };
            var _local_9:RoomObjectRoomUpdateMessage;
            if (_arg_3 != null){
                if (((!((_local_8 == null))) && (!(_arg_6)))){
                    _local_8.setString(RoomObjectVariableEnum._SafeStr_5784, _arg_3);
                };
                _local_9 = new RoomObjectRoomUpdateMessage(RoomObjectRoomUpdateMessage.RORUM_ROOM_FLOOR_UPDATE, _arg_3);
                _local_7.getEventHandler().processUpdateMessage(_local_9);
            };
            if (_arg_4 != null){
                if (((!((_local_8 == null))) && (!(_arg_6)))){
                    _local_8.setString(RoomObjectVariableEnum._SafeStr_5786, _arg_4);
                };
                _local_9 = new RoomObjectRoomUpdateMessage(RoomObjectRoomUpdateMessage.RORUM_ROOM_WALL_UPDATE, _arg_4);
                _local_7.getEventHandler().processUpdateMessage(_local_9);
            };
            if (_arg_5 != null){
                if (((!((_local_8 == null))) && (!(_arg_6)))){
                    _local_8.setString(RoomObjectVariableEnum._SafeStr_5788, _arg_5);
                };
                _local_9 = new RoomObjectRoomUpdateMessage(RoomObjectRoomUpdateMessage.RORUM_ROOM_LANDSCAPE_UPDATE, _arg_5);
                _local_7.getEventHandler().processUpdateMessage(_local_9);
            };
            return (true);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:uint, _arg_4:int, _arg_5:Boolean):Boolean
        {
            var _local_6:IRoomObjectController = this.RoomEngine(_arg_1, _arg_2);
            if ((((_local_6 == null)) || ((_local_6.getEventHandler() == null)))){
                return (false);
            };
            var _local_7:RoomObjectRoomColorUpdateMessage;
            _local_7 = new RoomObjectRoomColorUpdateMessage(RoomObjectRoomColorUpdateMessage.RORCUM_BACKGROUND_COLOR, _arg_3, _arg_4, _arg_5);
            _local_6.getEventHandler().processUpdateMessage(_local_7);
            events.dispatchEvent(new RoomEngineRoomColorEvent(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5));
            return (true);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean=true):Boolean
        {
            var _local_5:IRoomObjectController = this.RoomEngine(_arg_1, _arg_2);
            if ((((_local_5 == null)) || ((_local_5.getEventHandler() == null)))){
                return (false);
            };
            var _local_6:RoomObjectRoomPlaneVisibilityUpdateMessage;
            _local_6 = new RoomObjectRoomPlaneVisibilityUpdateMessage(RoomObjectRoomPlaneVisibilityUpdateMessage.RORPVUM_WALL_VISIBILITY, _arg_3);
            _local_5.getEventHandler().processUpdateMessage(_local_6);
            _local_6 = new RoomObjectRoomPlaneVisibilityUpdateMessage(RoomObjectRoomPlaneVisibilityUpdateMessage.RORPVUM_FLOOR_VISIBILITY, _arg_4);
            _local_5.getEventHandler().processUpdateMessage(_local_6);
            return (true);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:Number, _arg_4:Number):Boolean
        {
            var _local_5:IRoomObjectController = this.RoomEngine(_arg_1, _arg_2);
            if ((((_local_5 == null)) || ((_local_5.getEventHandler() == null)))){
                return (false);
            };
            var _local_6:RoomObjectRoomPlanePropertyUpdateMessage;
            _local_6 = new RoomObjectRoomPlanePropertyUpdateMessage(RoomObjectRoomPlanePropertyUpdateMessage.RORPPUM_WALL_THICKNESS, _arg_3);
            _local_5.getEventHandler().processUpdateMessage(_local_6);
            _local_6 = new RoomObjectRoomPlanePropertyUpdateMessage(RoomObjectRoomPlanePropertyUpdateMessage.RORPVUM_FLOOR_THICKNESS, _arg_4);
            _local_5.getEventHandler().processUpdateMessage(_local_6);
            return (true);
        }
        public function disposeRoom(_arg_1:int, _arg_2:int):void
        {
            var _local_3:String = this.getRoomIdentifier(_arg_1, _arg_2);
            this._roomManager.disposeRoom(_local_3);
            var _local_4:RoomInstanceData = this._SafeStr_13468.remove(_local_3);
            if (_local_4 != null){
                _local_4.dispose();
            };
            events.dispatchEvent(new RoomEngineEvent(RoomEngineEvent.REE_DISPOSED, _arg_1, _arg_2));
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            var _local_4:RoomCamera = this.RoomEngine(_arg_1, _arg_2);
            if (_local_4 != null){
                _local_4.targetId = _arg_3;
                _local_4.targetCategory = RoomObjectCategoryEnum.OBJECT_CATEGORY_USER;
            };
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int):DisplayObject
        {
            var _local_12:String;
            var _local_13:Number;
            var _local_14:Number;
            var _local_15:Number;
            var _local_16:Number;
            var _local_17:Vector3d;
            var _local_18:Vector3d;
            var _local_19:Sprite;
            var _local_7:String = this.getRoomIdentifier(_arg_1, _arg_2);
            var _local_8:IRoomInstance = this._roomManager.getRoom(_local_7);
            if (_local_8 == null){
                return (null);
            };
            var _local_9:IRoomRenderer = (_local_8.RoomInstance() as IRoomRenderer);
            if (_local_9 == null){
                _local_9 = this._roomRendererFactory.createRenderer();
            };
            if (_local_9 == null){
                return (null);
            };
            _local_9.roomObjectVariableAccurateZ = RoomObjectVariableEnum._SafeStr_13000;
            _local_8.RoomInstance(_local_9);
            var _local_10:IRoomRenderingCanvas = _local_9.IRoomRenderer(_arg_3, _arg_4, _arg_5, _arg_6);
            if (_local_10 == null){
                return (null);
            };
            _local_10.mouseListener = this._SafeStr_13448;
            if (_local_10.geometry != null){
                _local_12 = this.RoomEngine(_arg_1, _arg_2);
                if (this.RoomEngine(_local_12)){
                    if (this._SafeStr_13450 != null){
                        if (this._SafeStr_13450.getPublicRoomWorldSize(_local_12) != 64){
                            _local_10.geometry.RoomGeometry();
                        };
                    };
                };
                _local_10.geometry.z_scale = _local_8.getNumber(RoomVariableEnum._SafeStr_13370);
            };
            if (_local_10.geometry != null){
                _local_13 = _local_8.getNumber(RoomObjectVariableEnum._SafeStr_13004);
                _local_14 = _local_8.getNumber(RoomObjectVariableEnum._SafeStr_13005);
                _local_15 = _local_8.getNumber(RoomObjectVariableEnum._SafeStr_13006);
                _local_16 = _local_8.getNumber(RoomObjectVariableEnum._SafeStr_13007);
                _local_17 = new Vector3d(_local_13, _local_14, _local_15);
                _local_18 = null;
                if (_local_16 == 90){
                    _local_18 = new Vector3d(-1000, 0, 0);
                };
                if (_local_16 == 180){
                    _local_18 = new Vector3d(0, -1000, 0);
                };
                _local_10.geometry.RoomGeometry(_local_17, _local_18);
            };
            var _local_11:Sprite = (_local_10.displayObject as Sprite);
            if (_local_11 != null){
                _local_19 = new Sprite();
                _local_19.name = OVERLAY_SPRITE;
                _local_19.mouseEnabled = false;
                _local_11.addChild(_local_19);
            };
            return (_local_11);
        }
        private function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int):IRoomRenderingCanvas
        {
            var _local_4:String = this.getRoomIdentifier(_arg_1, _arg_2);
            var _local_5:IRoomInstance = this._roomManager.getRoom(_local_4);
            if (_local_5 == null){
                return (null);
            };
            var _local_6:IRoomRenderer = (_local_5.RoomInstance() as IRoomRenderer);
            if (_local_6 == null){
                return (null);
            };
            return (_local_6.getCanvas(_arg_3));
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int):Boolean
        {
            var _local_6:IRoomRenderingCanvas = this.RoomEngine(_arg_1, _arg_2, _arg_3);
            if (_local_6 == null){
                return (false);
            };
            _local_6.initialize(_arg_4, _arg_5);
            return (true);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Boolean):void
        {
            var _local_5:IRoomRenderingCanvas = this.RoomEngine(_arg_1, _arg_2, _arg_3);
            if (_local_5 == null){
                return;
            };
            _local_5.useMask = _arg_4;
        }
        private function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int):Rectangle
        {
            var _local_4:IRoomRenderingCanvas = this.RoomEngine(_arg_1, _arg_2, _arg_3);
            if (_local_4 == null){
                return (null);
            };
            return (new Rectangle(0, 0, _local_4.width, _local_4.height));
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int):IRoomGeometry
        {
            var _local_4:IRoomRenderingCanvas = this.RoomEngine(_arg_1, _arg_2, _arg_3);
            if (_local_4 == null){
                return (null);
            };
            return (_local_4.geometry);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int):Point
        {
            var _local_4:IRoomRenderingCanvas = this.RoomEngine(_arg_1, _arg_2, _arg_3);
            if (_local_4 == null){
                return (null);
            };
            return (new Point(_local_4.screenOffsetX, _local_4.screenOffsetY));
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Point):Boolean
        {
            var _local_5:IRoomRenderingCanvas = this.RoomEngine(_arg_1, _arg_2, _arg_3);
            if ((((_local_5 == null)) || ((_arg_4 == null)))){
                return (false);
            };
            _local_5.screenOffsetX = _arg_4.x;
            _local_5.screenOffsetY = _arg_4.y;
            return (true);
        }
        private function RoomEngine(_arg_1:IRoomRenderingCanvas, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:Boolean, _arg_6:Boolean, _arg_7:Boolean):Boolean
        {
            var _local_10:RoomInstanceData;
            var _local_11:RoomCamera;
            var _local_8:int = (_arg_2 - this._SafeStr_13458);
            var _local_9:int = (_arg_3 - this._SafeStr_13459);
            if (_arg_4 == MouseEvent.MOUSE_DOWN){
                if (((((!(_arg_5)) && (!(_arg_6)))) && (!(_arg_7)))){
                    this._SafeStr_13460 = true;
                    this._SafeStr_13461 = false;
                    this._SafeStr_13462 = this._SafeStr_13458;
                    this._SafeStr_13463 = this._SafeStr_13459;
                };
            }
            else {
                if (_arg_4 == MouseEvent.MOUSE_UP){
                    if (this._SafeStr_13460){
                        this._SafeStr_13460 = false;
                        if (this._SafeStr_13461){
                            _local_10 = this.RoomEngine(this._activeRoomId, this._activeRoomCategory);
                            if (_local_10 != null){
                                _local_11 = _local_10.roomCamera;
                                if (_local_11 != null){
                                    if (this.useOffsetScrolling){
                                        if (!_local_11.isMoving){
                                            _local_11.centeredLocX = false;
                                            _local_11.centeredLocY = false;
                                        };
                                        _local_11.resetLocation(new Vector3d(-(_arg_1.screenOffsetX), -(_arg_1.screenOffsetY)));
                                    };
                                    if (this._SafeStr_13466){
                                        _local_11.reset();
                                    };
                                };
                            };
                        };
                    };
                }
                else {
                    if (_arg_4 == MouseEvent.MOUSE_MOVE){
                        if (this._SafeStr_13460){
                            if (!this._SafeStr_13461){
                                _local_8 = (_arg_2 - this._SafeStr_13462);
                                _local_9 = (_arg_3 - this._SafeStr_13463);
                                if ((((((((_local_8 <= -(_SafeStr_13444))) || ((_local_8 >= _SafeStr_13444)))) || ((_local_9 <= -(_SafeStr_13444))))) || ((_local_9 >= _SafeStr_13444)))){
                                    this._SafeStr_13461 = true;
                                };
                                _local_8 = 0;
                                _local_9 = 0;
                            };
                            if (((!((_local_8 == 0))) || (!((_local_9 == 0))))){
                                this._SafeStr_13464 = (this._SafeStr_13464 + _local_8);
                                this._SafeStr_13465 = (this._SafeStr_13465 + _local_9);
                                this._SafeStr_13461 = true;
                            };
                        };
                    }
                    else {
                        if ((((_arg_4 == MouseEvent.CLICK)) || ((_arg_4 == MouseEvent.DOUBLE_CLICK)))){
                            this._SafeStr_13460 = false;
                            if (this._SafeStr_13461){
                                this._SafeStr_13461 = false;
                                return (true);
                            };
                        };
                    };
                };
            };
            return (false);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:Boolean, _arg_6:Boolean, _arg_7:Boolean, _arg_8:Boolean):void
        {
            var _local_10:Sprite;
            var _local_11:Sprite;
            var _local_12:Rectangle;
            var _local_13:String;
            var _local_14:RoomObjectEvent;
            var _local_9:IRoomRenderingCanvas = this.RoomEngine(this._activeRoomId, this._activeRoomCategory, _arg_1);
            if (_local_9 != null){
                _local_10 = this.RoomEngine(_local_9);
                _local_11 = this.RoomEngine(_local_10, _SafeStr_13443);
                if (_local_11 != null){
                    _local_12 = _local_11.getRect(_local_11);
                    _local_11.x = (_arg_2 - (_local_12.width / 2));
                    _local_11.y = (_arg_3 - (_local_12.height / 2));
                };
                if (!this.RoomEngine(_local_9, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7)){
                    if (!_local_9.handleMouseEvent(_arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8)){
                        _local_13 = "";
                        if (_arg_4 == MouseEvent.CLICK){
                            if (events != null){
                                events.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.REOE_OBJECT_DESELECTED, this._activeRoomId, this._activeRoomCategory, -1, RoomObjectCategoryEnum._SafeStr_4962));
                            };
                            _local_13 = RoomObjectMouseEvent.ROE_MOUSE_CLICK;
                        }
                        else {
                            if (_arg_4 == MouseEvent.MOUSE_MOVE){
                                _local_13 = RoomObjectMouseEvent.ROE_MOUSE_MOVE;
                            }
                            else {
                                if (_arg_4 == MouseEvent.MOUSE_DOWN){
                                    _local_13 = RoomObjectMouseEvent.ROE_MOUSE_DOWN;
                                };
                            };
                        };
                        if (this._SafeStr_13448 != null){
                            _local_14 = new RoomObjectMouseEvent(_local_13, null, _SafeStr_13437, _SafeStr_13438);
                            this._SafeStr_13448.handleRoomObjectEvent(_local_14, this._activeRoomId, this._activeRoomCategory);
                        };
                    };
                };
                this._SafeStr_13457 = _arg_1;
                this._SafeStr_13458 = _arg_2;
                this._SafeStr_13459 = _arg_3;
            };
        }
        private function RoomEngine(_arg_1:IRoomRenderingCanvas):Sprite
        {
            if (_arg_1 == null){
                return (null);
            };
            var _local_2:Sprite = (_arg_1.displayObject as Sprite);
            if (_local_2 == null){
                return (null);
            };
            return ((_local_2.getChildByName(OVERLAY_SPRITE) as Sprite));
        }
        private function RoomEngine(_arg_1:Sprite, _arg_2:String, _arg_3:BitmapData):Sprite
        {
            if ((((_arg_1 == null)) || ((_arg_3 == null)))){
                return (null);
            };
            var _local_4:Sprite = this.RoomEngine(_arg_1, _arg_2);
            if (_local_4 != null){
                return (null);
            };
            _local_4 = new Sprite();
            _local_4.name = _arg_2;
            _local_4.mouseEnabled = false;
            var _local_5:Bitmap = new Bitmap(_arg_3);
            _local_4.addChild(_local_5);
            _arg_1.addChild(_local_4);
            return (_local_4);
        }
        private function RoomEngine(_arg_1:Sprite, _arg_2:String):Boolean
        {
            var _local_4:Sprite;
            var _local_5:Bitmap;
            if (_arg_1 == null){
                return (false);
            };
            var _local_3:int = (_arg_1.numChildren - 1);
            while (_local_3 >= 0) {
                _local_4 = (_arg_1.getChildAt(_local_3) as Sprite);
                if (_local_4 != null){
                    if (_local_4.name == _arg_2){
                        _arg_1.removeChildAt(_local_3);
                        _local_5 = (_local_4.getChildAt(0) as Bitmap);
                        if (((!((_local_5 == null))) && (!((_local_5.bitmapData == null))))){
                            _local_5.bitmapData.dispose();
                            _local_5.bitmapData = null;
                        };
                        return (true);
                    };
                };
                _local_3--;
            };
            return (false);
        }
        private function RoomEngine(_arg_1:Sprite, _arg_2:String):Sprite
        {
            var _local_4:Sprite;
            if (_arg_1 == null){
                return (null);
            };
            var _local_3:int = (_arg_1.numChildren - 1);
            while (_local_3 >= 0) {
                _local_4 = (_arg_1.getChildAt(_local_3) as Sprite);
                if (_local_4 != null){
                    if (_local_4.name == _arg_2){
                        return (_local_4);
                    };
                };
                _local_3--;
            };
            return (null);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:Boolean, _arg_4:String=null):void
        {
            var _local_7:String;
            var _local_8:int;
            var _local_9:Sprite;
            var _local_10:Sprite;
            var _local_5:ImageResult;
            if (_arg_3){
                _local_5 = this.RoomEngine(this._activeRoomId, this._activeRoomCategory, _arg_1, _arg_2, new Vector3d(), 1, null);
            }
            else {
                if (this._SafeStr_13450 != null){
                    _local_7 = null;
                    _local_8 = 0;
                    if (_arg_2 == RoomObjectCategoryEnum._SafeStr_4329){
                        _local_7 = this._SafeStr_13450.getActiveObjectType(_arg_1);
                        _local_8 = this._SafeStr_13450.getActiveObjectColorIndex(_arg_1);
                    }
                    else {
                        if (_arg_2 == RoomObjectCategoryEnum._SafeStr_4330){
                            _local_7 = this._SafeStr_13450.RoomEngine(_arg_1, _arg_4);
                            _local_8 = this._SafeStr_13450.RoomEngine(_arg_1);
                        };
                    };
                    if (_arg_2 == RoomObjectCategoryEnum.OBJECT_CATEGORY_USER){
                        _local_7 = this.RoomEngine(_arg_1);
                        if (_local_7 == "pet"){
                            _local_7 = this.RoomEngine(_arg_4);
                        };
                        _local_5 = this.getGenericRoomObjectImage(_local_7, _arg_4, new Vector3d(180), 1, null);
                    }
                    else {
                        _local_5 = this.getGenericRoomObjectImage(_local_7, String(_local_8), new Vector3d(), 1, null, 0, _arg_4);
                    };
                };
            };
            if ((((_local_5 == null)) || ((_local_5.data == null)))){
                return;
            };
            var _local_6:IRoomRenderingCanvas = this.RoomEngine(this._activeRoomId, this._activeRoomCategory, this._SafeStr_13457);
            if (_local_6 != null){
                _local_9 = this.RoomEngine(_local_6);
                this.RoomEngine(_local_9, _SafeStr_13443);
                _local_10 = this.RoomEngine(_local_9, _SafeStr_13443, _local_5.data);
                if (_local_10 != null){
                    _local_10.x = (this._SafeStr_13458 - (_local_5.data.width / 2));
                    _local_10.y = (this._SafeStr_13459 - (_local_5.data.height / 2));
                };
            };
        }
        public function RoomEngine(_arg_1:Boolean):void
        {
            var _local_3:Sprite;
            var _local_4:Sprite;
            var _local_2:IRoomRenderingCanvas = this.RoomEngine(this._activeRoomId, this._activeRoomCategory, this._SafeStr_13457);
            if (_local_2 != null){
                _local_3 = this.RoomEngine(_local_2);
                _local_4 = this.RoomEngine(_local_3, _SafeStr_13443);
                if (_local_4 != null){
                    _local_4.visible = _arg_1;
                };
            };
        }
        public function RoomEngine():void
        {
            var _local_2:Sprite;
            var _local_1:IRoomRenderingCanvas = this.RoomEngine(this._activeRoomId, this._activeRoomCategory, this._SafeStr_13457);
            if (_local_1 != null){
                _local_2 = this.RoomEngine(_local_1);
                this.RoomEngine(_local_2, _SafeStr_13443);
            };
        }
        public function IRoomSpriteCanvasContainer(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            if (!this._isInitialized){
                return (0);
            };
            var _local_4:String = this.getRoomIdentifier(_arg_1, _arg_2);
            var _local_5:IRoomInstance = this._roomManager.getRoom(_local_4);
            if (_local_5 == null){
                return (0);
            };
            return (_local_5.RoomInstance(_arg_3));
        }
        public function IRoomSpriteCanvasContainer(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):IRoomObject
        {
            if (!this._isInitialized){
                return (null);
            };
            var _local_5:String = this.getRoomIdentifier(_arg_1, _arg_2);
            return (this.RoomInstance(_local_5, _arg_3, _arg_4));
        }
        public function IRoomSpriteCanvasContainer(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):IRoomObject
        {
            if (!this._isInitialized){
                return (null);
            };
            var _local_5:String = this.getRoomIdentifier(_arg_1, _arg_2);
            var _local_6:IRoomInstance = this._roomManager.getRoom(_local_5);
            if (_local_6 == null){
                return (null);
            };
            return (_local_6.RoomInstance(_arg_3, _arg_4));
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:String):Boolean
        {
            if (this._SafeStr_13448 != null){
                return (this._SafeStr_13448.RoomEngine(this._activeRoomId, this._activeRoomCategory, _arg_1, _arg_2, _arg_3));
            };
            return (false);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:Map):Boolean
        {
            if (this._SafeStr_13448 != null){
                if (_arg_2 == RoomObjectCategoryEnum._SafeStr_4329){
                    return (this._SafeStr_13448.RoomEngine(this._activeRoomId, this._activeRoomCategory, _arg_1, _arg_2, _arg_3, _arg_4));
                };
            };
            return (false);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:String):Boolean
        {
            if (this._SafeStr_13448 != null){
                if (_arg_2 == RoomObjectCategoryEnum._SafeStr_4330){
                    return (this._SafeStr_13448.modifyWallItemData(this._activeRoomId, this._activeRoomCategory, _arg_1, _arg_3));
                };
            };
            return (false);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int):Boolean
        {
            if (this._SafeStr_13448 != null){
                if (_arg_2 == RoomObjectCategoryEnum._SafeStr_4330){
                    return (this._SafeStr_13448.deleteWallItem(this._activeRoomId, this._activeRoomCategory, _arg_1));
                };
            };
            return (false);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String=null):Boolean
        {
            var _local_5:IRoomInstance = this.getRoom(this._activeRoomId, this._activeRoomCategory);
            if ((((_local_5 == null)) || (!((_local_5.getNumber(RoomVariableEnum._SafeStr_13369) == 0))))){
                return (false);
            };
            if (this._SafeStr_13448 != null){
                return (this._SafeStr_13448.RoomEngine(this._activeRoomId, this._activeRoomCategory, _arg_1, _arg_2, _arg_3, _arg_4));
            };
            return (false);
        }
        public function RoomEngine():void
        {
            if (this._SafeStr_13448 != null){
                this._SafeStr_13448.RoomEngine(this._activeRoomId, this._activeRoomCategory);
            };
        }
        public function RoomEngine(_arg_1:int, _arg_2:int):Boolean
        {
            var _local_4:IRoomObjectEventHandler;
            var _local_3:IRoomObject = this.IRoomSpriteCanvasContainer(this._activeRoomId, this._activeRoomCategory, _arg_1, _arg_2);
            if (_local_3 != null){
                _local_4 = (_local_3.getMouseHandler() as IRoomObjectEventHandler);
                if (_local_4 != null){
                    _local_4.useObject();
                    return (true);
                };
            };
            return (false);
        }
        private function RoomEngine(_arg_1:String):String
        {
            if (this._SafeStr_13450 != null){
                return (this._SafeStr_13450.RoomEngine(_arg_1));
            };
            return ("");
        }
        public function RoomEngine(_arg_1:String, _arg_2:String):void
        {
            if (this._SafeStr_13450 != null){
                this._SafeStr_13450.RoomEngine(_arg_1, _arg_2);
            };
        }
        public function RoomEngine(_arg_1:String):int
        {
            if (this._SafeStr_13450 != null){
                return (this._SafeStr_13450.getObjectCategory(_arg_1));
            };
            return (RoomObjectCategoryEnum._SafeStr_4962);
        }
        public function RoomEngine(_arg_1:int):String
        {
            if (this._SafeStr_13450 != null){
                return (this._SafeStr_13450.getActiveObjectType(_arg_1));
            };
            return ("");
        }
        public function RoomEngine(_arg_1:int, _arg_2:String=null):String
        {
            if (this._SafeStr_13450 != null){
                return (this._SafeStr_13450.RoomEngine(_arg_1, _arg_2));
            };
            return ("");
        }
        private function RoomEngine(_arg_1:int):String
        {
            switch (_arg_1){
                case 1:
                    return ("user");
                case 2:
                    return ("pet");
                case 3:
                    return ("bot");
            };
            return (null);
        }
        private function RoomEngine(_arg_1:String):String
        {
            var _local_2:Array;
            var _local_3:int;
            if (_arg_1 != null){
                _local_2 = _arg_1.split(" ");
                if (_local_2.length > 1){
                    _local_3 = parseInt(_local_2[0]);
                    if (_local_3 >= 8){
                        if (this._SafeStr_13450 != null){
                            return (this._SafeStr_13450.RoomEngine(_local_3));
                        };
                    };
                    return ("pet");
                };
            };
            return (null);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int):PetColorResult
        {
            if (this._SafeStr_13450 != null){
                return (this._SafeStr_13450.RoomEngine(_arg_1, _arg_2));
            };
            return (null);
        }
        private function RoomEngine(_arg_1:int):int
        {
            if (this._SafeStr_13450 != null){
                return (this._SafeStr_13450.getActiveObjectColorIndex(_arg_1));
            };
            return (0);
        }
        private function RoomEngine(_arg_1:int):int
        {
            if (this._SafeStr_13450 != null){
                return (this._SafeStr_13450.RoomEngine(_arg_1));
            };
            return (0);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int):IRoomObjectController
        {
            return (this.RoomInstance(this.getRoomIdentifier(_arg_1, _arg_2), _SafeStr_13441, RoomObjectCategoryEnum._SafeStr_13134));
        }
        public function RoomEngine(_arg_1:int, _arg_2:int):IRoomObjectController
        {
            return (this.RoomInstance(this.getRoomIdentifier(_arg_1, _arg_2), _SafeStr_13439, RoomObjectCategoryEnum._SafeStr_13134));
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:IVector3d, _arg_6:IVector3d, _arg_7:int, _arg_8:String, _arg_9:Number=NaN, _arg_10:int=-1, _arg_11:Boolean=false):Boolean
        {
            var _local_13:FurnitureData;
            var _local_12:RoomInstanceData = this.RoomEngine(_arg_1, _arg_2);
            if (_local_12 != null){
                _local_13 = new FurnitureData(_arg_3, _arg_4, null, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
                _local_12.addFurnitureData(_local_13);
            };
            return (true);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:IVector3d, _arg_6:IVector3d, _arg_7:int, _arg_8:String, _arg_9:Number=NaN):Boolean
        {
            var _local_12:String;
            var _local_13:FurnitureData;
            var _local_10:String = this.RoomEngine(_arg_1, _arg_2);
            if (((this.RoomEngine(_local_10)) && (!((this._SafeStr_13450 == null))))){
                _local_12 = (this._SafeStr_13450.getPublicRoomContentType(_local_10) + "_");
                _arg_4 = (_local_12 + _arg_4);
            };
            var _local_11:RoomInstanceData = this.RoomEngine(_arg_1, _arg_2);
            if (_local_11 != null){
                _local_13 = new FurnitureData(_arg_3, 0, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, 0);
                _local_11.addFurnitureData(_local_13);
            };
            return (true);
        }
        private function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:FurnitureData):Boolean
        {
            var _local_11:RoomInstanceData;
            if (_arg_4 == null){
                _local_11 = this.RoomEngine(_arg_1, _arg_2);
                if (_local_11 != null){
                    _arg_4 = _local_11.getFurnitureDataWithId(_arg_3);
                };
            };
            if (_arg_4 == null){
                return (false);
            };
            var _local_5:Boolean;
            var _local_6:String = _arg_4.type;
            if (_local_6 == null){
                _local_6 = this.RoomEngine(_arg_4.typeId);
                _local_5 = true;
            };
            var _local_7:int = this.RoomEngine(_arg_4.typeId);
            var _local_8:String = this.RoomEngine(_local_6);
            if (_local_6 == null){
                _local_6 = "";
            };
            var _local_9:IRoomObjectController = this.RoomEngine(_arg_1, _arg_2, _arg_3, _local_6);
            if (_local_9 == null){
                return (false);
            };
            if (((((!((_local_9 == null))) && (!((_local_9.getModelController() == null))))) && (_local_5))){
                _local_9.getModelController().setNumber(RoomObjectVariableEnum._SafeStr_7220, _local_7, true);
                _local_9.getModelController().setNumber(RoomObjectVariableEnum._SafeStr_7294, _arg_4.typeId, true);
                _local_9.getModelController().setString(RoomObjectVariableEnum._SafeStr_12448, _local_8, true);
                _local_9.getModelController().setNumber(RoomObjectVariableEnum._SafeStr_12500, 1, true);
                _local_9.getModelController().setNumber(RoomObjectVariableEnum._SafeStr_7353, _arg_4.expiryTime);
                _local_9.getModelController().setNumber(RoomObjectVariableEnum._SafeStr_7354, getTimer());
                if (_arg_4.knownAsUsable){
                    _local_9.getModelController().setNumber(RoomObjectVariableEnum._SafeStr_7348, 1);
                };
            };
            if (!this.RoomEngine(_arg_1, _arg_2, _arg_3, _arg_4.loc, _arg_4.dir, _arg_4.state, _arg_4.data, _arg_4.extra)){
                return (false);
            };
            if (events != null){
                events.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.REOB_OBJECT_ADDED, _arg_1, _arg_2, _arg_3, RoomObjectCategoryEnum._SafeStr_4329));
            };
            var _local_10:ISelectedRoomObjectData = this.RoomEngine(_arg_1, _arg_2);
            if (((((_local_10) && ((Math.abs(_local_10.id) == _arg_3)))) && ((_local_10.category == RoomObjectCategoryEnum._SafeStr_4329)))){
                this.selectRoomObject(_arg_1, _arg_2, _arg_3, RoomObjectCategoryEnum._SafeStr_4329);
            };
            return (true);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
            var _local_6:Number;
            var _local_5:IRoomObjectController = this.RoomInstance(this.getRoomIdentifier(_arg_1, _arg_2), _arg_3, _arg_4);
            if (((!((_local_5 == null))) && (!((_local_5.getModelController() == null))))){
                _local_6 = _local_5.getModelController().getNumber(RoomObjectVariableEnum._SafeStr_12644);
                if (isNaN(_local_6)){
                    _local_6 = 1;
                }
                else {
                    _local_6 = (_local_6 + 1);
                };
                _local_5.getModelController().setNumber(RoomObjectVariableEnum._SafeStr_12644, _local_6);
            };
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:IVector3d, _arg_5:IVector3d, _arg_6:int, _arg_7:String, _arg_8:Number=NaN):Boolean
        {
            var _local_9:IRoomObjectController = this.RoomEngine(_arg_1, _arg_2, _arg_3);
            if (_local_9 == null){
                return (false);
            };
            var _local_10:RoomObjectUpdateMessage = new RoomObjectUpdateMessage(_arg_4, _arg_5);
            var _local_11:RoomObjectDataUpdateMessage = new RoomObjectDataUpdateMessage(_arg_6, _arg_7, _arg_8);
            if (((!((_local_9 == null))) && (!((_local_9.getEventHandler() == null))))){
                _local_9.getEventHandler().processUpdateMessage(_local_10);
                _local_9.getEventHandler().processUpdateMessage(_local_11);
            };
            return (true);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:IVector3d, _arg_5:IVector3d):Boolean
        {
            var _local_7:RoomObjectMoveUpdateMessage;
            var _local_6:IRoomObjectController = this.RoomEngine(_arg_1, _arg_2, _arg_3);
            if (_local_6 == null){
                return (false);
            };
            if (((!((_local_6 == null))) && (!((_local_6.getEventHandler() == null))))){
                _local_7 = new RoomObjectMoveUpdateMessage(_arg_4, _arg_5, null, !((_arg_5 == null)));
                _local_6.getEventHandler().processUpdateMessage(_local_7);
            };
            return (true);
        }
        private function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String):IRoomObjectController
        {
            var _local_5:int = RoomObjectCategoryEnum._SafeStr_4329;
            return (this.createObject(this.getRoomIdentifier(_arg_1, _arg_2), _arg_3, _arg_4, _local_5));
        }
        private function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int):IRoomObjectController
        {
            return (this.RoomInstance(this.getRoomIdentifier(_arg_1, _arg_2), _arg_3, RoomObjectCategoryEnum._SafeStr_4329));
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            var _local_4:RoomInstanceData = this.RoomEngine(_arg_1, _arg_2);
            if (_local_4 != null){
                _local_4.getFurnitureDataWithId(_arg_3);
            };
            this.RoomInstance(this.getRoomIdentifier(_arg_1, _arg_2), _arg_3, RoomObjectCategoryEnum._SafeStr_4329);
            this.RoomEngine(RoomObjectCategoryEnum._SafeStr_4329, _arg_3);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:IVector3d, _arg_6:IVector3d, _arg_7:int, _arg_8:String, _arg_9:Boolean=false):Boolean
        {
            var _local_11:FurnitureData;
            var _local_10:RoomInstanceData = this.RoomEngine(_arg_1, _arg_2);
            if (_local_10 != null){
                _local_11 = new FurnitureData(_arg_3, _arg_4, null, _arg_5, _arg_6, _arg_7, _arg_8, NaN, -1, _arg_9);
                _local_10.addWallItemData(_local_11);
            };
            return (true);
        }
        private function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:FurnitureData):Boolean
        {
            var _local_10:RoomInstanceData;
            if (_arg_4 == null){
                _local_10 = this.RoomEngine(_arg_1, _arg_2);
                if (_local_10 != null){
                    _arg_4 = _local_10.getWallItemDataWithId(_arg_3);
                };
            };
            if (_arg_4 == null){
                return (false);
            };
            var _local_5:String = this.RoomEngine(_arg_4.typeId, _arg_4.data);
            var _local_6:int = this.RoomEngine(_arg_4.typeId);
            var _local_7:String = this.RoomEngine(_local_5);
            if (_local_5 == null){
                _local_5 = "";
            };
            var _local_8:IRoomObjectController = this.RoomEngine(_arg_1, _arg_2, _arg_3, _local_5);
            if (_local_8 == null){
                return (false);
            };
            if (((!((_local_8 == null))) && (!((_local_8.getModelController() == null))))){
                _local_8.getModelController().setNumber(RoomObjectVariableEnum._SafeStr_7220, _local_6, false);
                _local_8.getModelController().setNumber(RoomObjectVariableEnum._SafeStr_7294, _arg_4.typeId, true);
                _local_8.getModelController().setString(RoomObjectVariableEnum._SafeStr_12448, _local_7, true);
                _local_8.getModelController().setNumber(RoomObjectVariableEnum._SafeStr_13000, 1, true);
                if (_arg_4.knownAsUsable){
                    _local_8.getModelController().setNumber(RoomObjectVariableEnum._SafeStr_7348, 1);
                };
            };
            if (!this.RoomEngine(_arg_1, _arg_2, _arg_3, _arg_4.loc, _arg_4.dir, _arg_4.state, _arg_4.data)){
                return (false);
            };
            if (events != null){
                events.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.REOB_OBJECT_ADDED, _arg_1, _arg_2, _arg_3, RoomObjectCategoryEnum._SafeStr_4330));
            };
            var _local_9:ISelectedRoomObjectData = this.RoomEngine(_arg_1, _arg_2);
            if (((((_local_9) && ((_local_9.id == _arg_3)))) && ((_local_9.category == RoomObjectCategoryEnum._SafeStr_4330)))){
                this.selectRoomObject(_arg_1, _arg_2, _arg_3, RoomObjectCategoryEnum._SafeStr_4330);
            };
            return (true);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:IVector3d, _arg_5:IVector3d, _arg_6:int, _arg_7:String):Boolean
        {
            var _local_8:IRoomObjectController = this.RoomEngine(_arg_1, _arg_2, _arg_3);
            if (_local_8 == null){
                return (false);
            };
            var _local_9:RoomObjectUpdateMessage = new RoomObjectUpdateMessage(_arg_4, _arg_5);
            var _local_10:RoomObjectDataUpdateMessage = new RoomObjectDataUpdateMessage(_arg_6, _arg_7);
            if (((!((_local_8 == null))) && (!((_local_8.getEventHandler() == null))))){
                _local_8.getEventHandler().processUpdateMessage(_local_9);
                _local_8.getEventHandler().processUpdateMessage(_local_10);
            };
            this.RoomEngine(_arg_1, _arg_2, _arg_3);
            return (true);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Boolean=true):void
        {
            var _local_9:String;
            var _local_10:IVector3d;
            var _local_5:String = ((RoomObjectCategoryEnum._SafeStr_4330 + "_") + _arg_3);
            var _local_6:RoomObjectRoomMaskUpdateMessage;
            var _local_7:IRoomObjectController = this.RoomEngine(_arg_1, _arg_2, _arg_3);
            if (_local_7 != null){
                if (_local_7.getModel() != null){
                    if (_local_7.getModel().getNumber(RoomObjectVariableEnum._SafeStr_12483) > 0){
                        _local_9 = _local_7.getModel().getString(RoomObjectVariableEnum._SafeStr_12484);
                        _local_10 = _local_7.getLocation();
                        if (_arg_4){
                            _local_6 = new RoomObjectRoomMaskUpdateMessage(RoomObjectRoomMaskUpdateMessage.RORMUM_ADD_MASK, _local_5, _local_9, _local_10);
                        }
                        else {
                            _local_6 = new RoomObjectRoomMaskUpdateMessage(RoomObjectRoomMaskUpdateMessage.RORMUM_ADD_MASK, _local_5);
                        };
                    };
                };
            }
            else {
                _local_6 = new RoomObjectRoomMaskUpdateMessage(RoomObjectRoomMaskUpdateMessage.RORMUM_ADD_MASK, _local_5);
            };
            var _local_8:IRoomObjectController = this.RoomEngine(_arg_1, _arg_2);
            if (((((!((_local_8 == null))) && (!((_local_8.getEventHandler() == null))))) && (!((_local_6 == null))))){
                _local_8.getEventHandler().processUpdateMessage(_local_6);
            };
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String):Boolean
        {
            var _local_5:IRoomObjectController = this.RoomEngine(_arg_1, _arg_2, _arg_3);
            if (_local_5 == null){
                return (false);
            };
            var _local_6:RoomObjectItemDataUpdateMessage = new RoomObjectItemDataUpdateMessage(_arg_4);
            if (((!((_local_5 == null))) && (!((_local_5.getEventHandler() == null))))){
                _local_5.getEventHandler().processUpdateMessage(_local_6);
            };
            return (true);
        }
        private function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String):IRoomObjectController
        {
            var _local_5:int = RoomObjectCategoryEnum._SafeStr_4330;
            return (this.createObject(this.getRoomIdentifier(_arg_1, _arg_2), _arg_3, _arg_4, _local_5));
        }
        private function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int):IRoomObjectController
        {
            return (this.RoomInstance(this.getRoomIdentifier(_arg_1, _arg_2), _arg_3, RoomObjectCategoryEnum._SafeStr_4330));
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:IVector3d):Boolean
        {
            var _local_6:RoomObjectMoveUpdateMessage;
            var _local_5:IRoomObjectController = this.RoomEngine(_arg_1, _arg_2, _arg_3);
            if (_local_5 == null){
                return (false);
            };
            if (_local_5.getEventHandler() != null){
                _local_6 = new RoomObjectMoveUpdateMessage(_arg_4, null, null);
                _local_5.getEventHandler().processUpdateMessage(_local_6);
            };
            this.RoomEngine(_arg_1, _arg_2, _arg_3);
            return (true);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            var _local_4:RoomInstanceData = this.RoomEngine(_arg_1, _arg_2);
            if (_local_4 != null){
                _local_4.getWallItemDataWithId(_arg_3);
            };
            this.RoomInstance(this.getRoomIdentifier(_arg_1, _arg_2), _arg_3, RoomObjectCategoryEnum._SafeStr_4330);
            this.RoomEngine(_arg_1, _arg_2, _arg_3, false);
            this.RoomEngine(RoomObjectCategoryEnum._SafeStr_4330, _arg_3);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:IVector3d, _arg_5:IVector3d, _arg_6:Number, _arg_7:int, _arg_8:String=null):Boolean
        {
            var _local_11:RoomObjectUpdateMessage;
            var _local_12:RoomObjectAvatarFigureUpdateMessage;
            if (this.RoomEngine(_arg_1, _arg_2, _arg_3) != null){
                return (false);
            };
            var _local_9:String = this.RoomEngine(_arg_7);
            if (_local_9 == "pet"){
                _local_9 = this.RoomEngine(_arg_8);
            };
            var _local_10:IRoomObjectController = this.RoomEngine(_arg_1, _arg_2, _arg_3, _local_9);
            if (_local_10 == null){
                return (false);
            };
            if (((!((_local_10 == null))) && (!((_local_10.getEventHandler() == null))))){
                _local_11 = new RoomObjectAvatarUpdateMessage(_arg_4, null, _arg_5, _arg_6);
                _local_10.getEventHandler().processUpdateMessage(_local_11);
                if (_arg_8 != null){
                    _local_12 = new RoomObjectAvatarFigureUpdateMessage(_arg_8);
                    _local_10.getEventHandler().processUpdateMessage(_local_12);
                };
            };
            if (events != null){
                events.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.REOB_OBJECT_ADDED, _arg_1, _arg_2, _arg_3, RoomObjectCategoryEnum.OBJECT_CATEGORY_USER));
            };
            return (true);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:IVector3d, _arg_5:IVector3d, _arg_6:IVector3d=null, _arg_7:Number=NaN):Boolean
        {
            var _local_8:IRoomObjectController = this.RoomEngine(_arg_1, _arg_2, _arg_3);
            if ((((((_local_8 == null)) || ((_local_8.getEventHandler() == null)))) || ((_local_8.getModel() == null)))){
                return (false);
            };
            if (_arg_4 == null){
                _arg_4 = _local_8.getLocation();
            };
            if (_arg_6 == null){
                _arg_6 = _local_8.getDirection();
            };
            if (isNaN(_arg_7)){
                _arg_7 = _local_8.getModel().getNumber(RoomObjectVariableEnum._SafeStr_4375);
            };
            var _local_9:RoomObjectUpdateMessage = new RoomObjectAvatarUpdateMessage(_arg_4, _arg_5, _arg_6, _arg_7);
            _local_8.getEventHandler().processUpdateMessage(_local_9);
            return (true);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String):Boolean
        {
            var _local_5:IRoomObjectController = this.RoomEngine(_arg_1, _arg_2, _arg_3);
            if ((((_local_5 == null)) || ((_local_5.getEventHandler() == null)))){
                return (false);
            };
            var _local_6:RoomObjectUpdateStateMessage = new RoomObjectAvatarFlatControlUpdateMessage(_arg_4);
            _local_5.getEventHandler().processUpdateMessage(_local_6);
            return (true);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:String=null, _arg_6:String=null):Boolean
        {
            var _local_7:IRoomObjectController = this.RoomEngine(_arg_1, _arg_2, _arg_3);
            if ((((_local_7 == null)) || ((_local_7.getEventHandler() == null)))){
                return (false);
            };
            var _local_8:RoomObjectUpdateStateMessage = new RoomObjectAvatarFigureUpdateMessage(_arg_4, _arg_5, _arg_6);
            _local_7.getEventHandler().processUpdateMessage(_local_8);
            return (true);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:int, _arg_6:String=null):Boolean
        {
            var _local_7:IRoomObjectController = this.RoomEngine(_arg_1, _arg_2, _arg_3);
            if ((((_local_7 == null)) || ((_local_7.getEventHandler() == null)))){
                return (false);
            };
            var _local_8:RoomObjectUpdateStateMessage;
            switch (_arg_4){
                case RoomObjectVariableEnum._SafeStr_6545:
                    _local_8 = new RoomObjectAvatarChatUpdateMessage(_arg_5);
                    break;
                case RoomObjectVariableEnum._SafeStr_6546:
                    _local_8 = new RoomObjectAvatarWaveUpdateMessage(!((_arg_5 == 0)));
                    break;
                case RoomObjectVariableEnum._SafeStr_4374:
                    _local_8 = new RoomObjectAvatarSleepUpdateMessage(!((_arg_5 == 0)));
                    break;
                case RoomObjectVariableEnum._SafeStr_6548:
                    _local_8 = new RoomObjectAvatarTypingUpdateMessage(!((_arg_5 == 0)));
                    break;
                case RoomObjectVariableEnum._SafeStr_6552:
                    _local_8 = new RoomObjectAvatarCarryObjectUpdateMessage(_arg_5, _arg_6);
                    break;
                case RoomObjectVariableEnum._SafeStr_6553:
                    _local_8 = new RoomObjectAvatarUseObjectUpdateMessage(_arg_5);
                    break;
                case RoomObjectVariableEnum._SafeStr_6550:
                    _local_8 = new RoomObjectAvatarDanceUpdateMessage(_arg_5);
                    break;
                case RoomObjectVariableEnum._SafeStr_4376:
                    _local_8 = new RoomObjectAvatarExperienceUpdateMessage(_arg_5);
                    break;
                case RoomObjectVariableEnum._SafeStr_6554:
                    _local_8 = new RoomObjectAvatarPlayerValueUpdateMessage(_arg_5);
                    break;
                case RoomObjectVariableEnum._SafeStr_6556:
                    _local_8 = new RoomObjectAvatarSignUpdateMessage(_arg_5);
                    break;
            };
            _local_7.getEventHandler().processUpdateMessage(_local_8);
            return (true);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:String=""):Boolean
        {
            var _local_6:IRoomObjectController = this.RoomEngine(_arg_1, _arg_2, _arg_3);
            if ((((_local_6 == null)) || ((_local_6.getEventHandler() == null)))){
                return (false);
            };
            var _local_7:RoomObjectUpdateStateMessage = new RoomObjectAvatarPostureUpdateMessage(_arg_4, _arg_5);
            _local_6.getEventHandler().processUpdateMessage(_local_7);
            return (true);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):Boolean
        {
            var _local_5:IRoomObjectController = this.RoomEngine(_arg_1, _arg_2, _arg_3);
            if ((((_local_5 == null)) || ((_local_5.getEventHandler() == null)))){
                return (false);
            };
            var _local_6:RoomObjectUpdateStateMessage = new RoomObjectAvatarGestureUpdateMessage(_arg_4);
            _local_5.getEventHandler().processUpdateMessage(_local_6);
            return (true);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String):Boolean
        {
            var _local_5:IRoomObjectController = this.RoomEngine(_arg_1, _arg_2, _arg_3);
            if ((((_local_5 == null)) || ((_local_5.getEventHandler() == null)))){
                return (false);
            };
            var _local_6:RoomObjectUpdateStateMessage = new RoomObjectAvatarPetGestureUpdateMessage(_arg_4);
            _local_5.getEventHandler().processUpdateMessage(_local_6);
            return (true);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int=0):Boolean
        {
            var _local_6:IRoomObjectController = this.RoomEngine(_arg_1, _arg_2, _arg_3);
            if ((((_local_6 == null)) || ((_local_6.getEventHandler() == null)))){
                return (false);
            };
            _local_6.getEventHandler().processUpdateMessage(new RoomObjectAvatarEffectUpdateMessage(_arg_4, _arg_5));
            return (true);
        }
        private function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String):IRoomObjectController
        {
            var _local_5:int = RoomObjectCategoryEnum.OBJECT_CATEGORY_USER;
            return (this.createObject(this.getRoomIdentifier(_arg_1, _arg_2), _arg_3, _arg_4, _local_5));
        }
        private function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int):IRoomObjectController
        {
            return (this.RoomInstance(this.getRoomIdentifier(_arg_1, _arg_2), _arg_3, RoomObjectCategoryEnum.OBJECT_CATEGORY_USER));
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            this.RoomInstance(this.getRoomIdentifier(_arg_1, _arg_2), _arg_3, RoomObjectCategoryEnum.OBJECT_CATEGORY_USER);
        }
        private function createObject(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:int):IRoomObjectController
        {
            var _local_5:IRoomInstance = this._roomManager.getRoom(_arg_1);
            if (_local_5 == null){
                return (null);
            };
            var _local_6:IRoomObjectController;
            return ((_local_5.createRoomObject(_arg_2, _arg_3, _arg_4) as IRoomObjectController));
        }
        private function RoomInstance(_arg_1:String, _arg_2:int, _arg_3:int):IRoomObjectController
        {
            var _local_4:IRoomInstance;
            if (this._roomManager != null){
                _local_4 = this._roomManager.getRoom(_arg_1);
            };
            if (_local_4 == null){
                return (null);
            };
            var _local_5:IRoomObjectController;
            _local_5 = (_local_4.RoomInstance(_arg_2, _arg_3) as IRoomObjectController);
            if (_local_5 == null){
                if (_arg_3 == RoomObjectCategoryEnum._SafeStr_4329){
                    this.RoomEngine(this.RoomEngine(_arg_1), this.RoomEngine(_arg_1), _arg_2, null);
                    _local_5 = (_local_4.RoomInstance(_arg_2, _arg_3) as IRoomObjectController);
                }
                else {
                    if (_arg_3 == RoomObjectCategoryEnum._SafeStr_4330){
                        this.RoomEngine(this.RoomEngine(_arg_1), this.RoomEngine(_arg_1), _arg_2, null);
                        _local_5 = (_local_4.RoomInstance(_arg_2, _arg_3) as IRoomObjectController);
                    };
                };
            };
            return (_local_5);
        }
        private function RoomInstance(_arg_1:String, _arg_2:int, _arg_3:int):void
        {
            var _local_4:IRoomInstance;
            if (this._roomManager != null){
                _local_4 = this._roomManager.getRoom(_arg_1);
                if (_local_4 == null){
                    return;
                };
                if (_local_4.RoomInstance(_arg_2, _arg_3)){
                    if (events != null){
                        events.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.REOE_OBJECT_REMOVED, this._activeRoomId, this._activeRoomCategory, _arg_2, _arg_3));
                    };
                };
            };
        }
        private function roomObjectEventHandler(_arg_1:RoomObjectEvent):void
        {
            if (this._SafeStr_13448 != null){
                this._SafeStr_13448.handleRoomObjectEvent(_arg_1, this._activeRoomId, this._activeRoomCategory);
            };
        }
        public function getFurnitureIcon(_arg_1:int, _arg_2:IGetImageListener, _arg_3:String=null):ImageResult
        {
            return (this.getFurnitureImage(_arg_1, new Vector3d(), 1, _arg_2, 0, _arg_3));
        }
        public function getWallItemIcon(_arg_1:int, _arg_2:IGetImageListener, _arg_3:String=null):ImageResult
        {
            return (this.getWallItemImage(_arg_1, new Vector3d(), 1, _arg_2, 0, _arg_3));
        }
        public function getFurnitureImage(_arg_1:int, _arg_2:IVector3d, _arg_3:int, _arg_4:IGetImageListener, _arg_5:uint=0, _arg_6:String=null, _arg_7:int=-1, _arg_8:int=-1):ImageResult
        {
            var _local_9:String;
            var _local_10:String = "";
            if (this._SafeStr_13450 != null){
                _local_9 = this._SafeStr_13450.getActiveObjectType(_arg_1);
                _local_10 = String(this._SafeStr_13450.getActiveObjectColorIndex(_arg_1));
            };
            return (this.getGenericRoomObjectImage(_local_9, _local_10, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8));
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:IVector3d, _arg_4:int, _arg_5:IGetImageListener, _arg_6:uint=0):ImageResult
        {
            var _local_7:String;
            var _local_8 = (_arg_2 + "");
            if (this._SafeStr_13450 != null){
                _local_7 = this._SafeStr_13450.RoomEngine(_arg_1);
            };
            return (this.getGenericRoomObjectImage(_local_7, _local_8, _arg_3, _arg_4, _arg_5, _arg_6));
        }
        public function getWallItemImage(_arg_1:int, _arg_2:IVector3d, _arg_3:int, _arg_4:IGetImageListener, _arg_5:uint=0, _arg_6:String=null, _arg_7:int=-1, _arg_8:int=-1):ImageResult
        {
            var _local_9:String;
            var _local_10:String = "";
            if (this._SafeStr_13450 != null){
                _local_9 = this._SafeStr_13450.RoomEngine(_arg_1, _arg_6);
                _local_10 = String(this._SafeStr_13450.RoomEngine(_arg_1));
            };
            return (this.getGenericRoomObjectImage(_local_9, _local_10, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8));
        }
        public function getRoomImage(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:int, _arg_5:IGetImageListener, _arg_6:String=null):ImageResult
        {
            if (_arg_1 == null){
                _arg_1 = "";
            };
            if (_arg_2 == null){
                _arg_2 = "";
            };
            if (_arg_3 == null){
                _arg_3 = "";
            };
            var _local_7:String = _SafeStr_13438;
            var _local_8 = (((((_arg_1 + "\n") + _arg_2) + "\n") + _arg_3) + "\n");
            if (_arg_6 != null){
                _local_8 = (_local_8 + _arg_6);
            };
            return (this.getGenericRoomObjectImage(_local_7, _local_8, new Vector3d(), _arg_4, _arg_5));
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:IVector3d, _arg_6:int, _arg_7:IGetImageListener, _arg_8:uint=0):ImageResult
        {
            var _local_11:String;
            var _local_14:IRoomObject;
            var _local_9:String;
            var _local_10:String = "";
            var _local_12:String = this.getRoomIdentifier(_arg_1, _arg_2);
            var _local_13:IRoomInstance = this._roomManager.getRoom(_local_12);
            if (_local_13 != null){
                _local_14 = _local_13.RoomInstance(_arg_3, _arg_4);
                if (((!((_local_14 == null))) && (!((_local_14.getModel() == null))))){
                    _local_9 = _local_14.getType();
                    switch (_arg_4){
                        case RoomObjectCategoryEnum._SafeStr_4329:
                        case RoomObjectCategoryEnum._SafeStr_4330:
                            _local_10 = String(_local_14.getModel().getNumber(RoomObjectVariableEnum._SafeStr_7220));
                            _local_11 = _local_14.getModel().getString(RoomObjectVariableEnum._SafeStr_7295);
                            break;
                        case RoomObjectCategoryEnum.OBJECT_CATEGORY_USER:
                            _local_10 = _local_14.getModel().getString(RoomObjectVariableEnum._SafeStr_4443);
                            break;
                    };
                };
            };
            return (this.getGenericRoomObjectImage(_local_9, _local_10, _arg_5, _arg_6, _arg_7, _arg_8, _local_11));
        }
        private function RoomEngine(_arg_1:IRoomObjectController, _arg_2:String):void
        {
            var _local_3:Array;
            var _local_4:String;
            var _local_5:String;
            var _local_6:String;
            var _local_7:String;
            var _local_8:int;
            var _local_9:RoomPlaneParser;
            var _local_10:int;
            var _local_11:XML;
            var _local_12:int;
            var _local_13:RoomObjectRoomMaskUpdateMessage;
            var _local_14:String;
            if (_arg_2 != null){
                _local_3 = _arg_2.split("\n");
                if (_local_3.length >= 3){
                    _local_4 = _local_3[0];
                    _local_5 = _local_3[1];
                    _local_6 = _local_3[2];
                    _local_7 = _local_3[3];
                    _local_8 = 6;
                    _local_9 = new RoomPlaneParser();
                    _local_9.initializeTileMap((_local_8 + 2), (_local_8 + 2));
                    _local_10 = 1;
                    while (_local_10 < (1 + _local_8)) {
                        _local_12 = 1;
                        while (_local_12 < (1 + _local_8)) {
                            _local_9.setTileHeight(_local_12, _local_10, 0);
                            _local_12++;
                        };
                        _local_10++;
                    };
                    _local_9.wallHeight = _local_8;
                    _local_9.initializeFromTileData();
                    _local_11 = _local_9.getXML();
                    _arg_1.getEventHandler().initialize(_local_11);
                    _arg_1.getModelController().setString(RoomObjectVariableEnum._SafeStr_5784, _local_4);
                    _arg_1.getModelController().setString(RoomObjectVariableEnum._SafeStr_5786, _local_5);
                    _arg_1.getModelController().setString(RoomObjectVariableEnum._SafeStr_5788, _local_6);
                    if (_local_7 != null){
                        _local_13 = null;
                        _local_14 = (RoomObjectCategoryEnum._SafeStr_4330 + "_1");
                        _local_13 = new RoomObjectRoomMaskUpdateMessage(RoomObjectRoomMaskUpdateMessage.RORMUM_ADD_MASK, _local_14, _local_7, new Vector3d(2.5, 0.5, 2));
                        _arg_1.getEventHandler().processUpdateMessage(_local_13);
                    };
                    _local_9.dispose();
                };
            };
        }
        public function getGenericRoomObjectImage(_arg_1:String, _arg_2:String, _arg_3:IVector3d, _arg_4:int, _arg_5:IGetImageListener, _arg_6:uint=0, _arg_7:String=null, _arg_8:int=-1, _arg_9:int=-1):ImageResult
        {
            var _local_18:String;
            var _local_19:RoomObjectDataUpdateMessage;
            var _local_20:int;
            var _local_10:ImageResult = new ImageResult();
            _local_10.id = -1;
            if (((!(this._isInitialized)) || ((_arg_1 == null)))){
                return (_local_10);
            };
            var _local_11:IRoomInstance = this._roomManager.getRoom(_SafeStr_13436);
            if (_local_11 == null){
                _local_11 = this._roomManager.createRoom(_SafeStr_13436, null);
                if (_local_11 == null){
                    return (_local_10);
                };
            };
            var _local_12:int = this._SafeStr_13452.reserveNumber();
            var _local_13:int = this.RoomEngine(_arg_1);
            if (_local_12 < 0){
                return (_local_10);
            };
            _local_12 = (_local_12 + 1);
            var _local_14:IRoomObjectController = (_local_11.createRoomObject(_local_12, _arg_1, _local_13) as IRoomObjectController);
            if ((((((_local_14 == null)) || ((_local_14.getModelController() == null)))) || ((_local_14.getEventHandler() == null)))){
                return (_local_10);
            };
            switch (_local_13){
                case RoomObjectCategoryEnum._SafeStr_4329:
                case RoomObjectCategoryEnum._SafeStr_4330:
                    _local_14.getModelController().setNumber(RoomObjectVariableEnum._SafeStr_7220, int(_arg_2));
                    _local_14.getModelController().setString(RoomObjectVariableEnum._SafeStr_7295, _arg_7);
                    break;
                case RoomObjectCategoryEnum.OBJECT_CATEGORY_USER:
                    if ((((((_arg_1 == "user")) || ((_arg_1 == "bot")))) || ((_arg_1 == "pet")))){
                        _local_14.getModelController().setString(RoomObjectVariableEnum._SafeStr_4443, _arg_2);
                    }
                    else {
                        _local_14.getModelController().setNumber(RoomObjectVariableEnum._SafeStr_4377, int(_arg_2));
                    };
                    break;
                case RoomObjectCategoryEnum._SafeStr_13133:
                    this.RoomEngine(_local_14, _arg_2);
                    break;
            };
            _local_14.setDirection(_arg_3);
            var _local_15:IRoomObjectSpriteVisualization;
            _local_15 = (_local_14.getVisualization() as IRoomObjectSpriteVisualization);
            if (_local_15 == null){
                _local_11.RoomInstance(_local_12, _local_13);
                return (_local_10);
            };
            if (_arg_8 > -1){
                _local_18 = _local_14.getModel().getString(RoomObjectVariableEnum._SafeStr_7217);
                _local_19 = new RoomObjectDataUpdateMessage(_arg_8, _local_18);
                if (_local_14.getEventHandler() != null){
                    _local_14.getEventHandler().processUpdateMessage(_local_19);
                };
            };
            var _local_16:RoomGeometry = new RoomGeometry(_arg_4, new Vector3d(-135, 30, 0), new Vector3d(11, 11, 5));
            _local_15.update(_local_16, 0, true, false);
            if (_arg_9 > 0){
                _local_20 = 0;
                while (_local_20 < _arg_9) {
                    _local_15.update(_local_16, 0, true, false);
                    _local_20++;
                };
            };
            var _local_17:BitmapData = _local_15.TwinkleImages(_arg_6);
            _local_10.data = _local_17;
            _local_10.id = _local_12;
            if (((!(this.RoomEngine(_arg_1))) && (!((_arg_5 == null))))){
                this._SafeStr_13453.add(String(_local_12), _arg_5);
                _local_14.getModelController().setNumber(RoomObjectVariableEnum._SafeStr_13001, _arg_4, true);
            }
            else {
                _local_11.RoomInstance(_local_12, _local_13);
                this._SafeStr_13452.freeNumber((_local_12 - 1));
                _local_10.id = 0;
            };
            _local_16.dispose();
            return (_local_10);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int):Rectangle
        {
            var _local_7:IRoomObject;
            var _local_8:IRoomObjectVisualization;
            var _local_9:Rectangle;
            var _local_10:Point;
            var _local_11:IRoomRenderingCanvas;
            var _local_6:IRoomGeometry = this.RoomEngine(_arg_1, _arg_2, _arg_5);
            if (_local_6 != null){
                _local_7 = this.IRoomSpriteCanvasContainer(_arg_1, _arg_2, _arg_3, _arg_4);
                if (_local_7 != null){
                    _local_8 = _local_7.getVisualization();
                    if (_local_8 != null){
                        _local_9 = _local_8.boundingRectangle;
                        _local_10 = _local_6.RoomGeometry(_local_7.getLocation());
                        if (_local_10 != null){
                            _local_9.offset(_local_10.x, _local_10.y);
                            _local_11 = this.RoomEngine(_arg_1, _arg_2, _arg_5);
                            if (_local_11 != null){
                                _local_9.offset(((_local_11.width / 2) + _local_11.screenOffsetX), ((_local_11.height / 2) + _local_11.screenOffsetY));
                                return (_local_9);
                            };
                        };
                    };
                };
            };
            return (null);
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int):Point
        {
            var _local_7:IRoomObject;
            var _local_8:Point;
            var _local_9:IRoomRenderingCanvas;
            var _local_6:IRoomGeometry = this.RoomEngine(_arg_1, _arg_2, _arg_5);
            if (_local_6 != null){
                _local_7 = this.IRoomSpriteCanvasContainer(_arg_1, _arg_2, _arg_3, _arg_4);
                if (_local_7 != null){
                    _local_8 = _local_6.RoomGeometry(_local_7.getLocation());
                    if (_local_8 != null){
                        _local_9 = this.RoomEngine(_arg_1, _arg_2, _arg_5);
                        if (_local_9 != null){
                            _local_8.offset(((_local_9.width / 2) + _local_9.screenOffsetX), ((_local_9.height / 2) + _local_9.screenOffsetY));
                        };
                        return (_local_8);
                    };
                };
            };
            return (null);
        }
        public function RoomEngine(_arg_1:int):Rectangle
        {
            return (this.RoomEngine(this._activeRoomId, this._activeRoomCategory, _SafeStr_13437, RoomObjectCategoryEnum._SafeStr_13133, _arg_1));
        }
        public function RoomEngine(_arg_1:String):Boolean
        {
            return (this._roomManager.isContentAvailable(_arg_1));
        }
        public function contentLoaded(_arg_1:String, _arg_2:Boolean=false):void
        {
            var _local_9:IRoomObject;
            var _local_10:int;
            var _local_11:BitmapData;
            var _local_12:IRoomObjectSpriteVisualization;
            var _local_13:IGetImageListener;
            var _local_14:Number;
            var _local_3:IRoomInstance = this._roomManager.getRoom(_SafeStr_13436);
            if (_local_3 == null){
                return;
            };
            if (this._SafeStr_13450 == null){
                return;
            };
            var _local_4:RoomGeometry;
            var _local_5:Number = 0;
            var _local_6:int = this._SafeStr_13450.getObjectCategory(_arg_1);
            var _local_7:int = _local_3.RoomInstance(_local_6);
            var _local_8:int = (_local_7 - 1);
            while (_local_8 >= 0) {
                _local_9 = _local_3.RoomInstance(_local_8, _local_6);
                if (((((!((_local_9 == null))) && (!((_local_9.getModel() == null))))) && ((_local_9.getType() == _arg_1)))){
                    _local_10 = _local_9.getId();
                    _local_11 = null;
                    _local_12 = null;
                    _local_12 = (_local_9.getVisualization() as IRoomObjectSpriteVisualization);
                    if (_local_12 != null){
                        _local_14 = _local_9.getModel().getNumber(RoomObjectVariableEnum._SafeStr_13001);
                        if (((!((_local_4 == null))) && (!((_local_5 == _local_14))))){
                            _local_4.dispose();
                            _local_4 = null;
                        };
                        if (_local_4 == null){
                            _local_5 = _local_14;
                            _local_4 = new RoomGeometry(_local_14, new Vector3d(-135, 30, 0), new Vector3d(11, 11, 5));
                        };
                        _local_12.update(_local_4, 0, true, false);
                        _local_11 = _local_12.image;
                    };
                    _local_3.RoomInstance(_local_10, _local_6);
                    this._SafeStr_13452.freeNumber((_local_10 - 1));
                    _local_13 = (this._SafeStr_13453.remove(String(_local_10)) as IGetImageListener);
                    if (((!((_local_13 == null))) && (!((_local_11 == null))))){
                        _local_13.imageReady(_local_10, _local_11);
                    }
                    else {
                        if (_local_11 != null){
                            _local_11.dispose();
                        };
                    };
                };
                _local_8--;
            };
            if (_local_4 != null){
                _local_4.dispose();
            };
        }
        public function objectInitialized(_arg_1:String, _arg_2:int, _arg_3:int):void
        {
            var _local_7:String;
            var _local_8:int;
            var _local_9:RoomObjectDataUpdateMessage;
            var _local_4:int = this.RoomEngine(_arg_1);
            var _local_5:int = this.RoomEngine(_arg_1);
            if (_arg_3 == RoomObjectCategoryEnum._SafeStr_4330){
                this.RoomEngine(_local_4, _local_5, _arg_2);
            };
            var _local_6:IRoomObjectController = (this.IRoomSpriteCanvasContainer(_local_4, _local_5, _arg_2, _arg_3) as IRoomObjectController);
            if (((((!((_local_6 == null))) && (!((_local_6.getModel() == null))))) && (!((_local_6.getEventHandler() == null))))){
                _local_7 = _local_6.getModel().getString(RoomObjectVariableEnum._SafeStr_7217);
                if (_local_7 != null){
                    _local_8 = _local_6.getState(0);
                    _local_9 = new RoomObjectDataUpdateMessage(_local_8, _local_7);
                    _local_6.getEventHandler().processUpdateMessage(_local_9);
                };
                if (events != null){
                    events.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.REOB_OBJECT_CONTENT_UPDATED, _local_4, _local_5, _arg_2, _arg_3));
                };
            };
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            if (this._SafeStr_13448 != null){
                this._SafeStr_13448.setSelectedAvatar(_arg_1, _arg_2, _arg_3, true);
            };
        }
        public function RoomEngine():int
        {
            if (this._SafeStr_13448 != null){
                return (this._SafeStr_13448.RoomEngine());
            };
            return (-1);
        }
        public function selectRoomObject(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
            if (this._SafeStr_13448 == null){
                return;
            };
            this._SafeStr_13448.setSelectedObject(_arg_1, _arg_2, _arg_3, _arg_4);
        }
        public function RoomEngine(_arg_1:String):Array
        {
            if (this._SafeStr_13450 != null){
                return (this._SafeStr_13450.loadLegacyContent(_arg_1, events));
            };
            return (new Array());
        }
        private function RoomEngine(_arg_1:AdEvent):void
        {
            var _local_2:String;
            var _local_3:IRoomObjectController;
            var _local_4:RoomObjectRoomAdUpdateMessage;
            if (this._SafeStr_13450 != null){
                _local_2 = this.RoomEngine(_arg_1.roomId, _arg_1.roomCategory);
                this._SafeStr_13450.addGraphicAsset(this._SafeStr_13450.getPublicRoomContentType(_local_2), RoomObjectVariableEnum._SafeStr_5316, _arg_1.image, true);
                this._SafeStr_13450.addGraphicAsset(this._SafeStr_13450.getPublicRoomContentType(_local_2), RoomObjectVariableEnum._SafeStr_5925, _arg_1.adWarningL, true);
                this._SafeStr_13450.addGraphicAsset(this._SafeStr_13450.getPublicRoomContentType(_local_2), RoomObjectVariableEnum._SafeStr_5926, _arg_1.adWarningR, true);
                _local_3 = this.RoomEngine(_arg_1.roomId, _arg_1.roomCategory);
                if (_local_3 == null){
                    return;
                };
                _local_4 = null;
                _local_4 = new RoomObjectRoomAdUpdateMessage(RoomObjectRoomAdUpdateMessage.RORUM_ROOM_AD_ACTIVATE, RoomObjectVariableEnum._SafeStr_5316, _arg_1.clickUrl);
                _local_3.getEventHandler().processUpdateMessage(_local_4);
            };
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:String, _arg_6:String):void
        {
            if (this._adManager != null){
                this._adManager.loadRoomAdImage(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6);
            };
        }
        private function RoomEngine(_arg_1:AdEvent):void
        {
            var _local_4:RoomObjectRoomAdUpdateMessage;
            var _local_2:IRoomObjectController = this.RoomEngine(_arg_1.roomId, _arg_1.roomCategory);
            if (_local_2 == null){
                return;
            };
            var _local_3:IRoomObjectController = this.RoomEngine(_arg_1.roomId, _arg_1.roomCategory, _arg_1.objectId);
            if ((((_local_3 == null)) || ((_local_3.getEventHandler() == null)))){
                return;
            };
            if (_arg_1.image != null){
                this._SafeStr_13450.addGraphicAsset(_local_3.getType(), _arg_1.imageUrl, _arg_1.image, true);
            };
            switch (_arg_1.type){
                case AdEvent.AE_ROOM_AD_IMAGE_LOADED:
                    _local_4 = new RoomObjectRoomAdUpdateMessage(RoomObjectRoomAdUpdateMessage.RORUM_ROOM_BILLBOARD_IMAGE_LOADED, _arg_1.imageUrl, _arg_1.clickUrl, _arg_1.objectId, _arg_1.image);
                    break;
                case AdEvent.AE_ROOM_AD_IMAGE_LOADING_FAILED:
                    _local_4 = new RoomObjectRoomAdUpdateMessage(RoomObjectRoomAdUpdateMessage.RORUM_ROOM_BILLBOARD_IMAGE_LOADING_FAILED, _arg_1.imageUrl, _arg_1.clickUrl, _arg_1.objectId, _arg_1.image);
                    break;
            };
            if (_local_4 != null){
                _local_3.getEventHandler().processUpdateMessage(_local_4);
            };
        }
        public function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:IAssetLibrary):Boolean
        {
            return (this._SafeStr_13450.insertObjectContent(_arg_1, _arg_2, _arg_3));
        }
        public function RoomEngine(_arg_1:int, _arg_2:String):void
        {
            this._SafeStr_13450.RoomEngine(_arg_1, _arg_2);
        }

    }
}//package com.sulake.habbo.room

// IID = "_-3KV" (String#7712, DoABC#2)
// onCommunicationReady = "_-3Ix" (String#372, DoABC#2)
// onSessionDataManagerReady = "_-0C-" (String#240, DoABC#2)
// RoomEngine = "_-0Ef" (String#3842, DoABC#2)
// RoomEngine = "_-2oq" (String#899, DoABC#2)
// _roomSessionManager = "_-2nJ" (String#249, DoABC#2)
// onToolbarReady = "_-3Ep" (String#218, DoABC#2)
// RoomEngine = "_-10q" (String#1603, DoABC#2)
// ISessionDataManager = "_-Bk" (String#7907, DoABC#2)
// IRoomEngineServices = "_-28G" (String#6208, DoABC#2)
// IRoomManagerListener = "_-2KC" (String#6449, DoABC#2)
// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// _SafeStr_12442 = "_-0vN" (String#16252, DoABC#2)
// _SafeStr_12443 = "_-7h" (String#22530, DoABC#2)
// _SafeStr_12448 = "_-0Jf" (String#14828, DoABC#2)
// _SafeStr_12483 = "_-2T8" (String#20170, DoABC#2)
// _SafeStr_12484 = "_-WN" (String#23505, DoABC#2)
// _SafeStr_12500 = "_-2Sa" (String#20140, DoABC#2)
// ImageResult = "_-31w" (String#21576, DoABC#2)
// _SafeStr_12644 = "_-Rd" (String#23309, DoABC#2)
// isEqual = "_-2hG" (String#20740, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// _SafeStr_12943 = "_-21-" (String#19052, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// _SafeStr_13000 = "_-20a" (String#19033, DoABC#2)
// _SafeStr_13001 = "_-2ay" (String#20485, DoABC#2)
// _SafeStr_13004 = "_-2y9" (String#21399, DoABC#2)
// _SafeStr_13005 = "_-3Im" (String#22228, DoABC#2)
// _SafeStr_13006 = "_-36J" (String#21741, DoABC#2)
// _SafeStr_13007 = "_-0Ud" (String#15229, DoABC#2)
// _SafeStr_13133 = "_-2xl" (String#21386, DoABC#2)
// _SafeStr_13134 = "_-VH" (String#23461, DoABC#2)
// targetId = "_-0Ji" (String#14831, DoABC#2)
// targetCategory = "_-1Hs" (String#17188, DoABC#2)
// targetObjectLoc = "_-05c" (String#14267, DoABC#2)
// limitedLocationX = "_-2WO" (String#20300, DoABC#2)
// limitedLocationY = "_-2AT" (String#19426, DoABC#2)
// centeredLocX = "_-2M" (String#19884, DoABC#2)
// centeredLocY = "_-294" (String#19369, DoABC#2)
// screenWd = "_-2dn" (String#20592, DoABC#2)
// roomWd = "_-1Cg" (String#16971, DoABC#2)
// roomHt = "_-1gg" (String#18164, DoABC#2)
// geometryUpdateId = "_-1y5" (String#18891, DoABC#2)
// initializeLocation = "_-0-v" (String#14049, DoABC#2)
// resetLocation = "_-1tW" (String#18698, DoABC#2)
// legacyGeometry = "_-2lx" (String#20915, DoABC#2)
// roomCamera = "_-0wp" (String#16304, DoABC#2)
// worldType = "_-3B4" (String#21926, DoABC#2)
// selectedObject = "_-1gs" (String#18170, DoABC#2)
// placedObject = "_-1MB" (String#17366, DoABC#2)
// addFurnitureData = "_-0Av" (String#14485, DoABC#2)
// getFurnitureDataWithId = "_-0Xe" (String#15342, DoABC#2)
// addWallItemData = "_-1vL" (String#18770, DoABC#2)
// getWallItemDataWithId = "_-0vM" (String#16251, DoABC#2)
// RoomEngine = "_-0A-" (String#3757, DoABC#2)
// RoomEngine = "_-136" (String#4935, DoABC#2)
// RoomEngine = "_-2BD" (String#6272, DoABC#2)
// RoomEngine = "_-1Nf" (String#5305, DoABC#2)
// RoomEngine = "_-0Op" (String#4066, DoABC#2)
// RoomEngine = "_-1tl" (String#5916, DoABC#2)
// RoomEngine = "_-TO" (String#8274, DoABC#2)
// RoomEngine = "_-hw" (String#2161, DoABC#2)
// RoomEngine = "_-2vR" (String#7185, DoABC#2)
// RoomEngine = "_-2gz" (String#6891, DoABC#2)
// RoomEngine = "_-0jE" (String#4485, DoABC#2)
// RoomEngine = "_-25z" (String#6160, DoABC#2)
// RoomEngine = "_-3Kt" (String#7720, DoABC#2)
// RoomEngine = "_-L3" (String#8103, DoABC#2)
// RoomEngine = "_-LV" (String#8113, DoABC#2)
// RoomEngine = "_-gt" (String#8532, DoABC#2)
// RoomEngine = "_-2Wi" (String#6694, DoABC#2)
// RoomEngine = "_-1t-" (String#5901, DoABC#2)
// RoomEngine = "_-mH" (String#2183, DoABC#2)
// RoomEngine = "_-2bg" (String#6788, DoABC#2)
// RoomEngine = "_-0vv" (String#4766, DoABC#2)
// RoomEngine = "_-0UL" (String#1485, DoABC#2)
// RoomEngine = "_-0Hd" (String#1444, DoABC#2)
// RoomEngine = "_-01q" (String#3599, DoABC#2)
// RoomEngine = "_-qa" (String#8719, DoABC#2)
// RoomEngine = "_-xX" (String#8834, DoABC#2)
// RoomEngine = "_-296" (String#6229, DoABC#2)
// RoomEngine = "_-11O" (String#4903, DoABC#2)
// setSelectedObject = "_-2rr" (String#21149, DoABC#2)
// setSelectedAvatar = "_-0N6" (String#14961, DoABC#2)
// getMouseHandler = "_-EC" (String#7957, DoABC#2)
// handleRoomObjectEvent = "_-0uq" (String#16232, DoABC#2)
// ISelectedRoomObjectData = "_-J6" (String#8063, DoABC#2)
// getEventHandler = "_-1dG" (String#5618, DoABC#2)
// modifyWallItemData = "_-1xa" (String#18872, DoABC#2)
// deleteWallItem = "_-82" (String#22545, DoABC#2)
// RCL_LOADER_READY = "_-1Df" (String#17010, DoABC#2)
// _visualizationFactory = "_-fh" (String#2154, DoABC#2)
// visualizationFactory = "_-2q6" (String#21085, DoABC#2)
// getObjectCategory = "_-3LR" (String#22345, DoABC#2)
// getActiveObjectType = "_-0em" (String#15616, DoABC#2)
// getActiveObjectColorIndex = "_-1IK" (String#17208, DoABC#2)
// RoomEngine = "_-263" (String#6163, DoABC#2)
// RoomEngine = "_-0se" (String#4700, DoABC#2)
// getPublicRoomContentType = "_-0ta" (String#16183, DoABC#2)
// insertObjectContent = "_-Vs" (String#8317, DoABC#2)
// loadLegacyContent = "_-1nL" (String#18438, DoABC#2)
// addGraphicAsset = "_-1ul" (String#18748, DoABC#2)
// RoomEngine = "_-G6" (String#7996, DoABC#2)
// getPublicRoomWorldHeightScale = "_-0KP" (String#14855, DoABC#2)
// getPublicRoomWorldSize = "_-1ld" (String#18360, DoABC#2)
// RoomEngine = "_-ep" (String#23837, DoABC#2)
// _SafeStr_13365 = "_-2Rl" (String#20110, DoABC#2)
// _SafeStr_13366 = "_-1hg" (String#18197, DoABC#2)
// _SafeStr_13367 = "_-Ey" (String#22810, DoABC#2)
// _SafeStr_13368 = "_-H7" (String#22896, DoABC#2)
// _SafeStr_13369 = "_-Kx" (String#23042, DoABC#2)
// _SafeStr_13370 = "_-2PV" (String#20023, DoABC#2)
// _SafeStr_13371 = "_-cC" (String#23722, DoABC#2)
// setCurrentRoom = "_-0HS" (String#14737, DoABC#2)
// disposeRoom = "_-2ya" (String#904, DoABC#2)
// resetCurrentRoom = "_-1wU" (String#18820, DoABC#2)
// RoomEngine = "_-2gw" (String#6889, DoABC#2)
// RoomEngine = "_-0Mn" (String#4018, DoABC#2)
// RoomEngine = "_-18W" (String#1625, DoABC#2)
// RoomEngine = "_-qZ" (String#8718, DoABC#2)
// RoomEngine = "_-36n" (String#7446, DoABC#2)
// RoomEngine = "_-0on" (String#4611, DoABC#2)
// getRoom = "_-1jg" (String#1750, DoABC#2)
// RoomEngine = "_-1HB" (String#5193, DoABC#2)
// RoomEngine = "_-tM" (String#8756, DoABC#2)
// RoomEngine = "_-1tf" (String#1777, DoABC#2)
// RoomEngine = "_-2lc" (String#6995, DoABC#2)
// RoomEngine = "_-2JZ" (String#6430, DoABC#2)
// RoomEngine = "_-2Ul" (String#6662, DoABC#2)
// RoomEngine = "_-2u6" (String#7162, DoABC#2)
// RoomEngine = "_-1VC" (String#5459, DoABC#2)
// RoomEngine = "_-3-V" (String#7294, DoABC#2)
// _SafeStr_13436 = "_-13o" (String#16608, DoABC#2)
// _SafeStr_13437 = "_-2qI" (String#21092, DoABC#2)
// _SafeStr_13438 = "_-Ug" (String#23434, DoABC#2)
// _SafeStr_13439 = "_-rr" (String#24355, DoABC#2)
// _SafeStr_13440 = "_-fb" (String#23870, DoABC#2)
// _SafeStr_13441 = "_-1NQ" (String#17414, DoABC#2)
// _SafeStr_13442 = "_-2CE" (String#19492, DoABC#2)
// _SafeStr_13443 = "_-3Cu" (String#21992, DoABC#2)
// _SafeStr_13444 = "_-yI" (String#24626, DoABC#2)
// _SafeStr_13445 = "_-2mq" (String#20954, DoABC#2)
// _SafeStr_13446 = "_-14N" (String#16631, DoABC#2)
// _adManager = "_-0si" (String#825, DoABC#2)
// _SafeStr_13448 = "_-XL" (String#23536, DoABC#2)
// _SafeStr_13449 = "_-3FR" (String#22096, DoABC#2)
// _SafeStr_13450 = "_-1mq" (String#18415, DoABC#2)
// _SafeStr_13451 = "_-0ZQ" (String#15419, DoABC#2)
// _SafeStr_13452 = "_-384" (String#21805, DoABC#2)
// _SafeStr_13453 = "_-26Y" (String#19274, DoABC#2)
// _isInitialized = "_-27O" (String#19308, DoABC#2)
// _activeRoomId = "_-2b" (String#20487, DoABC#2)
// _activeRoomCategory = "_-1dc" (String#18040, DoABC#2)
// _SafeStr_13457 = "_-0wN" (String#16285, DoABC#2)
// _SafeStr_13458 = "_-IV" (String#22948, DoABC#2)
// _SafeStr_13459 = "_-2eA" (String#20610, DoABC#2)
// _SafeStr_13460 = "_-0Ln" (String#14904, DoABC#2)
// _SafeStr_13461 = "_-1mf" (String#18407, DoABC#2)
// _SafeStr_13462 = "_-0Nk" (String#14980, DoABC#2)
// _SafeStr_13463 = "_-4s" (String#22413, DoABC#2)
// _SafeStr_13464 = "_-1wF" (String#18808, DoABC#2)
// _SafeStr_13465 = "_-vo" (String#24521, DoABC#2)
// _SafeStr_13466 = "_-2yX" (String#21411, DoABC#2)
// _SafeStr_13467 = "_-2QB" (String#20053, DoABC#2)
// _SafeStr_13468 = "_-0br" (String#15506, DoABC#2)
// _SafeStr_13469 = "_-1Km" (String#17303, DoABC#2)
// _SafeStr_13470 = "_-oq" (String#24230, DoABC#2)
// _SafeStr_13471 = "_-0x8" (String#16318, DoABC#2)
// RoomEngine = "_-CK" (String#22702, DoABC#2)
// RoomEngine = "_-0W-" (String#15275, DoABC#2)
// RoomEngine = "_-GN" (String#22868, DoABC#2)
// RoomEngine = "_-1Gw" (String#17148, DoABC#2)
// onAdManagerReady = "_-0Xv" (String#1496, DoABC#2)
// roomManager = "_-3L" (String#22322, DoABC#2)
// useOffsetScrolling = "_-1HS" (String#17168, DoABC#2)
// RoomEngine = "_-0V0" (String#15243, DoABC#2)
// getRoomIdentifier = "_-0yJ" (String#1587, DoABC#2)
// RoomEngine = "_-xR" (String#24587, DoABC#2)
// RoomEngine = "_-1z-" (String#18927, DoABC#2)
// RoomEngine = "_-0Ye" (String#15386, DoABC#2)
// getRoomCount = "_-1cQ" (String#5608, DoABC#2)
// getRoomWithIndex = "_-0lP" (String#4533, DoABC#2)
// RoomInstance = "_-05z" (String#3684, DoABC#2)
// RoomEngine = "_-1gY" (String#18160, DoABC#2)
// RoomEngine = "_-028" (String#14131, DoABC#2)
// RoomEngine = "_-1n1" (String#18423, DoABC#2)
// RoomEngine = "_-0WP" (String#15295, DoABC#2)
// RoomEngine = "_-28I" (String#19342, DoABC#2)
// RoomEngine = "_-XO" (String#23539, DoABC#2)
// RoomEngine = "_-1BW" (String#16919, DoABC#2)
// RoomEngine = "_-28c" (String#19356, DoABC#2)
// screenOffsetX = "_-08x" (String#3738, DoABC#2)
// screenOffsetY = "_-01t" (String#3600, DoABC#2)
// RoomEngine = "_-CX" (String#22706, DoABC#2)
// RoomEngine = "_-zy" (String#24683, DoABC#2)
// RoomEngine = "_-1jF" (String#18254, DoABC#2)
// addObjectUpdateCategory = "_-2A6" (String#6251, DoABC#2)
// setContentLoader = "_-2Q-" (String#6563, DoABC#2)
// RoomEngine = "_-0Pv" (String#15058, DoABC#2)
// RoomEngine = "_-2za" (String#21442, DoABC#2)
// addObjectEventListener = "_-Jk" (String#8078, DoABC#2)
// roomObjectEventHandler = "_-0ub" (String#1574, DoABC#2)
// roomManagerInitialized = "_-1lC" (String#5771, DoABC#2)
// createRoom = "_-1mK" (String#1756, DoABC#2)
// createRoomObject = "_-20d" (String#1799, DoABC#2)
// createRenderer = "_-0Gk" (String#3888, DoABC#2)
// RoomInstance = "_-1zT" (String#6024, DoABC#2)
// IRoomRenderer = "_-24l" (String#6132, DoABC#2)
// mouseListener = "_-2K" (String#6442, DoABC#2)
// z_scale = "_-2LM" (String#6468, DoABC#2)
// RoomGeometry = "_-03w" (String#3646, DoABC#2)
// useMask = "_-1iM" (String#5719, DoABC#2)
// RoomEngine = "_-1WD" (String#17751, DoABC#2)
// RoomEngine = "_-3D3" (String#21998, DoABC#2)
// RoomEngine = "_-2nI" (String#20971, DoABC#2)
// handleMouseEvent = "_-Xa" (String#8360, DoABC#2)
// RoomEngine = "_-278" (String#19297, DoABC#2)
// RoomEngine = "_-2iV" (String#20788, DoABC#2)
// RoomEngine = "_-12F" (String#16547, DoABC#2)
// RoomInstance = "_-252" (String#1807, DoABC#2)
// RoomEngine = "_-2SJ" (String#20130, DoABC#2)
// RoomEngine = "_-1Fq" (String#17108, DoABC#2)
// createObject = "_-j8" (String#2167, DoABC#2)
// RoomInstance = "_-3E-" (String#921, DoABC#2)
// RoomEngine = "_-0g9" (String#15678, DoABC#2)
// RoomEngine = "_-2rB" (String#21126, DoABC#2)
// IRoomObjectController = "_-17p" (String#5034, DoABC#2)
// RoomEngine = "_-U8" (String#23412, DoABC#2)
// RoomEngine = "_-1hd" (String#18195, DoABC#2)
// RoomEngine = "_-6a" (String#22484, DoABC#2)
// reserveNumber = "_-2zo" (String#21453, DoABC#2)
// getVisualization = "_-1At" (String#5090, DoABC#2)
// RoomEngine = "_-Vx" (String#23491, DoABC#2)
// freeNumber = "_-PP" (String#23222, DoABC#2)
// isContentAvailable = "_-0ic" (String#4474, DoABC#2)
// contentLoaded = "_-3K1" (String#7703, DoABC#2)
// objectInitialized = "_-ih" (String#8571, DoABC#2)
// RoomEngine = "_-2Sf" (String#20143, DoABC#2)
// RoomEngineObjectEvent = "_-10r" (String#16492, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// IRoomObjectEventHandler = "_-2c8" (String#6797, DoABC#2)
// IRoomInstance = "_-1j8" (String#5739, DoABC#2)
// IRoomObjectVisualization = "_-3D2" (String#7575, DoABC#2)
// IRoomRenderer = "_-2jS" (String#6944, DoABC#2)
// IRoomObjectSpriteVisualization = "_-2Xc" (String#6715, DoABC#2)
// PetColorResult = "_-06Y" (String#3693, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// RoomEngineRoomColorEvent = "_-2AM" (String#19420, DoABC#2)
// SelectedRoomObjectData = "_-0MS" (String#4010, DoABC#2)
// LegacyWallGeometry = "_-2Nh" (String#6515, DoABC#2)
// TileHeightMap = "_-0Bg" (String#3789, DoABC#2)
// RoomObjectUpdateMessage = "_-73" (String#22503, DoABC#2)
// RoomObjectUpdateStateMessage = "_-2WY" (String#6691, DoABC#2)
// RoomObjectAvatarEffectUpdateMessage = "_-Tq" (String#23400, DoABC#2)
// RoomObjectEventHandler = "_-0NF" (String#4024, DoABC#2)
// RoomContentLoader = "_-22f" (String#6100, DoABC#2)
// RoomObjectRoomPlaneVisibilityUpdateMessage = "_-1Hj" (String#17179, DoABC#2)
// RoomCamera = "_-1FW" (String#17096, DoABC#2)
// RoomObjectAvatarExperienceUpdateMessage = "_-2al" (String#20478, DoABC#2)
// RoomObjectAvatarWaveUpdateMessage = "_-0XU" (String#15334, DoABC#2)
// RoomObjectItemDataUpdateMessage = "_-1yC" (String#18895, DoABC#2)
// RoomVariableEnum = "_-0J6" (String#14804, DoABC#2)
// RoomObjectAvatarUseObjectUpdateMessage = "_-2HN" (String#19699, DoABC#2)
// RoomObjectMouseEvent = "_-20k" (String#19042, DoABC#2)
// RoomObjectAvatarPlayerValueUpdateMessage = "_-0X2" (String#15316, DoABC#2)
// RoomObjectAvatarTypingUpdateMessage = "_-2BI" (String#19455, DoABC#2)
// RoomObjectRoomColorUpdateMessage = "_-0hz" (String#15748, DoABC#2)
// RoomObjectRoomUpdateMessage = "_-L4" (String#23049, DoABC#2)
// FurnitureData = "_-sW" (String#2211, DoABC#2)
// RoomObjectFurnitureActionEvent = "_-2H6" (String#19689, DoABC#2)
// RoomObjectRoomAdUpdateMessage = "_-070" (String#14324, DoABC#2)
// RoomObjectMoveUpdateMessage = "_-2Es" (String#6339, DoABC#2)
// RoomObjectAvatarUpdateMessage = "_-1ht" (String#18207, DoABC#2)
// RoomObjectDataUpdateMessage = "_-2N4" (String#19928, DoABC#2)
// NumberBank = "_-28b" (String#19355, DoABC#2)
// RoomInstanceData = "_-1Yu" (String#5540, DoABC#2)
// RoomObjectAvatarFlatControlUpdateMessage = "_-0bw" (String#15508, DoABC#2)
// RoomObjectAvatarFigureUpdateMessage = "_-0tn" (String#16195, DoABC#2)
// RoomObjectRoomFloorHoleUpdateMessage = "_-208" (String#19017, DoABC#2)
// RoomMessageHandler = "_-2kZ" (String#6967, DoABC#2)
// RoomObjectAvatarGestureUpdateMessage = "_-2NZ" (String#19946, DoABC#2)
// RoomObjectRoomMaskUpdateMessage = "_-0S6" (String#15141, DoABC#2)
// RoomObjectAvatarPetGestureUpdateMessage = "_-3N" (String#22353, DoABC#2)
// RoomObjectAvatarChatUpdateMessage = "_-08" (String#14365, DoABC#2)
// RoomObjectRoomPlanePropertyUpdateMessage = "_-14L" (String#16629, DoABC#2)
// RoomObjectAvatarCarryObjectUpdateMessage = "_-ft" (String#23885, DoABC#2)
// RoomGeometry = "_-2l9" (String#20887, DoABC#2)
// RoomObjectAvatarSleepUpdateMessage = "_-0Hl" (String#14746, DoABC#2)
// RoomPlaneParser = "_-2Ya" (String#6737, DoABC#2)
// RoomObjectAvatarPostureUpdateMessage = "_-0OI" (String#15001, DoABC#2)
// RoomObjectAvatarDanceUpdateMessage = "_-MT" (String#23103, DoABC#2)
// RoomObjectAvatarSignUpdateMessage = "_-V" (String#23446, DoABC#2)
// IRoomRenderingCanvas = "_-22o" (String#6102, DoABC#2)
// IGetImageListener = "_-2i7" (String#6909, DoABC#2)
// RoomInstance = "_-09y" (String#1415, DoABC#2)
// RoomInstance = "_-1GT" (String#844, DoABC#2)
// floorType = "_-1D4" (String#16985, DoABC#2)
// wallType = "_-0n5" (String#15942, DoABC#2)
// landscapeType = "_-29h" (String#19391, DoABC#2)
// extra = "_-2We" (String#6693, DoABC#2)
// expiryTime = "_-1FG" (String#17083, DoABC#2)
// RoomEngine = "_-hN" (String#941, DoABC#2)
// IContext = "_-35P" (String#7415, DoABC#2)
// _SafeStr_4329 = "_-bN" (String#23687, DoABC#2)
// _SafeStr_4330 = "_-0cQ" (String#15531, DoABC#2)
// _SafeStr_4374 = "_-GG" (String#22862, DoABC#2)
// _SafeStr_4375 = "_-0Jq" (String#14835, DoABC#2)
// _SafeStr_4376 = "_-0Bp" (String#14520, DoABC#2)
// _SafeStr_4377 = "_-cz" (String#23755, DoABC#2)
// _SafeStr_4443 = "_-2Lr" (String#19878, DoABC#2)
// updateId = "_-0TD" (String#1478, DoABC#2)
// TwinkleImages = "_-eg" (String#2150, DoABC#2)
// IRoomObjectFactory = "_-2Bh" (String#6281, DoABC#2)
// HabboCommunicationManager = "_-0AQ" (String#809, DoABC#2)
// RSE_STARTED = "_-oj" (String#24224, DoABC#2)
// RSE_ENDED = "_-ar" (String#23665, DoABC#2)
// RoomGeometry = "_-34h" (String#7403, DoABC#2)
// getFurnitureData = "_-40" (String#7745, DoABC#2)
// REOB_OBJECT_ADDED = "_-rY" (String#24341, DoABC#2)
// REOB_OBJECT_CONTENT_UPDATED = "_-31j" (String#21568, DoABC#2)
// REE_INITIALIZED = "_-0c3" (String#15515, DoABC#2)
// initializeTileMap = "_-yM" (String#24629, DoABC#2)
// initializeFromTileData = "_-34W" (String#21678, DoABC#2)
// RoomEngine = "_-1SM" (String#1690, DoABC#2)
// getXML = "_-2Oe" (String#6532, DoABC#2)
// activeRoomId = "_-kJ" (String#2172, DoABC#2)
// activeRoomCategory = "_-1qo" (String#1770, DoABC#2)
// RoomEngine = "_-0Sj" (String#1477, DoABC#2)
// RoomEngine = "_-0aH" (String#1502, DoABC#2)
// RoomEngine = "_-Jw" (String#2086, DoABC#2)
// _SafeStr_4962 = "_-1WC" (String#17750, DoABC#2)
// RoomEngine = "_-0G1" (String#1439, DoABC#2)
// RoomEngine = "_-J0" (String#2084, DoABC#2)
// RoomEngine = "_-0kK" (String#1540, DoABC#2)
// RoomEngine = "_-0Yi" (String#1498, DoABC#2)
// RoomEngine = "_-3-m" (String#1983, DoABC#2)
// RoomEngine = "_-356" (String#1995, DoABC#2)
// RoomEngine = "_-3Dq" (String#2025, DoABC#2)
// RoomEngine = "_-HZ" (String#8028, DoABC#2)
// RoomEngine = "_-vj" (String#8798, DoABC#2)
// RoomEngine = "_-0uE" (String#4728, DoABC#2)
// RoomEngine = "_-1Qw" (String#5373, DoABC#2)
// RoomGeometry = "_-9w" (String#7863, DoABC#2)
// RoomEngine = "_-0PC" (String#4075, DoABC#2)
// RoomGeometry = "_-2Z0" (String#6746, DoABC#2)
// RoomEngine = "_-3FD" (String#7616, DoABC#2)
// RoomEngine = "_-2P0" (String#6544, DoABC#2)
// RoomEngine = "_-o" (String#2192, DoABC#2)
// RoomEngine = "_-DR" (String#2076, DoABC#2)
// IRoomSpriteCanvasContainer = "_-1qD" (String#866, DoABC#2)
// RoomEngine = "_-26n" (String#1814, DoABC#2)
// sessionDataManager = "_-0pX" (String#4623, DoABC#2)
// isMoving = "_-2Cl" (String#19515, DoABC#2)
// loc = "_-0fh" (String#15660, DoABC#2)
// _SafeStr_5316 = "_-1FV" (String#17095, DoABC#2)
// processUpdateMessage = "_-FX" (String#7984, DoABC#2)
// _SafeStr_5321 = "_-2jv" (String#20841, DoABC#2)
// RORUM_ROOM_AD_ACTIVATE = "_-1jv" (String#18281, DoABC#2)
// boundingRectangle = "_-0m7" (String#4552, DoABC#2)
// REOE_OBJECT_DESELECTED = "_-1yB" (String#18894, DoABC#2)
// REOE_OBJECT_REMOVED = "_-2ma" (String#20945, DoABC#2)
// ROFCAE_MOUSE_BUTTON = "_-Sz" (String#23363, DoABC#2)
// RORPFHUM_ADD = "_-wb" (String#24555, DoABC#2)
// RORPFHUM_REMOVE = "_-0CG" (String#14540, DoABC#2)
// REE_ENGINE_INITIALIZED = "_-2KW" (String#19823, DoABC#2)
// REE_DISPOSED = "_-rn" (String#24352, DoABC#2)
// REE_GAME_MODE = "_-131" (String#16581, DoABC#2)
// REE_NORMAL_MODE = "_-1fp" (String#18130, DoABC#2)
// AE_ROOM_AD_IMAGE_LOADED = "_-1jE" (String#18253, DoABC#2)
// AE_ROOM_AD_IMAGE_LOADING_FAILED = "_-27D" (String#19300, DoABC#2)
// AE_ROOM_AD_SHOW = "_-18f" (String#16799, DoABC#2)
// adWarningR = "_-1PS" (String#17486, DoABC#2)
// ROE_MOUSE_MOVE = "_-f9" (String#23852, DoABC#2)
// ROE_MOUSE_CLICK = "_-2sU" (String#21178, DoABC#2)
// _SafeStr_5784 = "_-2G-" (String#19644, DoABC#2)
// RORUM_ROOM_FLOOR_UPDATE = "_-2uz" (String#21276, DoABC#2)
// _SafeStr_5786 = "_-1SC" (String#17588, DoABC#2)
// RORUM_ROOM_WALL_UPDATE = "_-0DM" (String#14584, DoABC#2)
// _SafeStr_5788 = "_-Nt" (String#23160, DoABC#2)
// RORUM_ROOM_LANDSCAPE_UPDATE = "_-G8" (String#22858, DoABC#2)
// _SafeStr_5793 = "_-3En" (String#22068, DoABC#2)
// RORMUM_ADD_MASK = "_-0tl" (String#16193, DoABC#2)
// RORMUM_ADD_MASK = "_-0LP" (String#14892, DoABC#2)
// RORPVUM_FLOOR_VISIBILITY = "_-0u0" (String#16203, DoABC#2)
// RORPVUM_WALL_VISIBILITY = "_-1sU" (String#18653, DoABC#2)
// RORPVUM_FLOOR_THICKNESS = "_-2pM" (String#7067, DoABC#2)
// RORPPUM_WALL_THICKNESS = "_-GT" (String#8005, DoABC#2)
// RoomEngine = "_-u-" (String#8766, DoABC#2)
// RoomEngine = "_-1hN" (String#5693, DoABC#2)
// _SafeStr_5925 = "_-3Ks" (String#22318, DoABC#2)
// _SafeStr_5926 = "_-1Vb" (String#17726, DoABC#2)
// _habboConfiguration = "_-Mv" (String#637, DoABC#2)
// _toolbar = "_-1LG" (String#93, DoABC#2)
// isRoomController = "_-xz" (String#8838, DoABC#2)
// _SafeStr_6545 = "_-2IW" (String#19747, DoABC#2)
// _SafeStr_6546 = "_-n1" (String#24155, DoABC#2)
// _SafeStr_6548 = "_-09g" (String#14434, DoABC#2)
// _SafeStr_6550 = "_-aD" (String#23641, DoABC#2)
// _SafeStr_6552 = "_-0ig" (String#15779, DoABC#2)
// _SafeStr_6553 = "_-2wB" (String#21318, DoABC#2)
// _SafeStr_6554 = "_-4J" (String#22390, DoABC#2)
// _SafeStr_6556 = "_-02t" (String#14155, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// IRoomManager = "_-2kG" (String#6961, DoABC#2)
// ROE_MOUSE_DOWN = "_-va" (String#24512, DoABC#2)
// _SafeStr_7217 = "_-1mr" (String#18416, DoABC#2)
// _SafeStr_7220 = "_-1eF" (String#18068, DoABC#2)
// RoomEngine = "_-0Zc" (String#437, DoABC#2)
// RoomEngine = "_-2j0" (String#6933, DoABC#2)
// RoomEngine = "_-1aj" (String#5572, DoABC#2)
// RoomEngine = "_-1qN" (String#867, DoABC#2)
// HTE_TOOLBAR_CLICK = "_-22-" (String#19089, DoABC#2)
// iconId = "_-2di" (String#20590, DoABC#2)
// SessionDataManager = "_-Hc" (String#8029, DoABC#2)
// _SafeStr_7294 = "_-Uf" (String#23433, DoABC#2)
// _SafeStr_7295 = "_-2nE" (String#20969, DoABC#2)
// RoomEngine = "_-0Eh" (String#3843, DoABC#2)
// RoomEngine = "_-1YS" (String#5529, DoABC#2)
// IRoomSpriteCanvasContainer = "_-1Hy" (String#1654, DoABC#2)
// IRoomSpriteCanvasContainer = "_-cJ" (String#2140, DoABC#2)
// RoomEngine = "_-09k" (String#3753, DoABC#2)
// RoomEngine = "_-2p8" (String#7061, DoABC#2)
// RoomEngine = "_-1Vg" (String#5468, DoABC#2)
// RoomEngine = "_-4G" (String#7750, DoABC#2)
// _SafeStr_7348 = "_-2Po" (String#20036, DoABC#2)
// _SafeStr_7353 = "_-0su" (String#16158, DoABC#2)
// _SafeStr_7354 = "_-2xF" (String#21360, DoABC#2)
// RoomEngine = "_-0BC" (String#3783, DoABC#2)
// RoomEngine = "_-3l" (String#7742, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// RoomEngine = "_-0w6" (String#4772, DoABC#2)
// RoomEngine = "_-QC" (String#8205, DoABC#2)
// RoomEngine = "_-Ht" (String#2080, DoABC#2)
// IUpdateReceiver = "_-Qe" (String#8218, DoABC#2)
// RoomEngine = "_-1P4" (String#1679, DoABC#2)
// IRoomRendererFactory = "_-2zw" (String#7283, DoABC#2)
// IRoomObjectVisualizationFactory = "_-T7" (String#8269, DoABC#2)
// IHabboToolbar = "_-0Wr" (String#4245, DoABC#2)
// AdEvent = "_-1xT" (String#18868, DoABC#2)
// RORCUM_BACKGROUND_COLOR = "_-2XC" (String#20332, DoABC#2)
// RORUM_ROOM_BILLBOARD_IMAGE_LOADED = "_-MO" (String#23100, DoABC#2)
// RORUM_ROOM_BILLBOARD_IMAGE_LOADING_FAILED = "_-1jn" (String#18276, DoABC#2)
// _SafeStr_8203 = "_-1KE" (String#17283, DoABC#2)
// IAdManager = "_-S5" (String#8249, DoABC#2)
// RoomObjectCategoryEnum = "_-1eh" (String#5639, DoABC#2)
// _SafeStr_8503 = "_-Ri" (String#23311, DoABC#2)
// _sessionDataManager = "_-0kq" (String#149, DoABC#2)
// useObject = "_-0zi" (String#1594, DoABC#2)
// isInitialized = "_-1Cr" (String#840, DoABC#2)
// RoomEngine = "_-1ii" (String#1747, DoABC#2)
// loadRoomAdImage = "_-vu" (String#8803, DoABC#2)
// onConnectionReady = "_-0k8" (String#359, DoABC#2)


