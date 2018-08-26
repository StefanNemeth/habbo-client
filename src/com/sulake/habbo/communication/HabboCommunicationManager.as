
package com.sulake.habbo.communication
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.communication.connection.IConnectionStateListener;
    import com.sulake.core.communication.ICoreCommunicationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.core.communication.messages.IMessageConfiguration;
    import flash.utils.Timer;
    import com.sulake.iid.IIDCoreCommunicationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import flash.events.Event;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.communication.messages.outgoing.handshake.DisconnectMessageComposer;
    import com.sulake.core.communication.protocol.IProtocol;
    import com.sulake.habbo.communication.enum.HabboProtocolType;
    import com.sulake.habbo.communication.protocol.WedgieProtocol;
    import com.sulake.habbo.communication.enum.HabboConnectionType;
    import com.sulake.core.communication.enum.ConnectionType;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.Core;
    import com.sulake.core.utils.ErrorReportStorage;
    import flash.events.TimerEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.tracking.HabboErrorVariableEnum;
    import com.sulake.iid.*;

    public class HabboCommunicationManager extends Component implements IHabboCommunicationManager, IConnectionStateListener 
    {

        private const _SafeStr_10827:int = 2;

        private var _communicationManager:ICoreCommunicationManager;
        private var _habboConfiguration:IHabboConfigurationManager;
        private var _connection:IConnection;
        private var _mode:int = 0;
        private var _messages:IMessageConfiguration;
        private var _SafeStr_9768:String = "";
        private var _SafeStr_10828:Array;
        private var _SafeStr_10829:int = -1;
        private var _SafeStr_10830:Timer;
        private var _SafeStr_10831:int = 1;
        private var _SafeStr_10832:String = "";
        private var _SafeStr_10833:Boolean = false;
        private var _SafeStr_10834:Boolean = false;
        private var _SafeStr_10835:Boolean = false;
        private var _a4:Array;

        public function HabboCommunicationManager(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            this._messages = new HabboMessages();
            this._SafeStr_10828 = [];
            this._SafeStr_10830 = new Timer(100, 1);
            this._a4 = [65191, 65178, 65178, 65177, 65185];
            super(_arg_1, _arg_2, _arg_3);
            lock();
            this.queueInterface(new IIDCoreCommunicationManager(), this.HabboCommunicationManager);
            this.queueInterface(new IIDHabboConfigurationManager(), this.HabboSoundManagerFlash10);
            _arg_1.events.addEventListener(Event.UNLOAD, this.unloading);
        }
        public function get mode():int
        {
            return (this._mode);
        }
        public function set mode(_arg_1:int):void
        {
            this._mode = _arg_1;
        }
        public function get port():int
        {
            if ((((((this._SafeStr_10828.length == 0)) || ((this._SafeStr_10829 < 0)))) || ((this._SafeStr_10829 >= this._SafeStr_10828.length)))){
                return (0);
            };
            return (this._SafeStr_10828[this._SafeStr_10829]);
        }
        private function unloading(_arg_1:Event):void
        {
            if (this._connection){
                this._connection.send(new DisconnectMessageComposer());
                this._connection.dispose();
                this._connection = null;
            };
        }
        override public function dispose():void
        {
            if (this._connection){
                this._connection.dispose();
                this._connection = null;
            };
            if (this._communicationManager){
                this._communicationManager.release(new IIDCoreCommunicationManager());
                this._communicationManager = null;
            };
            if (this._habboConfiguration){
                this._habboConfiguration.release(new IIDHabboConfigurationManager());
                this._habboConfiguration = null;
            };
            super.dispose();
        }
        private function HabboCommunicationManager(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            var _local_3:IProtocol;
            Logger.log(("Habbo Communication Manager: Core Communication Manager found:: " + [_arg_1, _arg_2]));
            if (_arg_2 != null){
                this._communicationManager = (_arg_2 as ICoreCommunicationManager);
                this._communicationManager.connectionStateListener = this;
                this._communicationManager.registerProtocolType(HabboProtocolType._SafeStr_6099, WedgieProtocol);
                this._connection = this._communicationManager.createConnection(HabboConnectionType._SafeStr_6096, ConnectionType._SafeStr_5164);
                _local_3 = this._communicationManager.getProtocolInstanceOfType(HabboProtocolType._SafeStr_6099);
                this._connection.registerMessageClasses(this._messages);
                this._connection.protocol = _local_3;
                this._connection.addEventListener(IOErrorEvent.IO_ERROR, this.HabboCommunicationManager);
                this._connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.HabboCommunicationManager);
                this._connection.addEventListener(Event.CONNECT, this.HabboCommunicationManager);
                this.HabboCommunicationManager();
            };
        }
        private function HabboSoundManagerFlash10(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            var _local_3:Array;
            var _local_4:Array;
            var _local_5:Array;
            var _local_6:Array;
            var _local_7:String;
            var _local_8:String;
            var _local_9:Array;
            var _local_10:String;
            var _local_11:Array;
            var _local_12:int;
            if (_arg_2 != null){
                this._habboConfiguration = (_arg_2 as IHabboConfigurationManager);
                _local_3 = [65162, 65162, 65158, 65155];
                _local_4 = [65234, 65174, 65168, 65175, 65165, 65229];
                _local_5 = [65170, 65162, 65157, 65155];
                _local_6 = [65186, 65168, 65178, 65171, 65171];
                _local_8 = this._habboConfiguration.getKey(this.getKey([this._a4, _local_6, _local_4, _local_5], 0), null);
                if (_local_8 == null){
                    Core.Core(this.getKey([this._a4, _local_6, _local_4, _local_5], 0), Core._SafeStr_9858);
                    return;
                };
                if (false == false){
                    _local_11 = [];
                    _local_12 = 1;
                    while (_local_12 < 5) {
                        _local_7 = _local_8.substring(0, (_local_8.length - _local_12));
                        switch (_local_12){
                            case (488311 % 668):
                                _local_11.push(_local_4);
                                break;
                            case (76 % 37):
                                _local_11.push(_local_6);
                                break;
                            case (415524125 % 49157):
                                _local_11.push(_local_3);
                                break;
                            case (16 % 5):
                                _local_11.push(this._a4);
                                break;
                        };
                        _local_12++;
                    };
                    _local_7 = this._habboConfiguration.getKey(this.getKey(_local_11, 0), null);
                };
                if (_local_7 == null){
                    Core.Core(this.getKey([this._a4, _local_6, _local_4, _local_3], 0), Core._SafeStr_9858);
                    return;
                };
                this._SafeStr_10828 = [];
                _local_9 = _local_7.split(",");
                for each (_local_10 in _local_9) {
                    this._SafeStr_10828.push(parseInt(_local_10.replace(" ", "")));
                };
                this._SafeStr_9768 = _local_8;
                this._SafeStr_10834 = true;
                if (this._SafeStr_10835){
                    this.HabboCommunicationManager();
                };
                this.HabboCommunicationManager();
            };
        }
        private function getKey(_arg_1:Array, _arg_2:int):String
        {
            var _local_4:Array;
            var _local_5:int;
            var _local_3:String = "";
            for each (_local_4 in _arg_1) {
                for each (_local_5 in _local_4) {
                    _local_3 = (_local_3 + String.fromCharCode(((65290 - _local_5) + _arg_2--)));
                };
            };
            return (_local_3);
        }
        private function HabboCommunicationManager():void
        {
            if (((this._habboConfiguration) && (this._communicationManager))){
                unlock();
            };
        }
        public function HabboCommunicationManager(_arg_1:String):void
        {
            switch (_arg_1){
                case HabboConnectionType._SafeStr_6096:
                    if (this._habboConfiguration == null){
                        Core.Core("Tried to connect to proxy but configuration was null", Core._SafeStr_9858);
                        return;
                    };
                    if (this._connection == null){
                        Core.Core("Tried to connect to proxy but connection was null", Core._SafeStr_9858);
                        return;
                    };
                    this._SafeStr_10835 = true;
                    if (this._SafeStr_10834){
                        this.HabboCommunicationManager();
                    };
                    return;
                default:
                    Logger.log(("Unknown Habbo Connection Type: " + _arg_1));
            };
        }
        private function HabboCommunicationManager():void
        {
            var _local_1:int;
            if (this._connection.connected){
                Logger.log("Warning: Already connected so will not try to connect again!");
                return;
            };
            this._SafeStr_10829++;
            if (this._SafeStr_10829 >= this._SafeStr_10828.length){
                ErrorReportStorage.addDebugData("ConnectionRetry", ("Connection attempt " + this._SafeStr_10831));
                this._SafeStr_10831++;
                _local_1 = this._SafeStr_10827;
                if (this._SafeStr_10828.length == 1){
                    _local_1++;
                };
                if (this._SafeStr_10831 <= _local_1){
                    this._SafeStr_10829 = 0;
                }
                else {
                    if (this._SafeStr_10833){
                        return;
                    };
                    this._SafeStr_10833 = true;
                    Core.error("Connection failed to host and ports", true, Core._SafeStr_9858);
                    return;
                };
            };
            this._connection.timeout = (this._SafeStr_10831 * 10000);
            if (false == false){
                this._connection.init((this._SafeStr_9768 + this.getKey(null, 0)), this._SafeStr_10828[this._SafeStr_10829]);
            };
        }
        private function HabboCommunicationManager(_arg_1:IOErrorEvent):void
        {
            Logger.log(("[HabboCommunicationManager] IO Error: " + _arg_1.text));
            switch (_arg_1.type){
                case IOErrorEvent.IO_ERROR:
                    break;
                case IOErrorEvent.DISK_ERROR:
                    break;
                case IOErrorEvent.NETWORK_ERROR:
                    break;
                case IOErrorEvent.VERIFY_ERROR:
                    break;
            };
            ErrorReportStorage.addDebugData("Communication IO Error", ((((("IOError " + _arg_1.type) + " on connect: ") + _arg_1.text) + ". Port was ") + this._SafeStr_10828[this._SafeStr_10829]));
            this.HabboCommunicationManager();
        }
        private function HabboCommunicationManager(_arg_1:Event):void
        {
            ErrorReportStorage.addDebugData("Connection", (("Connected with " + this._SafeStr_10831) + " attempts"));
        }
        private function HabboCommunicationManager():void
        {
            this._SafeStr_10830.addEventListener(TimerEvent.TIMER, this.HabboCommunicationManager);
            this._SafeStr_10830.start();
        }
        private function HabboCommunicationManager(_arg_1:TimerEvent):void
        {
            this._SafeStr_10830.stop();
            this.HabboCommunicationManager();
        }
        private function HabboCommunicationManager(_arg_1:SecurityErrorEvent):void
        {
            Logger.log(("[HabboCommunicationManager] Security Error: " + _arg_1.text));
            ErrorReportStorage.addDebugData("Communication Security Error", ((("SecurityError on connect: " + _arg_1.text) + ". Port was ") + this._SafeStr_10828[this._SafeStr_10829]));
            this.HabboCommunicationManager();
        }
        public function HabboCommunicationManager(_arg_1:Function):IConnection
        {
            return (((this._communicationManager) ? this._communicationManager.queueConnection(HabboConnectionType._SafeStr_6096, _arg_1) : null));
        }
        public function HabboCommunicationManager(_arg_1:IMessageEvent):void
        {
            if (this._communicationManager){
                this._communicationManager.addConnectionMessageEvent(HabboConnectionType._SafeStr_6096, _arg_1);
            };
        }
        public function HabboCommunicationManager(_arg_1:String, _arg_2:String):IHabboWebLogin
        {
            var _local_3:String = "";
            _local_3 = this._habboConfiguration.getKey("url.prefix", _local_3);
            _local_3 = _local_3.replace("http://", "");
            _local_3 = _local_3.replace("https://", "");
            return (new HabboWebLogin(_arg_1, _arg_2, _local_3));
        }
        public function HabboCommunicationManager(_arg_1:String, _arg_2:int):void
        {
            ErrorReportStorage.setParameter(HabboErrorVariableEnum._SafeStr_10841, _arg_1);
            ErrorReportStorage.setParameter(HabboErrorVariableEnum._SafeStr_10842, String(_arg_2));
        }
        public function HabboCommunicationManager(_arg_1:String, _arg_2:String):void
        {
            ErrorReportStorage.setParameter(HabboErrorVariableEnum._SafeStr_10843, String(new Date().getTime()));
            ErrorReportStorage.setParameter(HabboErrorVariableEnum._SafeStr_10844, ((_arg_1 + " ") + _arg_2));
            if (this._SafeStr_10832.length > 0){
                this._SafeStr_10832 = (this._SafeStr_10832 + (",R:" + _arg_1));
            }
            else {
                this._SafeStr_10832 = ("R:" + _arg_1);
            };
            if (this._SafeStr_10832.length > 150){
                this._SafeStr_10832 = this._SafeStr_10832.substring((this._SafeStr_10832.length - 150));
            };
            ErrorReportStorage.addDebugData("MESSAGE_QUEUE", this._SafeStr_10832);
        }
        public function HabboCommunicationManager(_arg_1:String, _arg_2:String):void
        {
            ErrorReportStorage.setParameter(HabboErrorVariableEnum._SafeStr_10845, String(new Date().getTime()));
            ErrorReportStorage.setParameter(HabboErrorVariableEnum._SafeStr_10846, ((_arg_1 + " ") + _arg_2));
            if (this._SafeStr_10832.length > 0){
                this._SafeStr_10832 = (this._SafeStr_10832 + (",S:" + _arg_1));
            }
            else {
                this._SafeStr_10832 = ("S:" + _arg_1);
            };
            if (this._SafeStr_10832.length > 150){
                this._SafeStr_10832 = this._SafeStr_10832.substring((this._SafeStr_10832.length - 150));
            };
            ErrorReportStorage.addDebugData("MESSAGE_QUEUE", this._SafeStr_10832);
        }

    }
}//package com.sulake.habbo.communication

// IID = "_-3KV" (String#7712, DoABC#2)
// HabboCommunicationManager = "_-0kp" (String#4518, DoABC#2)
// HabboSoundManagerFlash10 = "_-1NP" (String#851, DoABC#2)
// HabboCommunicationManager = "_-31b" (String#7337, DoABC#2)
// _SafeStr_10827 = "_-0G4" (String#14687, DoABC#2)
// _SafeStr_10828 = "_-3KA" (String#22289, DoABC#2)
// _SafeStr_10829 = "_-1Pn" (String#17500, DoABC#2)
// _SafeStr_10830 = "_-00r" (String#14087, DoABC#2)
// _SafeStr_10831 = "_-1Px" (String#17507, DoABC#2)
// _SafeStr_10832 = "_-VP" (String#23467, DoABC#2)
// _SafeStr_10833 = "_-0vl" (String#16265, DoABC#2)
// _SafeStr_10834 = "_-Xb" (String#23545, DoABC#2)
// _SafeStr_10835 = "_-0Ia" (String#14783, DoABC#2)
// HabboCommunicationManager = "_-0p2" (String#16016, DoABC#2)
// HabboCommunicationManager = "_-1yu" (String#18922, DoABC#2)
// HabboCommunicationManager = "_-0PH" (String#15034, DoABC#2)
// HabboCommunicationManager = "_-0N1" (String#14958, DoABC#2)
// HabboCommunicationManager = "_-2nO" (String#20973, DoABC#2)
// _SafeStr_10841 = "_-2Qw" (String#20084, DoABC#2)
// _SafeStr_10842 = "_-1CP" (String#16962, DoABC#2)
// _SafeStr_10843 = "_-T3" (String#23368, DoABC#2)
// _SafeStr_10844 = "_-22g" (String#19118, DoABC#2)
// _SafeStr_10845 = "_-Uh" (String#23435, DoABC#2)
// _SafeStr_10846 = "_-DW" (String#22749, DoABC#2)
// ICoreCommunicationManager = "_-XS" (String#8357, DoABC#2)
// IHabboWebLogin = "_-0eC" (String#4394, DoABC#2)
// HabboConnectionType = "_-1yr" (String#6011, DoABC#2)
// IMessageConfiguration = "_-EK" (String#7959, DoABC#2)
// HabboMessages = "_-1Q" (String#5352, DoABC#2)
// IProtocol = "_-2N9" (String#6505, DoABC#2)
// WedgieProtocol = "_-18r" (String#5055, DoABC#2)
// HabboWebLogin = "_-1H9" (String#5191, DoABC#2)
// ConnectionType = "_-2cZ" (String#20548, DoABC#2)
// HabboProtocolType = "_-02R" (String#3616, DoABC#2)
// DisconnectMessageComposer = "_-YP" (String#8381, DoABC#2)
// addDebugData = "_-04r" (String#14235, DoABC#2)
// HabboCommunicationManager = "_-0r" (String#4663, DoABC#2)
// HabboCommunicationManager = "_-0AQ" (String#809, DoABC#2)
// _messages = "_-1AO" (String#835, DoABC#2)
// _SafeStr_5164 = "_-1Dd" (String#17008, DoABC#2)
// _habboConfiguration = "_-Mv" (String#637, DoABC#2)
// mode = "_-3Cz" (String#2023, DoABC#2)
// _mode = "_-1kk" (String#611, DoABC#2)
// _SafeStr_6096 = "_-2kV" (String#20865, DoABC#2)
// _SafeStr_6099 = "_-03K" (String#14175, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// IConnectionStateListener = "_-1qk" (String#5868, DoABC#2)
// HabboErrorVariableEnum = "_-zF" (String#24662, DoABC#2)
// ErrorReportStorage = "_-Yg" (String#8387, DoABC#2)
// HabboCommunicationManager = "_-0sV" (String#4696, DoABC#2)
// HabboCommunicationManager = "_-1zG" (String#6021, DoABC#2)
// HabboCommunicationManager = "_-0AA" (String#3762, DoABC#2)
// timeout = "_-1Ga" (String#5177, DoABC#2)
// registerMessageClasses = "_-2m6" (String#7007, DoABC#2)
// protocol = "_-0Fr" (String#3870, DoABC#2)
// _communicationManager = "_-0-x" (String#432, DoABC#2)
// HabboCommunicationManager = "_-16F" (String#4999, DoABC#2)
// HabboCommunicationManager = "_-39M" (String#7498, DoABC#2)
// HabboCommunicationManager = "_-3LV" (String#7728, DoABC#2)
// addConnectionMessageEvent = "_-2QH" (String#6565, DoABC#2)
// queueConnection = "_-25p" (String#6156, DoABC#2)
// createConnection = "_-0Yf" (String#4276, DoABC#2)
// getProtocolInstanceOfType = "_-2R0" (String#6579, DoABC#2)
// connectionStateListener = "_-3Ik" (String#7685, DoABC#2)
// Core = "_-1--" (String#16429, DoABC#2)
// setParameter = "_-33Y" (String#21643, DoABC#2)
// _SafeStr_9768 = "_-30e" (String#7318, DoABC#2)
// _SafeStr_9858 = "_-1oR" (String#18474, DoABC#2)


