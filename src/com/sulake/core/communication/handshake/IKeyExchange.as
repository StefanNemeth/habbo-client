
package com.sulake.core.communication.handshake
{
    public interface IKeyExchange 
    {

        function init(_arg_1:String, _arg_2:uint=16):Boolean;
        function generateSharedKey(_arg_1:String, _arg_2:uint=16):String;
        function getSharedKey(_arg_1:uint=16):String;
        function getPublicKey(_arg_1:uint=16):String;

    }
}//package com.sulake.core.communication.handshake

// IKeyExchange = "_-26Q" (String#6174, DoABC#2)
// generateSharedKey = "_-3D7" (String#7578, DoABC#2)
// getSharedKey = "_-1-f" (String#4862, DoABC#2)
// getPublicKey = "_-0XQ" (String#4257, DoABC#2)


