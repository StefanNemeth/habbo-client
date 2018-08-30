
package com.sulake.habbo.avatar.hotlooks
{
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryView;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.avatar.wardrobe.Outfit;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class HotLooksView implements IAvatarEditorCategoryView 
    {

        private var _windowManager:IHabboWindowManager;
        private var _assetLibrary:IAssetLibrary;
        private var _window:IWindowContainer;
        private var _modelController:HotLooksModel;
        private var _SafeStr_4831:IItemGridWindow;

        public function HotLooksView(_arg_1:HotLooksModel, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary)
        {
            this._modelController = _arg_1;
            this._assetLibrary = _arg_3;
            this._windowManager = _arg_2;
        }
        public function init():void
        {
            if (this._SafeStr_4831){
                this._SafeStr_4831.removeGridItems();
            };
            if (this._window){
                this._window.dispose();
            };
            var _local_1:XmlAsset = (this._assetLibrary.getAssetByName("avatareditor_hotlooks_base") as XmlAsset);
            this._window = IWindowContainer(this._windowManager.buildFromXML((_local_1.content as XML)));
            this._SafeStr_4831 = (this._window.findChildByName("hotlooks") as IItemGridWindow);
            this._window.visible = false;
            this.update();
        }
        public function dispose():void
        {
            while (this._SafeStr_4831.numGridItems > 0) {
                this._SafeStr_4831.removeGridItemAt(0);
            };
            this._window.dispose();
            this._window = null;
            this._modelController = null;
            this._assetLibrary = null;
            this._windowManager = null;
        }
        public function update():void
        {
            var _local_1:IWindow;
            var _local_2:Outfit;
            this._SafeStr_4831.removeGridItems();
            for each (_local_2 in this._modelController.hotLooks) {
                _local_1 = _local_2.view.window;
                this._SafeStr_4831.addGridItem(_local_1);
                _local_1.procedure = this.hotLooksEventProc;
            };
        }
        public function getWindowContainer():IWindowContainer
        {
            return (this._window);
        }
        private function hotLooksEventProc(_arg_1:WindowEvent, _arg_2:IWindow=null):void
        {
            var _local_3:int;
            if (_arg_2 == null){
                _arg_2 = (_arg_1.target as IWindow);
            };
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                _local_3 = this._SafeStr_4831.getGridItemIndex(_arg_2.parent);
                this._modelController.selectHotLook(_local_3);
            };
        }
        public function switchCategory(_arg_1:String):void
        {
        }
        public function showPalettes(_arg_1:String, _arg_2:int):void
        {
        }
        public function reset():void
        {
        }

    }
}//package com.sulake.habbo.avatar.hotlooks

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IItemGridWindow = "_-265" (String#1809, DoABC#2)
// IAvatarEditorCategoryView = "_-0Au" (String#3774, DoABC#2)
// HotLooksView = "_-K1" (String#8084, DoABC#2)
// _modelController = "_-0XB" (String#112, DoABC#2)
// _SafeStr_4831 = "_-wt" (String#24565, DoABC#2)
// removeGridItems = "_-1Bp" (String#5106, DoABC#2)
// removeGridItemAt = "_-Rm" (String#8243, DoABC#2)
// hotLooks = "_-2aX" (String#20465, DoABC#2)
// addGridItem = "_-2vh" (String#7192, DoABC#2)
// hotLooksEventProc = "_-0ph" (String#16041, DoABC#2)
// getWindowContainer = "_-v8" (String#313, DoABC#2)
// selectHotLook = "_-2PP" (String#20019, DoABC#2)
// showPalettes = "_-3AL" (String#7520, DoABC#2)


