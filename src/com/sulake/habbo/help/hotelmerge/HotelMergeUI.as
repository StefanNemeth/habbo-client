
package com.sulake.habbo.help.hotelmerge
{
    import com.sulake.habbo.help.INameChangeUI;
    import com.sulake.habbo.help.HabboHelp;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.communication.messages.outgoing.avatar.ChangeUserNameMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.avatar.CheckUserNameMessageComposer;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.parser.avatar.ChangeUserNameResultMessageParser;
    import com.sulake.habbo.communication.messages.incoming.avatar.ChangeUserNameResultMessageEvent;
    import com.sulake.habbo.communication.messages.parser.avatar.CheckUserNameResultMessageParser;
    import com.sulake.habbo.communication.messages.incoming.avatar.CheckUserNameResultMessageEvent;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;

    public class HotelMergeUI implements INameChangeUI 
    {

        private var _SafeStr_11411:HabboHelp;
        private var _view:HotelMergeNameChangeView;

        public function HotelMergeUI(_arg_1:HabboHelp)
        {
            this._SafeStr_11411 = _arg_1;
        }
        public function get assets():IAssetLibrary
        {
            return (this._SafeStr_11411.assets);
        }
        public function get localization():IHabboLocalizationManager
        {
            return (this._SafeStr_11411.localization);
        }
        public function get windowManager():IHabboWindowManager
        {
            return (this._SafeStr_11411.windowManager);
        }
        public function dispose():void
        {
            this._SafeStr_11411 = null;
            if (this._view){
                this._view.dispose();
                this._view = null;
            };
        }
        public function HotelMergeUI():void
        {
            if (!this._view){
                this._view = new HotelMergeNameChangeView(this);
            };
            this._view.NameChangeView();
        }
        public function changeName(_arg_1:String):void
        {
            this._SafeStr_11411.sendMessage(new ChangeUserNameMessageComposer(_arg_1));
        }
        public function checkName(_arg_1:String):void
        {
            this._SafeStr_11411.sendMessage(new CheckUserNameMessageComposer(_arg_1));
        }
        public function onUserNameChanged(name:String):void
        {
            if (!this._SafeStr_11411){
                return;
            };
            this._SafeStr_11411.localization.registerParameter("help.tutorial.name.changed", "name", name);
            this._SafeStr_11411.windowManager.alert("${generic.notice}", "${help.tutorial.name.changed}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
            {
                _arg_1.dispose();
            });
        }
        public function onChangeUserNameResult(_arg_1:ChangeUserNameResultMessageEvent):void
        {
            if (_arg_1 == null){
                return;
            };
            var _local_2:ChangeUserNameResultMessageParser = _arg_1.getParser();
            if (_local_2.resultCode == ChangeUserNameResultMessageEvent._SafeStr_7096){
                this._view.dispose();
            }
            else {
                this._view.NameChangeView(_local_2.resultCode, _local_2.name, _local_2.nameSuggestions);
            };
        }
        public function onCheckUserNameResult(_arg_1:CheckUserNameResultMessageEvent):void
        {
            if (!_arg_1){
                return;
            };
            var _local_2:CheckUserNameResultMessageParser = _arg_1.getParser();
            if (_local_2.resultCode == ChangeUserNameResultMessageEvent._SafeStr_7096){
                this._view.checkedName = _local_2.name;
            }
            else {
                this._view.NameChangeView(_local_2.resultCode, _local_2.name, _local_2.nameSuggestions);
            };
        }
        public function get myName():String
        {
            return (this._SafeStr_11411.ownUserName);
        }
        public function HabboInventory(_arg_1:String):void
        {
        }
        public function buildXmlWindow(_arg_1:String, _arg_2:uint=1):IWindow
        {
            if ((((this._SafeStr_11411 == null)) || ((this._SafeStr_11411.assets == null)))){
                return (null);
            };
            var _local_3:XmlAsset = XmlAsset(this._SafeStr_11411.assets.getAssetByName((_arg_1 + "_xml")));
            if ((((_local_3 == null)) || ((this._SafeStr_11411.windowManager == null)))){
                return (null);
            };
            return (this._SafeStr_11411.windowManager.buildFromXML(XML(_local_3.content), _arg_2));
        }

    }
}//package com.sulake.habbo.help.hotelmerge

// _SafeStr_11411 = "_-0kl" (String#822, DoABC#2)
// NameChangeView = "_-2pt" (String#21077, DoABC#2)
// changeName = "_-0uN" (String#4733, DoABC#2)
// checkName = "_-2Fe" (String#6356, DoABC#2)
// onUserNameChanged = "_-dO" (String#23776, DoABC#2)
// onChangeUserNameResult = "_-06v" (String#1405, DoABC#2)
// NameChangeView = "_-oP" (String#24210, DoABC#2)
// onCheckUserNameResult = "_-2F9" (String#6344, DoABC#2)
// checkedName = "_-11W" (String#16518, DoABC#2)
// myName = "_-0Kp" (String#3971, DoABC#2)
// ownUserName = "_-19l" (String#16846, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// INameChangeUI = "_-34B" (String#7392, DoABC#2)
// HotelMergeUI = "_-XE" (String#8353, DoABC#2)
// ChangeUserNameResultMessageParser = "_-9" (String#22578, DoABC#2)
// ChangeUserNameResultMessageEvent = "_-3HW" (String#22180, DoABC#2)
// CheckUserNameResultMessageEvent = "_-2Tb" (String#20186, DoABC#2)
// ChangeUserNameMessageComposer = "_-05J" (String#14256, DoABC#2)
// HotelMergeNameChangeView = "_-0Ko" (String#3970, DoABC#2)
// CheckUserNameResultMessageParser = "_-15d" (String#4988, DoABC#2)
// CheckUserNameMessageComposer = "_-pJ" (String#24245, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// _SafeStr_7096 = "_-OP" (String#23184, DoABC#2)
// HotelMergeUI = "_-1qU" (String#5864, DoABC#2)
// HabboInventory = "_-1gE" (String#860, DoABC#2)
// resultCode = "_-09c" (String#14431, DoABC#2)
// nameSuggestions = "_-2Cy" (String#19520, DoABC#2)


