
package com.sulake.core.communication.protocol
{
    import flash.utils.ByteArray;

    public interface IProtocol 
    {

        function dispose():void;
        function get encoder():IProtocolEncoder;
        function get decoder():IProtocolDecoder;
        function getMessages(_arg_1:ByteArray, _arg_2:Array):uint;

    }
}//package com.sulake.core.communication.protocol

// IProtocol = "_-2N9" (String#6505, DoABC#2)
// IProtocolDecoder = "_-17h" (String#5031, DoABC#2)
// encoder = "_-29H" (String#6235, DoABC#2)
// decoder = "_-IU" (String#8050, DoABC#2)
// getMessages = "_-gT" (String#8521, DoABC#2)


