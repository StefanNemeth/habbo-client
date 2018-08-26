
package com.sulake.habbo.roomevents
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDRoomEngine;
    import com.sulake.iid.IIDHabboRoomSessionManager;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.room.IRoomEngineServices;
    import com.sulake.habbo.room.ISelectedRoomObjectData;
    import com.sulake.habbo.communication.enum.HabboProtocolOption;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.session.events.RoomSessionEvent;

    public class HabboUserDefinedRoomEvents extends Component implements IHabboUserDefinedRoomEvents 
    {

        private var _windowManager:IHabboWindowManager;
        private var _communication:IHabboCommunicationManager;
        private var _localization:IHabboLocalizationManager;
        private var _configuration:IHabboConfigurationManager;
        private var _userDefinedRoomEventsCtrl:UserDefinedRoomEventsCtrl;
        private var _SafeStr_11492:IncomingMessages;
        private var _roomEngine:IRoomEngine;
        private var _roomSession:IRoomSession;
        private var _roomSessionManager:IRoomSessionManager;
        private var _sessionDataManager:ISessionDataManager;
        private var _userName:String;

        public function HabboUserDefinedRoomEvents(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            Logger.log(("UDE initialized: " + _arg_3));
            this._userDefinedRoomEventsCtrl = new UserDefinedRoomEventsCtrl(this);
            queueInterface(new IIDHabboCommunicationManager(), this.HabboUserDefinedRoomEvents);
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
            queueInterface(new IIDHabboLocalizationManager(), this.onLocalizationReady);
            queueInterface(new IIDRoomEngine(), this.onRoomEngineReady);
            queueInterface(new IIDHabboRoomSessionManager(), this.onRoomSessionManagerReady);
            queueInterface(new IIDSessionDataManager(), this.onSessionDataManagerReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationReady);
        }
        public function get communication():IHabboCommunicationManager
        {
            return (this._communication);
        }
        public function get windowManager():IHabboWindowManager
        {
            return (this._windowManager);
        }
        public function get localization():IHabboLocalizationManager
        {
            return (this._localization);
        }
        public function get configuration():IHabboConfigurationManager
        {
            return (this._configuration);
        }
        override public function dispose():void
        {
            if (this._communication){
                this._communication.release(new IIDHabboCommunicationManager());
                this._communication = null;
            };
            if (this._windowManager){
                this._windowManager.release(new IIDHabboWindowManager());
                this._windowManager = null;
            };
            super.dispose();
        }
        public function stuffSelected(_arg_1:int, _arg_2:String):void
        {
            var _local_3:ISelectedRoomObjectData = (this._roomEngine as IRoomEngineServices).RoomEngine(this.roomId, this.roomCategory);
            if (((_local_3) && ((_local_3.id == -(_arg_1))))){
                (this._roomEngine as IRoomEngineServices).RoomEngine(this.roomId, this.roomCategory, null);
                return;
            };
            this._userDefinedRoomEventsCtrl.stuffSelected(_arg_1, _arg_2);
        }
        public function send(_arg_1:IMessageComposer, _arg_2:Boolean=false):void
        {
            this._communication.HabboCommunicationManager(null).send(_arg_1, ((_arg_2) ? HabboProtocolOption.OLD_STYLE : -1));
        }
        public function getXmlWindow(name:String):IWindow
        {
            var asset:IAsset;
            var xmlAsset:XmlAsset;
            var window:IWindow;
            try {
                asset = assets.getAssetByName((name + "_xml"));
                xmlAsset = XmlAsset(asset);
                window = this._windowManager.buildFromXML(XML(xmlAsset.content));
            }
            catch(e:Error) {
            };
            return (window);
        }
        public function refreshButton(_arg_1:IWindowContainer, _arg_2:String, _arg_3:Boolean, _arg_4:Function, _arg_5:int, _arg_6:String=null):void
        {
            if (!_arg_6){
                _arg_6 = _arg_2;
            };
            var _local_7:IBitmapWrapperWindow = (_arg_1.findChildByName(_arg_2) as IBitmapWrapperWindow);
            if (!_arg_3){
                _local_7.visible = false;
            }
            else {
                this.HabboUserDefinedRoomEvents(_local_7, _arg_6, _arg_4, _arg_5);
                _local_7.visible = true;
            };
        }
        private function HabboUserDefinedRoomEvents(_arg_1:IBitmapWrapperWindow, _arg_2:String, _arg_3:Function, _arg_4:int):void
        {
            _arg_1.id = _arg_4;
            _arg_1.procedure = _arg_3;
            if (_arg_1.bitmap != null){
                return;
            };
            _arg_1.bitmap = this.getButtonImage(_arg_2);
            _arg_1.width = _arg_1.bitmap.width;
            _arg_1.height = _arg_1.bitmap.height;
        }
        public function getButtonImage(_arg_1:String, _arg_2:String="_png"):BitmapData
        {
            var _local_3:String = (_arg_1 + _arg_2);
            var _local_4:IAsset = assets.getAssetByName(_local_3);
            var _local_5:BitmapDataAsset = BitmapDataAsset(_local_4);
            var _local_6:BitmapData = BitmapData(_local_5.content);
            return (_local_6.clone());
        }
        private function HabboUserDefinedRoomEvents(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._communication = IHabboCommunicationManager(_arg_2);
            this._SafeStr_11492 = new IncomingMessages(this);
        }
        private function onWindowManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._windowManager = IHabboWindowManager(_arg_2);
        }
        private function onLocalizationReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._localization = IHabboLocalizationManager(_arg_2);
        }
        public function get userDefinedRoomEventsCtrl():UserDefinedRoomEventsCtrl
        {
            return (this._userDefinedRoomEventsCtrl);
        }
        private function onRoomEngineReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._roomEngine = IRoomEngine(_arg_2);
        }
        public function get roomEngine():IRoomEngine
        {
            return (this._roomEngine);
        }
        private function onConfigurationReady(_arg_1:IID, _arg_2:IUnknown):void
        {
            if (_arg_2 == null){
                return;
            };
            this._configuration = (_arg_2 as IHabboConfigurationManager);
        }
        private function onRoomSessionManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._roomSessionManager = (_arg_2 as IRoomSessionManager);
            this.registerSessionEvents();
        }
        private function onSessionDataManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._sessionDataManager = (_arg_2 as ISessionDataManager);
        }
        private function registerSessionEvents():void
        {
            if (this._roomSessionManager){
                this._roomSessionManager.events.addEventListener(RoomSessionEvent.RSE_CREATED, this.roomSessionStateEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionEvent.RSE_STARTED, this.roomSessionStateEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionEvent.RSE_ENDED, this.roomSessionStateEventHandler);
            };
        }
        private function roomSessionStateEventHandler(_arg_1:RoomSessionEvent):void
        {
            if (this._roomEngine == null){
                return;
            };
            switch (_arg_1.type){
                case RoomSessionEvent.RSE_CREATED:
                case RoomSessionEvent.RSE_STARTED:
                case RoomSessionEvent.RSE_ENDED:
                    this._roomSession = _arg_1.session;
                    return;
            };
        }
        public function get roomId():int
        {
            return (((this._roomSession) ? this._roomSession.roomId : 0));
        }
        public function get roomCategory():int
        {
            return (((this._roomSession) ? this._roomSession.roomCategory : 0));
        }
        public function get userName():String
        {
            return (this._userName);
        }
        public function set userName(_arg_1:String):void
        {
            this._userName = _arg_1;
        }
        public function get sessionDataManager():ISessionDataManager
        {
            return (this._sessionDataManager);
        }

    }
}//package com.sulake.habbo.roomevents

// IID = "_-3KV" (String#7712, DoABC#2)
// onSessionDataManagerReady = "_-0C-" (String#240, DoABC#2)
// _roomSessionManager = "_-2nJ" (String#249, DoABC#2)
// _roomSession = "_-2CB" (String#1832, DoABC#2)
// ISessionDataManager = "_-Bk" (String#7907, DoABC#2)
// HabboUserDefinedRoomEvents = "_-1hF" (String#443, DoABC#2)
// IRoomEngineServices = "_-28G" (String#6208, DoABC#2)
// HabboUserDefinedRoomEvents = "_-08W" (String#807, DoABC#2)
// _SafeStr_11492 = "_-0aZ" (String#589, DoABC#2)
// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// RoomEngine = "_-2bg" (String#6788, DoABC#2)
// RoomEngine = "_-0vv" (String#4766, DoABC#2)
// IncomingMessages = "_-2Xb" (String#216, DoABC#2)
// ISelectedRoomObjectData = "_-J6" (String#8063, DoABC#2)
// HabboProtocolOption = "_-9Z" (String#7855, DoABC#2)
// userDefinedRoomEventsCtrl = "_-1JG" (String#17247, DoABC#2)
// _userDefinedRoomEventsCtrl = "_-1Ya" (String#17834, DoABC#2)
// registerSessionEvents = "_-0mt" (String#4564, DoABC#2)
// communication = "_-3HD" (String#22171, DoABC#2)
// HabboCommunicationManager = "_-0AQ" (String#809, DoABC#2)
// RSE_CREATED = "_-1XM" (String#17790, DoABC#2)
// RSE_STARTED = "_-oj" (String#24224, DoABC#2)
// RSE_ENDED = "_-ar" (String#23665, DoABC#2)
// sessionDataManager = "_-0pX" (String#4623, DoABC#2)
// IHabboUserDefinedRoomEvents = "_-2Ae" (String#6258, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// stuffSelected = "_-0oj" (String#4608, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// onWindowManagerReady = "_-34x" (String#94, DoABC#2)
// onLocalizationReady = "_-uK" (String#167, DoABC#2)
// _sessionDataManager = "_-0kq" (String#149, DoABC#2)
// onConfigurationReady = "_-x5" (String#190, DoABC#2)


