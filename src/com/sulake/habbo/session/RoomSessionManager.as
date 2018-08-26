
package com.sulake.habbo.session
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.tracking.IHabboTracking;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboTracking;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.session.handler.RoomSessionHandler;
    import com.sulake.habbo.session.handler.RoomChatHandler;
    import com.sulake.habbo.session.handler.RoomUsersHandler;
    import com.sulake.habbo.session.handler.RoomPermissionsHandler;
    import com.sulake.habbo.session.handler.AvatarEffectsHandler;
    import com.sulake.habbo.session.handler.RoomDataHandler;
    import com.sulake.habbo.session.handler.PresentHandler;
    import com.sulake.habbo.session.handler.PlaceObjectErrorHandler;
    import com.sulake.habbo.session.handler.TeleportErrorHandler;
    import com.sulake.habbo.session.handler.GenericErrorHandler;
    import com.sulake.habbo.session.handler.PollHandler;
    import com.sulake.habbo.session.handler.VoteHandler;
    import com.sulake.habbo.session.handler.LidoHandler;
    import com.sulake.habbo.session.handler.RoomDimmerPresetsHandler;
    import com.sulake.habbo.session.handler.ViralFurniHandler;
    import com.sulake.habbo.session.handler.UserNotificationHandler;
    import com.sulake.habbo.session.handler.PetPackageHandler;
    import com.sulake.habbo.session.events.RoomSessionEvent;
    import com.sulake.habbo.session.handler.BaseHandler;
    import com.sulake.iid.*;

    public class RoomSessionManager extends Component implements IRoomSessionManager, IRoomHandlerListener 
    {

        private var _communication:IHabboCommunicationManager = null;
        private var _connection:IConnection = null;
        private var _SafeStr_13661:Array = null;
        private var _initialized:Boolean = false;
        private var _SafeStr_13662:Boolean = false;
        private var _SafeStr_13663:Map = null;
        private var _SafeStr_13664:Boolean = false;
        private var _SafeStr_13665:Boolean = false;
        private var _SafeStr_13666:int = 0;
        private var _SafeStr_13667:String = "";
        private var _SafeStr_13668:Boolean = false;
        private var _habboTracking:IHabboTracking;

        public function RoomSessionManager(_arg_1:IContext, _arg_2:uint=0)
        {
            super(_arg_1, _arg_2);
            this._SafeStr_13661 = [];
            this._SafeStr_13663 = new Map();
            queueInterface(new IIDHabboCommunicationManager(), this.RoomSessionManager);
            queueInterface(new IIDHabboTracking(), this.trackingReady);
        }
        public function set roomEngineReady(_arg_1:Boolean):void
        {
            this._SafeStr_13662 = _arg_1;
            this.RoomSessionManager();
        }
        public function get initialized():Boolean
        {
            if (((this._initialized) && (this._SafeStr_13662))){
                return (true);
            };
            return (false);
        }
        public function get sessionStarting():Boolean
        {
            return (this._SafeStr_13668);
        }
        override public function dispose():void
        {
            var _local_1:String;
            var _local_2:RoomSession;
            var _local_3:int;
            var _local_4:IDisposable;
            super.dispose();
            if (this._communication != null){
                this._communication.release(new IIDHabboCommunicationManager());
                this._communication = null;
            };
            if (this._habboTracking != null){
                this._habboTracking.release(new IIDHabboTracking());
                this._habboTracking = null;
            };
            this._connection = null;
            if (this._SafeStr_13663){
                while (this._SafeStr_13663.length > 0) {
                    _local_1 = (this._SafeStr_13663.getKey(0) as String);
                    _local_2 = (this._SafeStr_13663.remove(_local_1) as RoomSession);
                    if (_local_2 != null){
                        _local_2.dispose();
                    };
                };
                this._SafeStr_13663.dispose();
                this._SafeStr_13663 = null;
            };
            if (this._SafeStr_13661){
                _local_3 = 0;
                while (_local_3 < this._SafeStr_13661.length) {
                    _local_4 = (this._SafeStr_13661[_local_3] as IDisposable);
                    if (_local_4){
                        _local_4.dispose();
                    };
                    _local_3++;
                };
                this._SafeStr_13661 = null;
            };
        }
        private function RoomSessionManager(_arg_1:IID=null, _arg_2:IUnknown=null):void
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
        }
        private function trackingReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._habboTracking = (_arg_2 as IHabboTracking);
        }
        private function onConnectionReady(_arg_1:IConnection):void
        {
            if (disposed){
                return;
            };
            if (_arg_1 != null){
                this._connection = _arg_1;
                this.RoomSessionManager();
                this.RoomSessionManager();
            };
        }
        private function RoomSessionManager():void
        {
            if (this._connection == null){
                return;
            };
            this._SafeStr_13661.push(new RoomSessionHandler(this._connection, this));
            this._SafeStr_13661.push(new RoomChatHandler(this._connection, this));
            this._SafeStr_13661.push(new RoomUsersHandler(this._connection, this));
            this._SafeStr_13661.push(new RoomPermissionsHandler(this._connection, this));
            this._SafeStr_13661.push(new AvatarEffectsHandler(this._connection, this));
            this._SafeStr_13661.push(new RoomDataHandler(this._connection, this));
            this._SafeStr_13661.push(new PresentHandler(this._connection, this));
            this._SafeStr_13661.push(new PlaceObjectErrorHandler(this._connection, this));
            this._SafeStr_13661.push(new TeleportErrorHandler(this._connection, this));
            this._SafeStr_13661.push(new GenericErrorHandler(this._connection, this));
            this._SafeStr_13661.push(new PollHandler(this._connection, this));
            this._SafeStr_13661.push(new VoteHandler(this._connection, this));
            this._SafeStr_13661.push(new LidoHandler(this._connection, this));
            this._SafeStr_13661.push(new RoomDimmerPresetsHandler(this._connection, this));
            this._SafeStr_13661.push(new ViralFurniHandler(this._connection, this));
            this._SafeStr_13661.push(new UserNotificationHandler(this._connection, this));
            this._SafeStr_13661.push(new PetPackageHandler(this._connection, this));
        }
        private function RoomSessionManager():void
        {
            if (this._communication != null){
                this._initialized = true;
            };
            if (((this.initialized) && (this._SafeStr_13664))){
                this.RoomSessionManager(this._SafeStr_13665, this._SafeStr_13666, this._SafeStr_13667);
                this._SafeStr_13664 = false;
                this._SafeStr_13667 = "";
            };
        }
        public function RoomSessionManager(_arg_1:Boolean, _arg_2:int, _arg_3:String="", _arg_4:String=""):Boolean
        {
            if (!this.initialized){
                this._SafeStr_13664 = true;
                this._SafeStr_13665 = _arg_1;
                this._SafeStr_13666 = _arg_2;
                this._SafeStr_13667 = _arg_3;
                return (false);
            };
            var _local_5:int;
            if (_arg_1){
                _local_5 = 1;
            };
            var _local_6:String = this.getRoomIdentifier(_arg_2, _local_5);
            this._SafeStr_13668 = true;
            if (this._SafeStr_13663.getValue(_local_6) != null){
                this.RoomSessionManager(_arg_2, _local_5);
            };
            var _local_7:RoomSession = new RoomSession(_arg_2, _local_5, this._habboTracking, _arg_3, _arg_4);
            _local_7.connection = this._connection;
            this._SafeStr_13663.add(_local_6, _local_7);
            events.dispatchEvent(new RoomSessionEvent(RoomSessionEvent.RSE_CREATED, _local_7));
            return (true);
        }
        public function RoomSessionManager(_arg_1:IRoomSession):Boolean
        {
            if (_arg_1.state == RoomSessionEvent.RSE_STARTED){
                return (false);
            };
            if (_arg_1.start()){
                this._SafeStr_13668 = false;
                events.dispatchEvent(new RoomSessionEvent(RoomSessionEvent.RSE_STARTED, _arg_1));
                this.RoomSessionManager(_arg_1);
            }
            else {
                this.RoomSessionManager(_arg_1.roomId, _arg_1.roomCategory);
                this._SafeStr_13668 = false;
                return (false);
            };
            return (true);
        }
        public function sessionUpdate(_arg_1:int, _arg_2:int, _arg_3:String):void
        {
            var _local_4:IRoomSession = this.getSession(_arg_1, _arg_2);
            if (_local_4 != null){
                switch (_arg_3){
                    case RoomSessionHandler.RS_CONNECTED:
                        return;
                    case RoomSessionHandler.RS_READY:
                        return;
                    case RoomSessionHandler.RS_DISCONNECTED:
                        this.RoomSessionManager(_arg_1, _arg_2);
                        return;
                };
            };
        }
        public function sessionReinitialize(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
            var _local_7:RoomSession;
            var _local_5:String = this.getRoomIdentifier(_arg_1, _arg_2);
            var _local_6:RoomSession = (this._SafeStr_13663.remove(_local_5) as RoomSession);
            if (_local_6 != null){
                _arg_4 = _arg_2;
                _local_6.reset(_arg_3, _arg_4);
                _local_5 = this.getRoomIdentifier(_arg_3, _arg_4);
                _local_7 = this._SafeStr_13663.remove(_local_5);
                if (_local_7 != null){
                };
                this._SafeStr_13663.add(_local_5, _local_6);
                this.RoomSessionManager(_local_6);
            };
        }
        public function getSession(_arg_1:int, _arg_2:int):IRoomSession
        {
            var _local_3:String = this.getRoomIdentifier(_arg_1, _arg_2);
            return ((this._SafeStr_13663.getValue(_local_3) as IRoomSession));
        }
        public function RoomSessionManager(_arg_1:int, _arg_2:int):void
        {
            var _local_3:String = this.getRoomIdentifier(_arg_1, _arg_2);
            var _local_4:RoomSession = (this._SafeStr_13663.remove(_local_3) as RoomSession);
            if (_local_4 != null){
                events.dispatchEvent(new RoomSessionEvent(RoomSessionEvent.RSE_ENDED, _local_4));
                _local_4.dispose();
            };
        }
        private function RoomSessionManager(_arg_1:IRoomSession):void
        {
            var _local_2:int;
            var _local_3:BaseHandler;
            if (((!((_arg_1 == null))) && (!((this._SafeStr_13661 == null))))){
                _local_2 = 0;
                while (_local_2 < this._SafeStr_13661.length) {
                    _local_3 = (this._SafeStr_13661[_local_2] as BaseHandler);
                    if (_local_3 != null){
                        _local_3._xxxRoomId = _arg_1.roomId;
                        _local_3._SafeStr_6312 = _arg_1.roomCategory;
                    };
                    _local_2++;
                };
            };
        }
        private function getRoomIdentifier(_arg_1:int, _arg_2:int):String
        {
            return ("hard_coded_room_id");
        }

    }
}//package com.sulake.habbo.session

// IID = "_-3KV" (String#7712, DoABC#2)
// sessionStarting = "_-0Wy" (String#4247, DoABC#2)
// RoomSessionManager = "_-Fa" (String#7986, DoABC#2)
// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// BaseHandler = "_-1Mx" (String#5291, DoABC#2)
// VoteHandler = "_-gx" (String#8534, DoABC#2)
// RoomChatHandler = "_-9B" (String#7846, DoABC#2)
// RoomDimmerPresetsHandler = "_-060" (String#3686, DoABC#2)
// ViralFurniHandler = "_-0rV" (String#4676, DoABC#2)
// TeleportErrorHandler = "_-1iD" (String#5714, DoABC#2)
// PetPackageHandler = "_-2GG" (String#6371, DoABC#2)
// RoomUsersHandler = "_-328" (String#7348, DoABC#2)
// RoomSession = "_-2wJ" (String#7207, DoABC#2)
// PollHandler = "_-2G9" (String#6369, DoABC#2)
// RoomPermissionsHandler = "_-1E9" (String#5143, DoABC#2)
// LidoHandler = "_-23B" (String#6108, DoABC#2)
// UserNotificationHandler = "_-0pD" (String#4617, DoABC#2)
// PresentHandler = "_-2vt" (String#7198, DoABC#2)
// RoomSessionHandler = "_-243" (String#6124, DoABC#2)
// RoomDataHandler = "_-1Q9" (String#5355, DoABC#2)
// GenericErrorHandler = "_-05Z" (String#3676, DoABC#2)
// PlaceObjectErrorHandler = "_-0nG" (String#4576, DoABC#2)
// IRoomHandlerListener = "_-3Fo" (String#7627, DoABC#2)
// getRoomIdentifier = "_-0yJ" (String#1587, DoABC#2)
// roomEngineReady = "_-0Qo" (String#4107, DoABC#2)
// RoomSessionManager = "_-j1" (String#8577, DoABC#2)
// _SafeStr_13661 = "_-1FZ" (String#17097, DoABC#2)
// _SafeStr_13662 = "_-no" (String#24183, DoABC#2)
// _SafeStr_13663 = "_-1Lb" (String#17339, DoABC#2)
// _SafeStr_13664 = "_-1QJ" (String#17524, DoABC#2)
// _SafeStr_13665 = "_-0vU" (String#16256, DoABC#2)
// _SafeStr_13666 = "_-363" (String#21730, DoABC#2)
// _SafeStr_13667 = "_-PB" (String#23214, DoABC#2)
// _SafeStr_13668 = "false" (String#82, DoABC#2)
// RoomSessionManager = "_-2Jf" (String#19797, DoABC#2)
// RoomSessionManager = "_-8w" (String#22577, DoABC#2)
// RoomSessionManager = "_-06E" (String#14294, DoABC#2)
// RoomSessionManager = "_-2cO" (String#20540, DoABC#2)
// RoomSessionManager = "_-0rg" (String#16109, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// HabboCommunicationManager = "_-0AQ" (String#809, DoABC#2)
// RSE_CREATED = "_-1XM" (String#17790, DoABC#2)
// RSE_STARTED = "_-oj" (String#24224, DoABC#2)
// RSE_ENDED = "_-ar" (String#23665, DoABC#2)
// _initialized = "_-0EY" (String#214, DoABC#2)
// IHabboTracking = "_-0fl" (String#4419, DoABC#2)
// _SafeStr_6312 = "_-2JJ" (String#19781, DoABC#2)
// RS_CONNECTED = "_-2VD" (String#20249, DoABC#2)
// RS_READY = "_-2uu" (String#21274, DoABC#2)
// RS_DISCONNECTED = "_-2nj" (String#20988, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// initialized = "_-2r9" (String#21124, DoABC#2)
// onConnectionReady = "_-0k8" (String#359, DoABC#2)


