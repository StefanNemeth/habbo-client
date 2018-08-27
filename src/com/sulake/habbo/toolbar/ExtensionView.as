
package com.sulake.habbo.toolbar
{
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.utils.Map;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.Core;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindow;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import com.sulake.habbo.toolbar.events.ExtensionViewEvent;

    public class ExtensionView implements IExtensionView 
    {

        private static const _SafeStr_13776:int = 3;

        private var _toolbar:HabboToolbar;
        private var _SafeStr_13777:IItemListWindow;
        private var _items:Map;
        private var _disposed:Boolean = false;

        public function ExtensionView(_arg_1:IHabboWindowManager, _arg_2:IAssetLibrary, _arg_3:HabboToolbar)
        {
            this._toolbar = _arg_3;
            var _local_4:XmlAsset = (_arg_2.getAssetByName("extension_grid_xml") as XmlAsset);
            if (_local_4){
                this._SafeStr_13777 = (_arg_1.buildFromXML((_local_4.content as XML), 1) as IItemListWindow);
            };
            var _local_5:IWindowContainer = this._SafeStr_13777.desktop;
            if (this._SafeStr_13777){
                this._SafeStr_13777.x = ((_local_5.width - this._SafeStr_13777.width) - _SafeStr_13776);
                this._SafeStr_13777.y = _SafeStr_13776;
                this._SafeStr_13777.visible = true;
            }
            else {
                Core.error("Unable to initialize Toolbar Extension view window from xml asset", false, Core._SafeStr_9058);
            };
            this._items = new Map();
        }
        public function dispose():void
        {
            var _local_1:Array;
            var _local_2:String;
            if (!this._disposed){
                _local_1 = this._items.getKeys();
                for each (_local_2 in _local_1) {
                    this.detachExtension(_local_2);
                };
                if (this._SafeStr_13777){
                    this._SafeStr_13777.dispose();
                    this._SafeStr_13777 = null;
                };
                this._toolbar = null;
                this._items = null;
                this._disposed = true;
            };
        }
        public function get screenHeight():uint
        {
            if (!this._SafeStr_13777){
                return (0);
            };
            return ((this._SafeStr_13777.height + this._SafeStr_13777.y));
        }
        public function attachExtension(_arg_1:String, _arg_2:IWindow, _arg_3:int=-1):void
        {
            if (this._items.getValue(_arg_1)){
                return;
            };
            this._items.add(_arg_1, _arg_2);
            if (this._SafeStr_13777){
                if (_arg_3 == -1){
                    this._SafeStr_13777.addListItem(_arg_2);
                }
                else {
                    this._SafeStr_13777.addListItemAt(_arg_2, _arg_3);
                };
                this._SafeStr_13777.invalidate();
            };
            this.queueResizeEvent();
        }
        public function detachExtension(_arg_1:String):void
        {
            var _local_2:IWindow = this._items[_arg_1];
            if (this._SafeStr_13777){
                this._SafeStr_13777.removeListItem(_local_2);
            };
            this._items.remove(_arg_1);
            this.queueResizeEvent();
        }
        private function queueResizeEvent():void
        {
            var _local_1:Timer = new Timer(25, 1);
            _local_1.addEventListener(TimerEvent.TIMER_COMPLETE, this.onResizeTimer);
            _local_1.start();
        }
        private function onResizeTimer(_arg_1:TimerEvent):void
        {
            if (this._toolbar){
                this._toolbar.events.dispatchEvent(new ExtensionViewEvent(ExtensionViewEvent.EVE_EXTENSION_VIEW_RESIZED));
            };
        }

    }
}//package com.sulake.habbo.toolbar

// screenHeight = "_-1sB" (String#5888, DoABC#2)
// _SafeStr_13776 = "_-1PC" (String#17476, DoABC#2)
// _SafeStr_13777 = "_-08n" (String#14397, DoABC#2)
// queueResizeEvent = "_-3He" (String#22186, DoABC#2)
// IExtensionView = "_-1z2" (String#6016, DoABC#2)
// ExtensionView = "_-20R" (String#6055, DoABC#2)
// ExtensionViewEvent = "_-Cn" (String#22717, DoABC#2)
// addListItemAt = "_-2CT" (String#6293, DoABC#2)
// _toolbar = "_-1LG" (String#93, DoABC#2)
// detachExtension = "_-gb" (String#8524, DoABC#2)
// attachExtension = "_-01F" (String#3587, DoABC#2)
// EVE_EXTENSION_VIEW_RESIZED = "_-tG" (String#24417, DoABC#2)
// _SafeStr_9058 = "_-MM" (String#23098, DoABC#2)


