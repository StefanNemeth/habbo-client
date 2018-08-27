
package com.sulake.habbo.notifications
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class MOTDNotification 
    {

        private const _SafeStr_12098:int = 20;

        private var _window:IFrameWindow;
        private var _localizations:IHabboLocalizationManager;
        private var _messages:Array;

        public function MOTDNotification(_arg_1:Array, _arg_2:IAssetLibrary, _arg_3:IHabboWindowManager)
        {
            var _local_8:String;
            var _local_9:IWindowContainer;
            var _local_10:ITextWindow;
            super();
            if (((!(_arg_3)) || (!(_arg_2)))){
                return;
            };
            this._messages = _arg_1;
            var _local_4:XmlAsset = (_arg_2.getAssetByName("motd_notification_xml") as XmlAsset);
            if (_local_4 == null){
                return;
            };
            this._window = (_arg_3.buildFromXML((_local_4.content as XML)) as IFrameWindow);
            if (this._window == null){
                return;
            };
            this._window.procedure = this.eventHandler;
            this._window.center();
            var _local_5:XmlAsset = (_arg_2.getAssetByName("motd_notification_item_xml") as XmlAsset);
            if (_local_5 == null){
                return;
            };
            var _local_6:IWindowContainer = (_arg_3.buildFromXML((_local_5.content as XML)) as IWindowContainer);
            var _local_7:IItemListWindow = (this._window.findChildByName("message_list") as IItemListWindow);
            for each (_local_8 in this._messages) {
                _local_9 = (_local_6.clone() as IWindowContainer);
                _local_10 = (_local_9.findChildByName("message_text") as ITextWindow);
                _local_10.text = _local_8;
                _local_9.height = (_local_10.textHeight + this._SafeStr_12098);
                _local_7.addListItem(_local_9);
            };
        }
        public function dispose():void
        {
            if (this._window != null){
                this._window.dispose();
                this._window = null;
            };
            this._localizations = null;
        }
        private function eventHandler(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            switch (_arg_2.name){
                case "close":
                case "header_button_close":
                    this.dispose();
                    return;
            };
        }

    }
}//package com.sulake.habbo.notifications

// _SafeStr_12098 = "_-rS" (String#24336, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// MOTDNotification = "_-298" (String#6231, DoABC#2)
// eventHandler = "_-34P" (String#217, DoABC#2)
// _messages = "_-1AO" (String#835, DoABC#2)
// _localizations = "_-0il" (String#358, DoABC#2)


