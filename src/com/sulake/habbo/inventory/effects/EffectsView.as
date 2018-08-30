
package com.sulake.habbo.inventory.effects
{
    import com.sulake.habbo.inventory.IInventoryView;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.inventory.common.ThumbListManager;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.inventory.common.IThumbListDataProvider;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.components.ITextWindow;
    import flash.geom.Point;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class EffectsView implements IInventoryView 
    {

        private var _windowManager:IHabboWindowManager;
        private var _assetLibrary:IAssetLibrary;
        private var _view:IWindowContainer;
        private var _modelController:EffectsModel;
        private var _SafeStr_8117:ThumbListManager;
        private var _SafeStr_8118:ThumbListManager;
        private var _disposed:Boolean = false;

        public function EffectsView(_arg_1:EffectsModel, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager, _arg_5:IThumbListDataProvider, _arg_6:IThumbListDataProvider)
        {
            this._modelController = _arg_1;
            this._assetLibrary = _arg_3;
            this._windowManager = _arg_2;
            var _local_7:IAsset = this._assetLibrary.getAssetByName("inventory_effects_xml");
            var _local_8:XmlAsset = XmlAsset(_local_7);
            this._view = IWindowContainer(this._windowManager.buildFromXML(XML(_local_8.content)));
            this._view.visible = false;
            this._view.procedure = this.windowEventProc;
            this._SafeStr_8117 = new ThumbListManager(this._assetLibrary, _arg_5, "thumb_bg_png", "thumb_bg_selected_png", this.getActiveThumbListImageWidth(), this.getActiveThumbListImageHeight());
            this._SafeStr_8118 = new ThumbListManager(this._assetLibrary, _arg_6, "thumb_bg_png", "thumb_bg_selected_png", this.getActiveThumbListImageWidth(), this.getActiveThumbListImageHeight());
            var _local_9:IBitmapWrapperWindow = (this._view.findChildByName("active_items_image") as IBitmapWrapperWindow);
            _local_9.procedure = this.activeThumbListEventProc;
            var _local_10:IBitmapWrapperWindow = (this._view.findChildByName("inactive_items_image") as IBitmapWrapperWindow);
            _local_10.procedure = this.inactiveThumbListEventProc;
            this._view.procedure = this.windowEventProc;
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
                if (this._SafeStr_8117 != null){
                    this._SafeStr_8117.dispose();
                    this._SafeStr_8117 = null;
                };
                if (this._SafeStr_8118 != null){
                    this._SafeStr_8118.dispose();
                    this._SafeStr_8118 = null;
                };
                this._disposed = true;
            };
        }
        public function getActiveThumbListImageWidth():int
        {
            var _local_1:IBitmapWrapperWindow = (this._view.findChildByName("active_items_image") as IBitmapWrapperWindow);
            if (_local_1 == null){
                return (0);
            };
            return (_local_1.width);
        }
        public function getActiveThumbListImageHeight():int
        {
            var _local_1:IBitmapWrapperWindow = (this._view.findChildByName("active_items_image") as IBitmapWrapperWindow);
            if (_local_1 == null){
                return (0);
            };
            return (_local_1.height);
        }
        public function getInactiveThumbListImageWidth():int
        {
            var _local_1:IBitmapWrapperWindow = (this._view.findChildByName("inactive_items_image") as IBitmapWrapperWindow);
            if (_local_1 == null){
                return (0);
            };
            return (_local_1.width);
        }
        public function getInactiveThumbListImageHeight():int
        {
            var _local_1:IBitmapWrapperWindow = (this._view.findChildByName("inactive_items_image") as IBitmapWrapperWindow);
            if (_local_1 == null){
                return (0);
            };
            return (_local_1.height);
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
        public function updateListViews():void
        {
            if (this._view == null){
                return;
            };
            if (this._view.disposed){
                return;
            };
            this._SafeStr_8118.updateImageFromList();
            this._SafeStr_8117.updateImageFromList();
            var _local_1:IBitmapWrapperWindow = (this._view.findChildByName("inactive_items_image") as IBitmapWrapperWindow);
            var _local_2:BitmapData = this._SafeStr_8118.getListImage();
            _local_1.bitmap = _local_2;
            _local_1.width = _local_2.width;
            _local_1.height = _local_2.height;
            _local_1.invalidate();
            var _local_3:IBitmapWrapperWindow = (this._view.findChildByName("active_items_image") as IBitmapWrapperWindow);
            var _local_4:BitmapData = this._SafeStr_8117.getListImage();
            _local_3.bitmap = _local_4;
            _local_3.width = _local_4.width;
            _local_3.height = _local_4.height;
            _local_3.invalidate();
        }
        public function updateActionView():void
        {
            if (this._view == null){
                return;
            };
            if (this._view.disposed){
                return;
            };
            var _local_1:IButtonWindow = (this._view.findChildByName("activateEffect_button") as IButtonWindow);
            var _local_2:ITextWindow = (this._view.findChildByName("effectDescriptionText") as ITextWindow);
            if (_local_1 == null){
                return;
            };
            if (_local_2 == null){
                return;
            };
            var _local_3:Effect = this._modelController.getSelectedEffect(-1);
            if (_local_3 == null){
                _local_1.disable();
                this.setEffectDescriptionImage(null);
                _local_2.text = "${inventory.effects.defaultdescription}";
            }
            else {
                if (_local_3.isActive){
                    _local_1.disable();
                    this.setEffectDescriptionImage(_local_3.iconImage);
                    _local_2.text = "${inventory.effects.active}";
                    this._windowManager.registerLocalizationParameter("inventory.effects.active", "timeleft", this.convertSecondsToTime(_local_3.secondsLeft));
                    this._windowManager.registerLocalizationParameter("inventory.effects.active", "duration", this.convertSecondsToTime(_local_3.duration));
                    this._windowManager.registerLocalizationParameter("inventory.effects.active", "itemcount", String(_local_3.effectsInInventory));
                }
                else {
                    _local_1.enable();
                    this.setEffectDescriptionImage(_local_3.iconImage);
                    _local_2.text = "${inventory.effects.inactive}";
                    this._windowManager.registerLocalizationParameter("inventory.effects.inactive", "duration", this.convertSecondsToTime(_local_3.duration));
                    this._windowManager.registerLocalizationParameter("inventory.effects.inactive", "itemcount", String(_local_3.effectsInInventory));
                };
            };
        }
        private function setEffectDescriptionImage(_arg_1:BitmapData):void
        {
            if (this._view == null){
                return;
            };
            if (this._view.disposed){
                return;
            };
            var _local_2:IBitmapWrapperWindow = (this._view.findChildByName("effectDescriptionImage") as IBitmapWrapperWindow);
            if (_local_2 == null){
                return;
            };
            if (_local_2.bitmap == null){
                _local_2.bitmap = new BitmapData(_local_2.width, _local_2.height, false);
            };
            if (_arg_1 == null){
                _arg_1 = new BitmapData(_local_2.width, _local_2.height);
            };
            var _local_3:Point = new Point(((_local_2.width - _arg_1.width) / 2), ((_local_2.height - _arg_1.height) / 2));
            _local_2.bitmap.copyPixels(_arg_1, _arg_1.rect, _local_3, null, null, false);
            _local_2.invalidate();
        }
        private function convertSecondsToTime(_arg_1:int):String
        {
            var _local_2:int = Math.floor(((_arg_1 / 60) / 60));
            var _local_3:int = Math.floor(((_arg_1 - ((_local_2 * 60) * 60)) / 60));
            var _local_4:int = ((_arg_1 - ((_local_2 * 60) * 60)) - (_local_3 * 60));
            var _local_5:String = "";
            if (_local_2 > 0){
                _local_5 = (_local_2 + ":");
            };
            _local_5 = (((_local_3)<10) ? ((_local_5 + "0") + _local_3) : (_local_5 + _local_3));
            _local_5 = (_local_5 + ":");
            return ((((_local_4)<10) ? ((_local_5 + "0") + _local_4) : (_local_5 + _local_4)));
        }
        private function activeThumbListEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:Point;
            var _local_4:int;
            var _local_5:Effect;
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                _local_3 = new Point(WindowMouseEvent(_arg_1).localX, WindowMouseEvent(_arg_1).localY);
                _local_4 = this._SafeStr_8117.resolveIndexFromImageLocation(_local_3);
                _local_5 = this._modelController.getItemInIndex(_local_4, 1);
                if (_local_5 != null){
                    this._modelController.toggleEffectSelected(_local_5.type);
                };
            };
        }
        private function inactiveThumbListEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:Point;
            var _local_4:int;
            var _local_5:Effect;
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                _local_3 = new Point(WindowMouseEvent(_arg_1).localX, WindowMouseEvent(_arg_1).localY);
                _local_4 = this._SafeStr_8118.resolveIndexFromImageLocation(_local_3);
                _local_5 = this._modelController.getItemInIndex(_local_4, 0);
                if (_local_5 != null){
                    this._modelController.toggleEffectSelected(_local_5.type);
                };
            };
        }
        private function windowEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:Effect;
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                if (_arg_2.name == "activateEffect_button"){
                    _local_3 = this._modelController.getSelectedEffect(0);
                    if (_local_3 != null){
                        this._modelController.requestEffectActivated(_local_3.type);
                    };
                };
            };
        }

    }
}//package com.sulake.habbo.inventory.effects

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// EffectsModel = "_-ja" (String#8589, DoABC#2)
// Effect = "_-0Ka" (String#14863, DoABC#2)
// IInventoryView = "_-1g8" (String#5665, DoABC#2)
// EffectsView = "_-1-K" (String#4853, DoABC#2)
// IThumbListDataProvider = "_-2SK" (String#6616, DoABC#2)
// ThumbListManager = "_-1u4" (String#18719, DoABC#2)
// effectsInInventory = "_-0U0" (String#4183, DoABC#2)
// secondsLeft = "_-I-" (String#8040, DoABC#2)
// isActive = "_-0q4" (String#4638, DoABC#2)
// _modelController = "_-0XB" (String#112, DoABC#2)
// getWindowContainer = "_-v8" (String#313, DoABC#2)
// iconImage = "_-0Pn" (String#4088, DoABC#2)
// updateImageFromList = "_-eL" (String#23815, DoABC#2)
// getListImage = "_-2gm" (String#20719, DoABC#2)
// resolveIndexFromImageLocation = "_-0fW" (String#15651, DoABC#2)
// updateActionView = "_-jg" (String#8593, DoABC#2)
// updateListViews = "_-3LU" (String#7727, DoABC#2)
// requestEffectActivated = "_-2jP" (String#20821, DoABC#2)
// toggleEffectSelected = "_-tV" (String#24427, DoABC#2)
// getSelectedEffect = "_-7B" (String#22509, DoABC#2)
// getItemInIndex = "_-0Tf" (String#15196, DoABC#2)
// _SafeStr_8117 = "_-1Wk" (String#17769, DoABC#2)
// _SafeStr_8118 = "_-1eG" (String#18069, DoABC#2)
// getActiveThumbListImageWidth = "_-3-z" (String#21499, DoABC#2)
// getActiveThumbListImageHeight = "_-1kU" (String#18308, DoABC#2)
// activeThumbListEventProc = "_-23A" (String#19141, DoABC#2)
// inactiveThumbListEventProc = "_-0zn" (String#16418, DoABC#2)
// getInactiveThumbListImageWidth = "_-2E9" (String#19573, DoABC#2)
// getInactiveThumbListImageHeight = "_-0EG" (String#14618, DoABC#2)
// setEffectDescriptionImage = "_-03O" (String#14178, DoABC#2)
// convertSecondsToTime = "_-0uJ" (String#16214, DoABC#2)


