
package com.sulake.habbo.toolbar.extensions.purse
{
    import com.sulake.core.window.components.IItemGridWindow;
    import __AS3__.vec.Vector;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.toolbar.extensions.purse.indicators.CreditsIndicator;
    import com.sulake.habbo.toolbar.extensions.purse.indicators.ClubDaysIndicator;
    import com.sulake.habbo.toolbar.extensions.purse.indicators.ShellsIndicator;
    import com.sulake.habbo.toolbar.extensions.purse.indicators.PixelsIndicator;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.core.window.IWindow;
    import flash.events.IEventDispatcher;
    import __AS3__.vec.*;

    public class PurseExtension 
    {

        private var _window:IItemGridWindow;
        private var _SafeStr_13729:Vector.<ICurrencyIndicator>;
        private var _disposed:Boolean = false;

        public function PurseExtension(_arg_1:IHabboWindowManager, _arg_2:IAssetLibrary, _arg_3:IHabboConfigurationManager, _arg_4:IHabboCatalog, _arg_5:IHabboInventory, _arg_6:ICoreLocalizationManager)
        {
            this._SafeStr_13729 = new Vector.<ICurrencyIndicator>();
            super();
            var _local_7:XmlAsset = (_arg_2.getAssetByName("purse_xml") as XmlAsset);
            if (_local_7){
                this._window = (_arg_1.buildFromXML((_local_7.content as XML), 1) as IItemGridWindow);
                if (this._window){
                    this.PurseExtension(this._window, (new CreditsIndicator(_arg_1, _arg_2, _arg_4, _arg_6) as ICurrencyIndicator), _arg_4.events);
                    this.PurseExtension(this._window, (new ClubDaysIndicator(_arg_1, _arg_2, _arg_4, _arg_5, _arg_6) as ICurrencyIndicator), _arg_5.events);
                    if (_arg_3.getKey("purse.widget.currency.shells.enabled", "0") == "1"){
                        this.PurseExtension(this._window, (new ShellsIndicator(_arg_1, _arg_2, _arg_4, _arg_6) as ICurrencyIndicator), _arg_4.events);
                    };
                    this.PurseExtension(this._window, (new PixelsIndicator(_arg_1, _arg_2, _arg_4, _arg_6) as ICurrencyIndicator), _arg_4.events);
                };
                this._window.x = 0;
                this._window.y = 0;
                this._window.visible = true;
            };
        }
        public function get window():IWindow
        {
            return (this._window);
        }
        public function dispose():void
        {
            var _local_1:ICurrencyIndicator;
            if (!this._disposed){
                if (this._SafeStr_13729){
                    for each (_local_1 in this._SafeStr_13729) {
                        _local_1.dispose();
                    };
                    this._SafeStr_13729 = null;
                };
                this._disposed = true;
            };
        }
        private function PurseExtension(_arg_1:IItemGridWindow, _arg_2:ICurrencyIndicator, _arg_3:IEventDispatcher):void
        {
            if (_arg_2.view){
                _arg_1.IItemGridWindow(_arg_2.view);
                _arg_2.RoomChatWidget(_arg_3);
                this._SafeStr_13729.push(_arg_2);
            }
            else {
                Logger.log("ERROR: currency indicator view was null!");
            };
        }

    }
}//package com.sulake.habbo.toolbar.extensions.purse

// _SafeStr_13729 = "_-0XD" (String#15323, DoABC#2)
// PurseExtension = "_-16k" (String#16725, DoABC#2)
// IItemGridWindow = "_-265" (String#1809, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// PurseExtension = "_-0kV" (String#4510, DoABC#2)
// ShellsIndicator = "_-2HW" (String#6394, DoABC#2)
// PixelsIndicator = "_-19r" (String#5074, DoABC#2)
// ClubDaysIndicator = "_-Vj" (String#8315, DoABC#2)
// CreditsIndicator = "_-0zT" (String#4838, DoABC#2)
// RoomChatWidget = "_-1yD" (String#1787, DoABC#2)
// IItemGridWindow = "_-2vh" (String#7192, DoABC#2)
// IHabboInventory = "_-ud" (String#8776, DoABC#2)


