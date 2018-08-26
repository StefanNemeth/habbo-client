
package com.sulake.habbo.communication.demo
{
    import flash.events.EventDispatcher;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ISelectableWindow;
    import com.sulake.core.runtime.Component;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import flash.net.SharedObject;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.components.ITextWindow;
    import flash.events.Event;
    import com.sulake.habbo.communication.IHabboWebLogin;
    import com.sulake.core.window.components.*;
    import com.sulake.habbo.window.enum.*;

    public class HabboLoginDemoView extends EventDispatcher 
    {

        public static const _SafeStr_10673:String = "InitConnection";

        private const _SafeStr_10674:String = "fuselogin";

        private var _SafeStr_10675:HabboCommunicationDemo;
        private var _window:IWindowContainer;
        private var _SafeStr_10676:SSOTicket;
        private var _SafeStr_10677:Boolean = false;
        public var name:String = "";
        public var password:String = "";

        public function HabboLoginDemoView(_arg_1:HabboCommunicationDemo)
        {
            this._SafeStr_10675 = _arg_1;
            this.createWindow();
        }
        public function dispose():void
        {
        }
        public function closeLoginWindow():void
        {
            this._SafeStr_10675.windowManager.removeWindow("habbo_login_window");
        }
        public function get useSSOTicket():Boolean
        {
            var _local_1:ISelectableWindow = (this._window.findChildByName("useTicket") as ISelectableWindow);
            if (_local_1 != null){
                return (_local_1.isSelected);
            };
            return (false);
        }
        public function get useExistingSession():Boolean
        {
            if (this._SafeStr_10677){
                return (true);
            };
            var _local_1:ISelectableWindow = (this._window.findChildByName("useExistingSession") as ISelectableWindow);
            if (_local_1 != null){
                return (_local_1.isSelected);
            };
            return (false);
        }
        private function createWindow():void
        {
            var _local_1:XmlAsset = ((this._SafeStr_10675 as Component).assets.getAssetByName("login_window") as XmlAsset);
            if (_local_1 == null){
                Logger.log("Could  not find embedded Window XML for Login Window, login_window");
                return;
            };
            this._window = (this._SafeStr_10675.windowManager.createWindow("habbo_login_window", "Login", HabboWindowType.0, HabboWindowStyle._SafeStr_4662, (HabboWindowParam._SafeStr_7485 | HabboWindowParam._SafeStr_3731), new Rectangle(10, 10, 320, 240), null) as IFrameWindow);
            var _local_2:XML = (_local_1.content as XML);
            var _local_3:IWindowContainer = (this._SafeStr_10675.windowManager.buildFromXML(_local_2) as IWindowContainer);
            this._window.addChild(_local_3);
            this._window.width = (_local_3.width + 20);
            this._window.height = (_local_3.height + 40);
            _local_3.x = 10;
            _local_3.y = 30;
            this._window.center();
            var _local_4:IButtonWindow = (_local_3.findChildByName("login_btn") as IButtonWindow);
            var _local_5:ITextFieldWindow = (_local_3.findChildByName("name_field") as ITextFieldWindow);
            var _local_6:ITextFieldWindow = (_local_3.findChildByName("pwd_field") as ITextFieldWindow);
            if (_local_4 != null){
                _local_4.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.HabboLoginDemoView);
            }
            else {
                Logger.log("Could not find the button");
            };
            var _local_7:SharedObject = SharedObject.getLocal(this._SafeStr_10674, "/");
            if (_local_5 != null){
                _local_5.textBackground = true;
                _local_5.textBackgroundColor = 0xFFFFFF;
                if (_local_7.data.login != null){
                    _local_5.text = _local_7.data.login;
                };
            };
            if (_local_6 != null){
                _local_6.textBackground = true;
                _local_6.textBackgroundColor = 0xFFFFFF;
                if (_local_7.data.password != null){
                    _local_6.text = _local_7.data.password;
                };
            };
            var _local_8:ISelectableWindow = (this._window.findChildByName("useTicket") as ISelectableWindow);
            if (_local_8){
                if (this._SafeStr_10675.habboConfiguration){
                    if (this._SafeStr_10675.habboConfiguration.getKey("use.sso", "false") == "true"){
                        _local_8.select();
                    };
                };
            };
            var _local_9:ISelectableWindow = (this._window.findChildByName("useExistingSession") as ISelectableWindow);
            if (_local_9){
                _local_9.ISelectableWindow();
            };
            if (((this._SafeStr_10675.habboConfiguration) && ((this._SafeStr_10675.habboConfiguration.getKey("try.existing.session", "false") == "true")))){
                this._SafeStr_10677 = true;
                this._window.visible = false;
                this.HabboLoginDemoView(WindowEvent.allocate(WindowEvent.WE_OK, this._window, null, false));
            };
        }
        public function HabboLoginDemoView(_arg_1:Map):void
        {
            var _local_5:IWindow;
            var _local_2:IItemListWindow = (this._window.findChildByName("list") as IItemListWindow);
            if (!_local_2){
                return;
            };
            var _local_3:XmlAsset = (this._SafeStr_10675.assets.getAssetByName("login_user_list_item") as XmlAsset);
            var _local_4:IWindow = this._SafeStr_10675.windowManager.buildFromXML((_local_3.content as XML));
            _local_4.procedure = this.HabboLoginDemoView;
            var _local_6:int;
            while (_local_6 < _arg_1.length) {
                _local_5 = _local_4.clone();
                _local_5.id = _arg_1.getKey(_local_6);
                _local_5.caption = _arg_1.getWithIndex(_local_6);
                _local_2.addListItem(_local_5);
                _local_6++;
            };
            _local_4.dispose();
        }
        public function HabboLoginDemoView(_arg_1:String):void
        {
            var _local_2:ITextWindow = (this._window.findChildByName("text002") as ITextWindow);
            if (_local_2 != null){
                _local_2.text = _arg_1;
            };
        }
        private function HabboLoginDemoView(_arg_1:WindowEvent=null, _arg_2:IWindow=null):void
        {
            var _local_4:ITextFieldWindow;
            var _local_5:ITextFieldWindow;
            var _local_6:SharedObject;
            var _local_3:IWindowContainer = (_arg_1.target.parent as IWindowContainer);
            if (_local_3 != null){
                _local_4 = (_local_3.findChildByName("name_field") as ITextFieldWindow);
                _local_5 = (_local_3.findChildByName("pwd_field") as ITextFieldWindow);
                if (_local_4 != null){
                    this.name = _local_4.text;
                };
                if (_local_5 != null){
                    this.password = _local_5.text;
                };
                _local_6 = SharedObject.getLocal(this._SafeStr_10674, "/");
                _local_6.data.login = this.name;
                _local_6.data.password = this.password;
                _local_6.flush();
            };
            if (this.useSSOTicket){
                this.HabboLoginDemoView(this.useExistingSession);
            }
            else {
                dispatchEvent(new Event(_SafeStr_10673));
            };
        }
        private function HabboLoginDemoView(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this._SafeStr_10675.sendTryLogin(this.name, this.password, _arg_2.id);
        }
        private function HabboLoginDemoView(_arg_1:Boolean):void
        {
            if (this._SafeStr_10676 != null){
                this._SafeStr_10676.removeEventListener(SSOTicket._SafeStr_10687, this.HabboLoginDemoView);
                this._SafeStr_10676.removeEventListener(SSOTicket._SafeStr_10689, this.HabboLoginDemoView);
                this._SafeStr_10676 = null;
            };
            var _local_2:String = "";
            if (this._SafeStr_10675.habboConfiguration != null){
                _local_2 = this._SafeStr_10675.habboConfiguration.getKey("url.prefix", _local_2);
                _local_2 = _local_2.replace("http://", "");
                _local_2 = _local_2.replace("https://", "");
            };
            var _local_3:IHabboWebLogin = this._SafeStr_10675.habboCommunication.HabboCommunicationManager(this.name, this.password);
            this._SafeStr_10676 = new SSOTicket(this._SafeStr_10675.assets, _local_3, _local_2, _arg_1);
            this._SafeStr_10676.addEventListener(SSOTicket._SafeStr_10687, this.HabboLoginDemoView);
            this._SafeStr_10676.addEventListener(SSOTicket._SafeStr_10689, this.HabboLoginDemoView);
        }
        private function HabboLoginDemoView(_arg_1:Event):void
        {
            Logger.log(("Got ticket: " + this._SafeStr_10676.ticket));
            Logger.log(("Has Facebook: " + this._SafeStr_10676.isFacebookUser));
            if (this._SafeStr_10676.isFacebookUser){
                this._SafeStr_10675.habboConfiguration.setKey("facebook.user", "1");
            };
            this._SafeStr_10675.flashClientUrl = this._SafeStr_10676.flashClientUrl;
            this._SafeStr_10675.ssoTicket = this._SafeStr_10676.ticket;
            this._SafeStr_10676.removeEventListener(SSOTicket._SafeStr_10687, this.HabboLoginDemoView);
            this._SafeStr_10676.removeEventListener(SSOTicket._SafeStr_10689, this.HabboLoginDemoView);
            this._SafeStr_10676 = null;
            dispatchEvent(new Event(_SafeStr_10673));
        }
        private function HabboLoginDemoView(_arg_1:Event):void
        {
            Logger.log("Could not get a ticket! ");
            this._SafeStr_10676.removeEventListener(SSOTicket._SafeStr_10687, this.HabboLoginDemoView);
            this._SafeStr_10676.removeEventListener(SSOTicket._SafeStr_10689, this.HabboLoginDemoView);
            this._SafeStr_10676 = null;
            if (this._SafeStr_10677){
                this._SafeStr_10677 = false;
                this._window.visible = true;
            };
        }

    }
}//package com.sulake.habbo.communication.demo

// _SafeStr_10673 = "_-3K7" (String#22287, DoABC#2)
// _SafeStr_10674 = "_-6F" (String#7786, DoABC#2)
// _SafeStr_10675 = "_-zw" (String#24681, DoABC#2)
// _SafeStr_10676 = "_-2Lv" (String#19881, DoABC#2)
// _SafeStr_10677 = "_-1ng" (String#18449, DoABC#2)
// closeLoginWindow = "_-Sl" (String#23355, DoABC#2)
// useSSOTicket = "_-1wb" (String#18826, DoABC#2)
// HabboLoginDemoView = "_-Fs" (String#22846, DoABC#2)
// habboConfiguration = "_-0Ma" (String#14935, DoABC#2)
// HabboLoginDemoView = "_-0yW" (String#16374, DoABC#2)
// HabboLoginDemoView = "_-19P" (String#16833, DoABC#2)
// HabboLoginDemoView = "_-1dW" (String#18035, DoABC#2)
// HabboLoginDemoView = "_-gz" (String#23928, DoABC#2)
// sendTryLogin = "_-1kF" (String#18299, DoABC#2)
// _SafeStr_10687 = "_-1Eu" (String#17067, DoABC#2)
// HabboLoginDemoView = "_-3Dw" (String#22031, DoABC#2)
// _SafeStr_10689 = "_-0Mh" (String#14939, DoABC#2)
// HabboLoginDemoView = "_-1Xe" (String#17800, DoABC#2)
// HabboCommunicationManager = "_-0kp" (String#4518, DoABC#2)
// habboCommunication = "_-uL" (String#24465, DoABC#2)
// ticket = "_-vm" (String#24519, DoABC#2)
// isFacebookUser = "_-o-" (String#24190, DoABC#2)
// flashClientUrl = "_-0dV" (String#15565, DoABC#2)
// ssoTicket = "_-1ab" (String#17919, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// HabboWindowParam = "_-29D" (String#6233, DoABC#2)
// HabboWindowStyle = "_-0E1" (String#14608, DoABC#2)
// HabboWindowType = "_-29U" (String#19384, DoABC#2)
// ITextFieldWindow = "_-3EL" (String#2027, DoABC#2)
// ISelectableWindow = "_-nA" (String#2188, DoABC#2)
// IHabboWebLogin = "_-0eC" (String#4394, DoABC#2)
// HabboLoginDemoView = "_-06" (String#3685, DoABC#2)
// SSOTicket = "_-1ex" (String#5643, DoABC#2)
// _SafeStr_3731 = "_-B" (String#22654, DoABC#2)
// _SafeStr_4662 = "_-0g1" (String#15673, DoABC#2)
// ISelectableWindow = "_-2aK" (String#6764, DoABC#2)
// setKey = "_-0sz" (String#1567, DoABC#2)
// textBackgroundColor = "_-11u" (String#1606, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// removeWindow = "_-x0" (String#949, DoABC#2)
// _SafeStr_7485 = "_-Q7" (String#23255, DoABC#2)
// 0 = "_-2pg" (String#21067, DoABC#2)
// WE_OK = "_-0UB" (String#15212, DoABC#2)
// textBackground = "_-IA" (String#2081, DoABC#2)
// allocate = "_-08G" (String#14374, DoABC#2)


