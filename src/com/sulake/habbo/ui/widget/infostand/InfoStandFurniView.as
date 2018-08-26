
package com.sulake.habbo.ui.widget.infostand
{
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.IBorderWindow;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.tracking.IHabboTracking;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.tracking.HabboTracking;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniActionMessage;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetInfostandExtraParamEnum;
    import com.sulake.habbo.ui.widget.events.RoomWidgetFurniInfoUpdateEvent;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.events.WindowEvent;

    public class InfoStandFurniView 
    {

        protected var _window:IItemListWindow;
        protected var _border:IBorderWindow;
        protected var _buttons:IItemListWindow;
        protected var _catalog:IHabboCatalog;
        protected var _habboTracking:IHabboTracking;
        protected var _SafeStr_14009:IWindow;
        protected var _widget:InfostandWidget;
        protected var _SafeStr_13990:IItemListWindow;

        public function InfoStandFurniView(_arg_1:InfostandWidget, _arg_2:String, _arg_3:IHabboCatalog)
        {
            this._widget = _arg_1;
            this._catalog = _arg_3;
            this._habboTracking = HabboTracking.getInstance();
            this.createWindow(_arg_2);
        }
        public function dispose():void
        {
            this._catalog = null;
            this._widget = null;
            this._window.dispose();
            this._window = null;
        }
        public function get window():IItemListWindow
        {
            return (this._window);
        }
        protected function createWindow(_arg_1:String):void
        {
            var _local_4:IWindow;
            var _local_5:int;
            var _local_2:XmlAsset = (this._widget.assets.getAssetByName("furni_view") as XmlAsset);
            this._window = (this._widget.windowManager.buildFromXML((_local_2.content as XML)) as IItemListWindow);
            if (this._window == null){
                throw (new Error("Failed to construct window from XML!"));
            };
            this._border = (this._window.getListItemByName("info_border") as IBorderWindow);
            this._buttons = (this._window.getListItemByName("button_list") as IItemListWindow);
            if (this._border != null){
                this._SafeStr_13990 = (this._border.findChildByName("infostand_element_list") as IItemListWindow);
            };
            this._window.name = _arg_1;
            this._widget.mainContainer.addChild(this._window);
            var _local_3:IWindow = this._border.findChildByTag("close");
            if (_local_3 != null){
                _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.PollOfferDialog);
            };
            if (this._buttons != null){
                _local_5 = 0;
                while (_local_5 < this._buttons.numListItems) {
                    _local_4 = this._buttons.getListItemAt(_local_5);
                    _local_4.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.InfoStandUserView);
                    _local_5++;
                };
            };
            this._SafeStr_14009 = this._border.findChildByTag("catalog");
            if (this._SafeStr_14009 != null){
                this._SafeStr_14009.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.InfoStandFurniView);
            };
        }
        protected function PollOfferDialog(_arg_1:WindowMouseEvent):void
        {
            this._widget.close();
        }
        public function set name(_arg_1:String):void
        {
            var _local_2:ITextWindow = (this._SafeStr_13990.getListItemByName("name_text") as ITextWindow);
            if (_local_2 == null){
                return;
            };
            _local_2.text = _arg_1;
            _local_2.visible = true;
            _local_2.height = (_local_2.textHeight + 5);
            this.InfoStandUserView();
        }
        public function set image(_arg_1:BitmapData):void
        {
            if (_arg_1 == null){
                return;
            };
            var _local_2:IBitmapWrapperWindow = (this._SafeStr_13990.getListItemByName("image") as IBitmapWrapperWindow);
            if (_local_2 == null){
                return;
            };
            var _local_3:BitmapData = new BitmapData(_local_2.width, _arg_1.height, true, 0);
            var _local_4:Point = new Point(((_local_2.width - _arg_1.width) / 2), 0);
            _local_3.copyPixels(_arg_1, _arg_1.rect, _local_4);
            _local_2.height = _arg_1.height;
            _local_2.bitmap = _local_3;
            _local_2.invalidate();
            this.InfoStandUserView();
        }
        public function set description(_arg_1:String):void
        {
            var _local_2:ITextWindow = (this._SafeStr_13990.getListItemByName("description_text") as ITextWindow);
            if (_local_2 == null){
                return;
            };
            _local_2.text = _arg_1;
            _local_2.height = (_local_2.textHeight + 5);
            this.InfoStandUserView();
        }
        private function set expiration(_arg_1:int):void
        {
            var _local_2:ITextWindow = (this._SafeStr_13990.getListItemByName("expiration_text") as ITextWindow);
            var _local_3:IWindowContainer = (this._SafeStr_13990.getListItemByName("expiration_spacer") as IWindowContainer);
            if ((((_local_2 == null)) || ((_local_3 == null)))){
                return;
            };
            this._widget.localizations.registerParameter("infostand.rent.expiration", "minutes", _arg_1.toString());
            if (_arg_1 <= 0){
                _local_2.height = 0;
                _local_3.height = 0;
            }
            else {
                _local_2.height = (_local_2.textHeight + 5);
                _local_3.height = 1;
            };
            this.InfoStandUserView();
        }
        protected function InfoStandUserView(_arg_1:WindowMouseEvent):void
        {
            var _local_2:RoomWidgetMessage;
            var _local_3:String;
            var _local_4:String;
            var _local_6:int;
            var _local_7:int;
            var _local_5:IWindow = (_arg_1.target as IWindow);
            switch (_local_5.name){
                case "rotate":
                    _local_3 = RoomWidgetFurniActionMessage.RWFUAM_ROTATE;
                    break;
                case "move":
                    _local_3 = RoomWidgetFurniActionMessage.RWFAM_MOVE;
                    break;
                case "pickup":
                    _local_3 = RoomWidgetFurniActionMessage.RWFAM_PICKUP;
                    this._widget.close();
                    break;
                case "save_branding_configuration":
                    _local_3 = RoomWidgetFurniActionMessage.RWFAM_SAVE_STUFF_DATA;
                    _local_4 = this.InfoStandFurniView();
                    break;
                case "use":
                    _local_3 = RoomWidgetFurniActionMessage.RWFAM_USE;
                    break;
            };
            if (_local_3 != null){
                _local_6 = this._widget.furniData.id;
                _local_7 = this._widget.furniData.category;
                _local_2 = new RoomWidgetFurniActionMessage(_local_3, _local_6, _local_7, _local_4);
                this._widget.messageListener.processWidgetMessage(_local_2);
            };
        }
        protected function InfoStandFurniView(_arg_1:WindowMouseEvent):void
        {
            var _local_2:int;
            var _local_3:int;
            if (this._catalog){
                _local_2 = this._widget.furniData.catalogPageId;
                _local_3 = this._widget.furniData.offerId;
                if (_local_2 > -1){
                    this._catalog.openCatalogPageById(_local_2, _local_3);
                    if (((this._habboTracking) && (!(this._habboTracking.disposed)))){
                        this._habboTracking.trackGoogle("infostandCatalogButton", "offer", _local_3);
                    };
                };
            };
        }
        protected function InfoStandUserView():void
        {
            if ((((((this._SafeStr_13990 == null)) || ((this._border == null)))) || ((this._buttons == null)))){
                return;
            };
            this._buttons.width = this._buttons.scrollableRegion.width;
            this._SafeStr_13990.height = this._SafeStr_13990.scrollableRegion.height;
            this._border.height = (this._SafeStr_13990.height + 20);
            this._window.width = Math.max(this._border.width, this._buttons.width);
            this._window.height = this._window.scrollableRegion.height;
            if (this._border.width < this._buttons.width){
                this._border.x = (this._window.width - this._border.width);
                this._buttons.x = 0;
            }
            else {
                this._buttons.x = (this._window.width - this._buttons.width);
                this._border.x = 0;
            };
            this._widget.InfostandWidget();
        }
        public function update(_arg_1:RoomWidgetFurniInfoUpdateEvent):void
        {
            this.name = _arg_1.name;
            this.description = _arg_1.description;
            this.image = _arg_1.image;
            this.expiration = _arg_1.expiration;
            var _local_2:Boolean;
            var _local_3:Boolean;
            var _local_4:Boolean;
            var _local_5:Boolean;
            var _local_6:Boolean;
            if (_arg_1.isRoomController){
                _local_2 = true;
                _local_3 = true;
            };
            if (((_arg_1.isRoomOwner) || (_arg_1.isAnyRoomController))){
                _local_2 = true;
                _local_3 = true;
                _local_4 = true;
            };
            if (_local_3){
                _local_3 = !(_arg_1.isWallItem);
            };
            if (_arg_1.isStickie){
                _local_4 = false;
            };
            if (_arg_1.isAnyRoomController){
                _local_5 = true;
            };
            if ((((_arg_1.extraParam == RoomWidgetInfostandExtraParamEnum.RWEIEP_USABLE)) || ((((_arg_1.extraParam == RoomWidgetInfostandExtraParamEnum.RWEIEP_JUKEBOX)) && (_arg_1.isRoomOwner))))){
                _local_6 = this._widget.config.getBoolean("infostand.use.button.enabled", false);
            };
            this.InfoStandUserView("move", _local_2);
            this.InfoStandUserView("rotate", _local_3);
            this.InfoStandUserView("pickup", _local_4);
            this.InfoStandUserView("use", _local_6);
            this.InfoStandFurniView(_local_5);
            if (_arg_1.catalogPageId < 0){
                this.InfoStandFurniView(false);
            }
            else {
                this.InfoStandFurniView(true);
            };
            this._buttons.visible = ((((((_local_2) || (_local_3))) || (_local_4))) || (_local_6));
            this.InfoStandUserView();
        }
        private function InfoStandFurniView(_arg_1:String, _arg_2:String):void
        {
            var _local_3:XmlAsset;
            var _local_4:IWindowContainer;
            var _local_5:IWindow;
            var _local_6:IWindow;
            if (this._SafeStr_13990 != null){
                _local_3 = (this._widget.assets.getAssetByName("furni_view_branding_element") as XmlAsset);
                if (_local_3 != null){
                    _local_4 = (this._widget.windowManager.buildFromXML((_local_3.content as XML)) as IWindowContainer);
                    if (_local_4 != null){
                        _local_5 = _local_4.findChildByName("element_name");
                        if (_local_5 != null){
                            _local_5.caption = _arg_1;
                        };
                        _local_6 = _local_4.findChildByName("element_value");
                        if (_local_6 != null){
                            _local_6.caption = _arg_2;
                            _local_6.addEventListener(WindowKeyboardEvent.WKE_KEY_DOWN, this.InfoStandFurniView);
                        };
                        if (((!((_local_5 == null))) && (!((_local_6 == null))))){
                            this._SafeStr_13990.addListItem(_local_4);
                        };
                    };
                };
            };
        }
        private function InfoStandFurniView():Map
        {
            var _local_2:String;
            var _local_3:Array;
            var _local_4:String;
            var _local_5:Array;
            var _local_6:String;
            var _local_7:String;
            var _local_1:Map = new Map();
            if (this._widget != null){
                _local_2 = this._widget.furniData.extraParam.substr(RoomWidgetInfostandExtraParamEnum.RWEIEP_BRANDING_OPTIONS.length);
                _local_3 = _local_2.split("\t");
                if (_local_3 != null){
                    for each (_local_4 in _local_3) {
                        _local_5 = _local_4.split("=", 2);
                        if (((!((_local_5 == null))) && ((_local_5.length == 2)))){
                            _local_6 = _local_5[0];
                            _local_7 = _local_5[1];
                            _local_1.add(_local_6, _local_7);
                        };
                    };
                };
            };
            return (_local_1);
        }
        private function InfoStandFurniView():String
        {
            var _local_2:Array;
            var _local_3:IWindowContainer;
            var _local_4:IWindow;
            var _local_5:IWindow;
            var _local_6:String;
            var _local_7:String;
            var _local_1:String = "";
            if (this._border != null){
                _local_2 = [];
                this._border.WindowController("branding_element", _local_2, true);
                if (_local_2.length > 0){
                    for each (_local_3 in _local_2) {
                        _local_4 = _local_3.findChildByName("element_name");
                        _local_5 = _local_3.findChildByName("element_value");
                        if (((!((_local_4 == null))) && (!((_local_5 == null))))){
                            _local_6 = this.InfoStandFurniView(_local_4.caption);
                            _local_7 = this.InfoStandFurniView(_local_5.caption);
                            _local_1 = (_local_1 + (((_local_6 + "=") + _local_7) + "\t"));
                        };
                    };
                };
            };
            return (_local_1);
        }
        private function InfoStandFurniView(_arg_1:String):String
        {
            if (_arg_1 != null){
                if (_arg_1.indexOf("\t") != -1){
                    return (_arg_1.replace("\t", ""));
                };
            };
            return (_arg_1);
        }
        private function InfoStandFurniView(_arg_1:Boolean):void
        {
            var _local_6:IWindow;
            var _local_7:String;
            var _local_8:Map;
            var _local_9:String;
            var _local_10:String;
            if ((((this._widget == null)) || ((this._border == null)))){
                return;
            };
            var _local_2:IWindow = this._border.findChildByName("furni_details_spacer");
            if (_local_2 != null){
                _local_2.visible = _arg_1;
            };
            var _local_3:Array = [];
            this._border.WindowController("branding_element", _local_3, true);
            if (_local_3.length > 0){
                for each (_local_6 in _local_3) {
                    this._border.removeChild(_local_6);
                    _local_6.dispose();
                };
            };
            var _local_4:Boolean;
            var _local_5:IWindow = (this._border.findChildByName("furni_details_text") as ITextWindow);
            if (_local_5 != null){
                _local_5.visible = _arg_1;
                _local_7 = ("id: " + this._widget.furniData.id);
                _local_8 = this.InfoStandFurniView();
                if (_local_8.length > 0){
                    _local_4 = true;
                    for each (_local_9 in _local_8.getKeys()) {
                        _local_10 = _local_8.getValue(_local_9);
                        this.InfoStandFurniView(_local_9, _local_10);
                    };
                };
                _local_5.caption = _local_7;
            };
            this.InfoStandUserView("save_branding_configuration", _local_4);
        }
        private function InfoStandFurniView(_arg_1:WindowEvent=null, _arg_2:IWindow=null):void
        {
        }
        private function InfoStandUserView(_arg_1:String, _arg_2:Boolean):void
        {
            if (this._buttons == null){
                return;
            };
            var _local_3:IWindow = this._buttons.getListItemByName(_arg_1);
            if (_local_3 != null){
                _local_3.visible = _arg_2;
                this._buttons.IItemListWindow();
            };
        }
        private function InfoStandFurniView(_arg_1:Boolean):void
        {
            if (_arg_1){
                if (!this._SafeStr_13990.getListItemByName("catalog_button")){
                    this._SafeStr_13990.addListItem(this._SafeStr_14009);
                };
                this._SafeStr_14009.visible = _arg_1;
            }
            else {
                this._SafeStr_13990.removeListItem(this._SafeStr_14009);
            };
        }

    }
}//package com.sulake.habbo.ui.widget.infostand

// openCatalogPageById = "_-1I6" (String#5209, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// _border = "_-0NB" (String#815, DoABC#2)
// _SafeStr_13990 = "_-38U" (String#2009, DoABC#2)
// InfostandWidget = "_-Ez" (String#22811, DoABC#2)
// _SafeStr_14009 = "_-ST" (String#23345, DoABC#2)
// InfoStandFurniView = "_-TK" (String#23378, DoABC#2)
// InfoStandFurniView = "_-1cH" (String#17982, DoABC#2)
// InfoStandFurniView = "_-k3" (String#24036, DoABC#2)
// InfoStandFurniView = "_-05V" (String#14262, DoABC#2)
// InfoStandFurniView = "_-2Pa" (String#20027, DoABC#2)
// InfoStandFurniView = "_-0fR" (String#15649, DoABC#2)
// InfoStandFurniView = "_-34C" (String#21667, DoABC#2)
// InfoStandFurniView = "_-2cb" (String#20549, DoABC#2)
// IBorderWindow = "_-0Br" (String#1422, DoABC#2)
// WindowKeyboardEvent = "_-0Di" (String#1433, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetInfostandExtraParamEnum = "_-2ru" (String#7121, DoABC#2)
// RoomWidgetFurniActionMessage = "_-02g" (String#3622, DoABC#2)
// InfoStandFurniView = "_-1e5" (String#5631, DoABC#2)
// RoomWidgetFurniInfoUpdateEvent = "_-1V1" (String#5455, DoABC#2)
// RWFUAM_ROTATE = "_-1J1" (String#17237, DoABC#2)
// RWFAM_MOVE = "_-07t" (String#14359, DoABC#2)
// RWFAM_PICKUP = "_-0VQ" (String#15258, DoABC#2)
// RWFAM_USE = "_-7c" (String#22527, DoABC#2)
// RWFAM_SAVE_STUFF_DATA = "_-0oi" (String#16001, DoABC#2)
// InfoStandUserView = "_-2k0" (String#247, DoABC#2)
// getInstance = "_-n5" (String#24157, DoABC#2)
// RWEIEP_JUKEBOX = "_-2Bo" (String#19475, DoABC#2)
// RWEIEP_BRANDING_OPTIONS = "_-1ob" (String#18481, DoABC#2)
// RWEIEP_USABLE = "_-0ax" (String#15472, DoABC#2)
// scrollableRegion = "_-2ku" (String#6976, DoABC#2)
// offerId = "_-9g" (String#928, DoABC#2)
// extraParam = "_-AM" (String#7874, DoABC#2)
// expiration = "_-1G1" (String#1648, DoABC#2)
// PollOfferDialog = "_-2Ts" (String#54, DoABC#2)
// IHabboTracking = "_-0fl" (String#4419, DoABC#2)
// WKE_KEY_DOWN = "_-fs" (String#23884, DoABC#2)
// isRoomController = "_-xz" (String#8838, DoABC#2)
// isRoomOwner = "_-ZP" (String#8405, DoABC#2)
// isAnyRoomController = "_-2IH" (String#6407, DoABC#2)
// InfoStandUserView = "_-2s1" (String#451, DoABC#2)
// InfoStandUserView = "_-P4" (String#461, DoABC#2)
// trackGoogle = "_-3Fx" (String#7630, DoABC#2)
// catalogPageId = "_-2oc" (String#7050, DoABC#2)
// isStickie = "_-15M" (String#16668, DoABC#2)
// isWallItem = "_-92" (String#22582, DoABC#2)
// WindowController = "_-cU" (String#2141, DoABC#2)
// IItemListWindow = "_-0fG" (String#4411, DoABC#2)


