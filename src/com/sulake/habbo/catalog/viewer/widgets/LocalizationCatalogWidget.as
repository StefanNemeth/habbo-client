
package com.sulake.habbo.catalog.viewer.widgets
{
    import flash.utils.Dictionary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import flash.external.ExternalInterface;
    import com.sulake.habbo.catalog.enum.CatalogPageName;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.geom.Point;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;

    public class LocalizationCatalogWidget extends CatalogWidget implements ICatalogWidget 
    {

        private var _SafeStr_10499:Dictionary;

        public function LocalizationCatalogWidget(_arg_1:IWindowContainer)
        {
            super(_arg_1);
            this._SafeStr_10499 = new Dictionary();
        }
        override public function dispose():void
        {
            super.dispose();
        }
        override public function init():Boolean
        {
            if (!super.init()){
                return (false);
            };
            this.initLocalizables();
            this.initStaticImages();
            this.initLinks();
            events.addEventListener(WidgetEvent.CWE_SELECT_PRODUCT, this.onProductSelected);
            return (true);
        }
        private function onProductSelected(_arg_1:SelectProductEvent):void
        {
            if (_arg_1 == null){
                return;
            };
        }
        private function initLinks():void
        {
            var _local_1:String;
            var _local_2:IWindow;
            if (page.hasLinks){
                for each (_local_1 in page.links) {
                    _local_2 = _window.findChildByName(_local_1);
                    if (_local_2 != null){
                        _local_2.setParamFlag(WindowParam._SafeStr_7434);
                        _local_2.mouseThreshold = 0;
                        _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClickLink);
                    };
                };
            };
        }
        private function onClickLink(_arg_1:WindowMouseEvent):void
        {
            var _local_2:ICoreLocalizationManager = (page.viewer.catalog as HabboCatalog).localization;
            var _local_3:IHabboConfigurationManager = (page.viewer.catalog as HabboCatalog).configuration;
            var _local_4:String = IWindow(_arg_1.target).name;
            var _local_5:String = "";
            switch (page.layoutCode){
                case "frontpage3":
                    switch (_local_4){
                        case "ctlg_txt3":
                            if (IWindow(_arg_1.target).caption != ""){
                                _local_5 = page.localization.getTextElementContent(6);
                                page.viewer.catalog.openCatalogPage(_local_5);
                            };
                            break;
                        case "ctlg_txt7":
                            if (IWindow(_arg_1.target).caption != ""){
                                _local_5 = page.localization.getTextElementContent(10);
                                if (_local_5.indexOf("http") >= 0){
                                    this.openExternalLink(_local_5);
                                }
                                else {
                                    if (_local_5 == "magic.credits"){
                                        if (((ExternalInterface.available) && (("true" == _local_3.getKey("client.credits.embed.enabled"))))){
                                            ExternalInterface.call("FlashExternalInterface.openHabblet", "credits");
                                        }
                                        else {
                                            _local_5 = _local_3.getKey("link.format.credits", "/credits");
                                            this.openExternalLink(_local_5);
                                        };
                                    }
                                    else {
                                        page.viewer.catalog.openCatalogPage(_local_5);
                                    };
                                };
                            };
                            break;
                    };
                    return;
                case "info_pixels":
                    switch (_local_4){
                        case "ctlg_text_5":
                            break;
                        case "ctlg_text_7":
                            _local_5 = page.localization.getTextElementContent(7);
                            page.viewer.catalog.openCatalogPage(_local_5);
                            break;
                    };
                    return;
                case "info_credits":
                    switch (_local_4){
                        case "ctlg_text_5":
                            if (((ExternalInterface.available) && (("true" == _local_3.getKey("client.credits.embed.enabled"))))){
                                ExternalInterface.call("FlashExternalInterface.openHabblet", "credits");
                            }
                            else {
                                _local_5 = _local_3.getKey("link.format.credits", "/credits");
                                this.openExternalLink(_local_5);
                            };
                            break;
                        case "ctlg_text_7":
                            _local_5 = page.localization.getTextElementContent(7);
                            page.viewer.catalog.openCatalogPage(_local_5);
                            break;
                    };
                    return;
                case "collectibles":
                    switch (_local_4){
                        case "ctlg_collectibles_link":
                            _local_5 = _local_3.getKey("link.format.collectibles", "/credits/collectibles");
                            this.openExternalLink(_local_5);
                            break;
                    };
                    return;
                case "club1":
                    switch (_local_4){
                        case "ctlg_text_5":
                            page.viewer.catalog.openCatalogPage(CatalogPageName._SafeStr_5382, true);
                            break;
                    };
                    return;
                case "club_buy":
                    switch (_local_4){
                        case "club_link":
                            _local_5 = _local_3.getKey("link.format.club", "/credits/collectibles");
                            this.openExternalLink(_local_5);
                            break;
                    };
                    return;
                case "mad_money":
                    switch (_local_4){
                        case "ctlg_madmoney_button":
                            _local_5 = _local_3.getKey("link.format.madmoney", "/credits/credits_subscription");
                            this.openExternalLink(_local_5);
                            break;
                    };
                    return;
                case "monkey":
                    switch (_local_4){
                        case "ctlg_teaserimg_1_region":
                        case "ctlg_special_img_region":
                            _local_5 = _local_2.getKey("link.format.monkey", "http://store.apple.com/");
                            this.openExternalLink(_local_5);
                            break;
                    };
                    return;
                default:
                    Logger.log(("[LocalizationCatalogWidget] Unhandled link clicked" + [page.layoutCode, _local_4]));
            };
        }
        private function openExternalLink(_arg_1:String):void
        {
            var _local_2:IHabboConfigurationManager = (page.viewer.catalog as HabboCatalog).configuration;
            if (_arg_1 != ""){
                page.viewer.catalog.windowManager.alert("${catalog.alert.external.link.title}", "${catalog.alert.external.link.desc}", 0, this.onExternalLink);
                HabboWebTools.navigateToURL(_arg_1, "habboMain");
            };
        }
        private function onExternalLink(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
        }
        private function initStaticImages():void
        {
            var _local_2:IWindow;
            var _local_3:String;
            var _local_4:String;
            var _local_1:int;
            while (_local_1 < _window.numChildren) {
                _local_2 = _window.getChildAt(_local_1);
                if ((_local_2 is IBitmapWrapperWindow)){
                    if (_local_2.tags.indexOf("STATIC_IMAGE") > -1){
                        _local_3 = _local_2.name;
                        _local_4 = _local_2.name;
                        this._SafeStr_10499[_local_4] = _local_3;
                        if (page.viewer.catalog.assets.hasAsset(_local_4)){
                            this.setElementImage(_local_3, _local_4);
                        }
                        else {
                            this.retrieveCatalogImage(_local_4);
                        };
                    };
                };
                _local_1++;
            };
        }
        protected function initLocalizables():void
        {
            var _local_2:String;
            var _local_3:String;
            var _local_4:IWindow;
            var _local_5:BitmapData;
            var _local_6:String;
            var _local_7:Array;
            var _local_8:Array;
            var _local_9:uint;
            var _local_10:int;
            var _local_11:ITextWindow;
            var _local_1:int;
            this._SafeStr_10499 = new Dictionary();
            _local_1 = 0;
            while (_local_1 < page.localization.textCount) {
                _local_2 = page.localization.getTextElementName(_local_1, page.layoutCode);
                _local_3 = page.localization.getTextElementContent(_local_1);
                if (_window != null){
                    _local_4 = _window.findChildByName(_local_2);
                };
                if (_local_4 != null){
                    _local_4.caption = _local_3;
                }
                else {
                    Logger.log(((("[LocalizationCatalogWidget] Could not place text in layout:  element: " + _local_2) + ", content: ") + _local_3));
                };
                _local_1++;
            };
            _local_1 = 0;
            while (_local_1 < page.localization.imageCount) {
                _local_2 = page.localization.getImageElementName(_local_1, page.layoutCode);
                _local_3 = page.localization.getImageElementContent(_local_1);
                if (_local_2 != ""){
                    if (_local_3 != ""){
                        _local_6 = _local_3;
                        this._SafeStr_10499[_local_6] = _local_2;
                        if (page.viewer.catalog.assets.hasAsset(_local_6)){
                            this.setElementImage(_local_2, _local_6);
                        }
                        else {
                            this.retrieveCatalogImage(_local_6);
                        };
                    };
                };
                _local_1++;
            };
            if (page.localization.hasColors(page.layoutCode)){
                _local_7 = page.localization.getColorSources(page.layoutCode);
                _local_8 = page.localization.getColorTargets(page.layoutCode);
                _local_1 = 0;
                while (_local_1 < _local_7.length) {
                    _local_9 = page.localization.getColorUintFromText(_local_7[_local_1]);
                    if ((_local_8[_local_1] as Array) != null){
                        _local_10 = 0;
                        while (_local_10 < (_local_8[_local_1] as Array).length) {
                            if (_window != null){
                                _local_11 = (_window.findChildByName(_local_8[_local_1][_local_10]) as ITextWindow);
                            };
                            if (_local_11 != null){
                                _local_11.textColor = _local_9;
                            };
                            _local_10++;
                        };
                    };
                    _local_1++;
                };
            };
        }
        private function setElementImage(_arg_1:String, _arg_2:String):void
        {
            var _local_4:BitmapDataAsset;
            var _local_5:BitmapData;
            var _local_6:int;
            var _local_7:int;
            Logger.log(("[LocalizationCatalogWidget] Set Element Image: " + [_arg_1, _arg_2]));
            if (_window == null){
                Logger.log(("[LocalizationCatalogWidget] Window is null! " + [_arg_1, _arg_2]));
                return;
            };
            if (_window.disposed){
                Logger.log(("[LocalizationCatalogWidget] Window is disposed! " + [_arg_1, _arg_2, _window.name]));
                return;
            };
            var _local_3:IBitmapWrapperWindow = (_window.findChildByName(_arg_1) as IBitmapWrapperWindow);
            if (_local_3 != null){
                _local_4 = (page.viewer.catalog.assets.getAssetByName(_arg_2) as BitmapDataAsset);
                if (_local_4 == null){
                    Logger.log(("[LocalizationCatalogWidget] Asset does not exist: " + [_arg_1, _arg_2]));
                    return;
                };
                _local_5 = (_local_4.content as BitmapData);
                if (_local_3.bitmap == null){
                    _local_3.bitmap = new BitmapData(_local_3.width, _local_3.height, true, 0xFFFFFF);
                };
                _local_3.bitmap.fillRect(_local_3.bitmap.rect, 0xFFFFFF);
                _local_6 = ((_local_3.width - _local_5.width) / 2);
                _local_7 = ((_local_3.height - _local_5.height) / 2);
                _local_3.bitmap.copyPixels(_local_5, _local_5.rect, new Point(_local_6, _local_7), null, null, true);
            }
            else {
                Logger.log(("[LocalizationCatalogWidget] Could not find element: " + _arg_1));
            };
        }
        private function retrieveCatalogImage(_arg_1:String):void
        {
            var _local_2:String;
            var _local_3:String = page.viewer.catalog.configuration.getKey("image.library.catalogue.url");
            var _local_4 = (page.viewer.catalog.configuration.getKey("image.library.url") + "Top_Story_Images/");
            var _local_5:String = this._SafeStr_10499[_arg_1];
            var _local_6:IWindow = (_window.findChildByName(_local_5) as IWindow);
            if (_local_6.tags.indexOf("TOP_STORY") > -1){
                _local_2 = _local_4;
            }
            else {
                _local_2 = _local_3;
            };
            var _local_7 = ((_local_2 + _arg_1) + ".gif");
            Logger.log(("[LocalizationCatalogWidget]  : " + _local_7));
            var _local_8:URLRequest = new URLRequest(_local_7);
            var _local_9:AssetLoaderStruct = page.viewer.catalog.assets.loadAssetFromFile(_arg_1, _local_8, "image/gif");
            _local_9.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.onCatalogImageReady);
        }
        private function onCatalogImageReady(_arg_1:AssetLoaderEvent):void
        {
            var _local_3:String;
            var _local_4:String;
            var _local_2:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            if (_local_2 != null){
                _local_3 = _local_2.assetName;
                _local_4 = this._SafeStr_10499[_local_3];
                this.setElementImage(_local_4, _local_3);
            };
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets

// onExternalLink = "_-022" (String#575, DoABC#2)
// _SafeStr_10499 = "_-rt" (String#24357, DoABC#2)
// initLocalizables = "_-kF" (String#24045, DoABC#2)
// initStaticImages = "_-0en" (String#15617, DoABC#2)
// initLinks = "_-34E" (String#7393, DoABC#2)
// onProductSelected = "_-1H7" (String#17158, DoABC#2)
// onClickLink = "_-2wT" (String#7212, DoABC#2)
// openExternalLink = "_-0kn" (String#823, DoABC#2)
// retrieveCatalogImage = "_-0lI" (String#15876, DoABC#2)
// onCatalogImageReady = "_-0-g" (String#14040, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// HabboWebTools = "_-2pX" (String#21059, DoABC#2)
// CatalogPageName = "_-mv" (String#24149, DoABC#2)
// CatalogWidget = "_-1pJ" (String#5844, DoABC#2)
// ICatalogWidget = "_-016" (String#3585, DoABC#2)
// LocalizationCatalogWidget = "_-2Y0" (String#6726, DoABC#2)
// setElementImage = "_-1IU" (String#302, DoABC#2)
// _SafeStr_5382 = "_-lc" (String#24094, DoABC#2)
// mouseThreshold = "_-0OA" (String#4051, DoABC#2)
// _SafeStr_7434 = "_-2xA" (String#21356, DoABC#2)
// AssetLoaderStruct = "_-0R2" (String#4112, DoABC#2)


