
package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.avatar.pets.IPetDataListener;
    import com.sulake.habbo.avatar.IPetImageListener;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.avatar.pets.IPetData;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
    import com.sulake.habbo.avatar.pets.IPetColor;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetPurchaseOverrideEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColoursEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetsInitializedEvent;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColourIndexEvent;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetApproveNameResultEvent;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetSellablePetBreedsEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.SellablePetBreedData;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.avatar.enum.AvatarAction;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.geom.Matrix;

    public class PetsCatalogWidget extends CatalogWidget implements ICatalogWidget, IPetDataListener, IPetImageListener 
    {

        private var _offers:Map;
        private var _name:String;
        private var _SafeStr_10396:int = -1;
        private var _SafeStr_10570:int = 0;
        private var _selectedColorIndex:int = 0;
        private var _SafeStr_10398:String;
        private var _SafeStr_10399:Boolean = false;
        private var _SafeStr_10400:Array;
        private var _SafeStr_10572:Array;
        private var _disposed:Boolean = false;

        public function PetsCatalogWidget(_arg_1:IWindowContainer)
        {
            super(_arg_1);
        }
        override public function dispose():void
        {
            var _local_1:HabboCatalog;
            if (this._disposed){
                return;
            };
            if (((((page) && (page.viewer))) && (page.viewer.catalog))){
                _local_1 = (page.viewer.catalog as HabboCatalog);
                if (((_local_1) && (_local_1.avatarRenderManager))){
                    _local_1.avatarRenderManager.removePetImageListener(this);
                    if (_local_1.avatarRenderManager.petDataManager){
                        _local_1.avatarRenderManager.petDataManager.removeListener(this);
                    };
                };
            };
            this._SafeStr_10399 = false;
            this._offers.dispose();
            this._offers = null;
            this._SafeStr_10400 = null;
            this._SafeStr_10572 = null;
            super.dispose();
            this._disposed = true;
        }
        override public function init():Boolean
        {
            var _local_4:HabboCatalog;
            var _local_5:IPetData;
            if (!super.init()){
                return (false);
            };
            this._SafeStr_10399 = false;
            var _local_1:IWindow = window.findChildByName("ctlg_buy_button");
            var _local_2:ITextFieldWindow = (window.findChildByName("name_input_text") as ITextFieldWindow);
            if (_local_2 == null){
                return (false);
            };
            _local_2.addEventListener(WindowEvent.WE_CHANGE, this.onTextWindowEvent);
            this._offers = new Map();
            if (page.offers.length == 0){
                return (false);
            };
            var _local_3:Offer = page.offers[0];
            this._SafeStr_10396 = this.getPetTypeIndexFromProduct(_local_3.localizationId);
            if (this._SafeStr_10396 >= 8){
                return (false);
            };
            this.updateAvailableBreeds(_local_3.localizationId);
            this._SafeStr_10398 = _local_3.localizationId;
            this._SafeStr_10572 = [];
            if (((((page) && (page.viewer))) && (page.viewer.catalog))){
                _local_4 = (page.viewer.catalog as HabboCatalog);
                if (((((_local_4) && (_local_4.avatarRenderManager))) && (_local_4.avatarRenderManager.petDataManager))){
                    _local_5 = _local_4.avatarRenderManager.petDataManager.getPetData(this._SafeStr_10396, this);
                    if (_local_5){
                        this._SafeStr_10572 = _local_5.colors;
                        if (this._SafeStr_10572 == null){
                            this._SafeStr_10572 = [];
                        };
                    };
                };
            };
            this._offers.add(this._SafeStr_10396, _local_3);
            events.addEventListener(WidgetEvent.CWE_SELECT_PRODUCT, this.onSelectProduct);
            events.addEventListener(WidgetEvent.CWE_COLOUR_INDEX, this.onColourIndex);
            events.addEventListener(WidgetEvent.CWE_APPROVE_RESULT, this.onApproveNameResult);
            events.addEventListener(WidgetEvent.CWE_WIDGETS_INITIALIZED, this.onWidgetsInitialized);
            events.addEventListener(WidgetEvent.CWE_SELLABLE_PET_BREEDS, this.onSellablePetBreeds);
            return (true);
        }
        private function onWidgetsInitialized(_arg_1:CatalogWidgetsInitializedEvent=null):void
        {
            var _local_4:IPetColor;
            if (this._disposed){
                return;
            };
            events.dispatchEvent(new CatalogWidgetPurchaseOverrideEvent(this.onPurchase));
            var _local_2:Offer = this._offers.getWithIndex(0);
            if (_local_2 != null){
                events.dispatchEvent(new SelectProductEvent(_local_2));
            };
            var _local_3:Array = [];
            for each (_local_4 in this._SafeStr_10572) {
                _local_3.push(_local_4.rgb);
            };
            events.dispatchEvent(new CatalogWidgetColoursEvent(_local_3, "ctlg_clr_27x22_1", "ctlg_clr_27x22_2", "ctlg_clr_27x22_3"));
        }
        private function onPurchase(_arg_1:WindowEvent):void
        {
            if (this._SafeStr_10399){
                Logger.log("* Cannot buy a pet, pending previous name approval.");
            };
            if (this.getPurchaseParameters() == ""){
                return;
            };
            this._SafeStr_10399 = true;
            (page.viewer.catalog as HabboCatalog).approveName(this._name, 1);
        }
        public function onDropMenuEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:int;
            if (_arg_1.type == WindowEvent.WE_SELECTED){
                _local_3 = IDropMenuWindow(_arg_2).selection;
                if ((((this._SafeStr_10400 == null)) || ((_local_3 >= this._SafeStr_10400.length)))){
                    return;
                };
                this._SafeStr_10570 = _local_3;
                this.updateImage();
            };
        }
        private function onTextWindowEvent(_arg_1:WindowEvent):void
        {
            var _local_2:ITextFieldWindow = (_arg_1.target as ITextFieldWindow);
            if (_local_2 == null){
                return;
            };
            this._name = _local_2.text;
        }
        private function onSelectProduct(_arg_1:SelectProductEvent):void
        {
            if (_arg_1 == null){
                return;
            };
            this.updateImage();
        }
        private function onColourIndex(_arg_1:CatalogWidgetColourIndexEvent):void
        {
            if (_arg_1 == null){
                return;
            };
            this._selectedColorIndex = _arg_1.index;
            if ((((this._selectedColorIndex < 0)) || ((this._selectedColorIndex > this._SafeStr_10572.length)))){
                this._selectedColorIndex = 0;
            };
            this.updateImage();
        }
        private function onApproveNameResult(event:CatalogWidgetApproveNameResultEvent):void
        {
            if ((((event == null)) || (!(this._SafeStr_10399)))){
                return;
            };
            this._SafeStr_10399 = false;
            var nameValidationInfo:String = event.nameValidationInfo;
            switch (event.result){
                case 1:
                    page.viewer.catalog.windowManager.alert("${catalog.alert.purchaseerror.title}", this.constructErrorMessage("long", nameValidationInfo), 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                    {
                        _arg_1.dispose();
                    });
                    return;
                case 2:
                    page.viewer.catalog.windowManager.alert("${catalog.alert.purchaseerror.title}", this.constructErrorMessage("short", nameValidationInfo), 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                    {
                        _arg_1.dispose();
                    });
                    return;
                case 3:
                    page.viewer.catalog.windowManager.alert("${catalog.alert.purchaseerror.title}", this.constructErrorMessage("chars", nameValidationInfo), 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                    {
                        _arg_1.dispose();
                    });
                    return;
                case 4:
                    page.viewer.catalog.windowManager.alert("${catalog.alert.purchaseerror.title}", this.constructErrorMessage("bobba", nameValidationInfo), 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                    {
                        _arg_1.dispose();
                    });
                    return;
            };
            var p:String = this.getPurchaseParameters();
            if (p == ""){
                Logger.log("* Not enough information to buy a pet!");
                return;
            };
            Logger.log(("* Will buy pet as " + p));
            (page.viewer.catalog as HabboCatalog).showPurchaseConfirmation(this._offers.getWithIndex(0), page.pageId, p);
        }
        private function constructErrorMessage(_arg_1:String, _arg_2:String):String
        {
            var _local_3:ICoreLocalizationManager = (page.viewer.catalog as HabboCatalog).localization;
            var _local_4:String = ("catalog.alert.petname." + _arg_1);
            var _local_5 = (_local_4 + ".additionalInfo");
            _local_3.registerParameter(_local_5, "additional_info", _arg_2);
            var _local_6:String = _local_3.getKey(_local_4);
            var _local_7:String = _local_3.getKey(_local_5);
            if (((((((!((_arg_2 == null))) && ((_arg_2.length > 0)))) && (!((_local_7 == null))))) && ((_local_7.length > 0)))){
                _local_6 = _local_7;
            };
            return (_local_6);
        }
        private function onSellablePetBreeds(_arg_1:CatalogWidgetSellablePetBreedsEvent):void
        {
            if (_arg_1.productCode == this._SafeStr_10398){
                this._SafeStr_10400 = this.parseSellableBreeds(_arg_1.sellableBreeds);
                this._SafeStr_10570 = 0;
                this.updateBreedSelections();
            };
        }
        private function parseSellableBreeds(_arg_1:Array):Array
        {
            var _local_3:SellablePetBreedData;
            if (!_arg_1){
                return (null);
            };
            var _local_2:Array = new Array();
            for each (_local_3 in _arg_1) {
                if ((((_local_3.type == this._SafeStr_10396)) && (_local_3.sellable))){
                    _local_2.push(_local_3.breed);
                };
            };
            return (_local_2);
        }
        private function updateBreedSelections():void
        {
            var _local_5:int;
            var _local_1:ICoreLocalizationManager = (page.viewer.catalog as HabboCatalog).localization;
            var _local_2:Array = new Array();
            var _local_3:int;
            while (_local_3 < this._SafeStr_10400.length) {
                _local_5 = (this._SafeStr_10400[_local_3] as int);
                _local_2.push(_local_1.getKey(this.getRaceLocalizationKey(this._SafeStr_10396, _local_5), this.getRaceLocalizationKey(this._SafeStr_10396, _local_5)));
                _local_3++;
            };
            var _local_4:IDropMenuWindow = (window.findChildByName("type_drop_menu") as IDropMenuWindow);
            if (_local_4 == null){
                return;
            };
            if (_local_2.length > 1){
                _local_4.populate(_local_2);
                _local_4.selection = 0;
                _local_4.procedure = this.onDropMenuEvent;
                _local_4.visible = true;
            }
            else {
                _local_4.visible = false;
            };
            this.updateImage();
        }
        private function updateImage():void
        {
            var _local_7:IPetColor;
            var _local_1:Offer = this._offers.getWithIndex(0);
            if (_local_1 == null){
                return;
            };
            if ((((this._SafeStr_10400 == null)) || ((this._SafeStr_10570 >= this._SafeStr_10400.length)))){
                return;
            };
            var _local_2:uint;
            if ((((this._selectedColorIndex >= 0)) && ((this._selectedColorIndex < this._SafeStr_10572.length)))){
                _local_7 = (this._SafeStr_10572[this._selectedColorIndex] as IPetColor);
                if (_local_7 != null){
                    _local_2 = _local_7.rgb;
                };
            };
            var _local_3:int = (this._SafeStr_10400[this._SafeStr_10570] as int);
            var _local_4:IAvatarImage = (page.viewer.catalog as HabboCatalog).avatarRenderManager.createPetImage(this._SafeStr_10396, _local_3, _local_2, AvatarScaleType._SafeStr_4336, this);
            if (_local_4 == null){
                return;
            };
            _local_4.initActionAppends();
            _local_4.appendAction(AvatarAction._SafeStr_4479, AvatarAction._SafeStr_9995);
            _local_4.endActionAppends();
            _local_4.setDirection(AvatarSetType._SafeStr_4457, 2);
            this.setPreviewImage(_local_4.getCroppedImage(AvatarSetType._SafeStr_4457), true);
            _local_4.dispose();
            var _local_5:ICoreLocalizationManager = (page.viewer.catalog as HabboCatalog).localization;
            var _local_6:ITextWindow = (_window.findChildByName("ctlg_price_credits") as ITextWindow);
            if (_local_6 != null){
                _local_5.registerParameter("catalog.purchase.price.credits", "credits", String(_local_1.priceInCredits));
                _local_6.caption = "${catalog.purchase.price.credits}";
            };
        }
        private function getPurchaseParameters():String
        {
            if ((((this._name == null)) || ((this._name.length == 0)))){
                page.viewer.catalog.windowManager.alert("${catalog.alert.purchaseerror.title}", "${catalog.alert.petname.empty}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                {
                    _arg_1.dispose();
                });
                return ("");
            };
            if ((((this._SafeStr_10400 == null)) || ((this._SafeStr_10570 >= this._SafeStr_10400.length)))){
                return ("");
            };
            if (this._selectedColorIndex >= this._SafeStr_10572.length){
                return ("");
            };
            var petColor:IPetColor = (this._SafeStr_10572[this._selectedColorIndex] as IPetColor);
            var color:uint = petColor.rgb;
            var breed:int = (this._SafeStr_10400[this._SafeStr_10570] as int);
            var p:String = ((((this._name + String.fromCharCode(10)) + breed) + String.fromCharCode(10)) + this.addZeroPadding(color.toString(16).toUpperCase(), 6));
            return (p);
        }
        private function setPreviewImage(_arg_1:BitmapData, _arg_2:Boolean):void
        {
            var _local_3:IBitmapWrapperWindow;
            var _local_4:int;
            var _local_5:BitmapData;
            var _local_6:Point;
            if (!window.disposed){
                if (_arg_1 == null){
                    _arg_1 = new BitmapData(1, 1);
                    _arg_2 = true;
                };
                _local_3 = (window.findChildByName("ctlg_teaserimg_1") as IBitmapWrapperWindow);
                if (_local_3 != null){
                    if (_local_3.bitmap == null){
                        _local_3.bitmap = new BitmapData(_local_3.width, _local_3.height, true, 0xFFFFFF);
                    };
                    _local_3.bitmap.fillRect(_local_3.bitmap.rect, 0xFFFFFF);
                    _local_4 = 2;
                    _local_5 = new BitmapData((_arg_1.width * _local_4), (_arg_1.height * _local_4), true, 0xFFFFFF);
                    _local_5.draw(_arg_1, new Matrix(_local_4, 0, 0, _local_4));
                    _local_6 = new Point(((_local_3.width - _local_5.width) / 2), ((_local_3.height - _local_5.height) / 2));
                    _local_3.bitmap.copyPixels(_local_5, _local_5.rect, _local_6, null, null, true);
                    _local_3.invalidate();
                    _local_5.dispose();
                };
            };
            if (_arg_2){
                _arg_1.dispose();
            };
        }
        private function getPetTypeIndexFromProduct(_arg_1:String):int
        {
            if (_arg_1.length == 0){
                return (0);
            };
            var _local_2:int;
            _local_2 = (_arg_1.length - 1);
            while (_local_2 >= 0) {
                if (isNaN(parseInt(_arg_1.charAt(_local_2)))) break;
                _local_2--;
            };
            if (_local_2 > 0){
                return (int(_arg_1.substring((_local_2 + 1))));
            };
            return (-1);
        }
        private function getRaceLocalizationKey(_arg_1:int, _arg_2:int):String
        {
            return (((("pet.breed." + _arg_1) + ".") + _arg_2));
        }
        private function addZeroPadding(_arg_1:String, _arg_2:int):String
        {
            while (_arg_1.length < _arg_2) {
                _arg_1 = ("0" + _arg_1);
            };
            return (_arg_1);
        }
        private function updateAvailableBreeds(_arg_1:String):void
        {
            var _local_2:Array;
            if (this._SafeStr_10400 == null){
                _local_2 = (page.viewer.catalog as HabboCatalog).getSellablePetBreeds(_arg_1);
                this._SafeStr_10400 = this.parseSellableBreeds(_local_2);
                this._SafeStr_10570 = 0;
                if (this._SafeStr_10400 != null){
                    this.updateBreedSelections();
                };
            };
        }
        public function petImageReady(_arg_1:String):void
        {
            if (this._disposed){
                return;
            };
            this.updateImage();
        }
        public function petDataReady():void
        {
            if (this._disposed){
                return;
            };
            this.init();
            this.onWidgetsInitialized();
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets

// sellableBreeds = "_-2ie" (String#6923, DoABC#2)
// removePetImageListener = "_-1Uw" (String#5453, DoABC#2)
// CWE_APPROVE_RESULT = "_-2zr" (String#21455, DoABC#2)
// _SafeStr_10396 = "_-2DL" (String#6309, DoABC#2)
// _SafeStr_10398 = "_-06o" (String#3699, DoABC#2)
// _SafeStr_10399 = "_-0w9" (String#4773, DoABC#2)
// _SafeStr_10400 = "_-Ke" (String#8096, DoABC#2)
// updateAvailableBreeds = "_-6U" (String#7793, DoABC#2)
// onSelectProduct = "_-qr" (String#463, DoABC#2)
// onColourIndex = "_-WH" (String#934, DoABC#2)
// onApproveNameResult = "_-0aR" (String#1505, DoABC#2)
// onWidgetsInitialized = "_-2Ty" (String#890, DoABC#2)
// onSellablePetBreeds = "_-32Z" (String#7360, DoABC#2)
// onPurchase = "_-ku" (String#2174, DoABC#2)
// updateImage = "_-13D" (String#4937, DoABC#2)
// getRaceLocalizationKey = "_-2x5" (String#1971, DoABC#2)
// getPurchaseParameters = "_-HR" (String#8025, DoABC#2)
// approveName = "_-2HO" (String#19700, DoABC#2)
// constructErrorMessage = "_-2-W" (String#1796, DoABC#2)
// parseSellableBreeds = "_-ti" (String#8762, DoABC#2)
// addZeroPadding = "_-2sk" (String#7135, DoABC#2)
// getSellablePetBreeds = "_-0zI" (String#16400, DoABC#2)
// _SafeStr_10570 = "_-08t" (String#14401, DoABC#2)
// _selectedColorIndex = "_-0n9" (String#4572, DoABC#2)
// _SafeStr_10572 = "_-14-" (String#16616, DoABC#2)
// onDropMenuEvent = "_-2Hf" (String#19712, DoABC#2)
// updateBreedSelections = "_-149" (String#16623, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// AvatarScaleType = "_-2lF" (String#20893, DoABC#2)
// CatalogWidgetSellablePetBreedsEvent = "_-eO" (String#23818, DoABC#2)
// CatalogWidgetApproveNameResultEvent = "_-By" (String#22687, DoABC#2)
// Offer = "_-0m2" (String#4550, DoABC#2)
// ITextFieldWindow = "_-3EL" (String#2027, DoABC#2)
// IDropMenuWindow = "_-4Z" (String#2049, DoABC#2)
// CatalogWidget = "_-1pJ" (String#5844, DoABC#2)
// ICatalogWidget = "_-016" (String#3585, DoABC#2)
// SellablePetBreedData = "_-r" (String#8724, DoABC#2)
// IPetData = "_-0mZ" (String#4560, DoABC#2)
// IPetDataListener = "_-r6" (String#8726, DoABC#2)
// IPetColor = "_-2Cb" (String#6294, DoABC#2)
// CatalogWidgetsInitializedEvent = "_-0-E" (String#14021, DoABC#2)
// PetsCatalogWidget = "_-rp" (String#8733, DoABC#2)
// CatalogWidgetColourIndexEvent = "_-00G" (String#3567, DoABC#2)
// CatalogWidgetPurchaseOverrideEvent = "_-0IB" (String#3920, DoABC#2)
// CatalogWidgetColoursEvent = "_-2Vi" (String#6678, DoABC#2)
// WE_SELECTED = "_-17F" (String#16745, DoABC#2)
// _SafeStr_4336 = "_-1wM" (String#18815, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// _SafeStr_4457 = "_-2mY" (String#20943, DoABC#2)
// initActionAppends = "_-2j7" (String#6936, DoABC#2)
// appendAction = "_-1hS" (String#5696, DoABC#2)
// _SafeStr_4479 = "_-Dm" (String#22761, DoABC#2)
// endActionAppends = "_-1gH" (String#5667, DoABC#2)
// petImageReady = "_-WW" (String#8332, DoABC#2)
// productCode = "_-2co" (String#20558, DoABC#2)
// localizationId = "_-0nF" (String#4575, DoABC#2)
// priceInCredits = "_-0Is" (String#3931, DoABC#2)
// WE_CHANGE = "_-1sp" (String#18670, DoABC#2)
// onTextWindowEvent = "_-0hH" (String#820, DoABC#2)
// getCroppedImage = "_-2Ez" (String#6342, DoABC#2)
// showPurchaseConfirmation = "_-2zh" (String#21447, DoABC#2)
// rgb = "_-1zC" (String#1788, DoABC#2)
// getPetData = "_-2Tw" (String#6646, DoABC#2)
// petDataManager = "_-0y0" (String#4809, DoABC#2)
// petDataReady = "_-0Wh" (String#4242, DoABC#2)
// createPetImage = "_-0Qk" (String#4105, DoABC#2)
// setPreviewImage = "_-27B" (String#448, DoABC#2)
// removeListener = "_-1Hc" (String#1653, DoABC#2)
// _SafeStr_9995 = "_-0xM" (String#16326, DoABC#2)


