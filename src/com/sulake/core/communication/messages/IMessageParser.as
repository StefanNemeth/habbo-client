
package com.sulake.core.communication.messages
{
    public interface IMessageParser 
    {

        function flush():Boolean;
        function parse(_arg_1:IMessageDataWrapper):Boolean;

    }
}//package com.sulake.core.communication.messages

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


