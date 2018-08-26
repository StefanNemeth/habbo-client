
package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;

    public class MadMoneyCatalogWidget extends CatalogWidget implements ICatalogWidget 
    {

        private var _SafeStr_10494:IButtonWindow;

        public function MadMoneyCatalogWidget(_arg_1:IWindowContainer)
        {
            super(_arg_1);
        }
        override public function dispose():void
        {
            super.dispose();
            if (this._SafeStr_10494 != null){
                this._SafeStr_10494.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.eventProc);
                this._SafeStr_10494 = null;
            };
        }
        override public function init():Boolean
        {
            if (!super.init()){
                return (false);
            };
            this._SafeStr_10494 = (_window.findChildByName("ctlg_madmoney_button") as IButtonWindow);
            if (this._SafeStr_10494 != null){
            };
            return (true);
        }
        private function eventProc(event:WindowMouseEvent):void
        {
            page.viewer.catalog.windowManager.alert("TODO", "Fix in MadMoneyCatalogWidget.as", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
            {
                _arg_1.dispose();
            });
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets

// _SafeStr_10494 = "_-15L" (String#16667, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// CatalogWidget = "_-1pJ" (String#5844, DoABC#2)
// ICatalogWidget = "_-016" (String#3585, DoABC#2)
// MadMoneyCatalogWidget = "_-hh" (String#23954, DoABC#2)
// eventProc = "_-0xb" (String#1584, DoABC#2)


