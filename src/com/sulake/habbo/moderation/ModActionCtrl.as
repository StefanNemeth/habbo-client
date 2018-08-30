
package com.sulake.habbo.moderation
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.habbo.communication.messages.incoming.moderation.OffenceCategoryData;
    import com.sulake.habbo.communication.messages.incoming.moderation.OffenceData;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.incoming.moderation.INamed;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.communication.messages.outgoing.moderator.ModAlertMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.moderator.ModKickMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.moderator.ModBanMessageComposer;
    import com.sulake.habbo.window.utils.IAlertDialog;

    public class ModActionCtrl implements IDisposable, TrackedWindow 
    {

        private static var _SafeStr_11912:Array;

        private var _help:ModerationManager;
        private var _SafeStr_11909:int;
        private var _id:String;
        private var _SafeStr_11848:String;
        private var _frame:IFrameWindow;
        private var _SafeStr_11913:IDropMenuWindow;
        private var _SafeStr_11823:ITextFieldWindow;
        private var _disposed:Boolean;
        private var _SafeStr_11824:Boolean = true;
        private var _SafeStr_11914:OffenceCategoryData;
        private var _SafeStr_11915:OffenceData;
        private var _SafeStr_11916:IButtonWindow;
        private var _SafeStr_11917:IButtonWindow;

        public function ModActionCtrl(_arg_1:ModerationManager, _arg_2:int, _arg_3:String, _arg_4:String)
        {
            this._help = _arg_1;
            this._SafeStr_11909 = _arg_2;
            this._id = _arg_3;
            this._SafeStr_11848 = _arg_4;
            if (_SafeStr_11912 == null){
                _SafeStr_11912 = new Array();
                _SafeStr_11912.push(new BanDefinition("2 hours", 2));
                _SafeStr_11912.push(new BanDefinition("4 hours", 4));
                _SafeStr_11912.push(new BanDefinition("12 hours", 12));
                _SafeStr_11912.push(new BanDefinition("24 hours", 24));
                _SafeStr_11912.push(new BanDefinition("2 days", 48));
                _SafeStr_11912.push(new BanDefinition("3 days", 72));
                _SafeStr_11912.push(new BanDefinition("1 week", 168));
                _SafeStr_11912.push(new BanDefinition("2 weeks", 336));
                _SafeStr_11912.push(new BanDefinition("3 weeks", 504));
                _SafeStr_11912.push(new BanDefinition("1 month", 720));
                _SafeStr_11912.push(new BanDefinition("2 months", 1440));
                _SafeStr_11912.push(new BanDefinition("1 year", 8760));
                _SafeStr_11912.push(new BanDefinition("2 years", 17520));
                _SafeStr_11912.push(new BanDefinition("Permanent", 100000));
            };
            this._SafeStr_11916 = IButtonWindow(this._help.getXmlWindow("modact_offence"));
            this._SafeStr_11917 = IButtonWindow(this._help.getXmlWindow("modact_offencectg"));
        }
        public static function hideChildren(_arg_1:IWindowContainer):void
        {
            var _local_2:int;
            while (_local_2 < _arg_1.numChildren) {
                _arg_1.getChildAt(_local_2).visible = false;
                _local_2++;
            };
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function show():void
        {
            this._frame = IFrameWindow(this._help.getXmlWindow("modact_summary"));
            this._frame.caption = ("Mod action on: " + this._id);
            this._frame.findChildByName("send_caution_but").procedure = this.onSendCautionButton;
            this._frame.findChildByName("kick_but").procedure = this.onKickButton;
            this._frame.findChildByName("ban_but").procedure = this.onBanButton;
            this._frame.findChildByName("change_categorization_but").procedure = this.onChangeCategorizationButton;
            this._help.disableButton(this._help.initMsg.alertPermission, this._frame, "send_caution_but");
            this._help.disableButton(this._help.initMsg.kickPermission, this._frame, "kick_but");
            this._help.disableButton(this._help.initMsg.banPermission, this._frame, "ban_but");
            this._SafeStr_11823 = ITextFieldWindow(this._frame.findChildByName("message_input"));
            this._SafeStr_11823.procedure = this.onInputClick;
            this._SafeStr_11913 = IDropMenuWindow(this._frame.findChildByName("banLengthSelect"));
            this.prepareBanSelect(this._SafeStr_11913);
            var _local_1:IWindow = this._frame.findChildByTag("close");
            _local_1.procedure = this.onClose;
            this.refreshCategorization();
            this._frame.visible = true;
        }
        public function refreshCategorization():void
        {
            var _local_1:IWindowContainer = IWindowContainer(this._frame.findChildByName("categorization_cont"));
            hideChildren(_local_1);
            _local_1.findChildByName("categorization_caption_txt").visible = true;
            _local_1.findChildByName("change_categorization_but").visible = !((this._SafeStr_11914 == null));
            if (this._SafeStr_11915 != null){
                this._frame.findChildByName("offence_txt").caption = this._SafeStr_11915.name;
                this._frame.findChildByName("offence_category").visible = true;
            }
            else {
                if (this._SafeStr_11914 != null){
                    this.refreshButtons("offences_cont", 2, this._SafeStr_11914.offences, this._SafeStr_11916, this.onOffenceButton);
                }
                else {
                    this.refreshButtons("offence_categories_cont", 3, this._help.initMsg.offenceCategories, this._SafeStr_11917, this.onOffenceCtgButton);
                    _local_1.height = RoomToolCtrl.getLowestPoint(_local_1);
                };
            };
        }
        private function refreshButtons(_arg_1:String, _arg_2:int, _arg_3:Array, _arg_4:IWindow, _arg_5:Function):void
        {
            var _local_11:INamed;
            var _local_12:String;
            var _local_13:IButtonWindow;
            var _local_6:IWindowContainer = IWindowContainer(this._frame.findChildByName(_arg_1));
            hideChildren(_local_6);
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_10:int = 5;
            for each (_local_11 in _arg_3) {
                _local_12 = ("" + _local_7);
                _local_13 = IButtonWindow(_local_6.findChildByName(_local_12));
                if (_local_13 == null){
                    _local_13 = IButtonWindow(_arg_4.clone());
                    _local_13.procedure = _arg_5;
                    _local_13.x = (_local_9 * (_arg_4.width + _local_10));
                    _local_13.y = (_local_8 * (_arg_4.height + _local_10));
                    _local_13.name = _local_12;
                    _local_6.addChild(_local_13);
                };
                _local_13.caption = _local_11.name;
                _local_13.visible = true;
                _local_7++;
                if (++_local_9 >= _arg_2){
                    _local_9 = 0;
                    _local_8++;
                };
            };
            _local_6.height = RoomToolCtrl.getLowestPoint(_local_6);
            _local_6.visible = true;
        }
        public function getType():int
        {
            return (WindowTracker._SafeStr_11796);
        }
        public function getId():String
        {
            return (this._id);
        }
        public function getFrame():IFrameWindow
        {
            return (this._frame);
        }
        private function prepareBanSelect(_arg_1:IDropMenuWindow):void
        {
            var _local_3:BanDefinition;
            var _local_2:Array = new Array();
            for each (_local_3 in _SafeStr_11912) {
                _local_2.push(_local_3.name);
            };
            _arg_1.populate(_local_2);
        }
        private function onSendCautionButton(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            Logger.log("Sending caution...");
            if (!this.isMsgGiven()){
                return;
            };
            this._help.connection.send(new ModAlertMessageComposer(this._SafeStr_11909, this._SafeStr_11823.text, this._SafeStr_11848));
            this.dispose();
        }
        private function onOffenceCtgButton(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            var _local_3:int = int(_arg_2.name);
            this._SafeStr_11914 = this._help.initMsg.offenceCategories[_local_3];
            this.refreshCategorization();
        }
        private function onOffenceButton(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            var _local_3:int = int(_arg_2.name);
            this._SafeStr_11915 = this._SafeStr_11914.offences[_local_3];
            this._SafeStr_11823.text = this._SafeStr_11915.msg;
            this._SafeStr_11824 = false;
            this.refreshCategorization();
        }
        private function onChangeCategorizationButton(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            if (this._SafeStr_11915 != null){
                this._SafeStr_11915 = null;
            }
            else {
                this._SafeStr_11914 = null;
            };
            this.refreshCategorization();
        }
        private function onKickButton(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            Logger.log("Kick...");
            if (!this.isMsgGiven()){
                return;
            };
            this._help.connection.send(new ModKickMessageComposer(this._SafeStr_11909, this._SafeStr_11823.text, this._SafeStr_11848));
            this.dispose();
        }
        private function onBanButton(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            Logger.log("Ban...");
            if (!this.isMsgGiven()){
                return;
            };
            if (this._SafeStr_11913.selection < 0){
                this._help.windowManager.alert("Alert", "You must select ban lenght", 0, this.onAlertClose);
                return;
            };
            this._help.connection.send(new ModBanMessageComposer(this._SafeStr_11909, this._SafeStr_11823.text, this.getBanLength(), this._SafeStr_11848));
            this.dispose();
        }
        private function isMsgGiven():Boolean
        {
            if (((this._SafeStr_11824) || ((this._SafeStr_11823.text == "")))){
                this._help.windowManager.alert("Alert", "You must input a message to the user", 0, this.onAlertClose);
                return (false);
            };
            return (true);
        }
        private function getBanLength():int
        {
            var _local_1:int = this._SafeStr_11913.selection;
            var _local_2:BanDefinition = _SafeStr_11912[_local_1];
            return (_local_2.banLengthHours);
        }
        private function onClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this.dispose();
        }
        private function onInputClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowEvent.WE_FOCUSED){
                return;
            };
            if (!this._SafeStr_11824){
                return;
            };
            this._SafeStr_11823.text = "";
            this._SafeStr_11824 = false;
        }
        public function dispose():void
        {
            if (this._disposed){
                return;
            };
            this._disposed = true;
            if (this._frame != null){
                this._frame.destroy();
                this._frame = null;
            };
            if (this._SafeStr_11916 != null){
                this._SafeStr_11916.destroy();
                this._SafeStr_11916 = null;
            };
            if (this._SafeStr_11917 != null){
                this._SafeStr_11917.destroy();
                this._SafeStr_11917 = null;
            };
            this._SafeStr_11913 = null;
            this._SafeStr_11823 = null;
            this._help = null;
        }
        private function onAlertClose(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
        }

    }
}//package com.sulake.habbo.moderation

// _help = "_-3HG" (String#114, DoABC#2)
// onAlertClose = "_-34G" (String#309, DoABC#2)
// disableButton = "_-24c" (String#19207, DoABC#2)
// initMsg = "_-MD" (String#23092, DoABC#2)
// _SafeStr_11796 = "_-3FI" (String#22088, DoABC#2)
// _SafeStr_11823 = "_-2AA" (String#1824, DoABC#2)
// _SafeStr_11824 = "_-0s6" (String#824, DoABC#2)
// onInputClick = "_-2zA" (String#907, DoABC#2)
// _SafeStr_11848 = "_-2-7" (String#1795, DoABC#2)
// _SafeStr_11909 = "_-1OJ" (String#5319, DoABC#2)
// _id = "_-US" (String#8292, DoABC#2)
// _SafeStr_11912 = "_-12V" (String#16559, DoABC#2)
// _SafeStr_11913 = "_-0Pg" (String#15049, DoABC#2)
// _SafeStr_11914 = "_-EY" (String#22794, DoABC#2)
// _SafeStr_11915 = "_-1EP" (String#17043, DoABC#2)
// _SafeStr_11916 = "_-1tC" (String#18687, DoABC#2)
// _SafeStr_11917 = "_-35T" (String#21712, DoABC#2)
// onSendCautionButton = "_-11j" (String#16527, DoABC#2)
// onKickButton = "_-0VA" (String#15250, DoABC#2)
// onBanButton = "_-2hh" (String#20761, DoABC#2)
// onChangeCategorizationButton = "_-2s3" (String#21160, DoABC#2)
// prepareBanSelect = "_-15c" (String#16680, DoABC#2)
// refreshCategorization = "_-1wx" (String#18843, DoABC#2)
// onOffenceButton = "_-0oX" (String#15995, DoABC#2)
// onOffenceCtgButton = "_-03k" (String#14192, DoABC#2)
// isMsgGiven = "_-2x3" (String#21351, DoABC#2)
// getBanLength = "_-23Q" (String#19150, DoABC#2)
// banLengthHours = "_-2Mb" (String#19911, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// ITextFieldWindow = "_-3EL" (String#2027, DoABC#2)
// IDropMenuWindow = "_-4Z" (String#2049, DoABC#2)
// WindowTracker = "_-2m9" (String#7008, DoABC#2)
// ModBanMessageComposer = "_-2u0" (String#21238, DoABC#2)
// ModAlertMessageComposer = "_-Yq" (String#23593, DoABC#2)
// ModKickMessageComposer = "_-2TW" (String#20182, DoABC#2)
// TrackedWindow = "_-Xp" (String#8365, DoABC#2)
// RoomToolCtrl = "_-0Tu" (String#4178, DoABC#2)
// INamed = "_-11E" (String#4899, DoABC#2)
// OffenceCategoryData = "_-10g" (String#4888, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// ModActionCtrl = "_-0HN" (String#3902, DoABC#2)
// OffenceData = "_-10e" (String#4886, DoABC#2)
// BanDefinition = "_-177" (String#5019, DoABC#2)
// hideChildren = "_-14q" (String#1615, DoABC#2)
// getLowestPoint = "_-0t0" (String#16161, DoABC#2)
// getFrame = "_-3Jk" (String#923, DoABC#2)
// onClose = "_-2Ts" (String#54, DoABC#2)
// WE_FOCUSED = "_-1ay" (String#17932, DoABC#2)
// offences = "_-2-3" (String#18973, DoABC#2)
// msg = "_-1Bo" (String#16933, DoABC#2)
// destroy = "_-25R" (String#615, DoABC#2)
// offenceCategories = "_-sF" (String#24370, DoABC#2)
// alertPermission = "_-1B8" (String#16904, DoABC#2)
// kickPermission = "_-0-P" (String#14029, DoABC#2)
// banPermission = "_-1Gj" (String#17141, DoABC#2)
// refreshButtons = "_-1ep" (String#859, DoABC#2)


