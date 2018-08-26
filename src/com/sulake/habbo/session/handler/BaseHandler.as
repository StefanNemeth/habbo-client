
package com.sulake.habbo.session.handler
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;

    public class BaseHandler implements IDisposable 
    {

        private var _connection:IConnection;
        private var _messageListener:IRoomHandlerListener;
        private var _disposed:Boolean = false;
        public var _xxxRoomId:int;
        public var _SafeStr_6312:int;

        public function BaseHandler(_arg_1:IConnection, _arg_2:IRoomHandlerListener)
        {
            this._connection = _arg_1;
            this._messageListener = _arg_2;
        }
        public function dispose():void
        {
            this._connection = null;
            this._messageListener = null;
            this._disposed = true;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get connection():IConnection
        {
            return (this._connection);
        }
        public function get listener():IRoomHandlerListener
        {
            return (this._messageListener);
        }

    }
}//package com.sulake.habbo.session.handler

// BaseHandler = "_-1Mx" (String#5291, DoABC#2)
// IRoomHandlerListener = "_-3Fo" (String#7627, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _messageListener = "_-16t" (String#833, DoABC#2)
// _SafeStr_6312 = "_-2JJ" (String#19781, DoABC#2)


