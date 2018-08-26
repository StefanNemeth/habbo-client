
package com.sulake.core.communication.messages
{
    import com.sulake.core.communication.util.Short;

    public interface IMessageDataWrapper 
    {

        function readString():String;
        function readInteger():int;
        function readBoolean():Boolean;
        function readShort():Short;

    }
}//package com.sulake.core.communication.messages

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// Short = "_-0S7" (String#4139, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)


