
package com.hurlant.crypto.symmetric
{
    import flash.utils.ByteArray;

    public interface ICipher 
    {

        function getBlockSize():uint;
        function encrypt(_arg_1:ByteArray):void;
        function decrypt(_arg_1:ByteArray):void;
        function dispose():void;
        function toString():String;

    }
}//package com.hurlant.crypto.symmetric

// ICipher = "_-0ga" (String#4435, DoABC#2)
// encrypt = "_-0NA" (String#1460, DoABC#2)
// getBlockSize = "_-2Xy" (String#1896, DoABC#2)
// decrypt = "_-0j-" (String#1535, DoABC#2)


