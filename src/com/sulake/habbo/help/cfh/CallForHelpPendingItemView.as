
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
    import default.DeletePendingCallsForHelpMessageComposer;
    import com.sulake.habbo.help.enum.HabboHelpViewEnum;

    public class CallForHelpPendingItemView extends HelpViewController implements IHelpViewController 
    {

        public function CallForHelpPendingItemView(_arg_1:HelpUI, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary)
        {
            super(_arg_1, _arg_2, _arg_3);
        }
        override public function render():void
        {
            super.render();
            if (container != null){
                container.dispose();
            };
            container = (buildXmlWindow("help_cfh_pending") as IWindowContainer);
            if (container == null){
                return;
            };
            var _local_1:IWindow = container.findChildByName("cfh_delete");
            if (_local_1 != null){
                _local_1.setParamFlag(WindowParam._SafeStr_7434);
                _local_1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onDelete);
            };
            var _local_2:IWindow = container.findChildByName("cfh_cancel");
            if (_local_2 != null){
                _local_2.setParamFlag(WindowParam._SafeStr_7434);
                _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onCancel);
            };
        }
        private function onDelete(_arg_1:WindowMouseEvent):void
        {
            main.sendMessage(new DeletePendingCallsForHelpMessageComposer());
        }
        private function onCancel(_arg_1:WindowMouseEvent):void
        {
            main.showUI(HabboHelpViewEnum.HHVE_HELP_FRONTPAGE);
        }

    }
}//package com.sulake.habbo.help.cfh

// onDelete = "_-1Fj" (String#17104, DoABC#2)
// HabboHelpViewEnum = "_-1e7" (String#18062, DoABC#2)
// IHelpViewController = "_-0cs" (String#4364, DoABC#2)
// HelpViewController = "_-IY" (String#8052, DoABC#2)
// CallForHelpPendingItemView = "_-1YW" (String#5531, DoABC#2)
// DeletePendingCallsForHelpMessageComposer = "_-23Z" (String#19157, DoABC#2)
// onCancel = "_-3JX" (String#633, DoABC#2)
// _SafeStr_7434 = "_-2xA" (String#21356, DoABC#2)
// HHVE_HELP_FRONTPAGE = "_-2WD" (String#20292, DoABC#2)


