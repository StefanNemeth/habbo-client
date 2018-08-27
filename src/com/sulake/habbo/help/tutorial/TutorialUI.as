
package com.sulake.habbo.help.tutorial
{
    import com.sulake.habbo.help.INameChangeUI;
    import com.sulake.habbo.help.HabboHelp;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.help.enum.HabboHelpTutorialEvent;
    import com.sulake.habbo.session.events.HabboSessionFigureUpdatedEvent;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.communication.messages.outgoing.avatar.ChangeUserNameMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.avatar.CheckUserNameMessageComposer;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.habbo.communication.messages.parser.avatar.ChangeUserNameResultMessageParser;
    import com.sulake.habbo.communication.messages.incoming.avatar.ChangeUserNameResultMessageEvent;
    import com.sulake.habbo.communication.messages.parser.avatar.CheckUserNameResultMessageParser;
    import com.sulake.habbo.communication.messages.incoming.avatar.CheckUserNameResultMessageEvent;

    public class TutorialUI implements INameChangeUI 
    {

        public static const TUI_MAIN_VIEW:String = "TUI_MAIN_VIEW";
        public static const TUI_NAME_VIEW:String = "TUI_NAME_VIEW";
        public static const TUI_CLOTHES_VIEW:String = "TUI_CLOTHES_VIEW";
        public static const TUI_GUIDEBOT_VIEW:String = "TUI_GUIDEBOT_VIEW";

        private var _SafeStr_11397:int = 0;
        private var _SafeStr_11398:int = 0;
        private var _help:HabboHelp;
        private var _window:IFrameWindow;
        private var _SafeStr_3864:ITutorialUIView;
        private var _SafeStr_11445:NameChangeView;
        private var _hasChangedLooks:Boolean = false;
        private var _hasChangedName:Boolean = false;
        private var _hasCalledGuideBot:Boolean = false;
        private var _SafeStr_11446:Boolean = false;
        private var _SafeStr_11447:Boolean;

        public function TutorialUI(_arg_1:HabboHelp, _arg_2:Boolean=true)
        {
            this._help = _arg_1;
            this._SafeStr_11447 = _arg_2;
            this._help.events.addEventListener(HabboHelpTutorialEvent.HHTPNUFWE_DONE_GUIDEBOT, this.onTaskDoneEvent);
            this._help.events.addEventListener(HabboHelpTutorialEvent.HHTE_DONE_AVATAR_EDITOR_OPENING, this.onTaskDoneEvent);
            this._help.events.addEventListener(HabboHelpTutorialEvent.HHTE_DONE_AVATAR_EDITOR_CLOSING, this.onTaskDoneEvent);
            if (this._help.sessionDataManager != null){
                this._help.sessionDataManager.events.addEventListener(HabboSessionFigureUpdatedEvent.HABBO_SESSION_FIGURE_UPDATE, this.onFigureUpdate);
            };
        }
        public function get help():HabboHelp
        {
            return (this._help);
        }
        public function get assets():IAssetLibrary
        {
            return (this._help.assets);
        }
        public function get localization():IHabboLocalizationManager
        {
            return (this._help.localization);
        }
        public function get myName():String
        {
            return (this._help.ownUserName);
        }
        public function get hasTasksDone():Boolean
        {
            return (((((this._hasChangedLooks) && (this._hasChangedName))) && (this._hasCalledGuideBot)));
        }
        public function get hasChangedLooks():Boolean
        {
            return (this._hasChangedLooks);
        }
        public function get hasChangedName():Boolean
        {
            return (this._hasChangedName);
        }
        public function get hasCalledGuideBot():Boolean
        {
            return (this._hasCalledGuideBot);
        }
        public function dispose():void
        {
            this.disposeView();
            if (this._help){
                this._help.events.removeEventListener(HabboHelpTutorialEvent.HHTPNUFWE_DONE_GUIDEBOT, this.onTaskDoneEvent);
                this._help.events.removeEventListener(HabboHelpTutorialEvent.HHTE_DONE_AVATAR_EDITOR_OPENING, this.onTaskDoneEvent);
                this._help.events.removeEventListener(HabboHelpTutorialEvent.HHTE_DONE_AVATAR_EDITOR_CLOSING, this.onTaskDoneEvent);
                if (this._help.sessionDataManager != null){
                    this._help.sessionDataManager.events.removeEventListener(HabboSessionFigureUpdatedEvent.HABBO_SESSION_FIGURE_UPDATE, this.onFigureUpdate);
                };
                this._help = null;
            };
        }
        public function update(_arg_1:Boolean, _arg_2:Boolean, _arg_3:Boolean):void
        {
            this._hasChangedLooks = _arg_1;
            this._hasChangedName = _arg_2;
            this._hasCalledGuideBot = _arg_3;
            if ((((this._SafeStr_3864 == null)) || ((this._SafeStr_3864.id == TUI_MAIN_VIEW)))){
                this.prepareForTutorial();
                this.showView(TUI_MAIN_VIEW);
            };
        }
        public function onTaskDoneEvent(_arg_1:HabboHelpTutorialEvent):void
        {
            switch (_arg_1.type){
                case HabboHelpTutorialEvent.HHTPNUFWE_DONE_GUIDEBOT:
                    this._hasCalledGuideBot = true;
                    if (((!((this._SafeStr_3864 == null))) && ((this._SafeStr_3864.id == TUI_GUIDEBOT_VIEW)))){
                        this.showView(TUI_MAIN_VIEW);
                    };
                    return;
                case HabboHelpTutorialEvent.HHTE_DONE_AVATAR_EDITOR_OPENING:
                    if (((!((this._SafeStr_3864 == null))) && ((this._SafeStr_3864.id == TUI_CLOTHES_VIEW)))){
                        this._SafeStr_11446 = true;
                        this.disposeWindow();
                    };
                    return;
                case HabboHelpTutorialEvent.HHTE_DONE_AVATAR_EDITOR_CLOSING:
                    if (this._SafeStr_11446){
                        this._SafeStr_11446 = false;
                        this.showView(TUI_MAIN_VIEW);
                    };
                    return;
            };
        }
        public function showView(_arg_1:String):void
        {
            var _local_2:IItemListWindow;
            if (this.hasTasksDone){
                if (this._help){
                    this._help.removeTutorialUI();
                };
                return;
            };
            var _local_3:Boolean;
            if (this._window == null){
                this._window = (this.buildXmlWindow("tutorial_frame") as IFrameWindow);
                if (this._window == null){
                    return;
                };
                this._window.procedure = this.windowProcedure;
                _local_2 = (this._window.findChildByName("content_list") as IItemListWindow);
                if (_local_2 == null){
                    return;
                };
                this._SafeStr_11397 = (this._window.width - _local_2.width);
                this._SafeStr_11398 = this._window.height;
                _local_3 = true;
            };
            _local_2 = (this._window.findChildByName("content_list") as IItemListWindow);
            if (_local_2 == null){
                return;
            };
            _local_2.destroyListItems();
            _local_2.height = 0;
            if (this._SafeStr_3864 != null){
                this._SafeStr_3864.dispose();
            };
            this._window.visible = true;
            switch (_arg_1){
                case TUI_MAIN_VIEW:
                    if (this._SafeStr_11445 != null){
                        this._SafeStr_11445.dispose();
                    };
                    if (this._SafeStr_11447){
                        this._SafeStr_3864 = new TutorialMainView(_local_2, this);
                    }
                    else {
                        this._window.visible = false;
                        return;
                    };
                    break;
                case TUI_NAME_VIEW:
                    this._window.visible = false;
                    if (this._SafeStr_11445 == null){
                        this._SafeStr_11445 = new NameChangeView(this);
                    };
                    this._SafeStr_11445.showMainView();
                    this.prepareForTutorial();
                    break;
                case TUI_CLOTHES_VIEW:
                    this._SafeStr_3864 = new TutorialClothesChangeView(_local_2, this);
                    break;
                case TUI_GUIDEBOT_VIEW:
                    this._SafeStr_3864 = new TutorialCallGuideBotView(_local_2, this);
                    break;
            };
            this._window.height = (_local_2.height + this._SafeStr_11398);
            this._window.width = (_local_2.width + this._SafeStr_11397);
            if (_local_3){
                if (this._window == null){
                    return;
                };
                this._window.x = ((this._window.context.getDesktopWindow().width / 2) - (this._window.width / 2));
                this._window.y = 0;
            };
        }
        public function buildXmlWindow(_arg_1:String, _arg_2:uint=1):IWindow
        {
            if ((((this._help == null)) || ((this._help.assets == null)))){
                return (null);
            };
            var _local_3:XmlAsset = XmlAsset(this._help.assets.getAssetByName((_arg_1 + "_xml")));
            if ((((_local_3 == null)) || ((this._help.windowManager == null)))){
                return (null);
            };
            return (this._help.windowManager.buildFromXML(XML(_local_3.content), _arg_2));
        }
        private function disposeWindow(_arg_1:WindowEvent=null):void
        {
            if (this._window != null){
                this._window.dispose();
                this._window = null;
            };
        }
        private function disposeView():void
        {
            if (this._SafeStr_3864 != null){
                this._SafeStr_3864.dispose();
                this._SafeStr_3864 = null;
            };
            if (this._SafeStr_11445 != null){
                this._SafeStr_11445.dispose();
                this._SafeStr_11445 = null;
            };
            this.disposeWindow();
        }
        public function setRoomSessionStatus(_arg_1:Boolean):void
        {
            if (_arg_1 == false){
                this.disposeView();
            };
        }
        public function prepareForTutorial():void
        {
            if ((((this._help == null)) || ((this._help.events == null)))){
                return;
            };
            this._help.hideUI();
            this._help.events.dispatchEvent(new HabboHelpTutorialEvent(HabboHelpTutorialEvent.HHTPNUFWE_AE_STARTED));
        }
        public function windowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            switch (_arg_1.type){
                case WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK:
                    if (_arg_2.name == "header_button_close"){
                        this.disposeView();
                    };
                    return;
            };
        }
        public function changeName(_arg_1:String):void
        {
            this.disposeWindow();
            this._help.sendMessage(new ChangeUserNameMessageComposer(_arg_1));
        }
        public function checkName(_arg_1:String):void
        {
            this.disposeWindow();
            this._help.sendMessage(new CheckUserNameMessageComposer(_arg_1));
        }
        public function onUserNameChanged(name:String):void
        {
            if (((((!(this._help)) || (!(this._help.localization)))) || (!(this._help.windowManager)))){
                return;
            };
            this._hasChangedName = true;
            this._help.localization.registerParameter("help.tutorial.name.changed", "name", name);
            this._help.windowManager.alert("${generic.notice}", "${help.tutorial.name.changed}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
            {
                _arg_1.dispose();
            });
            if (((!((this._SafeStr_3864 == null))) && ((((this._SafeStr_3864.id == TUI_NAME_VIEW)) || ((this._SafeStr_3864.id == TUI_MAIN_VIEW)))))){
                this.showView(TUI_MAIN_VIEW);
            };
        }
        private function onFigureUpdate(_arg_1:HabboSessionFigureUpdatedEvent):void
        {
            var _local_2:Boolean;
            if ((((this._help == null)) || ((_arg_1 == null)))){
                return;
            };
            if (!this._hasChangedLooks){
                if (this._help.sessionDataManager != null){
                    _local_2 = (_arg_1.userId == this._help.sessionDataManager.userId);
                    if (_local_2){
                        this._help.sessionDataManager.events.removeEventListener(HabboSessionFigureUpdatedEvent.HABBO_SESSION_FIGURE_UPDATE, this.onFigureUpdate);
                        this.onUserChanged();
                    };
                };
            };
        }
        public function onUserChanged():void
        {
            this._hasChangedLooks = true;
            if (((!((this._SafeStr_3864 == null))) && ((((this._SafeStr_3864.id == TUI_CLOTHES_VIEW)) || ((this._SafeStr_3864.id == TUI_MAIN_VIEW)))))){
                this.showView(TUI_MAIN_VIEW);
            };
        }
        public function onChangeUserNameResult(_arg_1:ChangeUserNameResultMessageEvent):void
        {
            if (_arg_1 == null){
                return;
            };
            var _local_2:ChangeUserNameResultMessageParser = _arg_1.getParser();
            if (_local_2.resultCode == ChangeUserNameResultMessageEvent._SafeStr_7096){
                this._hasChangedName = true;
                this.showView(TutorialUI.TUI_MAIN_VIEW);
            }
            else {
                this._SafeStr_11445.setNameNotAvailableView(_local_2.resultCode, _local_2.name, _local_2.nameSuggestions);
            };
        }
        public function onCheckUserNameResult(_arg_1:CheckUserNameResultMessageEvent):void
        {
            if (!_arg_1){
                return;
            };
            var _local_2:CheckUserNameResultMessageParser = _arg_1.getParser();
            if (_local_2.resultCode == ChangeUserNameResultMessageEvent._SafeStr_7096){
                this._SafeStr_11445.checkedName = _local_2.name;
            }
            else {
                this._SafeStr_11445.setNameNotAvailableView(_local_2.resultCode, _local_2.name, _local_2.nameSuggestions);
            };
        }

    }
}//package com.sulake.habbo.help.tutorial

// _help = "_-3HG" (String#114, DoABC#2)
// _SafeStr_11397 = "_-1Dk" (String#5138, DoABC#2)
// _SafeStr_11398 = "_-2Is" (String#6418, DoABC#2)
// setRoomSessionStatus = "_-lP" (String#24084, DoABC#2)
// showMainView = "_-2pt" (String#21077, DoABC#2)
// changeName = "_-0uN" (String#4733, DoABC#2)
// checkName = "_-2Fe" (String#6356, DoABC#2)
// onUserNameChanged = "_-dO" (String#23776, DoABC#2)
// onChangeUserNameResult = "_-06v" (String#1405, DoABC#2)
// setNameNotAvailableView = "_-oP" (String#24210, DoABC#2)
// onCheckUserNameResult = "_-2F9" (String#6344, DoABC#2)
// checkedName = "_-11W" (String#16518, DoABC#2)
// myName = "_-0Kp" (String#3971, DoABC#2)
// ownUserName = "_-19l" (String#16846, DoABC#2)
// TUI_NAME_VIEW = "_-146" (String#16621, DoABC#2)
// disposeWindow = "_-0-u" (String#804, DoABC#2)
// TUI_MAIN_VIEW = "_-0CO" (String#14545, DoABC#2)
// TUI_CLOTHES_VIEW = "_-2a" (String#20440, DoABC#2)
// TUI_GUIDEBOT_VIEW = "_-0n" (String#15938, DoABC#2)
// _SafeStr_11445 = "_-2rA" (String#21125, DoABC#2)
// _SafeStr_11446 = "_-0Dg" (String#14595, DoABC#2)
// _SafeStr_11447 = "_-0M6" (String#14919, DoABC#2)
// onTaskDoneEvent = "_-02Y" (String#14144, DoABC#2)
// help = "_-01v" (String#14125, DoABC#2)
// hasTasksDone = "_-h0" (String#23931, DoABC#2)
// prepareForTutorial = "_-0Yl" (String#15390, DoABC#2)
// removeTutorialUI = "_-0JO" (String#14817, DoABC#2)
// windowProcedure = "_-1tK" (String#869, DoABC#2)
// onUserChanged = "_-0NZ" (String#14975, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// INameChangeUI = "_-34B" (String#7392, DoABC#2)
// TutorialUI = "_-38o" (String#7488, DoABC#2)
// ChangeUserNameResultMessageParser = "_-9" (String#22578, DoABC#2)
// ChangeUserNameResultMessageEvent = "_-3HW" (String#22180, DoABC#2)
// HabboSessionFigureUpdatedEvent = "_-1Yz" (String#17851, DoABC#2)
// HabboHelpTutorialEvent = "_-TD" (String#23373, DoABC#2)
// CheckUserNameResultMessageEvent = "_-2Tb" (String#20186, DoABC#2)
// ChangeUserNameMessageComposer = "_-05J" (String#14256, DoABC#2)
// CheckUserNameResultMessageParser = "_-15d" (String#4988, DoABC#2)
// CheckUserNameMessageComposer = "_-pJ" (String#24245, DoABC#2)
// ITutorialUIView = "_-2tN" (String#7145, DoABC#2)
// TutorialCallGuideBotView = "_-Ob" (String#8175, DoABC#2)
// TutorialClothesChangeView = "_-dF" (String#8473, DoABC#2)
// TutorialMainView = "_-yd" (String#8850, DoABC#2)
// NameChangeView = "_-2AW" (String#6255, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// _SafeStr_3864 = "_-2-T" (String#446, DoABC#2)
// HHTPNUFWE_AE_STARTED = "_-0Le" (String#14899, DoABC#2)
// HABBO_SESSION_FIGURE_UPDATE = "_-0yO" (String#16368, DoABC#2)
// sessionDataManager = "_-0pX" (String#4623, DoABC#2)
// destroyListItems = "_-0xF" (String#4796, DoABC#2)
// _SafeStr_7096 = "_-OP" (String#23184, DoABC#2)
// onFigureUpdate = "_-2uZ" (String#1961, DoABC#2)
// HHTE_DONE_AVATAR_EDITOR_OPENING = "_-2Gq" (String#19675, DoABC#2)
// HHTE_DONE_AVATAR_EDITOR_CLOSING = "_-0NU" (String#14972, DoABC#2)
// hasChangedName = "_-33G" (String#7371, DoABC#2)
// HHTPNUFWE_DONE_GUIDEBOT = "_-2lW" (String#20900, DoABC#2)
// _hasChangedLooks = "_-01Z" (String#3593, DoABC#2)
// _hasChangedName = "_-0FH" (String#3858, DoABC#2)
// _hasCalledGuideBot = "_-19F" (String#5062, DoABC#2)
// hasChangedLooks = "_-32V" (String#21597, DoABC#2)
// hasCalledGuideBot = "_-l6" (String#24074, DoABC#2)
// showView = "_-1gE" (String#860, DoABC#2)
// disposeView = "_-jU" (String#2169, DoABC#2)
// resultCode = "_-09c" (String#14431, DoABC#2)
// nameSuggestions = "_-2Cy" (String#19520, DoABC#2)


