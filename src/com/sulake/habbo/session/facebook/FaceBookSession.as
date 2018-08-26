
package com.sulake.habbo.session.facebook
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.communication.messages.incoming.facebook.FaceBookAuthenticateEvent;
    import com.sulake.habbo.communication.messages.incoming.facebook.FaceBookErrorEvent;
    import com.sulake.habbo.communication.messages.incoming.facebook.FaceBookAppRequestEvent;
    import flash.external.ExternalInterface;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.communication.messages.outgoing.facebook.FaceBookIsLoggedOnMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.facebook.FaceBookIsLoggedOffMessageComposer;

    public class FaceBookSession implements IDisposable 
    {

        private static const _SafeStr_4521:String = "FlashExternalInterface.authenticateFacebook";
        private static const _SafeStr_4522:String = "sendAccessTokenToServer";
        private static const _FaceBookSession:String = "fbKLogOut";

        private var _disposed:Boolean;
        private var _connection:IHabboCommunicationManager;

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            if (!this._disposed){
                this._connection = null;
                this._disposed = true;
            };
        }
        public function set communication(_arg_1:IHabboCommunicationManager):void
        {
            this._connection = _arg_1;
            this._connection.HabboCommunicationManager(new FaceBookAuthenticateEvent(this.FaceBookSession));
            this._connection.HabboCommunicationManager(new FaceBookErrorEvent(this.onError));
            this._connection.HabboCommunicationManager(new FaceBookAppRequestEvent(this.FaceBookSession));
        }
        private function FaceBookSession(_arg_1:FaceBookAuthenticateEvent):void
        {
            Logger.log("-- -- FACEBOOK SESSION RECEIVED onAuthenticate!");
            if (ExternalInterface.available){
                ExternalInterface.addCallback(_SafeStr_4522, this.FaceBookSession);
                ExternalInterface.addCallback(_FaceBookSession, this.FaceBookSession);
                Logger.log("-- -- ADDED JAVASCRIPT CALLBACK HOOKS!");
                ExternalInterface.call(_SafeStr_4521);
                Logger.log(("-- -- CALLED JAVASCRIPT METHOD " + _SafeStr_4521));
            };
        }
        private function FaceBookSession(_arg_1:String, _arg_2:String, _arg_3:String):void
        {
            var _local_4:IConnection;
            Logger.log(((((("-- -- CALLBACK FROM JAVASCRIPT, RECEIVED VALUE " + _arg_1) + ", ") + _arg_2) + ", ") + _arg_3));
            if (!this._connection.disposed){
                _local_4 = this._connection.HabboCommunicationManager(null);
                if (_local_4){
                    _local_4.send(new FaceBookIsLoggedOnMessageComposer(_arg_1, _arg_2, _arg_3));
                };
            };
        }
        private function FaceBookSession(_arg_1:String):void
        {
            var _local_2:IConnection;
            if (!this._connection.disposed){
                _local_2 = this._connection.HabboCommunicationManager(null);
                if (_local_2){
                    this._connection.HabboCommunicationManager(null).send(new FaceBookIsLoggedOffMessageComposer());
                };
            };
        }
        private function onError(_arg_1:FaceBookErrorEvent):void
        {
        }
        private function FaceBookSession(_arg_1:FaceBookAppRequestEvent):void
        {
        }

    }
}//package com.sulake.habbo.session.facebook

// FaceBookSession = "_-32h" (String#21605, DoABC#2)
// FaceBookIsLoggedOnMessageComposer = "_-0ov" (String#16008, DoABC#2)
// FaceBookAuthenticateEvent = "_-11l" (String#4911, DoABC#2)
// FaceBookIsLoggedOffMessageComposer = "_-3CF" (String#21970, DoABC#2)
// FaceBookErrorEvent = "_-0LT" (String#3990, DoABC#2)
// FaceBookAppRequestEvent = "_-26B" (String#6168, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _SafeStr_4521 = "_-02b" (String#14146, DoABC#2)
// _SafeStr_4522 = "_-1QQ" (String#17529, DoABC#2)
// _FaceBookSession = "_-00d" (String#14080, DoABC#2)
// communication = "_-3HD" (String#22171, DoABC#2)
// HabboCommunicationManager = "_-0r" (String#4663, DoABC#2)
// FaceBookSession = "_-1kw" (String#18329, DoABC#2)
// onError = "_-1cU" (String#1723, DoABC#2)
// FaceBookSession = "_-25k" (String#19248, DoABC#2)
// FaceBookSession = "_-01V" (String#14110, DoABC#2)
// FaceBookSession = "_-11a" (String#16520, DoABC#2)
// HabboCommunicationManager = "_-0AQ" (String#809, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)


