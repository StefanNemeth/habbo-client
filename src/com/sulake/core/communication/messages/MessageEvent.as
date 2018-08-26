
package com.sulake.core.communication.messages
{
    import com.sulake.core.communication.connection.IConnection;

    public class MessageEvent implements IMessageEvent 
    {

        protected var _callback:Function;
        protected var _connection:IConnection;
        private var _parserClass:Class;
        protected var _parser:IMessageParser;

        public function MessageEvent(_arg_1:Function, _arg_2:Class)
        {
            this._callback = _arg_1;
            this._parserClass = _arg_2;
        }
        public function dispose():void
        {
            this._callback = null;
            this._parserClass = null;
            this._connection = null;
            this._parser = null;
        }
        public function get callback():Function
        {
            return (this._callback);
        }
        public function set connection(_arg_1:IConnection):void
        {
            this._connection = _arg_1;
        }
        public function get connection():IConnection
        {
            return (this._connection);
        }
        public function get parserClass():Class
        {
            return (this._parserClass);
        }
        public function set parser(_arg_1:IMessageParser):void
        {
            this._parser = _arg_1;
        }

    }
}//package com.sulake.core.communication.messages

// _parser = "_-2Ja" (String#19793, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)
// _callback = "_-0t2" (String#593, DoABC#2)


