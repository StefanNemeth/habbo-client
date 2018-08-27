
package com.sulake.habbo.help.help
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Dictionary;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class HelpViewController implements IHelpViewController 
    {

        private var _help:HelpUI;
        private var _windowManager:IHabboWindowManager;
        private var _assetLibrary:IAssetLibrary;
        private var _container:IWindowContainer;
        private var _roomSessionActive:Boolean = false;
        private var _disposed:Boolean = true;

        public function HelpViewController(_arg_1:HelpUI, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary)
        {
            this._help = _arg_1;
            this._windowManager = _arg_2;
            this._assetLibrary = _arg_3;
        }
        public function dispose():void
        {
            if (this._container != null){
                this._container.dispose();
                this._container = null;
            };
            this._disposed = true;
        }
        public function render():void
        {
            this._disposed = false;
        }
        public function update(_arg_1:*=null):void
        {
        }
        public function get container():IWindowContainer
        {
            return (this._container);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get main():HelpUI
        {
            return (this._help);
        }
        public function get windowManager():IHabboWindowManager
        {
            return (this._windowManager);
        }
        public function get assetLibrary():IAssetLibrary
        {
            return (this._assetLibrary);
        }
        public function get roomSessionActive():Boolean
        {
            return (this._roomSessionActive);
        }
        public function set container(_arg_1:IWindowContainer):void
        {
            this._container = _arg_1;
        }
        public function set disposed(_arg_1:Boolean):void
        {
            this._disposed = _arg_1;
        }
        public function set roomSessionActive(_arg_1:Boolean):void
        {
            this._roomSessionActive = _arg_1;
        }
        public function getWindowContainer():IWindowContainer
        {
            return (this._container);
        }
        public function getText(_arg_1:String):String
        {
            if (this._help == null){
                return (null);
            };
            return (this._help.getText(_arg_1));
        }
        public function getConfigurationKey(_arg_1:String, _arg_2:String=null, _arg_3:Dictionary=null):String
        {
            if (this._help == null){
                return (null);
            };
            return (this._help.getConfigurationKey(_arg_1, _arg_2, _arg_3));
        }
        public function buildXmlWindow(_arg_1:String):IWindow
        {
            var _local_2:XmlAsset = XmlAsset(this._assetLibrary.getAssetByName((_arg_1 + "_xml")));
            if ((((_local_2 == null)) || ((this._windowManager == null)))){
                return (null);
            };
            return (this._windowManager.buildFromXML(XML(_local_2.content)));
        }
        protected function buildHelpCategoryListEntryItem(_arg_1:String, _arg_2:String, _arg_3:Function=null):IWindowContainer
        {
            var _local_6:IWindow;
            var _local_4:IWindowContainer = (this.buildXmlWindow(_arg_2) as IWindowContainer);
            if (_local_4 == null){
                return (null);
            };
            var _local_5:ITextWindow = (_local_4.findChildByTag("text") as ITextWindow);
            if (_local_5 == null){
                return (null);
            };
            _local_5.text = _arg_1;
            if (_arg_3 != null){
                _local_6 = (_local_4.findChildByName("item_bg") as IWindow);
                if (_local_6 != null){
                    _local_6.setParamFlag(WindowParam._SafeStr_7434);
                    _local_6.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, _arg_3);
                };
            };
            return (_local_4);
        }

    }
}//package com.sulake.habbo.help.help

// buildHelpCategoryListEntryItem = "_-Lh" (String#23070, DoABC#2)
// roomSessionActive = "_-4g" (String#7760, DoABC#2)
// _help = "_-3HG" (String#114, DoABC#2)
// _roomSessionActive = "_-2WF" (String#20293, DoABC#2)
// IHelpViewController = "_-0cs" (String#4364, DoABC#2)
// HelpViewController = "_-IY" (String#8052, DoABC#2)
// getWindowContainer = "_-v8" (String#313, DoABC#2)
// _SafeStr_7434 = "_-2xA" (String#21356, DoABC#2)


