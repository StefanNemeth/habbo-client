
package com.sulake.habbo.avatar
{
    import com.sulake.core.window.IWindowContainer;
    import flash.geom.Point;
    import com.sulake.core.window.components.ITabSelectorWindow;
    import com.sulake.core.window.components.IFrameWindow;
    import flash.utils.Timer;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.avatar.enum.AvatarEditorFigureCategory;
    import flash.events.TimerEvent;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import flash.events.Event;
    import com.sulake.core.window.components.ISelectableWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IContainerButtonWindow;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.habbo.avatar.enum.AvatarEditorSideCategory;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.assets.IAsset;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.habbo.catalog.enum.CatalogPageName;

    public class AvatarEditorView 
    {

        public static var _SafeStr_10173:IWindowContainer;
        public static var _SafeStr_10174:IWindowContainer;
        public static var _SafeStr_9966:int = 0x666666;
        private static const _SafeStr_10175:int = 5000;
        private static const _SafeStr_10176:Point = new Point(100, 30);

        private var _SafeStr_10177:HabboAvatarEditor;
        private var _SafeStr_10178:IWindowContainer;
        private var _SafeStr_10179:String;
        private var _SafeStr_10180:ITabSelectorWindow;
        private var _SafeStr_10181:IFrameWindow;
        private var _SafeStr_9637:IWindowContainer;
        private var _SafeStr_10182:IFrameWindow;
        private var _saveTimer:Timer;
        private var _SafeStr_10183:String;
        private var _SafeStr_10184:Boolean = true;
        private var _SafeStr_10185:Array;
        private var _allCategories:Array;

        public function AvatarEditorView(_arg_1:HabboAvatarEditor, _arg_2:Array)
        {
            var _local_3:String;
            var _local_4:XmlAsset;
            var _local_5:XmlAsset;
            this._SafeStr_10185 = [];
            this._allCategories = [AvatarEditorFigureCategory._SafeStr_9987, AvatarEditorFigureCategory._SafeStr_4458, AvatarEditorFigureCategory._SafeStr_7388, AvatarEditorFigureCategory._SafeStr_7389, AvatarEditorFigureCategory.HOTLOOKS, AvatarEditorFigureCategory._SafeStr_9985];
            super();
            this._SafeStr_10177 = _arg_1;
            if (_SafeStr_10173 == null){
                _local_4 = (this._SafeStr_10177.manager.assets.getAssetByName("AvatarEditorThumb") as XmlAsset);
                _SafeStr_10173 = (this._SafeStr_10177.manager.windowManager.buildFromXML((_local_4.content as XML)) as IWindowContainer);
            };
            if (_SafeStr_10174 == null){
                _local_5 = (this._SafeStr_10177.manager.assets.getAssetByName("color_chooser_cell") as XmlAsset);
                _SafeStr_10174 = (this._SafeStr_10177.manager.windowManager.buildFromXML((_local_5.content as XML)) as IWindowContainer);
            };
            this._saveTimer = new Timer(_SafeStr_10175, 1);
            this._saveTimer.addEventListener(TimerEvent.TIMER, this.onUpdate);
            if (_arg_2 == null){
                _arg_2 = this._allCategories;
            };
            for each (_local_3 in _arg_2) {
                this._SafeStr_10185.push(_local_3);
            };
            this.createWindow();
        }
        public function dispose():void
        {
            var _local_1:IWindowContainer;
            var _local_2:IWindowContainer;
            var _local_3:IWindowContainer;
            if (this._saveTimer != null){
                this._saveTimer.stop();
                this._saveTimer.removeEventListener(TimerEvent.TIMER, this.onUpdate);
                this._saveTimer = null;
            };
            if (this._SafeStr_10180){
                this._SafeStr_10180.dispose();
                this._SafeStr_10180 = null;
            };
            if (this._SafeStr_10182){
                this._SafeStr_10182.dispose();
                this._SafeStr_10182 = null;
            };
            if (this._SafeStr_10178){
                this._SafeStr_10178.dispose();
                this._SafeStr_10178 = null;
            };
            if (this._SafeStr_9637 != null){
                this._SafeStr_9637.dispose();
                this._SafeStr_9637 = null;
            };
            if (this._SafeStr_10181){
                this._SafeStr_10181.dispose();
                this._SafeStr_10181 = null;
            };
            if (this._SafeStr_10178 != null){
                _local_1 = (this._SafeStr_10178.findChildByName("figureContainer") as IWindowContainer);
                if (_local_1 != null){
                    while (_local_1.numChildren > 0) {
                        _local_1.removeChildAt(0);
                    };
                };
                _local_2 = (this._SafeStr_10178.findChildByName("contentArea") as IWindowContainer);
                if (_local_2 != null){
                    while (_local_2.numChildren > 0) {
                        _local_2.removeChildAt(0);
                    };
                };
                _local_3 = (this._SafeStr_10178.findChildByName("sideContainer") as IWindowContainer);
                if (_local_3 != null){
                    while (_local_3.numChildren > 0) {
                        _local_3.removeChildAt(0);
                    };
                };
                this._SafeStr_10177 = null;
            };
        }
        public function getFrame(_arg_1:Array, _arg_2:String=null):IFrameWindow
        {
            if (this._SafeStr_10181){
                this._SafeStr_10181.visible = true;
                this._SafeStr_10181.activate();
                return (this._SafeStr_10181);
            };
            if (this._SafeStr_10181){
                this._SafeStr_10181.dispose();
                this._SafeStr_10181 = null;
            };
            var _local_3:XmlAsset = (this._SafeStr_10177.manager.assets.getAssetByName("AvatarEditorFrame") as XmlAsset);
            if (_local_3){
                this._SafeStr_10181 = (this._SafeStr_10177.manager.windowManager.buildFromXML((_local_3.content as XML)) as IFrameWindow);
            };
            if (this._SafeStr_10181 == null){
                Logger.log("Failed to construct Avatar editor window!");
                return (null);
            };
            var _local_4:IWindowContainer = (this._SafeStr_10181.findChildByName("maincontent") as IWindowContainer);
            if (!this.embedToContext(_local_4, _arg_1)){
                this._SafeStr_10181.dispose();
                this._SafeStr_10181 = null;
                return (null);
            };
            if (_arg_2){
                this._SafeStr_10181.header.title.text = _arg_2;
            };
            this._SafeStr_10181.position = _SafeStr_10176;
            this._SafeStr_10181.findChildByName("header_button_close").procedure = this.windowEventProc;
            return (this._SafeStr_10181);
        }
        public function embedToContext(_arg_1:IWindowContainer, _arg_2:Array):Boolean
        {
            var _local_3:int;
            if (!this.validateAvailableCategories(_arg_2)){
                Logger.log("Could not validate categories for avatar editor!");
                return (false);
            };
            if (_arg_1){
                _local_3 = _arg_1.getChildIndex(this._SafeStr_10178);
                if (_local_3){
                    _arg_1.removeChildAt(_local_3);
                };
                _arg_1.addChild(this._SafeStr_10178);
            }
            else {
                if (this._SafeStr_9637 == null){
                    this._SafeStr_9637 = (this._SafeStr_10177.manager.windowManager.createWindow("avatarEditorContainer", "", HabboWindowType._SafeStr_3728, HabboWindowStyle._SafeStr_3729, (HabboWindowParam._SafeStr_3730 | HabboWindowParam._SafeStr_3731), new Rectangle(0, 0, 2, 2), null, 0) as IWindowContainer);
                    this._SafeStr_9637.addChild(this._SafeStr_10178);
                };
                _local_3 = this._SafeStr_9637.getChildIndex(this._SafeStr_10178);
                if (_local_3){
                    _arg_1.removeChildAt(_local_3);
                };
                this._SafeStr_9637.visible = true;
            };
            return (true);
        }
        public function validateAvailableCategories(_arg_1:Array):Boolean
        {
            var _local_2:String;
            if (_arg_1 == null){
                return (this.validateAvailableCategories(this._allCategories));
            };
            if (_arg_1.length != this._SafeStr_10185.length){
                return (false);
            };
            for each (_local_2 in _arg_1) {
                if (this._SafeStr_10185.indexOf(_local_2) < 0){
                    return (false);
                };
            };
            return (true);
        }
        private function onUpdate(_arg_1:Event=null):void
        {
            this._saveTimer.stop();
            if (this._SafeStr_10178){
                this._SafeStr_10178.findChildByName("save").enable();
            };
        }
        public function show():void
        {
            if (this._SafeStr_10181){
                this._SafeStr_10181.visible = true;
            }
            else {
                if (this._SafeStr_10178){
                    this._SafeStr_10178.visible = true;
                };
            };
        }
        public function hide():void
        {
            if (this._SafeStr_10181){
                this._SafeStr_10181.visible = false;
            }
            else {
                if (this._SafeStr_10178){
                    this._SafeStr_10178.visible = false;
                };
            };
        }
        private function createWindow():void
        {
            var _local_2:ISelectableWindow;
            var _local_3:ISelectableWindow;
            var _local_4:int;
            if (this._SafeStr_10178 == null){
                this._SafeStr_10178 = (this._SafeStr_10177.manager.windowManager.buildFromXML(((this._SafeStr_10177.manager.assets.getAssetByName("AvatarEditorContent") as XmlAsset).content as XML)) as IWindowContainer);
            };
            this._SafeStr_10178.procedure = this.windowEventProc;
            this._SafeStr_10180 = (this._SafeStr_10178.findChildByName("mainTabs") as ITabSelectorWindow);
            var _local_1:int = (this._SafeStr_10180.numSelectables - 1);
            while (_local_1 >= 0) {
                _local_2 = this._SafeStr_10180.ISelectorWindow(_local_1);
                if (((!((_local_2 == null))) && ((this._SafeStr_10185.indexOf(_local_2.name) < 0)))){
                    _local_3 = this._SafeStr_10180.ISelectorWindow(_local_2);
                    _local_4 = (_local_1 + 1);
                    while (_local_4 < this._SafeStr_10180.numSelectables) {
                        this._SafeStr_10180.ISelectorWindow(_local_4).x = (this._SafeStr_10180.ISelectorWindow(_local_4).x - _local_3.width);
                        _local_4++;
                    };
                };
                _local_1--;
            };
            this._SafeStr_10180.setSelected(this._SafeStr_10180.ISelectorWindow(0));
            this.attachImages();
            this.update();
        }
        private function attachImages():void
        {
            var _local_3:String;
            var _local_4:IWindowContainer;
            var _local_5:IBitmapWrapperWindow;
            var _local_6:BitmapDataAsset;
            var _local_7:BitmapData;
            var _local_1:Array = this._allCategories;
            var _local_2:Point = new Point();
            for each (_local_3 in _local_1) {
                _local_4 = (this._SafeStr_10178.findChildByName(_local_3) as IWindowContainer);
                if (_local_4 != null){
                    _local_5 = (_local_4.findChildByTag("BITMAP") as IBitmapWrapperWindow);
                    if (_local_5 != null){
                        _local_6 = (this._SafeStr_10177.manager.assets.getAssetByName(("ae_tabs_" + _local_3)) as BitmapDataAsset);
                        _local_7 = (_local_6.content as BitmapData);
                        _local_5.bitmap = new BitmapData(_local_5.width, _local_5.height, true, 0xFFFFFF);
                        _local_2.x = ((_local_5.width - _local_7.width) / 2);
                        _local_2.y = ((_local_5.height - _local_7.height) / 2);
                        _local_5.bitmap.copyPixels(_local_7, _local_7.rect, _local_2);
                    };
                };
            };
        }
        public function update():void
        {
            var _local_1:IWindowContainer = this._SafeStr_10177.figureData.view.window;
            var _local_2:IWindowContainer = (this._SafeStr_10178.findChildByName("figureContainer") as IWindowContainer);
            if (_local_2.numChildren > 0){
                _local_2.removeChildAt(0);
            };
            if (_local_2 != null){
                _local_2.addChild(_local_1);
            };
            var _local_3:IContainerButtonWindow = (this._SafeStr_10178.findChildByName("wardrobe") as IContainerButtonWindow);
            if (((_local_3) && (this._SafeStr_10177.manager.sessionData))){
                _local_3.visible = (((this._SafeStr_10177.manager.sessionData.clubLevel >= HabboClubLevelEnum._SafeStr_3943)) && (this._SafeStr_10177.HabboAvatarEditor()));
            };
            var _local_4:String = AvatarEditorSideCategory._SafeStr_9984;
            if (((((this._SafeStr_10177.manager.sessionData) && ((this._SafeStr_10177.manager.sessionData.clubLevel >= HabboClubLevelEnum._SafeStr_3943)))) && ((((this._SafeStr_10183 == AvatarEditorSideCategory._SafeStr_9985)) || (this._SafeStr_10184))))){
                _local_4 = AvatarEditorSideCategory._SafeStr_9985;
            };
            if (((this._SafeStr_10177.HabboAvatarEditor()) && ((this._SafeStr_10177.clubMemberLevel <= 0)))){
                _local_4 = AvatarEditorSideCategory._SafeStr_9986;
            };
            if (!this._SafeStr_10177.HabboAvatarEditor()){
                _local_4 = AvatarEditorSideCategory._SafeStr_9984;
            };
            this.setSideContent(_local_4);
            this.setViewToCategory(this._SafeStr_10179);
        }
        public function toggleCategoryView(_arg_1:String, _arg_2:Boolean=false):void
        {
            if (_arg_2){
            };
            this.setViewToCategory(_arg_1);
        }
        private function toggleWardrobe():void
        {
            if (this._SafeStr_10183 == AvatarEditorSideCategory._SafeStr_9985){
                this._SafeStr_10184 = false;
                this.setSideContent(AvatarEditorSideCategory._SafeStr_9984);
            }
            else {
                this.setSideContent(AvatarEditorSideCategory._SafeStr_9985);
            };
        }
        private function setSideContent(_arg_1:String):void
        {
            var _local_5:int;
            if (this._SafeStr_10183 == _arg_1){
                return;
            };
            var _local_2:IWindowContainer = (this._SafeStr_10178.findChildByName("sideContainer") as IWindowContainer);
            if (!_local_2){
                return;
            };
            var _local_3:IWindow;
            switch (_arg_1){
                case AvatarEditorSideCategory._SafeStr_9984:
                    break;
                case AvatarEditorSideCategory._SafeStr_9986:
                    _local_3 = this._SafeStr_10177.getSideContentWindowContainer(AvatarEditorSideCategory._SafeStr_9986);
                    break;
                case AvatarEditorSideCategory._SafeStr_9985:
                    _local_3 = this._SafeStr_10177.getSideContentWindowContainer(AvatarEditorSideCategory._SafeStr_9985);
                    break;
            };
            var _local_4:IWindow = _local_2.removeChildAt(0);
            if (_local_4){
                this._SafeStr_10178.width = (this._SafeStr_10178.width - _local_4.width);
            };
            if (_local_3){
                _local_2.addChild(_local_3);
                _local_3.visible = true;
                _local_2.width = _local_3.width;
            }
            else {
                _local_2.width = 0;
            };
            this._SafeStr_10183 = _arg_1;
            if (this._SafeStr_10181){
                _local_5 = 8;
                this._SafeStr_10181.content.width = (this._SafeStr_10178.width + _local_5);
            };
        }
        private function setViewToCategory(_arg_1:String):void
        {
            if (_arg_1 == null){
                return;
            };
            if (_arg_1 == ""){
                return;
            };
            var _local_2:IWindowContainer = (this._SafeStr_10178.findChildByName("contentArea") as IWindowContainer);
            if (_local_2 == null){
                return;
            };
            var _local_3:IWindowContainer = (_local_2.getChildAt(0) as IWindowContainer);
            _local_2.removeChild(_local_3);
            _local_2.invalidate();
            var _local_4:IWindowContainer = this._SafeStr_10177.HabboInventory(_arg_1);
            if (_local_4 == null){
                return;
            };
            _local_4.visible = true;
            _local_2.addChild(_local_4);
            this._SafeStr_10179 = _arg_1;
            this._SafeStr_10180.setSelected(this._SafeStr_10180.ISelectorWindow(_arg_1));
        }
        public function windowEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:String;
            if (_arg_1.type == WindowEvent.WE_SELECTED){
                _local_3 = _arg_2.name;
                Logger.log(("Select tab: " + _local_3));
                if (_local_3 != this._SafeStr_10179){
                    this._SafeStr_10177.toggleAvatarEditorPage(_local_3);
                };
            }
            else {
                if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                    switch (_arg_2.name){
                        case "save":
                            if (this._SafeStr_10177.hasInvalidClubItems()){
                                this.displayStripClubDialog();
                                return;
                            };
                            this._saveTimer.start();
                            this._SafeStr_10178.findChildByName("save").disable();
                            this._SafeStr_10177.HabboAvatarEditor();
                            this._SafeStr_10177.manager.close(this._SafeStr_10177.instanceId);
                            return;
                        case "cancel":
                            this._SafeStr_10177.manager.close(this._SafeStr_10177.instanceId);
                            return;
                        case "wardrobe":
                            this.toggleWardrobe();
                            return;
                        case "header_button_close":
                            this._SafeStr_10177.manager.close(this._SafeStr_10177.instanceId);
                    };
                };
            };
        }
        private function displayStripClubDialog():void
        {
            var _local_1:IAsset;
            var _local_2:XML;
            if (!this._SafeStr_10182){
                _local_1 = this._SafeStr_10177.manager.assets.getAssetByName("StripClubItemsInfo");
                if (!_local_1){
                    Logger.log("Failed to initialize strip club info dialog; missing asset!");
                    return;
                };
                _local_2 = (_local_1.content as XML);
                this._SafeStr_10182 = (this._SafeStr_10177.manager.windowManager.buildFromXML(_local_2, 2) as IFrameWindow);
                this._SafeStr_10182.procedure = this.stripClubDialogEventProc;
                this._SafeStr_10182.center();
            }
            else {
                this._SafeStr_10182.visible = true;
                this._SafeStr_10182.center();
            };
        }
        private function stripClubDialogEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                switch (_arg_2.name){
                    case "header_button_close":
                        this._SafeStr_10182.visible = false;
                        if (this._SafeStr_10177.manager.communication){
                            this._SafeStr_10177.manager.communication.HabboCommunicationManager(null).send(new EventLogMessageComposer("AvatarEditor", "click", "strip_club_items_close"));
                        };
                        return;
                    case "strip_button_ok":
                        if (this._SafeStr_10177){
                            this._SafeStr_10177.stripClubItems();
                        };
                        this._SafeStr_10182.visible = false;
                        if (this._SafeStr_10177.manager.communication){
                            this._SafeStr_10177.manager.communication.HabboCommunicationManager(null).send(new EventLogMessageComposer("AvatarEditor", "click", "strip_club_items_ok"));
                        };
                        return;
                    case "strip_button_club_info":
                        this.openCatalogClubPage();
                        this._SafeStr_10182.visible = false;
                        if (this._SafeStr_10177.manager.communication){
                            this._SafeStr_10177.manager.communication.HabboCommunicationManager(null).send(new EventLogMessageComposer("AvatarEditor", "click", "strip_club_items_info"));
                        };
                };
            };
        }
        private function openCatalogClubPage():void
        {
            if (this._SafeStr_10177.manager.catalog){
                this._SafeStr_10177.manager.catalog.openCatalogPage(CatalogPageName._SafeStr_5382, true);
            };
        }

    }
}//package com.sulake.habbo.avatar

// _SafeStr_10173 = "_-20g" (String#19038, DoABC#2)
// _SafeStr_10174 = "_-0YN" (String#15374, DoABC#2)
// _SafeStr_10175 = "_-0Sy" (String#15168, DoABC#2)
// _SafeStr_10176 = "_-25d" (String#875, DoABC#2)
// _SafeStr_10177 = "_-N-" (String#23125, DoABC#2)
// _SafeStr_10178 = "_-P" (String#23206, DoABC#2)
// _SafeStr_10179 = "_-2HD" (String#6390, DoABC#2)
// _SafeStr_10180 = "_-1lk" (String#18364, DoABC#2)
// _SafeStr_10181 = "_-2NA" (String#19930, DoABC#2)
// _SafeStr_10182 = "_-21E" (String#19061, DoABC#2)
// _SafeStr_10183 = "_-3C5" (String#21964, DoABC#2)
// _SafeStr_10184 = "_-2y1" (String#21394, DoABC#2)
// _SafeStr_10185 = "_-1Yn" (String#17841, DoABC#2)
// validateAvailableCategories = "_-tJ" (String#24420, DoABC#2)
// HabboAvatarEditor = "_-j" (String#23999, DoABC#2)
// HabboAvatarEditor = "_-05h" (String#14269, DoABC#2)
// setSideContent = "_-1NG" (String#17409, DoABC#2)
// setViewToCategory = "_-211" (String#6066, DoABC#2)
// toggleCategoryView = "_-wV" (String#24553, DoABC#2)
// toggleWardrobe = "_-0X4" (String#15317, DoABC#2)
// getSideContentWindowContainer = "_-24M" (String#19193, DoABC#2)
// HabboInventory = "_-1yQ" (String#18906, DoABC#2)
// toggleAvatarEditorPage = "_-2Od" (String#19990, DoABC#2)
// hasInvalidClubItems = "_-1Si" (String#17611, DoABC#2)
// displayStripClubDialog = "_-sj" (String#24389, DoABC#2)
// HabboAvatarEditor = "_-1ER" (String#17045, DoABC#2)
// stripClubDialogEventProc = "_-1oa" (String#18480, DoABC#2)
// stripClubItems = "_-bD" (String#23678, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// CatalogPageName = "_-mv" (String#24149, DoABC#2)
// HabboWindowParam = "_-29D" (String#6233, DoABC#2)
// HabboWindowStyle = "_-0E1" (String#14608, DoABC#2)
// HabboWindowType = "_-29U" (String#19384, DoABC#2)
// ISelectableWindow = "_-nA" (String#2188, DoABC#2)
// IContainerButtonWindow = "_-0UF" (String#1484, DoABC#2)
// HabboClubLevelEnum = "_-1ZP" (String#17867, DoABC#2)
// AvatarEditorSideCategory = "_-0s9" (String#4689, DoABC#2)
// AvatarEditorView = "_-06P" (String#3690, DoABC#2)
// AvatarEditorFigureCategory = "_-nF" (String#8661, DoABC#2)
// _SafeStr_3728 = "_-1IW" (String#5215, DoABC#2)
// _SafeStr_3729 = "_-06z" (String#14322, DoABC#2)
// _SafeStr_3730 = "_-1rZ" (String#18611, DoABC#2)
// _SafeStr_3731 = "_-B" (String#22654, DoABC#2)
// _SafeStr_3943 = "_-xn" (String#24604, DoABC#2)
// sessionData = "_-3Fb" (String#22101, DoABC#2)
// WE_SELECTED = "_-17F" (String#16745, DoABC#2)
// getFrame = "_-3Jk" (String#923, DoABC#2)
// _SafeStr_4458 = "_-327" (String#21586, DoABC#2)
// communication = "_-3HD" (String#22171, DoABC#2)
// HabboCommunicationManager = "_-0AQ" (String#809, DoABC#2)
// _SafeStr_5382 = "_-lc" (String#24094, DoABC#2)
// attachImages = "_-2jH" (String#6942, DoABC#2)
// instanceId = "_-044" (String#3649, DoABC#2)
// _SafeStr_7388 = "_-0YE" (String#15366, DoABC#2)
// _SafeStr_7389 = "_-3HR" (String#22176, DoABC#2)
// ISelectorWindow = "_-0EO" (String#3836, DoABC#2)
// onUpdate = "_-Ck" (String#2075, DoABC#2)
// EventLogMessageComposer = "_-2lH" (String#6984, DoABC#2)
// _allCategories = "_-Wy" (String#8348, DoABC#2)
// numSelectables = "_-1pQ" (String#5845, DoABC#2)
// ISelectorWindow = "_-2Vc" (String#6675, DoABC#2)
// ISelectorWindow = "_-i9" (String#8555, DoABC#2)
// _SafeStr_9637 = "_-2Xg" (String#1895, DoABC#2)
// _SafeStr_9966 = "_-T9" (String#23371, DoABC#2)
// _SafeStr_9984 = "_-2VA" (String#20246, DoABC#2)
// _SafeStr_9985 = "_-0g7" (String#15676, DoABC#2)
// _SafeStr_9986 = "_-0vi" (String#16264, DoABC#2)
// _SafeStr_9987 = "_-qw" (String#24312, DoABC#2)


