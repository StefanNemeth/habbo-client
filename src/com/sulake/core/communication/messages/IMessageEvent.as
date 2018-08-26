
package com.sulake.core.communication.messages
{
    import com.sulake.core.communication.connection.IConnection;

    public interface IMessageEvent 
    {

        function get callback():Function;
        function set connection(_arg_1:IConnection):void;
        function get connection():IConnection;
        function get parserClass():Class;
        function set parser(_arg_1:IMessageParser):void;
        function dispose():void;

    }
}//package com.sulake.core.communication.messages

// IMessageParser = "_-5U" (String#7770, DoABC#2)


