
package com.sulake.habbo.inventory.furni
{
    import com.sulake.habbo.inventory.IInventoryView;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.inventory.marketplace.MarketplaceModel;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.sound.events.SongInfoReceivedEvent;
    import com.sulake.habbo.inventory.enum.FurniModelCategory;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ISelectorWindow;
    import com.sulake.habbo.inventory.items.GroupItem;
    import com.sulake.habbo.communication.messages.outgoing.notifications.UnseenItemCategoryEnum;
    import com.sulake.habbo.inventory.items.IItem;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.assets.IAsset;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.habbo.sound.ISongInfo;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.inventory.enum.FurniCategory;
    import com.sulake.habbo.inventory.items.FloorItem;
    import com.sulake.room.utils.Vector3d;
    import flash.filters.GlowFilter;
    import com.sulake.habbo.inventory.items.WallItem;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class FurniView implements IInventoryView, IGetImageListener 
    {

        private static const _SafeStr_7893:int = 0;
        private static const _SafeStr_7894:int = 1;
        private static const _SafeStr_7895:int = 2;
        private static const _SafeStr_7896:int = 3;
        private static const _SafeStr_7897:int = 42;
        private static const _SafeStr_7898:int = 120;
        private static const _SafeStr_7899:int = 4;

        private var _windowManager:IHabboWindowManager;
        private var _assetLibrary:IAssetLibrary;
        private var _view:IWindowContainer;
        private var _SafeStr_4830:FurniModel;
        private var _SafeStr_7900:MarketplaceModel;
        private var _roomEngine:IRoomEngine;
        private var _soundManager:IHabboSoundManager;
        private var _disposed:Boolean = false;
        private var _SafeStr_7901:Map;
        private var _visibleCategoryId:String;
        private var _SafeStr_7903:int = 0;
        private var _SafeStr_7904:int = -1;

        public function FurniView(_arg_1:FurniModel, _arg_2:MarketplaceModel, _arg_3:IHabboWindowManager, _arg_4:IAssetLibrary, _arg_5:IRoomEngine, _arg_6:IHabboSoundManager)
        {
            var _local_12:IWindowContainer;
            super();
            this._SafeStr_4830 = _arg_1;
            this._SafeStr_7900 = _arg_2;
            this._assetLibrary = _arg_4;
            this._windowManager = _arg_3;
            this._roomEngine = _arg_5;
            this._soundManager = _arg_6;
            this._soundManager.events.addEventListener(SongInfoReceivedEvent.SIR_TRAX_SONG_INFO_RECEIVED, this.onSongInfoReceivedEvent);
            this._SafeStr_7901 = new Map();
            this._SafeStr_7901.add(FurniModelCategory.S, new FurniGridView(this._SafeStr_4830, FurniModelCategory.S, this._windowManager, this._assetLibrary, this._roomEngine));
            this._SafeStr_7901.add(FurniModelCategory.I, new FurniGridView(this._SafeStr_4830, FurniModelCategory.I, this._windowManager, this._assetLibrary, this._roomEngine));
            var _local_7:XmlAsset = (this._assetLibrary.getAssetByName("inventory_furni_base_xml") as XmlAsset);
            if (_local_7 == null){
                return;
            };
            this._view = (this._windowManager.buildFromXML((_local_7.content as XML)) as IWindowContainer);
            this._view.visible = false;
            this._view.procedure = this.windowEventProc;
            this.PetsView();
            this.switchCategory(FurniModelCategory.S);
            var _local_8:IWindowContainer = (this._view.findChildByName("preview_container") as IWindowContainer);
            if (_local_8 != null){
                _local_7 = (this._assetLibrary.getAssetByName("inventory_furni_preview_xml") as XmlAsset);
                _local_12 = (this._windowManager.buildFromXML((_local_7.content as XML)) as IWindowContainer);
                if (_local_12 != null){
                    _local_8.addChild(_local_12);
                };
            };
            var _local_9:IBitmapWrapperWindow = (this._view.findChildByName("download_image") as IBitmapWrapperWindow);
            _local_9.bitmap = new BitmapData(_local_9.width, _local_9.height);
            var _local_10:BitmapData = (this._assetLibrary.getAssetByName("download_icon_png").content as BitmapData);
            _local_9.bitmap.copyPixels(_local_10, _local_10.rect, new Point(((_local_9.width - _local_10.width) / 2), ((_local_9.height - _local_10.height) / 2)), null, null, true);
            _local_9 = (this._view.findChildByName("image") as IBitmapWrapperWindow);
            _local_9.bitmap = new BitmapData(_local_9.width, _local_9.height);
            var _local_11:BitmapData = (this._assetLibrary.getAssetByName("inventory_empty_png").content as BitmapData);
            _local_9.bitmap.copyPixels(_local_11, _local_11.rect, new Point(((_local_9.width - _local_11.width) / 2), ((_local_9.height - _local_11.height) / 2)), null, null, true);
            this.setViewToState();
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        private function PetsView():void
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
        public function dispose():void
        {
            var _local_1:FurniGridView;
            if (!this._disposed){
                this._SafeStr_4830 = null;
                this._SafeStr_7900 = null;
                this._assetLibrary = null;
                this._windowManager = null;
                this._roomEngine = null;
                if (this._SafeStr_7901){
                    for each (_local_1 in this._SafeStr_7901) {
                        _local_1.dispose();
                    };
                    this._SafeStr_7901.dispose();
                    this._SafeStr_7901 = null;
                };
                if (this._soundManager){
                    if (this._soundManager.events != null){
                        this._soundManager.events.removeEventListener(SongInfoReceivedEvent.SIR_TRAX_SONG_INFO_RECEIVED, this.onSongInfoReceivedEvent);
                    };
                    this._soundManager = null;
                };
                if (this._view){
                    this._view.dispose();
                    this._view = null;
                };
                this._disposed = true;
            };
        }
        public function get isVisible():Boolean
        {
            return (((!((this._view.parent == null))) && (this._view.visible)));
        }
        public function TradingModel():IWindowContainer
        {
            var _local_2:IWindow;
            if (this._view == null){
                return (null);
            };
            if (this._view.disposed){
                return (null);
            };
            var _local_1:Boolean = this._SafeStr_4830.isTradingOpen;
            _local_2 = this._view.findChildByName("placeinroom_btn");
            if (_local_2 != null){
                _local_2.visible = !(_local_1);
            };
            _local_2 = this._view.findChildByName("offertotrade_btn");
            if (_local_2 != null){
                _local_2.visible = _local_1;
            };
            return (this._view);
        }
        public function get visibleCategoryId():String
        {
            return (this._visibleCategoryId);
        }
        public function switchCategory(_arg_1:String):void
        {
            if (this._view == null){
                return;
            };
            if (this._view.disposed){
                return;
            };
            if (this._visibleCategoryId == _arg_1){
                return;
            };
            var _local_2:ISelectorWindow = (this._view.findChildByName("category_selector") as ISelectorWindow);
            if (this._SafeStr_4830.isMainViewActive()){
                this._SafeStr_4830.resetUnseenItems();
            };
            switch (_arg_1){
                case FurniModelCategory.I:
                    _local_2.setSelected(_local_2.ISelectorWindow("tab_wall"));
                    this._visibleCategoryId = FurniModelCategory.I;
                    break;
                case FurniModelCategory.S:
                    _local_2.setSelected(_local_2.ISelectorWindow("tab_floor"));
                    this._visibleCategoryId = FurniModelCategory.S;
                    break;
                case FurniModelCategory._SafeStr_7068:
                    _local_2.setSelected(_local_2.ISelectorWindow("tab_pets"));
                    this._visibleCategoryId = FurniModelCategory._SafeStr_7068;
                    break;
                default:
                    throw (new Error((('Unknown item category: "' + _arg_1) + '"')));
            };
            this._SafeStr_4830.furniCategorySwitch();
            this.showCategoryGrid(this._visibleCategoryId);
            this.setViewToState();
        }
        private function showCategoryGrid(_arg_1:String=null):void
        {
            var _local_4:IWindowContainer;
            if (_arg_1 == null){
                _arg_1 = this._visibleCategoryId;
            };
            var _local_2:IWindowContainer = (this._view.findChildByName("grid_container") as IWindowContainer);
            _local_2.removeChildAt(0);
            var _local_3:FurniGridView = this._SafeStr_7901.getValue(this._visibleCategoryId);
            if (_local_3){
                _local_4 = _local_3.window;
                if (_local_4 == null){
                    return;
                };
                _local_2.addChild(_local_4);
                _local_2.invalidate();
                this.BadgesView();
            };
        }
        public function setViewToState():void
        {
            var _local_2:int;
            var _local_1:Array = this._SafeStr_4830.FurniModel(this._visibleCategoryId);
            if (!this._SafeStr_4830.FurniModel()){
                _local_2 = _SafeStr_7894;
            }
            else {
                if (((!(_local_1)) || ((_local_1.length == 0)))){
                    _local_2 = _SafeStr_7895;
                }
                else {
                    _local_2 = _SafeStr_7896;
                };
            };
            if (this._SafeStr_7903 == _local_2){
                return;
            };
            this._SafeStr_7903 = _local_2;
            var _local_3:IWindowContainer = (this._view.findChildByName("loading_container") as IWindowContainer);
            var _local_4:IWindowContainer = (this._view.findChildByName("empty_container") as IWindowContainer);
            var _local_5:IWindowContainer = (this._view.findChildByName("furni_container") as IWindowContainer);
            switch (_local_2){
                case _SafeStr_7894:
                    _local_3.visible = true;
                    _local_4.visible = false;
                    _local_5.visible = false;
                    return;
                case _SafeStr_7895:
                    _local_3.visible = false;
                    _local_4.visible = true;
                    _local_5.visible = false;
                    return;
                case _SafeStr_7896:
                    _local_3.visible = false;
                    _local_4.visible = false;
                    _local_5.visible = true;
                    this.showCategoryGrid();
                    return;
            };
        }
        public function clearViews():void
        {
            var _local_2:String;
            var _local_3:FurniGridView;
            var _local_1:Array = [FurniModelCategory.S, FurniModelCategory.I];
            var _local_4:int;
            while (_local_4 < _local_1.length) {
                _local_2 = _local_1[_local_4];
                _local_3 = this._SafeStr_7901.getValue(_local_2);
                if (_local_3 != null){
                    _local_3.FurniGridView();
                };
                _local_4++;
            };
            this.BadgesView();
        }
        public function updateItem(_arg_1:String, _arg_2:GroupItem, _arg_3:int):void
        {
            if (_arg_2 == null){
                return;
            };
            var _local_4:FurniGridView = this._SafeStr_7901.getValue(_arg_1);
            if (_local_4 == null){
                return;
            };
            _local_4.updateItem(_arg_3, _arg_2.window);
            this.BadgesView();
        }
        public function FurniGridView(_arg_1:String, _arg_2:GroupItem):void
        {
            if (_arg_2 == null){
                return;
            };
            var _local_3:FurniGridView = this._SafeStr_7901.getValue(_arg_1);
            if (_local_3 == null){
                return;
            };
            _local_3.FurniGridView(_arg_2.window);
        }
        public function FurniGridView(_arg_1:String, _arg_2:GroupItem, _arg_3:int):void
        {
            if (_arg_2 == null){
                return;
            };
            var _local_4:FurniGridView = this._SafeStr_7901.getValue(_arg_1);
            if (_local_4 == null){
                return;
            };
            _local_4.FurniGridView(_arg_2.window, _arg_3);
        }
        public function removeItem(_arg_1:String, _arg_2:int):void
        {
            var _local_3:FurniGridView = this._SafeStr_7901.getValue(_arg_1);
            if (_local_3 == null){
                return;
            };
            var _local_4:IWindow = _local_3.removeItem(_arg_2);
            if (_local_4){
                _local_4.dispose();
            };
            this.BadgesView();
        }
        public function FurniGridView(_arg_1:GroupItem, _arg_2:int):void
        {
            if (_arg_1 == null){
                return;
            };
            var _local_3:FurniGridView = this._SafeStr_7901.getValue(_arg_1.mainCategory);
            if (_local_3 == null){
                return;
            };
            _local_3.FurniGridView(_arg_1.window, _arg_2);
        }
        public function setGridLock(_arg_1:String, _arg_2:Boolean):void
        {
            var _local_3:FurniGridView = this._SafeStr_7901.getValue(_arg_1);
            if (_local_3 == null){
                return;
            };
            _local_3.FurniGridView(_arg_2);
        }
        public function PetsView():void
        {
            var _local_1:IWindow;
            _local_1 = this._view.findChildByTag("unseen_symbol_floor");
            _local_1.visible = (this._SafeStr_4830.getUnseenItemCount(UnseenItemCategoryEnum._SafeStr_6767) > 0);
            _local_1 = this._view.findChildByTag("unseen_symbol_wall");
            _local_1.visible = (this._SafeStr_4830.getUnseenItemCount(UnseenItemCategoryEnum._SafeStr_6768) > 0);
            _local_1 = this._view.findChildByTag("unseen_symbol_pets");
            _local_1.visible = (this._SafeStr_4830.petsModel.getUnseenItemCount() > 0);
        }
        public function BadgesView():void
        {
            var _local_2:BitmapData;
            var _local_4:GroupItem;
            var _local_5:IItem;
            var _local_6:IBitmapWrapperWindow;
            var _local_7:ITextWindow;
            var _local_8:IRegionWindow;
            var _local_9:String;
            var _local_10:String;
            var _local_11:IButtonWindow;
            var _local_15:IAsset;
            var _local_16:String;
            var _local_17:String;
            var _local_18:String;
            var _local_19:BitmapData;
            var _local_20:IAsset;
            var _local_21:int;
            var _local_22:ImageResult;
            var _local_23:uint;
            var _local_24:int;
            var _local_25:ISongInfo;
            if (this._view == null){
                return;
            };
            if (this._view.disposed){
                return;
            };
            var _local_1:Boolean;
            var _local_3:int = this._SafeStr_4830.getSelectedItemIndex();
            _local_4 = this._SafeStr_4830.getGroupItemInIndex(_local_3, this._visibleCategoryId);
            if ((((((_local_3 > -1)) && (!((_local_4 == null))))) && (!((_local_4._SafeStr_7867() == null))))){
                _local_5 = _local_4._SafeStr_7867();
                _local_1 = true;
                _local_16 = this._roomEngine.RoomEngine(this._roomEngine.activeRoomId, this._roomEngine.activeRoomCategory, RoomObjectVariableEnum._SafeStr_5786);
                _local_17 = this._roomEngine.RoomEngine(this._roomEngine.activeRoomId, this._roomEngine.activeRoomCategory, RoomObjectVariableEnum._SafeStr_5784);
                _local_18 = this._roomEngine.RoomEngine(this._roomEngine.activeRoomId, this._roomEngine.activeRoomCategory, RoomObjectVariableEnum._SafeStr_5788);
                _local_16 = ((((_local_16) && ((_local_16.length > 0)))) ? _local_16 : "101");
                _local_17 = ((((_local_17) && ((_local_17.length > 0)))) ? _local_17 : "101");
                _local_18 = ((((_local_18) && ((_local_18.length > 0)))) ? _local_18 : "1.1");
                if (_local_5.category == FurniCategory._SafeStr_7051){
                    _local_22 = this._roomEngine.getRoomImage(_local_17, _local_5.stuffData, _local_18, 64, this);
                    if (_local_22 != null){
                        _local_2 = _local_22.data;
                    };
                    this.setPreviewImage(_local_2);
                    _local_9 = "${inventory.furni.item.wallpaper.name}";
                    _local_10 = "${inventory.furni.item.wallpaper.desc}";
                }
                else {
                    if (_local_5.category == FurniCategory._SafeStr_7052){
                        _local_22 = this._roomEngine.getRoomImage(_local_5.stuffData, _local_16, _local_18, 64, this);
                        if (_local_22 != null){
                            _local_2 = _local_22.data;
                        };
                        this.setPreviewImage(_local_2);
                        _local_9 = "${inventory.furni.item.floor.name}";
                        _local_10 = "${inventory.furni.item.floor.desc}";
                    }
                    else {
                        if (_local_5.category == FurniCategory._SafeStr_7053){
                            _local_15 = this._assetLibrary.getAssetByName("icon_landscape_png");
                            if (_local_15 != null){
                                this.setPreviewImage((_local_15.content as BitmapData));
                            };
                            _local_9 = "${inventory.furni.item.landscape.name}";
                            _local_10 = "${inventory.furni.item.landscape.desc}";
                        }
                        else {
                            if (_local_5.category == FurniCategory._SafeStr_7055){
                                _local_9 = (("${poster_" + _local_5.stuffData) + "_name}");
                                _local_10 = (("${poster_" + _local_5.stuffData) + "_desc}");
                            };
                            _local_23 = 0xFFFFFFFF;
                            if ((_local_5 is FloorItem)){
                                _local_22 = this._roomEngine.getFurnitureImage(_local_4.type, new Vector3d(180, 0, 0), 64, this, _local_23, String(_local_4.extra));
                            }
                            else {
                                _local_22 = this._roomEngine.getWallItemImage(_local_4.type, new Vector3d(180, 0, 0), 64, this, _local_23, _local_4.stuffData);
                            };
                            if (_local_22 != null){
                                _local_2 = _local_22.data;
                            };
                            this.setPreviewImage(_local_2);
                            _local_4.previewCallbackId = _local_22.id;
                        };
                    };
                };
                _local_6 = (this._view.findChildByName("tradeable_icon") as IBitmapWrapperWindow);
                _local_7 = (this._view.findChildByName("tradeable_number") as ITextWindow);
                _local_8 = (this._view.findChildByName("tradeable_info_region") as IRegionWindow);
                if (((((!((_local_6 == null))) && (!((_local_7 == null))))) && (!((_local_8 == null))))){
                    _local_21 = _local_4.GroupItem();
                    if (_local_21 == 0){
                        _local_20 = this._assetLibrary.getAssetByName("no_trade_icon_png");
                        _local_19 = (_local_20.content as BitmapData);
                        _local_7.visible = false;
                        _local_8.toolTipCaption = "${inventory.furni.preview.not_tradeable}";
                        _local_7.filters = [];
                    }
                    else {
                        _local_20 = this._assetLibrary.getAssetByName("trade_icon_png");
                        _local_19 = (_local_20.content as BitmapData);
                        _local_7.visible = true;
                        _local_7.text = String(_local_21);
                        _local_8.toolTipCaption = "${inventory.furni.preview.tradeable_amount}";
                        _local_7.filters = [new GlowFilter(0xFFFFFF, 1, 3, 3, 300)];
                    };
                    _local_6.bitmap = new BitmapData(_local_6.width, _local_6.height, true, 0xFFFFFF);
                    if (_local_19 != null){
                        _local_6.bitmap.copyPixels(_local_19, _local_19.rect, new Point(0, 0), null, null, true);
                    };
                    _local_6.invalidate();
                };
                _local_6 = (this._view.findChildByName("recyclable_icon") as IBitmapWrapperWindow);
                _local_7 = (this._view.findChildByName("recyclable_number") as ITextWindow);
                _local_8 = (this._view.findChildByName("recyclable_info_region") as IRegionWindow);
                if (((((!((_local_6 == null))) && (!((_local_7 == null))))) && (!((_local_8 == null))))){
                    _local_21 = _local_4.GroupItem();
                    if (_local_21 == 0){
                        _local_20 = this._assetLibrary.getAssetByName("no_recycle_icon_png");
                        _local_19 = (_local_20.content as BitmapData);
                        _local_7.visible = false;
                        _local_8.toolTipCaption = "${inventory.furni.preview.not_recyclable}";
                        _local_7.filters = [];
                    }
                    else {
                        _local_20 = this._assetLibrary.getAssetByName("recycle_icon_png");
                        _local_19 = (_local_20.content as BitmapData);
                        _local_7.visible = true;
                        _local_7.text = String(_local_21);
                        _local_8.toolTipCaption = "${inventory.furni.preview.recyclable_amount}";
                        _local_7.filters = [new GlowFilter(0xFFFFFF, 1, 3, 3, 300)];
                    };
                    _local_6.bitmap = new BitmapData(_local_6.width, _local_6.height, true, 0xFFFFFF);
                    if (_local_19 != null){
                        _local_6.bitmap.copyPixels(_local_19, _local_19.rect, new Point(0, 0), null, null, true);
                    };
                    _local_6.invalidate();
                };
            }
            else {
                this.setPreviewImage(null);
                _local_6 = (this._view.findChildByName("tradeable_icon") as IBitmapWrapperWindow);
                _local_7 = (this._view.findChildByName("tradeable_number") as ITextWindow);
                _local_8 = (this._view.findChildByName("tradeable_info_region") as IRegionWindow);
                if (((((_local_6) && (_local_7))) && (_local_8))){
                    _local_6.bitmap = null;
                    _local_7.visible = false;
                };
                _local_6 = (this._view.findChildByName("recyclable_icon") as IBitmapWrapperWindow);
                _local_7 = (this._view.findChildByName("recyclable_number") as ITextWindow);
                _local_8 = (this._view.findChildByName("recyclable_info_region") as IRegionWindow);
                if (((((_local_6) && (_local_7))) && (_local_8))){
                    _local_6.bitmap = null;
                    _local_7.visible = false;
                };
            };
            var _local_12:Boolean = this._SafeStr_4830.isTradingOpen;
            _local_11 = (this._view.findChildByName("placeinroom_btn") as IButtonWindow);
            if (_local_11){
                if (((_local_1) && (this._SafeStr_4830.isPrivateRoom))){
                    _local_11.enable();
                }
                else {
                    _local_11.disable();
                };
                _local_11.visible = !(_local_12);
            };
            _local_11 = (this._view.findChildByName("offertotrade_btn") as IButtonWindow);
            if (_local_11){
                if (((((((_local_1) && (!((_local_4 == null))))) && (!((_local_5 == null))))) && (this._SafeStr_4830.HabboInventory()))){
                    if (((_local_4.GroupItem()) && (_local_5.tradeable))){
                        _local_11.enable();
                    }
                    else {
                        _local_11.disable();
                    };
                }
                else {
                    _local_11.disable();
                };
                _local_11.visible = _local_12;
            };
            _local_11 = (this._view.findChildByName("sell_btn") as IButtonWindow);
            if (_local_11){
                if (((((((_local_1) && (this._SafeStr_7900))) && (this._SafeStr_7900.isEnabled))) && (_local_5.sellable))){
                    _local_11.enable();
                }
                else {
                    _local_11.disable();
                };
            };
            this._SafeStr_7904 = -1;
            if (_local_5 != null){
                if (_local_5.category == FurniCategory._SafeStr_7057){
                    _local_24 = _local_5.extra;
                    _local_25 = this._soundManager.musicController.getSongInfo(_local_24);
                    if (_local_25 != null){
                        _local_9 = _local_25.name;
                        _local_10 = _local_25.creator;
                    }
                    else {
                        this._soundManager.musicController.requestSongInfoWithoutSamples(_local_24);
                        this._SafeStr_7904 = _local_24;
                    };
                };
            };
            var _local_13:ITextWindow = (this._view.findChildByName("furni_name") as ITextWindow);
            if (_local_13 != null){
                if (_local_9 != null){
                    _local_13.text = _local_9;
                }
                else {
                    if ((_local_5 is FloorItem)){
                        _local_13.text = (("${roomItem.name." + _local_5.type) + "}");
                    }
                    else {
                        if ((_local_5 is WallItem)){
                            _local_13.text = (("${wallItem.name." + _local_5.type) + "}");
                        }
                        else {
                            _local_13.text = "";
                        };
                    };
                };
                _local_13.height = _local_13.textHeight;
            };
            var _local_14:ITextWindow = (this._view.findChildByName("furni_description") as ITextWindow);
            if (_local_14 != null){
                if (_local_10 != null){
                    _local_14.text = _local_10;
                }
                else {
                    if ((_local_5 is FloorItem)){
                        _local_14.text = (("${roomItem.desc." + _local_5.type) + "}");
                    }
                    else {
                        if ((_local_5 is WallItem)){
                            _local_14.text = (("${wallItem.desc." + _local_5.type) + "}");
                        }
                        else {
                            _local_14.text = "";
                        };
                    };
                };
                _local_14.height = (_local_14.textHeight + 5);
            };
        }
        public function displayItemInfo(_arg_1:GroupItem):void
        {
            var _local_2:ImageResult;
            var _local_4:IButtonWindow;
            if (this._view == null){
                return;
            };
            if (this._view.disposed){
                return;
            };
            var _local_3:IItem = _arg_1._SafeStr_7867();
            if ((_local_3 is FloorItem)){
                _local_2 = this._roomEngine.getFurnitureImage(_arg_1.type, new Vector3d(2, 0, 0), 64, this, 0, String(_arg_1.extra));
            }
            else {
                _local_2 = this._roomEngine.getWallItemImage(_arg_1.type, new Vector3d(2, 0, 0), 64, this, 0, _arg_1.stuffData);
            };
            if (_local_2 != null){
                this.setPreviewImage(_local_2.data);
            };
            _local_4 = (this._view.findChildByName("placeinroom_btn") as IButtonWindow);
            if (_local_4){
                _local_4.disable();
            };
            _local_4 = (this._view.findChildByName("offertotrade_btn") as IButtonWindow);
            if (_local_4){
                _local_4.disable();
            };
        }
        private function setPreviewImage(_arg_1:BitmapData):void
        {
            var _local_2:IBitmapWrapperWindow = (this._view.findChildByName("furni_preview_image") as IBitmapWrapperWindow);
            if (_local_2 == null){
                return;
            };
            if (_arg_1 == null){
                _arg_1 = new BitmapData(20, 20);
            };
            var _local_3:int = _arg_1.height;
            if (_local_3 > _SafeStr_7898){
                _local_3 = _SafeStr_7898;
            }
            else {
                if (_local_3 < _SafeStr_7897){
                    _local_3 = _SafeStr_7897;
                }
                else {
                    _local_3 = (Math.ceil((_local_3 / 10)) * 10);
                };
            };
            _local_2.bitmap = new BitmapData(_local_2.width, _local_3, true, 0xFFFFFF);
            _local_2.height = _local_3;
            var _local_4:Point = new Point(((_local_2.width - _arg_1.width) / 2), ((_local_3 - _arg_1.height) / 2));
            _local_2.bitmap.copyPixels(_arg_1, _arg_1.rect, _local_4, null, null, true);
            _local_2.invalidate();
            var _local_5:ITextWindow = (this._view.findChildByName("furni_description") as ITextWindow);
            if (_local_5 != null){
                _local_5.y = ((_local_2.y + _local_2.height) + 5);
            };
        }
        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            var _local_3:GroupItem = this._SafeStr_4830.getGroupItemInIndex(this._SafeStr_4830.getSelectedItemIndex());
            if (_local_3 == null){
                return;
            };
            if (_local_3.previewCallbackId == _arg_1){
                this.setPreviewImage(_arg_2);
            };
        }
        private function windowEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                switch (_arg_2.name){
                    case "placeinroom_btn":
                        this._SafeStr_4830.FurniModel(false);
                        break;
                    case "offertotrade_btn":
                        this._SafeStr_4830.FurniModel();
                        break;
                    case "sell_btn":
                        this._SafeStr_4830.FurniModel();
                        break;
                    case "open_catalog_btn":
                        this._SafeStr_4830.requestCatalogOpen();
                        break;
                    default:
                        this._SafeStr_4830.cancelFurniInMover();
                };
            }
            else {
                if (_arg_1.type == WindowEvent.WE_SELECTED){
                    switch (_arg_2.name){
                        case "tab_floor":
                            this.switchCategory(FurniModelCategory.S);
                            return;
                        case "tab_wall":
                            this.switchCategory(FurniModelCategory.I);
                            return;
                        case "tab_pets":
                            this.switchCategory(FurniModelCategory._SafeStr_7068);
                            return;
                    };
                };
            };
        }
        private function onSongInfoReceivedEvent(_arg_1:SongInfoReceivedEvent):void
        {
            if (_arg_1.id == this._SafeStr_7904){
                this.BadgesView();
                this._SafeStr_7904 = -1;
            };
        }

    }
}//package com.sulake.habbo.inventory.furni

// ImageResult = "_-31w" (String#21576, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// FurniCategory = "_-0lm" (String#15890, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// ISelectorWindow = "_-1aY" (String#1714, DoABC#2)
// IRegionWindow = "_-dg" (String#2146, DoABC#2)
// IItem = "_-1-k" (String#4863, DoABC#2)
// GroupItem = "_-0qS" (String#4647, DoABC#2)
// FurniModelCategory = "_-1a8" (String#5563, DoABC#2)
// FurniModel = "_-1ur" (String#5936, DoABC#2)
// MarketplaceModel = "_-2M1" (String#6484, DoABC#2)
// ISongInfo = "_-2vd" (String#7190, DoABC#2)
// UnseenItemCategoryEnum = "_-0Ua" (String#15227, DoABC#2)
// IGetImageListener = "_-2i7" (String#6909, DoABC#2)
// WallItem = "_-2ZP" (String#20413, DoABC#2)
// FloorItem = "_-2DW" (String#19547, DoABC#2)
// IInventoryView = "_-1g8" (String#5665, DoABC#2)
// FurniView = "_-1Jo" (String#5239, DoABC#2)
// FurniGridView = "_-z3" (String#8862, DoABC#2)
// extra = "_-2We" (String#6693, DoABC#2)
// stuffData = "_-0vz" (String#1580, DoABC#2)
// IHabboSoundManager = "_-0vD" (String#4750, DoABC#2)
// WE_SELECTED = "_-17F" (String#16745, DoABC#2)
// _SafeStr_4830 = "_-0XB" (String#112, DoABC#2)
// TradingModel = "_-v8" (String#313, DoABC#2)
// previewCallbackId = "_-2QR" (String#20063, DoABC#2)
// activeRoomId = "_-kJ" (String#2172, DoABC#2)
// activeRoomCategory = "_-1qo" (String#1770, DoABC#2)
// isEnabled = "_-2ri" (String#21145, DoABC#2)
// _SafeStr_5784 = "_-2G-" (String#19644, DoABC#2)
// _SafeStr_5786 = "_-1SC" (String#17588, DoABC#2)
// _SafeStr_5788 = "_-Nt" (String#23160, DoABC#2)
// creator = "_-1U2" (String#5433, DoABC#2)
// removeItem = "_-2gu" (String#6888, DoABC#2)
// musicController = "_-1Qk" (String#5366, DoABC#2)
// getSongInfo = "_-0Fc" (String#3864, DoABC#2)
// SIR_TRAX_SONG_INFO_RECEIVED = "_-02" (String#14127, DoABC#2)
// onSongInfoReceivedEvent = "_-1Di" (String#360, DoABC#2)
// _SafeStr_6767 = "for" (String#45121, DoABC#2)
// _SafeStr_6768 = "_-QD" (String#23258, DoABC#2)
// toolTipCaption = "_-0cC" (String#4347, DoABC#2)
// _SafeStr_7051 = "_-AU" (String#22635, DoABC#2)
// _SafeStr_7052 = "_-0OP" (String#15005, DoABC#2)
// _SafeStr_7053 = "_-19z" (String#16856, DoABC#2)
// _SafeStr_7055 = "_-0z3" (String#16396, DoABC#2)
// _SafeStr_7057 = "_-W0" (String#23493, DoABC#2)
// S = "_-Ch" (String#22713, DoABC#2)
// I = "_-3-D" (String#21470, DoABC#2)
// _SafeStr_7068 = "_-0Wb" (String#15301, DoABC#2)
// isPrivateRoom = "_-1Wr" (String#5489, DoABC#2)
// requestSongInfoWithoutSamples = "_-3CP" (String#7560, DoABC#2)
// petsModel = "_-227" (String#19096, DoABC#2)
// setGridLock = "_-2Jr" (String#19803, DoABC#2)
// getSelectedItemIndex = "_-tL" (String#24421, DoABC#2)
// FurniModel = "_-cQ" (String#23731, DoABC#2)
// setViewToState = "_-0gw" (String#15707, DoABC#2)
// FurniModel = "_-1lE" (String#18339, DoABC#2)
// isVisible = "_-1rE" (String#18592, DoABC#2)
// visibleCategoryId = "_-2iM" (String#20782, DoABC#2)
// furniCategorySwitch = "_-3W" (String#22356, DoABC#2)
// resetUnseenItems = "_-0qm" (String#16077, DoABC#2)
// BadgesView = "_-jg" (String#8593, DoABC#2)
// clearViews = "_-Uc" (String#23431, DoABC#2)
// FurniGridView = "_-SJ" (String#23337, DoABC#2)
// FurniGridView = "_-3AS" (String#21898, DoABC#2)
// cancelFurniInMover = "_-1Xa" (String#17797, DoABC#2)
// FurniModel = "_-17E" (String#16744, DoABC#2)
// displayItemInfo = "_-264" (String#19261, DoABC#2)
// getGroupItemInIndex = "_-0lk" (String#15888, DoABC#2)
// isTradingOpen = "_-0Yq" (String#15394, DoABC#2)
// HabboInventory = "_-1Ic" (String#17218, DoABC#2)
// GroupItem = "_-2rq" (String#21148, DoABC#2)
// _SafeStr_7867 = "catch" (String#25155, DoABC#2)
// FurniModel = "_-1mj" (String#18410, DoABC#2)
// FurniModel = "_-1hq" (String#18205, DoABC#2)
// requestCatalogOpen = "_-0sM" (String#16138, DoABC#2)
// PetsView = "_-2i3" (String#20774, DoABC#2)
// FurniGridView = "_-3JU" (String#22263, DoABC#2)
// isMainViewActive = "_-jz" (String#24031, DoABC#2)
// getUnseenItemCount = "_-133" (String#16582, DoABC#2)
// _SafeStr_7893 = "_-h3" (String#8535, DoABC#2)
// _SafeStr_7894 = "_-2EZ" (String#1840, DoABC#2)
// _SafeStr_7895 = "_-3F1" (String#7613, DoABC#2)
// _SafeStr_7896 = "_-0X6" (String#4252, DoABC#2)
// _SafeStr_7897 = "_-hk" (String#23955, DoABC#2)
// _SafeStr_7898 = "_-25G" (String#19228, DoABC#2)
// _SafeStr_7899 = "_-1Jp" (String#5240, DoABC#2)
// _SafeStr_7900 = "_-2lg" (String#6997, DoABC#2)
// _SafeStr_7901 = "_-2WA" (String#20289, DoABC#2)
// _visibleCategoryId = "_-15S" (String#16673, DoABC#2)
// _SafeStr_7903 = "_-04-" (String#577, DoABC#2)
// _SafeStr_7904 = "_-2re" (String#21142, DoABC#2)
// PetsView = "_-pj" (String#8703, DoABC#2)
// ISelectorWindow = "_-0EO" (String#3836, DoABC#2)
// showCategoryGrid = "_-0XH" (String#15325, DoABC#2)
// FurniGridView = "_-1n7" (String#18429, DoABC#2)
// mainCategory = "_-JH" (String#22977, DoABC#2)
// FurniGridView = "_-2VO" (String#20257, DoABC#2)
// RoomEngine = "_-Ht" (String#2080, DoABC#2)
// setPreviewImage = "_-27B" (String#448, DoABC#2)
// GroupItem = "_-0fV" (String#15650, DoABC#2)
// GroupItem = "_-0sX" (String#16143, DoABC#2)
// tradeable = "_-3E5" (String#7597, DoABC#2)


