
package com.sulake.habbo.ui.widget.infostand
{
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.tracking.IHabboTracking;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.IBorderWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.tracking.HabboTracking;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.ITextWindow;
    import flash.geom.Point;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
    import com.sulake.habbo.catalog.enum.CatalogPageName;

    public class InfoStandPetView 
    {

        private static const _SafeStr_13972:int = 162;
        private static const _SafeStr_13973:int = 16;
        private static const _SafeStr_13974:int = 4;
        private static const _SafeStr_13975:uint = 0xDADADA;
        private static const _SafeStr_13976:uint = 0x3A3A3A;
        private static const _SafeStr_13977:uint = 2085362;
        private static const _SafeStr_13978:uint = 39616;
        private static const _SafeStr_13979:uint = 10513106;
        private static const _SafeStr_13980:uint = 8734654;
        private static const _SafeStr_13981:uint = 9094430;
        private static const _SafeStr_13982:uint = 0x5E9D00;
        private static const _SafeStr_13983:String = "happiness";
        private static const _SafeStr_13984:String = "experience";
        private static const _SafeStr_13985:String = "energy";
        private static const _SafeStr_13986:int = 250;
        private static const _SafeStr_13987:int = 25;
        private static const _SafeStr_13988:int = 5;

        private var _catalog:IHabboCatalog;
        private var _habboTracking:IHabboTracking;
        private var _widget:InfostandWidget;
        private var _window:IItemListWindow;
        private var _border:IBorderWindow;
        private var _SafeStr_13989:IWindowContainer;
        private var _SafeStr_13990:IItemListWindow;
        private var _SafeStr_13991:PetCommandTool;
        private var _petData:Map;
        private var _currentPetId:int;

        public function InfoStandPetView(_arg_1:InfostandWidget, _arg_2:String, _arg_3:IHabboCatalog)
        {
            this._widget = _arg_1;
            this._catalog = _arg_3;
            this._habboTracking = HabboTracking.getInstance();
            this.createWindow(_arg_2);
            this._petData = new Map();
        }
        public function dispose():void
        {
            this._widget = null;
            this._catalog = null;
            this._habboTracking = null;
            this._border = null;
            this._SafeStr_13989 = null;
            this._SafeStr_13990 = null;
            if (this._window){
                this._window.dispose();
            };
            this._window = null;
            if (this._SafeStr_13991){
                this._SafeStr_13991.dispose();
            };
            this._SafeStr_13991 = null;
            if (this._petData){
                this._petData.dispose();
                this._petData = null;
            };
        }
        public function get window():IItemListWindow
        {
            return (this._window);
        }
        private function updateWindow():void
        {
            if ((((((this._SafeStr_13990 == null)) || ((this._border == null)))) || ((this._SafeStr_13989 == null)))){
                return;
            };
            this._SafeStr_13989.width = this._SafeStr_13989.width;
            this._SafeStr_13989.visible = (this._SafeStr_13989.width > 0);
            this._SafeStr_13990.height = this._SafeStr_13990.scrollableRegion.height;
            this._border.height = (this._SafeStr_13990.height + 20);
            this._window.width = Math.max(this._border.width, this._SafeStr_13989.width);
            this._window.height = this._window.scrollableRegion.height;
            if (this._border.width < this._SafeStr_13989.width){
                this._border.x = (this._window.width - this._border.width);
                this._SafeStr_13989.x = 0;
            }
            else {
                this._SafeStr_13989.x = (this._window.width - this._SafeStr_13989.width);
                this._border.x = 0;
            };
            this._widget.refreshContainer();
        }
        public function update(_arg_1:InfoStandPetData):void
        {
            this.name = _arg_1.name;
            this.image = _arg_1.image;
            this.ownerName = _arg_1.ownerName;
            this.raceText = this._widget.localizations.getKey(this.getRaceLocalizationKey(_arg_1.type, _arg_1.race));
            this.petRespect = _arg_1.petRespect;
            this.ageText = _arg_1.age;
            this.setLevelText(_arg_1.level, _arg_1.levelMax);
            this.updateStateElement(_SafeStr_13983, _arg_1.nutrition, _arg_1.nutritionMax, _SafeStr_13978, _SafeStr_13977);
            this.updateStateElement(_SafeStr_13984, _arg_1.experience, _arg_1.experienceMax, _SafeStr_13980, _SafeStr_13979);
            this.updateStateElement(_SafeStr_13985, _arg_1.energy, _arg_1.energyMax, _SafeStr_13982, _SafeStr_13981);
            this.showButton("pick", _arg_1.isOwnPet);
            this.showButton("train", _arg_1.isOwnPet);
            this.showButton("kick", _arg_1.canOwnerBeKicked);
            this.updateRespectButton();
            this.updateWindow();
            this._currentPetId = _arg_1.id;
            this._petData.remove(_arg_1.id);
            this._petData.add(_arg_1.id, _arg_1);
            if (((((this._SafeStr_13991) && (this._SafeStr_13991.isVisible()))) && (_arg_1.isOwnPet))){
                this._SafeStr_13991.showCommandToolForPet(_arg_1.id, _arg_1.name, _arg_1.image);
            };
        }
        public function getCurrentPetId():int
        {
            return (this._currentPetId);
        }
        public function updateEnabledTrainingCommands(_arg_1:int, _arg_2:CommandConfiguration):void
        {
            if (this._SafeStr_13991 == null){
                return;
            };
            this._SafeStr_13991.setEnabledCommands(_arg_1, _arg_2);
        }
        private function getRaceLocalizationKey(_arg_1:int, _arg_2:int):String
        {
            return (((("pet.breed." + _arg_1) + ".") + _arg_2));
        }
        private function createPercentageBar(_arg_1:int, _arg_2:int, _arg_3:uint, _arg_4:uint):BitmapData
        {
            _arg_2 = Math.max(_arg_2, 1);
            _arg_1 = Math.max(_arg_1, 0);
            if (_arg_1 > _arg_2){
                _arg_1 = _arg_2;
            };
            var _local_5:Number = (_arg_1 / _arg_2);
            var _local_6:int = 1;
            var _local_7:BitmapData = new BitmapData(_SafeStr_13972, _SafeStr_13973, false);
            _local_7.fillRect(new Rectangle(0, 0, _local_7.width, _local_7.height), _SafeStr_13975);
            var _local_8:Rectangle = new Rectangle(_local_6, _local_6, (_local_7.width - (_local_6 * 2)), (_local_7.height - (_local_6 * 2)));
            _local_7.fillRect(_local_8, _SafeStr_13976);
            var _local_9:Rectangle = new Rectangle(_local_6, (_local_6 + _SafeStr_13974), (_local_7.width - (_local_6 * 2)), ((_local_7.height - (_local_6 * 2)) - _SafeStr_13974));
            _local_9.width = (_local_5 * _local_9.width);
            _local_7.fillRect(_local_9, _arg_3);
            var _local_10:Rectangle = new Rectangle(_local_6, _local_6, (_local_7.width - (_local_6 * 2)), _SafeStr_13974);
            _local_10.width = (_local_5 * _local_10.width);
            _local_7.fillRect(_local_10, _arg_4);
            return (_local_7);
        }
        private function openTrainView():void
        {
            if (this._SafeStr_13991 == null){
                this._SafeStr_13991 = new PetCommandTool(this._widget);
            };
            var _local_1:InfoStandPetData = (this._petData.getValue(this._currentPetId) as InfoStandPetData);
            if (_local_1 != null){
                this._SafeStr_13991.showWindow(true);
                this._SafeStr_13991.showCommandToolForPet(_local_1.id, _local_1.name, _local_1.image);
            };
        }
        private function createWindow(_arg_1:String):void
        {
            var _local_5:IWindow;
            var _local_6:IBitmapWrapperWindow;
            var _local_10:IWindow;
            var _local_11:BitmapDataAsset;
            var _local_12:BitmapData;
            var _local_13:BitmapDataAsset;
            var _local_14:BitmapData;
            var _local_15:BitmapDataAsset;
            var _local_16:BitmapData;
            var _local_17:BitmapDataAsset;
            var _local_18:BitmapData;
            var _local_2:XmlAsset = (this._widget.assets.getAssetByName("pet_view") as XmlAsset);
            this._window = (this._widget.windowManager.buildFromXML((_local_2.content as XML)) as IItemListWindow);
            if (this._window == null){
                throw (new Error("Failed to construct window from XML!"));
            };
            this._border = (this._window.getListItemByName("info_border") as IBorderWindow);
            if (this._border != null){
                this._SafeStr_13990 = (this._border.findChildByName("infostand_element_list") as IItemListWindow);
            };
            this._window.name = _arg_1;
            this._widget.mainContainer.addChild(this._window);
            var _local_3:IWindow = this._border.findChildByTag("close");
            if (_local_3 != null){
                _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClose);
            };
            this._SafeStr_13989 = (this._window.getListItemByName("button_list") as IWindowContainer);
            if (this._SafeStr_13989 == null){
                return;
            };
            var _local_4:Array = [];
            this._SafeStr_13989.groupChildrenWithTag("CMD_BUTTON", _local_4, true);
            for each (_local_5 in _local_4) {
                _local_5.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onButtonClicked);
            };
            _local_6 = (this._border.findChildByName("petrespect_icon") as IBitmapWrapperWindow);
            if (_local_6 != null){
                _local_11 = (this._widget.assets.getAssetByName("icon_petrespect") as BitmapDataAsset);
                _local_12 = (_local_11.content as BitmapData);
                _local_6.bitmap = _local_12.clone();
            };
            var _local_7:IBitmapWrapperWindow = (this._border.findChildByName("status_happiness_icon") as IBitmapWrapperWindow);
            if (_local_7 != null){
                _local_13 = (this._widget.assets.getAssetByName("icon_pet_happiness") as BitmapDataAsset);
                _local_14 = (_local_13.content as BitmapData);
                _local_7.bitmap = _local_14.clone();
            };
            var _local_8:IBitmapWrapperWindow = (this._border.findChildByName("status_experience_icon") as IBitmapWrapperWindow);
            if (_local_8 != null){
                _local_15 = (this._widget.assets.getAssetByName("icon_pet_experience") as BitmapDataAsset);
                _local_16 = (_local_15.content as BitmapData);
                _local_8.bitmap = _local_16.clone();
            };
            var _local_9:IBitmapWrapperWindow = (this._border.findChildByName("status_energy_icon") as IBitmapWrapperWindow);
            if (_local_9 != null){
                _local_17 = (this._widget.assets.getAssetByName("icon_pet_energy") as BitmapDataAsset);
                _local_18 = (_local_17.content as BitmapData);
                _local_9.bitmap = _local_18.clone();
            };
            for each (_local_10 in _local_4) {
                if (_local_10.parent){
                    _local_10.parent.width = _local_10.width;
                };
                _local_10.addEventListener(WindowEvent.WE_RESIZED, this.onButtonResized);
            };
        }
        private function set name(_arg_1:String):void
        {
            if (this._SafeStr_13990 == null){
                return;
            };
            var _local_2:ITextWindow = (this._SafeStr_13990.getListItemByName("name_text") as ITextWindow);
            if (_local_2 == null){
                return;
            };
            _local_2.text = _arg_1;
            _local_2.visible = true;
        }
        private function set image(_arg_1:BitmapData):void
        {
            if (this._SafeStr_13990 == null){
                return;
            };
            if (_arg_1 == null){
                return;
            };
            var _local_2:IWindowContainer = (this._SafeStr_13990.getListItemByName("image_container") as IWindowContainer);
            if (_local_2 == null){
                return;
            };
            var _local_3:IBitmapWrapperWindow = (_local_2.findChildByName("avatar_image") as IBitmapWrapperWindow);
            if (_local_3 == null){
                return;
            };
            var _local_4:BitmapData = new BitmapData(_local_3.width, _local_3.height, true, 0);
            var _local_5:Point = new Point(0, 0);
            _local_5.x = Math.round(((_local_3.width - _arg_1.width) / 2));
            _local_5.y = Math.round(((_local_3.height - _arg_1.height) / 2));
            _local_4.copyPixels(_arg_1, _arg_1.rect, _local_5);
            _local_3.bitmap = _local_4;
            _local_3.invalidate();
            this.updateWindow();
        }
        private function setLevelText(_arg_1:int, _arg_2:int):void
        {
            if (this._SafeStr_13990 == null){
                return;
            };
            var _local_3:IWindowContainer = (this._SafeStr_13990.getListItemByName("level_container") as IWindowContainer);
            if (_local_3 == null){
                return;
            };
            var _local_4:ITextWindow = (_local_3.findChildByName("level_text") as ITextWindow);
            if (_local_4 == null){
                return;
            };
            this._widget.localizations.registerParameter("pet.level", "level", _arg_1.toString());
            this._widget.localizations.registerParameter("pet.level", "maxlevel", _arg_2.toString());
            this.updateWindow();
        }
        private function set ownerName(_arg_1:String):void
        {
            this._widget.localizations.registerParameter("infostand.text.petowner", "name", _arg_1);
            this.updateWindow();
        }
        private function set raceText(_arg_1:String):void
        {
            if (this._SafeStr_13990 == null){
                return;
            };
            var _local_2:ITextWindow = (this._SafeStr_13990.getListItemByName("race_text") as ITextWindow);
            if (_local_2 == null){
                return;
            };
            _local_2.text = _arg_1;
            this.updateWindow();
        }
        private function set ageText(_arg_1:int):void
        {
            if (this._SafeStr_13990 == null){
                return;
            };
            var _local_2:ITextWindow = (this._SafeStr_13990.getListItemByName("age_text") as ITextWindow);
            if (_local_2 == null){
                return;
            };
            this._widget.localizations.registerParameter("pet.age", "age", _arg_1.toString());
            this.updateWindow();
        }
        private function set petRespect(_arg_1:int):void
        {
            this._widget.localizations.registerParameter("infostand.text.petrespect", "count", _arg_1.toString());
            if (this._SafeStr_13990 == null){
                return;
            };
            var _local_2:IWindowContainer = (this._SafeStr_13990.getListItemByName("petrespect_container") as IWindowContainer);
            var _local_3:ITextWindow = (_local_2.findChildByName("petrespect_text") as ITextWindow);
            var _local_4:IBitmapWrapperWindow = (_local_2.findChildByName("petrespect_icon") as IBitmapWrapperWindow);
            _local_4.x = ((_local_3.x + _local_3.width) + 2);
            this.updateWindow();
        }
        private function updateStateElement(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:uint, _arg_5:uint):void
        {
            var _local_9:BitmapData;
            if (this._SafeStr_13990 == null){
                return;
            };
            var _local_6:IWindowContainer = (this._SafeStr_13990.getListItemByName("status_container") as IWindowContainer);
            if (_local_6 == null){
                return;
            };
            var _local_7:ITextWindow = (_local_6.findChildByName((("status_" + _arg_1) + "_value_text")) as ITextWindow);
            if (_local_7 != null){
                _local_7.text = ((_arg_2 + "/") + _arg_3);
            };
            var _local_8:IBitmapWrapperWindow = (_local_6.findChildByName((("status_" + _arg_1) + "_bitmap")) as IBitmapWrapperWindow);
            if (_local_8 != null){
                _local_9 = this.createPercentageBar(_arg_2, _arg_3, _arg_4, _arg_5);
                if (_local_9 != null){
                    _local_8.bitmap = _local_9;
                    _local_8.width = _local_9.width;
                    _local_8.height = _local_9.height;
                    _local_8.invalidate();
                };
            };
            this.updateWindow();
        }
        protected function onButtonClicked(_arg_1:WindowMouseEvent):void
        {
            var _local_2:RoomWidgetMessage;
            var _local_3:String;
            var _local_5:int;
            var _local_4:IWindow = (_arg_1.target as IWindow);
            switch (_local_4.name){
                case "btn_pick":
                    _local_3 = RoomWidgetUserActionMessage.RWUAM_PICKUP_PET;
                    if (((this._SafeStr_13991) && ((this._SafeStr_13991.getPetId() == this._currentPetId)))){
                        this._SafeStr_13991.showWindow(false);
                    };
                    break;
                case "btn_train":
                    this.openTrainView();
                    break;
                case "btn_buy_food":
                    if (this._catalog){
                        this._catalog.openCatalogPage(CatalogPageName._SafeStr_6007, true);
                        if (((this._habboTracking) && (!(this._habboTracking.disposed)))){
                            this._habboTracking.trackGoogle("infostandBuyPetFoodButton", "click");
                        };
                    };
                    break;
                case "btn_petrespect":
                    this._widget.userData.petRespectLeft--;
                    this.updateRespectButton();
                    _local_3 = RoomWidgetUserActionMessage. RWUAM_RESPECT_PET;
                    break;
                case "btn_kick":
                    _local_2 = new RoomWidgetUserActionMessage(RoomWidgetUserActionMessage.RWUAM_KICK_USER, this._widget.petData.ownerId);
                    this._widget.messageListener.processWidgetMessage(_local_2);
                    return;
            };
            if (_local_3 != null){
                _local_5 = this._widget.petData.id;
                _local_2 = new RoomWidgetUserActionMessage(_local_3, _local_5);
                this._widget.messageListener.processWidgetMessage(_local_2);
            };
            this.updateWindow();
        }
        private function onClose(_arg_1:WindowMouseEvent):void
        {
            this._widget.close();
        }
        private function updateRespectButton():void
        {
            var _local_1:int = this._widget.userData.petRespectLeft;
            this._widget.localizations.registerParameter("infostand.button.petrespect", "count", _local_1.toString());
            this.showButton("petrespect", (_local_1 > 0));
        }
        protected function showButton(_arg_1:String, _arg_2:Boolean):void
        {
            if (this._SafeStr_13989 == null){
                return;
            };
            var _local_3:IWindow = this._SafeStr_13989.getChildByName(_arg_1);
            if (_local_3 != null){
                _local_3.visible = _arg_2;
                this.arrangeButtons();
            };
        }
        protected function onButtonResized(_arg_1:WindowEvent):void
        {
            var _local_2:IWindow = _arg_1.window.parent;
            if (((_local_2) && ((_local_2.tags.indexOf("CMD_BUTTON_REGION") > -1)))){
                _local_2.width = _arg_1.window.width;
            };
        }
        private function arrangeButtons():void
        {
            var _local_5:IWindow;
            var _local_1:int = _SafeStr_13986;
            this._SafeStr_13989.width = _local_1;
            var _local_2:Array = [];
            this._SafeStr_13989.groupChildrenWithTag("CMD_BUTTON_REGION", _local_2, true);
            var _local_3:int = _local_1;
            var _local_4:int;
            for each (_local_5 in _local_2) {
                if (_local_5.visible){
                    if ((_local_3 - _local_5.width) < 0){
                        _local_3 = _local_1;
                        _local_4 = (_local_4 + (_SafeStr_13987 + _SafeStr_13988));
                    };
                    _local_5.x = (_local_3 - _local_5.width);
                    _local_5.y = _local_4;
                    _local_3 = (_local_5.x - _SafeStr_13988);
                };
            };
            this._SafeStr_13989.height = (_local_4 + _SafeStr_13987);
            this.updateWindow();
        }

    }
}//package com.sulake.habbo.ui.widget.infostand

// getRaceLocalizationKey = "_-2x5" (String#1971, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// _border = "_-0NB" (String#815, DoABC#2)
// CatalogPageName = "_-mv" (String#24149, DoABC#2)
// isOwnPet = "_-1g3" (String#18141, DoABC#2)
// _SafeStr_13972 = "_-rA" (String#24322, DoABC#2)
// _SafeStr_13973 = "_-0tO" (String#16175, DoABC#2)
// _SafeStr_13974 = "_-0D4" (String#14571, DoABC#2)
// _SafeStr_13975 = "_-07m" (String#14354, DoABC#2)
// _SafeStr_13976 = "_-1RC" (String#17554, DoABC#2)
// _SafeStr_13977 = "_-1R2" (String#17549, DoABC#2)
// _SafeStr_13978 = "_-2wV" (String#21327, DoABC#2)
// _SafeStr_13979 = "_-C" (String#22689, DoABC#2)
// _SafeStr_13980 = "_-wo" (String#24560, DoABC#2)
// _SafeStr_13981 = "_-3GH" (String#22132, DoABC#2)
// _SafeStr_13982 = "_-2GX" (String#19662, DoABC#2)
// _SafeStr_13983 = "_-TP" (String#23381, DoABC#2)
// _SafeStr_13984 = "_-YH" (String#23572, DoABC#2)
// _SafeStr_13985 = "_-1ub" (String#18740, DoABC#2)
// _SafeStr_13986 = "_-1hI" (String#18185, DoABC#2)
// _SafeStr_13987 = "_-nj" (String#24181, DoABC#2)
// _SafeStr_13988 = "_-1f" (String#18097, DoABC#2)
// _SafeStr_13989 = "_-1WU" (String#5481, DoABC#2)
// _SafeStr_13990 = "_-38U" (String#2009, DoABC#2)
// _SafeStr_13991 = "_-28A" (String#19336, DoABC#2)
// _currentPetId = "_-2l0" (String#6980, DoABC#2)
// refreshContainer = "_-Ez" (String#22811, DoABC#2)
// raceText = "_-1CL" (String#16958, DoABC#2)
// ageText = "_-2aY" (String#20466, DoABC#2)
// setLevelText = "_-24Y" (String#19203, DoABC#2)
// updateStateElement = "_-1Lw" (String#17354, DoABC#2)
// updateRespectButton = "_-op" (String#8686, DoABC#2)
// showCommandToolForPet = "_-19V" (String#16837, DoABC#2)
// getCurrentPetId = "_-01n" (String#14121, DoABC#2)
// updateEnabledTrainingCommands = "_-1L2" (String#17315, DoABC#2)
// setEnabledCommands = "_-3A2" (String#21886, DoABC#2)
// createPercentageBar = "_-tU" (String#24426, DoABC#2)
// openTrainView = "_-14d" (String#16639, DoABC#2)
// onButtonResized = "_-1lR" (String#5774, DoABC#2)
// getPetId = "_-2AE" (String#19413, DoABC#2)
// arrangeButtons = "_-1UF" (String#5437, DoABC#2)
// IBorderWindow = "_-0Br" (String#1422, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// InfoStandPetView = "_-3CN" (String#7558, DoABC#2)
// CommandConfiguration = "_-2sa" (String#21184, DoABC#2)
// InfoStandPetData = "_-1oA" (String#5821, DoABC#2)
// RoomWidgetUserActionMessage = "_-22U" (String#19109, DoABC#2)
// PetCommandTool = "_-1zX" (String#6025, DoABC#2)
// RWUAM_KICK_USER = "_-02D" (String#14135, DoABC#2)
// RWUAM_PICKUP_PET = "_-2JW" (String#19790, DoABC#2)
//  RWUAM_RESPECT_PET = "_-0nn" (String#15968, DoABC#2)
// petRespectLeft = "_-0wV" (String#4782, DoABC#2)
// onButtonClicked = "_-2k0" (String#247, DoABC#2)
// getInstance = "_-n5" (String#24157, DoABC#2)
// ownerName = "_-1e1" (String#1730, DoABC#2)
// WE_RESIZED = "_-76" (String#22505, DoABC#2)
// scrollableRegion = "_-2ku" (String#6976, DoABC#2)
// showWindow = "_-2ve" (String#21300, DoABC#2)
// onClose = "_-2Ts" (String#54, DoABC#2)
// IHabboTracking = "_-0fl" (String#4419, DoABC#2)
// _SafeStr_6007 = "_-0ZX" (String#15424, DoABC#2)
// levelMax = "_-2dd" (String#6823, DoABC#2)
// experienceMax = "_-1bq" (String#5596, DoABC#2)
// energyMax = "_-8m" (String#7836, DoABC#2)
// nutrition = "_-0yZ" (String#4819, DoABC#2)
// nutritionMax = "_-1m9" (String#5783, DoABC#2)
// ownerId = "_-0Kl" (String#3968, DoABC#2)
// updateWindow = "_-2s1" (String#451, DoABC#2)
// showButton = "_-P4" (String#461, DoABC#2)
// trackGoogle = "_-3Fx" (String#7630, DoABC#2)
// petRespect = "_-2a9" (String#6762, DoABC#2)
// canOwnerBeKicked = "_-2Yz" (String#20395, DoABC#2)
// isVisible = "_-1rE" (String#18592, DoABC#2)
// groupChildrenWithTag = "_-cU" (String#2141, DoABC#2)


