
package com.sulake.habbo.avatar.promo
{
    import com.sulake.habbo.avatar.common.ISideContentView;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.catalog.enum.CatalogPageName;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class ClubPromoView implements ISideContentView 
    {

        private var _modelController:ClubPromoModel;
        private var _window:IWindowContainer;

        public function ClubPromoView(_arg_1:ClubPromoModel)
        {
            var _local_2:XmlAsset;
            super();
            this._modelController = _arg_1;
            if (((((this._modelController) && (this._modelController.controller))) && (this._modelController.controller.manager.assets))){
                _local_2 = (this._modelController.controller.manager.assets.getAssetByName("avatareditor_club_promo_try") as XmlAsset);
                if (_local_2){
                    this._window = (this._modelController.controller.manager.windowManager.buildFromXML((_local_2.content as XML)) as IWindowContainer);
                    this._window.visible = false;
                    this._window.procedure = this.windowEventProc;
                };
            };
        }
        public function dispose():void
        {
            this._modelController = null;
        }
        public function getWindowContainer():IWindowContainer
        {
            return (this._window);
        }
        public function showBuyView():void
        {
            var _local_1:XmlAsset;
            if (((((this._modelController) && (this._modelController.controller))) && (this._modelController.controller.manager.assets))){
                _local_1 = (this._modelController.controller.manager.assets.getAssetByName("avatareditor_club_promo_buy") as XmlAsset);
                if (_local_1){
                    this._window = (this._modelController.controller.manager.windowManager.buildFromXML((_local_1.content as XML)) as IWindowContainer);
                    this._window.visible = false;
                    this._window.procedure = this.windowEventProc;
                };
            };
        }
        private function windowEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                switch (_arg_2.name){
                    case "try_clothes_btn":
                        if (this._modelController){
                            this._modelController.tryClubClothes();
                        };
                        return;
                    case "club_info_btn":
                        if (((((this._modelController) && (this._modelController.controller))) && (this._modelController.controller.manager.catalog))){
                            this._modelController.controller.manager.catalog.openCatalogPage(CatalogPageName._SafeStr_5382, true);
                        };
                        return;
                    default:
                        Logger.log("No event proc for element in Club Promo View");
                };
            };
        }

    }
}//package com.sulake.habbo.avatar.promo

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// CatalogPageName = "_-mv" (String#24149, DoABC#2)
// ClubPromoModel = "_-1zj" (String#6027, DoABC#2)
// ISideContentView = "_-1Yh" (String#5537, DoABC#2)
// ClubPromoView = "_-28r" (String#6221, DoABC#2)
// _modelController = "_-0XB" (String#112, DoABC#2)
// getWindowContainer = "_-v8" (String#313, DoABC#2)
// _SafeStr_5382 = "_-lc" (String#24094, DoABC#2)
// tryClubClothes = "_-0Mo" (String#14944, DoABC#2)
// showBuyView = "_-So" (String#23357, DoABC#2)


