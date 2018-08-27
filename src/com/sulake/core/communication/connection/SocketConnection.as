
package com.sulake.core.communication.connection
{
    import flash.events.EventDispatcher;
    import com.sulake.core.runtime.IDisposable;
    import flash.net.Socket;
    import flash.utils.ByteArray;
    import com.sulake.core.communication.encryption.IEncryption;
    import com.sulake.core.communication.protocol.IProtocol;
    import com.sulake.core.communication.messages.IMessageClassManager;
    import com.sulake.core.communication.ICoreCommunicationManager;
    import flash.utils.Timer;
    import com.sulake.core.communication.messages.MessageClassManager;
    import flash.events.TimerEvent;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.IOErrorEvent;
    import flash.external.ExternalInterface;
    import flash.system.Security;
    import flash.utils.getTimer;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.communication.messages.IMessageConfiguration;
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;
    import com.sulake.core.communication.messages.MessageDataWrapper;
    import com.sulake.core.utils.ErrorReportStorage;
    import flash.events.*;

    public class SocketConnection extends EventDispatcher implements IConnection, IDisposable 
    {

        public static const _SafeStr_8822:int = 10000;

        private var _disposed:Boolean = false;
        private var _SafeStr_8823:Socket;
        private var _SafeStr_8824:ByteArray;
        private var _SafeStr_8825:IEncryption;
        private var _protocol:IProtocol;
        private var _id:String;
        private var _SafeStr_8827:IMessageClassManager;
        private var _communicationManager:ICoreCommunicationManager;
        private var _SafeStr_8829:IConnectionStateListener;
        private var _SafeStr_8830:Timer;
        private var _SafeStr_8831:int;
        private var _SafeStr_8832:Boolean = false;

        public function SocketConnection(_arg_1:String, _arg_2:ICoreCommunicationManager, _arg_3:IConnectionStateListener)
        {
            this._id = _arg_1;
            this._communicationManager = _arg_2;
            this._SafeStr_8824 = new ByteArray();
            this._SafeStr_8827 = new MessageClassManager();
            this._SafeStr_8823 = new Socket();
            this._SafeStr_8830 = new Timer(_SafeStr_8822, 1);
            this._SafeStr_8830.addEventListener(TimerEvent.TIMER, this.onTimeOutTimer);
            this._SafeStr_8823.addEventListener(Event.CONNECT, this.onConnect);
            this._SafeStr_8823.addEventListener(Event.COMPLETE, this.onComplete);
            this._SafeStr_8823.addEventListener(Event.CLOSE, this.onClose);
            this._SafeStr_8823.addEventListener(ProgressEvent.SOCKET_DATA, this.onRead);
            this._SafeStr_8823.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
            this._SafeStr_8823.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
            this._SafeStr_8829 = _arg_3;
            ExternalInterface.addCallback("sendRawData", this.sendRaw);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function set protocol(_arg_1:IProtocol):void
        {
            this._protocol = _arg_1;
        }
        public function get protocol():IProtocol
        {
            return (this._protocol);
        }
        public function dispose():void
        {
            if (this.disposed){
                return;
            };
            this._disposed = true;
            if (this._SafeStr_8823){
                this._SafeStr_8823.removeEventListener(Event.CONNECT, this.onConnect);
                this._SafeStr_8823.removeEventListener(Event.COMPLETE, this.onComplete);
                this._SafeStr_8823.removeEventListener(Event.CLOSE, this.onClose);
                this._SafeStr_8823.removeEventListener(ProgressEvent.SOCKET_DATA, this.onRead);
                this._SafeStr_8823.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
                this._SafeStr_8823.removeEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
                if (this._SafeStr_8832){
                    this._SafeStr_8823.close();
                };
            };
            this._SafeStr_8823 = null;
            if (this._SafeStr_8830){
                this._SafeStr_8830.stop();
                this._SafeStr_8830.removeEventListener(TimerEvent.TIMER, this.onTimeOutTimer);
            };
            this._SafeStr_8830 = null;
            this._SafeStr_8824 = null;
            this._SafeStr_8829 = null;
            this._SafeStr_8825 = null;
            this._protocol = null;
            this._id = null;
            this._SafeStr_8827 = null;
            this._communicationManager = null;
            this._SafeStr_8829 = null;
        }
        public function init(_arg_1:String, _arg_2:uint=0):Boolean
        {
            this.logConnection(((("Connecting to " + _arg_1) + ":") + _arg_2));
            if (this._SafeStr_8829){
                this._SafeStr_8829.connectionInit(_arg_1, _arg_2);
            };
            Security.loadPolicyFile(((("xmlsocket://" + _arg_1) + ":") + _arg_2));
            this._SafeStr_8830.start();
            this._SafeStr_8831 = getTimer();
            this._SafeStr_8823.connect(_arg_1, _arg_2);
            return (true);
        }
        public function set timeout(_arg_1:int):void
        {
            this._SafeStr_8830.delay = _arg_1;
        }
        public function addMessageEvent(_arg_1:IMessageEvent):void
        {
            if (this.disposed){
                return;
            };
            this._communicationManager.addConnectionMessageEvent(this._id, _arg_1);
        }
        public function removeMessageEvent(_arg_1:IMessageEvent):void
        {
            if (this.disposed){
                return;
            };
            this._communicationManager.removeConnectionMessageEvent(this._id, _arg_1);
        }
        public function send(_arg_1:IMessageComposer, _arg_2:int=-1):Boolean
        {
            if (this.disposed){
                return (false);
            };
            var _local_3:ByteArray = new ByteArray();
            var _local_4:int = this._SafeStr_8827.getMessageComposerID(_arg_1);
            if (_local_4 < 0){
                this.logConnection(("Could not find registered message composer for " + _arg_1));
                return (false);
            };
            var _local_5:Array = _arg_1.getMessageArray();
            var _local_6:ByteArray = this._protocol.encoder.encode(_local_4, _local_5, _arg_2);
            if (this._SafeStr_8829){
                this._SafeStr_8829.messageSent(String(_local_4), _local_6.toString());
            };
            if (this._SafeStr_8825 != null){
                _local_3 = this._SafeStr_8825.encipher(_local_6);
            }
            else {
                _local_3 = _local_6;
            };
            if (this._SafeStr_8823.connected){
                this._SafeStr_8823.writeBytes(_local_3);
                this._SafeStr_8823.flush();
            }
            else {
                this.logConnection("[SOCKET] Not connected.");
                return (false);
            };
            return (true);
        }
        public function setEncryption(_arg_1:IEncryption):void
        {
            this._SafeStr_8825 = _arg_1;
        }
        public function registerMessageClasses(_arg_1:IMessageConfiguration):void
        {
            this._SafeStr_8827.registerMessages(_arg_1);
        }
        override public function toString():String
        {
            var _local_1:String = "";
            _local_1 = (_local_1 + "Socket Connection: \n");
            _local_1 = (_local_1 + (("Protocol Encoder: " + this._protocol.encoder) + "\n"));
            _local_1 = (_local_1 + (("Protocol Decoder: " + this._protocol.decoder) + "\n"));
            return ((_local_1 + (("Encryption: " + this._SafeStr_8825) + "\n")));
        }
        public function processReceivedData():void
        {
            var id:int;
            var message:Array;
            var data:ByteArray;
            var eventClasses:Array;
            var events:Array;
            var eventClass:Class;
            var eventsForClass:Array;
            var parserInstance:IMessageParser;
            var parserClassCurrent:Class;
            var dataClone:ByteArray;
            var messageEventInstance:IMessageEvent;
            var parserClass:Class;
            var dataWrapper:IMessageDataWrapper;
            var wasParsed:Boolean;
            var temp:ByteArray;
            if (this.disposed){
                return;
            };
            var receivedMessages:Array = new Array();
            var offset:uint = this._protocol.getMessages(this._SafeStr_8824, receivedMessages);
            try {
                for each (message in receivedMessages) {
                    id = (message[0] as int);
                    data = (message[1] as ByteArray);
                    ExternalInterface.call("FlashExternalInterface.logMessage", id, data.toString());
                    if (this._SafeStr_8829){
                        this._SafeStr_8829.messageReceived(String(id), data.toString());
                    };
                    eventClasses = this._SafeStr_8827.getMessageEventClasses(id);
                    events = new Array();
                    for each (eventClass in eventClasses) {
                        eventsForClass = this._communicationManager.getMessageEvents(this, eventClass);
                        events = events.concat(eventsForClass);
                    };
                    parserInstance = null;
                    parserClassCurrent = null;
                    for each (messageEventInstance in events) {
                        parserClass = messageEventInstance.parserClass;
                        if (parserClass != null){
                            wasParsed = false;
                            if (parserClass != parserClassCurrent){
                                dataClone = new ByteArray();
                                dataClone.writeBytes(data);
                                dataClone.position = data.position;
                                dataWrapper = new MessageDataWrapper(dataClone, this.protocol.decoder);
                                parserInstance = this._communicationManager.getMessageParser(parserClass);
                                if (!parserInstance.flush()){
                                    this.logConnection((">>[SocketConnection] Message Event Parser wasn't flushed: " + [id, parserClass, parserInstance]));
                                }
                                else {
                                    if (parserInstance.parse(dataWrapper)){
                                        parserClassCurrent = parserClass;
                                        wasParsed = true;
                                    };
                                };
                            }
                            else {
                                wasParsed = true;
                            };
                            if (wasParsed){
                                messageEventInstance.connection = this;
                                messageEventInstance.parser = parserInstance;
                                messageEventInstance.callback.call(null, messageEventInstance);
                            }
                            else {
                                parserClassCurrent = null;
                                parserInstance = null;
                            };
                        };
                    };
                };
                if (offset == this._SafeStr_8824.length){
                    this._SafeStr_8824 = new ByteArray();
                }
                else {
                    if (offset > 0){
                        temp = new ByteArray();
                        temp.writeBytes(this._SafeStr_8824, offset);
                        this._SafeStr_8824 = temp;
                        this.logConnection(((("[SOCKET REST] offset: " + offset) + " rest: ") + this._SafeStr_8824.toString()));
                    };
                };
            }
            catch(e:Error) {
                if (!disposed){
                    ErrorReportStorage.addDebugData("SocketConnection", (('Crashed while processing incoming message with id="' + id) + '"!'));
                    throw (e);
                };
            };
        }
        public function get connected():Boolean
        {
            if (this._SafeStr_8823 == null){
                return (false);
            };
            return (this._SafeStr_8823.connected);
        }
        private function onRead(_arg_1:ProgressEvent):void
        {
            if (this._SafeStr_8823 == null){
                return;
            };
            while (this._SafeStr_8823.bytesAvailable > 0) {
                this._SafeStr_8824.writeByte(this._SafeStr_8823.readUnsignedByte());
            };
        }
        private function onConnect(_arg_1:Event):void
        {
            this.logConnection("[SocketConnection] Connected");
            this._SafeStr_8830.stop();
            this._SafeStr_8832 = true;
            ErrorReportStorage.addDebugData("ConnectionTimer", ("Connected in " + (getTimer() - this._SafeStr_8831)));
            dispatchEvent(_arg_1);
        }
        private function onClose(_arg_1:Event):void
        {
            this._SafeStr_8830.stop();
            this.logConnection("[SocketConnection] Closed");
            this._SafeStr_8832 = false;
            ErrorReportStorage.addDebugData("ConnectionTimer", ("Closed in " + (getTimer() - this._SafeStr_8831)));
            dispatchEvent(_arg_1);
        }
        private function onComplete(_arg_1:Event):void
        {
            this._SafeStr_8830.stop();
            this.logConnection("[SocketConnection] Complete");
            ErrorReportStorage.addDebugData("ConnectionTimer", ("Completed in " + (getTimer() - this._SafeStr_8831)));
            dispatchEvent(_arg_1);
        }
        private function onSecurityError(_arg_1:SecurityErrorEvent):void
        {
            this._SafeStr_8830.stop();
            this.logConnection(("[SocketConnection] Security Error: " + _arg_1.text));
            ErrorReportStorage.addDebugData("ConnectionTimer", ("SecurityError in " + (getTimer() - this._SafeStr_8831)));
            dispatchEvent(_arg_1);
        }
        private function onIOError(_arg_1:IOErrorEvent):void
        {
            this._SafeStr_8830.stop();
            this.logConnection(("[SocketConnection] IO Error: " + _arg_1.text));
            ErrorReportStorage.addDebugData("ConnectionTimer", ("IOError in " + (getTimer() - this._SafeStr_8831)));
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
            dispatchEvent(_arg_1);
        }
        private function onTimeOutTimer(_arg_1:TimerEvent):void
        {
            this._SafeStr_8830.stop();
            this.logConnection("[SocketConnection] TimeOut Error");
            ErrorReportStorage.addDebugData("ConnectionTimer", ("TimeOut in " + (getTimer() - this._SafeStr_8831)));
            var _local_2:IOErrorEvent = new IOErrorEvent(IOErrorEvent.IO_ERROR);
            _local_2.text = (("Socket Timeout (" + this._SafeStr_8830.delay) + " ms). Possible Firewall.");
            dispatchEvent(_local_2);
        }
        private function logConnection(_arg_1:String):void
        {
        }
        private function sendRaw(_arg_1:String):void
        {
            this._SafeStr_8823.writeUTFBytes(_arg_1);
            this._SafeStr_8823.flush();
            return;
            //not popped:
//            this
            
        }

    }
}//package com.sulake.core.communication.connection

// ICoreCommunicationManager = "_-XS" (String#8357, DoABC#2)
// IMessageConfiguration = "_-EK" (String#7959, DoABC#2)
// IProtocol = "_-2N9" (String#6505, DoABC#2)
// IEncryption = "_-0kE" (String#4505, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// IMessageClassManager = "_-2if" (String#6924, DoABC#2)
// MessageDataWrapper = "_-17g" (String#16762, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// onComplete = "_-2qX" (String#7085, DoABC#2)
// addDebugData = "_-04r" (String#14235, DoABC#2)
// encipher = "_-15G" (String#4982, DoABC#2)
// encode = "_-31x" (String#7345, DoABC#2)
// onClose = "_-2Ts" (String#54, DoABC#2)
// encoder = "_-29H" (String#6235, DoABC#2)
// decoder = "_-IU" (String#8050, DoABC#2)
// getMessages = "_-gT" (String#8521, DoABC#2)
// removeMessageEvent = "_-0vh" (String#4760, DoABC#2)
// IConnectionStateListener = "_-1qk" (String#5868, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)
// ErrorReportStorage = "_-Yg" (String#8387, DoABC#2)
// connectionInit = "_-0sV" (String#4696, DoABC#2)
// messageReceived = "_-1zG" (String#6021, DoABC#2)
// messageSent = "_-0AA" (String#3762, DoABC#2)
// timeout = "_-1Ga" (String#5177, DoABC#2)
// setEncryption = "_-30E" (String#7309, DoABC#2)
// registerMessageClasses = "_-2m6" (String#7007, DoABC#2)
// protocol = "_-0Fr" (String#3870, DoABC#2)
// processReceivedData = "_-28g" (String#6215, DoABC#2)
// _SafeStr_8822 = "_-2DK" (String#19540, DoABC#2)
// _SafeStr_8823 = "_-5j" (String#22451, DoABC#2)
// _SafeStr_8824 = "_-pt" (String#24267, DoABC#2)
// _SafeStr_8825 = "_-2w9" (String#21316, DoABC#2)
// _protocol = "_-0Y" (String#15355, DoABC#2)
// _SafeStr_8827 = "_-dp" (String#23793, DoABC#2)
// _communicationManager = "_-0-x" (String#432, DoABC#2)
// _SafeStr_8829 = "_-d-" (String#23756, DoABC#2)
// _SafeStr_8830 = "_-4F" (String#22388, DoABC#2)
// _SafeStr_8831 = "_-04j" (String#14228, DoABC#2)
// _SafeStr_8832 = "_-Yh" (String#23586, DoABC#2)
// onTimeOutTimer = "_-6h" (String#22487, DoABC#2)
// onConnect = "_-16F" (String#4999, DoABC#2)
// onRead = "_-6u" (String#22496, DoABC#2)
// onSecurityError = "_-39M" (String#7498, DoABC#2)
// onIOError = "_-3LV" (String#7728, DoABC#2)
// logConnection = "_-39m" (String#21875, DoABC#2)
// addConnectionMessageEvent = "_-2QH" (String#6565, DoABC#2)
// removeConnectionMessageEvent = "_-hG" (String#8540, DoABC#2)
// getMessageComposerID = "_-2Ur" (String#6664, DoABC#2)
// registerMessages = "_-2Qq" (String#6573, DoABC#2)
// getMessageEventClasses = "_-1Uo" (String#5450, DoABC#2)
// getMessageEvents = "_-3D5" (String#7577, DoABC#2)
// getMessageParser = "_-2Dc" (String#6315, DoABC#2)


