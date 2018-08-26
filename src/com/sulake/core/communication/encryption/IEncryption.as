
package com.sulake.core.communication.encryption
{
    import flash.utils.ByteArray;

    public interface IEncryption 
    {

        function init(_arg_1:ByteArray):void;
        function initFromState(_arg_1:IEncryption):void;
        function encipher(_arg_1:ByteArray, _arg_2:Boolean=false):ByteArray;
        function decipher(_arg_1:ByteArray):ByteArray;

    }
}//package com.sulake.core.communication.encryption

// IEncryption = "_-0kE" (String#4505, DoABC#2)
// initFromState = "_-12G" (String#4921, DoABC#2)
// encipher = "_-15G" (String#4982, DoABC#2)
// decipher = "_-2tX" (String#7148, DoABC#2)


