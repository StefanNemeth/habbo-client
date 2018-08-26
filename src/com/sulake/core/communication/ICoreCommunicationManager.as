
package com.sulake.core.communication
{
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.core.communication.protocol.IProtocol;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.connection.IConnectionStateListener;

    public interface ICoreCommunicationManager extends IUnknown 
    {

        function queueConnection(_arg_1:String, _arg_2:Function):IConnection;
        function createConnection(_arg_1:String, _arg_2:uint=0):IConnection;
        function registerProtocolType(_arg_1:String, _arg_2:Class):Boolean;
        function getProtocolInstanceOfType(_arg_1:String):IProtocol;
        function addConnectionMessageEvent(_arg_1:String, _arg_2:IMessageEvent):void;
        function removeConnectionMessageEvent(_arg_1:String, _arg_2:IMessageEvent):void;
        function getMessageEvents(_arg_1:IConnection, _arg_2:Class):Array;
        function getMessageParser(_arg_1:Class):IMessageParser;
        function set connectionStateListener(_arg_1:IConnectionStateListener):void;

    }
}//package com.sulake.core.communication

// ICoreCommunicationManager = "_-XS" (String#8357, DoABC#2)
// IProtocol = "_-2N9" (String#6505, DoABC#2)
// IConnectionStateListener = "_-1qk" (String#5868, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)
// addConnectionMessageEvent = "_-2QH" (String#6565, DoABC#2)
// removeConnectionMessageEvent = "_-hG" (String#8540, DoABC#2)
// getMessageEvents = "_-3D5" (String#7577, DoABC#2)
// getMessageParser = "_-2Dc" (String#6315, DoABC#2)
// queueConnection = "_-25p" (String#6156, DoABC#2)
// createConnection = "_-0Yf" (String#4276, DoABC#2)
// getProtocolInstanceOfType = "_-2R0" (String#6579, DoABC#2)
// connectionStateListener = "_-3Ik" (String#7685, DoABC#2)


