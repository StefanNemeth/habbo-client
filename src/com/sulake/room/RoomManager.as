
package com.sulake.room
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.utils.Map;
    import com.sulake.room.object.IRoomObjectVisualizationFactory;
    import com.sulake.iid.IIDRoomObjectFactory;
    import com.sulake.iid.IIDRoomObjectVisualizationFactory;
    import com.sulake.room.events.RoomContentLoadedEvent;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.room.exceptions.RoomManagerException;
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectController;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.room.object.visualization.IRoomObjectGraphicVisualization;
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.room.object.logic.IRoomObjectEventHandler;
    import flash.utils.getTimer;
    import com.sulake.iid.*;

    public class RoomManager extends Component implements IRoomManager, IRoomInstanceContainer 
    {

        public static const _SafeStr_14536:int = -1;
        public static const _SafeStr_14537:int = 0;
        public static const _SafeStr_14538:int = 1;
        public static const _SafeStr_14539:int = 2;
        public static const _SafeStr_14540:int = 3;
        private static const CONTENT_PROCESSING_TIME_LIMIT_MILLISECONDS:int = 40;

        private var _rooms:Map;
        private var _SafeStr_14541:IRoomContentLoader;
        private var _SafeStr_14542:Array;
        private var _updateCategories:Array;
        private var _moveUpdateInterval:int;
        private var _messageListener:IRoomManagerListener;
        private var _SafeStr_14543:IRoomContentLoader;
        private var _SafeStr_14544:IRoomObjectFactory = null;
        private var _visualizationFactory:IRoomObjectVisualizationFactory = null;
        private var _state:int = 0;
        private var _SafeStr_14545:XML = null;
        private var _SafeStr_14546:Array;
        private var _SafeStr_14547:Boolean = false;
        private var _limitContentProcessing:Boolean = true;
        private var _disposed:Boolean = false;

        public function RoomManager(_arg_1:IContext, _arg_2:uint=0)
        {
            this._SafeStr_14546 = [];
            super(_arg_1, _arg_2);
            this._rooms = new Map();
            queueInterface(new IIDRoomObjectFactory(), this.objectFactoryReady);
            queueInterface(new IIDRoomObjectVisualizationFactory(), this.visualizationFactoryReady);
            this._SafeStr_14542 = [];
            this._updateCategories = [];
            events.addEventListener(RoomContentLoadedEvent.RCLE_SUCCESS, this.onContentLoaded);
            events.addEventListener(RoomContentLoadedEvent.RCLE_FAILURE, this.onContentLoaded);
            events.addEventListener(RoomContentLoadedEvent.RCLE_CANCEL, this.onContentLoaded);
        }
        override public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function set limitContentProcessing(_arg_1:Boolean):void
        {
            this._limitContentProcessing = _arg_1;
        }
        override public function dispose():void
        {
            var _local_3:IRoomInstance;
            if (this.disposed){
                return;
            };
            super.dispose();
            var _local_1:int;
            var _local_2:int;
            if (this._rooms != null){
                _local_1 = this._rooms.length;
                _local_2 = 0;
                while (_local_2 < _local_1) {
                    _local_3 = (this._rooms.getWithIndex(_local_2) as IRoomInstance);
                    if (_local_3 != null){
                        _local_3.dispose();
                    };
                    _local_2++;
                };
                this._rooms.dispose();
                this._rooms = null;
            };
            this._messageListener = null;
            if (this._SafeStr_14544 != null){
                release(new IIDRoomObjectFactory());
                this._SafeStr_14544 = null;
            };
            if (this._visualizationFactory != null){
                release(new IIDRoomObjectVisualizationFactory());
                this._visualizationFactory = null;
            };
            this._SafeStr_14542 = null;
            this._updateCategories = null;
            this._SafeStr_14541 = null;
            this._disposed = true;
        }
        private function objectFactoryReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (this.disposed){
                return;
            };
            this._SafeStr_14544 = (_arg_2 as IRoomObjectFactory);
            this.continueInitializing();
        }
        private function visualizationFactoryReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (this.disposed){
                return;
            };
            this._visualizationFactory = (_arg_2 as IRoomObjectVisualizationFactory);
            this.continueInitializing();
        }
        private function continueInitializing():void
        {
            var _local_1:XML;
            if ((((this._SafeStr_14544 == null)) || ((this._visualizationFactory == null)))){
                return;
            };
            this._state = _SafeStr_14538;
            if (this._SafeStr_14545 != null){
                _local_1 = this._SafeStr_14545;
                this._SafeStr_14545 = null;
                this.initialize(_local_1, this._messageListener);
            };
        }
        public function initialize(_arg_1:XML, _arg_2:IRoomManagerListener):Boolean
        {
            var _local_5:String;
            if (this._state == _SafeStr_14537){
                if (this._SafeStr_14545 != null){
                    return (false);
                };
                this._SafeStr_14545 = _arg_1;
                this._messageListener = _arg_2;
                return (true);
            };
            if (this._state >= _SafeStr_14539){
                return (false);
            };
            if (_arg_1 == null){
                return (false);
            };
            if (this._SafeStr_14541 == null){
                return (false);
            };
            this._moveUpdateInterval = 50;
            this._messageListener = _arg_2;
            var _local_3:Array = this._SafeStr_14541.getPlaceHolderTypes();
            var _local_4:int;
            while (_local_4 < _local_3.length) {
                _local_5 = _local_3[_local_4];
                if (this._SafeStr_14542.indexOf(_local_5) < 0){
                    this._SafeStr_14541.loadObjectContent(_local_5, events);
                    this._SafeStr_14542.push(_local_5);
                };
                _local_4++;
            };
            this._state = _SafeStr_14539;
            return (true);
        }
        public function setContentLoader(_arg_1:IRoomContentLoader):void
        {
            if (this._SafeStr_14541 != null){
                this._SafeStr_14541.dispose();
            };
            this._SafeStr_14541 = _arg_1;
        }
        public function addObjectUpdateCategory(_arg_1:int):void
        {
            var _local_4:RoomInstance;
            var _local_2:int = this._updateCategories.indexOf(_arg_1);
            if (_local_2 >= 0){
                return;
            };
            this._updateCategories.push(_arg_1);
            var _local_3:int = (this._rooms.length - 1);
            while (_local_3 >= 0) {
                _local_4 = (this._rooms.getWithIndex(_local_3) as RoomInstance);
                if (_local_4 != null){
                    _local_4.addObjectUpdateCategory(_arg_1);
                };
                _local_3--;
            };
        }
        public function removeObjectUpdateCategory(_arg_1:int):void
        {
            var _local_4:RoomInstance;
            var _local_2:int = this._updateCategories.indexOf(_arg_1);
            if (_local_2 < 0){
                return;
            };
            this._updateCategories.splice(_local_2, 1);
            var _local_3:int = (this._rooms.length - 1);
            while (_local_3 >= 0) {
                _local_4 = (this._rooms.getWithIndex(_local_3) as RoomInstance);
                if (_local_4 != null){
                    _local_4.removeObjectUpdateCategory(_arg_1);
                };
                _local_3--;
            };
        }
        public function createRoom(_arg_1:String, _arg_2:XML):IRoomInstance
        {
            var _local_5:int;
            if (this._state < _SafeStr_14540){
                throw (new RoomManagerException());
            };
            if (this._rooms.getValue(_arg_1) != null){
                return (null);
            };
            var _local_3:RoomInstance = new RoomInstance(_arg_1, this);
            this._rooms.add(String(_arg_1), _local_3);
            var _local_4:int = (this._updateCategories.length - 1);
            while (_local_4 >= 0) {
                _local_5 = this._updateCategories[_local_4];
                _local_3.addObjectUpdateCategory(_local_5);
                _local_4--;
            };
            return (_local_3);
        }
        public function getRoom(_arg_1:String):IRoomInstance
        {
            return ((this._rooms.getValue(_arg_1) as IRoomInstance));
        }
        public function getRoomWithIndex(_arg_1:int):IRoomInstance
        {
            return (this._rooms.getWithIndex(_arg_1));
        }
        public function getRoomCount():int
        {
            return (this._rooms.length);
        }
        public function disposeRoom(_arg_1:String):Boolean
        {
            var _local_2:IRoomInstance = (this._rooms.remove(_arg_1) as IRoomInstance);
            if (_local_2 != null){
                _local_2.dispose();
                return (true);
            };
            return (false);
        }
        public function createRoomObject(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:int):IRoomObject
        {
            if (this._state < _SafeStr_14540){
                throw (new RoomManagerException());
            };
            var _local_5:IRoomInstance = this.getRoom(_arg_1);
            if (_local_5 == null){
                return (null);
            };
            if (this._SafeStr_14541 == null){
                return (null);
            };
            var _local_6:RoomInstance = (_local_5 as RoomInstance);
            if (_local_6 == null){
                return (null);
            };
            var _local_7:IGraphicAssetCollection;
            var _local_8:XML;
            var _local_9:XML;
            var _local_10:String;
            var _local_11:String;
            var _local_12:String = _arg_3;
            if (!this._SafeStr_14541.hasInternalContent(_arg_3)){
                _local_7 = this._SafeStr_14541.getGraphicAssetCollection(_arg_3);
                if (_local_7 == null){
                    this._SafeStr_14541.loadObjectContent(_arg_3, events);
                    _local_12 = this._SafeStr_14541.getPlaceHolderType(_arg_3);
                    _local_7 = this._SafeStr_14541.getGraphicAssetCollection(_local_12);
                };
                _local_8 = this._SafeStr_14541.getVisualizationXML(_local_12);
                _local_9 = this._SafeStr_14541.getLogicXML(_local_12);
                if ((((_local_8 == null)) || ((_local_7 == null)))){
                    return (null);
                };
                _local_10 = this._SafeStr_14541.getVisualizationType(_local_12);
                _local_11 = this._SafeStr_14541.getLogicType(_local_12);
            }
            else {
                _local_10 = _arg_3;
                _local_11 = _arg_3;
            };
            var _local_13:int = 1;
            var _local_14:IRoomObject = _local_6.createObjectInternal(_arg_2, _local_13, _arg_3, _arg_4);
            var _local_15:IRoomObjectController = (_local_14 as IRoomObjectController);
            if (_local_15 == null){
                return (null);
            };
            var _local_16:IRoomObjectModelController = _local_15.getModelController();
            if (_local_16 == null){
                _local_5.disposeObject(_arg_2, _arg_4);
                return (null);
            };
            var _local_17:IRoomObjectGraphicVisualization = this._visualizationFactory.createRoomObjectVisualization(_local_10);
            if (_local_17 == null){
                _local_5.disposeObject(_arg_2, _arg_4);
                return (null);
            };
            _local_17.assetCollection = _local_7;
            var _local_18:IRoomObjectVisualizationData;
            _local_18 = this._visualizationFactory.getRoomObjectVisualizationData(_local_12, _local_10, _local_8);
            if (!_local_17.initialize(_local_18)){
                _local_5.disposeObject(_arg_2, _arg_4);
                return (null);
            };
            _local_15.setVisualization(_local_17);
            var _local_19:IRoomObjectEventHandler = this._SafeStr_14544.createRoomObjectLogic(_local_11);
            _local_15.setEventHandler(_local_19);
            if (((!((_local_19 == null))) && (!((_local_9 == null))))){
                _local_19.initialize(_local_9);
            };
            return (_local_15);
        }
        public function createRoomObjectManager():IRoomObjectManager
        {
            if (this._SafeStr_14544 != null){
                return (this._SafeStr_14544.createRoomObjectManager());
            };
            return (null);
        }
        public function isContentAvailable(_arg_1:String):Boolean
        {
            if (this._SafeStr_14541 != null){
                if (this._SafeStr_14541.getGraphicAssetCollection(_arg_1) != null){
                    return (true);
                };
            };
            return (false);
        }
        private function processInitialContentLoad(_arg_1:String):void
        {
            var _local_2:int;
            if (_arg_1 == null){
                return;
            };
            if (this._state == _SafeStr_14536){
                return;
            };
            if (this._SafeStr_14541 == null){
                this._state = _SafeStr_14536;
                return;
            };
            if (this._SafeStr_14541.getGraphicAssetCollection(_arg_1) != null){
                _local_2 = this._SafeStr_14542.indexOf(_arg_1);
                if (_local_2 >= 0){
                    this._SafeStr_14542.splice(_local_2, 1);
                };
                if (this._SafeStr_14542.length == 0){
                    this._state = _SafeStr_14540;
                    if (this._messageListener != null){
                        this._messageListener.roomManagerInitialized();
                    };
                };
            }
            else {
                this._state = _SafeStr_14536;
                this._messageListener.roomManagerInitialized(false);
            };
        }
        private function onContentLoaded(_arg_1:RoomContentLoadedEvent):void
        {
            if (this._SafeStr_14541 == null){
                return;
            };
            var _local_2:String = _arg_1.contentType;
            if (_local_2 == null){
                if (this._messageListener != null){
                    this._messageListener.contentLoaded(null, false);
                };
                return;
            };
            if (this._SafeStr_14546.indexOf(_local_2) < 0){
                this._SafeStr_14546.push(_local_2);
            };
        }
        private function processLoadedContentTypes():void
        {
            var _local_2:String;
            var _local_3:XML;
            var _local_4:IGraphicAssetCollection;
            var _local_5:int;
            if (this._SafeStr_14547){
                this._SafeStr_14547 = false;
                return;
            };
            var _local_1:int = getTimer();
            while (this._SafeStr_14546.length > 0) {
                _local_2 = this._SafeStr_14546[0];
                this._SafeStr_14546.splice(0, 1);
                _local_3 = this._SafeStr_14541.getVisualizationXML(_local_2);
                if (_local_3 == null){
                    if (this._messageListener != null){
                        this._messageListener.contentLoaded(_local_2, false);
                    };
                    return;
                };
                _local_4 = this._SafeStr_14541.getGraphicAssetCollection(_local_2);
                if (_local_4 == null){
                    if (this._messageListener != null){
                        this._messageListener.contentLoaded(_local_2, false);
                    };
                    return;
                };
                this.updateObjectContents(_local_2);
                if (this._messageListener != null){
                    this._messageListener.contentLoaded(_local_2, true);
                };
                if (this._SafeStr_14542.length > 0){
                    this.processInitialContentLoad(_local_2);
                };
                _local_5 = getTimer();
                if (((((_local_5 - _local_1) >= CONTENT_PROCESSING_TIME_LIMIT_MILLISECONDS)) && (this._limitContentProcessing))){
                    this._SafeStr_14547 = true;
                    return;
                };
            };
        }
        private function updateObjectContents(_arg_1:String):void
        {
            var _local_9:RoomInstance;
            var _local_10:String;
            var _local_11:Array;
            var _local_12:int;
            var _local_13:int;
            var _local_14:int;
            var _local_15:IRoomObjectController;
            var _local_16:IRoomObjectGraphicVisualization;
            var _local_17:IRoomObjectEventHandler;
            if (_arg_1 == null){
                return;
            };
            if ((((this._SafeStr_14541 == null)) || ((this._visualizationFactory == null)))){
                return;
            };
            var _local_2:XML = this._SafeStr_14541.getVisualizationXML(_arg_1);
            var _local_3:XML = this._SafeStr_14541.getLogicXML(_arg_1);
            var _local_4:IGraphicAssetCollection = this._SafeStr_14541.getGraphicAssetCollection(_arg_1);
            if ((((_local_2 == null)) || ((_local_4 == null)))){
                return;
            };
            var _local_5:String = this._SafeStr_14541.getVisualizationType(_arg_1);
            var _local_6:String = this._SafeStr_14541.getLogicType(_arg_1);
            var _local_7:IRoomObjectVisualizationData = this._visualizationFactory.getRoomObjectVisualizationData(_arg_1, _local_5, _local_2);
            var _local_8:int = (this._rooms.length - 1);
            while (_local_8 >= 0) {
                _local_9 = (this._rooms.getWithIndex(_local_8) as RoomInstance);
                _local_10 = this._rooms.getKey(_local_8);
                if (_local_9 != null){
                    _local_11 = _local_9.getObjectManagerIds();
                    for each (_local_12 in _local_11) {
                        _local_13 = _local_9.getObjectCountForType(_arg_1, _local_12);
                        _local_14 = (_local_13 - 1);
                        while (_local_14 >= 0) {
                            _local_15 = (_local_9.getObjectWithIndexAndType(_local_14, _arg_1, _local_12) as IRoomObjectController);
                            if (_local_15 != null){
                                _local_16 = this._visualizationFactory.createRoomObjectVisualization(_local_5);
                                if (_local_16 != null){
                                    _local_16.assetCollection = _local_4;
                                    if (!_local_16.initialize(_local_7)){
                                        _local_9.disposeObject(_local_15.getId(), _local_12);
                                    }
                                    else {
                                        _local_15.setVisualization(_local_16);
                                        _local_17 = this._SafeStr_14544.createRoomObjectLogic(_local_6);
                                        _local_15.setEventHandler(_local_17);
                                        if (_local_17 != null){
                                            _local_17.initialize(_local_3);
                                        };
                                        if (this._messageListener != null){
                                            this._messageListener.objectInitialized(_local_10, _local_15.getId(), _local_12);
                                        };
                                    };
                                }
                                else {
                                    _local_9.disposeObject(_local_15.getId(), _local_12);
                                };
                            };
                            _local_14--;
                        };
                    };
                };
                _local_8--;
            };
        }
        public function update(_arg_1:uint):void
        {
            var _local_3:RoomInstance;
            this.processLoadedContentTypes();
            var _local_2:int = (this._rooms.length - 1);
            while (_local_2 >= 0) {
                _local_3 = (this._rooms.getWithIndex(_local_2) as RoomInstance);
                if (_local_3 != null){
                    _local_3.update();
                };
                _local_2--;
            };
        }

    }
}//package com.sulake.room

// IID = "_-3KV" (String#7712, DoABC#2)
// IRoomManagerListener = "_-2KC" (String#6449, DoABC#2)
// createRoomObjectVisualization = "_-0ao" (String#4319, DoABC#2)
// getRoomObjectVisualizationData = "_-1Qq" (String#5368, DoABC#2)
// _visualizationFactory = "_-fh" (String#2154, DoABC#2)
// getPlaceHolderType = "_-0dn" (String#4388, DoABC#2)
// hasInternalContent = "_-21J" (String#6071, DoABC#2)
// loadObjectContent = "_-1ZT" (String#5553, DoABC#2)
// onContentLoaded = "_-0mw" (String#4565, DoABC#2)
// getVisualizationType = "_-1HN" (String#5197, DoABC#2)
// getGraphicAssetCollection = "_-0bl" (String#4341, DoABC#2)
// getVisualizationXML = "_-Np" (String#8161, DoABC#2)
// getLogicType = "_-3CB" (String#7555, DoABC#2)
// getLogicXML = "_-3P" (String#7733, DoABC#2)
// disposeRoom = "_-2ya" (String#904, DoABC#2)
// getRoom = "_-1jg" (String#1750, DoABC#2)
// getRoomCount = "_-1cQ" (String#5608, DoABC#2)
// getRoomWithIndex = "_-0lP" (String#4533, DoABC#2)
// addObjectUpdateCategory = "_-2A6" (String#6251, DoABC#2)
// setContentLoader = "_-2Q-" (String#6563, DoABC#2)
// roomManagerInitialized = "_-1lC" (String#5771, DoABC#2)
// createRoom = "_-1mK" (String#1756, DoABC#2)
// createRoomObject = "_-20d" (String#1799, DoABC#2)
// disposeObject = "_-3E-" (String#921, DoABC#2)
// IRoomObjectController = "_-17p" (String#5034, DoABC#2)
// isContentAvailable = "_-0ic" (String#4474, DoABC#2)
// contentLoaded = "_-3K1" (String#7703, DoABC#2)
// objectInitialized = "_-ih" (String#8571, DoABC#2)
// createRoomObjectLogic = "_-0ly" (String#4548, DoABC#2)
// createRoomObjectManager = "_-1Ry" (String#1688, DoABC#2)
// getObjectCountForType = "_-2T0" (String#1882, DoABC#2)
// getObjectWithIndexAndType = "_-2OS" (String#1870, DoABC#2)
// removeObjectUpdateCategory = "_-0Cw" (String#3806, DoABC#2)
// createObjectInternal = "_-00P" (String#14070, DoABC#2)
// getObjectManagerIds = "_-2-B" (String#18977, DoABC#2)
// _SafeStr_14536 = "_-KI" (String#23017, DoABC#2)
// _SafeStr_14537 = "_-2DR" (String#19545, DoABC#2)
// _SafeStr_14538 = "_-11A" (String#16505, DoABC#2)
// _SafeStr_14539 = "_-2c6" (String#20527, DoABC#2)
// _SafeStr_14540 = "_-0fX" (String#15652, DoABC#2)
// _SafeStr_14541 = "_-0xQ" (String#16329, DoABC#2)
// _SafeStr_14542 = "_-15J" (String#16665, DoABC#2)
// _SafeStr_14543 = "_-236" (String#19138, DoABC#2)
// _SafeStr_14544 = "_-2gv" (String#20726, DoABC#2)
// _SafeStr_14545 = "_-10y" (String#16497, DoABC#2)
// _SafeStr_14546 = "_-2KJ" (String#19816, DoABC#2)
// _SafeStr_14547 = "_-0kb" (String#15852, DoABC#2)
// _limitContentProcessing = "_-Ao" (String#22648, DoABC#2)
// objectFactoryReady = "_-043" (String#14204, DoABC#2)
// visualizationFactoryReady = "_-1tr" (String#18712, DoABC#2)
// limitContentProcessing = "_-FW" (String#22832, DoABC#2)
// continueInitializing = "_-1jS" (String#18263, DoABC#2)
// processInitialContentLoad = "_-pg" (String#24260, DoABC#2)
// processLoadedContentTypes = "_-1Vl" (String#17732, DoABC#2)
// updateObjectContents = "_-1os" (String#18493, DoABC#2)
// IRoomObjectManager = "_-iT" (String#8568, DoABC#2)
// IRoomObjectEventHandler = "_-2c8" (String#6797, DoABC#2)
// IRoomInstance = "_-1j8" (String#5739, DoABC#2)
// IRoomContentLoader = "_-6z" (String#7806, DoABC#2)
// IRoomObjectVisualizationData = "_-26A" (String#6167, DoABC#2)
// IRoomObjectGraphicVisualization = "_-rv" (String#8734, DoABC#2)
// RoomManagerException = "_-3AD" (String#21890, DoABC#2)
// RoomContentLoadedEvent = "_-0sn" (String#16153, DoABC#2)
// IRoomObjectModelController = "_-1yp" (String#6010, DoABC#2)
// RoomInstance = "_-OJ" (String#8170, DoABC#2)
// IGraphicAssetCollection = "_-24o" (String#6134, DoABC#2)
// IRoomObjectFactory = "_-2Bh" (String#6281, DoABC#2)
// _messageListener = "_-16t" (String#833, DoABC#2)
// _rooms = "_-36o" (String#456, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// IRoomManager = "_-2kG" (String#6961, DoABC#2)
// RCLE_SUCCESS = "_-2gW" (String#20711, DoABC#2)
// RCLE_FAILURE = "_-2Qp" (String#20081, DoABC#2)
// RCLE_CANCEL = "_-OH" (String#23179, DoABC#2)
// contentType = "_-1bf" (String#17960, DoABC#2)
// _moveUpdateInterval = "_-1LT" (String#1665, DoABC#2)
// IRoomObjectVisualizationFactory = "_-T7" (String#8269, DoABC#2)
// setEventHandler = "_-2X9" (String#6703, DoABC#2)


