
package com.sulake.core.communication.connection
{
    public interface IConnectionStateListener 
    {

        function connectionInit(_arg_1:String, _arg_2:int):void;
        function messageReceived(_arg_1:String, _arg_2:String):void;
        function messageSent(_arg_1:String, _arg_2:String):void;

    }
}//package com.sulake.core.communication.connection

// IConnectionStateListener = "_-1qk" (String#5868, DoABC#2)
// connectionInit = "_-0sV" (String#4696, DoABC#2)
// messageReceived = "_-1zG" (String#6021, DoABC#2)
// messageSent = "_-0AA" (String#3762, DoABC#2)


