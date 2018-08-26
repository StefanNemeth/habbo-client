
package com.sulake.habbo.avatar.wardrobe
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.XmlAsset;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class OutfitView 
    {

        private var _windowManager:IHabboWindowManager;
        private var _assetLibrary:IAssetLibrary;
        private var _window:IWindowContainer;
        private var _SafeStr_7922:IBitmapWrapperWindow;

        public function OutfitView(_arg_1:IHabboWindowManager, _arg_2:IAssetLibrary, _arg_3:Boolean)
        {
            this._windowManager = _arg_1;
            this._assetLibrary = _arg_2;
            var _local_4:XmlAsset = (this._assetLibrary.getAssetByName("Outfit") as XmlAsset);
            this._window = IWindowContainer(this._windowManager.buildFromXML((_local_4.content as XML)));
            if (this._window != null){
                this._SafeStr_7922 = (this._window.findChildByName("bitmap") as IBitmapWrapperWindow);
            };
            if (!_arg_3){
                this._window.findChildByName("button").disable();
            };
        }
        public function dispose():void
        {
            this._windowManager = null;
            this._assetLibrary = null;
            if (this._window){
                this._window.dispose();
            };
            this._window = null;
            if (this._SafeStr_7922){
                this._SafeStr_7922.dispose();
            };
            this._SafeStr_7922 = null;
        }
        public function udpate(_arg_1:BitmapData):void
        {
            this._SafeStr_7922.bitmap = new BitmapData(this._SafeStr_7922.width, this._SafeStr_7922.height, true, 0xFFFFFF);
            var _local_2:int = ((this._SafeStr_7922.width - _arg_1.width) / 2);
            var _local_3:int = (this._SafeStr_7922.height - _arg_1.height);
            this._SafeStr_7922.bitmap.copyPixels(_arg_1, _arg_1.rect, new Point(_local_2, _local_3));
        }
        public function get window():IWindowContainer
        {
            return (this._window);
        }
        private function windowEventProc(_arg_1:WindowEvent, _arg_2:IWindow=null):void
        {
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                Logger.log("[OutfitView] Click! This should be over-ridden!");
            }
            else {
                if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER){
                    this._window.color = 0xCCCCCC;
                }
                else {
                    if (_arg_1.type == WindowMouseEvent.WME_OUT){
                        this._window.color = 0x666666;
                    };
                };
            };
        }

    }
}//package com.sulake.habbo.avatar.wardrobe

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// OutfitView = "_-06R" (String#3691, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// _SafeStr_7922 = "_-3AP" (String#2014, DoABC#2)
// udpate = "_-Rw" (String#23322, DoABC#2)


