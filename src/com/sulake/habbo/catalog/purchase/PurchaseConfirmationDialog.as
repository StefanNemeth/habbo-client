
package com.sulake.habbo.catalog.purchase
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.habbo.communication.messages.parser.catalog.IsOfferGiftableMessageParser;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Matrix;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.habbo.catalog.viewer.IProduct;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.habbo.catalog.club.ClubBuyOfferData;
    import com.sulake.habbo.catalog.enum.ProductTypeEnum;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.components.ICheckBoxWindow;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import flash.geom.ColorTransform;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.assets.XmlAsset;
    import flash.ui.Keyboard;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.window.utils.IAlertDialog;

    public class PurchaseConfirmationDialog implements IGetImageListener, IDisposable 
    {

        private const _SafeStr_5581:int = 10;
        private const _SafeStr_5582:uint = 4293848814;
        private const _SafeStr_5583:uint = 0xFFFFFFFF;
        private const _SafeStr_5584:uint = 4291613146;

        private var _catalog:HabboCatalog;
        private var _roomEngine:IRoomEngine;
        private var _localization:ICoreLocalizationManager;
        private var _offerId:int;
        private var _pageId:int;
        private var _extraParameter:String;
        private var _friends:Array;
        private var _SafeStr_5585:IWindowContainer;
        private var _SafeStr_5586:IWindowContainer;
        private var _SafeStr_5587:int = -1;
        private var _SafeStr_5588:String = "";
        private var _SafeStr_5589:Boolean;
        private var _SafeStr_5590:Boolean;
        private var _SafeStr_5591:int;
        private var _stuffTypes:Array;
        private var _ribbonTypes:Array;
        private var _boxTypes:Array;
        private var _SafeStr_5595:int;
        private var _SafeStr_5596:int;
        private var _SafeStr_5597:int;
        private var _window:IFrameWindow;
        private var _disposed:Boolean = false;

        public function PurchaseConfirmationDialog(_arg_1:ICoreLocalizationManager)
        {
            this._ribbonTypes = [];
            this._boxTypes = [];
            super();
            this._localization = _arg_1;
        }
        public function showOffer(_arg_1:IHabboCatalog, _arg_2:IRoomEngine, _arg_3:IPurchasableOffer, _arg_4:int, _arg_5:String="", _arg_6:Array=null):void
        {
            this._catalog = (_arg_1 as HabboCatalog);
            this._roomEngine = _arg_2;
            this._offerId = _arg_3.offerId;
            this._pageId = _arg_4;
            this._extraParameter = _arg_5;
            this._friends = _arg_6;
            this.showConfirmationDialog(_arg_3);
            this._catalog.syncPlacedOfferWithPurchase(_arg_3);
        }
        public function dispose():void
        {
            if (this.disposed){
                return;
            };
            this._disposed = true;
            this._catalog = null;
            this._roomEngine = null;
            this._offerId = -1;
            this._pageId = -1;
            this._extraParameter = "";
            this._friends = null;
            if (this._window != null){
                this._window.dispose();
                this._window = null;
            };
            this._SafeStr_5585 = null;
            if (this._SafeStr_5586 != null){
                this._SafeStr_5586.dispose();
                this._SafeStr_5586 = null;
            };
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function onIsOfferGiftable(_arg_1:IsOfferGiftableMessageParser):void
        {
            if (this.disposed){
                return;
            };
            if (this._offerId != _arg_1.offerId){
                return;
            };
            this.setGiftButtonState(_arg_1.isGiftable);
        }
        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            if (_arg_1 == this._SafeStr_5591){
                this._SafeStr_5591 = 0;
                this.setImage(_arg_2, true);
            };
        }
        private function setImage(_arg_1:BitmapData, _arg_2:Boolean):void
        {
            if ((((((this._window == null)) || ((_arg_1 == null)))) || (this.disposed))){
                return;
            };
            var _local_3:IBitmapWrapperWindow = (this._window.findChildByName("product_image") as IBitmapWrapperWindow);
            if (_local_3 == null){
                return;
            };
            if (_local_3.bitmap != null){
                _local_3.bitmap.dispose();
                _local_3.bitmap = null;
            };
            if (_local_3.bitmap == null){
                _local_3.bitmap = new BitmapData(_local_3.width, _local_3.height, true, 0);
            };
            var _local_4:int = ((_local_3.width - _arg_1.width) * 0.5);
            var _local_5:int = ((_local_3.height - _arg_1.height) * 0.5);
            _local_3.bitmap.draw(_arg_1, new Matrix(1, 0, 0, 1, _local_4, _local_5));
            if (_arg_2){
                _arg_1.dispose();
            };
        }
        private function showConfirmationDialog(_arg_1:IPurchasableOffer):void
        {
            var _local_8:IProductData;
            var _local_9:IRoomEngine;
            var _local_10:ImageResult;
            var _local_11:BitmapData;
            var _local_12:int;
            var _local_13:String;
            var _local_14:String;
            var _local_15:IProduct;
            if (this._catalog == null){
                return;
            };
            if (this._window != null){
                this._window.dispose();
            };
            this.updateLocalizations(_arg_1);
            this._window = (this.createWindow("purchase_confirmation") as IFrameWindow);
            if (this._window == null){
                return;
            };
            var _local_2:IWindow = this._window.findChildByName("buy_button");
            if (_local_2 != null){
                _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onBuyButtonClick);
            };
            var _local_3:IWindow = this._window.findChildByName("gift_button");
            if (_local_3 != null){
                _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onGiftButtonClick);
            };
            var _local_4:IWindow = this._window.findChildByName("cancel_button");
            if (_local_4 != null){
                _local_4.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClose);
            };
            var _local_5:IWindow = this._window.findChildByName("header_button_close");
            if (_local_5 != null){
                _local_5.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClose);
            };
            this.setGiftButtonState(false);
            this._window.center();
            var _local_6:ITextWindow = (this._window.findChildByName("product_name") as ITextWindow);
            if (_local_6 != null){
                _local_8 = this._catalog.getProductData(_arg_1.localizationId);
                _local_6.text = (((_local_8)==null) ? "" : _local_8.name);
            };
            var _local_7:IBitmapWrapperWindow = (this._window.findChildByName("product_image") as IBitmapWrapperWindow);
            if (_local_7 != null){
                _local_9 = _arg_1.page.viewer.roomEngine;
                _local_12 = 0;
                _local_13 = "";
                _local_14 = "";
                if ((_arg_1 is Offer)){
                    _local_15 = _arg_1.productContainer.firstProduct;
                    _local_14 = _local_15.productType;
                    _local_12 = _local_15.productClassId;
                    _local_13 = _local_15.extraParam;
                }
                else {
                    if ((_arg_1 is ClubBuyOfferData)){
                        _local_14 = ProductTypeEnum._SafeStr_5023;
                    };
                };
                switch (_local_14){
                    case ProductTypeEnum._SafeStr_5017:
                        _local_10 = _local_9.getFurnitureIcon(_local_12, this);
                        break;
                    case ProductTypeEnum._SafeStr_5019:
                        _local_10 = _local_9.getWallItemIcon(_local_12, this, _local_13);
                        break;
                    case ProductTypeEnum._SafeStr_5021:
                        _local_11 = this._catalog.getPixelEffectIcon(_local_12);
                        break;
                    case ProductTypeEnum._SafeStr_5023:
                        _local_11 = this._catalog.getSubscriptionProductIcon(_local_12);
                        break;
                };
                if (_local_10 != null){
                    _local_11 = _local_10.data;
                    this._SafeStr_5591 = _local_10.id;
                };
                this.setImage(_local_11, true);
            };
        }
        private function setGiftButtonState(_arg_1:Boolean):void
        {
            if (this._window == null){
                return;
            };
            var _local_2:IButtonWindow = IButtonWindow(this._window.findChildByName("gift_button"));
            if (_arg_1){
                _local_2.enable();
            }
            else {
                _local_2.disable();
            };
        }
        private function updateLocalizations(_arg_1:IPurchasableOffer):void
        {
            if (_arg_1 == null){
                return;
            };
            var _local_2:IProductData = this._catalog.getProductData(_arg_1.localizationId);
            var _local_3:String = (((_local_2)==null) ? "" : _local_2.name);
            this._catalog.windowManager.registerLocalizationParameter("catalog.purchase.confirmation.dialog.costs", "offer_name", _local_3);
            var _local_4:BalanceAndCost = new BalanceAndCost(this._catalog, this._localization, _arg_1);
            this._catalog.windowManager.registerLocalizationParameter("catalog.purchase.confirmation.dialog.costs", "price", _local_4.cost);
            this._catalog.windowManager.registerLocalizationParameter("catalog.purchase.confirmation.dialog.amount", "amount", _local_4.balance);
            _local_4.dispose();
        }
        private function showGiftDialog():void
        {
            var _local_8:IWindow;
            var _local_9:IWindow;
            var _local_10:IWindow;
            var _local_11:IWindow;
            var _local_12:ICheckBoxWindow;
            var _local_13:IWindow;
            if (this._window != null){
                this._window.dispose();
            };
            var _local_1:GiftWrappingConfiguration = this._catalog.giftWrappingConfiguration;
            var _local_2:String = ((_local_1.isEnabled) ? "gift_wrapping" : "gift_no_wrapping");
            this._window = (this.createWindow(_local_2) as IFrameWindow);
            if (this._window == null){
                return;
            };
            this._window.center();
            var _local_3:IWindow = this._window.findChildByName("give_gift_button");
            if (_local_3 != null){
                _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onGiveGiftButtonClick);
            };
            var _local_4:IWindow = this._window.findChildByName("cancel_gifting_button");
            if (_local_4 != null){
                _local_4.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onCancelGift);
            };
            var _local_5:IWindow = this._window.findChildByName("header_button_close");
            if (_local_5 != null){
                _local_5.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onCancelGift);
            };
            var _local_6:ITextFieldWindow = (this._window.findChildByName("name_input") as ITextFieldWindow);
            if (_local_6 != null){
                _local_6.addEventListener(WindowEvent.WE_CHANGE, this.onNameInputChange);
                _local_6.addEventListener(WindowMouseEvent.WME_DOWN, this.onNameInputMouseDown);
                _local_6.addEventListener(WindowKeyboardEvent.WKE_KEY_UP, this.onNameInputKeyUp);
            };
            var _local_7:ITextFieldWindow = (this._window.findChildByName("message_input") as ITextFieldWindow);
            if (_local_7 != null){
                _local_7.addEventListener(WindowMouseEvent.WME_DOWN, this.onMessageInputMouseDown);
                _local_7.addEventListener(WindowEvent.WE_FOCUSED, this.onMessageInputFocus);
            };
            this._SafeStr_5589 = true;
            this._SafeStr_5590 = true;
            if (_local_1.isEnabled){
                _local_8 = this._window.findChildByName("ribbon_prev");
                if (_local_8 != null){
                    _local_8.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onPreviousGiftWrap);
                };
                _local_9 = this._window.findChildByName("ribbon_next");
                if (_local_9 != null){
                    _local_9.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onNextGiftWrap);
                };
                _local_10 = this._window.findChildByName("box_prev");
                if (_local_10 != null){
                    _local_10.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onPreviousGiftBox);
                };
                _local_11 = this._window.findChildByName("box_next");
                if (_local_11 != null){
                    _local_11.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onNextGiftBox);
                };
                _local_12 = (this._window.findChildByName("use_free_checkbox") as ICheckBoxWindow);
                if (_local_12 != null){
                    _local_12.addEventListener(WindowEvent.WE_SELECT, this.onFreeWrappingSelected);
                    _local_12.addEventListener(WindowEvent.WE_UNSELECTED, this.onFreeWrappingUnSelect);
                };
                _local_13 = this._window.findChildByName("use_free_text");
                if (_local_13 != null){
                    _local_13.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onGiftWrappingUseFreeTextClicked);
                };
                this._localization.registerParameter("catalog.gift_wrapping.price", "price", _local_1.price.toString());
                this._stuffTypes = _local_1.stuffTypes;
                this._boxTypes = _local_1.boxTypes;
                this._ribbonTypes = _local_1.ribbonTypes;
                this._SafeStr_5597 = this._stuffTypes[0];
                this._SafeStr_5596 = this._boxTypes[0];
                this._SafeStr_5595 = this._ribbonTypes[0];
                this.initColorGrid();
                this.updateColorGrid();
                this.updatePreview();
            };
        }
        private function updatePreview():void
        {
            if (this._SafeStr_5595 < 0){
                this._SafeStr_5595 = (this._ribbonTypes.length - 1);
            };
            if (this._SafeStr_5595 > (this._ribbonTypes.length - 1)){
                this._SafeStr_5595 = 0;
            };
            if (this._SafeStr_5596 < 0){
                this._SafeStr_5596 = (this._boxTypes.length - 1);
            };
            if (this._SafeStr_5596 > (this._boxTypes.length - 1)){
                this._SafeStr_5596 = 0;
            };
            var _local_1:int = ((this._boxTypes[this._SafeStr_5596] * 1000) + this._ribbonTypes[this._SafeStr_5595]);
            if (this._window == null){
                return;
            };
            if (this._roomEngine == null){
                return;
            };
            var _local_2:ImageResult = this._roomEngine.getFurnitureImage(this._SafeStr_5597, new Vector3d(180), 64, this, 0, _local_1.toString());
            if (_local_2 == null){
                return;
            };
            this._SafeStr_5591 = _local_2.id;
            this.setImage(_local_2.data, true);
            this.showSuggestions(false);
        }
        private function initColorGrid():void
        {
            var _local_3:int;
            var _local_4:IFurnitureData;
            var _local_5:IWindowContainer;
            var _local_6:uint;
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:Number;
            var _local_10:ColorTransform;
            if (this._window == null){
                return;
            };
            var _local_1:IItemGridWindow = (this._window.findChildByName("color_grid") as IItemGridWindow);
            _local_1.destroyGridItems();
            var _local_2:IWindowContainer = (this.createWindow("gift_palette_item") as IWindowContainer);
            for each (_local_3 in this._stuffTypes) {
                _local_4 = this._catalog.getFurnitureData(_local_3, ProductTypeEnum._SafeStr_5017);
                _local_5 = (_local_2.clone() as IWindowContainer);
                if (!((!(_local_4)) || (!(_local_5)))){
                    _local_5.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onColorItemClick);
                    _local_6 = _local_4.colours[0];
                    _local_7 = (((_local_6 >> 16) & 0xFF) / 0xFF);
                    _local_8 = (((_local_6 >> 8) & 0xFF) / 0xFF);
                    _local_9 = ((_local_6 & 0xFF) / 0xFF);
                    _local_10 = new ColorTransform(_local_7, _local_8, _local_9);
                    this.setBitmapData(_local_5, "border", "ctlg_clr_27x22_1");
                    this.setBitmapData(_local_5, "color", "ctlg_clr_27x22_2", _local_10);
                    this.setBitmapData(_local_5, "selection", "ctlg_clr_27x22_3");
                    _local_5.id = _local_3;
                    _local_1.addGridItem(_local_5);
                };
            };
        }
        private function setBitmapData(_arg_1:IWindowContainer, _arg_2:String, _arg_3:String, _arg_4:ColorTransform=null):void
        {
            if (_arg_1 == null){
                return;
            };
            var _local_5:IBitmapWrapperWindow = (_arg_1.findChildByName(_arg_2) as IBitmapWrapperWindow);
            if (_local_5 == null){
                return;
            };
            var _local_6:BitmapDataAsset = (this._catalog.assets.getAssetByName(_arg_3) as BitmapDataAsset);
            if (_local_6 == null){
                return;
            };
            var _local_7:BitmapData = (_local_6.content as BitmapData);
            if (_local_7 == null){
                return;
            };
            if (_local_5.bitmap == null){
                _local_5.bitmap = new BitmapData(_local_5.width, _local_5.height, true, 0);
            };
            _local_5.bitmap.draw(_local_7, null, _arg_4);
        }
        private function createWindow(_arg_1:String):IWindow
        {
            if ((((this._catalog.windowManager == null)) || ((this._catalog.assets == null)))){
                return (null);
            };
            var _local_2:XmlAsset = (this._catalog.assets.getAssetByName(_arg_1) as XmlAsset);
            if ((((_local_2 == null)) || ((_local_2.content == null)))){
                return (null);
            };
            return (this._catalog.windowManager.buildFromXML((_local_2.content as XML)));
        }
        private function giveGift():void
        {
            var _local_1:ITextFieldWindow = (this._window.findChildByName("name_input") as ITextFieldWindow);
            if (_local_1 == null){
                return;
            };
            var _local_2:String = _local_1.text;
            var _local_3:ITextFieldWindow = (this._window.findChildByName("message_input") as ITextFieldWindow);
            var _local_4:String = (((_local_3)==null) ? "" : _local_3.text);
            var _local_5:ICheckBoxWindow = (this._window.findChildByName("use_free_checkbox") as ICheckBoxWindow);
            var _local_6:Boolean = (((_local_5)==null) ? false : _local_5.isSelected);
            var _local_7:int = ((_local_6) ? 0 : this._SafeStr_5597);
            var _local_8:int = ((_local_6) ? 0 : this._boxTypes[this._SafeStr_5596]);
            var _local_9:int = ((_local_6) ? 0 : this._ribbonTypes[this._SafeStr_5595]);
            this._catalog.purchaseProductAsGift(this._pageId, this._offerId, this._extraParameter, _local_2, _local_4, _local_7, _local_8, _local_9);
        }
        private function onBuyButtonClick(_arg_1:WindowEvent):void
        {
            this._catalog.purchaseProduct(this._pageId, this._offerId, this._extraParameter);
            this.dispose();
        }
        private function onGiftButtonClick(_arg_1:WindowEvent):void
        {
            this.showGiftDialog();
        }
        private function onClose(_arg_1:WindowEvent):void
        {
            this._catalog.resetPlacedOfferData();
            this.dispose();
        }
        private function onGiveGiftButtonClick(_arg_1:WindowEvent):void
        {
            this.giveGift();
            this.enableGiftButton(false);
            this._catalog.resetPlacedOfferData();
        }
        private function onCancelGift(_arg_1:WindowEvent):void
        {
            this._catalog.resetPlacedOfferData();
            this.dispose();
        }
        private function onPreviousGiftWrap(_arg_1:WindowEvent):void
        {
            this._SafeStr_5595--;
            this.updatePreview();
        }
        private function onNextGiftWrap(_arg_1:WindowEvent):void
        {
            this._SafeStr_5595++;
            this.updatePreview();
        }
        private function onPreviousGiftBox(_arg_1:WindowEvent):void
        {
            this._SafeStr_5596--;
            this.updatePreview();
        }
        private function onNextGiftBox(_arg_1:WindowEvent):void
        {
            this._SafeStr_5596++;
            this.updatePreview();
        }
        private function onGiftWrappingUseFreeTextClicked(_arg_1:WindowEvent):void
        {
            this.toggleCheckbox();
        }
        private function toggleCheckbox():void
        {
            if (this._window == null){
                return;
            };
            var _local_1:ICheckBoxWindow = (this._window.findChildByName("use_free_checkbox") as ICheckBoxWindow);
            if (_local_1 == null){
                return;
            };
            if (_local_1.isSelected){
                _local_1.unselect();
            }
            else {
                _local_1.select();
            };
        }
        private function onNameInputChange(_arg_1:WindowEvent):void
        {
            var _local_5:String;
            var _local_2:ITextFieldWindow = (_arg_1.target as ITextFieldWindow);
            if (_local_2 == null){
                return;
            };
            if (this._SafeStr_5588 == _local_2.text){
                return;
            };
            var _local_3:String = _local_2.text.toLowerCase();
            var _local_4:Array = [];
            for each (_local_5 in this._friends) {
                if (_local_5.toLowerCase().search(_local_3) != -1){
                    _local_4.push(_local_5);
                };
                if (_local_4.length >= this._SafeStr_5581) break;
            };
            this.updateSuggestions(_local_4);
            this._SafeStr_5588 = _local_2.text;
        }
        private function onNameInputMouseDown(_arg_1:WindowEvent):void
        {
            var _local_2:ITextFieldWindow = (_arg_1.target as ITextFieldWindow);
            if (_local_2 == null){
                return;
            };
            this.showSuggestions(false);
            if (this._SafeStr_5589){
                _local_2.text = "";
                this._SafeStr_5589 = false;
            };
        }
        private function onNameInputKeyUp(_arg_1:WindowEvent):void
        {
            var _local_2:WindowKeyboardEvent = (_arg_1 as WindowKeyboardEvent);
            switch (_local_2.keyCode){
                case Keyboard.UP:
                    this.highlightSuggestion((this._SafeStr_5587 - 1));
                    return;
                case Keyboard.DOWN:
                    this.highlightSuggestion((this._SafeStr_5587 + 1));
                    return;
                case Keyboard.ENTER:
                    this.selectHighlighted();
                    return;
                case Keyboard.TAB:
                    this.focusMessageField();
                    return;
            };
        }
        private function focusMessageField():void
        {
            if (this._window == null){
                return;
            };
            var _local_1:ITextFieldWindow = (this._window.findChildByName("message_input") as ITextFieldWindow);
            if (_local_1 == null){
                return;
            };
            _local_1.visible = true;
            _local_1.focus();
        }
        private function selectHighlighted():void
        {
            if ((((this._SafeStr_5585 == null)) || (!(this._SafeStr_5585.visible)))){
                return;
            };
            var _local_1:IItemListWindow = (this._SafeStr_5585.findChildByName("suggestion_list") as IItemListWindow);
            if (_local_1 == null){
                return;
            };
            var _local_2:IWindowContainer = (_local_1.getListItemAt(this._SafeStr_5587) as IWindowContainer);
            if (_local_2 == null){
                return;
            };
            var _local_3:ITextWindow = (_local_2.findChildByName("name_text") as ITextWindow);
            if (_local_3 == null){
                return;
            };
            this.setReceiverName(_local_3.text);
            this.showSuggestions(false);
        }
        private function showSuggestions(_arg_1:Boolean):void
        {
            if (this._SafeStr_5585 == null){
                return;
            };
            this._SafeStr_5585.visible = _arg_1;
            if (!_arg_1){
                this.showMessageInput(true);
            };
        }
        private function showMessageInput(_arg_1:Boolean):void
        {
            var _local_2:ITextFieldWindow = (this._window.findChildByName("message_input") as ITextFieldWindow);
            if (_local_2 != null){
                _local_2.visible = _arg_1;
            };
        }
        private function onMessageInputMouseDown(_arg_1:WindowEvent):void
        {
            var _local_2:ITextFieldWindow;
            if (this._SafeStr_5590){
                _local_2 = (_arg_1.target as ITextFieldWindow);
                if (_local_2 != null){
                    _local_2.text = "";
                    this._SafeStr_5590 = false;
                };
            };
        }
        private function onMessageInputFocus(_arg_1:WindowEvent):void
        {
            this.showSuggestions(false);
        }
        private function onFreeWrappingSelected(_arg_1:WindowEvent):void
        {
            this.showSelectors(false);
        }
        private function onFreeWrappingUnSelect(_arg_1:WindowEvent):void
        {
            this.showSelectors(true);
        }
        private function showSelectors(_arg_1:Boolean):void
        {
            if (this._window == null){
                return;
            };
            var _local_2:IWindowContainer = (this._window.findChildByName("mask") as IWindowContainer);
            if (_local_2 == null){
                return;
            };
            _local_2.visible = !(_arg_1);
        }
        private function updateSuggestions(_arg_1:Array):void
        {
            var _local_4:String;
            var _local_5:IWindowContainer;
            var _local_6:ITextWindow;
            if (this._SafeStr_5585 == null){
                this._SafeStr_5585 = (this._window.findChildByName("suggestion_container") as IWindowContainer);
            };
            if (this._SafeStr_5586 == null){
                this._SafeStr_5586 = (this.createWindow("suggestion_list_item") as IWindowContainer);
            };
            if ((((this._SafeStr_5585 == null)) || ((this._SafeStr_5586 == null)))){
                return;
            };
            var _local_2:IItemListWindow = (this._SafeStr_5585.findChildByName("suggestion_list") as IItemListWindow);
            if (_local_2 == null){
                return;
            };
            _local_2.removeListItems();
            if (_arg_1.length == 0){
                this.showSuggestions(false);
                return;
            };
            this.showSuggestions(true);
            var _local_3:int;
            for each (_local_4 in _arg_1) {
                _local_5 = (this._SafeStr_5586.clone() as IWindowContainer);
                if (_local_5 != null){
                    _local_5.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onSuggestionsClick);
                    _local_5.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onSuggestionsMouseOver);
                    _local_6 = (_local_5.findChildByName("name_text") as ITextWindow);
                    if (_local_6 != null){
                        _local_6.text = _local_4;
                        _local_2.addListItem(_local_5);
                    };
                    _local_5.color = this.getColor(_local_3);
                    _local_3++;
                };
            };
            this.showMessageInput((_arg_1.length < 2));
            this.highlightSuggestion(0);
        }
        private function onSuggestionsClick(_arg_1:WindowEvent):void
        {
            var _local_2:IWindowContainer = (_arg_1.target as IWindowContainer);
            if (_local_2 == null){
                return;
            };
            var _local_3:ITextWindow = (_local_2.findChildByName("name_text") as ITextWindow);
            if (_local_3 == null){
                return;
            };
            this.setReceiverName(_local_3.text);
            this.showSuggestions(false);
        }
        private function onSuggestionsMouseOver(_arg_1:WindowEvent):void
        {
            var _local_2:IWindowContainer = (_arg_1.target as IWindowContainer);
            if (_local_2 == null){
                return;
            };
            var _local_3:IItemListWindow = (this._SafeStr_5585.findChildByName("suggestion_list") as IItemListWindow);
            if (_local_3 == null){
                return;
            };
            this.highlightSuggestion(_local_3.getListItemIndex(_local_2));
        }
        private function highlightSuggestion(_arg_1:int):void
        {
            var _local_3:IWindowContainer;
            if (this._SafeStr_5585 == null){
                return;
            };
            var _local_2:IItemListWindow = (this._SafeStr_5585.findChildByName("suggestion_list") as IItemListWindow);
            if (_local_2 == null){
                return;
            };
            _local_3 = (_local_2.getListItemAt(this._SafeStr_5587) as IWindowContainer);
            if (_local_3 != null){
                _local_3.color = this.getColor(this._SafeStr_5587);
            };
            this._SafeStr_5587 = _arg_1;
            if (this._SafeStr_5587 < 0){
                this._SafeStr_5587 = (_local_2.numListItems - 1);
            };
            if (this._SafeStr_5587 >= _local_2.numListItems){
                this._SafeStr_5587 = 0;
            };
            _local_3 = (_local_2.getListItemAt(this._SafeStr_5587) as IWindowContainer);
            if (_local_3 != null){
                _local_3.color = this._SafeStr_5584;
            };
        }
        private function getColor(_arg_1:int):uint
        {
            return (((((_arg_1 % 2) == 0)) ? this._SafeStr_5582 : this._SafeStr_5583));
        }
        private function setReceiverName(_arg_1:String):void
        {
            if (this._window == null){
                return;
            };
            var _local_2:ITextFieldWindow = (this._window.findChildByName("name_input") as ITextFieldWindow);
            if (_local_2 == null){
                return;
            };
            _local_2.text = _arg_1;
            this.focusMessageField();
        }
        private function onColorItemClick(_arg_1:WindowEvent):void
        {
            this._SafeStr_5597 = _arg_1.target.id;
            this.updateColorGrid();
            this.updatePreview();
        }
        private function updateColorGrid():void
        {
            var _local_2:IWindowContainer;
            var _local_3:IBitmapWrapperWindow;
            if (this._window == null){
                return;
            };
            var _local_1:IItemGridWindow = (this._window.findChildByName("color_grid") as IItemGridWindow);
            if (_local_1 == null){
                return;
            };
            var _local_4:int;
            while (_local_4 < _local_1.numGridItems) {
                _local_2 = (_local_1.getGridItemAt(_local_4) as IWindowContainer);
                if (_local_2 != null){
                    _local_3 = (_local_2.findChildByName("selection") as IBitmapWrapperWindow);
                    if (_local_3 != null){
                        _local_3.visible = (_local_2.id == this._SafeStr_5597);
                    };
                };
                _local_4++;
            };
        }
        public function receiverNotFound():void
        {
            if (this.disposed){
                return;
            };
            this.enableGiftButton(true);
            if (((!(this._catalog)) || (!(this._catalog.windowManager)))){
                return;
            };
            this._catalog.windowManager.alert(("$" + "{catalog.gift_wrapping.receiver_not_found.title}"), ("$" + "{catalog.gift_wrapping.receiver_not_found.info}"), 0, this.alertHandler);
        }
        private function alertHandler(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
            this.enableGiftButton(true);
        }
        private function enableGiftButton(_arg_1:Boolean):void
        {
            if (this._window == null){
                return;
            };
            var _local_2:IButtonWindow = (this._window.findChildByName("give_gift_button") as IButtonWindow);
            if (_local_2 != null){
                if (_arg_1){
                    _local_2.enable();
                }
                else {
                    _local_2.disable();
                };
            };
        }
        public function notEnoughCredits():void
        {
            if (this.disposed){
                return;
            };
            if (this._window == null){
                return;
            };
            this.enableGiftButton(true);
            var _local_1:ICheckBoxWindow = (this._window.findChildByName("use_free_checkbox") as ICheckBoxWindow);
            if (_local_1 != null){
                _local_1.select();
            };
        }

    }
}//package com.sulake.habbo.catalog.purchase

// ImageResult = "_-31w" (String#21576, DoABC#2)
// IFurnitureData = "_-pe" (String#8701, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// IProductData = "_-0jc" (String#4494, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// PurchaseConfirmationDialog = "_-1qd" (String#5866, DoABC#2)
// GiftWrappingConfiguration = "_-0BE" (String#14495, DoABC#2)
// IPurchasableOffer = "_-2RV" (String#6596, DoABC#2)
// ClubBuyOfferData = "_-2XP" (String#6709, DoABC#2)
// Offer = "_-0m2" (String#4550, DoABC#2)
// ProductTypeEnum = "_-11z" (String#16536, DoABC#2)
// ITextFieldWindow = "_-3EL" (String#2027, DoABC#2)
// ICheckBoxWindow = "_-1zu" (String#1793, DoABC#2)
// IItemGridWindow = "_-265" (String#1809, DoABC#2)
// WindowKeyboardEvent = "_-0Di" (String#1433, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// IsOfferGiftableMessageParser = "_-0cA" (String#4346, DoABC#2)
// BalanceAndCost = "_-sU" (String#8747, DoABC#2)
// IGetImageListener = "_-2i7" (String#6909, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// setImage = "_-1NZ" (String#603, DoABC#2)
// WME_DOWN = "_-hL" (String#23944, DoABC#2)
// _friends = "_-02K" (String#576, DoABC#2)
// addGridItem = "_-2vh" (String#7192, DoABC#2)
// _offerId = "_-0i7" (String#125, DoABC#2)
// offerId = "_-9g" (String#928, DoABC#2)
// localizationId = "_-0nF" (String#4575, DoABC#2)
// getFurnitureData = "_-40" (String#7745, DoABC#2)
// productClassId = "_-02F" (String#3609, DoABC#2)
// productType = "_-Sd" (String#8259, DoABC#2)
// extraParam = "_-AM" (String#7874, DoABC#2)
// firstProduct = "_-KM" (String#8089, DoABC#2)
// _SafeStr_5017 = "_-1-l" (String#16457, DoABC#2)
// _SafeStr_5019 = "_-Ok" (String#23195, DoABC#2)
// getPixelEffectIcon = "_-1HA" (String#5192, DoABC#2)
// _SafeStr_5021 = "_-h-" (String#23930, DoABC#2)
// getSubscriptionProductIcon = "_-dz" (String#8484, DoABC#2)
// _SafeStr_5023 = "_-hJ" (String#23942, DoABC#2)
// _pageId = "_-251" (String#366, DoABC#2)
// onClose = "_-2Ts" (String#54, DoABC#2)
// WE_CHANGE = "_-1sp" (String#18670, DoABC#2)
// unselect = "_-2aK" (String#6764, DoABC#2)
// showOffer = "_-2nW" (String#20980, DoABC#2)
// purchaseProduct = "_-na" (String#24175, DoABC#2)
// _extraParameter = "_-1eD" (String#1731, DoABC#2)
// _SafeStr_5581 = "_-1Iu" (String#17233, DoABC#2)
// _SafeStr_5582 = "_-2ih" (String#1929, DoABC#2)
// _SafeStr_5583 = "_-2HF" (String#1846, DoABC#2)
// _SafeStr_5584 = "_-3IQ" (String#7678, DoABC#2)
// _SafeStr_5585 = "_-1C3" (String#16945, DoABC#2)
// _SafeStr_5586 = "_-xN" (String#24584, DoABC#2)
// _SafeStr_5587 = "_-20X" (String#19031, DoABC#2)
// _SafeStr_5588 = "_-0n-" (String#15939, DoABC#2)
// _SafeStr_5589 = "_-2sX" (String#21181, DoABC#2)
// _SafeStr_5590 = "_-0kU" (String#15848, DoABC#2)
// _SafeStr_5591 = "_-1fm" (String#18127, DoABC#2)
// _stuffTypes = "_-ya" (String#2230, DoABC#2)
// _ribbonTypes = "_-1RU" (String#1685, DoABC#2)
// _boxTypes = "_-2Pq" (String#1874, DoABC#2)
// _SafeStr_5595 = "_-0NH" (String#14966, DoABC#2)
// _SafeStr_5596 = "_-2Rf" (String#20107, DoABC#2)
// _SafeStr_5597 = "_-2S9" (String#20126, DoABC#2)
// showConfirmationDialog = "_-2vw" (String#21308, DoABC#2)
// syncPlacedOfferWithPurchase = "_-2mj" (String#20950, DoABC#2)
// onIsOfferGiftable = "_-0hn" (String#4463, DoABC#2)
// setGiftButtonState = "_-0KU" (String#14859, DoABC#2)
// isGiftable = "_-38z" (String#21842, DoABC#2)
// updateLocalizations = "_-1dP" (String#18031, DoABC#2)
// onBuyButtonClick = "_-ia" (String#23981, DoABC#2)
// onGiftButtonClick = "_-39e" (String#21868, DoABC#2)
// showGiftDialog = "_-CT" (String#22704, DoABC#2)
// giftWrappingConfiguration = "_-19O" (String#16832, DoABC#2)
// isEnabled = "_-2ri" (String#21145, DoABC#2)
// onGiveGiftButtonClick = "_-5B" (String#22428, DoABC#2)
// onCancelGift = "_-1X6" (String#17781, DoABC#2)
// onNameInputChange = "_-39u" (String#21881, DoABC#2)
// onNameInputMouseDown = "_-1w9" (String#18804, DoABC#2)
// WKE_KEY_UP = "_-0aL" (String#15451, DoABC#2)
// onNameInputKeyUp = "_-3J7" (String#22245, DoABC#2)
// onMessageInputMouseDown = "_-22j" (String#19121, DoABC#2)
// WE_FOCUSED = "_-1ay" (String#17932, DoABC#2)
// onMessageInputFocus = "_-1Y6" (String#17818, DoABC#2)
// onPreviousGiftWrap = "_-hF" (String#23940, DoABC#2)
// onPreviousGiftBox = "_-LA" (String#23052, DoABC#2)
// onNextGiftBox = "_-2fa" (String#20673, DoABC#2)
// WE_SELECT = "_-335" (String#21624, DoABC#2)
// onFreeWrappingSelected = "_-2hX" (String#20754, DoABC#2)
// WE_UNSELECTED = "_-1D" (String#16982, DoABC#2)
// onFreeWrappingUnSelect = "_-36x" (String#21764, DoABC#2)
// onGiftWrappingUseFreeTextClicked = "_-1cZ" (String#17992, DoABC#2)
// stuffTypes = "_-1BP" (String#16914, DoABC#2)
// boxTypes = "_-P9" (String#23213, DoABC#2)
// ribbonTypes = "_-28J" (String#19343, DoABC#2)
// initColorGrid = "_-36y" (String#21765, DoABC#2)
// updateColorGrid = "_-07s" (String#14358, DoABC#2)
// updatePreview = "_-0hB" (String#4449, DoABC#2)
// showSuggestions = "_-1On" (String#17459, DoABC#2)
// onColorItemClick = "_-0mI" (String#15907, DoABC#2)
// colours = "_-2hm" (String#6902, DoABC#2)
// setBitmapData = "_-mn" (String#24142, DoABC#2)
// giveGift = "_-2ZV" (String#20418, DoABC#2)
// purchaseProductAsGift = "_-0Dk" (String#14597, DoABC#2)
// resetPlacedOfferData = "_-1cp" (String#18004, DoABC#2)
// enableGiftButton = "_-ws" (String#24564, DoABC#2)
// toggleCheckbox = "_-1XG" (String#17787, DoABC#2)
// updateSuggestions = "_-2YH" (String#20368, DoABC#2)
// highlightSuggestion = "_-1ZO" (String#17866, DoABC#2)
// selectHighlighted = "_-n9" (String#24161, DoABC#2)
// focusMessageField = "_-0sP" (String#16140, DoABC#2)
// setReceiverName = "_-33p" (String#21652, DoABC#2)
// showMessageInput = "_-1tB" (String#18686, DoABC#2)
// showSelectors = "_-0S3" (String#15138, DoABC#2)
// removeListItems = "_-aG" (String#8425, DoABC#2)
// onSuggestionsClick = "_-30S" (String#21519, DoABC#2)
// onSuggestionsMouseOver = "_-2tS" (String#21219, DoABC#2)
// getColor = "_-07L" (String#1406, DoABC#2)
// getListItemIndex = "_-6Q" (String#7792, DoABC#2)
// getGridItemAt = "_-B9" (String#7890, DoABC#2)
// receiverNotFound = "_-79" (String#22507, DoABC#2)
// alertHandler = "_-2cB" (String#6798, DoABC#2)
// notEnoughCredits = "_-0aV" (String#15455, DoABC#2)


