
package com.sulake.habbo.ui.widget.infostand
{
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBorderWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import flash.geom.Point;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetGetBadgeDetailsMessage;
    import flash.geom.Rectangle;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomTagSearchMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetChangeMottoMessage;
    import flash.ui.Keyboard;
    import flash.utils.getTimer;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
    import com.sulake.habbo.tracking.HabboTracking;

    public class InfoStandUserView 
    {

        private const _SafeStr_14020:int = 5;
        private const _SafeStr_14021:int = 3;
        private const _SafeStr_14022:int = 0xAAAAAA;
        private const _SafeStr_14023:int = 0xFFFFFF;
        private const _SafeStr_14024:int = 2000;
        private const _SafeStr_14025:int = 50;
        private const _SafeStr_14026:int = 23;

        protected var _widget:InfostandWidget;
        protected var _window:IItemListWindow;
        protected var _SafeStr_13990:IItemListWindow;
        protected var _SafeStr_13989:IWindowContainer;
        private var _border:IBorderWindow;
        private var _SafeStr_4206:TagListRenderer;
        private var _SafeStr_14027:IBorderWindow;
        private var _SafeStr_14028:int;
        private var _SafeStr_14029:Boolean = true;

        public function InfoStandUserView(_arg_1:InfostandWidget, _arg_2:String)
        {
            this._widget = _arg_1;
            this.createWindow(_arg_2, false);
            this._SafeStr_4206 = new TagListRenderer(_arg_1, this.InfoStandUserView);
            this._SafeStr_14029 = !(this._widget.config.getBoolean("menu.avatar.enabled", false));
        }
        public function dispose():void
        {
            this._widget = null;
            this._window.dispose();
            this._window = null;
            this._SafeStr_4206.dispose();
            this._SafeStr_4206 = null;
            this.InfoStandUserView();
        }
        public function get window():IItemListWindow
        {
            return (this._window);
        }
        protected function InfoStandUserView():void
        {
            if ((((((this._SafeStr_13990 == null)) || ((this._border == null)))) || ((this._SafeStr_13989 == null)))){
                return;
            };
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
            this._widget.InfostandWidget();
        }
        protected function createWindow(_arg_1:String, _arg_2:Boolean):void
        {
            var _local_4:IWindow;
            var _local_7:IWindow;
            var _local_10:BitmapDataAsset;
            var _local_11:BitmapData;
            var _local_12:IBitmapWrapperWindow;
            var _local_13:BitmapDataAsset;
            this._window = (this._widget.getXmlWindow("user_view") as IItemListWindow);
            if (this._window == null){
                throw (new Error("Failed to construct window from XML!"));
            };
            this._border = (this._window.getListItemByName("info_border") as IBorderWindow);
            this._SafeStr_13989 = (this._window.getListItemByName("button_list") as IWindowContainer);
            var _local_3:Array = [];
            this._SafeStr_13989.WindowController("CMD_BUTTON", _local_3, true);
            for each (_local_4 in _local_3) {
                if (_local_4.parent){
                    _local_4.parent.width = _local_4.width;
                };
                _local_4.addEventListener(WindowEvent.WE_RESIZED, this.InfoStandUserView);
                _local_4.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.InfoStandUserView);
            };
            if (this._border != null){
                this._SafeStr_13990 = (this._border.findChildByName("infostand_element_list") as IItemListWindow);
            };
            this._window.name = _arg_1;
            var _local_5:IBitmapWrapperWindow = (this._border.findChildByName("home_icon") as IBitmapWrapperWindow);
            if (((!((_local_5 == null))) && (!(_arg_2)))){
                _local_5.bitmap = new BitmapData(_local_5.width, _local_5.height, true, 0);
                _local_10 = (this._widget.assets.getAssetByName("icon_home") as BitmapDataAsset);
                _local_11 = (_local_10.content as BitmapData);
                _local_5.bitmap = new BitmapData(_local_5.width, _local_5.height, true, 0);
                _local_5.bitmap.copyPixels(_local_11, _local_11.rect, new Point(0, 0));
                _local_5.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.InfoStandUserView);
            };
            this._widget.mainContainer.addChild(this._window);
            var _local_6:IWindow = this._border.findChildByTag("close");
            if (_local_6 != null){
                _local_6.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.PollOfferDialog);
            };
            var _local_8:int;
            while (_local_8 < 5) {
                _local_7 = this._border.findChildByName(("badge_" + _local_8));
                if (_local_7 != null){
                    _local_7.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.InfoStandUserView);
                    _local_7.addEventListener(WindowMouseEvent.WME_OUT, this.InfoStandUserView);
                };
                _local_8++;
            };
            _local_7 = this._border.findChildByName("badge_group");
            if (((!((_local_7 == null))) && (!(_arg_2)))){
                _local_7.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.InfoStandUserView);
                _local_7.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.InfoStandUserView);
                _local_7.addEventListener(WindowMouseEvent.WME_OUT, this.InfoStandUserView);
            };
            var _local_9:IWindowContainer = (this._SafeStr_13990.getListItemByName("motto_container") as IWindowContainer);
            if (_local_9){
                _local_12 = (_local_9.findChildByName("changemotto.image") as IBitmapWrapperWindow);
                _local_13 = (this._widget.assets.getAssetByName("changemotto") as BitmapDataAsset);
                if (((_local_12) && (_local_13))){
                    if (_local_12.bitmap == null){
                        _local_12.bitmap = new BitmapData(_local_12.width, _local_12.height, true, 0);
                    };
                    this.InfoStandUserView(_local_12.bitmap, (_local_13.content as BitmapData));
                    _local_12.invalidate();
                };
            };
        }
        private function InfoStandUserView(_arg_1:WindowMouseEvent):void
        {
            if (this._widget.userData.groupId < 0){
                return;
            };
            var _local_2:RoomWidgetGetBadgeDetailsMessage = new RoomWidgetGetBadgeDetailsMessage(this._widget.userData.groupId);
            this._widget.messageListener.processWidgetMessage(_local_2);
        }
        private function InfoStandUserView(_arg_1:WindowMouseEvent):void
        {
            if (this._widget.userData.groupId < 0){
                return;
            };
            this.InfoStandUserView();
            var _local_2:IBitmapWrapperWindow = (_arg_1.window as IBitmapWrapperWindow);
            if (_local_2 == null){
                return;
            };
            this._SafeStr_14027.findChildByName("name").caption = "${group.badgepopup.caption}";
            this._SafeStr_14027.findChildByName("description").caption = "${group.badgepopup.body}";
            var _local_3:Rectangle = new Rectangle();
            _local_2.WindowController(_local_3);
            this._SafeStr_14027.x = (_local_3.left - this._SafeStr_14027.width);
            this._SafeStr_14027.y = (_local_3.top + ((_local_3.height - this._SafeStr_14027.height) / 2));
        }
        private function InfoStandUserView(_arg_1:WindowMouseEvent):void
        {
            this.InfoStandUserView();
        }
        private function InfoStandUserView(_arg_1:WindowMouseEvent):void
        {
            var _local_6:ITextWindow;
            var _local_2:IBitmapWrapperWindow = (_arg_1.window as IBitmapWrapperWindow);
            if (_local_2 == null){
                return;
            };
            var _local_3:int = int(_local_2.name.replace("badge_", ""));
            if (_local_3 < 0){
                return;
            };
            var _local_4:Array = this._widget.userData.badges;
            if (_local_4 == null){
                return;
            };
            if (_local_3 >= _local_4.length){
                return;
            };
            var _local_5:String = this._widget.userData.badges[_local_3];
            if (_local_5 == null){
                return;
            };
            this.InfoStandUserView();
            _local_6 = (this._SafeStr_14027.getChildByName("name") as ITextWindow);
            if (_local_6 != null){
                _local_6.text = this._widget.localizations.getBadgeName(_local_5);
            };
            _local_6 = (this._SafeStr_14027.getChildByName("description") as ITextWindow);
            if (_local_6 != null){
                _local_6.text = this._widget.localizations.getBadgeDesc(_local_5);
            };
            var _local_7:Rectangle = new Rectangle();
            _local_2.WindowController(_local_7);
            this._SafeStr_14027.x = (_local_7.left - this._SafeStr_14027.width);
            this._SafeStr_14027.y = (_local_7.top + ((_local_7.height - this._SafeStr_14027.height) / 2));
        }
        private function InfoStandUserView(_arg_1:WindowMouseEvent):void
        {
            this.InfoStandUserView();
        }
        private function InfoStandUserView():void
        {
            if (this._SafeStr_14027 != null){
                return;
            };
            var _local_1:XmlAsset = (this._widget.assets.getAssetByName("badge_details") as XmlAsset);
            if (_local_1 == null){
                return;
            };
            this._SafeStr_14027 = (this._widget.windowManager.buildFromXML((_local_1.content as XML)) as IBorderWindow);
            if (this._SafeStr_14027 == null){
                throw (new Error("Failed to construct window from XML!"));
            };
        }
        private function InfoStandUserView():void
        {
            if (this._SafeStr_14027 != null){
                this._SafeStr_14027.dispose();
                this._SafeStr_14027 = null;
            };
        }
        private function PollOfferDialog(_arg_1:WindowMouseEvent):void
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
        }
        public function set realName(_arg_1:String):void
        {
            var _local_2:ITextWindow = (this._SafeStr_13990.getListItemByName("realname_text") as ITextWindow);
            if (_local_2 == null){
                return;
            };
            if (_arg_1.length == 0){
                _local_2.text = "";
            }
            else {
                this._widget.localizations.registerParameter("infostand.text.realname", "realname", _arg_1);
                _local_2.text = this._widget.localizations.getKey("infostand.text.realname");
            };
            _local_2.height = (_local_2.textHeight + this._SafeStr_14020);
            _local_2.visible = (_arg_1.length > 0);
        }
        public function set image(_arg_1:BitmapData):void
        {
            var _local_2:IWindowContainer = (this._SafeStr_13990.getListItemByName("image_and_badges_container") as IWindowContainer);
            if (!_local_2){
                return;
            };
            var _local_3:IBitmapWrapperWindow = (_local_2.findChildByName("avatar_image") as IBitmapWrapperWindow);
            if (_local_3 == null){
                return;
            };
            _local_3.bitmap = _arg_1;
            _local_3.width = _arg_1.width;
            _local_3.height = _arg_1.height;
            _local_3.invalidate();
        }
        public function InfoStandUserView(_arg_1:String, _arg_2:Boolean):void
        {
            var _local_3:IWindowContainer = (this._SafeStr_13990.getListItemByName("motto_container") as IWindowContainer);
            if (!_local_3){
                return;
            };
            var _local_4:IBitmapWrapperWindow = (_local_3.findChildByName("changemotto.image") as IBitmapWrapperWindow);
            var _local_5:ITextWindow = (_local_3.findChildByName("motto_text") as ITextWindow);
            var _local_6:IWindowContainer = (this._SafeStr_13990.getListItemByName("motto_spacer") as IWindowContainer);
            if ((((_local_5 == null)) || ((_local_6 == null)))){
                return;
            };
            if (_arg_1 == null){
                _arg_1 = "";
            };
            if (_arg_2){
                _local_4.visible = true;
                if (_arg_1 == ""){
                    _arg_1 = this._widget.localizations.getKey("infostand.motto.change");
                    _local_5.textColor = this._SafeStr_14022;
                }
                else {
                    _local_5.textColor = this._SafeStr_14023;
                };
                _local_5.enable();
            }
            else {
                _local_4.visible = false;
                _local_5.textColor = this._SafeStr_14023;
                _local_5.disable();
            };
            if (this._widget.config.getKey("infostand.motto.change.enabled", "1") == "0"){
                _local_5.disable();
            };
            _local_5.text = _arg_1;
            _local_5.height = Math.min((_local_5.textHeight + this._SafeStr_14020), this._SafeStr_14025);
            _local_5.height = Math.max(_local_5.height, this._SafeStr_14026);
            _local_3.height = (_local_5.height + this._SafeStr_14021);
            if (_arg_2){
                _local_5.addEventListener(WindowKeyboardEvent.WKE_KEY_UP, this.InfoStandUserView);
                _local_5.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.InfoStandUserView);
            }
            else {
                _local_5.removeEventListener(WindowKeyboardEvent.WKE_KEY_UP, this.InfoStandUserView);
            };
            this.InfoStandUserView();
        }
        public function set achievementScore(_arg_1:int):void
        {
            var _local_2:ITextWindow = (this._SafeStr_13990.getListItemByName("score_value") as ITextWindow);
            if (_local_2 == null){
                return;
            };
            _local_2.text = String(_arg_1);
        }
        public function set carryItem(_arg_1:int):void
        {
            var _local_6:String;
            var _local_2:ITextWindow = (this._SafeStr_13990.getListItemByName("handitem_txt") as ITextWindow);
            var _local_3:IWindowContainer = (this._SafeStr_13990.getListItemByName("handitem_spacer") as IWindowContainer);
            if ((((_local_2 == null)) || ((_local_3 == null)))){
                return;
            };
            if (_arg_1 > 0){
                _local_6 = this._widget.localizations.getKey(("handitem" + _arg_1), ("handitem" + _arg_1));
                this._widget.localizations.registerParameter("infostand.text.handitem", "item", _local_6);
            };
            _local_2.height = (_local_2.textHeight + this._SafeStr_14020);
            var _local_4:Boolean = _local_2.visible;
            var _local_5 = (_arg_1 > 0);
            _local_2.visible = _local_5;
            _local_3.visible = _local_5;
            if (_local_5 != _local_4){
                this._SafeStr_13990.IItemListWindow();
            };
            this.InfoStandUserView();
        }
        public function set xp(_arg_1:int):void
        {
            var _local_2:ITextWindow = (this._SafeStr_13990.getListItemByName("xp_text") as ITextWindow);
            var _local_3:IWindowContainer = (this._SafeStr_13990.getListItemByName("xp_spacer") as IWindowContainer);
            if ((((_local_2 == null)) || ((_local_3 == null)))){
                return;
            };
            this._widget.localizations.registerParameter("infostand.text.xp", "xp", _arg_1.toString());
            _local_2.height = (_local_2.textHeight + this._SafeStr_14020);
            var _local_4:Boolean = _local_2.visible;
            var _local_5 = (_arg_1 > 0);
            _local_2.visible = _local_5;
            _local_3.visible = _local_5;
            if (_local_5 != _local_4){
                this._SafeStr_13990.IItemListWindow();
            };
            this.InfoStandUserView();
        }
        public function InfoStandUserView(_arg_1:Array, _arg_2:Array=null):void
        {
            var _local_3:IWindowContainer = (this._SafeStr_13990.getListItemByName("tags_container") as IWindowContainer);
            var _local_4:IWindowContainer = (this._SafeStr_13990.getListItemByName("tags_spacer") as IWindowContainer);
            if ((((_local_3 == null)) || ((_local_4 == null)))){
                return;
            };
            if (_arg_1.length != 0){
                _local_3.height = this._SafeStr_4206.renderTags(_arg_1, _local_3, _arg_2);
                _local_4.height = 1;
            }
            else {
                _local_3.height = 0;
                _local_4.height = 0;
            };
            this.InfoStandUserView();
        }
        public function InfoStandUserView(_arg_1:int, _arg_2:BitmapData):void
        {
            var _local_3:IWindowContainer = (this._SafeStr_13990.getListItemByName("image_and_badges_container") as IWindowContainer);
            var _local_4:IBitmapWrapperWindow = (_local_3.findChildByName(("badge_" + _arg_1)) as IBitmapWrapperWindow);
            if (_local_4 == null){
                return;
            };
            if (_local_4.bitmap == null){
                _local_4.bitmap = new BitmapData(_local_4.width, _local_4.height, true, 0);
            };
            this.InfoStandUserView(_local_4.bitmap, _arg_2);
            _local_4.invalidate();
        }
        public function InfoStandUserView():void
        {
            var _local_3:IBitmapWrapperWindow;
            var _local_1:IWindowContainer = (this._SafeStr_13990.getListItemByName("image_and_badges_container") as IWindowContainer);
            var _local_2:int;
            while (_local_2 < 5) {
                _local_3 = (_local_1.findChildByName(("badge_" + _local_2)) as IBitmapWrapperWindow);
                if (_local_3 != null){
                    _local_3.bitmap = new BitmapData(_local_3.width, _local_3.height, true, 0);
                };
                _local_2++;
            };
        }
        public function InfoStandUserView():void
        {
            var _local_1:IWindowContainer = (this._SafeStr_13990.getListItemByName("image_and_badges_container") as IWindowContainer);
            var _local_2:IBitmapWrapperWindow = (_local_1.findChildByName("badge_group") as IBitmapWrapperWindow);
            if (_local_2 != null){
                _local_2.bitmap = new BitmapData(_local_2.width, _local_2.height, true, 0);
            };
        }
        public function InfoStandUserView(_arg_1:BitmapData):void
        {
            var _local_2:IWindowContainer = (this._SafeStr_13990.getListItemByName("image_and_badges_container") as IWindowContainer);
            var _local_3:IBitmapWrapperWindow = (_local_2.findChildByName("badge_group") as IBitmapWrapperWindow);
            if (_local_3 == null){
                return;
            };
            if (_local_3.bitmap == null){
                _local_3.bitmap = new BitmapData(_local_3.width, _local_3.height, true, 0);
            };
            this.InfoStandUserView(_local_3.bitmap, _arg_1);
            _local_3.invalidate();
        }
        private function InfoStandUserView(_arg_1:BitmapData, _arg_2:BitmapData):void
        {
            _arg_1.fillRect(_arg_1.rect, 0);
            var _local_3:int = ((_arg_1.width - _arg_2.width) / 2);
            var _local_4:int = ((_arg_1.height - _arg_2.height) / 2);
            _arg_1.copyPixels(_arg_2, _arg_2.rect, new Point(_local_3, _local_4));
        }
        private function InfoStandUserView(_arg_1:WindowMouseEvent):void
        {
            var _local_2:ITextWindow = (_arg_1.target as ITextWindow);
            if (_local_2 == null){
                return;
            };
            this._widget.messageListener.processWidgetMessage(new RoomWidgetRoomTagSearchMessage(_local_2.text));
        }
        public function update(_arg_1:RoomWidgetUserInfoUpdateEvent):void
        {
            this.InfoStandUserView();
            this.InfoStandUserView();
            this.InfoStandUserView([]);
            this.InfoStandUserView(_arg_1);
            this.InfoStandUserView(_arg_1);
        }
        protected function InfoStandUserView(_arg_1:RoomWidgetUserInfoUpdateEvent):void
        {
            this.name = _arg_1.name;
            this.InfoStandUserView(_arg_1.motto, (_arg_1.type == RoomWidgetUserInfoUpdateEvent.RWUIUE_OWN_USER));
            this.achievementScore = _arg_1.achievementScore;
            this.carryItem = _arg_1.carryItem;
            this.xp = _arg_1.xp;
            this.image = _arg_1.image;
        }
        private function InfoStandUserView(_arg_1:String, _arg_2:Boolean=true):void
        {
            if (this._SafeStr_13989 == null){
                return;
            };
            var _local_3:IRegionWindow = (this._SafeStr_13989.getChildByName(_arg_1) as IRegionWindow);
            var _local_4:IWindow = _local_3.getChildAt(0);
            if (_local_4 != null){
                if (_arg_2){
                    _local_4.enable();
                }
                else {
                    _local_4.disable();
                };
            };
        }
        protected function InfoStandUserView(_arg_1:String, _arg_2:Boolean):void
        {
            if (this._SafeStr_13989 == null){
                return;
            };
            var _local_3:IWindow = this._SafeStr_13989.getChildByName(_arg_1);
            if (_local_3 != null){
                _local_3.visible = _arg_2;
                this.InfoStandUserView();
            };
        }
        protected function InfoStandUserView(_arg_1:String, _arg_2:String):void
        {
            var _local_3:IRegionWindow = (this._SafeStr_13989.getChildByName(_arg_1) as IRegionWindow);
            if (_local_3 != null){
                _local_3.toolTipCaption = _arg_2;
                _local_3.toolTipDelay = 100;
            };
        }
        protected function InfoStandUserView(_arg_1:RoomWidgetUserInfoUpdateEvent):void
        {
            var _local_2:Boolean;
            if (this._SafeStr_13989 == null){
                return;
            };
            switch (_arg_1.type){
                case RoomWidgetUserInfoUpdateEvent.RWUIUE_OWN_USER:
                    this._SafeStr_13989.visible = false;
                    break;
                case RoomWidgetUserInfoUpdateEvent.RWUIUE_PEER:
                    if (_arg_1.isSpectatorMode){
                        this._SafeStr_13989.visible = false;
                        break;
                    };
                    if (this._SafeStr_14029){
                        this.InfoStandUserView("friend", true);
                        this.InfoStandUserView("friend", _arg_1.canBeAskedAsFriend);
                        this.InfoStandUserView();
                        this.InfoStandUserView(_arg_1.isIgnored);
                        this.InfoStandUserView("kick", ((((((_arg_1.amIOwner) || (_arg_1.amIController))) || (_arg_1.amIAnyRoomController))) && (_arg_1.canBeKicked)));
                        this.InfoStandUserView("ban", ((((_arg_1.amIOwner) || (_arg_1.amIAnyRoomController))) && (_arg_1.canBeKicked)));
                        this.InfoStandUserView(_arg_1.amIOwner, _arg_1.hasFlatControl);
                        this.InfoStandUserView("trade", _arg_1.canTrade);
                        this.InfoStandUserView(_arg_1.canTradeReason);
                        _local_2 = false;
                        if (((!((this._widget.config == null))) && ((this._widget.config.getKey("infostand.report.show", "0") == "1")))){
                            _local_2 = true;
                        };
                        this.InfoStandUserView("report", _local_2);
                        this._SafeStr_13989.visible = true;
                    }
                    else {
                        this._SafeStr_13989.visible = false;
                    };
                    break;
            };
            if (this._window != null){
                this._window.IItemListWindow();
            };
            this.InfoStandUserView();
        }
        private function InfoStandUserView():void
        {
            var _local_1:int = this._widget.userData.respectLeft;
            this._widget.localizations.registerParameter("infostand.button.respect", "count", _local_1.toString());
            this.InfoStandUserView("respect", (_local_1 > 0));
        }
        private function InfoStandUserView(_arg_1:Boolean):void
        {
            this.InfoStandUserView("ignore", !(_arg_1));
            this.InfoStandUserView("unignore", _arg_1);
        }
        protected function InfoStandUserView(_arg_1:Boolean, _arg_2:Boolean):void
        {
            if (_arg_1){
                this.InfoStandUserView("give_rights", !(_arg_2));
                this.InfoStandUserView("remove_rights", _arg_2);
            }
            else {
                this.InfoStandUserView("give_rights", false);
                this.InfoStandUserView("remove_rights", false);
            };
        }
        protected function InfoStandUserView(_arg_1:int):void
        {
            var _local_2:String;
            switch (_arg_1){
                case RoomWidgetUserInfoUpdateEvent._SafeStr_6864:
                    _local_2 = "${infostand.button.trade.tooltip.shutdown}";
                    break;
                case RoomWidgetUserInfoUpdateEvent._SafeStr_6865:
                    _local_2 = "${infostand.button.trade.tooltip.tradingroom}";
                    break;
                default:
                    _local_2 = "";
            };
            this.InfoStandUserView("trade", _local_2);
        }
        protected function InfoStandUserView(_arg_1:WindowKeyboardEvent):void
        {
            var _local_5:RoomWidgetChangeMottoMessage;
            var _local_6:int;
            var _local_7:int;
            var _local_2:IWindowContainer = (this._SafeStr_13990.getListItemByName("motto_container") as IWindowContainer);
            if (!_local_2){
                return;
            };
            var _local_3:ITextWindow = (_local_2.findChildByName("motto_text") as ITextWindow);
            var _local_4:String = _local_3.text;
            if (_arg_1.keyCode == Keyboard.ENTER){
                _local_6 = getTimer();
                if (((((_local_6 - this._SafeStr_14028) > this._SafeStr_14024)) && (!((_local_4 == this._widget.localizations.getKey("infostand.motto.change")))))){
                    _local_7 = this._widget.userData.userId;
                    _local_5 = new RoomWidgetChangeMottoMessage(_local_4);
                    this._widget.messageListener.processWidgetMessage(_local_5);
                    this._SafeStr_14028 = _local_6;
                    _local_3.textColor = this._SafeStr_14023;
                };
            }
            else {
                _local_3.textColor = this._SafeStr_14022;
            };
            _local_3.height = Math.min((_local_3.textHeight + this._SafeStr_14020), this._SafeStr_14025);
            _local_3.height = Math.max(_local_3.height, this._SafeStr_14026);
            _local_2.height = (_local_3.height + this._SafeStr_14021);
        }
        protected function InfoStandUserView(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IWindowContainer = (this._SafeStr_13990.getListItemByName("motto_container") as IWindowContainer);
            if (!_local_2){
                return;
            };
            var _local_3:ITextWindow = (_local_2.findChildByName("motto_text") as ITextWindow);
            if (_local_3.text == this._widget.localizations.getKey("infostand.motto.change")){
                _local_3.text = "";
            };
            _local_3.textColor = this._SafeStr_14022;
        }
        protected function InfoStandUserView(_arg_1:WindowMouseEvent):void
        {
            var _local_2:RoomWidgetMessage;
            var _local_3:String;
            var _local_5:int;
            var _local_4:IWindow = (_arg_1.target as IWindow);
            switch (_local_4.name){
                case "whisper":
                    _local_3 = RoomWidgetUserActionMessage.RWUAM_WHISPER_USER;
                    break;
                case "friend":
                    _local_4.disable();
                    _local_3 = RoomWidgetUserActionMessage.RWUAM_SEND_FRIEND_REQUEST;
                    break;
                case "respect":
                    this._widget.userData.respectLeft--;
                    this.InfoStandUserView();
                    _local_3 = RoomWidgetUserActionMessage.RWUAM_RESPECT_USER;
                    break;
                case "ignore":
                    this.InfoStandUserView(true);
                    _local_3 = RoomWidgetUserActionMessage.RWUAM_IGNORE_USER;
                    break;
                case "unignore":
                    this.InfoStandUserView(false);
                    _local_3 = RoomWidgetUserActionMessage.RWUAM_UNIGNORE_USER;
                    break;
                case "kick":
                    _local_3 = RoomWidgetUserActionMessage.RWUAM_KICK_USER;
                    break;
                case "ban":
                    _local_3 = RoomWidgetUserActionMessage.RWUAM_BAN_USER;
                    break;
                case "give_rights":
                    this.InfoStandUserView(true, true);
                    _local_3 = RoomWidgetUserActionMessage.RWUAM_GIVE_RIGHTS;
                    break;
                case "remove_rights":
                    this.InfoStandUserView(true, false);
                    _local_3 = RoomWidgetUserActionMessage.RWUAM_TAKE_RIGHTS;
                    break;
                case "trade":
                    _local_3 = RoomWidgetUserActionMessage.RWUAM_START_TRADING;
                    break;
                case "home_icon":
                    _local_3 = RoomWidgetUserActionMessage.RWUAM_OPEN_HOME_PAGE;
                    break;
                case "report":
                    _local_3 = RoomWidgetUserActionMessage.RWUAM_REPORT;
                    break;
            };
            if (_local_3 != null){
                _local_5 = this._widget.userData.userId;
                _local_2 = new RoomWidgetUserActionMessage(_local_3, _local_5);
                this._widget.messageListener.processWidgetMessage(_local_2);
                HabboTracking.getInstance().trackEventLog("InfoStand", "click", _local_3);
            };
            this.InfoStandUserView();
        }
        protected function InfoStandUserView(_arg_1:WindowEvent):void
        {
            var _local_2:IWindow = _arg_1.window.parent;
            if (((_local_2) && ((_local_2.tags.indexOf("CMD_BUTTON_REGION") > -1)))){
                _local_2.width = _arg_1.window.width;
            };
        }
        private function InfoStandUserView():void
        {
            var _local_5:IWindow;
            var _local_1 = 250;
            this._SafeStr_13989.width = _local_1;
            var _local_2:Array = [];
            this._SafeStr_13989.WindowController("CMD_BUTTON_REGION", _local_2, true);
            var _local_3:int = _local_1;
            var _local_4:int;
            for each (_local_5 in _local_2) {
                if (_local_5.visible){
                    if ((_local_3 - _local_5.width) < 0){
                        _local_3 = _local_1;
                        _local_4 = (_local_4 + 30);
                    };
                    _local_5.x = (_local_3 - _local_5.width);
                    _local_5.y = _local_4;
                    _local_3 = (_local_5.x - 5);
                };
            };
            this._SafeStr_13989.height = (_local_4 + 25);
            this.InfoStandUserView();
        }

    }
}//package com.sulake.habbo.ui.widget.infostand

// InfoStandUserView = "_-jx" (String#8602, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// _border = "_-0NB" (String#815, DoABC#2)
// _SafeStr_13989 = "_-1WU" (String#5481, DoABC#2)
// _SafeStr_13990 = "_-38U" (String#2009, DoABC#2)
// InfostandWidget = "_-Ez" (String#22811, DoABC#2)
// InfoStandUserView = "_-op" (String#8686, DoABC#2)
// InfoStandUserView = "_-1lR" (String#5774, DoABC#2)
// InfoStandUserView = "_-1UF" (String#5437, DoABC#2)
// _SafeStr_14020 = "_-1pP" (String#18520, DoABC#2)
// _SafeStr_14021 = "_-1db" (String#18039, DoABC#2)
// _SafeStr_14022 = "_-0pk" (String#16043, DoABC#2)
// _SafeStr_14023 = "_-2At" (String#19438, DoABC#2)
// _SafeStr_14024 = "_-Tn" (String#23398, DoABC#2)
// _SafeStr_14025 = "_-1UC" (String#17674, DoABC#2)
// _SafeStr_14026 = "_-0Ly" (String#14911, DoABC#2)
// _SafeStr_14027 = "_-v3" (String#24494, DoABC#2)
// _SafeStr_14028 = "_-17P" (String#16752, DoABC#2)
// _SafeStr_14029 = "_-078" (String#14330, DoABC#2)
// InfoStandUserView = "_-24K" (String#19191, DoABC#2)
// InfoStandUserView = "_-2GB" (String#19649, DoABC#2)
// InfoStandUserView = "_-2dT" (String#20583, DoABC#2)
// InfoStandUserView = "_-1-6" (String#16433, DoABC#2)
// InfoStandUserView = "_-qf" (String#24300, DoABC#2)
// InfoStandUserView = "_-3Bd" (String#21946, DoABC#2)
// InfoStandUserView = "_-1kl" (String#18320, DoABC#2)
// InfoStandUserView = "_-0lz" (String#15896, DoABC#2)
// InfoStandUserView = "_-1cu" (String#18008, DoABC#2)
// InfoStandUserView = "_-0aQ" (String#15453, DoABC#2)
// InfoStandUserView = "_-rM" (String#24332, DoABC#2)
// InfoStandUserView = "_-37K" (String#21781, DoABC#2)
// renderTags = "_-2qk" (String#21112, DoABC#2)
// InfoStandUserView = "_-2Nw" (String#19961, DoABC#2)
// InfoStandUserView = "_-6H" (String#22477, DoABC#2)
// InfoStandUserView = "_-1XP" (String#17793, DoABC#2)
// InfoStandUserView = "_-Rl" (String#23314, DoABC#2)
// InfoStandUserView = "_-0Ob" (String#15011, DoABC#2)
// InfoStandUserView = "_-cO" (String#23729, DoABC#2)
// InfoStandUserView = "_-003" (String#14055, DoABC#2)
// InfoStandUserView = "_-1Oq" (String#17461, DoABC#2)
// InfoStandUserView = "_-VG" (String#23460, DoABC#2)
// IBorderWindow = "_-0Br" (String#1422, DoABC#2)
// IRegionWindow = "_-dg" (String#2146, DoABC#2)
// WindowKeyboardEvent = "_-0Di" (String#1433, DoABC#2)
// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetUserInfoUpdateEvent = "_-28z" (String#6226, DoABC#2)
// InfoStandUserView = "_-5X" (String#7772, DoABC#2)
// RoomWidgetUserActionMessage = "_-22U" (String#19109, DoABC#2)
// RoomWidgetGetBadgeDetailsMessage = "_-3AO" (String#7522, DoABC#2)
// RoomWidgetChangeMottoMessage = "_-iB" (String#8557, DoABC#2)
// RoomWidgetRoomTagSearchMessage = "_-2ev" (String#6850, DoABC#2)
// TagListRenderer = "_-Z0" (String#8393, DoABC#2)
// RWUAM_WHISPER_USER = "_-0oT" (String#15994, DoABC#2)
// RWUAM_IGNORE_USER = "_-XM" (String#23537, DoABC#2)
// RWUAM_UNIGNORE_USER = "_-1-L" (String#16442, DoABC#2)
// RWUAM_KICK_USER = "_-02D" (String#14135, DoABC#2)
// RWUAM_BAN_USER = "_-0ex" (String#15625, DoABC#2)
// RWUAM_SEND_FRIEND_REQUEST = "_-2XL" (String#20336, DoABC#2)
// RWUAM_RESPECT_USER = "_-6j" (String#22488, DoABC#2)
// RWUAM_GIVE_RIGHTS = "_-1ns" (String#18455, DoABC#2)
// RWUAM_TAKE_RIGHTS = "_-20C" (String#19019, DoABC#2)
// RWUAM_START_TRADING = "_-J3" (String#22970, DoABC#2)
// RWUAM_OPEN_HOME_PAGE = "_-0z1" (String#16395, DoABC#2)
// RWUAM_REPORT = "_-3-T" (String#21480, DoABC#2)
// achievementScore = "_-16Z" (String#5005, DoABC#2)
// realName = "_-3HH" (String#922, DoABC#2)
// respectLeft = "_-2Yo" (String#6743, DoABC#2)
// RWUIUE_OWN_USER = "_-13K" (String#16592, DoABC#2)
// InfoStandUserView = "_-2k0" (String#247, DoABC#2)
// trackEventLog = "_-0ML" (String#14927, DoABC#2)
// getInstance = "_-n5" (String#24157, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// _SafeStr_4206 = "_-2ux" (String#901, DoABC#2)
// WE_RESIZED = "_-76" (String#22505, DoABC#2)
// scrollableRegion = "_-2ku" (String#6976, DoABC#2)
// WindowController = "_-05T" (String#3675, DoABC#2)
// PollOfferDialog = "_-2Ts" (String#54, DoABC#2)
// WKE_KEY_UP = "_-0aL" (String#15451, DoABC#2)
// RWUIUE_PEER = "_-2Tv" (String#20195, DoABC#2)
// isSpectatorMode = "_-10C" (String#4874, DoABC#2)
// InfoStandUserView = "_-i5" (String#942, DoABC#2)
// amIAnyRoomController = "_-09r" (String#14441, DoABC#2)
// amIController = "_-01W" (String#14111, DoABC#2)
// amIOwner = "_-15r" (String#16691, DoABC#2)
// canBeAskedAsFriend = "_-0c9" (String#15521, DoABC#2)
// canBeKicked = "_-34-" (String#21658, DoABC#2)
// canTrade = "_-07S" (String#14342, DoABC#2)
// canTradeReason = "_-01A" (String#14098, DoABC#2)
// hasFlatControl = "_-282" (String#19332, DoABC#2)
// isIgnored = "_-0NV" (String#4031, DoABC#2)
// InfoStandUserView = "_-2s1" (String#451, DoABC#2)
// InfoStandUserView = "_-P4" (String#461, DoABC#2)
// _SafeStr_6864 = "_-19C" (String#16825, DoABC#2)
// _SafeStr_6865 = "_-2u2" (String#21240, DoABC#2)
// toolTipCaption = "_-0cC" (String#4347, DoABC#2)
// InfoStandUserView = "_-1Qo" (String#1680, DoABC#2)
// carryItem = "_-0WF" (String#15289, DoABC#2)
// toolTipDelay = "_-2W1" (String#6685, DoABC#2)
// WindowController = "_-cU" (String#2141, DoABC#2)
// IItemListWindow = "_-0fG" (String#4411, DoABC#2)


