
package com.sulake.core.communication.protocol
{
    import flash.utils.ByteArray;
    import com.sulake.core.communication.util.Short;

    public interface IProtocolDecoder 
    {

        function dispose():void;
        function getID(_arg_1:ByteArray):int;
        function decode(_arg_1:ByteArray):void;
        function readString(_arg_1:ByteArray):String;
        function readInteger(_arg_1:ByteArray):int;
        function readBoolean(_arg_1:ByteArray):Boolean;
        function readShort(_arg_1:ByteArray):Short;

    }
}//package com.sulake.core.communication.protocol

// IProtocolDecoder = "_-17h" (String#5031, DoABC#2)
// Short = "_-0S7" (String#4139, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// decode = "_-1M7" (String#1666, DoABC#2)
// getID = "_-zL" (String#8865, DoABC#2)


