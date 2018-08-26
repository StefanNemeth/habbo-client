
package com.sulake.habbo.communication
{
    import flash.events.EventDispatcher;
    import flash.net.URLLoader;
    import flash.events.IEventDispatcher;
    import flash.net.URLRequest;
    import flash.net.URLVariables;
    import flash.net.URLRequestMethod;
    import flash.events.Event;
    import com.sulake.habbo.communication.enum.HabboWeb;
    import flash.events.SecurityErrorEvent;
    import flash.events.HTTPStatusEvent;
    import flash.events.IOErrorEvent;

    public class HabboWebLogin extends EventDispatcher implements IHabboWebLogin 
    {

        private var _content:URLLoader;
        private var _name:String;
        private var _password:String;
        private var _SafeStr_10814:String;
        private var _SafeStr_10815:String;
        private var _SafeStr_10816:String;

        public function HabboWebLogin(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:IEventDispatcher=null)
        {
            super(_arg_4);
            this._name = _arg_1;
            this._password = _arg_2;
            this._SafeStr_10814 = (("https://" + _arg_3) + "/account/submit");
            this._SafeStr_10815 = (("https://" + _arg_3) + "/security_check");
            this._SafeStr_10816 = (("https://" + _arg_3) + "/account/reauthenticate");
        }
        public function init():void
        {
            this.requestCredentials();
        }
        private function requestCredentials():void
        {
            var _local_1:String = ((("credentials.username=" + this._name) + "&credentials.password=") + this._password);
            var _local_2:URLRequest = new URLRequest(this._SafeStr_10814);
            _local_2.data = new URLVariables(_local_1);
            _local_2.method = URLRequestMethod.POST;
            this._content = new URLLoader();
            this._content.addEventListener(Event.COMPLETE, this.credentialsComplete);
            this.configureListeners(this._content);
            this._content.load(_local_2);
        }
        private function credentialsComplete(_arg_1:Event=null):void
        {
            var _local_4:String;
            var _local_5:URLRequest;
            var _local_2:URLLoader = URLLoader(_arg_1.target);
            var _local_3:String = _local_2.data;
            if ((((_local_3.indexOf("Redirecting") > -1)) && (!((_local_3.indexOf("/useOrCreateAvatar/") == -1))))){
                _local_4 = /<meta http-equiv="Refresh" content="0;URL=(.*?)">/.exec(_local_3)[1];
                _local_5 = new URLRequest(_local_4);
                this._content.load(_local_5);
                return;
            };
            this._content.removeEventListener(Event.COMPLETE, this.credentialsComplete);
            this.removeListeners(this._content);
            if (_local_3.indexOf("Redirecting") > -1){
                this.requestSecurityCheck();
            }
            else {
                if (_local_3.indexOf("Habbo ~ Me") > -1){
                    dispatchEvent(new Event(HabboWeb._SafeStr_6100));
                }
                else {
                    if (_local_3.indexOf("Habbo ~ Home") > -1){
                        dispatchEvent(new Event(HabboWeb._SafeStr_6100));
                    }
                    else {
                        if (_local_3.indexOf("Habbo: Home") > -1){
                            dispatchEvent(new Event(HabboWeb._SafeStr_6100));
                        }
                        else {
                            if (_local_3.indexOf("document.habboLoggedIn = true") > -1){
                                dispatchEvent(new Event(HabboWeb._SafeStr_6100));
                            };
                        };
                    };
                };
            };
        }
        private function requestSecurityCheck():void
        {
            var _local_1:URLRequest = new URLRequest(this._SafeStr_10815);
            this._content = new URLLoader();
            this._content.addEventListener(Event.COMPLETE, this.securityCheckComplete);
            this.configureListeners(this._content);
            this._content.load(_local_1);
        }
        private function securityCheckComplete(_arg_1:Event=null):void
        {
            var _local_2:URLLoader = URLLoader(_arg_1.target);
            this._content.removeEventListener(Event.COMPLETE, this.securityCheckComplete);
            this.removeListeners(this._content);
            var _local_3:String = _local_2.data;
            if (_local_3.indexOf("Redirecting") > -1){
                dispatchEvent(new Event(HabboWeb._SafeStr_6100));
            };
        }
        public function requestReAuthenticate():void
        {
            var _local_1:String = ("page=%2Fclient&credentials.password=" + this._password);
            var _local_2:URLRequest = new URLRequest(this._SafeStr_10816);
            _local_2.data = new URLVariables(_local_1);
            _local_2.method = URLRequestMethod.POST;
            this._content = new URLLoader();
            this._content.addEventListener(Event.COMPLETE, this.reauthenticateComplete);
            this.configureListeners(this._content);
            this._content.load(_local_2);
        }
        private function reauthenticateComplete(_arg_1:Event=null):void
        {
            var _local_2:URLLoader = URLLoader(_arg_1.target);
            this._content.removeEventListener(Event.COMPLETE, this.reauthenticateComplete);
            this.removeListeners(this._content);
            var _local_3:String = _local_2.data;
            if (_local_3.indexOf("Redirecting") > -1){
                dispatchEvent(new Event(HabboWeb._SafeStr_6100));
            }
            else {
                Logger.log("[HabboWebLogin] Reauthenticate completed but couldn't find 'Redirecting' string. Something failed.");
                if (_local_3.indexOf("You need to use secure log")){
                    Logger.log("[HabboWebLogin] Reason for failure: You need to use secure login in HK.");
                };
            };
        }
        private function configureListeners(_arg_1:IEventDispatcher):void
        {
            _arg_1.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityErrorHandler);
            _arg_1.addEventListener(HTTPStatusEvent.HTTP_STATUS, this.httpStatusHandler);
            _arg_1.addEventListener(IOErrorEvent.IO_ERROR, this.ioErrorHandler);
        }
        private function removeListeners(_arg_1:IEventDispatcher):void
        {
            _arg_1.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityErrorHandler);
            _arg_1.removeEventListener(HTTPStatusEvent.HTTP_STATUS, this.httpStatusHandler);
            _arg_1.removeEventListener(IOErrorEvent.IO_ERROR, this.ioErrorHandler);
        }
        private function ioErrorHandler(_arg_1:IOErrorEvent):void
        {
            Logger.log(((("[LoginToWeb] IOError: " + _arg_1.text) + " ") + _arg_1.type));
        }
        private function httpStatusHandler(_arg_1:HTTPStatusEvent):void
        {
            Logger.log(((("[LoginToWeb] HTTPStatus: " + _arg_1.status) + " ") + _arg_1.type));
        }
        private function securityErrorHandler(_arg_1:SecurityErrorEvent):void
        {
            Logger.log(("[LoginToWeb] SecurityError: " + _arg_1.text));
        }

    }
}//package com.sulake.habbo.communication

// requestReAuthenticate = "_-0QM" (String#4100, DoABC#2)
// _SafeStr_10814 = "_-1m-" (String#18377, DoABC#2)
// _SafeStr_10815 = "_-14I" (String#16627, DoABC#2)
// _SafeStr_10816 = "_-h4" (String#23934, DoABC#2)
// requestCredentials = "_-1hc" (String#18194, DoABC#2)
// credentialsComplete = "_-1F0" (String#17071, DoABC#2)
// configureListeners = "_-0Zs" (String#15437, DoABC#2)
// removeListeners = "_-05H" (String#14255, DoABC#2)
// requestSecurityCheck = "_-2Of" (String#19991, DoABC#2)
// securityCheckComplete = "_-14C" (String#16625, DoABC#2)
// reauthenticateComplete = "_-1ri" (String#18618, DoABC#2)
// securityErrorHandler = "_-h7" (String#23935, DoABC#2)
// httpStatusHandler = "_-Rq" (String#23318, DoABC#2)
// ioErrorHandler = "_-1tF" (String#5906, DoABC#2)
// IHabboWebLogin = "_-0eC" (String#4394, DoABC#2)
// HabboWebLogin = "_-1H9" (String#5191, DoABC#2)
// HabboWeb = "_-14P" (String#4966, DoABC#2)
// _content = "_-0lY" (String#299, DoABC#2)
// _SafeStr_6100 = "_-Fg" (String#22838, DoABC#2)


