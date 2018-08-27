
package com.sulake.habbo.communication.demo
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.communication.ICoreCommunicationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.core.communication.handshake.IKeyExchange;
    import com.sulake.habbo.communication.encryption.PseudoRandom;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboRoomSessionManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.utils.ByteArray;
    import flash.geom.Point;
    import com.sulake.habbo.communication.enum.HabboConnectionType;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.session.events.RoomSessionEvent;
    import com.sulake.core.communication.connection.IConnection;
    import flash.events.Event;
    import com.sulake.habbo.communication.messages.incoming.handshake.InitCryptoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.SecretKeyEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.SessionParamsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.AuthenticationOKMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.PingMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.error.ErrorReportEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.GenericErrorEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.DisconnectReasonEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UniqueMachineIDEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.IdentityAccountsEvent;
    import flash.external.ExternalInterface;
    import com.sulake.core.Core;
    import com.sulake.habbo.communication.enum.HabboCommunicationEvent;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.handshake.InitCryptoMessageComposer;
    import com.sulake.habbo.communication.encryption.DiffieHellman;
    import com.hurlant.math.BigInteger;
    import com.sulake.habbo.communication.messages.outgoing.handshake.GenerateSecretKeyMessageComposer;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.encryption.RC4_R27;
    import com.sulake.core.communication.encryption.IEncryption;
    import com.sulake.core.communication.encryption.CryptoTools;
    import flash.net.SharedObject;
    import com.sulake.habbo.communication.messages.outgoing.handshake.VersionCheckMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.handshake.UniqueIDMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.handshake.GetSessionParametersMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.handshake.SSOTicketMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.handshake.TryLoginMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.handshake.InfoRetrieveMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.habbo.communication.messages.parser.handshake.GenericErrorParser;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.handshake.PongMessageComposer;
    import com.sulake.habbo.communication.messages.parser.error.ErrorReportMessageParser;
    import com.sulake.habbo.utils.HabboWebTools;
    import flash.display.BitmapData;
    import com.sulake.iid.*;
    import com.sulake.habbo.communication.messages.incoming.handshake.*;
    import com.sulake.habbo.communication.messages.outgoing.handshake.*;

    public class HabboCommunicationDemo extends Component 
    {

        private const _SafeStr_10674:String = "fuselogin";

        private var _communicationManager:ICoreCommunicationManager;
        private var _habboConfiguration:IHabboConfigurationManager;
        private var _habboCommunication:IHabboCommunicationManager;
        private var _windowManager:IHabboWindowManager;
        private var _roomSessionManager:IRoomSessionManager;
        private var _SafeStr_10715:IKeyExchange;
        private var _SafeStr_4650:String;
        private var _view:HabboLoginDemoView;
        private var _SafeStr_10716:PseudoRandom;
        private var _ssoTicket:String;
        private var _flashClientUrl:String;
        private var _SafeStr_10718:Boolean;
        private var _SafeStr_10719:Boolean;
        private var _SafeStr_10720:String;
        private var override:HabboHotelView;
        private var _token:String = "";

        public function HabboCommunicationDemo(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
            queueInterface(new IIDHabboCommunicationManager(), this.onHabboCommunication);
            queueInterface(new IIDHabboRoomSessionManager(), this.onRoomSessionManagerReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onHabboConfigurationInit);
        }
        private static function decode(_arg_1:ByteArray, _arg_2:uint, _arg_3:uint, _arg_4:Point, _arg_5:Point):String
        {
            var _local_12:int;
            var _local_13:uint;
            var _local_14:int;
            var _local_15:uint;
            var _local_16:uint;
            var _local_6:String = "";
            var _local_7:uint;
            var _local_8:uint;
            var _local_9:uint;
            var _local_10:uint;
            if (_arg_3 == 4){
                _local_10 = 1;
            };
            var _local_11:int = _arg_4.y;
            while (_local_11 < (_arg_4.y + _arg_5.y)) {
                _local_12 = _arg_4.x;
                while (_local_12 < (_arg_4.x + _arg_5.x)) {
                    _local_13 = ((((_local_11 + _local_9) * _arg_2) + _local_12) * _arg_3);
                    _local_14 = _local_10;
                    while (_local_14 < _arg_3) {
                        _arg_1.position = (_local_13 + _local_14);
                        _local_15 = _arg_1.readUnsignedByte();
                        _local_16 = (_local_15 & 1);
                        _local_8 = (_local_8 | (_local_16 << (7 - _local_7)));
                        if (_local_7 == 7){
                            _local_6 = (_local_6 + String.fromCharCode(_local_8));
                            _local_8 = 0;
                            _local_7 = 0;
                        }
                        else {
                            _local_7++;
                        };
                        _local_14++;
                    };
                    if ((_local_12 % 2) == 0){
                        _local_9++;
                    };
                    _local_12++;
                };
                _local_9 = 0;
                _local_11++;
            };
            return (_local_6);
        }
        private static function xor(_arg_1:String, _arg_2:String):String
        {
            var _local_6:uint;
            var _local_3:String = "";
            var _local_4:int;
            var _local_5:int;
            while (_local_5 < _arg_1.length) {
                _local_6 = _arg_1.charCodeAt(_local_5);
                _local_3 = (_local_3 + String.fromCharCode((_local_6 ^ _arg_2.charCodeAt(_local_4))));
                if (++_local_4 == _arg_2.length){
                    _local_4 = 0;
                };
                _local_5++;
            };
            return (_local_3);
        }

        public function get communicationManager():ICoreCommunicationManager
        {
            return (this._communicationManager);
        }
        public function get habboConfiguration():IHabboConfigurationManager
        {
            return (this._habboConfiguration);
        }
        public function get habboCommunication():IHabboCommunicationManager
        {
            return (this._habboCommunication);
        }
        public function get windowManager():IHabboWindowManager
        {
            return (this._windowManager);
        }
        public function set ssoTicket(_arg_1:String):void
        {
            this._ssoTicket = _arg_1;
        }
        public function set flashClientUrl(_arg_1:String):void
        {
            this._flashClientUrl = _arg_1;
        }
        override public function dispose():void
        {
            if (this._view != null){
                this._view.dispose();
                this._view = null;
            };
            if (this.override != null){
                this.override.dispose();
                this.override = null;
            };
        }
        public function setSSOTicket(_arg_1:String):void
        {
            if (((_arg_1) && (!(this._ssoTicket)))){
                this._ssoTicket = _arg_1;
                this._habboCommunication.initConnection(HabboConnectionType._SafeStr_6096);
            };
        }
        private function onHabboConfigurationInit(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (_arg_2 != null){
                this._habboConfiguration = (_arg_2 as IHabboConfigurationManager);
                this.checkRequirements();
            };
        }
        private function onWindowManagerReady(_arg_1:IID, _arg_2:IUnknown):void
        {
            this._windowManager = (_arg_2 as IHabboWindowManager);
            this.checkRequirements();
        }
        private function onRoomSessionManagerReady(_arg_1:IID, _arg_2:IUnknown):void
        {
            this._roomSessionManager = (_arg_2 as IRoomSessionManager);
            this._roomSessionManager.events.addEventListener(RoomSessionEvent.RSE_ENDED, this.onRoomSessionEnded);
            this.checkRequirements();
        }
        private function onHabboCommunication(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            var _local_3:IConnection;
            if (_arg_2 != null){
                this._habboCommunication = (_arg_2 as IHabboCommunicationManager);
                _local_3 = this._habboCommunication.getHabboMainConnection(null);
                if (_local_3 != null){
                    _local_3.addEventListener(Event.CONNECT, this.onConnectionEstablished);
                    _local_3.addEventListener(Event.CLOSE, this.onConnectionDisconnected);
                };
                this._habboCommunication.addHabboConnectionMessageEvent(new InitCryptoMessageEvent(this.onInitCrypto));
                this._habboCommunication.addHabboConnectionMessageEvent(new SecretKeyEvent(this.onSecretKeyEvent));
                this._habboCommunication.addHabboConnectionMessageEvent(new SessionParamsMessageEvent(this.onSessionParamsEvent));
                this._habboCommunication.addHabboConnectionMessageEvent(new AuthenticationOKMessageEvent(this.onAuthenticationOK));
                this._habboCommunication.addHabboConnectionMessageEvent(new PingMessageEvent(this.onPing));
                this._habboCommunication.addHabboConnectionMessageEvent(new ErrorReportEvent(this.onErrorReport));
                this._habboCommunication.addHabboConnectionMessageEvent(new GenericErrorEvent(this.onGenericError));
                this._habboCommunication.addHabboConnectionMessageEvent(new DisconnectReasonEvent(this.onDisconnectReason));
                this._habboCommunication.addHabboConnectionMessageEvent(new RoomEntryInfoMessageEvent(this.onRoomEntryInfoEvent));
                this._habboCommunication.addHabboConnectionMessageEvent(new UniqueMachineIDEvent(this.onUniqueMachineId));
                this._habboCommunication.addHabboConnectionMessageEvent(new IdentityAccountsEvent(this.onIdentityAccounts));
                this.checkRequirements();
            };
        }
        private function checkRequirements():void
        {
            if (((((((this._habboCommunication) && (this._habboConfiguration))) && (this._roomSessionManager))) && (this._windowManager))){
                this.componentsAreRunning();
            };
        }
        private function componentsAreRunning():void
        {
            var _local_5:Boolean;
            var _local_1:Boolean = this._habboConfiguration.getBoolean("client.hotel_view.show_on_startup", true);
            this.override = new HabboHotelView(this._windowManager, assets, Component(context).events, _local_1);
            var _local_2:String = this._habboConfiguration.getKey("client.hotel_view.image");
            var _local_3:String = this._habboConfiguration.getKey("image.library.url");
            if (((!((_local_2 == null))) && (!((_local_3 == null))))){
                this.override.loadHotelViewImage((_local_3 + _local_2));
            };
            var _local_4 = (this._habboConfiguration.getKey("use.sso.ticket") == "1");
            this._ssoTicket = this._habboConfiguration.getKey("sso.ticket", null);
            this._flashClientUrl = this._habboConfiguration.getKey("flash.client.url", "");
            this._SafeStr_10720 = this._habboConfiguration.getKey("external.variables.txt", "");
            if (this.override == null){
                this.override = new HabboHotelView(this._windowManager, assets, Component(context).events, _local_1);
            };
            if (_local_4){
                this._habboCommunication.mode = HabboConnectionType.RWREUE_NORMAL_MODE;
                if (this._ssoTicket){
                    this._habboCommunication.initConnection(HabboConnectionType._SafeStr_6096);
                }
                else {
                    if (ExternalInterface.available){
                        ExternalInterface.addCallback("setSSOTicket", this.setSSOTicket);
                        ExternalInterface.call("requestSSOTicket");
                    };
                };
            }
            else {
                if (this._windowManager != null){
                    goto _label_1;
                    this._view = new HabboLoginDemoView(this);
                    this._view.addEventListener(HabboLoginDemoView._SafeStr_10673, this.onInitConnection);
                    return;
                    
                _label_1: 
                    Core.crash("Login without an SSO ticket is not supported", Core._SafeStr_9857);
                };
            };
        }
        private function onInitConnection(_arg_1:Event=null):void
        {
            this.dispatchLoginStepEvent(HabboCommunicationEvent.INIT);
            if (this._ssoTicket != null){
                this._habboCommunication.mode = HabboConnectionType.RWREUE_NORMAL_MODE;
            }
            else {
                this._habboCommunication.mode = HabboConnectionType.RWREUE_NORMAL_MODE;
                if (this._habboConfiguration.keyExists("local.environment")){
                    this._habboCommunication.mode = HabboConnectionType._SafeStr_6098;
                };
            };
            this._habboCommunication.initConnection(HabboConnectionType._SafeStr_6096);
        }
        private function onConnectionEstablished(_arg_1:Event=null):void
        {
            var _local_3:IMessageComposer;
            var _local_2:IConnection = this._habboCommunication.getHabboMainConnection(null);
            if (_local_2 != null){
                this.dispatchLoginStepEvent(HabboCommunicationEvent.HABBO_CONNECTION_EVENT_ESTABLISHED);
                _local_3 = new InitCryptoMessageComposer(this._habboCommunication.mode);
                _local_2.send(_local_3);
            };
        }
        private function onInitCrypto(_arg_1:IMessageEvent):void
        {
            var _local_6:String;
            var _local_7:String;
            var _local_8:String;
            var _local_2:IConnection = _arg_1.connection;
            var _local_3:InitCryptoMessageEvent = (_arg_1 as InitCryptoMessageEvent);
            var _local_4:String = _local_3.token;
            var _local_5:Boolean = _local_3.isServerEncrypted;
            this._SafeStr_10716 = new PseudoRandom(parseInt(_local_4.substring((_local_4.length - 4)), 16), 65536);
            switch (this._habboCommunication.mode){
                case HabboConnectionType.RWREUE_NORMAL_MODE:
                    _local_6 = "";
                    _local_6 = this._habboConfiguration.getKey("url.prefix", _local_6);
                    _local_6 = _local_6.replace("http://", "");
                    _local_6 = _local_6.replace("https://", "");
                    _local_7 = this._habboConfiguration.getKey("hotelview.banner.url", "http:/\nsitename$/gamedata/banner");
                    _local_7 = _local_7.replace("$sitename$", _local_6);
                    this._token = _local_4;
                    this.override.loadBannerImage(((_local_7 + "?token=") + this._token), this.onHotelViewBannerLoaded);
                    return;
                case HabboConnectionType._SafeStr_6098:
                    this.sendConnectionParameters(_local_2);
                    return;
                case HabboConnectionType._SafeStr_6097:
                    this._SafeStr_4650 = this.generateRandomHexString(30);
                    this._SafeStr_10715 = new DiffieHellman(new BigInteger(this._habboConfiguration.getKey("connection.development.prime"), 16), new BigInteger(this._habboConfiguration.getKey("connection.development.generator"), 16));
                    this._SafeStr_10715.init(this._SafeStr_4650);
                    _local_8 = this._SafeStr_10715.getPublicKey(10);
                    _local_2.send(new GenerateSecretKeyMessageComposer(_local_8.toUpperCase()));
                    return;
                default:
                    Logger.log(("[HabboCommunicationDemo] Unknown Connection Mode: " + this._habboCommunication.mode));
            };
        }
        private function onSecretKeyEvent(_arg_1:IMessageEvent):void
        {
            var _local_2:IConnection = _arg_1.connection;
            var _local_3:SecretKeyEvent = (_arg_1 as SecretKeyEvent);
            var _local_4:String = _local_3.serverPublicKey;
            this._SafeStr_10715.generateSharedKey(_local_4, 10);
            var _local_5:String = this._SafeStr_10715.getSharedKey(16).toUpperCase();
            var _local_6:RC4_R27 = new RC4_R27(null, null);
            var _local_7:IEncryption = new RC4_R27(_local_6, this._SafeStr_10716);
            var _local_8:ByteArray = CryptoTools.hexStringToByteArray(_local_5);
            _local_8.position = 0;
            _local_6.init(_local_8);
            _local_8.position = 0;
            _local_7.initFromState(_local_6);
            _local_2.setEncryption(_local_7);
            this.sendConnectionParameters(_local_2);
        }
        private function sendConnectionParameters(connection:IConnection):void
        {
            var so:SharedObject;
            this._SafeStr_10718 = true;
            this.dispatchLoginStepEvent(HabboCommunicationEvent.HABBO_CONNECTION_EVENT_HANDSHAKING);
            connection.send(new VersionCheckMessageComposer(401, this._flashClientUrl, this._SafeStr_10720));
            var machineId:String = "";
            try {
                so = SharedObject.getLocal(this._SafeStr_10674, "/");
                if (so.data.machineid != null){
                    machineId = so.data.machineid;
                };
            }
            catch(e:Error) {
            };
            connection.send(new UniqueIDMessageComposer(machineId));
            connection.send(new GetSessionParametersMessageComposer());
        }
        private function onSessionParamsEvent(_arg_1:IMessageEvent):void
        {
            var _local_4:SSOTicketMessageComposer;
            var _local_5:String;
            var _local_6:String;
            this._SafeStr_10718 = false;
            var _local_2:IConnection = _arg_1.connection;
            var _local_3:SessionParamsMessageEvent = (_arg_1 as SessionParamsMessageEvent);
            if (this._ssoTicket != null){
                _local_4 = new SSOTicketMessageComposer(this._ssoTicket);
                _local_2.send(_local_4);
                this.dispatchLoginStepEvent(HabboCommunicationEvent.HABBO_CONNECTION_EVENT_HANDSHAKED);
            }
            else {
                if (this._view != null){
                    _local_5 = this._view.name;
                    _local_6 = this._view.password;
                    if ((((_local_5.length > 0)) && ((_local_6.length > 0)))){
                        this.sendTryLogin(_local_5, _local_6);
                        this.dispatchLoginStepEvent(HabboCommunicationEvent.HABBO_CONNECTION_EVENT_HANDSHAKED);
                    };
                }
                else {
                    Logger.log("[HabboCommunicationDemo] Error, no login window nor ticket");
                };
            };
        }
        public function sendTryLogin(_arg_1:String, _arg_2:String, _arg_3:int=0):void
        {
            var _local_4:IConnection = this._habboCommunication.getHabboMainConnection(null);
            var _local_5:TryLoginMessageComposer = new TryLoginMessageComposer(_arg_1, _arg_2, _arg_3);
            _local_4.send(_local_5);
        }
        private function onAuthenticationOK(_arg_1:IMessageEvent):void
        {
            var _local_2:IConnection = _arg_1.connection;
            var _local_3:AuthenticationOKMessageEvent = (_arg_1 as AuthenticationOKMessageEvent);
            Logger.log("Authentication success!");
            var _local_4:InfoRetrieveMessageComposer = new InfoRetrieveMessageComposer();
            _local_2.send(_local_4);
            var _local_5:EventLogMessageComposer = new EventLogMessageComposer("Login", "socket", "client.auth_ok");
            _local_2.send(_local_5);
            if (this._view != null){
                this._view.closeLoginWindow();
            };
            this.dispatchLoginStepEvent(HabboCommunicationEvent.HABBO_CONNECTION_EVENT_AUTHENTICATED);
        }
        private function onGenericError(event:IMessageEvent):void
        {
            var parser:GenericErrorParser = (event as GenericErrorEvent).getParser();
            switch (parser.errorCode){
                case -3:
                    this._windowManager.alert("${connection.error.id.title}", "${connection.login.error.-3.desc}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                    {
                        _arg_1.dispose();
                    });
                    return;
                case -400:
                    this._windowManager.alert("${connection.error.id.title}", "${connection.login.error.-400.desc}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                    {
                        _arg_1.dispose();
                    });
                    return;
            };
        }
        private function onPing(_arg_1:IMessageEvent):void
        {
            var _local_2:IConnection = _arg_1.connection;
            var _local_3:PingMessageEvent = (_arg_1 as PingMessageEvent);
            var _local_4:PongMessageComposer = new PongMessageComposer();
            _local_2.send(_local_4);
        }
        private function onUniqueMachineId(event:UniqueMachineIDEvent):void
        {
            var so:SharedObject;
            if (event == null){
                return;
            };
            try {
                so = SharedObject.getLocal(this._SafeStr_10674, "/");
                so.data.machineid = event.machineID;
                so.flush();
            }
            catch(e:Error) {
            };
        }
        private function onIdentityAccounts(_arg_1:IdentityAccountsEvent):void
        {
            if (!_arg_1){
                return;
            };
            if (this._view){
                this._view.populateUserList(_arg_1.getParser().accounts);
            };
        }
        private function onErrorReport(event:IMessageEvent):void
        {
            var parser:ErrorReportMessageParser = (event as ErrorReportEvent).getParser();
            var errorCode:int = parser.errorCode;
            var messageId:int = parser.messageId;
            var time:String = parser.timestamp;
            Logger.log(((("SERVER ERROR! Error code:" + errorCode) + "Message id:") + messageId));
            this._windowManager.registerLocalizationParameter("connection.server.error.desc", "errorCode", String(errorCode));
            this._windowManager.alert("${connection.server.error.title}", "${connection.server.error.desc}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
            {
                _arg_1.dispose();
            });
        }
        private function onConnectionDisconnected(_arg_1:Event):void
        {
            var _local_2:String;
            if (this._SafeStr_10718){
                this.dispatchLoginStepEvent(HabboCommunicationEvent.HABBO_CONNECTION_EVENT_HANDSHAKE_FAIL);
            };
            if ((((_arg_1.type == Event.CLOSE)) && (!(this._SafeStr_10719)))){
                _local_2 = this._habboConfiguration.getKey("logout.disconnect.url");
                _local_2 = this.setOriginProperty(_local_2);
                HabboWebTools.openWebPage(_local_2, "_self");
            };
        }
        private function onDisconnectReason(_arg_1:DisconnectReasonEvent):void
        {
            if (this._SafeStr_10718){
                this.dispatchLoginStepEvent(HabboCommunicationEvent.HABBO_CONNECTION_EVENT_HANDSHAKE_FAIL);
            };
            this._SafeStr_10719 = true;
            var _local_2:String = this._habboConfiguration.getKey("logout.url");
            if (_local_2.length > 0){
                _local_2 = this.setReasonProperty(_local_2, _arg_1.reasonString);
                _local_2 = this.setOriginProperty(_local_2);
                _local_2 = (_local_2 + ("&id=" + _arg_1.reason));
                HabboWebTools.openWebPage(_local_2, "_self");
            };
        }
        private function setReasonProperty(_arg_1:String, _arg_2:String):String
        {
            if (_arg_1.indexOf("%reason%") != -1){
                return (_arg_1.replace("%reason%", _arg_2));
            };
            return (_arg_1);
        }
        private function setOriginProperty(_arg_1:String):String
        {
            if (_arg_1.indexOf("%origin%") != -1){
                return (_arg_1.replace("%origin%", this._habboConfiguration.getKey("flash.client.origin", "popup")));
            };
            return (_arg_1);
        }
        private function onRoomEntryInfoEvent(_arg_1:RoomEntryInfoMessageEvent):void
        {
            if (this.override){
                if (!this.override.disposed){
                    this.override.hide();
                };
            };
        }
        private function onRoomSessionEnded(_arg_1:RoomSessionEvent):void
        {
            if (!this._roomSessionManager.sessionStarting){
                this.showHotelView();
            };
        }
        private function showHotelView():void
        {
            if (this.override){
                if (!this.override.disposed){
                    this.override.show();
                };
            };
        }
        private function dispatchLoginStepEvent(_arg_1:String):void
        {
            if ((((Component(context) == null)) || ((Component(context).events == null)))){
                return;
            };
            Component(context).events.dispatchEvent(new Event(_arg_1));
        }
        private function onHotelViewBannerLoaded(_arg_1:BitmapData):void
        {
            var _local_15:String;
            var _local_2:ByteArray = _arg_1.getPixels(_arg_1.rect);
            var _local_3:String = decode(_local_2, _arg_1.width, 4, new Point(4, 39), new Point(80, 30));
            var _local_4:String = xor(_local_3, this._token);
            var _local_5:uint = _local_4.charCodeAt(0);
            var _local_6:uint = _local_4.charCodeAt((_local_5 + 1));
            var _local_7:String = _local_4.substr(1, _local_5);
            var _local_8:String = _local_4.substr((_local_5 + 2), _local_6);
            var _local_9:IConnection = this._habboCommunication.getHabboMainConnection(null);
            var _local_10:BigInteger = new BigInteger();
            var _local_11:BigInteger = new BigInteger();
            var _local_12:String;
            _local_10.fromRadix(_local_7, 10);
            _local_11.fromRadix(_local_8, 10);
            this._SafeStr_10715 = new DiffieHellman(_local_10, _local_11);
            var _local_13:int = 10;
            var _local_14:String;
            while (_local_13 > 0) {
                _local_14 = this.generateRandomHexString(30);
                this._SafeStr_10715.init(_local_14);
                _local_15 = this._SafeStr_10715.getPublicKey(10);
                if (_local_15.length < 64){
                    if ((((_local_12 == null)) || ((_local_15.length > _local_12.length)))){
                        _local_12 = _local_15;
                        this._SafeStr_4650 = _local_14;
                    };
                }
                else {
                    _local_12 = _local_15;
                    this._SafeStr_4650 = _local_14;
                    break;
                };
                _local_13--;
            };
            if (_local_14 != this._SafeStr_4650){
                this._SafeStr_10715.init(this._SafeStr_4650);
            };
            _local_9.send(new GenerateSecretKeyMessageComposer(_local_12.toUpperCase()));
            this._token = "";
        }
        private function generateRandomHexString(_arg_1:uint=16):String
        {
            var _local_4:uint;
            var _local_2:String = "";
            var _local_3:int;
            while (_local_3 < _arg_1) {
                _local_4 = uint((Math.random() * 0xFF));
                _local_2 = (_local_2 + _local_4.toString(16));
                _local_3++;
            };
            return (_local_2);
        }

    }
}//package com.sulake.habbo.communication.demo

// IID = "_-3KV" (String#7712, DoABC#2)
// _roomSessionManager = "_-2nJ" (String#249, DoABC#2)
// keyExists = "_-2ME" (String#6487, DoABC#2)
// _SafeStr_10673 = "_-3K7" (String#22287, DoABC#2)
// _SafeStr_10674 = "_-6F" (String#7786, DoABC#2)
// closeLoginWindow = "_-Sl" (String#23355, DoABC#2)
// habboConfiguration = "_-0Ma" (String#14935, DoABC#2)
// populateUserList = "_-0yW" (String#16374, DoABC#2)
// sendTryLogin = "_-1kF" (String#18299, DoABC#2)
// habboCommunication = "_-uL" (String#24465, DoABC#2)
// flashClientUrl = "_-0dV" (String#15565, DoABC#2)
// ssoTicket = "_-1ab" (String#17919, DoABC#2)
// loadHotelViewImage = "_-0BN" (String#14500, DoABC#2)
// loadBannerImage = "_-2ad" (String#20471, DoABC#2)
// _flashClientUrl = "_-KW" (String#8093, DoABC#2)
// _habboCommunication = "_-1Ec" (String#17053, DoABC#2)
// _SafeStr_10715 = "_-16g" (String#16723, DoABC#2)
// _SafeStr_10716 = "_-3L3" (String#22326, DoABC#2)
// _ssoTicket = "_-2vH" (String#21289, DoABC#2)
// _SafeStr_10718 = "_-2hA" (String#20735, DoABC#2)
// _SafeStr_10719 = "_-ki" (String#24057, DoABC#2)
// _SafeStr_10720 = "_-1ue" (String#18743, DoABC#2)
// onHabboCommunication = "_-0Ae" (String#14475, DoABC#2)
// onHabboConfigurationInit = "_-1NP" (String#851, DoABC#2)
// communicationManager = "_-DC" (String#22737, DoABC#2)
// initConnection = "_-31b" (String#7337, DoABC#2)
// checkRequirements = "_-1zO" (String#18943, DoABC#2)
// onRoomSessionEnded = "_-2-U" (String#18991, DoABC#2)
// onConnectionEstablished = "_-0ht" (String#15743, DoABC#2)
// onConnectionDisconnected = "_-2-f" (String#18999, DoABC#2)
// onInitCrypto = "_-02C" (String#14134, DoABC#2)
// onSecretKeyEvent = "_-2kK" (String#20858, DoABC#2)
// onSessionParamsEvent = "_-0LN" (String#14890, DoABC#2)
// onAuthenticationOK = "_-20A" (String#612, DoABC#2)
// onPing = "_-Ii" (String#22954, DoABC#2)
// onErrorReport = "_-2WH" (String#20295, DoABC#2)
// onDisconnectReason = "_-2fJ" (String#20660, DoABC#2)
// onRoomEntryInfoEvent = "_-2uN" (String#21255, DoABC#2)
// onUniqueMachineId = "_-0Rd" (String#15126, DoABC#2)
// onIdentityAccounts = "_-RD" (String#23292, DoABC#2)
// componentsAreRunning = "_-qQ" (String#24290, DoABC#2)
// onInitConnection = "_-1HX" (String#17171, DoABC#2)
// dispatchLoginStepEvent = "_-0YJ" (String#15371, DoABC#2)
// onHotelViewBannerLoaded = "_-0BX" (String#14507, DoABC#2)
// sendConnectionParameters = "_-2gF" (String#20700, DoABC#2)
// generateRandomHexString = "_-2FF" (String#19614, DoABC#2)
// setOriginProperty = "_-1M" (String#17357, DoABC#2)
// setReasonProperty = "_-2hT" (String#20751, DoABC#2)
// sessionStarting = "_-0Wy" (String#4247, DoABC#2)
// showHotelView = "_-1dm" (String#18049, DoABC#2)
// ICoreCommunicationManager = "_-XS" (String#8357, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// HabboWebTools = "_-2pX" (String#21059, DoABC#2)
// HabboConnectionType = "_-1yr" (String#6011, DoABC#2)
// IEncryption = "_-0kE" (String#4505, DoABC#2)
// SecretKeyEvent = "_-23F" (String#6110, DoABC#2)
// PongMessageComposer = "_-1H-" (String#5188, DoABC#2)
// IKeyExchange = "_-26Q" (String#6174, DoABC#2)
// PseudoRandom = "_-ji" (String#24023, DoABC#2)
// UniqueMachineIDEvent = "_-0xp" (String#4804, DoABC#2)
// InfoRetrieveMessageComposer = "_-10H" (String#4876, DoABC#2)
// TryLoginMessageComposer = "_-1uh" (String#5932, DoABC#2)
// VersionCheckMessageComposer = "_-0ou" (String#4613, DoABC#2)
// SessionParamsMessageEvent = "_-J4" (String#8062, DoABC#2)
// GenericErrorEvent = "_-2X" (String#6699, DoABC#2)
// RC4_R27 = "_-1bx" (String#17969, DoABC#2)
// SSOTicketMessageComposer = "_-0cf" (String#4356, DoABC#2)
// PingMessageEvent = "_-0bC" (String#4327, DoABC#2)
// GetSessionParametersMessageComposer = "_-1Z7" (String#5544, DoABC#2)
// UniqueIDMessageComposer = "_-1uo" (String#5935, DoABC#2)
// IdentityAccountsEvent = "_-0GI" (String#3875, DoABC#2)
// InitCryptoMessageComposer = "_-Wc" (String#8338, DoABC#2)
// GenerateSecretKeyMessageComposer = "_-30y" (String#7326, DoABC#2)
// GenericErrorParser = "_-2ft" (String#6864, DoABC#2)
// ErrorReportMessageParser = "_-2xv" (String#7238, DoABC#2)
// HabboLoginDemoView = "_-06" (String#3685, DoABC#2)
// DisconnectReasonEvent = "_-1OP" (String#5321, DoABC#2)
// CryptoTools = "_-1UR" (String#17682, DoABC#2)
// InitCryptoMessageEvent = "_-Nu" (String#8163, DoABC#2)
// HabboHotelView = "_-FN" (String#7979, DoABC#2)
// ErrorReportEvent = "_-0WW" (String#4237, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// serverPublicKey = "_-1gz" (String#18175, DoABC#2)
// machineID = "_-08r" (String#14399, DoABC#2)
// reason = "_-053" (String#14245, DoABC#2)
// reasonString = "_-Ln" (String#23073, DoABC#2)
// token = "_-dt" (String#23796, DoABC#2)
// isServerEncrypted = "_-0WR" (String#15297, DoABC#2)
// accounts = "_-rq" (String#24354, DoABC#2)
// _token = "_-01j" (String#3597, DoABC#2)
// RWREUE_NORMAL_MODE = "_-w-" (String#24530, DoABC#2)
// generateSharedKey = "_-3D7" (String#7578, DoABC#2)
// getSharedKey = "_-1-f" (String#4862, DoABC#2)
// getPublicKey = "_-0XQ" (String#4257, DoABC#2)
// openWebPage = "_-27c" (String#6194, DoABC#2)
// addHabboConnectionMessageEvent = "_-0r" (String#4663, DoABC#2)
// getHabboMainConnection = "_-0AQ" (String#809, DoABC#2)
// initFromState = "_-12G" (String#4921, DoABC#2)
// decode = "_-1M7" (String#1666, DoABC#2)
// _SafeStr_4650 = "_-16X" (String#5004, DoABC#2)
// fromRadix = "_-2e9" (String#20609, DoABC#2)
// RSE_ENDED = "_-ar" (String#23665, DoABC#2)
// _habboConfiguration = "_-Mv" (String#637, DoABC#2)
// mode = "_-3Cz" (String#2023, DoABC#2)
// _SafeStr_6096 = "_-2kV" (String#20865, DoABC#2)
// _SafeStr_6097 = "_-2Y3" (String#20358, DoABC#2)
// _SafeStr_6098 = "_-3J6" (String#22244, DoABC#2)
// HABBO_CONNECTION_EVENT_ESTABLISHED = "_-24k" (String#19213, DoABC#2)
// HABBO_CONNECTION_EVENT_HANDSHAKING = "_-Zy" (String#23630, DoABC#2)
// HABBO_CONNECTION_EVENT_HANDSHAKED = "_-17L" (String#16750, DoABC#2)
// HABBO_CONNECTION_EVENT_HANDSHAKE_FAIL = "_-is" (String#23993, DoABC#2)
// HABBO_CONNECTION_EVENT_AUTHENTICATED = "_-2hD" (String#20737, DoABC#2)
// onGenericError = "_-1F3" (String#5159, DoABC#2)
// timestamp = "_-188" (String#16782, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// onWindowManagerReady = "_-34x" (String#94, DoABC#2)
// hexStringToByteArray = "_-0Rb" (String#15124, DoABC#2)
// HabboCommunicationEvent = "_-2do" (String#20593, DoABC#2)
// EventLogMessageComposer = "_-2lH" (String#6984, DoABC#2)
// RoomEntryInfoMessageEvent = "_-nk" (String#24182, DoABC#2)
// xor = "_-1WT" (String#5480, DoABC#2)
// setEncryption = "_-30E" (String#7309, DoABC#2)
// _communicationManager = "_-0-x" (String#432, DoABC#2)
// crash = "_-1--" (String#16429, DoABC#2)
// _SafeStr_9857 = "_-0SS" (String#15152, DoABC#2)


