
package com.sulake.habbo.inventory.pets
{
    import com.sulake.habbo.inventory.IInventoryModel;
    import com.sulake.habbo.inventory.HabboInventory;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.inventory.furni.FurniModel;
    import com.sulake.habbo.room.events.RoomEngineObjectEvent;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.communication.messages.outgoing.inventory.pets.GetPetInventoryComposer;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetData;
    import com.sulake.habbo.inventory.enum.InventoryCategory;
    import flash.events.Event;
    import com.sulake.habbo.inventory.events.HabboInventoryTrackingEvent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import com.sulake.habbo.room.object.RoomObjectTypeEnum;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.PlacePetMessageComposer;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.communication.messages.outgoing.notifications.ResetUnseenItemsComposer;
    import com.sulake.habbo.communication.messages.outgoing.notifications.UnseenItemCategoryEnum;

    public class PetsModel implements IInventoryModel 
    {

        private var _controller:HabboInventory;
        private var _view:PetsView;
        private var _assets:IAssetLibrary;
        private var _communication:IHabboCommunicationManager;
        private var _roomEngine:IRoomEngine;
        private var _catalog:IHabboCatalog;
        private var _pets:Map;
        private var _SafeStr_8469:Boolean = false;
        private var _disposed:Boolean = false;
        private var _SafeStr_7799:Boolean;
        private var _SafeStr_8470:Array;
        private var _furniModel:FurniModel;

        public function PetsModel(_arg_1:HabboInventory, _arg_2:IHabboWindowManager, _arg_3:IHabboCommunicationManager, _arg_4:IAssetLibrary, _arg_5:IHabboLocalizationManager, _arg_6:IRoomEngine, _arg_7:IAvatarRenderManager, _arg_8:IHabboCatalog)
        {
            this._controller = _arg_1;
            this._assets = _arg_4;
            this._communication = _arg_3;
            this._roomEngine = _arg_6;
            this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOB_OBJECT_PLACED, this.onObjectPlaced);
            this._catalog = _arg_8;
            this._pets = new Map();
            this._SafeStr_8470 = [];
            this._view = new PetsView(this, _arg_2, _arg_4, _arg_5, _arg_6, _arg_7);
        }
        public function set furniModel(_arg_1:FurniModel):void
        {
            this._furniModel = _arg_1;
        }
        public function get furniModel():FurniModel
        {
            return (this._furniModel);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            if (!this._disposed){
                if (this._view){
                    this._view.dispose();
                    this._view = null;
                };
                if (this._roomEngine){
                    if (this._roomEngine.events){
                        this._roomEngine.events.removeEventListener(RoomEngineObjectEvent.REOB_OBJECT_PLACED, this.onObjectPlaced);
                    };
                    this._roomEngine = null;
                };
                if (this._pets){
                    this._pets.dispose();
                    this._pets = null;
                };
                this._controller = null;
                this._catalog = null;
                this._assets = null;
                this._communication = null;
                this._SafeStr_8470 = null;
                this._disposed = true;
            };
        }
        public function isListInitialized():Boolean
        {
            return (this._SafeStr_7799);
        }
        public function setListInitialized():void
        {
            this._SafeStr_7799 = true;
            this._view.updateState();
        }
        public function requestPetInventory():void
        {
            if (this._communication == null){
                return;
            };
            var _local_1:IConnection = this._communication.getHabboMainConnection(null);
            if (_local_1 == null){
                return;
            };
            _local_1.send(new GetPetInventoryComposer());
        }
        public function requestCatalogOpen():void
        {
            this._catalog.openCatalog();
        }
        public function get pets():Map
        {
            return (this._pets);
        }
        public function addPet(_arg_1:PetData):void
        {
            if (this._pets.add(_arg_1.id, _arg_1)){
                this._view.addPet(_arg_1);
            };
            this._view.updateState();
        }
        public function removePet(_arg_1:int):void
        {
            this._pets.remove(_arg_1);
            this._view.removePet(_arg_1);
            this._view.updateState();
        }
        public function requestInitialization(_arg_1:int=0):void
        {
            this.requestPetInventory();
        }
        public function categorySwitch(_arg_1:String):void
        {
            if ((((_arg_1 == InventoryCategory._SafeStr_5996)) && (this._controller.isVisible))){
                this._view.updateCategoryButtons();
                this._controller.events.dispatchEvent(new Event(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_PETS));
            };
        }
        public function switchToFurnitureCategory(_arg_1:String, _arg_2:Boolean=false):void
        {
            var _local_3:FurniModel = this._controller.furniModel;
            if (_local_3 != null){
                _local_3.switchCategory(_arg_1);
                this._controller.toggleInventoryPage(InventoryCategory._SafeStr_5995, _arg_2);
            };
            this.resetUnseenItems();
        }
        public function refreshViews():void
        {
            this._view.update();
        }
        public function getWindowContainer():IWindowContainer
        {
            return (this._view.getWindowContainer());
        }
        public function closingInventoryView():void
        {
            if (this._view.isVisible){
                this.resetUnseenItems();
            };
        }
        public function subCategorySwitch(_arg_1:String):void
        {
        }
        public function placePetToRoom(_arg_1:int, _arg_2:Boolean=false):void
        {
            var _local_3:PetData = this.getPetById(_arg_1);
            if (_local_3 == null){
                return;
            };
            if (this._controller.roomSession.isRoomOwner){
                this._SafeStr_8469 = this._roomEngine.initializeRoomObjectInsert(_local_3.id, RoomObjectCategoryEnum.OBJECT_CATEGORY_USER, RoomObjectTypeEnum._SafeStr_3747, _local_3.figureString);
                this._controller.closeView();
                return;
            };
            if (!this._controller.roomSession.arePetsAllowed){
                return;
            };
            if (!_arg_2){
                this._communication.getHabboMainConnection(null).send(new PlacePetMessageComposer(_local_3.id, 0, 0));
            };
        }
        public function updateView():void
        {
            if (this._view == null){
                return;
            };
            this._view.update();
        }
        private function getPetById(_arg_1:int):PetData
        {
            var _local_2:PetData;
            for each (_local_2 in this._pets) {
                if (_local_2.id == _arg_1){
                    return (_local_2);
                };
            };
            return (null);
        }
        public function onObjectPlaced(_arg_1:Event):void
        {
            if (_arg_1 == null){
                return;
            };
            if (((this._SafeStr_8469) && ((_arg_1.type == RoomEngineObjectEvent.REOB_OBJECT_PLACED)))){
                this._controller.showView();
                this._SafeStr_8469 = false;
            };
        }
        public function get roomSession():IRoomSession
        {
            return (this._controller.roomSession);
        }
        public function updatePetsAllowed():void
        {
            this._view.update();
        }
        public function addUnseenPets(_arg_1:Array):void
        {
            var _local_2:int;
            if (_arg_1 == null){
                return;
            };
            for each (_local_2 in _arg_1) {
                if (this._SafeStr_8470.indexOf(_local_2) == -1){
                    this._SafeStr_8470.push(_local_2);
                };
            };
            this._view.update();
        }
        public function resetUnseenItems():void
        {
            if (!this._controller.isMainViewActive){
                return;
            };
            var _local_1:IConnection = this._communication.getHabboMainConnection(null);
            if (((this._SafeStr_8470) && ((this._SafeStr_8470.length > 0)))){
                _local_1.send(new ResetUnseenItemsComposer(UnseenItemCategoryEnum._SafeStr_6769));
                this._SafeStr_8470 = [];
                this._view.update();
                this._controller.updateUnseenItemCounts();
            };
        }
        public function getUnseenItemCount():int
        {
            return (this._SafeStr_8470.length);
        }
        public function isUnseen(_arg_1:int):Boolean
        {
            return ((this._SafeStr_8470.indexOf(_arg_1) > -1));
        }

    }
}//package com.sulake.habbo.inventory.pets

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// PetData = "_-01G" (String#1387, DoABC#2)
// InventoryCategory = "_-04Y" (String#14224, DoABC#2)
// RoomEngineObjectEvent = "_-10r" (String#16492, DoABC#2)
// IInventoryModel = "_-Fh" (String#7987, DoABC#2)
// PetsModel = "_-1sv" (String#5899, DoABC#2)
// FurniModel = "_-1ur" (String#5936, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// UnseenItemCategoryEnum = "_-0Ua" (String#15227, DoABC#2)
// ResetUnseenItemsComposer = "_-pv" (String#24269, DoABC#2)
// RoomObjectTypeEnum = "_-2hK" (String#20744, DoABC#2)
// PlacePetMessageComposer = "_-1qF" (String#18553, DoABC#2)
// GetPetInventoryComposer = "_-jb" (String#24021, DoABC#2)
// PetsView = "_-N0" (String#8143, DoABC#2)
// figureString = "_-P1" (String#23207, DoABC#2)
// _controller = "_-18D" (String#59, DoABC#2)
// _SafeStr_3747 = "_-gF" (String#23903, DoABC#2)
// IAvatarRenderManager = "_-C9" (String#7915, DoABC#2)
// getHabboMainConnection = "_-0AQ" (String#809, DoABC#2)
// getWindowContainer = "_-v8" (String#313, DoABC#2)
// REOB_OBJECT_PLACED = "_-2hu" (String#20768, DoABC#2)
// furniModel = "_-Sp" (String#23358, DoABC#2)
// closingInventoryView = "_-0Lx" (String#4000, DoABC#2)
// requestInitialization = "_-2eX" (String#6842, DoABC#2)
// categorySwitch = "_-3Ad" (String#7526, DoABC#2)
// subCategorySwitch = "_-1Gu" (String#5187, DoABC#2)
// toggleInventoryPage = "_-1MK" (String#5280, DoABC#2)
// _SafeStr_5995 = "_-2qT" (String#21102, DoABC#2)
// _SafeStr_5996 = "_-Jg" (String#22993, DoABC#2)
// isRoomOwner = "_-ZP" (String#8405, DoABC#2)
// arePetsAllowed = "_-1f7" (String#5646, DoABC#2)
// _SafeStr_6769 = "_-1Y9" (String#17821, DoABC#2)
// roomSession = "_-0cq" (String#4363, DoABC#2)
// updateView = "_-1Js" (String#847, DoABC#2)
// _SafeStr_7799 = "_-2eC" (String#6837, DoABC#2)
// onObjectPlaced = "_-CM" (String#7922, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// setListInitialized = "_-Mb" (String#23108, DoABC#2)
// isVisible = "_-1rE" (String#18592, DoABC#2)
// resetUnseenItems = "_-0qm" (String#16077, DoABC#2)
// switchToFurnitureCategory = "_-1uc" (String#18741, DoABC#2)
// showView = "_-1gE" (String#860, DoABC#2)
// initializeRoomObjectInsert = "_-QC" (String#8205, DoABC#2)
// closeView = "_-0fQ" (String#15648, DoABC#2)
// requestCatalogOpen = "_-0sM" (String#16138, DoABC#2)
// openCatalog = "_-RM" (String#8233, DoABC#2)
// updateCategoryButtons = "_-2i3" (String#20774, DoABC#2)
// isMainViewActive = "_-jz" (String#24031, DoABC#2)
// getUnseenItemCount = "_-133" (String#16582, DoABC#2)
// updateUnseenItemCounts = "_-ik" (String#23988, DoABC#2)
// refreshViews = "_-tx" (String#24446, DoABC#2)
// RoomObjectCategoryEnum = "_-1eh" (String#5639, DoABC#2)
// _SafeStr_8469 = "_-2Ml" (String#19917, DoABC#2)
// HabboInventoryTrackingEvent = "_-1r0" (String#18582, DoABC#2)
// _SafeStr_8470 = "_-0iM" (String#15766, DoABC#2)
// isListInitialized = "_-2cf" (String#20551, DoABC#2)
// updateState = "_-3Be" (String#21947, DoABC#2)
// requestPetInventory = "_-1VZ" (String#17725, DoABC#2)
// addPet = "_-3DW" (String#22016, DoABC#2)
// removePet = "_-lb" (String#24093, DoABC#2)
// placePetToRoom = "_-2hx" (String#20770, DoABC#2)
// getPetById = "_-38l" (String#21832, DoABC#2)
// updatePetsAllowed = "_-2UB" (String#20206, DoABC#2)
// addUnseenPets = "_-2Rw" (String#20116, DoABC#2)
// isUnseen = "_-FH" (String#22825, DoABC#2)


