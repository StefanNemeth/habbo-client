
package com.sulake.habbo.help.tutorial
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class TutorialClothesChangeView implements ITutorialUIView 
    {

        private var _help:TutorialUI;
        private var _SafeStr_11455:IWindowContainer;

        public function TutorialClothesChangeView(_arg_1:IItemListWindow, _arg_2:TutorialUI):void
        {
            this._help = _arg_2;
            var _local_3:IWindowContainer = (_arg_2.buildXmlWindow("tutorial_change_clothes") as IWindowContainer);
            if (_local_3 == null){
                return;
            };
            _local_3.procedure = this.windowProcedure;
            _arg_1.addListItem((_local_3 as IWindow));
            this._help.prepareForTutorial();
        }
        public function get view():IWindowContainer
        {
            return (null);
        }
        public function get id():String
        {
            return (TutorialUI.TUI_CLOTHES_VIEW);
        }
        public function dispose():void
        {
            this._help = null;
            if (this._SafeStr_11455){
                this._SafeStr_11455.dispose();
                this._SafeStr_11455 = null;
            };
        }
        private function windowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            switch (_arg_2.name){
                case "button_cancel":
                    if (_arg_1.type == WindowMouseEvent.WME_DOWN){
                        this._help.showView(TutorialUI.TUI_MAIN_VIEW);
                    };
                    return;
            };
        }

    }
}//package com.sulake.habbo.help.tutorial

// _help = "_-3HG" (String#114, DoABC#2)
// TUI_MAIN_VIEW = "_-0CO" (String#14545, DoABC#2)
// TUI_CLOTHES_VIEW = "_-2a" (String#20440, DoABC#2)
// prepareForTutorial = "_-0Yl" (String#15390, DoABC#2)
// windowProcedure = "_-1tK" (String#869, DoABC#2)
// _SafeStr_11455 = "_-2to" (String#7155, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// TutorialUI = "_-38o" (String#7488, DoABC#2)
// ITutorialUIView = "_-2tN" (String#7145, DoABC#2)
// TutorialClothesChangeView = "_-dF" (String#8473, DoABC#2)
// WME_DOWN = "_-hL" (String#23944, DoABC#2)
// showView = "_-1gE" (String#860, DoABC#2)


