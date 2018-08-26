
package com.sulake.core.communication
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.IUpdateReceiver;
    import flash.utils.Dictionary;
    import com.sulake.core.communication.connection.IConnectionStateListener;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.core.communication.connection.SocketConnection;
    import com.sulake.core.communication.enum.ConnectionType;
    import com.sulake.core.communication.protocol.IProtocol;
    import com.sulake.iid.*;

    public class CoreCommunicationManager extends Component implements ICoreCommunicationManager, IUpdateReceiver 
    {

        private var _connections:Dictionary;
        private var _SafeStr_8855:Dictionary;
        private var _SafeStr_8856:Dictionary;
        private var _SafeStr_8857:Array;
        private var _connectionStateListener:IConnectionStateListener;

        public function CoreCommunicationManager(_arg_1:IContext, _arg_2:uint=0)
        {
            super(_arg_1, _arg_2);
            this._connections = new Dictionary();
            this._SafeStr_8855 = new Dictionary();
            this._SafeStr_8856 = new Dictionary();
            this._SafeStr_8857 = new Array();
            IContext(this, 1);
        }
        public function set connectionStateListener(_arg_1:IConnectionStateListener):void
        {
            this._connectionStateListener = _arg_1;
        }
        override public function dispose():void
        {
            var _local_1:IConnection;
            var _local_2:Array;
            var _local_3:IMessageParser;
            var _local_4:IMessageEvent;
            removeUpdateReceiver(this);
            for each (_local_1 in this._connections) {
                _local_1.dispose();
            };
            this._connections = null;
            this._SafeStr_8855 = null;
            this._connectionStateListener = null;
            for each (_local_2 in this._SafeStr_8856) {
                while (true) {
                    _local_4 = (_local_2.pop() as IMessageEvent);
                    if (!_local_4) break;
                    _local_4.dispose();
                };
            };
            this._SafeStr_8856 = null;
            for each (_local_3 in this._SafeStr_8857) {
            };
            (this._SafeStr_8855 = null);
            super.dispose();
        }
        public function createConnection(_arg_1:String, _arg_2:uint=0):IConnection
        {
            var _local_3:IConnection;
            switch (_arg_2){
                case ConnectionType._SafeStr_5164:
                    _local_3 = new SocketConnection(_arg_1, this, this._connectionStateListener);
                    _local_3;
                    break;
                default:
                    Logger.log(("[CoreCommunicationManager] Unknown connectionType, can not create connection: " + _arg_2));
            };
            (this._connections[_arg_1] = _local_3);
            return (_local_3);
        }
        public function queueConnection(_arg_1:String, _arg_2:Function):IConnection
        {
            if ((((_arg_1 == null)) || ((this._connections == null)))){
                return (null);
            };
            return ((this._connections[_arg_1] as IConnection));
        }
        public function registerProtocolType(_arg_1:String, _arg_2:Class):Boolean
        {
            var _local_3:Object = new (_arg_2)();
            if ((_local_3 is IProtocol)){
                (this._SafeStr_8855[_arg_1] = _arg_2);
                return (true);
            };
            throw (new Error((("[CoreCommunicationManager] Invalid Protocol class defined for protocol type " + _arg_1) + "!")));
        }
        public function getProtocolInstanceOfType(_arg_1:String):IProtocol
        {
            var _local_2:Class = this._SafeStr_8855[_arg_1];
            var _local_3:IProtocol;
            if (_local_2 != null){
                _local_3 = (new (_local_2)() as IProtocol);
                _local_3;
            }
            else {
                throw (new Error((("[CoreCommunicationManager] Could not instantiate Protocol class defined for protocol type " + _arg_1) + "!")));
            };
            return (_local_3);
        }
        public function addConnectionMessageEvent(_arg_1:String, _arg_2:IMessageEvent):void
        {
            var _local_3:Array = this._SafeStr_8856[_arg_1];
            if (_local_3 == null){
                _local_3 = new Array();
                _local_3;
                (this._SafeStr_8856[_arg_1] = _local_3);
            };
            _local_3.push(_arg_2);
        }
        public function removeConnectionMessageEvent(_arg_1:String, _arg_2:IMessageEvent):void
        {
            var _local_4:int;
            var _local_3:Array = this._SafeStr_8856[_arg_1];
            if (_local_3 != null){
                _local_4 = _local_3.indexOf(_arg_2);
                if (_local_4 >= 0){
                    _local_3.splice(_local_4, 1);
                };
            };
        }
        public function getMessageEvents(_arg_1:IConnection, _arg_2:Class):Array
        {
            var _local_4:String;
            var _local_7:IMessageEvent;
            var _local_3:String = "";
            for (var _local_10 in this._connections) {
                _local_4 = _local_10;
                _local_10;
                if (this._connections[_local_4] == _arg_1){
                    _local_3 = _local_4;
                    _local_3;
                    break;
                };
            };
            if (_local_3 == ""){
                throw (new Error((("[CoreCommunicationManager] Could not find registered events for connection " + _arg_1) + "!")));
            };
            var _local_5:Array = this._SafeStr_8856[_local_3];
            var _local_6:Array = new Array();
            for each (_local_10 in _local_5) {
                _local_7 = _local_10;
                _local_10;
                if ((_local_7 is _arg_2)){
                    _local_6.push(_local_7);
                };
            };
            return (_local_6);
        }
        public function getMessageParser(_arg_1:Class):IMessageParser
        {
            var _local_2:IMessageParser;
            var _local_3:IMessageParser;
            for each (var _local_6 in this._SafeStr_8857) {
                _local_3 = _local_6;
                _local_6;
                if ((_local_3 is _arg_1)){
                    _local_2 = _local_3;
                    _local_2;
                    break;
                };
            };
            if (_local_2 == null){
                _local_2 = (new (_arg_1)() as IMessageParser);
                _local_2;
                if (_local_2 == null){
                    throw (new Error((("[CoreCommunicationManager] Could not create parser-instance from class: " + _arg_1) + "!")));
                };
                this._SafeStr_8857.push(_local_2);
            };
            return (_local_2);
        }
        public function update(_arg_1:uint):void
        {
            var _local_2:IConnection;
            for each (var _local_5 in this._connections) {
                _local_2 = _local_5;
                _local_5;
                _local_2.processReceivedData();
            };
        }

    }
}//package com.sulake.core.communication

// ICoreCommunicationManager = "_-XS" (String#8357, DoABC#2)
// IProtocol = "_-2N9" (String#6505, DoABC#2)
// ConnectionType = "_-2cZ" (String#20548, DoABC#2)
// IContext = "_-35P" (String#7415, DoABC#2)
// _SafeStr_5164 = "_-1Dd" (String#17008, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// IConnectionStateListener = "_-1qk" (String#5868, DoABC#2)
// IUpdateReceiver = "_-Qe" (String#8218, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)
// processReceivedData = "_-28g" (String#6215, DoABC#2)
// addConnectionMessageEvent = "_-2QH" (String#6565, DoABC#2)
// removeConnectionMessageEvent = "_-hG" (String#8540, DoABC#2)
// getMessageEvents = "_-3D5" (String#7577, DoABC#2)
// getMessageParser = "_-2Dc" (String#6315, DoABC#2)
// queueConnection = "_-25p" (String#6156, DoABC#2)
// createConnection = "_-0Yf" (String#4276, DoABC#2)
// getProtocolInstanceOfType = "_-2R0" (String#6579, DoABC#2)
// connectionStateListener = "_-3Ik" (String#7685, DoABC#2)
// _SafeStr_8855 = "_-1jW" (String#18267, DoABC#2)
// _SafeStr_8856 = "_-ql" (String#24305, DoABC#2)
// _SafeStr_8857 = "_-1JV" (String#17257, DoABC#2)
// _connectionStateListener = "_-00f" (String#14081, DoABC#2)


