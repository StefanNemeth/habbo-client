
package com.sulake.habbo.catalog.club
{
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;

    public class ClubGiftConfirmationDialog 
    {

        private var _offer:Offer;
        private var _controller:ClubGiftController;
        private var _view:IFrameWindow;

        public function ClubGiftConfirmationDialog(_arg_1:ClubGiftController, _arg_2:Offer)
        {
            this._offer = _arg_2;
            this._controller = _arg_1;
            this.showConfirmation();
        }
        public function dispose():void
        {
            this._controller = null;
            this._offer = null;
            if (this._view){
                this._view.dispose();
                this._view = null;
            };
        }
        public function showConfirmation():void
        {
            if (((!(this._offer)) || (!(this._controller)))){
                return;
            };
            this._view = (this.createWindow("club_gift_confirmation") as IFrameWindow);
            if (!this._view){
                return;
            };
            this._view.procedure = this.windowEventHandler;
            this._view.center();
            var _local_1:ITextWindow = (this._view.findChildByName("item_name") as ITextWindow);
            if (_local_1){
                _local_1.text = this.getProductName();
            };
            var _local_2:IWindowContainer = (this._view.findChildByName("image_border") as IWindowContainer);
            if (!_local_2){
                return;
            };
            if (!this._offer.productContainer){
                return;
            };
            this._offer.productContainer.view = _local_2;
            this._offer.productContainer.initProductIcon(this._controller.roomEngine);
        }
        private function getProductName():String
        {
            var _local_1:IProductData;
            if (((((this._offer) && (this._offer.productContainer))) && (this._offer.productContainer.firstProduct))){
                _local_1 = this._offer.productContainer.firstProduct.productData;
                if (_local_1){
                    return (_local_1.name);
                };
            };
            return ("");
        }
        private function windowEventHandler(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((((((!(_arg_1)) || (!(_arg_2)))) || (!(this._controller)))) || (!(this._offer)))){
                return;
            };
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            switch (_arg_2.name){
                case "select_button":
                    this._controller.confirmSelection(this._offer.localizationId);
                    return;
                case "header_button_close":
                case "cancel_button":
                    this._controller.closeConfirmation();
                    return;
            };
        }
        private function createWindow(_arg_1:String):IWindow
        {
            if (((((!(this._controller)) || (!(this._controller.assets)))) || (!(this._controller.windowManager)))){
                return (null);
            };
            var _local_2:XmlAsset = (this._controller.assets.getAssetByName(_arg_1) as XmlAsset);
            if (((!(_local_2)) || (!(_local_2.content)))){
                return (null);
            };
            var _local_3:XML = (_local_2.content as XML);
            if (!_local_3){
                return (null);
            };
            return (this._controller.windowManager.buildFromXML(_local_3));
        }

    }
}//package com.sulake.habbo.catalog.club

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IProductData = "_-0jc" (String#4494, DoABC#2)
// ClubGiftController = "_-33f" (String#7378, DoABC#2)
// Offer = "_-0m2" (String#4550, DoABC#2)
// ClubGiftConfirmationDialog = "_-WY" (String#8334, DoABC#2)
// _controller = "_-18D" (String#59, DoABC#2)
// localizationId = "_-0nF" (String#4575, DoABC#2)
// initProductIcon = "_-0Ft" (String#1438, DoABC#2)
// firstProduct = "_-KM" (String#8089, DoABC#2)
// _offer = "_-1jb" (String#165, DoABC#2)
// closeConfirmation = "_-2PG" (String#6548, DoABC#2)
// confirmSelection = "_-fK" (String#23861, DoABC#2)
// windowEventHandler = "_-36j" (String#371, DoABC#2)
// getProductName = "_-2Y5" (String#6729, DoABC#2)


