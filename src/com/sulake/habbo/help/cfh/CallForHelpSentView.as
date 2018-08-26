
package com.sulake.habbo.help.cfh
{
    import com.sulake.habbo.help.help.HelpViewController;
    import com.sulake.habbo.help.help.IHelpViewController;
    import com.sulake.habbo.help.help.HelpUI;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class CallForHelpSentView extends HelpViewController implements IHelpViewController 
    {

        private var _SafeStr_5032:String = "";

        public function CallForHelpSentView(_arg_1:HelpUI, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:String)
        {
            super(_arg_1, _arg_2, _arg_3);
            this._SafeStr_5032 = _arg_4;
        }
        override public function render():void
        {
            super.render();
            if (container != null){
                container.dispose();
            };
            container = (buildXmlWindow(this._SafeStr_5032) as IWindowContainer);
            if (container == null){
                return;
            };
            var _local_1:IWindow = container.findChildByTag("close");
            if (_local_1 != null){
                _local_1.setParamFlag(WindowParam._SafeStr_7434);
                _local_1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.PollOfferDialog);
            };
        }
        private function PollOfferDialog(_arg_1:WindowMouseEvent):void
        {
            main.hideUI();
        }

    }
}//package com.sulake.habbo.help.cfh

// IHelpViewController = "_-0cs" (String#4364, DoABC#2)
// HelpViewController = "_-IY" (String#8052, DoABC#2)
// CallForHelpSentView = "_-0am" (String#4318, DoABC#2)
// _SafeStr_5032 = "_-0Tq" (String#4176, DoABC#2)
// PollOfferDialog = "_-2Ts" (String#54, DoABC#2)
// _SafeStr_7434 = "_-2xA" (String#21356, DoABC#2)


