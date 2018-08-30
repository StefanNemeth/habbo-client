
package com.sulake.habbo.inventory.pets
{
    import com.sulake.habbo.inventory.IInventoryView;
    import com.sulake.habbo.avatar.IPetImageListener;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetData;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.inventory.enum.FurniModelCategory;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ISelectorWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.communication.messages.outgoing.notifications.UnseenItemCategoryEnum;

    public class PetsView implements IInventoryView, IPetImageListener, IGetImageListener 
    {

        private static const _SafeStr_7899:int = 4;

        private const _SafeStr_7893:int = 0;
        private const _SafeStr_7894:int = 1;
        private const _SafeStr_7895:int = 2;
        private const _SafeStr_7896:int = 3;

        private var _windowManager:IHabboWindowManager;
        private var _assetLibrary:IAssetLibrary;
        private var _view:IWindowContainer;
        private var _modelController:PetsModel;
        private var _disposed:Boolean = false;
        private var _grid:IItemGridWindow;
        private var _roomEngine:IRoomEngine;
        private var _avatarRenderer:IAvatarRenderManager;
        private var _SafeStr_8481:Map;
        private var _SafeStr_8482:PetsGridItem;
        private var _SafeStr_7903:int = 0;

        public function PetsView(_arg_1:PetsModel, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager, _arg_5:IRoomEngine, _arg_6:IAvatarRenderManager)
        {
            var _local_11:IButtonWindow;
            super();
            this._modelController = _arg_1;
            this._assetLibrary = _arg_3;
            this._windowManager = _arg_2;
            this._roomEngine = _arg_5;
            this._avatarRenderer = _arg_6;
            this._SafeStr_8481 = new Map();
            var _local_7:XmlAsset = (this._assetLibrary.getAssetByName("inventory_pets_view_xml") as XmlAsset);
            if ((((_local_7 == null)) || ((_local_7.content == null)))){
                return;
            };
            this._view = (this._windowManager.buildFromXML((_local_7.content as XML)) as IWindowContainer);
            if (this._view == null){
                return;
            };
            this._view.visible = false;
            this._view.procedure = this.windowEventHandler;
            this.addUnseenItemSymbols();
            this._grid = (this._view.findChildByName("grid") as IItemGridWindow);
            var _local_8:IBitmapWrapperWindow = (this._view.findChildByName("download_image") as IBitmapWrapperWindow);
            _local_8.bitmap = new BitmapData(_local_8.width, _local_8.height);
            var _local_9:BitmapData = (this._assetLibrary.getAssetByName("download_icon_png").content as BitmapData);
            _local_8.bitmap.copyPixels(_local_9, _local_9.rect, new Point(((_local_8.width - _local_9.width) / 2), ((_local_8.height - _local_9.height) / 2)), null, null, true);
            _local_8 = (this._view.findChildByName("image") as IBitmapWrapperWindow);
            _local_8.bitmap = new BitmapData(_local_8.width, _local_8.height);
            var _local_10:BitmapData = (this._assetLibrary.getAssetByName("inventory_empty_png").content as BitmapData);
            _local_8.bitmap.copyPixels(_local_10, _local_10.rect, new Point(((_local_8.width - _local_10.width) / 2), ((_local_8.height - _local_10.height) / 2)), null, null, true);
            _local_11 = (this._view.findChildByName("place_button") as IButtonWindow);
            if (_local_11 != null){
                _local_11.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.placeButtonClickHandler);
            };
            _local_11 = (this._view.findChildByName("open_catalog_btn") as IButtonWindow);
            if (_local_11 != null){
                _local_11.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.catalogButtonClickHandler);
            };
            this.selectPetsTab();
            this.updatePreview();
            this.updateState();
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            if (!this._disposed){
                this._windowManager = null;
                this._modelController = null;
                this._view = null;
                this._disposed = true;
            };
        }
        public function get isVisible():Boolean
        {
            return (((!((this._view.parent == null))) && (this._view.visible)));
        }
        public function update():void
        {
            this.updateCategoryButtons();
            this.updateGrid();
            this.updatePreview(this._SafeStr_8482);
        }
        public function removePet(_arg_1:int):void
        {
            var _local_2:PetsGridItem = (this._SafeStr_8481.remove(_arg_1) as PetsGridItem);
            if (_local_2 == null){
                return;
            };
            this._grid.removeGridItem(_local_2.window);
            if (this._SafeStr_8482 == _local_2){
                this._SafeStr_8482 = null;
                this.selectFirst();
            };
        }
        private function selectFirst():void
        {
            if ((((this._SafeStr_8481 == null)) || ((this._SafeStr_8481.length == 0)))){
                this.updatePreview();
                return;
            };
            this.setSelectedGridItem(this._SafeStr_8481.getWithIndex(0));
        }
        public function addPet(_arg_1:PetData):void
        {
            if (_arg_1 == null){
                return;
            };
            if (this._SafeStr_8481.getValue(_arg_1.id) != null){
                return;
            };
            var _local_2:PetsGridItem = new PetsGridItem(this, _arg_1, this._windowManager, this._assetLibrary, this._avatarRenderer, this._modelController.isUnseen(_arg_1.id));
            if (_local_2 != null){
                this._grid.addGridItem(_local_2.window);
                this._SafeStr_8481.add(_arg_1.id, _local_2);
                if (this._SafeStr_8482 == null){
                    this.selectFirst();
                };
            };
        }
        private function updateGrid():void
        {
            var _local_1:PetsGridItem;
            var _local_2:Map;
            var _local_3:PetData;
            if (this._view == null){
                return;
            };
            this._grid.removeGridItems();
            for each (_local_1 in this._SafeStr_8481) {
                _local_1.dispose();
            };
            this._SafeStr_8481.reset();
            _local_2 = this._modelController.pets;
            if (_local_2 == null){
                return;
            };
            for each (_local_3 in _local_2) {
                this.addPet(_local_3);
            };
        }
        private function catalogButtonClickHandler(_arg_1:WindowMouseEvent):void
        {
            this._modelController.requestCatalogOpen();
        }
        private function placeButtonClickHandler(_arg_1:WindowMouseEvent):void
        {
            if (this._SafeStr_8482 == null){
                return;
            };
            var _local_2:PetData = this._SafeStr_8482.pet;
            if (_local_2 == null){
                return;
            };
            this.placePetToRoom(_local_2.id);
        }
        public function placePetToRoom(_arg_1:int, _arg_2:Boolean=false):void
        {
            this._modelController.placePetToRoom(_arg_1, _arg_2);
        }
        public function getWindowContainer():IWindowContainer
        {
            if (this._view == null){
                return (null);
            };
            if (this._view.disposed){
                return (null);
            };
            return (this._view);
        }
        private function windowEventHandler(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == WindowEvent.WE_SELECTED){
                switch (_arg_2.name){
                    case "tab_floor":
                        this._modelController.switchToFurnitureCategory(FurniModelCategory.S);
                        break;
                    case "tab_wall":
                        this._modelController.switchToFurnitureCategory(FurniModelCategory.I);
                        break;
                };
                this.selectPetsTab();
            };
        }
        private function selectPetsTab():void
        {
            if (this._view == null){
                return;
            };
            var _local_1:ISelectorWindow = (this._view.findChildByName("category_selector") as ISelectorWindow);
            if (_local_1 != null){
                _local_1.setSelected(_local_1.getSelectableByName("tab_pets"));
            };
        }
        public function setSelectedGridItem(_arg_1:PetsGridItem):void
        {
            if (this._SafeStr_8482 != null){
                this._SafeStr_8482.setSelected(false);
            };
            this._SafeStr_8482 = _arg_1;
            if (this._SafeStr_8482 != null){
                this._SafeStr_8482.setSelected(true);
            };
            this.updatePreview(_arg_1);
        }
        public function updateState():void
        {
            var _local_2:int;
            var _local_1:Map = this._modelController.pets;
            if (!this._modelController.isListInitialized()){
                _local_2 = this._SafeStr_7894;
            }
            else {
                if (((!(_local_1)) || ((_local_1.length == 0)))){
                    _local_2 = this._SafeStr_7895;
                }
                else {
                    _local_2 = this._SafeStr_7896;
                };
            };
            if (this._SafeStr_7903 == _local_2){
                return;
            };
            this._SafeStr_7903 = _local_2;
            var _local_3:IWindowContainer = (this._view.findChildByName("loading_container") as IWindowContainer);
            var _local_4:IWindowContainer = (this._view.findChildByName("empty_container") as IWindowContainer);
            var _local_5:IWindowContainer = (this._view.findChildByName("grid_container") as IWindowContainer);
            var _local_6:IWindowContainer = (this._view.findChildByName("preview_container") as IWindowContainer);
            switch (_local_2){
                case this._SafeStr_7894:
                    _local_3.visible = true;
                    _local_4.visible = false;
                    _local_5.visible = false;
                    _local_6.visible = false;
                    return;
                case this._SafeStr_7895:
                    _local_3.visible = false;
                    _local_4.visible = true;
                    _local_5.visible = false;
                    _local_6.visible = false;
                    return;
                case this._SafeStr_7896:
                    _local_3.visible = false;
                    _local_4.visible = false;
                    _local_5.visible = true;
                    _local_6.visible = true;
                    this.updateGrid();
                    this.updatePreview();
                    return;
            };
        }
        private function updatePreview(_arg_1:PetsGridItem=null):void
        {
            var _local_2:BitmapData;
            var _local_3:String;
            var _local_4:String;
            var _local_5:Boolean;
            var _local_12:PetData;
            var _local_13:BitmapData;
            if (this._view == null){
                return;
            };
            if ((((_arg_1 == null)) || ((_arg_1.pet == null)))){
                _local_2 = new BitmapData(1, 1);
                _local_3 = "";
                _local_4 = "";
                _local_5 = false;
            }
            else {
                _local_12 = _arg_1.pet;
                _local_3 = _local_12.name;
                _local_2 = this.getPetImage(_local_12.type, _local_12.breed, _local_12.color, 4, true);
                _local_5 = true;
            };
            var _local_6:IBitmapWrapperWindow = (this._view.findChildByName("preview_image") as IBitmapWrapperWindow);
            if (_local_6 != null){
                _local_13 = new BitmapData(_local_6.width, _local_6.height);
                _local_13.fillRect(_local_13.rect, 0);
                _local_13.copyPixels(_local_2, _local_2.rect, new Point(((_local_13.width / 2) - (_local_2.width / 2)), ((_local_13.height / 2) - (_local_2.height / 2))));
                _local_6.bitmap = _local_13;
            };
            _local_2.dispose();
            var _local_7:ITextWindow = (this._view.findChildByName("preview_text") as ITextWindow);
            if (_local_7 != null){
                _local_7.caption = _local_3;
            };
            _local_7 = (this._view.findChildByName("preview_description") as ITextWindow);
            if (_local_7 != null){
                _local_7.caption = _local_4;
            };
            var _local_8:Boolean;
            var _local_9:Boolean;
            if (this._modelController.roomSession != null){
                _local_8 = this._modelController.roomSession.arePetsAllowed;
                _local_9 = this._modelController.roomSession.isRoomOwner;
            };
            var _local_10:String = "";
            if (!_local_9){
                if (_local_8){
                    _local_10 = "${inventory.pets.allowed}";
                }
                else {
                    _local_10 = "${inventory.pets.forbidden}";
                };
            };
            _local_7 = (this._view.findChildByName("preview_info") as ITextWindow);
            if (_local_7 != null){
                _local_7.caption = _local_10;
            };
            var _local_11:IButtonWindow = (this._view.findChildByName("place_button") as IButtonWindow);
            if (_local_11 != null){
                if (((_local_5) && (((_local_9) || (_local_8))))){
                    _local_11.enable();
                }
                else {
                    _local_11.disable();
                };
            };
        }
        public function getPetImage(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:Boolean):BitmapData
        {
            var _local_7:uint;
            var _local_8:IAvatarImage;
            var _local_9:uint;
            var _local_10:ImageResult;
            var _local_6:BitmapData;
            if (_arg_1 < 8){
                _local_7 = parseInt(_arg_3, 16);
                _local_8 = this._avatarRenderer.createPetImage(_arg_1, _arg_2, _local_7, AvatarScaleType._SafeStr_4336, this);
                if (_local_8 != null){
                    _local_8.setDirection(AvatarSetType._SafeStr_4457, _arg_4);
                    if (_arg_5){
                        _local_6 = _local_8.getCroppedImage(AvatarSetType._SafeStr_4457);
                    }
                    else {
                        _local_6 = _local_8.getCroppedImage(AvatarSetType._SafeStr_4458);
                    };
                    _local_8.dispose();
                };
            }
            else {
                _local_9 = 0;
                _local_10 = this._roomEngine.getPetImage(_arg_1, _arg_2, new Vector3d((_arg_4 * 45)), 64, this, _local_9);
                if (_local_10 != null){
                    _local_6 = _local_10.data;
                };
            };
            if (_local_6 == null){
                _local_6 = new BitmapData(30, 30, false, 4289374890);
            };
            return (_local_6);
        }
        public function petImageReady(_arg_1:String):void
        {
            this.update();
        }
        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            _arg_2.dispose();
            this.update();
        }
        private function addUnseenItemSymbols():void
        {
            var _local_3:IWindowContainer;
            var _local_4:IWindow;
            var _local_5:String;
            var _local_6:IWindow;
            var _local_1:XmlAsset = (this._assetLibrary.getAssetByName("unseen_item_symbol_xml") as XmlAsset);
            var _local_2:IWindow = this._windowManager.buildFromXML((_local_1.content as XML));
            for each (_local_5 in ["floor", "wall", "pets"]) {
                _local_4 = this._view.findChildByName(("tab_" + _local_5));
                _local_3 = (_local_2.clone() as IWindowContainer);
                _local_6 = _local_3.findChildByName("text");
                if (_local_6){
                    _local_6.caption = ((("$" + "{") + _local_6.caption) + "}");
                };
                _local_3.x = ((_local_4.rectangle.right - _local_3.width) - _SafeStr_7899);
                _local_3.y = (_local_4.y + _SafeStr_7899);
                _local_3.tags.push(("unseen_symbol_" + _local_5));
                _local_3.visible = false;
                this._view.addChild(_local_3);
            };
            _local_2.dispose();
        }
        public function updateCategoryButtons():void
        {
            var _local_1:IWindow;
            _local_1 = this._view.findChildByTag("unseen_symbol_floor");
            _local_1.visible = (this._modelController.furniModel.getUnseenItemCount(UnseenItemCategoryEnum._SafeStr_6767) > 0);
            _local_1 = this._view.findChildByTag("unseen_symbol_wall");
            _local_1.visible = (this._modelController.furniModel.getUnseenItemCount(UnseenItemCategoryEnum._SafeStr_6768) > 0);
            _local_1 = this._view.findChildByTag("unseen_symbol_pets");
            _local_1.visible = (this._modelController.getUnseenItemCount() > 0);
        }

    }
}//package com.sulake.habbo.inventory.pets

// ImageResult = "_-31w" (String#21576, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// PetData = "_-01G" (String#1387, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// AvatarScaleType = "_-2lF" (String#20893, DoABC#2)
// ISelectorWindow = "_-1aY" (String#1714, DoABC#2)
// IItemGridWindow = "_-265" (String#1809, DoABC#2)
// PetsModel = "_-1sv" (String#5899, DoABC#2)
// FurniModelCategory = "_-1a8" (String#5563, DoABC#2)
// UnseenItemCategoryEnum = "_-0Ua" (String#15227, DoABC#2)
// IGetImageListener = "_-2i7" (String#6909, DoABC#2)
// IInventoryView = "_-1g8" (String#5665, DoABC#2)
// PetsView = "_-N0" (String#8143, DoABC#2)
// PetsGridItem = "_-2O2" (String#6523, DoABC#2)
// WE_SELECTED = "_-17F" (String#16745, DoABC#2)
// _SafeStr_4336 = "_-1wM" (String#18815, DoABC#2)
// IAvatarRenderManager = "_-C9" (String#7915, DoABC#2)
// _SafeStr_4457 = "_-2mY" (String#20943, DoABC#2)
// _SafeStr_4458 = "_-327" (String#21586, DoABC#2)
// petImageReady = "_-WW" (String#8332, DoABC#2)
// _modelController = "_-0XB" (String#112, DoABC#2)
// removeGridItems = "_-1Bp" (String#5106, DoABC#2)
// addGridItem = "_-2vh" (String#7192, DoABC#2)
// getWindowContainer = "_-v8" (String#313, DoABC#2)
// _grid = "_-CU" (String#2073, DoABC#2)
// getCroppedImage = "_-2Ez" (String#6342, DoABC#2)
// windowEventHandler = "_-36j" (String#371, DoABC#2)
// updatePreview = "_-0hB" (String#4449, DoABC#2)
// furniModel = "_-Sp" (String#23358, DoABC#2)
// isRoomOwner = "_-ZP" (String#8405, DoABC#2)
// arePetsAllowed = "_-1f7" (String#5646, DoABC#2)
// _SafeStr_6767 = "for" (String#45121, DoABC#2)
// _SafeStr_6768 = "_-QD" (String#23258, DoABC#2)
// roomSession = "_-0cq" (String#4363, DoABC#2)
// S = "_-Ch" (String#22713, DoABC#2)
// I = "_-3-D" (String#21470, DoABC#2)
// getPetImage = "_-0Zc" (String#437, DoABC#2)
// createPetImage = "_-0Qk" (String#4105, DoABC#2)
// isVisible = "_-1rE" (String#18592, DoABC#2)
// switchToFurnitureCategory = "_-1uc" (String#18741, DoABC#2)
// requestCatalogOpen = "_-0sM" (String#16138, DoABC#2)
// updateCategoryButtons = "_-2i3" (String#20774, DoABC#2)
// getUnseenItemCount = "_-133" (String#16582, DoABC#2)
// _SafeStr_7893 = "_-h3" (String#8535, DoABC#2)
// _SafeStr_7894 = "_-2EZ" (String#1840, DoABC#2)
// _SafeStr_7895 = "_-3F1" (String#7613, DoABC#2)
// _SafeStr_7896 = "_-0X6" (String#4252, DoABC#2)
// _SafeStr_7899 = "_-1Jp" (String#5240, DoABC#2)
// _SafeStr_7903 = "_-04-" (String#577, DoABC#2)
// addUnseenItemSymbols = "_-pj" (String#8703, DoABC#2)
// getSelectableByName = "_-0EO" (String#3836, DoABC#2)
// removeGridItem = "_-3CS" (String#7563, DoABC#2)
// isListInitialized = "_-2cf" (String#20551, DoABC#2)
// updateState = "_-3Be" (String#21947, DoABC#2)
// addPet = "_-3DW" (String#22016, DoABC#2)
// removePet = "_-lb" (String#24093, DoABC#2)
// placePetToRoom = "_-2hx" (String#20770, DoABC#2)
// isUnseen = "_-FH" (String#22825, DoABC#2)
// _SafeStr_8481 = "_-18n" (String#16804, DoABC#2)
// _SafeStr_8482 = "_-2IF" (String#618, DoABC#2)
// placeButtonClickHandler = "_-0cB" (String#15522, DoABC#2)
// catalogButtonClickHandler = "_-1Fs" (String#17110, DoABC#2)
// selectPetsTab = "_-AR" (String#22633, DoABC#2)
// updateGrid = "_-1TW" (String#17646, DoABC#2)
// selectFirst = "_-RL" (String#23299, DoABC#2)
// setSelectedGridItem = "_-2eW" (String#20626, DoABC#2)


