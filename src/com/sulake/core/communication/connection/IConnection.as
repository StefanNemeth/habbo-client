
package com.sulake.core.communication.connection
{
    import flash.events.IEventDispatcher;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.communication.encryption.IEncryption;
    import com.sulake.core.communication.messages.IMessageConfiguration;
    import com.sulake.core.communication.protocol.IProtocol;
    import com.sulake.core.communication.messages.IMessageEvent;

    public interface IConnection extends IEventDispatcher 
    {

        function dispose():void;
        function init(_arg_1:String, _arg_2:uint=0):Boolean;
        function set timeout(_arg_1:int):void;
        function send(_arg_1:IMessageComposer, _arg_2:int=-1):Boolean;
        function SocketConnection(_arg_1:IEncryption):void;
        function registerMessageClasses(_arg_1:IMessageConfiguration):void;
        function set protocol(_arg_1:IProtocol):void;
        function get protocol():IProtocol;
        function addMessageEvent(_arg_1:IMessageEvent):void;
        function SocketConnection(_arg_1:IMessageEvent):void;
        function processReceivedData():void;
        function get connected():Boolean;

    }
}//package com.sulake.core.communication.connection

// IMessageConfiguration = "_-EK" (String#7959, DoABC#2)
// IProtocol = "_-2N9" (String#6505, DoABC#2)
// IEncryption = "_-0kE" (String#4505, DoABC#2)
// SocketConnection = "_-0vh" (String#4760, DoABC#2)
// timeout = "_-1Ga" (String#5177, DoABC#2)
// SocketConnection = "_-30E" (String#7309, DoABC#2)
// registerMessageClasses = "_-2m6" (String#7007, DoABC#2)
// protocol = "_-0Fr" (String#3870, DoABC#2)
// processReceivedData = "_-28g" (String#6215, DoABC#2)


