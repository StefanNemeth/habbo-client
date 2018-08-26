
package com.sulake.habbo.inventory.trading
{
    import com.sulake.habbo.inventory.IInventoryModel;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.inventory.HabboInventory;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.inventory.enum.InventoryCategory;
    import flash.events.Event;
    import com.sulake.habbo.inventory.events.HabboInventoryTrackingEvent;
    import com.sulake.habbo.inventory.enum.InventorySubCategory;
    import com.sulake.habbo.inventory.furni.FurniModel;
    import com.sulake.habbo.inventory.items.GroupItem;
    import com.sulake.habbo.inventory.items.IItem;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.habbo.inventory.items.FloorItem;
    import com.sulake.room.utils.Vector3d;
    import flash.display.BitmapData;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingCloseEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingAlreadyOpenEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingAcceptEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingConfirmationEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingCompletedEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingNotOpenEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingOtherNotAllowedEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingYouAreNotAllowedEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.OpenTradingComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.AddItemToTradeComposer;
    import com.sulake.habbo.inventory.enum.FurniCategory;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.RemoveItemFromTradeComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.AcceptTradingComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.UnacceptTradingComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.ConfirmAcceptTradingComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.ConfirmDeclineTradingComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.CloseTradingComposer;

    public class TradingModel implements IInventoryModel, IGetImageListener 
    {

        public static const _SafeStr_11523:uint = 9;
        public static const _SafeStr_11524:uint = 0;
        public static const _SafeStr_11525:uint = 1;
        public static const _SafeStr_11526:uint = 2;
        public static const _SafeStr_11527:uint = 3;
        public static const _SafeStr_11528:uint = 4;
        public static const _SafeStr_11529:uint = 5;
        public static const TRADING_STATE_CANCELLED:uint = 6;

        private var _inventory:HabboInventory;
        private var _assetLibrary:IAssetLibrary;
        private var _roomEngine:IRoomEngine;
        private var _communication:IHabboCommunicationManager;
        private var _localization:IHabboLocalizationManager;
        private var _soundManager:IHabboSoundManager;
        private var _SafeStr_11530:TradingView;
        private var _disposed:Boolean = false;
        private var _running:Boolean = false;
        private var _state:uint = 0;
        private var _ownUserId:int = -1;
        private var _ownUserName:String = "";
        private var _ownUserItems:Map;
        private var _ownUserAccepts:Boolean = false;
        private var _ownUserCanTrade:Boolean = false;
        private var _otherUserId:int = -1;
        private var _otherUserName:String = "";
        private var _otherUserItems:Map;
        private var _otherUserAccepts:Boolean = false;
        private var _otherUserCanTrade:Boolean = false;

        public function TradingModel(_arg_1:HabboInventory, _arg_2:IHabboWindowManager, _arg_3:IHabboCommunicationManager, _arg_4:IAssetLibrary, _arg_5:IRoomEngine, _arg_6:IHabboLocalizationManager, _arg_7:IHabboSoundManager)
        {
            this._inventory = _arg_1;
            this._communication = _arg_3;
            this._assetLibrary = _arg_4;
            this._roomEngine = _arg_5;
            this._localization = _arg_6;
            this._soundManager = _arg_7;
            this._SafeStr_11530 = new TradingView(this, _arg_2, _arg_4, _arg_5, _arg_6, _arg_7);
        }
        public function get running():Boolean
        {
            return (!((this._state == _SafeStr_11524)));
        }
        public function get state():uint
        {
            return (this._state);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get ownUserId():int
        {
            return (this._ownUserId);
        }
        public function get ownUserName():String
        {
            return (this._ownUserName);
        }
        public function get ownUserItems():Map
        {
            return (this._ownUserItems);
        }
        public function get ownUserAccepts():Boolean
        {
            return (this._ownUserAccepts);
        }
        public function get ownUserCanTrade():Boolean
        {
            return (this._ownUserCanTrade);
        }
        public function get otherUserId():int
        {
            return (this._otherUserId);
        }
        public function get otherUserName():String
        {
            return (this._otherUserName);
        }
        public function get otherUserItems():Map
        {
            return (this._otherUserItems);
        }
        public function get otherUserAccepts():Boolean
        {
            return (this._otherUserAccepts);
        }
        public function get otherUserCanTrade():Boolean
        {
            return (this._otherUserCanTrade);
        }
        public function dispose():void
        {
            if (!this._disposed){
                if (((this._SafeStr_11530) && (!(this._SafeStr_11530.disposed)))){
                    this._SafeStr_11530.dispose();
                    this._SafeStr_11530 = null;
                };
                this._inventory = null;
                this._communication = null;
                this._assetLibrary = null;
                this._roomEngine = null;
                this._localization = null;
                this._disposed = true;
            };
        }
        public function startTrading(_arg_1:int, _arg_2:String, _arg_3:Boolean, _arg_4:int, _arg_5:String, _arg_6:Boolean):void
        {
            this._ownUserId = _arg_1;
            this._ownUserName = _arg_2;
            this._ownUserItems = new Map();
            this._ownUserAccepts = false;
            this._ownUserCanTrade = _arg_3;
            this._otherUserId = _arg_4;
            this._otherUserName = _arg_5;
            this._otherUserItems = new Map();
            this._otherUserAccepts = false;
            this._otherUserCanTrade = _arg_6;
            this._running = true;
            this.state = _SafeStr_11525;
            this._SafeStr_11530.setup(_arg_1, _arg_3, _arg_4, _arg_6);
            this._SafeStr_11530.updateItemList(this._ownUserId);
            this._SafeStr_11530.updateItemList(this._otherUserId);
            this._SafeStr_11530.updateUserInterface();
            this._SafeStr_11530.clearItemLists();
            this._inventory.HabboInventory(InventoryCategory._SafeStr_5995);
            this._inventory.events.dispatchEvent(new Event(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_TRADING));
        }
        public function close():void
        {
            if (this._running){
                if (((!((this._state == _SafeStr_11524))) && (!((this._state == _SafeStr_11529))))){
                    this.TradingModel();
                    this.state = TradingModel.TRADING_STATE_CANCELLED;
                };
                this.state = _SafeStr_11524;
                this._inventory.HabboInventory(InventorySubCategory.);
                this._running = false;
            };
            this._SafeStr_11530.setMinimized(false);
        }
        public function categorySwitch(_arg_1:String):void
        {
            this._SafeStr_11530.setMinimized(!((_arg_1 == InventoryCategory._SafeStr_5995)));
            this._inventory.HabboInventory();
        }
        public function set state(_arg_1:uint):void
        {
            Logger.log(((((((("OLD STATE: " + this._state) + " NEW STATE: ") + _arg_1) + " OWN: ") + this._ownUserAccepts) + " OTHER: ") + this._otherUserAccepts));
            var _local_2:Boolean;
            if (this._state == _arg_1){
                return;
            };
            switch (this._state){
                case _SafeStr_11524:
                    if ((((_arg_1 == _SafeStr_11525)) || ((_arg_1 == _SafeStr_11529)))){
                        this._state = _arg_1;
                        _local_2 = true;
                    };
                    break;
                case _SafeStr_11525:
                    if (_arg_1 == _SafeStr_11526){
                        this._state = _arg_1;
                        _local_2 = true;
                        this.TradingModel();
                    }
                    else {
                        if (_arg_1 == TRADING_STATE_CANCELLED){
                            this._state = _arg_1;
                            this._SafeStr_11530.setMinimized(false);
                            _local_2 = true;
                        };
                    };
                    break;
                case _SafeStr_11526:
                    if (_arg_1 == _SafeStr_11527){
                        this._state = _arg_1;
                        _local_2 = true;
                    }
                    else {
                        if (_arg_1 == TRADING_STATE_CANCELLED){
                            this._state = _arg_1;
                            this._SafeStr_11530.setMinimized(false);
                            _local_2 = true;
                        }
                        else {
                            if (_arg_1 == _SafeStr_11525){
                                this._state = _arg_1;
                                _local_2 = true;
                                this.TradingModel();
                            };
                        };
                    };
                    break;
                case _SafeStr_11527:
                    if (_arg_1 == _SafeStr_11528){
                        this._state = _arg_1;
                        _local_2 = true;
                    }
                    else {
                        if (_arg_1 == _SafeStr_11529){
                            this._state = _arg_1;
                            _local_2 = true;
                            this.close();
                        }
                        else {
                            if (_arg_1 == TRADING_STATE_CANCELLED){
                                this._state = _arg_1;
                                this._SafeStr_11530.setMinimized(false);
                                _local_2 = true;
                                this.close();
                            };
                        };
                    };
                    break;
                case _SafeStr_11528:
                    if (_arg_1 == _SafeStr_11529){
                        this._state = _arg_1;
                        this._SafeStr_11530.setMinimized(false);
                        _local_2 = true;
                        this.close();
                    }
                    else {
                        if (_arg_1 == TRADING_STATE_CANCELLED){
                            this._state = _arg_1;
                            this._SafeStr_11530.setMinimized(false);
                            _local_2 = true;
                            this.close();
                        };
                    };
                    break;
                case _SafeStr_11529:
                    if (_arg_1 == _SafeStr_11524){
                        this._state = _arg_1;
                        _local_2 = true;
                    };
                    break;
                case TRADING_STATE_CANCELLED:
                    if (_arg_1 == _SafeStr_11524){
                        this._state = _arg_1;
                        _local_2 = true;
                    }
                    else {
                        if (_arg_1 == _SafeStr_11525){
                            this._state = _arg_1;
                            _local_2 = true;
                        };
                    };
                    break;
                default:
                    throw (new Error((('Unknown trading progress state: "' + this._state) + '"')));
            };
            if (_local_2){
                this._SafeStr_11530.updateUserInterface();
            }
            else {
                throw (new Error("Error assigning trading process status!"));
            };
        }
        public function TradingModel():FurniModel
        {
            return (this._inventory.furniModel);
        }
        public function TradingModel(_arg_1:int, _arg_2:Map, _arg_3:int, _arg_4:Map):void
        {
            if (this._inventory == null){
                return;
            };
            if (this._ownUserItems != null){
                this._ownUserItems.dispose();
            };
            if (this._otherUserItems != null){
                this._otherUserItems.dispose();
            };
            if (_arg_1 == this._ownUserId){
                this._ownUserItems = _arg_2;
                this._otherUserItems = _arg_4;
            }
            else {
                this._ownUserItems = _arg_4;
                this._otherUserItems = _arg_2;
            };
            this._ownUserAccepts = false;
            this._otherUserAccepts = false;
            this._SafeStr_11530.updateItemList(this._ownUserId);
            this._SafeStr_11530.updateItemList(this._otherUserId);
            this._SafeStr_11530.updateUserInterface();
            var _local_5:FurniModel = this._inventory.furniModel;
            if (_local_5 != null){
                _local_5.updateItemLocks();
            };
        }
        public function TradingModel():Array
        {
            var _local_2:GroupItem;
            var _local_3:IItem;
            var _local_5:int;
            var _local_1:Array = new Array();
            if ((((this._ownUserItems == null)) || (this._ownUserItems.disposed))){
                return (_local_1);
            };
            var _local_4:int;
            while (_local_4 < this._ownUserItems.length) {
                _local_2 = (this._ownUserItems.getWithIndex(_local_4) as GroupItem);
                if (_local_2 != null){
                    _local_5 = 0;
                    while (_local_5 < _local_2.GroupItem()) {
                        _local_3 = _local_2.GroupItem(_local_5);
                        if (_local_3 != null){
                            _local_1.push(_local_3.ref);
                        };
                        _local_5++;
                    };
                };
                _local_4++;
            };
            return (_local_1);
        }
        public function TradingModel():IWindowContainer
        {
            return (this._SafeStr_11530.TradingModel());
        }
        public function TradingModel(_arg_1:int=0):void
        {
        }
        public function TradingModel(_arg_1:String):void
        {
            if (this._running){
                if (this._state != _SafeStr_11524){
                    this.TradingModel();
                };
            };
        }
        public function TradingModel():void
        {
            if (this._running){
                this.close();
            };
        }
        public function TradingModel():void
        {
            this._SafeStr_11530.TradingModel();
        }
        public function TradingModel():void
        {
            this._SafeStr_11530.TradingModel();
        }
        public function TradingModel():void
        {
            if (this._state == _SafeStr_11526){
                this.state = _SafeStr_11527;
            };
        }
        public function TradingModel(_arg_1:IItem):BitmapData
        {
            var _local_2:ImageResult;
            if ((_arg_1 is FloorItem)){
                _local_2 = this._roomEngine.getFurnitureImage(_arg_1.type, new Vector3d(180, 0, 0), 64, this, 0, String(_arg_1.extra));
            }
            else {
                _local_2 = this._roomEngine.getWallItemImage(_arg_1.type, new Vector3d(180, 0, 0), 64, this, 0, _arg_1.stuffData);
            };
            return ((_local_2.data as BitmapData));
        }
        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            this._SafeStr_11530.updateItemImage(_arg_1, _arg_2);
        }
        public function TradingModel(_arg_1:IMessageEvent):void
        {
            var _local_2:TradingCloseEvent;
            if ((_arg_1 is TradingAlreadyOpenEvent)){
                Logger.log("TRADING::TradingAlreadyOpenEvent");
                this._SafeStr_11530.alertPopup(TradingView._SafeStr_11563);
            }
            else {
                if ((_arg_1 is TradingAcceptEvent)){
                    Logger.log("TRADING::TradingAcceptEvent");
                    if (TradingAcceptEvent(_arg_1).userID == this._ownUserId){
                        this._ownUserAccepts = !((TradingAcceptEvent(_arg_1).userAccepts == 0));
                    }
                    else {
                        this._otherUserAccepts = !((TradingAcceptEvent(_arg_1).userAccepts == 0));
                    };
                    this._SafeStr_11530.updateUserInterface();
                }
                else {
                    if ((_arg_1 is TradingConfirmationEvent)){
                        Logger.log("TRADING::TradingConfirmationEvent");
                        this.state = _SafeStr_11526;
                    }
                    else {
                        if ((_arg_1 is TradingCompletedEvent)){
                            Logger.log("TRADING::TradingCompletedEvent");
                            this.state = _SafeStr_11529;
                        }
                        else {
                            if ((_arg_1 is TradingCloseEvent)){
                                Logger.log("TRADING::TradingCloseEvent");
                                if (!this._running){
                                    Logger.log("Received TradingCloseEvent, but trading already stopped!!!");
                                    return;
                                };
                                _local_2 = (_arg_1 as TradingCloseEvent);
                                if (_local_2.userID != this._ownUserId){
                                    this._SafeStr_11530.alertPopup(TradingView._SafeStr_11564);
                                };
                                this.close();
                            }
                            else {
                                if ((_arg_1 is TradingNotOpenEvent)){
                                    Logger.log("TRADING::TradingNotOpenEvent");
                                }
                                else {
                                    if ((_arg_1 is TradingOtherNotAllowedEvent)){
                                        this._SafeStr_11530.showOtherUserNotification("${inventory.trading.warning.others_account_disabled}");
                                    }
                                    else {
                                        if ((_arg_1 is TradingYouAreNotAllowedEvent)){
                                            this._SafeStr_11530.showOwnUserNotification("${inventory.trading.warning.own_account_disabled}");
                                        }
                                        else {
                                            Logger.log(("TRADING/Unknown message event: " + _arg_1));
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
        }
        public function TradingModel():void
        {
            this._inventory.HabboInventory(InventoryCategory._SafeStr_5995);
        }
        public function TradingModel(_arg_1:int):void
        {
            this._communication.HabboCommunicationManager(null).send(new OpenTradingComposer(_arg_1));
        }
        public function TradingModel(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Boolean, _arg_5:String=""):Boolean
        {
            var _local_6:String;
            if (this._ownUserAccepts){
                return (false);
            };
            if (this._ownUserItems == null){
                return (false);
            };
            if (this._ownUserItems.length < _SafeStr_11523){
                this._communication.HabboCommunicationManager(null).send(new AddItemToTradeComposer(_arg_1));
            }
            else {
                if (!_arg_4){
                    return (false);
                };
                _local_6 = String(_arg_2);
                if (_arg_3 == FurniCategory._SafeStr_7055){
                    _local_6 = ((String(_arg_2) + "poster") + _arg_5);
                };
                if (this._ownUserItems.getValue(_local_6) != null){
                    this._communication.HabboCommunicationManager(null).send(new AddItemToTradeComposer(_arg_1));
                }
                else {
                    return (false);
                };
            };
            return (true);
        }
        public function TradingModel(_arg_1:int):void
        {
            var _local_3:IItem;
            if (this._ownUserAccepts){
                return;
            };
            var _local_2:GroupItem = this.ownUserItems.getWithIndex(_arg_1);
            if (_local_2){
                _local_3 = _local_2._SafeStr_7867();
                if (_local_3){
                    this._communication.HabboCommunicationManager(null).send(new RemoveItemFromTradeComposer(_local_3.id));
                };
            };
        }
        public function TradingModel():void
        {
            this._communication.HabboCommunicationManager(null).send(new AcceptTradingComposer());
        }
        public function TradingModel():void
        {
            this._communication.HabboCommunicationManager(null).send(new UnacceptTradingComposer());
        }
        public function TradingModel():void
        {
            this.state = _SafeStr_11528;
            this._communication.HabboCommunicationManager(null).send(new ConfirmAcceptTradingComposer());
        }
        public function TradingModel():void
        {
            this._communication.HabboCommunicationManager(null).send(new ConfirmDeclineTradingComposer());
        }
        public function TradingModel():void
        {
            this._communication.HabboCommunicationManager(null).send(new CloseTradingComposer());
        }

    }
}//package com.sulake.habbo.inventory.trading

// ownUserName = "_-19l" (String#16846, DoABC#2)
// _ownUserName = "_-1nP" (String#5807, DoABC#2)
// _SafeStr_11523 = "_-1Lg" (String#17343, DoABC#2)
// _SafeStr_11524 = "_-19b" (String#16841, DoABC#2)
// _SafeStr_11525 = "_-3I5" (String#22205, DoABC#2)
// _SafeStr_11526 = "_-0Sg" (String#15159, DoABC#2)
// _SafeStr_11527 = "_-28a" (String#19354, DoABC#2)
// _SafeStr_11528 = "_-1LO" (String#17329, DoABC#2)
// _SafeStr_11529 = "_-1Pl" (String#17498, DoABC#2)
// _SafeStr_11530 = "_-1w0" (String#18799, DoABC#2)
// _ownUserId = "_-1ah" (String#17922, DoABC#2)
// _ownUserItems = "_-0xL" (String#16325, DoABC#2)
// _ownUserAccepts = "_-1tx" (String#18714, DoABC#2)
// _ownUserCanTrade = "_-2ZG" (String#20408, DoABC#2)
// _otherUserId = "_-1g7" (String#18145, DoABC#2)
// _otherUserName = "_-3Fp" (String#22109, DoABC#2)
// _otherUserItems = "_-1aJ" (String#17908, DoABC#2)
// _otherUserAccepts = "_-3DE" (String#22004, DoABC#2)
// ownUserId = "_-2n4" (String#20964, DoABC#2)
// ownUserItems = "_-1bV" (String#17955, DoABC#2)
// ownUserAccepts = "_-2Yh" (String#20383, DoABC#2)
// ownUserCanTrade = "_-0My" (String#14953, DoABC#2)
// otherUserId = "_-0uV" (String#16221, DoABC#2)
// otherUserName = "_-rw" (String#24359, DoABC#2)
// otherUserItems = "_-lh" (String#24098, DoABC#2)
// otherUserAccepts = "_-0oG" (String#15987, DoABC#2)
// startTrading = "_-0Ci" (String#14557, DoABC#2)
// updateItemList = "_-23a" (String#19158, DoABC#2)
// updateUserInterface = "_-2BP" (String#19460, DoABC#2)
// clearItemLists = "_-2kF" (String#20855, DoABC#2)
// TradingModel = "_-2Xf" (String#20346, DoABC#2)
// HabboInventory = "_-NR" (String#8153, DoABC#2)
// HabboInventory = "_-Ec" (String#22798, DoABC#2)
// TradingModel = "_-2o5" (String#21005, DoABC#2)
// TradingModel = "_-2AB" (String#19410, DoABC#2)
// TradingModel = "_-04E" (String#14212, DoABC#2)
// TradingModel = "_-1JS" (String#17254, DoABC#2)
// TradingModel = "_-1Ci" (String#16972, DoABC#2)
// TradingModel = "_-1gL" (String#18152, DoABC#2)
// updateItemImage = "_-28e" (String#19357, DoABC#2)
// TradingModel = "_-0mn" (String#15930, DoABC#2)
// alertPopup = "_-1E3" (String#17030, DoABC#2)
// _SafeStr_11563 = "_-34s" (String#21691, DoABC#2)
// _SafeStr_11564 = "_-2Os" (String#19997, DoABC#2)
// showOtherUserNotification = "_-22" (String#19088, DoABC#2)
// showOwnUserNotification = "_-0j0" (String#15791, DoABC#2)
// TradingModel = "_-0VJ" (String#15256, DoABC#2)
// TradingModel = "_-05P" (String#14260, DoABC#2)
// TradingModel = "_-2GH" (String#19653, DoABC#2)
// TradingModel = "_-1b8" (String#17941, DoABC#2)
// TradingModel = "_-225" (String#19095, DoABC#2)
// TradingModel = "_-301" (String#21503, DoABC#2)
// TradingModel = "_-25W" (String#19239, DoABC#2)
// ImageResult = "_-31w" (String#21576, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// FurniCategory = "_-0lm" (String#15890, DoABC#2)
// InventoryCategory = "_-04Y" (String#14224, DoABC#2)
// IItem = "_-1-k" (String#4863, DoABC#2)
// IInventoryModel = "_-Fh" (String#7987, DoABC#2)
// TradingModel = "_-1PM" (String#5341, DoABC#2)
// GroupItem = "_-0qS" (String#4647, DoABC#2)
// InventorySubCategory = "_-1nz" (String#18460, DoABC#2)
// FurniModel = "_-1ur" (String#5936, DoABC#2)
// TradingConfirmationEvent = "_-j2" (String#8578, DoABC#2)
// TradingNotOpenEvent = "_-2Du" (String#6318, DoABC#2)
// TradingAlreadyOpenEvent = "_-QK" (String#8207, DoABC#2)
// TradingCompletedEvent = "_-2gA" (String#6872, DoABC#2)
// IGetImageListener = "_-2i7" (String#6909, DoABC#2)
// TradingOtherNotAllowedEvent = "_-PA" (String#8187, DoABC#2)
// TradingYouAreNotAllowedEvent = "_-2vg" (String#7191, DoABC#2)
// TradingCloseEvent = "_-WD" (String#8328, DoABC#2)
// TradingAcceptEvent = "_-38I" (String#7478, DoABC#2)
// FloorItem = "_-2DW" (String#19547, DoABC#2)
// TradingView = "_-0VY" (String#4218, DoABC#2)
// RemoveItemFromTradeComposer = "_-0rS" (String#16102, DoABC#2)
// ConfirmDeclineTradingComposer = "_-3HS" (String#22177, DoABC#2)
// ConfirmAcceptTradingComposer = "_-1k9" (String#18294, DoABC#2)
// OpenTradingComposer = "_-26G" (String#19263, DoABC#2)
// CloseTradingComposer = "_-23i" (String#19164, DoABC#2)
// AddItemToTradeComposer = "_-1mn" (String#18412, DoABC#2)
// UnacceptTradingComposer = "_-fW" (String#23865, DoABC#2)
// AcceptTradingComposer = "_-2ZY" (String#20421, DoABC#2)
// extra = "_-2We" (String#6693, DoABC#2)
// stuffData = "_-0vz" (String#1580, DoABC#2)
// userID = "_-1hY" (String#18192, DoABC#2)
// otherUserCanTrade = "_-0wj" (String#16300, DoABC#2)
// userAccepts = "_-sY" (String#24380, DoABC#2)
// IHabboSoundManager = "_-0vD" (String#4750, DoABC#2)
// HabboCommunicationManager = "_-0AQ" (String#809, DoABC#2)
// TradingModel = "_-v8" (String#313, DoABC#2)
// _inventory = "_-1O" (String#113, DoABC#2)
// _running = "_-00c" (String#353, DoABC#2)
// furniModel = "_-Sp" (String#23358, DoABC#2)
// TradingModel = "_-0Lx" (String#4000, DoABC#2)
// TradingModel = "_-2eX" (String#6842, DoABC#2)
// categorySwitch = "_-3Ad" (String#7526, DoABC#2)
// TradingModel = "_-1Gu" (String#5187, DoABC#2)
// _otherUserCanTrade = "_-1As" (String#5089, DoABC#2)
// HabboInventory = "_-1MK" (String#5280, DoABC#2)
// _SafeStr_5995 = "_-2qT" (String#21102, DoABC#2)
// setMinimized = "_-2Cz" (String#6306, DoABC#2)
// _SafeStr_7055 = "_-0z3" (String#16396, DoABC#2)
//  = "_-PL" (String#8192, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// updateItemLocks = "_-Ts" (String#23402, DoABC#2)
// TradingModel = "_-0QS" (String#15079, DoABC#2)
// ref = "_-Jx" (String#8081, DoABC#2)
// GroupItem = "_-1uB" (String#18723, DoABC#2)
// _SafeStr_7867 = "catch" (String#25155, DoABC#2)
// TradingModel = "_-0jr" (String#15822, DoABC#2)
// GroupItem = "_-0yu" (String#16388, DoABC#2)
// HabboInventoryTrackingEvent = "_-1r0" (String#18582, DoABC#2)


