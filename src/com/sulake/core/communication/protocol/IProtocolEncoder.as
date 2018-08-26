
package com.sulake.core.communication.protocol
{
    import flash.utils.ByteArray;

    public interface IProtocolEncoder 
    {

        function dispose():void;
        function encode(_arg_1:int, _arg_2:Array, _arg_3:int=-1):ByteArray;

    }
}//package com.sulake.core.communication.protocol

// encode = "_-31x" (String#7345, DoABC#2)


