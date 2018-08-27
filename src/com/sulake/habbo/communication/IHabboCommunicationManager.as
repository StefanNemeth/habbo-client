
package com.sulake.habbo.communication
{
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.core.communication.messages.IMessageEvent;

    public interface IHabboCommunicationManager extends IUnknown 
    {

        function initConnection(_arg_1:String):void;
        function getHabboMainConnection(_arg_1:Function):IConnection;
        function addHabboConnectionMessageEvent(_arg_1:IMessageEvent):void;
        function get mode():int;
        function set mode(_arg_1:int):void;
        function get port():int;
        function habboWebLogin(_arg_1:String, _arg_2:String):IHabboWebLogin;

    }
}//package com.sulake.habbo.communication

// habboWebLogin = "_-0kp" (String#4518, DoABC#2)
// initConnection = "_-31b" (String#7337, DoABC#2)
// IHabboWebLogin = "_-0eC" (String#4394, DoABC#2)
// addHabboConnectionMessageEvent = "_-0r" (String#4663, DoABC#2)
// getHabboMainConnection = "_-0AQ" (String#809, DoABC#2)
// mode = "_-3Cz" (String#2023, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)


