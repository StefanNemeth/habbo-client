
package com.sulake.habbo.inventory.trading
{
    import com.sulake.habbo.inventory.IInventoryView;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.inventory.ItemPopupCtrl;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Timer;
    import com.sulake.habbo.inventory.items.GroupItem;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.sound.events.SongInfoReceivedEvent;
    import flash.events.TimerEvent;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.ITextWindow;
    import flash.display.BitmapData;
    import com.sulake.core.utils.Map;
    import flash.geom.Point;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.habbo.inventory.items.FloorItem;
    import com.sulake.habbo.inventory.items.WallItem;
    import com.sulake.habbo.inventory.items.IItem;
    import com.sulake.habbo.inventory.enum.FurniCategory;
    import com.sulake.habbo.sound.ISongInfo;

    public class TradingView implements IInventoryView, IGetImageListener 
    {

        private static const _SafeStr_11574:uint = 4284532064;
        private static const _SafeStr_11575:uint = 2577770;
        public static const _SafeStr_11576:int = 0;
        public static const _SafeStr_11564:int = 1;
        public static const _SafeStr_11563:int = 2;

        private var _SafeStr_11577:TradingModel;
        private var _windowManager:IHabboWindowManager;
        private var _localization:IHabboLocalizationManager;
        private var _roomEngine:IRoomEngine;
        private var _assetLibrary:IAssetLibrary;
        private var _SafeStr_11247:ItemPopupCtrl;
        private var _soundManager:IHabboSoundManager;
        private var _disposed:Boolean = false;
        private var _visible:Boolean;
        private var _SafeStr_11578:IWindowContainer;
        private var _SafeStr_11579:IWindowContainer;
        private var _SafeStr_5297:Timer;
        private var _SafeStr_11580:GroupItem;
        private var _SafeStr_6827:Boolean;
        private var _SafeStr_11581:Array;

        public function TradingView(_arg_1:TradingModel, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IRoomEngine, _arg_5:IHabboLocalizationManager, _arg_6:IHabboSoundManager)
        {
            this._SafeStr_11581 = new Array();
            super();
            this._SafeStr_11577 = _arg_1;
            this._windowManager = _arg_2;
            this._localization = _arg_5;
            this._assetLibrary = _arg_3;
            this._roomEngine = _arg_4;
            this._soundManager = _arg_6;
            this._visible = false;
            var _local_7:IAsset = this._assetLibrary.getAssetByName("item_popup_xml");
            var _local_8:XmlAsset = XmlAsset(_local_7);
            var _local_9:IWindowContainer = (this._windowManager.buildFromXML((_local_8.content as XML)) as IWindowContainer);
            _local_9.visible = false;
            this._SafeStr_11247 = new ItemPopupCtrl(_local_9, this._assetLibrary);
            this._soundManager.events.addEventListener(SongInfoReceivedEvent.SIR_TRAX_SONG_INFO_RECEIVED, this.onSongInfoReceivedEvent);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get visible():Boolean
        {
            return (this._visible);
        }
        public function dispose():void
        {
            if (!this._disposed){
                if (((this._SafeStr_11578) && (!(this._SafeStr_11578.disposed)))){
                    this._SafeStr_11578.dispose();
                    this._SafeStr_11578 = null;
                };
                if (this._SafeStr_5297){
                    this._SafeStr_5297.removeEventListener(TimerEvent.TIMER, this.timerEventHandler);
                    this._SafeStr_5297.stop();
                    this._SafeStr_5297 = null;
                };
                if (this._SafeStr_11247 != null){
                    this._SafeStr_11247.dispose();
                    this._SafeStr_11247 = null;
                };
                if (this._soundManager){
                    if (this._soundManager.events != null){
                        this._soundManager.events.removeEventListener(SongInfoReceivedEvent.SIR_TRAX_SONG_INFO_RECEIVED, this.onSongInfoReceivedEvent);
                    };
                    this._soundManager = null;
                };
                this._SafeStr_11581 = null;
                this._SafeStr_11577 = null;
                this._windowManager = null;
                this._roomEngine = null;
                this._localization = null;
                this._assetLibrary = null;
                this._SafeStr_11580 = null;
                this._visible = false;
                this._disposed = true;
            };
        }
        public function setup(_arg_1:int, _arg_2:Boolean, _arg_3:int, _arg_4:Boolean):void
        {
            this.setMinimized(false);
            this.hideOwnUserNotification();
            this.hideOtherUserNotification();
            if (((!(_arg_2)) && (!(_arg_4)))){
                this.showInfoMessage("${inventory.trading.warning.both_accounts_disabled}");
                this.showOwnUserNotification("");
                this.showOtherUserNotification("");
            }
            else {
                if (!_arg_2){
                    this.showOwnUserNotification("${inventory.trading.warning.own_account_disabled}");
                };
                if (!_arg_4){
                    this.showOtherUserNotification("${inventory.trading.warning.others_account_disabled}");
                };
            };
        }
        public function getWindowContainer():IWindowContainer
        {
            if (this._SafeStr_11578 == null){
                this._SafeStr_11578 = this.createNormalWindow();
            };
            if (this._SafeStr_11579 == null){
                this._SafeStr_11579 = this.createMinimizedWindow();
            };
            if (!this._SafeStr_6827){
                return (this._SafeStr_11578);
            };
            return (this._SafeStr_11579);
        }
        private function createNormalWindow():IWindowContainer
        {
            var _local_3:IItemGridWindow;
            var _local_4:IWindow;
            var _local_5:IWindowContainer;
            var _local_6:uint;
            var _local_1:XML = (XmlAsset(this._assetLibrary.getAssetByName("inventory_trading_xml")).content as XML);
            var _local_2:IWindowContainer = (this._windowManager.buildFromXML(_local_1) as IWindowContainer);
            _local_3 = (_local_2.findChildByTag("OWN_USER_GRID") as IItemGridWindow);
            _local_6 = 0;
            while (_local_6 < _local_3.numGridItems) {
                _local_4 = _local_3.getGridItemAt(_local_6);
                _local_4.id = _local_6;
                _local_4.procedure = this.ownThumbEventProc;
                _local_4.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.ownThumbEventProc);
                _local_4.addEventListener(WindowMouseEvent.WME_OUT, this.ownThumbEventProc);
                _local_6++;
            };
            _local_3 = (_local_2.findChildByTag("OTHER_USER_GRID") as IItemGridWindow);
            _local_6 = 0;
            while (_local_6 < _local_3.numGridItems) {
                _local_4 = _local_3.getGridItemAt(_local_6);
                _local_4.id = _local_6;
                _local_4.procedure = this.othersThumbEventProc;
                _local_4.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.othersThumbEventProc);
                _local_4.addEventListener(WindowMouseEvent.WME_OUT, this.othersThumbEventProc);
                _local_6++;
            };
            _local_2.procedure = this.windowEventProc;
            return (_local_2);
        }
        private function createMinimizedWindow():IWindowContainer
        {
            var _local_1:XML = (XmlAsset(this._assetLibrary.getAssetByName("inventory_trading_minimized_xml")).content as XML);
            var _local_2:IWindowContainer = (this._windowManager.buildFromXML(_local_1) as IWindowContainer);
            _local_2.procedure = this.windowMininizedEventProc;
            return (_local_2);
        }
        public function setMinimized(_arg_1:Boolean=false):void
        {
            this._SafeStr_6827 = _arg_1;
        }
        protected function getOwnUsersItemGrid():IItemGridWindow
        {
            return ((this._SafeStr_11578.findChildByTag("OWN_USER_GRID") as IItemGridWindow));
        }
        protected function getOtherUsersItemGrid():IItemGridWindow
        {
            return ((this._SafeStr_11578.findChildByTag("OTHER_USER_GRID") as IItemGridWindow));
        }
        public function updateItemList(_arg_1:int):void
        {
            var _local_3:GroupItem;
            var _local_4:IWindowContainer;
            var _local_5:IBitmapWrapperWindow;
            var _local_6:ITextWindow;
            var _local_7:BitmapData;
            var _local_8:BitmapData;
            var _local_2:uint;
            var _local_9 = (_arg_1 == this._SafeStr_11577.otherUserId);
            var _local_10:Map = ((_local_9) ? this._SafeStr_11577.otherUserItems : this._SafeStr_11577.ownUserItems);
            var _local_11:IItemGridWindow = ((_local_9) ? this.getOtherUsersItemGrid() : this.getOwnUsersItemGrid());
            while (_local_2 < _local_10.length) {
                _local_3 = (_local_10.getWithIndex(_local_2) as GroupItem);
                _local_4 = (_local_11.getGridItemAt(_local_2) as IWindowContainer);
                if (_local_4){
                    _local_4.id = _local_2;
                    while (_local_4.numChildren > 0) {
                        _local_4.removeChildAt(0);
                    };
                    _local_4.addChild(_local_3.window);
                    _local_3.window.id = _local_2;
                };
                _local_2++;
            };
            while (_local_2 < _local_11.numGridItems) {
                _local_4 = (_local_11.getGridItemAt(_local_2) as IWindowContainer);
                if (_local_4){
                    _local_4.id = _local_2;
                    _local_4.removeChildAt(0);
                    _local_4.invalidate();
                };
                _local_2++;
            };
            this.updateActionState();
        }
        public function clearItemLists():void
        {
            var _local_1:IItemGridWindow;
            var _local_2:IWindowContainer;
            var _local_3:uint;
            _local_1 = this.getOwnUsersItemGrid();
            _local_3 = 0;
            while (_local_3 < _local_1.numGridItems) {
                _local_2 = (_local_1.getGridItemAt(_local_3) as IWindowContainer);
                if (_local_2){
                    _local_2.id = _local_3;
                    _local_2.removeChildAt(0);
                };
                _local_3++;
            };
            _local_1 = this.getOtherUsersItemGrid();
            _local_3 = 0;
            while (_local_3 < _local_1.numGridItems) {
                _local_2 = (_local_1.getGridItemAt(_local_3) as IWindowContainer);
                if (_local_2){
                    _local_2.id = _local_3;
                    _local_2.removeChildAt(0);
                };
                _local_3++;
            };
        }
        public function updateUserInterface():void
        {
            var _local_1:IWindow;
            var _local_2:ITextWindow;
            var _local_3:IBitmapWrapperWindow;
            if (this._SafeStr_11578){
                this.updateActionState();
                _local_2 = (this._SafeStr_11578.findChildByTag("OTHER_USER_NAME") as ITextWindow);
                if (_local_2){
                    _local_2.text = this._SafeStr_11577.otherUserName;
                };
                _local_1 = this._SafeStr_11578.findChildByTag("OWN_USER_BORDER");
                if (_local_1){
                    _local_1.color = ((this._SafeStr_11577.ownUserAccepts) ? _SafeStr_11574 : _SafeStr_11575);
                };
                _local_3 = (this._SafeStr_11578.findChildByTag("OWN_USER_LOCK") as IBitmapWrapperWindow);
                if (_local_3){
                    if (_local_3.bitmap == null){
                        _local_3.bitmap = new BitmapData(_local_3.width, _local_3.height, true);
                    };
                    _local_3.bitmap.fillRect(_local_3.bitmap.rect, 0xFFFFFF);
                    _local_3.bitmap.copyPixels((this._assetLibrary.getAssetByName(((this._SafeStr_11577.ownUserAccepts) ? "trading_locked_icon_png" : "trading_unlocked_icon_png")).content as BitmapData), _local_3.bitmap.rect, new Point());
                    _local_3.invalidate();
                };
                _local_1 = this._SafeStr_11578.findChildByTag("OTHER_USER_BORDER");
                if (_local_1){
                    _local_1.color = ((this._SafeStr_11577.otherUserAccepts) ? _SafeStr_11574 : _SafeStr_11575);
                };
                _local_3 = (this._SafeStr_11578.findChildByTag("OTHER_USER_LOCK") as IBitmapWrapperWindow);
                if (_local_3){
                    if (_local_3.bitmap == null){
                        _local_3.bitmap = new BitmapData(_local_3.width, _local_3.height, true);
                    };
                    _local_3.bitmap.fillRect(_local_3.bitmap.rect, 0xFFFFFF);
                    _local_3.bitmap.copyPixels((this._assetLibrary.getAssetByName(((this._SafeStr_11577.otherUserAccepts) ? "trading_locked_icon_png" : "trading_unlocked_icon_png")).content as BitmapData), _local_3.bitmap.rect, new Point());
                    _local_3.invalidate();
                };
            };
        }
        public function updateActionState():void
        {
            var _local_1:IWindow;
            if (this._SafeStr_11578){
                _local_1 = this._SafeStr_11578.findChildByName("button_accept");
                if (!_local_1){
                    return;
                };
                switch (this._SafeStr_11577.state){
                    case TradingModel._SafeStr_11524:
                        if ((((this._SafeStr_11577.otherUserItems.length > 0)) || ((this._SafeStr_11577.ownUserItems.length > 0)))){
                            _local_1.enable();
                        }
                        else {
                            _local_1.disable();
                        };
                        _local_1.caption = "${inventory.trading.accept}";
                        return;
                    case TradingModel._SafeStr_11525:
                        if ((((this._SafeStr_11577.otherUserItems.length > 0)) || ((this._SafeStr_11577.ownUserItems.length > 0)))){
                            _local_1.enable();
                        }
                        else {
                            _local_1.disable();
                        };
                        _local_1.caption = ((this._SafeStr_11577.ownUserAccepts) ? "${inventory.trading.modify}" : "${inventory.trading.accept}");
                        this.showInfoMessage("${inventory.trading.info.add}");
                        return;
                    case TradingModel._SafeStr_11526:
                        _local_1.disable();
                        _local_1.caption = "${inventory.trading.countdown}";
                        this.showInfoMessage("${inventory.trading.info.confirm}");
                        return;
                    case TradingModel._SafeStr_11527:
                        _local_1.enable();
                        _local_1.caption = "${inventory.trading.confirm}";
                        this.showInfoMessage("${inventory.trading.info.confirm}");
                        return;
                    case TradingModel._SafeStr_11528:
                        _local_1.disable();
                        this.showInfoMessage("${inventory.trading.info.waiting}");
                        return;
                    case TradingModel._SafeStr_11529:
                        _local_1.disable();
                        _local_1.caption = "${inventory.trading.accept}";
                        this.showInfoMessage("${inventory.trading.info.confirm}");
                        return;
                    case TradingModel.TRADING_STATE_CANCELLED:
                        return;
                    default:
                        throw (new Error((('Unknown trading progress state: "' + this._SafeStr_11577.state) + '"')));
                };
            };
        }
        public function showInfoMessage(_arg_1:String):void
        {
            var _local_2:ITextWindow = (this._SafeStr_11578.findChildByName("help_text") as ITextWindow);
            _local_2.text = _arg_1;
            _local_2.visible = true;
        }
        public function showOwnUserNotification(_arg_1:String):void
        {
            var _local_2:ITextWindow = (this._SafeStr_11578.findChildByName("info_text_0") as ITextWindow);
            _local_2.text = _arg_1;
            _local_2.visible = true;
            var _local_3:IItemGridWindow = (this._SafeStr_11578.findChildByName("item_grid_0") as IItemGridWindow);
            if (_local_3){
                _local_3.visible = false;
            };
        }
        public function hideOwnUserNotification():void
        {
            var _local_1:ITextWindow = (this._SafeStr_11578.findChildByName("info_text_0") as ITextWindow);
            _local_1.visible = false;
            var _local_2:IItemGridWindow = (this._SafeStr_11578.findChildByName("item_grid_0") as IItemGridWindow);
            if (_local_2){
                _local_2.visible = true;
            };
        }
        public function showOtherUserNotification(_arg_1:String):void
        {
            var _local_2:ITextWindow = (this._SafeStr_11578.findChildByName("info_text_1") as ITextWindow);
            _local_2.text = _arg_1;
            _local_2.visible = true;
            var _local_3:IItemGridWindow = (this._SafeStr_11578.findChildByName("item_grid_1") as IItemGridWindow);
            if (_local_3){
                _local_3.visible = false;
            };
        }
        public function hideOtherUserNotification():void
        {
            var _local_1:ITextWindow = (this._SafeStr_11578.findChildByName("info_text_1") as ITextWindow);
            _local_1.visible = false;
            var _local_2:IItemGridWindow = (this._SafeStr_11578.findChildByName("item_grid_1") as IItemGridWindow);
            if (_local_2){
                _local_2.visible = true;
            };
        }
        public function alertPopup(_arg_1:int):void
        {
            switch (_arg_1){
                case _SafeStr_11576:
                    this._windowManager.alert("${inventory.trading.notification.title}", "${inventory.trading.warning.other_not_offering}", 0, this.onTradingAlert);
                    return;
                case _SafeStr_11564:
                    this._windowManager.alert("${inventory.trading.notification.title}", "${inventory.trading.info.closed}", 0, this.onTradingAlert);
                    return;
                case _SafeStr_11563:
                    this._windowManager.alert("${inventory.trading.notification.title}", "${inventory.trading.info.already_open}", 0, this.onTradingAlert);
                    return;
            };
        }
        public function showAlertNotification(title:String, description:String, callback:Function):void
        {
            this._windowManager.alert(title, description, 0, (((callback)!=null) ? callback : function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
{
    _arg_1.dispose();
}));
        }
        public function startConfirmCountdown():void
        {
            if (this._SafeStr_5297 == null){
                this._SafeStr_5297 = new Timer(1000, 3);
                this._SafeStr_5297.addEventListener(TimerEvent.TIMER, this.timerEventHandler);
            };
            this._SafeStr_5297.reset();
            this._SafeStr_5297.repeatCount = 3;
            this._SafeStr_5297.start();
            this._windowManager.registerLocalizationParameter("inventory.trading.countdown", "counter", "3");
            this.updateUserInterface();
        }
        public function cancelConfirmCountdown():void
        {
            if (this._SafeStr_5297 != null){
                this._SafeStr_5297.reset();
            };
        }
        private function timerEventHandler(_arg_1:TimerEvent):void
        {
            this._windowManager.registerLocalizationParameter("inventory.trading.countdown", "counter", String((3 - this._SafeStr_5297.currentCount)));
            if (this._SafeStr_5297.currentCount == 3){
                this._SafeStr_11577.confirmCountdownReady();
                this._SafeStr_5297.reset();
            };
        }
        protected function resolveItemThumbnail(_arg_1:GroupItem):BitmapData
        {
            var _local_3:ImageResult;
            var _local_2:BitmapData = _arg_1.iconImage;
            if (_local_2 == null){
                if ((_arg_1._SafeStr_7867() is FloorItem)){
                    _local_3 = this._roomEngine.getFurnitureIcon(_arg_1.type, this);
                }
                else {
                    if ((_arg_1._SafeStr_7867() is WallItem)){
                        _local_3 = this._roomEngine.getWallItemIcon(_arg_1.type, this, _arg_1.stuffData);
                    };
                };
                if (_local_3.id > 0){
                    _arg_1.iconCallbackId = _local_3.id;
                };
                _local_2 = _local_3.data;
                _arg_1.iconImage = _local_2;
            };
            return (_local_2);
        }
        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            var _local_3:uint;
            var _local_4:GroupItem;
            var _local_5:Map;
            var _local_6:Boolean;
            _local_5 = this._SafeStr_11577.ownUserItems;
            _local_6 = false;
            _local_3 = 0;
            while (_local_3 < _local_5.length) {
                _local_4 = (_local_5.getWithIndex(_local_3) as GroupItem);
                if (_local_4.iconCallbackId == _arg_1){
                    _local_4.iconImage = _arg_2;
                    _local_6 = true;
                };
                _local_3++;
            };
            if (_local_6){
                this.updateItemList(this._SafeStr_11577.ownUserId);
            };
            _local_5 = this._SafeStr_11577.otherUserItems;
            _local_6 = false;
            _local_3 = 0;
            while (_local_3 < _local_5.length) {
                _local_4 = (_local_5[_local_3] as GroupItem);
                if (_local_4.iconCallbackId == _arg_1){
                    _local_4.iconImage = _arg_2;
                    _local_6 = true;
                };
                _local_3++;
            };
            if (_local_6){
                this.updateItemList(this._SafeStr_11577.otherUserId);
            };
        }
        protected function createThumbnailContainer():IWindowContainer
        {
            var _local_1:XML = (XmlAsset(this._assetLibrary.getAssetByName("inventory_thumb_xml")).content as XML);
            return ((this._windowManager.buildFromXML(_local_1) as IWindowContainer));
        }
        protected function selectOwnTradeItem(_arg_1:uint):void
        {
            var _local_2:GroupItem;
            if ((((this._SafeStr_11577 == null)) || ((this._SafeStr_11577.ownUserItems == null)))){
                return;
            };
            if (_arg_1 < this._SafeStr_11577.ownUserItems.length){
                _local_2 = (this._SafeStr_11577.ownUserItems.getWithIndex(_arg_1) as GroupItem);
                this.setSelection(_local_2);
                if (_local_2){
                    this._SafeStr_11577.getFurniInventoryModel().displayItemInfo(_local_2);
                };
            };
        }
        protected function selectOthersTradeItem(_arg_1:uint):void
        {
            var _local_2:GroupItem;
            if ((((this._SafeStr_11577 == null)) || ((this._SafeStr_11577.otherUserItems == null)))){
                return;
            };
            if (_arg_1 < this._SafeStr_11577.otherUserItems.length){
                _local_2 = (this._SafeStr_11577.otherUserItems.getWithIndex(_arg_1) as GroupItem);
                this.setSelection(_local_2);
                if (_local_2){
                    this._SafeStr_11577.getFurniInventoryModel().displayItemInfo(_local_2);
                };
            };
        }
        public function setSelection(_arg_1:GroupItem):void
        {
            this.removeSelection();
            if (_arg_1){
                this._SafeStr_11580 = _arg_1;
                this._SafeStr_11580.isSelected = true;
            };
        }
        public function removeSelection():void
        {
            if (this._SafeStr_11580){
                this._SafeStr_11580.isSelected = false;
                this._SafeStr_11580 = null;
            };
        }
        public function updateItemImage(_arg_1:int, _arg_2:BitmapData):void
        {
        }
        private function windowMininizedEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                switch (_arg_2.name){
                    case "button_continue":
                        this._SafeStr_11577.requestFurniViewOpen();
                        return;
                    case "button_cancel":
                        this._SafeStr_11577.requestCancelTrading();
                        return;
                };
            };
        }
        private function windowEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                switch (_arg_2.name){
                    case "button_accept":
                        switch (this._SafeStr_11577.state){
                            case TradingModel._SafeStr_11525:
                                if ((((this._SafeStr_11577.otherUserItems.length == 0)) && (!(this._SafeStr_11577.ownUserAccepts)))){
                                    this.alertPopup(_SafeStr_11576);
                                };
                                if (this._SafeStr_11577.ownUserAccepts){
                                    this._SafeStr_11577.requestUnacceptTrading();
                                }
                                else {
                                    this._SafeStr_11577.requestAcceptTrading();
                                };
                                break;
                            case TradingModel._SafeStr_11527:
                                _arg_2.disable();
                                this._SafeStr_11577.requestConfirmAcceptTrading();
                                break;
                        };
                        return;
                    case "button_cancel":
                        switch (this._SafeStr_11577.state){
                            case TradingModel._SafeStr_11525:
                                this._SafeStr_11577.requestCancelTrading();
                                break;
                            case TradingModel._SafeStr_11527:
                                this._SafeStr_11577.requestConfirmDeclineTrading();
                                break;
                        };
                        return;
                };
            };
        }
        private function ownThumbEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            this.thumbEventProc(_arg_1, _arg_2, true);
        }
        private function othersThumbEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            this.thumbEventProc(_arg_1, _arg_2, false);
        }
        private function thumbEventProc(_arg_1:WindowEvent, _arg_2:IWindow, _arg_3:Boolean):void
        {
            var _local_4:GroupItem;
            var _local_5:IItem;
            var _local_6:BitmapData;
            var _local_7:String;
            var _local_8:FloorItem;
            var _local_9:Date;
            if (((_arg_3) && ((_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)))){
                this._SafeStr_11577.requestRemoveItemFromTrading(_arg_2.id);
            };
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER){
                if (_arg_3){
                    _local_4 = this._SafeStr_11577.ownUserItems.getWithIndex(_arg_2.id);
                }
                else {
                    _local_4 = this._SafeStr_11577.otherUserItems.getWithIndex(_arg_2.id);
                };
                if (_local_4 == null){
                    return;
                };
                _local_5 = _local_4._SafeStr_7867();
                if (_local_5 == null){
                    return;
                };
                _local_6 = this._SafeStr_11577.getItemImage(_local_5);
                if ((_local_5 is FloorItem)){
                    _local_7 = ((("$" + "{roomItem.name.") + _local_5.type) + "}");
                }
                else {
                    _local_7 = ((("$" + "{wallItem.name.") + _local_5.type) + "}");
                };
                if (_local_5.category == FurniCategory._SafeStr_7055){
                    _local_7 = (("${poster_" + _local_5.stuffData) + "_name}");
                };
                if (_local_5.category == FurniCategory._SafeStr_7059){
                    _local_8 = (_local_5 as FloorItem);
                    _local_9 = new Date(_local_8.creationYear, (_local_8.creationMonth - 1), _local_8.creationDay);
                    _local_7 = ((this._localization.getKey(("roomItem.name." + _local_5.type)) + " ") + _local_9.toLocaleDateString());
                };
                if (_local_5.category == FurniCategory._SafeStr_7057){
                    _local_7 = this.getTraxSongFurniName(_local_4, _local_7, true, _arg_2.id, _arg_3);
                };
                this._SafeStr_11247.updateContent((_arg_2 as IWindowContainer), _local_7, _local_6, ItemPopupCtrl._SafeStr_11602);
                this._SafeStr_11247.show();
            }
            else {
                if (_arg_1.type == WindowMouseEvent.WME_OUT){
                    this._SafeStr_11247.hideDelayed();
                };
            };
        }
        public function onTradingAlert(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            if (_arg_2.type == WindowEvent.WE_OK){
                _arg_1.dispose();
            };
        }
        private function getTraxSongFurniName(_arg_1:GroupItem, _arg_2:String, _arg_3:Boolean, _arg_4:uint=1, _arg_5:Boolean=false):String
        {
            var _local_6:IItem = _arg_1._SafeStr_7867();
            var _local_7:ISongInfo = this._soundManager.musicController.getSongInfo(_local_6.extra);
            if (_local_7 != null){
                this._localization.registerParameter("songdisc.info", "name", _local_7.name);
                this._localization.registerParameter("songdisc.info", "author", _local_7.creator);
                _arg_2 = this._localization.getKey("songdisc.info");
            }
            else {
                if (_arg_3){
                    if (this._SafeStr_11581.length > 0){
                        this._SafeStr_11581.pop();
                        this._SafeStr_11581.pop();
                        this._SafeStr_11581.pop();
                    };
                    this._SafeStr_11581.push(_arg_4);
                    this._SafeStr_11581.push(_arg_1);
                    this._SafeStr_11581.push(_arg_5);
                    this._soundManager.musicController.requestSongInfoWithoutSamples(_local_6.extra);
                };
            };
            return (_arg_2);
        }
        private function onSongInfoReceivedEvent(_arg_1:SongInfoReceivedEvent):void
        {
            var _local_2:Boolean;
            var _local_3:GroupItem;
            var _local_4:uint;
            var _local_5:IItem;
            var _local_6:String;
            var _local_7:BitmapData;
            var _local_8:IWindow;
            if (this._SafeStr_11581.length > 0){
                _local_2 = this._SafeStr_11581.pop();
                _local_3 = this._SafeStr_11581.pop();
                _local_4 = this._SafeStr_11581.pop();
                _local_5 = _local_3._SafeStr_7867();
                if (_local_5.extra == _arg_1.id){
                    if (((((_local_2) && ((this._SafeStr_11577.ownUserItems.getWithIndex(_local_4) == _local_3)))) || (((!(_local_2)) && ((this._SafeStr_11577.otherUserItems.getWithIndex(_local_4) == _local_3)))))){
                        _local_6 = this.getTraxSongFurniName(_local_3, "", false);
                        _local_7 = this._SafeStr_11577.getItemImage(_local_5);
                        _local_8 = ((_local_2) ? this.getOwnUsersItemGrid().getGridItemAt(_local_4) : this.getOtherUsersItemGrid().getGridItemAt(_local_4));
                        this._SafeStr_11247.updateContent((_local_8 as IWindowContainer), _local_6, _local_7, ItemPopupCtrl._SafeStr_11602);
                    };
                }
                else {
                    this._SafeStr_11581.push(_local_4);
                    this._SafeStr_11581.push(_local_3);
                    this._SafeStr_11581.push(_local_2);
                };
            };
        }

    }
}//package com.sulake.habbo.inventory.trading

// _SafeStr_11247 = "_-1xs" (String#1786, DoABC#2)
// iconCallbackId = "_-2dD" (String#20572, DoABC#2)
// _SafeStr_11524 = "_-19b" (String#16841, DoABC#2)
// _SafeStr_11525 = "_-3I5" (String#22205, DoABC#2)
// _SafeStr_11526 = "_-0Sg" (String#15159, DoABC#2)
// _SafeStr_11527 = "_-28a" (String#19354, DoABC#2)
// _SafeStr_11528 = "_-1LO" (String#17329, DoABC#2)
// _SafeStr_11529 = "_-1Pl" (String#17498, DoABC#2)
// ownUserId = "_-2n4" (String#20964, DoABC#2)
// ownUserItems = "_-1bV" (String#17955, DoABC#2)
// ownUserAccepts = "_-2Yh" (String#20383, DoABC#2)
// otherUserId = "_-0uV" (String#16221, DoABC#2)
// otherUserName = "_-rw" (String#24359, DoABC#2)
// otherUserItems = "_-lh" (String#24098, DoABC#2)
// otherUserAccepts = "_-0oG" (String#15987, DoABC#2)
// updateItemList = "_-23a" (String#19158, DoABC#2)
// updateUserInterface = "_-2BP" (String#19460, DoABC#2)
// clearItemLists = "_-2kF" (String#20855, DoABC#2)
// requestCancelTrading = "_-2Xf" (String#20346, DoABC#2)
// startConfirmCountdown = "_-2o5" (String#21005, DoABC#2)
// cancelConfirmCountdown = "_-2AB" (String#19410, DoABC#2)
// getFurniInventoryModel = "_-04E" (String#14212, DoABC#2)
// confirmCountdownReady = "_-1Ci" (String#16972, DoABC#2)
// getItemImage = "_-1gL" (String#18152, DoABC#2)
// updateItemImage = "_-28e" (String#19357, DoABC#2)
// alertPopup = "_-1E3" (String#17030, DoABC#2)
// _SafeStr_11563 = "_-34s" (String#21691, DoABC#2)
// _SafeStr_11564 = "_-2Os" (String#19997, DoABC#2)
// showOtherUserNotification = "_-22" (String#19088, DoABC#2)
// showOwnUserNotification = "_-0j0" (String#15791, DoABC#2)
// requestFurniViewOpen = "_-0VJ" (String#15256, DoABC#2)
// requestRemoveItemFromTrading = "_-2GH" (String#19653, DoABC#2)
// requestAcceptTrading = "_-1b8" (String#17941, DoABC#2)
// requestUnacceptTrading = "_-225" (String#19095, DoABC#2)
// requestConfirmAcceptTrading = "_-301" (String#21503, DoABC#2)
// requestConfirmDeclineTrading = "_-25W" (String#19239, DoABC#2)
// _SafeStr_11574 = "_-1U6" (String#17670, DoABC#2)
// _SafeStr_11575 = "_-16G" (String#16707, DoABC#2)
// _SafeStr_11576 = "_-2Qi" (String#20074, DoABC#2)
// _SafeStr_11577 = "_-04M" (String#14217, DoABC#2)
// _SafeStr_11578 = "_-ci" (String#23742, DoABC#2)
// _SafeStr_11579 = "_-2ac" (String#20470, DoABC#2)
// _SafeStr_11580 = "_-0ba" (String#15498, DoABC#2)
// _SafeStr_11581 = "_-0e3" (String#15587, DoABC#2)
// hideOwnUserNotification = "_-1rO" (String#18600, DoABC#2)
// hideOtherUserNotification = "_-HC" (String#22898, DoABC#2)
// showInfoMessage = "_-1yy" (String#18925, DoABC#2)
// createNormalWindow = "_-x3" (String#24572, DoABC#2)
// createMinimizedWindow = "_-2of" (String#21030, DoABC#2)
// ownThumbEventProc = "_-15A" (String#16660, DoABC#2)
// othersThumbEventProc = "_-0rl" (String#16111, DoABC#2)
// windowMininizedEventProc = "_-1dl" (String#18048, DoABC#2)
// getOwnUsersItemGrid = "_-1Ym" (String#17840, DoABC#2)
// getOtherUsersItemGrid = "_-vx" (String#24526, DoABC#2)
// updateActionState = "_-0NI" (String#14967, DoABC#2)
// onTradingAlert = "_-2AQ" (String#19424, DoABC#2)
// showAlertNotification = "_-0ey" (String#15626, DoABC#2)
// resolveItemThumbnail = "_-2m7" (String#20923, DoABC#2)
// createThumbnailContainer = "_-2zY" (String#21441, DoABC#2)
// selectOwnTradeItem = "_-2Hs" (String#19722, DoABC#2)
// selectOthersTradeItem = "_-hK" (String#23943, DoABC#2)
// thumbEventProc = "_-0G9" (String#14691, DoABC#2)
// getTraxSongFurniName = "_-2H4" (String#19687, DoABC#2)
// updateContent = "_-N5" (String#23127, DoABC#2)
// _SafeStr_11602 = "_-14h" (String#16641, DoABC#2)
// hideDelayed = "_-2Ey" (String#19602, DoABC#2)
// ImageResult = "_-31w" (String#21576, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// FurniCategory = "_-0lm" (String#15890, DoABC#2)
// IItemGridWindow = "_-265" (String#1809, DoABC#2)
// IItem = "_-1-k" (String#4863, DoABC#2)
// TradingModel = "_-1PM" (String#5341, DoABC#2)
// GroupItem = "_-0qS" (String#4647, DoABC#2)
// ISongInfo = "_-2vd" (String#7190, DoABC#2)
// IGetImageListener = "_-2i7" (String#6909, DoABC#2)
// WallItem = "_-2ZP" (String#20413, DoABC#2)
// FloorItem = "_-2DW" (String#19547, DoABC#2)
// IInventoryView = "_-1g8" (String#5665, DoABC#2)
// TradingView = "_-0VY" (String#4218, DoABC#2)
// ItemPopupCtrl = "_-0QF" (String#15073, DoABC#2)
// extra = "_-2We" (String#6693, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// stuffData = "_-0vz" (String#1580, DoABC#2)
// creationDay = "_-0jt" (String#15824, DoABC#2)
// creationMonth = "_-1T6" (String#17629, DoABC#2)
// creationYear = "_-0Ts" (String#15202, DoABC#2)
// IHabboSoundManager = "_-0vD" (String#4750, DoABC#2)
// getWindowContainer = "_-v8" (String#313, DoABC#2)
// iconImage = "_-0Pn" (String#4088, DoABC#2)
// _SafeStr_5297 = "_-0Gy" (String#355, DoABC#2)
// _visible = "_-1SE" (String#363, DoABC#2)
// getGridItemAt = "_-B9" (String#7890, DoABC#2)
// creator = "_-1U2" (String#5433, DoABC#2)
// musicController = "_-1Qk" (String#5366, DoABC#2)
// getSongInfo = "_-0Fc" (String#3864, DoABC#2)
// SIR_TRAX_SONG_INFO_RECEIVED = "_-02" (String#14127, DoABC#2)
// onSongInfoReceivedEvent = "_-1Di" (String#360, DoABC#2)
// _SafeStr_6827 = "_-0Pc" (String#4085, DoABC#2)
// setMinimized = "_-2Cz" (String#6306, DoABC#2)
// _SafeStr_7055 = "_-0z3" (String#16396, DoABC#2)
// _SafeStr_7057 = "_-W0" (String#23493, DoABC#2)
// _SafeStr_7059 = "_-3Am" (String#21911, DoABC#2)
// timerEventHandler = "_-0bW" (String#4333, DoABC#2)
// requestSongInfoWithoutSamples = "_-3CP" (String#7560, DoABC#2)
// displayItemInfo = "_-264" (String#19261, DoABC#2)
// _SafeStr_7867 = "catch" (String#25155, DoABC#2)
// WE_OK = "_-0UB" (String#15212, DoABC#2)


