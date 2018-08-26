
package com.sulake.habbo.communication.demo
{
    import flash.events.EventDispatcher;
    import flash.net.URLLoader;
    import com.sulake.habbo.communication.IHabboWebLogin;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.communication.enum.HabboWeb;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import flash.events.Event;

    public class SSOTicket extends EventDispatcher 
    {

        public static const _SafeStr_10687:String = "success";
        public static const _SafeStr_10689:String = "failure";

        private var _content:URLLoader;
        private var _SafeStr_4603:String;
        private var _SafeStr_10707:IHabboWebLogin;
        private var _SafeStr_10708:String;
        private var _ticket:String;
        private var _flashClientUrl:String;
        private var _assets:IAssetLibrary;
        private var _isFacebookUser:Boolean;

        public function SSOTicket(_arg_1:IAssetLibrary, _arg_2:IHabboWebLogin, _arg_3:String, _arg_4:Boolean=true)
        {
            this._assets = _arg_1;
            this._SafeStr_10707 = _arg_2;
            this._SafeStr_4603 = (("http://" + _arg_3) + "/client");
            if (!_arg_4){
                this._SafeStr_10707.init();
                this._SafeStr_10707.addEventListener(HabboWeb._SafeStr_6100, this.requestClientURL);
            }
            else {
                this.requestClientURL();
            };
        }
        public function get ticket():String
        {
            return (this._ticket);
        }
        public function get isFacebookUser():Boolean
        {
            return (this._isFacebookUser);
        }
        public function get flashClientUrl():String
        {
            return (this._flashClientUrl);
        }
        private function requestClientURL(_arg_1:Event=null):void
        {
            var _local_2:String = this._SafeStr_4603;
            if (this._assets.hasAsset(_local_2)){
                Logger.log(("[CoreLocalizationManager] reload localization for url: " + this._SafeStr_4603));
            };
            var _local_3:URLRequest = new URLRequest(this._SafeStr_4603);
            if (this._assets.hasAsset(_local_2)){
                this._assets.removeAsset(this._assets.getAssetByName(_local_2));
            };
            var _local_4:AssetLoaderStruct = this._assets.loadAssetFromFile(_local_2, _local_3, "text/plain");
            _local_4.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this._SafeStr_10712);
        }
        private function _SafeStr_10712(event:Event=null):void
        {
            var facebookData:Object;
            var loaderStruct:AssetLoaderStruct = (event.target as AssetLoaderStruct);
            if (loaderStruct == null){
                return;
            };
            var data:String = (loaderStruct.assetLoader.content as String);
            if (data.indexOf('account/reauthenticate"') > -1){
                this._SafeStr_10707.requestReAuthenticate();
            }
            else {
                try {
                    this._ticket = /\"sso.ticket\" : \"(.*?)\"/.exec(data)[1];
                    this._flashClientUrl = /\"flash.client.url\" : \"(.*?)\"/.exec(data)[1];
                    facebookData = /\"facebook.user\" : \"(.*?)\"/.exec(data);
                    if (facebookData){
                        this._isFacebookUser = Boolean(facebookData[1]);
                    };
                    if (this._ticket.length > 0){
                        dispatchEvent(new Event(_SafeStr_10687));
                    }
                    else {
                        dispatchEvent(new Event(_SafeStr_10689));
                    };
                }
                catch(e:Error) {
                    dispatchEvent(new Event(_SafeStr_10689));
                };
            };
        }

    }
}//package com.sulake.habbo.communication.demo

// _SafeStr_10687 = "_-1Eu" (String#17067, DoABC#2)
// _SafeStr_10689 = "_-0Mh" (String#14939, DoABC#2)
// ticket = "_-vm" (String#24519, DoABC#2)
// isFacebookUser = "_-o-" (String#24190, DoABC#2)
// flashClientUrl = "_-0dV" (String#15565, DoABC#2)
// _SafeStr_10707 = "_-2ol" (String#21035, DoABC#2)
// _SafeStr_10708 = "_-28m" (String#19361, DoABC#2)
// _ticket = "_-2JH" (String#19779, DoABC#2)
// _flashClientUrl = "_-KW" (String#8093, DoABC#2)
// _isFacebookUser = "_-2-L" (String#18984, DoABC#2)
// _SafeStr_10712 = "break" (String#25034, DoABC#2)
// requestReAuthenticate = "_-0QM" (String#4100, DoABC#2)
// IHabboWebLogin = "_-0eC" (String#4394, DoABC#2)
// HabboWeb = "_-14P" (String#4966, DoABC#2)
// SSOTicket = "_-1ex" (String#5643, DoABC#2)
// _SafeStr_4603 = "_-2QQ" (String#6569, DoABC#2)
// assetLoader = "_-1nR" (String#18439, DoABC#2)
// _content = "_-0lY" (String#299, DoABC#2)
// _SafeStr_6100 = "_-Fg" (String#22838, DoABC#2)
// AssetLoaderStruct = "_-0R2" (String#4112, DoABC#2)


