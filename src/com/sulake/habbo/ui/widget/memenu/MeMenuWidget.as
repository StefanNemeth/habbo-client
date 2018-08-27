
package com.sulake.habbo.ui.widget.memenu
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import flash.geom.Point;
    import com.sulake.core.window.IWindowContainer;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import flash.external.ExternalInterface;
    import com.sulake.habbo.ui.handler.MeMenuWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.IAsset;
    import flash.events.Event;
    import com.sulake.habbo.ui.widget.memenu.enum.HabboMeMenuTrackingEvent;
    import flash.geom.Rectangle;
    import com.sulake.habbo.ui.widget.events.RoomWidgetWaveUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetDanceUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEffectsUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetToolbarClickedUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetAvatarEditorUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetHabboClubUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetSettingsUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetTutorialEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPurseUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomEngineUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMeMenuMessage;
    import com.sulake.habbo.utils.WindowToggle;

    public class MeMenuWidget extends RoomWidgetBase 
    {

        public static const _SafeStr_3858:String = "me_menu_top_view";
        public static const _SafeStr_3859:String = "me_menu_my_clothes_view";
        public static const _SafeStr_3860:String = "me_menu_dance_moves_view";
        public static const _SafeStr_3861:String = "me_menu_settings_view";
        public static const _SafeStr_3862:String = "me_menu_sound_settings";
        private static const _SafeStr_3863:Point = new Point(95, 440);

        private var _SafeStr_3864:IMeMenuView;
        private var _mainWindow:IWindowContainer;
        private var _eventDispatcher:IEventDispatcher;
        private var _habboClubDays:int = 0;
        private var _habboClubPeriods:int = 0;
        private var _SafeStr_3868:int = 0;
        private var _allowHabboClubDances:Boolean = false;
        private var _habboClubLevel:int = 0;
        private var _hasEffectOn:Boolean = false;
        private var _isDancing:Boolean = false;
        private var _isActive:Boolean = false;
        private var _isNewsEnabled:Boolean = false;
        private var _SafeStr_3875:int = 0;
        private var _SafeStr_3876:Boolean = false;
        private var _config:IHabboConfigurationManager;
        private var _SafeStr_3877:Boolean;

        public function MeMenuWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager, _arg_5:IEventDispatcher, _arg_6:IHabboConfigurationManager)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            this._config = _arg_6;
            this._eventDispatcher = _arg_5;
            if (ExternalInterface.available){
                this._isNewsEnabled = _arg_6.getBoolean("client.news.embed.enabled", false);
            };
            this._SafeStr_3877 = this._config.getBoolean("menu.own_avatar.enabled", false);
            (_arg_1 as MeMenuWidgetHandler).widget = this;
            this.changeView(_SafeStr_3858);
            this.hide();
        }
        override public function dispose():void
        {
            if (disposed){
                return;
            };
            this.hide();
            this._eventDispatcher = null;
            if (this._SafeStr_3864 != null){
                this._SafeStr_3864.dispose();
                this._SafeStr_3864 = null;
            };
            this._mainWindow = null;
            this._config = null;
            super.dispose();
        }
        public function get handler():MeMenuWidgetHandler
        {
            return ((_handler as MeMenuWidgetHandler));
        }
        override public function get mainWindow():IWindow
        {
            return (this._mainWindow);
        }
        private function get mainContainer():IWindowContainer
        {
            var _local_1:IAsset;
            if (this._mainWindow == null){
                _local_1 = _assets.getAssetByName("memenu");
                if (_local_1){
                    this._mainWindow = (windowManager.buildFromXML((_local_1.content as XML)) as IWindowContainer);
                };
            };
            if (this._mainWindow){
                return ((this._mainWindow.findChildByTag("MAIN_CONTENT") as IWindowContainer));
            };
            return (null);
        }
        public function changeView(_arg_1:String):void
        {
            var _local_2:IMeMenuView;
            switch (_arg_1){
                case _SafeStr_3858:
                    _local_2 = new MeMenuMainView();
                    this._eventDispatcher.dispatchEvent(new Event(HabboMeMenuTrackingEvent.HABBO_MEMENU_TRACKING_EVENT_DEFAULT));
                    break;
                case _SafeStr_3860:
                    _local_2 = new MeMenuDanceView();
                    this._eventDispatcher.dispatchEvent(new Event(HabboMeMenuTrackingEvent.HABBO_MEMENU_TRACKING_EVENT_DANCE));
                    break;
                case _SafeStr_3861:
                    _local_2 = new MeMenuSettingsMenuView();
                    break;
                case _SafeStr_3862:
                    _local_2 = new MeMenuSoundSettingsView();
                    break;
                default:
                    Logger.log(("Me Menu Change view: unknown view: " + _arg_1));
            };
            if (_local_2 != null){
                if (this._SafeStr_3864){
                    this._SafeStr_3864.dispose();
                    this._SafeStr_3864 = null;
                };
                this._SafeStr_3864 = _local_2;
                this._SafeStr_3864.init(this, _arg_1);
                this.mainContainer.removeChildAt(0);
                this.mainContainer.addChildAt(this._SafeStr_3864.window, 0);
                this._mainWindow.visible = true;
                this._mainWindow.activate();
            };
            this.updateSize();
        }
        public function updateSize():void
        {
            var _local_1:int;
            var _local_2:Rectangle;
            if (((((this._SafeStr_3864) && (this._SafeStr_3864.window))) && (this._mainWindow))){
                _local_1 = 5;
                this._SafeStr_3864.window.position = new Point(_local_1, _local_1);
                this.mainContainer.width = (this._SafeStr_3864.window.width + (_local_1 * 2));
                this.mainContainer.height = (this._SafeStr_3864.window.height + (_local_1 * 2));
                if (((((((this._config.getBoolean("simple.memenu.enabled", false)) && (this.handler))) && (this.handler.container))) && (this.handler.container.toolbar))){
                    _local_2 = this.handler.container.toolbar.getRect();
                    this._mainWindow.x = (_local_2.right + _local_1);
                    this._mainWindow.y = (_local_2.bottom - this._mainWindow.height);
                }
                else {
                    this._mainWindow.x = _SafeStr_3863.x;
                    this._mainWindow.y = (_SafeStr_3863.y - this.mainContainer.height);
                };
            };
        }
        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.addEventListener(RoomWidgetWaveUpdateEvent.RWUE_WAVE, this.onWaveEvent);
            _arg_1.addEventListener(RoomWidgetDanceUpdateEvent.RWUE_DANCE, this.onDanceEvent);
            _arg_1.addEventListener(RoomWidgetUpdateEffectsUpdateEvent.RWUEUE_UPDATE_EFFECTS, this.onUpdateEffects);
            _arg_1.addEventListener(RoomWidgetToolbarClickedUpdateEvent.RWUE_REQUEST_ME_MENU_TOOLBAR_CLICKED, this.onToolbarClicked);
            _arg_1.addEventListener(RoomWidgetAvatarEditorUpdateEvent.RWUE_AVATAR_EDITOR_CLOSED, this.onAvatarEditorClosed);
            _arg_1.addEventListener(RoomWidgetAvatarEditorUpdateEvent.RWUE_HIDE_AVATAR_EDITOR, this.onHideAvatarEditor);
            _arg_1.addEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_OBJECT_DESELECTED, this.onAvatarDeselected);
            _arg_1.addEventListener(RoomWidgetHabboClubUpdateEvent.RWBIUE_HABBO_CLUB, this.onHabboClubEvent);
            _arg_1.addEventListener(RoomWidgetUserInfoUpdateEvent.RWUIUE_OWN_USER, this.onUserInfo);
            _arg_1.addEventListener(RoomWidgetSettingsUpdateEvent.RWSUE_SETTINGS, this.onSettingsUpdate);
            _arg_1.addEventListener(RoomWidgetTutorialEvent.HHTPNUFWE_AE_STARTED, this.onTutorialEvent);
            _arg_1.addEventListener(RoomWidgetTutorialEvent.HHTPNUFWE_AE_HIGHLIGHT, this.onTutorialEvent);
            _arg_1.addEventListener(RoomWidgetPurseUpdateEvent.RWPUE_CREDIT_BALANCE, this.onCreditBalance);
            _arg_1.addEventListener(RoomWidgetRoomEngineUpdateEvent.RWREUE_NORMAL_MODE, this.onNormalMode);
            _arg_1.addEventListener(RoomWidgetRoomEngineUpdateEvent._SafeStr_3911, this.onGameMode);
            super.registerUpdateEvents(_arg_1);
        }
        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.removeEventListener(RoomWidgetWaveUpdateEvent.RWUE_WAVE, this.onWaveEvent);
            _arg_1.removeEventListener(RoomWidgetDanceUpdateEvent.RWUE_DANCE, this.onDanceEvent);
            _arg_1.removeEventListener(RoomWidgetUpdateEffectsUpdateEvent.RWUEUE_UPDATE_EFFECTS, this.onUpdateEffects);
            _arg_1.removeEventListener(RoomWidgetToolbarClickedUpdateEvent.RWUE_REQUEST_ME_MENU_TOOLBAR_CLICKED, this.onToolbarClicked);
            _arg_1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_OBJECT_DESELECTED, this.onAvatarDeselected);
            _arg_1.removeEventListener(RoomWidgetHabboClubUpdateEvent.RWBIUE_HABBO_CLUB, this.onHabboClubEvent);
            _arg_1.removeEventListener(RoomWidgetAvatarEditorUpdateEvent.RWUE_AVATAR_EDITOR_CLOSED, this.onHideAvatarEditor);
            _arg_1.removeEventListener(RoomWidgetAvatarEditorUpdateEvent.RWUE_HIDE_AVATAR_EDITOR, this.onAvatarEditorClosed);
            _arg_1.removeEventListener(RoomWidgetUserInfoUpdateEvent.RWUIUE_OWN_USER, this.onUserInfo);
            _arg_1.removeEventListener(RoomWidgetSettingsUpdateEvent.RWSUE_SETTINGS, this.onSettingsUpdate);
            _arg_1.removeEventListener(RoomWidgetTutorialEvent.HHTPNUFWE_AE_HIGHLIGHT, this.onTutorialEvent);
            _arg_1.removeEventListener(RoomWidgetTutorialEvent.HHTPNUFWE_AE_STARTED, this.onTutorialEvent);
            _arg_1.removeEventListener(RoomWidgetPurseUpdateEvent.RWPUE_CREDIT_BALANCE, this.onCreditBalance);
            _arg_1.removeEventListener(RoomWidgetRoomEngineUpdateEvent.RWREUE_NORMAL_MODE, this.onNormalMode);
            _arg_1.removeEventListener(RoomWidgetRoomEngineUpdateEvent.RWREUE_NORMAL_MODE, this.onGameMode);
        }
        public function hide(_arg_1:RoomWidgetRoomObjectUpdateEvent=null):void
        {
            if (this._SafeStr_3864 != null){
                this._mainWindow.removeChild(this._SafeStr_3864.window);
                this._SafeStr_3864.dispose();
                this._SafeStr_3864 = null;
            };
            this._mainWindow.visible = false;
            this._isActive = false;
            this._eventDispatcher.dispatchEvent(new Event(HabboMeMenuTrackingEvent.HABBO_MEMENU_TRACKING_EVENT_CLOSE));
        }
        private function onUserInfo(_arg_1:RoomWidgetUserInfoUpdateEvent):void
        {
            var _local_2:RoomWidgetRequestWidgetMessage;
            if (this._SafeStr_3877){
                return;
            };
            if (!((this._isActive) && ((this._SafeStr_3864.window.name == _SafeStr_3859)))){
                _local_2 = new RoomWidgetRequestWidgetMessage(RoomWidgetRequestWidgetMessage.RWRWM_ME_MENU);
                if (messageListener != null){
                    if (!this._SafeStr_3876){
                        messageListener.processWidgetMessage(_local_2);
                    };
                };
            };
        }
        private function onSettingsUpdate(_arg_1:RoomWidgetSettingsUpdateEvent):void
        {
            if (!this._isActive){
                return;
            };
            if (this._SafeStr_3864.window.name == _SafeStr_3862){
                (this._SafeStr_3864 as MeMenuSoundSettingsView).updateSettings(_arg_1);
            };
        }
        private function onTutorialEvent(_arg_1:RoomWidgetTutorialEvent):void
        {
            switch (_arg_1.type){
                case RoomWidgetTutorialEvent.HHTPNUFWE_AE_HIGHLIGHT:
                    Logger.log(((("* MeMenuWidget: onHighlightClothesIcon " + this._isActive) + " view: ") + this._SafeStr_3864.window.name));
                    if (((!((this._isActive == true))) || (!((this._SafeStr_3864.window.name == _SafeStr_3858))))){
                        return;
                    };
                    (this._SafeStr_3864 as MeMenuMainView).setIconAssets("clothes_icon", _SafeStr_3858, "clothes_highlighter_blue");
                    return;
                case RoomWidgetTutorialEvent.HHTPNUFWE_AE_STARTED:
                    this.hide();
                    return;
            };
        }
        private function onToolbarClicked(_arg_1:RoomWidgetToolbarClickedUpdateEvent):void
        {
            var _local_2:RoomWidgetMeMenuMessage;
            if (this._isActive){
                if (((!((this._mainWindow == null))) && (WindowToggle.isHiddenByOtherWindows(this._mainWindow)))){
                    this._mainWindow.activate();
                    return;
                };
                this._isActive = false;
            }
            else {
                this._isActive = true;
            };
            if (this._isActive){
                _local_2 = new RoomWidgetMeMenuMessage(RoomWidgetMeMenuMessage.RWMMM_MESSAGE_ME_MENU_OPENED);
                if (messageListener != null){
                    messageListener.processWidgetMessage(_local_2);
                };
                this.changeView(_SafeStr_3858);
            }
            else {
                this.hide();
            };
        }
        private function onUpdateEffects(_arg_1:RoomWidgetUpdateEffectsUpdateEvent):void
        {
            var _local_2:IWidgetAvatarEffect;
            this._hasEffectOn = false;
            for each (_local_2 in _arg_1.effects) {
                if (_local_2.isInUse){
                    this._hasEffectOn = true;
                };
            };
        }
        private function onAvatarDeselected(_arg_1:Event):void
        {
            if (((!((this._SafeStr_3864 == null))) && (!((this._SafeStr_3864.window.name == _SafeStr_3859))))){
                this.hide();
            };
        }
        private function onAvatarEditorClosed(_arg_1:RoomWidgetAvatarEditorUpdateEvent):void
        {
            if (((!((this._SafeStr_3864 == null))) && ((this._SafeStr_3864.window.name == _SafeStr_3859)))){
                this.changeView(_SafeStr_3858);
            };
        }
        private function onHideAvatarEditor(_arg_1:RoomWidgetAvatarEditorUpdateEvent):void
        {
            if (((!((this._SafeStr_3864 == null))) && ((this._SafeStr_3864.window.name == _SafeStr_3859)))){
                this.changeView(_SafeStr_3858);
            };
        }
        private function onWaveEvent(_arg_1:RoomWidgetWaveUpdateEvent):void
        {
            Logger.log("[MeMenuWidget] Wave Event received");
        }
        private function onDanceEvent(_arg_1:RoomWidgetDanceUpdateEvent):void
        {
            Logger.log(("[MeMenuWidget] Dance Event received, style: " + _arg_1.style));
        }
        private function onHabboClubEvent(_arg_1:RoomWidgetHabboClubUpdateEvent):void
        {
            var _local_2 = !((_arg_1.daysLeft == this._habboClubDays));
            this._habboClubDays = _arg_1.daysLeft;
            this._habboClubPeriods = _arg_1.periodsLeft;
            this._SafeStr_3868 = _arg_1.pastPeriods;
            this._allowHabboClubDances = _arg_1.allowClubDances;
            _local_2 = ((_local_2) || (!((_arg_1.clubLevel == this._habboClubLevel))));
            this._habboClubLevel = _arg_1.clubLevel;
            if (_local_2){
                if (this._SafeStr_3864 != null){
                    this.changeView(this._SafeStr_3864.window.name);
                };
            };
        }
        private function onCreditBalance(_arg_1:RoomWidgetPurseUpdateEvent):void
        {
            if (_arg_1 == null){
                return;
            };
            this._SafeStr_3875 = _arg_1.balance;
            localizations.registerParameter("widget.memenu.credits", "credits", this._SafeStr_3875.toString());
        }
        private function onNormalMode(_arg_1:RoomWidgetRoomEngineUpdateEvent):void
        {
            this._SafeStr_3876 = false;
        }
        private function onGameMode(_arg_1:RoomWidgetRoomEngineUpdateEvent):void
        {
            this._SafeStr_3876 = true;
        }
        public function get allowHabboClubDances():Boolean
        {
            return (this._allowHabboClubDances);
        }
        public function get isHabboClubActive():Boolean
        {
            return ((this._habboClubDays > 0));
        }
        public function get habboClubDays():int
        {
            return (this._habboClubDays);
        }
        public function get habboClubPeriods():int
        {
            return (this._habboClubPeriods);
        }
        public function get habboClubLevel():int
        {
            return (this._habboClubLevel);
        }
        public function get isNewsEnabled():Boolean
        {
            return (this._isNewsEnabled);
        }
        public function get config():IHabboConfigurationManager
        {
            return (this._config);
        }
        public function get hasEffectOn():Boolean
        {
            return (this._hasEffectOn);
        }
        public function get isDancing():Boolean
        {
            return (this._isDancing);
        }
        public function set isDancing(_arg_1:Boolean):void
        {
            this._isDancing = _arg_1;
        }

    }
}//package com.sulake.habbo.ui.widget.memenu

// WindowToggle = "_-1Ud" (String#17689, DoABC#2)
// RoomWidgetBase = "_-0eQ" (String#4398, DoABC#2)
// MeMenuWidget = "_-02H" (String#3610, DoABC#2)
// IWidgetAvatarEffect = "_-uw" (String#8782, DoABC#2)
// MeMenuWidgetHandler = "_-1dd" (String#5625, DoABC#2)
// RoomWidgetRoomEngineUpdateEvent = "_-x9" (String#8828, DoABC#2)
// RoomWidgetRoomObjectUpdateEvent = "_-37T" (String#7457, DoABC#2)
// RoomWidgetRequestWidgetMessage = "_-XQ" (String#8356, DoABC#2)
// RoomWidgetUserInfoUpdateEvent = "_-28z" (String#6226, DoABC#2)
// RoomWidgetToolbarClickedUpdateEvent = "_-2PS" (String#6551, DoABC#2)
// RoomWidgetSettingsUpdateEvent = "_-1WG" (String#5478, DoABC#2)
// RoomWidgetPurseUpdateEvent = "_-2mA" (String#7009, DoABC#2)
// RoomWidgetWaveUpdateEvent = "_-vs" (String#8802, DoABC#2)
// RoomWidgetTutorialEvent = "_-1LH" (String#5266, DoABC#2)
// IMeMenuView = "_-Y6" (String#8372, DoABC#2)
// MeMenuSettingsMenuView = "_-2G5" (String#6367, DoABC#2)
// MeMenuDanceView = "_-2OK" (String#6525, DoABC#2)
// RoomWidgetDanceUpdateEvent = "_-268" (String#6166, DoABC#2)
// MeMenuMainView = "_-1Jt" (String#5241, DoABC#2)
// MeMenuSoundSettingsView = "_-2Vd" (String#6676, DoABC#2)
// HabboMeMenuTrackingEvent = "_-23E" (String#6109, DoABC#2)
// RoomWidgetMeMenuMessage = "_-0Ow" (String#4069, DoABC#2)
// RoomWidgetHabboClubUpdateEvent = "_-2ZL" (String#6751, DoABC#2)
// RoomWidgetAvatarEditorUpdateEvent = "_-3AA" (String#7517, DoABC#2)
// RoomWidgetUpdateEffectsUpdateEvent = "_-14K" (String#4965, DoABC#2)
// RWRWM_ME_MENU = "_-2Ka" (String#19826, DoABC#2)
// RWMMM_MESSAGE_ME_MENU_OPENED = "_-1vk" (String#18787, DoABC#2)
// registerUpdateEvents = "_-1yD" (String#1787, DoABC#2)
// unregisterUpdateEvents = "_-0-c" (String#3556, DoABC#2)
// _SafeStr_3858 = "_-1Lr" (String#17351, DoABC#2)
// _SafeStr_3859 = "_-16B" (String#16704, DoABC#2)
// _SafeStr_3860 = "_-1SH" (String#17592, DoABC#2)
// _SafeStr_3861 = "_-1HH" (String#17161, DoABC#2)
// _SafeStr_3862 = "_-0X-" (String#15314, DoABC#2)
// _SafeStr_3863 = "_-27S" (String#19310, DoABC#2)
// _SafeStr_3864 = "_-2-T" (String#446, DoABC#2)
// _mainWindow = "_-1P" (String#361, DoABC#2)
// _habboClubDays = "_-PZ" (String#23229, DoABC#2)
// _habboClubPeriods = "_-Wm" (String#23516, DoABC#2)
// _SafeStr_3868 = "_-2K1" (String#19808, DoABC#2)
// _allowHabboClubDances = "_-2Fa" (String#19627, DoABC#2)
// _habboClubLevel = "_-39k" (String#21873, DoABC#2)
// _hasEffectOn = "_-1JW" (String#17258, DoABC#2)
// _isDancing = "_-38" (String#7470, DoABC#2)
// _isActive = "_-Aj" (String#929, DoABC#2)
// _isNewsEnabled = "_-1GB" (String#17123, DoABC#2)
// _SafeStr_3875 = "_-2Yd" (String#20382, DoABC#2)
// _SafeStr_3876 = "_-1T8" (String#5416, DoABC#2)
// _SafeStr_3877 = "_-I9" (String#8043, DoABC#2)
// widget = "_-1yo" (String#18920, DoABC#2)
// changeView = "_-0hX" (String#15729, DoABC#2)
// handler = "_-06s" (String#1404, DoABC#2)
// _handler = "_-1Eb" (String#5153, DoABC#2)
// mainWindow = "_-2Lh" (String#1862, DoABC#2)
// updateSize = "_-26C" (String#19262, DoABC#2)
// RWUE_WAVE = "_-1aK" (String#17909, DoABC#2)
// onWaveEvent = "_-1Hk" (String#17180, DoABC#2)
// RWUE_DANCE = "_-0kM" (String#15844, DoABC#2)
// onDanceEvent = "_-0cI" (String#15525, DoABC#2)
// RWUEUE_UPDATE_EFFECTS = "_-P2" (String#23208, DoABC#2)
// onUpdateEffects = "_-2xg" (String#21381, DoABC#2)
// RWUE_REQUEST_ME_MENU_TOOLBAR_CLICKED = "_-00F" (String#14065, DoABC#2)
// onToolbarClicked = "_-hN" (String#941, DoABC#2)
// RWUE_AVATAR_EDITOR_CLOSED = "_-pF" (String#24243, DoABC#2)
// onAvatarEditorClosed = "_-2ry" (String#21155, DoABC#2)
// RWUE_HIDE_AVATAR_EDITOR = "_-1kI" (String#18301, DoABC#2)
// onHideAvatarEditor = "_-1KR" (String#17292, DoABC#2)
// RWROUE_OBJECT_DESELECTED = "_-8G" (String#22552, DoABC#2)
// onAvatarDeselected = "_-yW" (String#24635, DoABC#2)
// RWBIUE_HABBO_CLUB = "_-0ji" (String#15815, DoABC#2)
// onHabboClubEvent = "_-2a7" (String#20446, DoABC#2)
// RWUIUE_OWN_USER = "_-13K" (String#16592, DoABC#2)
// onUserInfo = "_-2pH" (String#623, DoABC#2)
// RWSUE_SETTINGS = "_-HH" (String#22902, DoABC#2)
// onSettingsUpdate = "_-0jj" (String#15816, DoABC#2)
// HHTPNUFWE_AE_STARTED = "_-0Le" (String#14899, DoABC#2)
// onTutorialEvent = "_-1iG" (String#18219, DoABC#2)
// HHTPNUFWE_AE_HIGHLIGHT = "_-06p" (String#14317, DoABC#2)
// RWPUE_CREDIT_BALANCE = "_-31Q" (String#21556, DoABC#2)
// onCreditBalance = "_-2Mm" (String#886, DoABC#2)
// RWREUE_NORMAL_MODE = "_-w-" (String#24530, DoABC#2)
// onNormalMode = "_-rE" (String#24325, DoABC#2)
// _SafeStr_3911 = "native" (String#46040, DoABC#2)
// onGameMode = "_-1fd" (String#18123, DoABC#2)
// updateSettings = "_-2GL" (String#19655, DoABC#2)
// setIconAssets = "_-27e" (String#19316, DoABC#2)
// isHiddenByOtherWindows = "_-1OQ" (String#17449, DoABC#2)
// isInUse = "_-2LN" (String#6469, DoABC#2)
// daysLeft = "_-0Qt" (String#15097, DoABC#2)
// periodsLeft = "_-24W" (String#19201, DoABC#2)
// pastPeriods = "_-1Ue" (String#17690, DoABC#2)
// allowClubDances = "_-1V7" (String#17708, DoABC#2)
// allowHabboClubDances = "_-0HC" (String#14727, DoABC#2)
// isHabboClubActive = "_-0Ta" (String#15193, DoABC#2)
// habboClubDays = "_-1Et" (String#17066, DoABC#2)
// habboClubPeriods = "_-2O9" (String#19972, DoABC#2)
// habboClubLevel = "_-03V" (String#14181, DoABC#2)
// isNewsEnabled = "_-3-L" (String#21475, DoABC#2)


