
package com.sulake.habbo.catalog.viewer.widgets
{
    import flash.utils.Dictionary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.habbo.catalog.viewer.IProduct;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetUpdateRoomPreviewEvent;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.localization.ICoreLocalizationManager;

    public class SpacesCatalogWidget extends CatalogWidget implements ICatalogWidget 
    {

        private static const _SafeStr_7291:String = "floor";
        private static const _SafeStr_7292:String = "wallpaper";
        private static const TYPE_LANDSCAPE:String = "landscape";

        private var _SafeStr_10545:Array;
        private var _SafeStr_10546:Array;
        private var _SafeStr_10547:int = 0;
        private var _SafeStr_10548:int = 0;
        private var _SafeStr_10549:int = 0;
        private var _floorType:String = "default";
        private var _SafeStr_10550:Array;
        private var _SafeStr_10551:Array;
        private var _SafeStr_10552:int = 0;
        private var _SafeStr_10553:int = 0;
        private var _SafeStr_10554:int = 0;
        private var _wallType:String = "default";
        private var _landscapeOffers:Array;
        private var _SafeStr_10555:Array;
        private var _SafeStr_10556:int = 0;
        private var _SafeStr_10557:int = 0;
        private var _SafeStr_10558:int = 0;
        private var _landscapeType:String = "1.1";
        private var _SafeStr_10559:Dictionary;
        private var _SafeStr_10560:Dictionary;
        private var _SafeStr_10561:Dictionary;

        public function SpacesCatalogWidget(_arg_1:IWindowContainer)
        {
            this._SafeStr_10545 = [];
            this._SafeStr_10546 = [];
            this._SafeStr_10550 = [];
            this._SafeStr_10551 = [];
            this._landscapeOffers = [];
            this._SafeStr_10555 = [];
            super(_arg_1);
        }
        override public function dispose():void
        {
            this._SafeStr_10559 = null;
            this._SafeStr_10560 = null;
            this._SafeStr_10561 = null;
            this._SafeStr_10545 = null;
            this._SafeStr_10546 = null;
            this._SafeStr_10550 = null;
            this._SafeStr_10551 = null;
            this._landscapeOffers = null;
            this._SafeStr_10555 = null;
            super.dispose();
        }
        override public function init():Boolean
        {
            var _local_3:Offer;
            var _local_4:int;
            var _local_5:IProduct;
            var _local_6:String;
            var _local_7:Array;
            var _local_8:String;
            var _local_9:String;
            var _local_10:String;
            var _local_11:Array;
            var _local_12:IWindow;
            if (!super.init()){
                return (false);
            };
            if (window == null){
                return (false);
            };
            var _local_1:XmlAsset = (page.viewer.catalog.assets.getAssetByName("configuration_catalog_spaces") as XmlAsset);
            if (_local_1 == null){
                return (false);
            };
            var _local_2:XML = (_local_1.content as XML);
            if (_local_2 == null){
                return (false);
            };
            this._SafeStr_10559 = this.parseElements(_local_2.floors.pattern);
            this._SafeStr_10560 = this.parseElements(_local_2.walls.pattern);
            this._SafeStr_10561 = this.parseElements(_local_2.landscapes.pattern);
            for each (_local_3 in page.offers) {
                _local_5 = _local_3.productContainer.firstProduct;
                _local_6 = _local_3.localizationId;
                _local_7 = (((_local_6)!=null) ? _local_6.split(" ") : null);
                if (!(((_local_7 == null)) || (!((_local_7.length == 2))))){
                    _local_8 = _local_7[1];
                    _local_9 = _local_5.furnitureData.name;
                    switch (_local_9){
                        case "floor":
                            for (_local_10 in this._SafeStr_10559) {
                                _local_11 = this._SafeStr_10559[_local_10];
                                if (this._SafeStr_10546.indexOf(_local_10) == -1){
                                    this._SafeStr_10546.push(_local_10);
                                    this._SafeStr_10545.push(_local_3);
                                };
                            };
                            break;
                        case "wallpaper":
                            if (this._SafeStr_10560[_local_8] != null){
                                this._SafeStr_10551.push(_local_8);
                                this._SafeStr_10550.push(_local_3);
                            }
                            else {
                                Logger.log(("[SpacesCatalogWidget] Could not find wallpaper pattern configuration! " + [_local_6, _local_9]));
                            };
                            break;
                        case "landscape":
                            if (this._SafeStr_10561[_local_8] != null){
                                this._SafeStr_10555.push(_local_8);
                                this._landscapeOffers.push(_local_3);
                            }
                            else {
                                Logger.log(("[SpacesCatalogWidget] Could not find landscape pattern configuration! " + [_local_6, _local_9]));
                            };
                            break;
                        default:
                            Logger.log(("[SpacesCatalogWidget] : " + _local_9));
                    };
                };
            };
            _local_4 = 0;
            while (_local_4 < _window.numChildren) {
                _local_12 = _window.getChildAt(_local_4);
                if ((_local_12 is IButtonWindow)){
                    _local_12.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClick);
                };
                _local_4++;
            };
            this.changePattern(_SafeStr_7291, 0);
            this.changePattern(_SafeStr_7292, 0);
            this.changePattern(TYPE_LANDSCAPE, 0);
            this.updateConfiguration();
            events.dispatchEvent(new CatalogWidgetUpdateRoomPreviewEvent(this._floorType, this._wallType, this._landscapeType, 64));
            return (true);
        }
        private function parseElements(_arg_1:XMLList):Dictionary
        {
            var _local_3:XML;
            var _local_4:String;
            var _local_5:Array;
            var _local_6:XMLList;
            var _local_7:XML;
            var _local_8:String;
            var _local_2:Dictionary = new Dictionary();
            if (_arg_1 != null){
                for each (_local_3 in _arg_1) {
                    _local_4 = String(_local_3.@id);
                    if (_local_4 != null){
                        _local_5 = new Array();
                        _local_2[_local_4] = _local_5;
                        _local_6 = _local_3.children();
                        if (((!((_local_6 == null))) && ((_local_6.length() > 0)))){
                            for each (_local_7 in _local_6) {
                                _local_8 = _local_7.@id;
                                if (((!((_local_8 == null))) && ((_local_5.indexOf(_local_8) == -1)))){
                                    _local_5.push(_local_8);
                                };
                            };
                        };
                    };
                };
            };
            return (_local_2);
        }
        private function onClick(_arg_1:WindowMouseEvent):void
        {
            var _local_3:Offer;
            var _local_2:IWindow = (_arg_1.target as IWindow);
            if (_local_2 == null){
                return;
            };
            switch (_local_2.name){
                case "ctlg_wall_pattern_prev":
                    this.changePattern(_SafeStr_7292, -1);
                    break;
                case "ctlg_wall_pattern_next":
                    this.changePattern(_SafeStr_7292, 1);
                    break;
                case "ctlg_wall_color_prev":
                    this.changeColor(_SafeStr_7292, -1);
                    break;
                case "ctlg_wall_color_next":
                    this.changeColor(_SafeStr_7292, 1);
                    break;
                case "ctlg_buy_wall":
                    _local_3 = this._SafeStr_10550[this._SafeStr_10552];
                    if (_local_3 != null){
                        (page.viewer.catalog as HabboCatalog).showPurchaseConfirmation(_local_3, page.pageId, this._wallType);
                    };
                    break;
                case "ctlg_floor_pattern_prev":
                    this.changePattern(_SafeStr_7291, -1);
                    break;
                case "ctlg_floor_pattern_next":
                    this.changePattern(_SafeStr_7291, 1);
                    break;
                case "ctlg_floor_color_prev":
                    this.changeColor(_SafeStr_7291, -1);
                    break;
                case "ctlg_floor_color_next":
                    this.changeColor(_SafeStr_7291, 1);
                    break;
                case "ctlg_buy_floor":
                    _local_3 = this._SafeStr_10545[this._SafeStr_10547];
                    if (_local_3 != null){
                        (page.viewer.catalog as HabboCatalog).showPurchaseConfirmation(_local_3, page.pageId, this._floorType);
                    };
                    break;
                case "ctlg_landscape_pattern_next":
                    this.changePattern(TYPE_LANDSCAPE, -1);
                    break;
                case "ctlg_landscape_pattern_prev":
                    this.changePattern(TYPE_LANDSCAPE, 1);
                    break;
                case "ctlg_landscape_color_prev":
                    this.changeColor(TYPE_LANDSCAPE, -1);
                    break;
                case "ctlg_landscape_color_next":
                    this.changeColor(TYPE_LANDSCAPE, 1);
                    break;
                case "ctlg_buy_landscape":
                    _local_3 = this._landscapeOffers[this._SafeStr_10556];
                    if (_local_3 != null){
                        (page.viewer.catalog as HabboCatalog).showPurchaseConfirmation(_local_3, page.pageId, this._landscapeType);
                    };
                    break;
                default:
                    Logger.log(("Spaces, unknown button: " + _local_2.name));
            };
            this.updateConfiguration();
            events.dispatchEvent(new CatalogWidgetUpdateRoomPreviewEvent(this._floorType, this._wallType, this._landscapeType, 64));
        }
        private function updateConfiguration():void
        {
            var _local_11:String;
            var _local_12:ITextWindow;
            var _local_13:String;
            var _local_14:ITextWindow;
            var _local_15:String;
            var _local_16:ITextWindow;
            var _local_1:ICoreLocalizationManager = (page.viewer.catalog as HabboCatalog).localization;
            var _local_2:String = this._SafeStr_10546[this._SafeStr_10547];
            var _local_3:Array = this._SafeStr_10559[_local_2];
            if (((!((_local_3 == null))) && ((this._SafeStr_10548 >= 0)))){
                _local_11 = _local_3[this._SafeStr_10548];
                if (_local_11 != null){
                    this._floorType = _local_11;
                };
            };
            var _local_4:Offer = this._SafeStr_10545[this._SafeStr_10547];
            if (_local_4 != null){
                _local_12 = (_window.findChildByName("ctlg_floor_price") as ITextWindow);
                if (_local_12 != null){
                    _local_12.caption = _local_1.registerParameter("catalog.purchase.price.credits", "credits", String(_local_4.priceInCredits));
                };
            };
            var _local_5:String = this._SafeStr_10551[this._SafeStr_10552];
            var _local_6:Array = this._SafeStr_10560[_local_5];
            if (((!((_local_6 == null))) && ((this._SafeStr_10553 >= 0)))){
                _local_13 = _local_6[this._SafeStr_10553];
                if (_local_13 != null){
                    this._wallType = _local_13;
                };
            };
            var _local_7:Offer = this._SafeStr_10550[this._SafeStr_10552];
            if (_local_7 != null){
                _local_14 = (_window.findChildByName("ctlg_wall_price") as ITextWindow);
                if (_local_14 != null){
                    _local_14.caption = _local_1.registerParameter("catalog.purchase.price.credits", "credits", String(_local_7.priceInCredits));
                };
            };
            var _local_8:String = this._SafeStr_10555[this._SafeStr_10556];
            var _local_9:Array = this._SafeStr_10561[_local_8];
            if (((!((_local_9 == null))) && ((this._SafeStr_10557 >= 0)))){
                _local_15 = _local_9[this._SafeStr_10557];
                if (_local_15 != null){
                    this._landscapeType = _local_15;
                };
            };
            var _local_10:Offer = this._landscapeOffers[this._SafeStr_10556];
            if (_local_10 != null){
                _local_16 = (_window.findChildByName("ctlg_landscape_price") as ITextWindow);
                if (_local_16 != null){
                    _local_16.caption = _local_1.registerParameter("catalog.purchase.price.credits", "credits", String(_local_10.priceInCredits));
                };
            };
        }
        private function changePattern(_arg_1:String, _arg_2:int):void
        {
            var _local_3:IButtonWindow;
            var _local_4:IButtonWindow;
            var _local_5:String;
            var _local_6:Array;
            var _local_7:String;
            var _local_8:Array;
            var _local_9:String;
            var _local_10:Array;
            switch (_arg_1){
                case _SafeStr_7291:
                    this._SafeStr_10547 = (this._SafeStr_10547 + _arg_2);
                    if (this._SafeStr_10547 < 0){
                        this._SafeStr_10547 = (this._SafeStr_10546.length - 1);
                    };
                    if (this._SafeStr_10547 >= this._SafeStr_10546.length){
                        this._SafeStr_10547 = 0;
                    };
                    this._SafeStr_10548 = 0;
                    this._SafeStr_10549 = 0;
                    _local_5 = this._SafeStr_10546[this._SafeStr_10547];
                    _local_6 = this._SafeStr_10559[_local_5];
                    if (_local_6 != null){
                        this._SafeStr_10549 = _local_6.length;
                    };
                    _local_4 = (_window.findChildByName("ctlg_floor_color_prev") as IButtonWindow);
                    _local_3 = (_window.findChildByName("ctlg_floor_color_next") as IButtonWindow);
                    if (this._SafeStr_10549 < 2){
                        if (_local_4 != null){
                            _local_4.disable();
                        };
                        if (_local_3 != null){
                            _local_3.disable();
                        };
                    }
                    else {
                        if (_local_4 != null){
                            _local_4.enable();
                        };
                        if (_local_3 != null){
                            _local_3.enable();
                        };
                    };
                    return;
                case _SafeStr_7292:
                    this._SafeStr_10552 = (this._SafeStr_10552 + _arg_2);
                    if (this._SafeStr_10552 < 0){
                        this._SafeStr_10552 = (this._SafeStr_10551.length - 1);
                    };
                    if (this._SafeStr_10552 == this._SafeStr_10551.length){
                        this._SafeStr_10552 = 0;
                    };
                    this._SafeStr_10553 = 0;
                    this._SafeStr_10554 = 0;
                    _local_7 = this._SafeStr_10551[this._SafeStr_10552];
                    _local_8 = this._SafeStr_10560[_local_7];
                    if (_local_8 != null){
                        this._SafeStr_10554 = _local_8.length;
                    };
                    _local_4 = (_window.findChildByName("ctlg_wall_color_prev") as IButtonWindow);
                    _local_3 = (_window.findChildByName("ctlg_wall_color_next") as IButtonWindow);
                    if (this._SafeStr_10554 < 2){
                        if (_local_4 != null){
                            _local_4.disable();
                        };
                        if (_local_3 != null){
                            _local_3.disable();
                        };
                    }
                    else {
                        if (_local_4 != null){
                            _local_4.enable();
                        };
                        if (_local_3 != null){
                            _local_3.enable();
                        };
                    };
                    return;
                case TYPE_LANDSCAPE:
                    this._SafeStr_10556 = (this._SafeStr_10556 + _arg_2);
                    if (this._SafeStr_10556 < 0){
                        this._SafeStr_10556 = (this._SafeStr_10555.length - 1);
                    };
                    if (this._SafeStr_10556 >= this._SafeStr_10555.length){
                        this._SafeStr_10556 = 0;
                    };
                    this._SafeStr_10557 = 0;
                    this._SafeStr_10558 = 0;
                    _local_9 = this._SafeStr_10555[this._SafeStr_10556];
                    _local_10 = this._SafeStr_10561[_local_9];
                    if (_local_10 != null){
                        this._SafeStr_10558 = _local_10.length;
                    };
                    _local_4 = (_window.findChildByName("ctlg_landscape_color_prev") as IButtonWindow);
                    _local_3 = (_window.findChildByName("ctlg_landscape_color_next") as IButtonWindow);
                    if (this._SafeStr_10558 < 2){
                        if (_local_4 != null){
                            _local_4.disable();
                        };
                        if (_local_3 != null){
                            _local_3.disable();
                        };
                    }
                    else {
                        if (_local_4 != null){
                            _local_4.enable();
                        };
                        if (_local_3 != null){
                            _local_3.enable();
                        };
                    };
                    return;
            };
        }
        private function changeColor(_arg_1:String, _arg_2:int):void
        {
            switch (_arg_1){
                case _SafeStr_7291:
                    this._SafeStr_10548 = (this._SafeStr_10548 + _arg_2);
                    if (this._SafeStr_10548 < 0){
                        if (this._SafeStr_10549 > 0){
                            this._SafeStr_10548 = (this._SafeStr_10549 - 1);
                        }
                        else {
                            this._SafeStr_10548 = 0;
                        };
                    };
                    if (this._SafeStr_10548 >= this._SafeStr_10549){
                        this._SafeStr_10548 = 0;
                    };
                    return;
                case _SafeStr_7292:
                    this._SafeStr_10553 = (this._SafeStr_10553 + _arg_2);
                    if (this._SafeStr_10553 < 0){
                        if (this._SafeStr_10554 > 0){
                            this._SafeStr_10553 = (this._SafeStr_10554 - 1);
                        }
                        else {
                            this._SafeStr_10553 = 0;
                        };
                    };
                    if (this._SafeStr_10553 >= this._SafeStr_10554){
                        this._SafeStr_10553 = 0;
                    };
                    return;
                case TYPE_LANDSCAPE:
                    this._SafeStr_10557 = (this._SafeStr_10557 + _arg_2);
                    if (this._SafeStr_10557 < 0){
                        if (this._SafeStr_10558 > 0){
                            this._SafeStr_10557 = (this._SafeStr_10558 - 1);
                        }
                        else {
                            this._SafeStr_10557 = 0;
                        };
                    };
                    if (this._SafeStr_10557 >= this._SafeStr_10558){
                        this._SafeStr_10557 = 0;
                    };
                    return;
            };
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets

// _SafeStr_10545 = "_-10d" (String#16487, DoABC#2)
// _SafeStr_10546 = "_-24p" (String#19215, DoABC#2)
// _SafeStr_10547 = "_-0NJ" (String#14968, DoABC#2)
// _SafeStr_10548 = "_-0xy" (String#16353, DoABC#2)
// _SafeStr_10549 = "_-ED" (String#22779, DoABC#2)
// _SafeStr_10550 = "_-11D" (String#16507, DoABC#2)
// _SafeStr_10551 = "_-20G" (String#19023, DoABC#2)
// _SafeStr_10552 = "_-2F7" (String#19610, DoABC#2)
// _SafeStr_10553 = "_-27A" (String#19298, DoABC#2)
// _SafeStr_10554 = "_-2fS" (String#20667, DoABC#2)
// _SafeStr_10555 = "_-0ok" (String#16002, DoABC#2)
// _SafeStr_10556 = "_-0II" (String#14771, DoABC#2)
// _SafeStr_10557 = "_-2pn" (String#21073, DoABC#2)
// _SafeStr_10558 = "_-0w1" (String#16274, DoABC#2)
// _SafeStr_10559 = "_-2IC" (String#19735, DoABC#2)
// _SafeStr_10560 = "_-2uC" (String#21248, DoABC#2)
// _SafeStr_10561 = "_-1kd" (String#18314, DoABC#2)
// parseElements = "_-28Q" (String#19348, DoABC#2)
// changePattern = "_-0gp" (String#15702, DoABC#2)
// updateConfiguration = "_-2ml" (String#20951, DoABC#2)
// changeColor = "_-ll" (String#24101, DoABC#2)
// Offer = "_-0m2" (String#4550, DoABC#2)
// CatalogWidget = "_-1pJ" (String#5844, DoABC#2)
// ICatalogWidget = "_-016" (String#3585, DoABC#2)
// SpacesCatalogWidget = "_-0bb" (String#4335, DoABC#2)
// CatalogWidgetUpdateRoomPreviewEvent = "_-1w1" (String#5958, DoABC#2)
// _wallType = "_-04G" (String#578, DoABC#2)
// _landscapeType = "_-2Wo" (String#621, DoABC#2)
// localizationId = "_-0nF" (String#4575, DoABC#2)
// priceInCredits = "_-0Is" (String#3931, DoABC#2)
// firstProduct = "_-KM" (String#8089, DoABC#2)
// furnitureData = "_-2GE" (String#6370, DoABC#2)
// showPurchaseConfirmation = "_-2zh" (String#21447, DoABC#2)
// onClick = "_-2US" (String#368, DoABC#2)
// _SafeStr_7291 = "_-00x" (String#1383, DoABC#2)
// _SafeStr_7292 = "_-aU" (String#8428, DoABC#2)


