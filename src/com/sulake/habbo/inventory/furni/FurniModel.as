
package com.sulake.habbo.inventory.furni
{
    import com.sulake.habbo.inventory.enum.FurniModelCategory;
    import com.sulake.habbo.inventory.IInventoryModel;
    import com.sulake.habbo.inventory.HabboInventory;
    import com.sulake.core.utils.Map;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import flash.utils.Timer;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.inventory.pets.PetsModel;
    import com.sulake.habbo.room.events.RoomEngineObjectEvent;
    import flash.events.TimerEvent;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.inventory.marketplace.MarketplaceModel;
    import com.sulake.habbo.inventory.items.IItem;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniData;
    import com.sulake.habbo.inventory.events.HabboInventoryItemAddedEvent;
    import com.sulake.habbo.inventory.enum.InventoryCategory;
    import com.sulake.habbo.inventory.items.FloorItem;
    import com.sulake.habbo.inventory.items.WallItem;
    import flash.display.BitmapData;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.inventory.enum.FurniCategory;
    import com.sulake.habbo.inventory.items.GroupItem;
    import flash.events.Event;
    import com.sulake.habbo.inventory.events.HabboInventoryTrackingEvent;
    import flash.utils.getTimer;
    import com.sulake.habbo.inventory.trading.TradingModel;
    import com.sulake.habbo.inventory.recycler.RecyclerModel;
    import com.sulake.habbo.inventory.enum.InventorySubCategory;
    import com.sulake.habbo.communication.messages.outgoing.inventory.furni.RequestRoomPropertySet;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.communication.messages.outgoing.inventory.furni.RequestFurniInventoryComposer;
    import com.sulake.habbo.communication.messages.outgoing.notifications.UnseenItemCategoryEnum;
    import com.sulake.habbo.communication.messages.outgoing.notifications.ResetUnseenItemsComposer;
    import __AS3__.vec.*;

    public class FurniModel extends FurniModelCategory implements IInventoryModel 
    {

        private static const _SafeStr_7791:int = 100;
        private static const _SafeStr_7792:int = 1000;

        private var _controller:HabboInventory;
        private var _view:FurniView;
        private var _furniData:Map;
        private var _assets:IAssetLibrary;
        private var _windowManager:IHabboWindowManager;
        private var _roomEngine:IRoomEngine;
        private var _communication:IHabboCommunicationManager;
        private var _soundManager:IHabboSoundManager;
        private var _disposed:Boolean = false;
        private var _SafeStr_7793:int = -1;
        private var _SafeStr_7794:Timer;
        private var _SafeStr_7795:XML;
        private var _SafeStr_7796:IWindowContainer;
        private var _SafeStr_7797:Boolean;
        private var _SafeStr_7798:Timer;
        private var _SafeStr_7799:Boolean;
        private var _catalog:IHabboCatalog;
        private var _SafeStr_7800:Vector.<Array>;
        private var _wallMsgFragments:Vector.<Array>;
        private var _SafeStr_7801:int;
        private var _SafeStr_7802:Array;
        private var _SafeStr_7803:Array;
        private var _petsModel:PetsModel;

        public function FurniModel(_arg_1:HabboInventory, _arg_2:MarketplaceModel, _arg_3:IHabboWindowManager, _arg_4:IHabboCommunicationManager, _arg_5:IAssetLibrary, _arg_6:IRoomEngine, _arg_7:IHabboCatalog, _arg_8:IHabboSoundManager)
        {
            this._controller = _arg_1;
            this._communication = _arg_4;
            this._windowManager = _arg_3;
            this._assets = _arg_5;
            this._roomEngine = _arg_6;
            this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOB_OBJECT_PLACED, this.onObjectPlaced);
            this._catalog = _arg_7;
            this._soundManager = _arg_8;
            this._SafeStr_7802 = [];
            this._SafeStr_7803 = [];
            this._SafeStr_7798 = new Timer(_SafeStr_7791, 1);
            this._SafeStr_7798.addEventListener(TimerEvent.TIMER_COMPLETE, this.onImageUpdateTimerEvent);
            var _local_9:IAsset = this._assets.getAssetByName("inventory_thumb_xml");
            var _local_10:XmlAsset = XmlAsset(_local_9);
            this._SafeStr_7795 = XML(_local_10.content);
            this.clearFurniList();
            this._view = new FurniView(this, _arg_2, this._windowManager, this._assets, this._roomEngine, this._soundManager);
            this._view.switchCategory(S);
        }
        public function set petsModel(_arg_1:PetsModel):void
        {
            this._petsModel = _arg_1;
        }
        public function get petsModel():PetsModel
        {
            return (this._petsModel);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            if (!this._disposed){
                this._controller = null;
                if (this._furniData != null){
                    this._furniData.dispose();
                    this._furniData = null;
                };
                if (this._view != null){
                    this._view.dispose();
                    this._view = null;
                };
                if (this._roomEngine != null){
                    if (this._roomEngine.events != null){
                        this._roomEngine.events.removeEventListener(RoomEngineObjectEvent.REOB_OBJECT_PLACED, this.onObjectPlaced);
                    };
                    this._roomEngine = null;
                };
                this._communication = null;
                this._assets = null;
                this._windowManager = null;
                this._catalog = null;
                this._soundManager = null;
                this._petsModel = null;
                if (this._SafeStr_7798 != null){
                    this._SafeStr_7798.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onImageUpdateTimerEvent);
                    this._SafeStr_7798.stop();
                    this._SafeStr_7798 = null;
                };
                if (this._SafeStr_7794 != null){
                    this._SafeStr_7794.removeEventListener(TimerEvent.TIMER_COMPLETE, this.initTimeout);
                    this._SafeStr_7794.stop();
                    this._SafeStr_7794 = null;
                };
                if (this._SafeStr_7796 != null){
                    this._SafeStr_7796.dispose();
                    this._SafeStr_7796 = null;
                };
                this._disposed = true;
            };
        }
        public function insertFurniList(_arg_1:String, _arg_2:Array, _arg_3:int, _arg_4:int):void
        {
            var _local_5:IItem;
            var _local_6:FurniData;
            var _local_15:Vector.<Array>;
            var _local_16:Array;
            var _local_17:Array;
            var _local_18:int;
            var _local_19:HabboInventoryItemAddedEvent;
            if ((((_arg_3 >= _arg_4)) && ((_arg_3 > 1)))){
                if (_arg_1 == S){
                    if (this._SafeStr_7800 == null){
                        this._SafeStr_7800 = new Vector.<Array>(_arg_3, true);
                    };
                    _local_15 = this._SafeStr_7800;
                }
                else {
                    if (this._wallMsgFragments == null){
                        this._wallMsgFragments = new Vector.<Array>(_arg_3, true);
                    };
                    _local_15 = this._wallMsgFragments;
                };
                _local_15[(_arg_4 - 1)] = _arg_2;
                for each (_local_16 in _local_15) {
                    if (_local_16 == null){
                        return;
                    };
                };
                _arg_2 = new Array();
                for each (_local_17 in _local_15) {
                    _arg_2 = _arg_2.concat(_local_17);
                };
                _local_15 = null;
            };
            if (_arg_1 == S){
                this._SafeStr_7800 = null;
            }
            else {
                this._wallMsgFragments = null;
            };
            this._controller.setInventoryCategoryInit(InventoryCategory._SafeStr_5995);
            var _local_7:Array = new Array();
            var _local_8:Array = new Array();
            var _local_9:Array = new Array();
            var _local_10:Array = new Array();
            this.getAllStripIds(_arg_1, _local_7);
            var _local_11:int;
            while (_local_11 < _arg_2.length) {
                _local_18 = FurniData(_arg_2[_local_11]).stripId;
                if (_local_7.indexOf(_local_18) == -1){
                    _local_9.push(_local_18);
                };
                _local_8.push(_local_18);
                _local_11++;
            };
            _local_11 = 0;
            while (_local_11 < _local_7.length) {
                if (_local_8.indexOf(_local_7[_local_11]) == -1){
                    _local_10.push(_local_7[_local_11]);
                };
                _local_11++;
            };
            this._view.setGridLock(_arg_1, true);
            var _local_12 = (_local_7.length == 0);
            var _local_13:int;
            while (_local_13 < _arg_2.length) {
                _local_6 = FurniData(_arg_2[_local_13]);
                if (_local_9.indexOf(_local_6.stripId) > -1){
                    if (_local_6.itemType == S){
                        _local_5 = new FloorItem(_local_6.stripId, _local_6.classId, _local_6.objId, _local_6.category, _local_6.isGroupable, _local_6.isTradeable, _local_6.isRecyclable, _local_6.isSellable, _local_6.stuffData, _local_6.extra, _local_6.expiryTime, 0, 0, 0, _local_6.slotId, _local_6.songId);
                    }
                    else {
                        if (_local_6.itemType == I){
                            _local_5 = new WallItem(_local_6.stripId, _local_6.classId, _local_6.objId, _local_6.category, _local_6.isGroupable, _local_6.isTradeable, _local_6.isRecyclable, _local_6.isSellable, _local_6.stuffData, _local_6.extra);
                        }
                        else {
                            throw (new Error((('Unknown inventory item category: "' + _local_6.itemType) + '"')));
                        };
                    };
                    if (_local_12){
                        this.addFurniAsLast(_local_5, true);
                    }
                    else {
                        this.addFurniAt(_local_5, true, 0, true);
                    };
                };
                _local_13++;
            };
            var _local_14:int;
            while (_local_14 < _local_10.length) {
                this.removeFurni(_local_10[_local_14]);
                _local_14++;
            };
            this._view.setGridLock(_arg_1, false);
            this.updateItemLocks();
            if (this.getSelectedItemIndex(S) == -1){
                this.toggleItemSelection(S, 0);
            };
            if (this.getSelectedItemIndex(I) == -1){
                this.toggleItemSelection(I, 0);
            };
            this.initListImages();
            this.setListInitialized();
            for each (_local_6 in _arg_2) {
                if (_local_9.indexOf(_local_6.stripId) > -1){
                    _local_19 = new HabboInventoryItemAddedEvent(_local_6.classId, _local_6.stripId, _local_6.category);
                    this._controller.events.dispatchEvent(_local_19);
                };
            };
        }
        public function isListInited():Boolean
        {
            return (this._SafeStr_7799);
        }
        public function setListInitialized():void
        {
            this._SafeStr_7799 = true;
            this._view.setViewToState();
        }
        public function createNewGroupItemTemplate(_arg_1:int, _arg_2:String, _arg_3:int, _arg_4:String=null, _arg_5:Number=NaN, _arg_6:Boolean=false):GroupItem
        {
            var _local_7:BitmapData;
            var _local_8:IAsset;
            var _local_9:BitmapData;
            var _local_12:BitmapDataAsset;
            var _local_13:IBitmapWrapperWindow;
            if (_arg_3 == FurniCategory._SafeStr_7051){
                _local_8 = this._assets.getAssetByName("icon_wallpaper_png");
                if (_local_8 != null){
                    _local_7 = (_local_8.content as BitmapData);
                };
            }
            else {
                if (_arg_3 == FurniCategory._SafeStr_7052){
                    _local_8 = this._assets.getAssetByName("icon_floor_png");
                    if (_local_8 != null){
                        _local_7 = (_local_8.content as BitmapData);
                    };
                }
                else {
                    if (_arg_3 == FurniCategory._SafeStr_7053){
                        _local_8 = this._assets.getAssetByName("icon_landscape_png");
                        if (_local_8 != null){
                            _local_7 = (_local_8.content as BitmapData);
                        };
                    };
                };
            };
            var _local_10:IAsset = this._assets.getAssetByName("thumb_icon_recycle_png");
            if (_local_10 != null){
                _local_9 = (_local_10.content as BitmapData);
            };
            if (this._SafeStr_7796 == null){
                this._SafeStr_7796 = (this._windowManager.buildFromXML(this._SafeStr_7795) as IWindowContainer);
                _local_12 = (this._assets.getAssetByName("thumb_selected_outline_png") as BitmapDataAsset);
                _local_13 = (this._SafeStr_7796.findChildByName("outline") as IBitmapWrapperWindow);
                _local_13.bitmap = (_local_12.content as BitmapData);
                _local_13.disposesBitmap = false;
            };
            var _local_11:IWindowContainer = (this._SafeStr_7796.clone() as IWindowContainer);
            return (new GroupItem(_arg_1, _arg_2, _arg_3, _local_11, this._roomEngine, _local_9.clone(), this._controller.recyclerModel.running, _arg_4, _arg_5, _local_7, _arg_6));
        }
        public function initListImages():void
        {
            var _local_1:Array;
            var _local_2:String;
            var _local_3:GroupItem;
            var _local_6:int;
            var _local_4:Array = [S, I];
            var _local_5:int;
            while (_local_5 < _local_4.length) {
                _local_2 = _local_4[_local_5];
                _local_1 = this.getCategoryContent(_local_2);
                if (_local_1 != null){
                    _local_6 = 0;
                    while (_local_6 < _local_1.length) {
                        _local_3 = (_local_1[_local_6] as GroupItem);
                        if (!_local_3.isImageInited){
                            _local_3.initImage(false);
                            if (!_local_3.isImageFinished){
                                this._SafeStr_7798.reset();
                                this._SafeStr_7798.start();
                                return;
                            };
                        };
                        _local_6++;
                    };
                };
                _local_5++;
            };
        }
        private function onImageUpdateTimerEvent(_arg_1:TimerEvent):void
        {
            this.initListImages();
        }
        public function requestInitialization(_arg_1:int=0):void
        {
            if (_arg_1 > 0){
                if (this._SafeStr_7794 != null){
                    this._SafeStr_7794.removeEventListener(TimerEvent.TIMER_COMPLETE, this.initTimeout);
                    this._SafeStr_7794.stop();
                    this._SafeStr_7794 = null;
                };
                this._SafeStr_7794 = new Timer(_arg_1, 1);
                this._SafeStr_7794.addEventListener(TimerEvent.TIMER_COMPLETE, this.initTimeout);
                this._SafeStr_7794.start();
            }
            else {
                this.requestNewList();
            };
        }
        public function categorySwitch(_arg_1:String):void
        {
            if ((((_arg_1 == InventoryCategory._SafeStr_5995)) && (this._controller.isVisible))){
                switch (this._view.visibleCategoryId){
                    case S:
                        this._controller.events.dispatchEvent(new Event(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_FURNI));
                        return;
                    case I:
                        this._controller.events.dispatchEvent(new Event(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_POSTERS));
                        return;
                    case _SafeStr_7068:
                        this._controller.toggleInventoryPage(InventoryCategory._SafeStr_5996);
                        return;
                };
            };
        }
        public function furniCategorySwitch():void
        {
            if (this._controller.isVisible){
                switch (this._view.visibleCategoryId){
                    case S:
                        this._controller.events.dispatchEvent(new Event(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_FURNI));
                        return;
                    case I:
                        this._controller.events.dispatchEvent(new Event(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_POSTERS));
                        return;
                    case _SafeStr_7068:
                        this._controller.toggleInventoryPage(InventoryCategory._SafeStr_5996);
                        return;
                };
            };
        }
        public function switchCategory(_arg_1:String):void
        {
            this._view.switchCategory(_arg_1);
        }
        public function automaticSwitchToPetCategory():void
        {
            this._SafeStr_7801 = getTimer();
            this.switchCategory(_SafeStr_7068);
        }
        private function initTimeout(_arg_1:TimerEvent):void
        {
            if (this._SafeStr_7794 != null){
                this._SafeStr_7794.removeEventListener(TimerEvent.TIMER_COMPLETE, this.initTimeout);
                this._SafeStr_7794.stop();
                this._SafeStr_7794 = null;
            };
            this.requestNewList();
        }
        public function getWindowContainer():IWindowContainer
        {
            this._controller.checkCategoryInitilization(InventoryCategory._SafeStr_7062);
            return (this._view.getWindowContainer());
        }
        public function closingInventoryView():void
        {
            if (this._view.isVisible){
                this.resetUnseenItems();
            };
        }
        public function updateItemLocks():void
        {
            var _local_4:Array;
            var _local_5:String;
            var _local_6:GroupItem;
            var _local_9:int;
            var _local_1:Array = new Array();
            var _local_2:TradingModel = this._controller.tradingModel;
            if (_local_2 != null){
                _local_1 = _local_1.concat(_local_2.getOwnItemIdsInTrade());
            };
            var _local_3:RecyclerModel = this._controller.recyclerModel;
            if (_local_3 != null){
                _local_1 = _local_1.concat(_local_3.getOwnItemsInRecycler());
            };
            if (_local_1.length == 0){
                this.removeAllLocks();
                return;
            };
            var _local_7:Array = [S, I];
            var _local_8:int;
            while (_local_8 < _local_7.length) {
                _local_5 = _local_7[_local_8];
                _local_4 = this.getCategoryContent(_local_5);
                if (_local_4 != null){
                    _local_9 = 0;
                    while (_local_9 < _local_4.length) {
                        _local_6 = (_local_4[_local_9] as GroupItem);
                        _local_6.addLocksFromData(_local_1);
                        _local_9++;
                    };
                };
                _local_8++;
            };
            this._view.updateActionView();
        }
        public function addLockTo(_arg_1:int):void
        {
            var _local_2:Array;
            var _local_3:String;
            var _local_4:GroupItem;
            var _local_7:int;
            var _local_5:Array = [S, I];
            var _local_6:int;
            while (_local_6 < _local_5.length) {
                _local_3 = _local_5[_local_6];
                _local_2 = this.getCategoryContent(_local_3);
                if (_local_2 != null){
                    _local_7 = 0;
                    while (_local_7 < _local_2.length) {
                        _local_4 = (_local_2[_local_7] as GroupItem);
                        _local_4.addLockTo(_arg_1);
                        _local_7++;
                    };
                };
                _local_6++;
            };
            this._view.updateActionView();
        }
        public function removeLockFrom(_arg_1:int):void
        {
            var _local_2:Array;
            var _local_3:String;
            var _local_4:GroupItem;
            var _local_7:int;
            var _local_5:Array = [S, I];
            var _local_6:int;
            while (_local_6 < _local_5.length) {
                _local_3 = _local_5[_local_6];
                _local_2 = this.getCategoryContent(_local_3);
                if (_local_2 != null){
                    _local_7 = 0;
                    while (_local_7 < _local_2.length) {
                        _local_4 = (_local_2[_local_7] as GroupItem);
                        if (_local_4){
                            _local_4.removeLockFrom(_arg_1);
                        };
                        _local_7++;
                    };
                };
                _local_6++;
            };
            this._view.updateActionView();
        }
        public function showRecyclable(_arg_1:Boolean):void
        {
            var _local_2:Array;
            var _local_3:String;
            var _local_4:GroupItem;
            var _local_7:int;
            var _local_5:Array = [S, I];
            var _local_6:int;
            while (_local_6 < _local_5.length) {
                _local_3 = _local_5[_local_6];
                _local_2 = this.getCategoryContent(_local_3);
                if (_local_2 != null){
                    _local_7 = 0;
                    while (_local_7 < _local_2.length) {
                        _local_4 = (_local_2[_local_7] as GroupItem);
                        _local_4.showRecyclable = _arg_1;
                        _local_7++;
                    };
                };
                _local_6++;
            };
            this._view.updateActionView();
        }
        public function clearFurniList():void
        {
            this._furniData = new Map();
            this._furniData.add(S, new Array());
            this._furniData.add(I, new Array());
            if (this._view != null){
                this._view.clearViews();
            };
        }
        public function addFurniAsLast(_arg_1:IItem, _arg_2:Boolean=false):void
        {
            this.addFurniAt(_arg_1, _arg_2);
        }
        public function addFurniAt(_arg_1:IItem, _arg_2:Boolean=false, _arg_3:int=-1, _arg_4:Boolean=false):void
        {
            var _local_5:Boolean;
            var _local_6:String;
            var _local_7:GroupItem;
            var _local_9:GroupItem;
            var _local_10:int;
            if ((_arg_1 is FloorItem)){
                _local_6 = S;
                _local_5 = (this._SafeStr_7802.indexOf(_arg_1.ref) > -1);
            }
            else {
                if ((_arg_1 is WallItem)){
                    _local_6 = I;
                    _local_5 = (this._SafeStr_7803.indexOf(_arg_1.ref) > -1);
                }
                else {
                    return;
                };
            };
            var _local_8:Array = this.getCategoryContent(_local_6);
            if (!_arg_1.groupable){
                for each (_local_9 in _local_8) {
                    if (_local_9.type == _arg_1.type){
                        if (_local_9.getItem(_arg_1.id) != null){
                            return;
                        };
                        break;
                    };
                };
                _local_7 = this.createNewGroupItemTemplate(_arg_1.type, _local_6, _arg_1.category, _arg_1.stuffData, _arg_1.extra, _arg_2);
                _local_7.push(_arg_1, _local_5);
                if (this._view != null){
                    if (_local_5){
                        _local_8.unshift(_local_7);
                        this._view.addItemAt(_local_6, _local_7, 0);
                    }
                    else {
                        if (_arg_3 == -1){
                            _local_8.push(_local_7);
                            this._view.addItemToBottom(_local_6, _local_7);
                        }
                        else {
                            _local_8.splice(_arg_3, 0, _local_7);
                            this._view.addItemAt(_local_6, _local_7, _arg_3);
                        };
                    };
                };
            }
            else {
                _local_10 = 0;
                while (_local_10 < _local_8.length) {
                    _local_9 = (_local_8[_local_10] as GroupItem);
                    if (_local_9.type == _arg_1.type){
                        if (_arg_1.category == FurniCategory._SafeStr_7055){
                            if (_local_9.stuffData == _arg_1.stuffData){
                                _local_7 = _local_9;
                                break;
                            };
                        }
                        else {
                            _local_7 = _local_9;
                            break;
                        };
                    };
                    _local_10++;
                };
                if (_local_7){
                    _local_7.push(_arg_1, _local_5);
                    if (_local_5){
                        this.moveGroupItemTo(_local_8, _local_7, 0);
                    };
                }
                else {
                    _local_7 = this.createNewGroupItemTemplate(_arg_1.type, _local_6, _arg_1.category, _arg_1.stuffData, _arg_1.extra, _arg_2);
                    _local_7.push(_arg_1, _local_5);
                    if (this._view != null){
                        if (_local_5){
                            _local_8.unshift(_local_7);
                            this._view.addItemAt(_local_6, _local_7, 0);
                        }
                        else {
                            if (_arg_3 == -1){
                                _local_8.push(_local_7);
                                this._view.addItemToBottom(_local_6, _local_7);
                            }
                            else {
                                _local_8.unshift(_local_7);
                                this._view.addItemAt(_local_6, _local_7, _arg_3);
                            };
                        };
                    };
                };
            };
            this._view.setViewToState();
            if (_arg_4){
                if (this._view.visibleCategoryId == _SafeStr_7068){
                    if (!this.furniIsMostLikelyPetFood()){
                        this._controller.petsModel.switchToFurnitureCategory(_local_6, true);
                    };
                }
                else {
                    this.switchCategory(_local_6);
                };
            };
            if (_local_7.isSelected){
                this._view.updateActionView();
            };
        }
        private function furniIsMostLikelyPetFood():Boolean
        {
            return ((getTimer() < (this._SafeStr_7801 + _SafeStr_7792)));
        }
        public function removeFurni(_arg_1:int):void
        {
            var _local_2:Array;
            var _local_3:String;
            var _local_4:GroupItem;
            var _local_7:int;
            var _local_8:IItem;
            var _local_5:Array = [S, I];
            var _local_6:int;
            while (_local_6 < _local_5.length) {
                _local_3 = _local_5[_local_6];
                _local_2 = this.getCategoryContent(_local_3);
                if (_local_2 != null){
                    _local_7 = 0;
                    while (_local_7 < _local_2.length) {
                        _local_4 = (_local_2[_local_7] as GroupItem);
                        _local_8 = _local_4.remove(_arg_1);
                        if (_local_8){
                            if (this._SafeStr_7793 == _local_8.ref){
                                this.cancelFurniInMover();
                                if (!this.requestSelectedFurniPlacement()){
                                    this._controller.showView();
                                };
                            };
                            if (_local_4.getTotalCount() <= 0){
                                this._view.removeItem(_local_3, _local_7);
                                _local_2.splice(_local_7, 1);
                                if (_local_4.isSelected){
                                    this.toggleItemSelection(_local_3, 0);
                                };
                            }
                            else {
                                this._view.updateActionView();
                            };
                            this.resetUnseenItems(_local_3);
                            this._view.setViewToState();
                            return;
                        };
                        _local_7++;
                    };
                };
                _local_6++;
            };
        }
        public function updatePostItCount(_arg_1:int, _arg_2:int):void
        {
            var _local_5:GroupItem;
            var _local_6:WallItem;
            var _local_3:Array = this.getCategoryContent(I);
            if (_local_3 == null){
                return;
            };
            var _local_4:int;
            while (_local_4 < _local_3.length) {
                _local_5 = (_local_3[_local_4] as GroupItem);
                _local_6 = (_local_5.getItem(_arg_1) as WallItem);
                if (_local_6 != null){
                    _local_6.stuffData = String(_arg_2);
                    _local_5.replaceItem(_arg_1, _local_6);
                };
                _local_4++;
            };
        }
        public function toggleItemSelection(_arg_1:String, _arg_2:int):void
        {
            var _local_4:GroupItem;
            var _local_5:int;
            var _local_3:Array = this.getCategoryContent(_arg_1);
            if ((((_local_3 == null)) || ((_local_3.length == 0)))){
                return;
            };
            if ((((_arg_2 > -1)) && ((_local_3.length > _arg_2)))){
                _local_4 = (_local_3[_arg_2] as GroupItem);
                _local_4.isSelected = true;
                this._view.updateItem(_arg_1, _local_4, _arg_2);
            };
            if (((_local_4) && (_local_4.isSelected))){
                _local_5 = 0;
                while (_local_5 < _local_3.length) {
                    if (_local_5 != _arg_2){
                        _local_4 = (_local_3[_local_5] as GroupItem);
                        if (((_local_4) && (_local_4.isSelected))){
                            _local_4.isSelected = false;
                        };
                    };
                    _local_5++;
                };
            };
            this._view.updateActionView();
        }
        public function displayItemInfo(_arg_1:GroupItem):void
        {
            if (((this._view) && (!(this._view.disposed)))){
                this._view.displayItemInfo(_arg_1);
            };
        }
        public function getSelectedItemIndex(_arg_1:String=null):int
        {
            var _local_3:GroupItem;
            if (_arg_1 == null){
                if (this._view == null){
                    return (-1);
                };
            };
            if (_arg_1 == null){
                _arg_1 = this._view.visibleCategoryId;
            };
            var _local_2:Array = this.getCategoryContent(_arg_1);
            if (_local_2 == null){
                return (-1);
            };
            var _local_4:int;
            while (_local_4 < _local_2.length) {
                _local_3 = (_local_2[_local_4] as GroupItem);
                if (_local_3.isSelected){
                    return (_local_4);
                };
                _local_4++;
            };
            return (-1);
        }
        public function getGroupItemInIndex(_arg_1:int, _arg_2:String=null):GroupItem
        {
            if (_arg_2 == null){
                _arg_2 = this._view.visibleCategoryId;
            };
            var _local_3:Array = this.getCategoryContent(_arg_2);
            if (_local_3 == null){
                return (null);
            };
            if (_arg_1 >= _local_3.length){
                return (null);
            };
            return ((_local_3[_arg_1] as GroupItem));
        }
        public function getGroupItemByType(_arg_1:int):GroupItem
        {
            var _local_2:Array;
            var _local_3:String;
            var _local_4:GroupItem;
            var _local_7:int;
            var _local_5:Array = [S, I];
            var _local_6:int;
            while (_local_6 < _local_5.length) {
                _local_3 = _local_5[_local_6];
                _local_2 = this.getCategoryContent(_local_3);
                if (_local_2 != null){
                    _local_7 = 0;
                    while (_local_7 < _local_2.length) {
                        _local_4 = (_local_2[_local_7] as GroupItem);
                        if (_local_4.type == _arg_1){
                            return (_local_4);
                        };
                        _local_7++;
                    };
                };
                _local_6++;
            };
            return (null);
        }
        public function get isTradingOpen():Boolean
        {
            return ((this._controller.getSubCategoryViewId() == InventorySubCategory._SafeStr_7064));
        }
        public function canUserOfferToTrade():Boolean
        {
            return (this._controller.canUserOfferToTrade());
        }
        public function removeAllLocks():void
        {
            var _local_1:Array;
            var _local_2:String;
            var _local_3:GroupItem;
            var _local_6:int;
            var _local_4:Array = [S, I];
            var _local_5:int;
            while (_local_5 < _local_4.length) {
                _local_2 = _local_4[_local_5];
                _local_1 = this.getCategoryContent(_local_2);
                if (_local_1 != null){
                    _local_6 = 0;
                    while (_local_6 < _local_1.length) {
                        _local_3 = (_local_1[_local_6] as GroupItem);
                        if (_local_3 != null){
                            _local_3.removeAllLocks();
                        };
                        _local_6++;
                    };
                };
                _local_5++;
            };
            if (this._view != null){
                this._view.updateActionView();
            };
        }
        public function cancelFurniInMover():void
        {
            if (this._SafeStr_7793 > -1){
                this._roomEngine.cancelRoomObjectInsert();
                this._SafeStr_7797 = false;
                this._SafeStr_7793 = -1;
            };
        }
        public function requestSelectedFurniPlacement(_arg_1:Boolean=false):Boolean
        {
            var _local_2:GroupItem = this.getGroupItemInIndex(this.getSelectedItemIndex(), this._view.visibleCategoryId);
            if (_local_2 == null){
                return (false);
            };
            if (_local_2.getUnlockedCount() == 0){
                return (false);
            };
            var _local_3:IItem = _local_2._SafeStr_7867();
            if (_local_3 == null){
                return (false);
            };
            if ((((((_local_3.category == FurniCategory._SafeStr_7052)) || ((_local_3.category == FurniCategory._SafeStr_7051)))) || ((_local_3.category == FurniCategory._SafeStr_7053)))){
                if (_arg_1){
                    return (false);
                };
                this._communication.getHabboMainConnection(null).send(new RequestRoomPropertySet(_local_3.id));
            }
            else {
                this.requestSelectedFurniToMover(_local_3);
            };
            this._view.updateActionView();
            return (true);
        }
        private function requestSelectedFurniToMover(_arg_1:IItem):void
        {
            var _local_2:int;
            var _local_3:Boolean;
            if ((_arg_1 is FloorItem)){
                _local_2 = RoomObjectCategoryEnum._SafeStr_4329;
            }
            else {
                _local_2 = RoomObjectCategoryEnum._SafeStr_4330;
            };
            if (_arg_1.category == FurniCategory._SafeStr_7055){
                _local_3 = this._roomEngine.initializeRoomObjectInsert(_arg_1.id, _local_2, _arg_1.type, _arg_1.stuffData);
            }
            else {
                _local_3 = this._roomEngine.initializeRoomObjectInsert(_arg_1.id, _local_2, _arg_1.type, _arg_1.extra.toString());
            };
            if (_local_3){
                this._SafeStr_7793 = _arg_1.ref;
                if (!this._controller.recyclerModel.running){
                    this.requestClose();
                };
                this._SafeStr_7797 = true;
            };
            this._view.updateActionView();
        }
        public function requestSelectedFurniToTrading():void
        {
            var _local_1:GroupItem = this.getGroupItemInIndex(this.getSelectedItemIndex(), this._view.visibleCategoryId);
            if (_local_1 == null){
                return;
            };
            var _local_2:IItem = _local_1.getOneForTrade();
            if (_local_2 == null){
                return;
            };
            var _local_3:TradingModel = this._controller.tradingModel;
            if (_local_3 != null){
                _local_3.requestAddItemToTrading(_local_2.id, _local_2.type, _local_2.category, _local_2.groupable, _local_2.stuffData);
            };
            this._view.updateActionView();
        }
        public function requestSelectedFurniSelling():void
        {
            var _local_1:GroupItem = this.getGroupItemInIndex(this.getSelectedItemIndex(), this._view.visibleCategoryId);
            if (_local_1 == null){
                return;
            };
            var _local_2:IItem = _local_1.getOneForTrade();
            if (_local_2 == null){
                return;
            };
            var _local_3:MarketplaceModel = this._controller.marketplaceModel;
            if (_local_3 == null){
                return;
            };
            _local_3.startOfferMaking(_local_2);
        }
        public function requestSelectedFurniToRecycler():IItem
        {
            var _local_1:GroupItem = this.getGroupItemInIndex(this.getSelectedItemIndex(), this._view.visibleCategoryId);
            if (_local_1 == null){
                return (null);
            };
            var _local_2:IItem = _local_1.getOneForRecycle();
            if (_local_2 == null){
                return (null);
            };
            this._view.updateActionView();
            return (_local_2);
        }
        public function requestCurrentActionOnSelection():void
        {
            if (this.isTradingOpen){
                this.requestSelectedFurniToTrading();
            }
            else {
                this.requestSelectedFurniPlacement(false);
            };
        }
        public function onObjectPlaced(_arg_1:Event):void
        {
            if (((this._SafeStr_7797) && ((_arg_1.type == RoomEngineObjectEvent.REOB_OBJECT_PLACED)))){
                this._SafeStr_7797 = false;
            };
        }
        public function requestClose():void
        {
            this._controller.closeView();
        }
        public function requestNewList():void
        {
            var _local_1:IConnection = this._communication.getHabboMainConnection(null);
            if (_local_1 == null){
                return;
            };
            _local_1.send(new RequestFurniInventoryComposer());
        }
        public function requestCatalogOpen():void
        {
            this._catalog.openCatalog();
        }
        public function getCategoryContent(_arg_1:String):Array
        {
            return (this._furniData.getValue(_arg_1));
        }
        public function subCategorySwitch(_arg_1:String):void
        {
            switch (_arg_1){
                case InventorySubCategory._SafeStr_7064:
                    this.cancelFurniInMover();
                    if (this._view != null){
                        this._view.updateActionView();
                    };
                    return;
                case InventorySubCategory.:
                    this.removeAllLocks();
                    if (this._view != null){
                        this._view.updateActionView();
                    };
                    return;
            };
        }
        public function getAllStripIds(_arg_1:String, _arg_2:Array):void
        {
            var _local_4:GroupItem;
            var _local_5:int;
            var _local_6:int;
            var _local_3:Array = (this._furniData.getValue(_arg_1) as Array);
            if (_local_3 != null){
                for each (_local_4 in _local_3) {
                    _local_5 = _local_4.getTotalCount();
                    if (_local_4.category == FurniCategory._SafeStr_7054){
                        _local_5 = 1;
                    };
                    _local_6 = 0;
                    while (_local_6 < _local_5) {
                        _arg_2.push(_local_4.getAt(_local_6).id);
                        _local_6++;
                    };
                };
            };
        }
        public function updateView():void
        {
            if (this._view != null){
                this.updateGroupItems(S);
                this.updateGroupItems(I);
                this._view.updateCategoryButtons();
                this._view.updateActionView();
            };
        }
        private function updateGroupItems(_arg_1:String):void
        {
            var _local_2:Array;
            var _local_3:Array;
            var _local_4:GroupItem;
            var _local_5:int;
            if (_arg_1 == S){
                _local_2 = this._SafeStr_7802;
            }
            else {
                if (_arg_1 == I){
                    _local_2 = this._SafeStr_7803;
                }
                else {
                    return;
                };
            };
            var _local_6:Array = this.getCategoryContent(_arg_1);
            for each (_local_4 in _local_6) {
                _local_3 = _local_4.getFurniIds();
                for each (_local_5 in _local_3) {
                    if (_local_2.indexOf(_local_5) != -1){
                        _local_4.hasUnseenItems = true;
                        this.moveGroupItemTo(_local_6, _local_4, 0);
                        break;
                    };
                };
            };
        }
        private function moveGroupItemTo(_arg_1:Array, _arg_2:GroupItem, _arg_3:int):void
        {
            var _local_4:int = _arg_1.indexOf(_arg_2);
            _arg_1.splice(_local_4, 1);
            _arg_1.unshift(_arg_2);
            this._view.moveItemTo(_arg_2, _arg_3);
        }
        public function get isPrivateRoom():Boolean
        {
            if (((!(this._controller)) || (!(this._controller.roomSession)))){
                return (false);
            };
            return (this._controller.roomSession.isPrivateRoom);
        }
        public function isMainViewActive():Boolean
        {
            return (this._controller.isMainViewActive);
        }
        public function addUnseenFloorItems(_arg_1:Array):void
        {
            var _local_2:int;
            if (_arg_1 == null){
                return;
            };
            for each (_local_2 in _arg_1) {
                if (this._SafeStr_7802.indexOf(_local_2) == -1){
                    this._SafeStr_7802.push(_local_2);
                };
            };
        }
        public function addUnseenWallItems(_arg_1:Array):void
        {
            var _local_2:int;
            if (_arg_1 == null){
                return;
            };
            for each (_local_2 in _arg_1) {
                if (this._SafeStr_7803.indexOf(_local_2) == -1){
                    this._SafeStr_7803.push(_local_2);
                };
            };
        }
        public function getUnseenItemCount(_arg_1:int=0):int
        {
            switch (_arg_1){
                case UnseenItemCategoryEnum._SafeStr_6767:
                    return (this._SafeStr_7802.length);
                case UnseenItemCategoryEnum._SafeStr_6768:
                    return (this._SafeStr_7803.length);
                default:
                    return ((this._SafeStr_7802.length + this._SafeStr_7803.length));
            };
        }
        public function resetUnseenItems(_arg_1:String=null):void
        {
            var _local_3:Array;
            var _local_4:GroupItem;
            if (((!(this._view)) || (!(this._view.visibleCategoryId)))){
                return;
            };
            var _local_2:IConnection = this._communication.getHabboMainConnection(null);
            if (!_arg_1){
                _arg_1 = this._view.visibleCategoryId;
            };
            switch (_arg_1){
                case I:
                    if (((this._SafeStr_7803) && ((this._SafeStr_7803.length > 0)))){
                        _local_2.send(new ResetUnseenItemsComposer(UnseenItemCategoryEnum._SafeStr_6768));
                        this._SafeStr_7803 = [];
                        _local_3 = this.getCategoryContent(_arg_1);
                    };
                    break;
                case S:
                    if (((this._SafeStr_7802) && ((this._SafeStr_7802.length > 0)))){
                        _local_2.send(new ResetUnseenItemsComposer(UnseenItemCategoryEnum._SafeStr_6767));
                        this._SafeStr_7802 = [];
                        _local_3 = this.getCategoryContent(_arg_1);
                    };
                    break;
            };
            if (_local_3){
                this._controller.updateUnseenItemCounts();
                for each (_local_4 in _local_3) {
                    _local_4.hasUnseenItems = false;
                };
            };
        }

    }
}//package com.sulake.habbo.inventory.furni

// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// FurniCategory = "_-0lm" (String#15890, DoABC#2)
// InventoryCategory = "_-04Y" (String#14224, DoABC#2)
// HabboInventoryItemAddedEvent = "_-1m1" (String#18379, DoABC#2)
// RoomEngineObjectEvent = "_-10r" (String#16492, DoABC#2)
// RequestRoomPropertySet = "_-6-" (String#22465, DoABC#2)
// IItem = "_-1-k" (String#4863, DoABC#2)
// IInventoryModel = "_-Fh" (String#7987, DoABC#2)
// TradingModel = "_-1PM" (String#5341, DoABC#2)
// GroupItem = "_-0qS" (String#4647, DoABC#2)
// InventorySubCategory = "_-1nz" (String#18460, DoABC#2)
// PetsModel = "_-1sv" (String#5899, DoABC#2)
// FurniModelCategory = "_-1a8" (String#5563, DoABC#2)
// FurniModel = "_-1ur" (String#5936, DoABC#2)
// RecyclerModel = "_-25-" (String#6140, DoABC#2)
// MarketplaceModel = "_-2M1" (String#6484, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// FurniData = "_-2AO" (String#19422, DoABC#2)
// UnseenItemCategoryEnum = "_-0Ua" (String#15227, DoABC#2)
// RequestFurniInventoryComposer = "_-17" (String#16734, DoABC#2)
// WallItem = "_-2ZP" (String#20413, DoABC#2)
// FloorItem = "_-2DW" (String#19547, DoABC#2)
// ResetUnseenItemsComposer = "_-pv" (String#24269, DoABC#2)
// FurniView = "_-1Jo" (String#5239, DoABC#2)
// itemType = "_-De" (String#22756, DoABC#2)
// classId = "_-1mV" (String#18401, DoABC#2)
// _controller = "_-18D" (String#59, DoABC#2)
// getItem = "_-0un" (String#16229, DoABC#2)
// extra = "_-2We" (String#6693, DoABC#2)
// expiryTime = "_-1FG" (String#17083, DoABC#2)
// stuffData = "_-0vz" (String#1580, DoABC#2)
// groupable = "_-1YM" (String#5527, DoABC#2)
// IHabboSoundManager = "_-0vD" (String#4750, DoABC#2)
// _SafeStr_4329 = "_-bN" (String#23687, DoABC#2)
// _SafeStr_4330 = "_-0cQ" (String#15531, DoABC#2)
// getHabboMainConnection = "_-0AQ" (String#809, DoABC#2)
// getWindowContainer = "_-v8" (String#313, DoABC#2)
// _furniData = "_-13M" (String#1612, DoABC#2)
// REOB_OBJECT_PLACED = "_-2hu" (String#20768, DoABC#2)
// showRecyclable = "_-38g" (String#21829, DoABC#2)
// removeLockFrom = "_-2FC" (String#19612, DoABC#2)
// requestSelectedFurniToRecycler = "_-2P" (String#6543, DoABC#2)
// getOwnItemsInRecycler = "_-cW" (String#23733, DoABC#2)
// closingInventoryView = "_-0Lx" (String#4000, DoABC#2)
// requestInitialization = "_-2eX" (String#6842, DoABC#2)
// categorySwitch = "_-3Ad" (String#7526, DoABC#2)
// subCategorySwitch = "_-1Gu" (String#5187, DoABC#2)
// toggleInventoryPage = "_-1MK" (String#5280, DoABC#2)
// _SafeStr_5995 = "_-2qT" (String#21102, DoABC#2)
// _SafeStr_5996 = "_-Jg" (String#22993, DoABC#2)
// disposesBitmap = "_-03U" (String#3637, DoABC#2)
// stripId = "_-28E" (String#19340, DoABC#2)
// removeItem = "_-2gu" (String#6888, DoABC#2)
// songId = "_-2fw" (String#20688, DoABC#2)
// _SafeStr_6767 = "for" (String#45121, DoABC#2)
// _SafeStr_6768 = "_-QD" (String#23258, DoABC#2)
// roomSession = "_-0cq" (String#4363, DoABC#2)
// updateView = "_-1Js" (String#847, DoABC#2)
// _SafeStr_7051 = "_-AU" (String#22635, DoABC#2)
// _SafeStr_7052 = "_-0OP" (String#15005, DoABC#2)
// _SafeStr_7053 = "_-19z" (String#16856, DoABC#2)
// _SafeStr_7054 = "_-1LD" (String#17322, DoABC#2)
// _SafeStr_7055 = "_-0z3" (String#16396, DoABC#2)
// _SafeStr_7062 = "_-1SW" (String#17601, DoABC#2)
//  = "_-PL" (String#8192, DoABC#2)
// _SafeStr_7064 = "_-08P" (String#14380, DoABC#2)
// S = "_-Ch" (String#22713, DoABC#2)
// I = "_-3-D" (String#21470, DoABC#2)
// _SafeStr_7068 = "_-0Wb" (String#15301, DoABC#2)
// isPrivateRoom = "_-1Wr" (String#5489, DoABC#2)
// _SafeStr_7791 = "_-2nd" (String#20984, DoABC#2)
// _SafeStr_7792 = "_-1MN" (String#17374, DoABC#2)
// _SafeStr_7793 = "_-2BC" (String#19452, DoABC#2)
// _SafeStr_7794 = "_-aa" (String#8430, DoABC#2)
// _SafeStr_7795 = "_-0vw" (String#16271, DoABC#2)
// _SafeStr_7796 = "_-28s" (String#19364, DoABC#2)
// _SafeStr_7797 = "_-Gh" (String#8012, DoABC#2)
// _SafeStr_7798 = "_-Tl" (String#23397, DoABC#2)
// _SafeStr_7799 = "_-2eC" (String#6837, DoABC#2)
// _SafeStr_7800 = "_-0oa" (String#15998, DoABC#2)
// _SafeStr_7801 = "_-2C2" (String#19484, DoABC#2)
// _SafeStr_7802 = "_-21G" (String#19063, DoABC#2)
// _SafeStr_7803 = "_-lw" (String#24107, DoABC#2)
// onObjectPlaced = "_-CM" (String#7922, DoABC#2)
// onImageUpdateTimerEvent = "_-2nx" (String#20997, DoABC#2)
// petsModel = "_-227" (String#19096, DoABC#2)
// initTimeout = "_-1qA" (String#18551, DoABC#2)
// insertFurniList = "_-2RU" (String#20098, DoABC#2)
// setInventoryCategoryInit = "_-0py" (String#16050, DoABC#2)
// getAllStripIds = "_-1a9" (String#17900, DoABC#2)
// setGridLock = "_-2Jr" (String#19803, DoABC#2)
// objId = "_-1VD" (String#17710, DoABC#2)
// isGroupable = "_-19p" (String#16849, DoABC#2)
// isTradeable = "_-2td" (String#21226, DoABC#2)
// isRecyclable = "_-1jA" (String#18251, DoABC#2)
// isSellable = "_-0aB" (String#4305, DoABC#2)
// addFurniAsLast = "_-0fn" (String#15663, DoABC#2)
// addFurniAt = "_-1cy" (String#18011, DoABC#2)
// removeFurni = "_-1-n" (String#16459, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// updateItemLocks = "_-Ts" (String#23402, DoABC#2)
// getSelectedItemIndex = "_-tL" (String#24421, DoABC#2)
// toggleItemSelection = "_-Qk" (String#23275, DoABC#2)
// initListImages = "_-2Qh" (String#20073, DoABC#2)
// setListInitialized = "_-Mb" (String#23108, DoABC#2)
// isListInited = "_-cQ" (String#23731, DoABC#2)
// setViewToState = "_-0gw" (String#15707, DoABC#2)
// createNewGroupItemTemplate = "_-0Bl" (String#14518, DoABC#2)
// recyclerModel = "_-26u" (String#19288, DoABC#2)
// getCategoryContent = "_-1lE" (String#18339, DoABC#2)
// isImageInited = "_-03j" (String#14191, DoABC#2)
// initImage = "_-2Hp" (String#19719, DoABC#2)
// isImageFinished = "_-0rt" (String#16118, DoABC#2)
// requestNewList = "_-1vn" (String#18790, DoABC#2)
// isVisible = "_-1rE" (String#18592, DoABC#2)
// visibleCategoryId = "_-2iM" (String#20782, DoABC#2)
// furniCategorySwitch = "_-3W" (String#22356, DoABC#2)
// automaticSwitchToPetCategory = "_-2NP" (String#19940, DoABC#2)
// checkCategoryInitilization = "_-vi" (String#24517, DoABC#2)
// resetUnseenItems = "_-0qm" (String#16077, DoABC#2)
// tradingModel = "_-1s3" (String#18635, DoABC#2)
// getOwnItemIdsInTrade = "_-0QS" (String#15079, DoABC#2)
// removeAllLocks = "_-O5" (String#23172, DoABC#2)
// addLocksFromData = "_-2gP" (String#20704, DoABC#2)
// updateActionView = "_-jg" (String#8593, DoABC#2)
// addLockTo = "_-oD" (String#24199, DoABC#2)
// clearViews = "_-Uc" (String#23431, DoABC#2)
// ref = "_-Jx" (String#8081, DoABC#2)
// addItemAt = "_-SJ" (String#23337, DoABC#2)
// addItemToBottom = "_-3AS" (String#21898, DoABC#2)
// moveGroupItemTo = "_-1kb" (String#18312, DoABC#2)
// furniIsMostLikelyPetFood = "_-1jV" (String#18266, DoABC#2)
// switchToFurnitureCategory = "_-1uc" (String#18741, DoABC#2)
// cancelFurniInMover = "_-1Xa" (String#17797, DoABC#2)
// requestSelectedFurniPlacement = "_-17E" (String#16744, DoABC#2)
// showView = "_-1gE" (String#860, DoABC#2)
// getTotalCount = "_-1uB" (String#18723, DoABC#2)
// updatePostItCount = "_-274" (String#19294, DoABC#2)
// replaceItem = "_-1qs" (String#18574, DoABC#2)
// displayItemInfo = "_-264" (String#19261, DoABC#2)
// getGroupItemInIndex = "_-0lk" (String#15888, DoABC#2)
// getGroupItemByType = "_-1q1" (String#18543, DoABC#2)
// isTradingOpen = "_-0Yq" (String#15394, DoABC#2)
// getSubCategoryViewId = "_-p7" (String#24238, DoABC#2)
// canUserOfferToTrade = "_-1Ic" (String#17218, DoABC#2)
// cancelRoomObjectInsert = "_-0w6" (String#4772, DoABC#2)
// getUnlockedCount = "_-2rq" (String#21148, DoABC#2)
// _SafeStr_7867 = "catch" (String#25155, DoABC#2)
// requestSelectedFurniToMover = "_-0zp" (String#16419, DoABC#2)
// initializeRoomObjectInsert = "_-QC" (String#8205, DoABC#2)
// requestClose = "_-32T" (String#21595, DoABC#2)
// requestSelectedFurniToTrading = "_-1mj" (String#18410, DoABC#2)
// getOneForTrade = "_-1OC" (String#17442, DoABC#2)
// requestAddItemToTrading = "_-0jr" (String#15822, DoABC#2)
// requestSelectedFurniSelling = "_-1hq" (String#18205, DoABC#2)
// marketplaceModel = "_-051" (String#14244, DoABC#2)
// startOfferMaking = "_-0bY" (String#15497, DoABC#2)
// getOneForRecycle = "_-2GC" (String#19650, DoABC#2)
// requestCurrentActionOnSelection = "_-14j" (String#16642, DoABC#2)
// closeView = "_-0fQ" (String#15648, DoABC#2)
// requestCatalogOpen = "_-0sM" (String#16138, DoABC#2)
// openCatalog = "_-RM" (String#8233, DoABC#2)
// getAt = "_-0yu" (String#16388, DoABC#2)
// updateGroupItems = "_-2DQ" (String#19544, DoABC#2)
// updateCategoryButtons = "_-2i3" (String#20774, DoABC#2)
// getFurniIds = "_-2Rv" (String#20115, DoABC#2)
// hasUnseenItems = "_-t0" (String#24406, DoABC#2)
// moveItemTo = "_-3JU" (String#22263, DoABC#2)
// isMainViewActive = "_-jz" (String#24031, DoABC#2)
// addUnseenFloorItems = "_-2XU" (String#20341, DoABC#2)
// addUnseenWallItems = "_-2YX" (String#20379, DoABC#2)
// getUnseenItemCount = "_-133" (String#16582, DoABC#2)
// updateUnseenItemCounts = "_-ik" (String#23988, DoABC#2)
// RoomObjectCategoryEnum = "_-1eh" (String#5639, DoABC#2)
// HabboInventoryTrackingEvent = "_-1r0" (String#18582, DoABC#2)


