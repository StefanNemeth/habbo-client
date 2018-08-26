
package com.sulake.habbo.help.help
{
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.help.HabboHelp;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.help.enum.HabboHelpViewEnum;
    import com.sulake.habbo.help.cfh.CallForHelpTopicSelection;
    import com.sulake.habbo.help.cfh.CallForHelpTextInput;
    import com.sulake.habbo.help.cfh.CallForHelpSentView;
    import com.sulake.habbo.help.cfh.CallForHelpPendingItemView;
    import com.sulake.habbo.help.cfh.CallForHelpReportUserSelection;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindow;
    import flash.events.Event;
    import com.sulake.habbo.help.enum.HabboHelpTrackingEvent;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.help.enum.CallForHelpResultEnum;
    import com.sulake.habbo.communication.messages.outgoing.room.action.CallGuideBotMessageComposer;
    import com.sulake.habbo.help.enum.HabboHelpTutorialEvent;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.habbo.help.help.data.FaqIndex;
    import flash.utils.Dictionary;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;

    public class HelpUI 
    {

        private var _assetLibrary:IAssetLibrary;
        private var _windowManager:IHabboWindowManager;
        private var _window:IWindowContainer;
        private var _component:HabboHelp;
        private var _SafeStr_11394:String = "HHVE_HELP_FRONTPAGE";
        private var _SafeStr_10179:String;
        private var _SafeStr_11395:Array;
        private var _SafeStr_11396:Map;
        private var _SafeStr_11397:int = 0;
        private var _SafeStr_11398:int = 0;
        private var _SafeStr_11399:IWindowContainer;
        private var _SafeStr_11400:Array;
        private var _HelpUI:Boolean = false;

        public function HelpUI(_arg_1:HabboHelp, _arg_2:IAssetLibrary, _arg_3:IHabboWindowManager)
        {
            this._SafeStr_10179 = this._SafeStr_11394;
            this._SafeStr_11395 = new Array();
            this._SafeStr_11400 = new Array();
            super();
            this._component = _arg_1;
            this._assetLibrary = _arg_2;
            this._windowManager = _arg_3;
            this._windowManager.registerLocalizationParameter("info.client.version", "version", new String(201108111102));
            this._SafeStr_11396 = new Map();
            this._SafeStr_11396.add(HabboHelpViewEnum.HVVE_PH, IHelpViewController(new PlaceholderView(this, this._windowManager, this._assetLibrary)));
            this._SafeStr_11396.add(HabboHelpViewEnum.HHVE_HELP_FRONTPAGE, IHelpViewController(new HelpMainView(this, this._windowManager, this._assetLibrary)));
            this._SafeStr_11396.add(HabboHelpViewEnum.HHVE_FAQ_TOP, IHelpViewController(new FaqBrowseTopView(this, this._windowManager, this._assetLibrary)));
            this._SafeStr_11396.add(HabboHelpViewEnum.HHVE_FAQ_CATEGORY, IHelpViewController(new FaqBrowseCategoryView(this, this._windowManager, this._assetLibrary)));
            this._SafeStr_11396.add(HabboHelpViewEnum.HHVE_FAQ_TOPICS, IHelpViewController(new FaqBrowseEntry(this, this._windowManager, this._assetLibrary)));
            this._SafeStr_11396.add(HabboHelpViewEnum.HHVE_CFG_TOPIC_SELECT, IHelpViewController(new CallForHelpTopicSelection(this, this._windowManager, this._assetLibrary)));
            this._SafeStr_11396.add(HabboHelpViewEnum.HHVE_CFH_TEXT_INPUT, IHelpViewController(new CallForHelpTextInput(this, this._windowManager, this._assetLibrary)));
            this._SafeStr_11396.add(HabboHelpViewEnum.CFHRE_SENT_OK, IHelpViewController(new CallForHelpSentView(this, this._windowManager, this._assetLibrary, "help_cfh_thanks")));
            this._SafeStr_11396.add(HabboHelpViewEnum.HHVE_CFH_HAS_ABUSIVE, IHelpViewController(new CallForHelpSentView(this, this._windowManager, this._assetLibrary, "help_cfh_abusive")));
            this._SafeStr_11396.add(HabboHelpViewEnum.HHVE_CFH_PENDING, IHelpViewController(new CallForHelpPendingItemView(this, this._windowManager, this._assetLibrary)));
            this._SafeStr_11396.add(HabboHelpViewEnum.HHVE_REPORT_USER_SELECT, IHelpViewController(new CallForHelpReportUserSelection(this, this._windowManager, this._assetLibrary)));
        }
        public function dispose():void
        {
            var _local_3:String;
            var _local_4:IHelpViewController;
            if (this._window != null){
                this._window.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClick);
            };
            var _local_1:Array = this._SafeStr_11396.getKeys();
            var _local_2:int;
            while (_local_2 < _local_1.length) {
                _local_3 = _local_1[_local_2];
                _local_4 = (this._SafeStr_11396.getValue(_local_3) as IHelpViewController);
                if (_local_4 != null){
                    _local_4.dispose();
                };
                _local_2++;
            };
            this._SafeStr_11396.dispose();
            if (this._SafeStr_11399 != null){
                this._SafeStr_11399.dispose();
                this._SafeStr_11399 = null;
            };
        }
        public function toggleUI():void
        {
            if (((!((this._window == null))) && (this._window.visible))){
                this.hideUI();
            }
            else {
                this.showUI();
            };
        }
        public function showUI(_arg_1:String=null, _arg_2:Boolean=true):void
        {
            if (_arg_1 == null){
                _arg_1 = this._SafeStr_10179;
            };
            if (this._window == null){
                this.createWindow();
                if (this._window == null){
                    return;
                };
                this._window.visible = true;
            }
            else {
                this.removeCurrentView();
            };
            if (_arg_1 == this._SafeStr_11394){
                this._SafeStr_11395 = new Array();
            }
            else {
                if (_arg_2){
                    if ((((this._SafeStr_11395.length == 0)) || (!((_arg_1 == this._SafeStr_10179))))){
                        this._SafeStr_11395.push(this._SafeStr_10179);
                    };
                };
            };
            this._SafeStr_10179 = _arg_1;
            var _local_3:IHelpViewController = this.getViewController();
            if (_local_3 == null){
                Logger.log(("* No view controller found for " + this._SafeStr_10179));
                return;
            };
            var _local_4:IWindowContainer = (this._window.findChildByName("content_area") as IWindowContainer);
            if (_local_4 == null){
                return;
            };
            var _local_5:IItemListWindow = (this._window.findChildByName("content_list") as IItemListWindow);
            if (_local_5 == null){
                return;
            };
            _local_5.height = 0;
            _local_3.render();
            var _local_6:IWindow = (_local_3.TradingModel() as IWindow);
            if (_local_6 != null){
                _local_5.IItemListWindow(_local_6, 0);
            };
            this.addBackButtonWindow();
            this.updateWindowDimensions();
            this._component.events.dispatchEvent(new Event(HabboHelpTrackingEvent.HABBO_HELP_TRACKING_EVENT_DEFAULT));
        }
        public function tellUI(_arg_1:String, _arg_2:*=null):void
        {
            if (this._SafeStr_10179 != _arg_1){
                return;
            };
            var _local_3:IHelpViewController = this.getViewController();
            if (_local_3 != null){
                _local_3.update(_arg_2);
            };
        }
        public function get component():HabboHelp
        {
            return (this._component);
        }
        public function get localization():IHabboLocalizationManager
        {
            return (this._component.localization);
        }
        public function get window():IWindowContainer
        {
            return (this._window);
        }
        public function HelpUI(message:String):void
        {
            this._windowManager.alert("${help.cfh.reply.title}", message, 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
            {
                _arg_1.dispose();
            });
        }
        public function HelpUI(_arg_1:String):void
        {
            switch (_arg_1){
                case CallForHelpResultEnum.CFHRE_SENT_OK:
                    this.showUI(HabboHelpViewEnum.CFHRE_SENT_OK);
                    return;
                case CallForHelpResultEnum.CFHRE_ERROR_TOO_MANY_PENDING:
                    this.showUI(HabboHelpViewEnum.HHVE_CFH_PENDING);
                    return;
                case CallForHelpResultEnum.CFHRE_HAS_ABUSIVE_CALL:
                    this.showUI(HabboHelpViewEnum.HHVE_CFH_HAS_ABUSIVE);
                    return;
            };
        }
        public function HelpUI(_arg_1:Boolean):void
        {
            this._HelpUI = _arg_1;
            var _local_2:IHelpViewController = (this._SafeStr_11396.getValue(HabboHelpViewEnum.HHVE_HELP_FRONTPAGE) as IHelpViewController);
            if (((!((_local_2 == null))) && (!(_local_2.disposed)))){
                _local_2.update();
            };
        }
        public function isCallForGuideBotEnabled():Boolean
        {
            return (this._HelpUI);
        }
        public function handleCallGuideBot():void
        {
            this.sendMessage(new CallGuideBotMessageComposer());
            this.hideUI();
            this._component.events.dispatchEvent(new HabboHelpTutorialEvent(HabboHelpTutorialEvent.HHTPNUFWE_DONE_GUIDEBOT));
        }
        public function sendMessage(_arg_1:IMessageComposer):void
        {
            this._component.sendMessage(_arg_1);
        }
        public function getFaq():FaqIndex
        {
            return (this._component.getFaq());
        }
        public function getText(_arg_1:String, _arg_2:String=null):String
        {
            if (_arg_2 == null){
                _arg_2 = _arg_1;
            };
            return (this.localization.getKey(_arg_1, _arg_2));
        }
        public function getConfigurationKey(_arg_1:String, _arg_2:String=null, _arg_3:Dictionary=null):String
        {
            return (this._component.getConfigurationKey(_arg_1, _arg_2, _arg_3));
        }
        public function setRoomSessionStatus(_arg_1:Boolean):void
        {
            var _local_3:IHelpViewController;
            var _local_2:int;
            while (_local_2 < this._SafeStr_11396.length) {
                _local_3 = (this._SafeStr_11396.getWithIndex(_local_2) as IHelpViewController);
                if (_local_3 != null){
                    _local_3.roomSessionActive = _arg_1;
                    if (!_local_3.disposed){
                        _local_3.update();
                    };
                };
                _local_2++;
            };
        }
        private function getViewController():IHelpViewController
        {
            return (this._SafeStr_11396.getValue(this._SafeStr_10179));
        }
        private function createWindow():void
        {
            var _local_1:XmlAsset = XmlAsset(this._assetLibrary.getAssetByName("help_frame_xml"));
            if (_local_1 == null){
                return;
            };
            this._window = (this._windowManager.buildFromXML(XML(_local_1.content)) as IWindowContainer);
            if (this._window == null){
                return;
            };
            this._window.center();
            this._window.setParamFlag(WindowParam._SafeStr_7434);
            this._window.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClick);
            var _local_2:IWindow = this._window.findChildByTag("close");
            if (_local_2 != null){
                _local_2.setParamFlag(WindowParam._SafeStr_7434);
                _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.PollOfferDialog);
            };
            var _local_3:IItemListWindow = (this._window.findChildByName("content_list") as IItemListWindow);
            if (_local_3 == null){
                return;
            };
            this._SafeStr_11397 = (this._window.width - _local_3.width);
            this._SafeStr_11398 = this._window.height;
        }
        private function removeCurrentView():void
        {
            var _local_2:IItemListWindow;
            if (this._window != null){
                _local_2 = (this._window.findChildByName("content_list") as IItemListWindow);
                if (_local_2 != null){
                    while (_local_2.numListItems > 1) {
                        _local_2.getListItemAt(0).dispose();
                        _local_2.IItemListWindow(0);
                    };
                };
            };
            var _local_1:IHelpViewController = this.getViewController();
            if (_local_1 != null){
                _local_1.dispose();
            };
        }
        public function updateWindowDimensions():void
        {
            if (this._window == null){
                return;
            };
            var _local_1:IItemListWindow = (this._window.findChildByName("content_list") as IItemListWindow);
            if (_local_1 == null){
                return;
            };
            this._window.height = (_local_1.height + this._SafeStr_11398);
            this._window.width = (_local_1.width + this._SafeStr_11397);
        }
        public function hideUI():void
        {
            if (this._window != null){
                this.removeCurrentView();
                this._window.dispose();
                this._window = null;
            };
            this._SafeStr_10179 = this._SafeStr_11394;
            this._component.events.dispatchEvent(new Event(HabboHelpTrackingEvent.HABBO_HELP_TRACKING_EVENT_CLOSED));
        }
        private function PollOfferDialog(_arg_1:WindowMouseEvent):void
        {
            this.hideUI();
        }
        private function AchievementController(_arg_1:WindowMouseEvent):void
        {
            if (this._SafeStr_11395.length > 0){
                this.showUI(this._SafeStr_11395.pop(), false);
            };
        }
        private function ClubGiftNotification(_arg_1:WindowMouseEvent):void
        {
            this.setBackButtonActiveState(false);
        }
        private function ClubGiftNotification(_arg_1:WindowMouseEvent):void
        {
            this.setBackButtonActiveState(true);
        }
        private function onClick(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IWindow = (_arg_1.target as IWindow);
            if (_local_2.tags.indexOf("close") > -1){
                this.hideUI();
                return;
            };
            if (_local_2.tags.indexOf("back") > -1){
                if (this._SafeStr_11395.length > 0){
                    this.showUI(this._SafeStr_11395.pop(), false);
                };
            };
        }
        private function setBackButtonActiveState(_arg_1:Boolean=false):void
        {
            var _local_3:BitmapDataAsset;
            if (this._SafeStr_10179 == HabboHelpViewEnum.HHVE_HELP_FRONTPAGE){
                return;
            };
            if (this._SafeStr_11400.length < 2){
                _local_3 = (this._assetLibrary.getAssetByName("back_png") as BitmapDataAsset);
                this._SafeStr_11400.push((_local_3.content as BitmapData));
                _local_3 = (this._assetLibrary.getAssetByName("back_hi_png") as BitmapDataAsset);
                this._SafeStr_11400.push((_local_3.content as BitmapData));
            };
            var _local_2:IBitmapWrapperWindow = (this._SafeStr_11399.findChildByName("back_image") as IBitmapWrapperWindow);
            if (_local_2 == null){
                return;
            };
            _local_2.bitmap = new BitmapData(_local_2.width, _local_2.height, true);
            if (_arg_1){
                _local_2.bitmap.copyPixels(this._SafeStr_11400[1], this._SafeStr_11400[1].rect, new Point(0, 0));
            }
            else {
                _local_2.bitmap.copyPixels(this._SafeStr_11400[0], this._SafeStr_11400[0].rect, new Point(0, 0));
            };
        }
        private function addBackButtonWindow():void
        {
            var _local_2:XmlAsset;
            var _local_3:IWindow;
            var _local_4:IWindow;
            if ((((this._SafeStr_10179 == HabboHelpViewEnum.HHVE_HELP_FRONTPAGE)) || ((this._SafeStr_11395.length == 0)))){
                return;
            };
            if (this._SafeStr_11399 == null){
                _local_2 = XmlAsset(this._assetLibrary.getAssetByName("help_back_button_xml"));
                if (_local_2 == null){
                    return;
                };
                this._SafeStr_11399 = (this._windowManager.buildFromXML(XML(_local_2.content)) as IWindowContainer);
                _local_3 = this._SafeStr_11399.findChildByName("back_image");
                if (_local_3 != null){
                    _local_3.setParamFlag(WindowParam._SafeStr_7434);
                    _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.AchievementController);
                    _local_3.addEventListener(WindowMouseEvent.WME_OUT, this.ClubGiftNotification);
                    _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.ClubGiftNotification);
                };
                _local_4 = this._SafeStr_11399.findChildByName("back_text");
                if (_local_4 != null){
                    _local_4.setParamFlag(WindowParam._SafeStr_7434);
                    _local_4.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.AchievementController);
                };
            };
            var _local_1:IItemListWindow = (this._window.findChildByName("content_list") as IItemListWindow);
            if ((((_local_1 == null)) || ((this._SafeStr_11399 == null)))){
                return;
            };
            if (_local_1.IItemListWindow((this._SafeStr_11399 as IWindow)) > -1){
                return;
            };
            _local_1.addListItem((this._SafeStr_11399 as IWindow));
            this.setBackButtonActiveState(false);
        }

    }
}//package com.sulake.habbo.help.help

// _SafeStr_10179 = "_-2HD" (String#6390, DoABC#2)
// roomSessionActive = "_-4g" (String#7760, DoABC#2)
// AchievementController = "_-2yv" (String#905, DoABC#2)
// _SafeStr_11394 = "_-2kv" (String#20880, DoABC#2)
// _SafeStr_11395 = "_-3IH" (String#22213, DoABC#2)
// _SafeStr_11396 = "_-2DP" (String#19543, DoABC#2)
// _SafeStr_11397 = "_-1Dk" (String#5138, DoABC#2)
// _SafeStr_11398 = "_-2Is" (String#6418, DoABC#2)
// _SafeStr_11399 = "_-2lV" (String#20899, DoABC#2)
// _SafeStr_11400 = "_-32f" (String#21603, DoABC#2)
// _HelpUI = "_-2Ta" (String#20185, DoABC#2)
// toggleUI = "_-OI" (String#23180, DoABC#2)
// removeCurrentView = "_-G1" (String#22854, DoABC#2)
// getViewController = "_-dL" (String#23773, DoABC#2)
// addBackButtonWindow = "_-2Ix" (String#19762, DoABC#2)
// HelpUI = "_-1DY" (String#17005, DoABC#2)
// HelpUI = "_-0VS" (String#15260, DoABC#2)
// HelpUI = "_-Hv" (String#22926, DoABC#2)
// setRoomSessionStatus = "_-lP" (String#24084, DoABC#2)
// setBackButtonActiveState = "_-0Xs" (String#15349, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// FaqIndex = "_-3I0" (String#7667, DoABC#2)
// HabboHelpViewEnum = "_-1e7" (String#18062, DoABC#2)
// IHelpViewController = "_-0cs" (String#4364, DoABC#2)
// CallForHelpTopicSelection = "_-un" (String#8780, DoABC#2)
// CallForHelpPendingItemView = "_-1YW" (String#5531, DoABC#2)
// CallForHelpResultEnum = "_-2DX" (String#6313, DoABC#2)
// HelpMainView = "_-h6" (String#8537, DoABC#2)
// FaqBrowseEntry = "_-1BI" (String#5100, DoABC#2)
// CallForHelpTextInput = "_-2VL" (String#6670, DoABC#2)
// CallGuideBotMessageComposer = "_-1JH" (String#17248, DoABC#2)
// PlaceholderView = "_-0wE" (String#828, DoABC#2)
// CallForHelpReportUserSelection = "_-1jP" (String#5743, DoABC#2)
// FaqBrowseCategoryView = "_-qA" (String#8712, DoABC#2)
// FaqBrowseTopView = "_-28S" (String#6211, DoABC#2)
// CallForHelpSentView = "_-0am" (String#4318, DoABC#2)
// HabboHelpTutorialEvent = "_-TD" (String#23373, DoABC#2)
// IItemListWindow = "_-2CT" (String#6293, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// ClubGiftNotification = "_-21W" (String#613, DoABC#2)
// ClubGiftNotification = "_-1ap" (String#608, DoABC#2)
// TradingModel = "_-v8" (String#313, DoABC#2)
// PollOfferDialog = "_-2Ts" (String#54, DoABC#2)
// IItemListWindow = "_-6Q" (String#7792, DoABC#2)
// _component = "_-2cU" (String#305, DoABC#2)
// onClick = "_-2US" (String#368, DoABC#2)
// IItemListWindow = "_-Td" (String#8279, DoABC#2)
// _SafeStr_7434 = "_-2xA" (String#21356, DoABC#2)
// HVVE_PH = "_-0V5" (String#15245, DoABC#2)
// HHVE_HELP_FRONTPAGE = "_-2WD" (String#20292, DoABC#2)
// HHVE_FAQ_TOP = "_-0et" (String#15622, DoABC#2)
// HHVE_FAQ_CATEGORY = "_-1AU" (String#16879, DoABC#2)
// HHVE_FAQ_TOPICS = "_-ed" (String#23829, DoABC#2)
// HHVE_CFG_TOPIC_SELECT = "_-2-u" (String#19007, DoABC#2)
// HHVE_CFH_TEXT_INPUT = "_-0Ke" (String#14865, DoABC#2)
// CFHRE_SENT_OK = "_-0ru" (String#16119, DoABC#2)
// HHVE_CFH_PENDING = "_-2w3" (String#21310, DoABC#2)
// HHVE_CFH_HAS_ABUSIVE = "_-sa" (String#24381, DoABC#2)
// HHVE_REPORT_USER_SELECT = "_-0Cm" (String#14561, DoABC#2)
// CFHRE_ERROR_TOO_MANY_PENDING = "_-1b1" (String#17935, DoABC#2)
// CFHRE_HAS_ABUSIVE_CALL = "_-3KC" (String#22290, DoABC#2)
// HHTPNUFWE_DONE_GUIDEBOT = "_-2lW" (String#20900, DoABC#2)


