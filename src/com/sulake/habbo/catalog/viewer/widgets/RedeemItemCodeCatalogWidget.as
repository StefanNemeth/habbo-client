
package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import flash.ui.Keyboard;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.window.utils.IAlertDialog;

    public class RedeemItemCodeCatalogWidget extends CatalogWidget implements ICatalogWidget 
    {

        private var _SafeStr_10491:IButtonWindow;
        private var _SafeStr_10492:ITextFieldWindow;

        public function RedeemItemCodeCatalogWidget(_arg_1:IWindowContainer)
        {
            super(_arg_1);
        }
        override public function dispose():void
        {
            super.dispose();
            if (this._SafeStr_10491 != null){
                this._SafeStr_10491.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onRedeem);
                this._SafeStr_10491 = null;
            };
            if (this._SafeStr_10492 != null){
                this._SafeStr_10492.removeEventListener(WindowKeyboardEvent.WKE_KEY_DOWN, this.windowKeyEventProcessor);
                this._SafeStr_10492 = null;
            };
        }
        override public function init():Boolean
        {
            if (!super.init()){
                return (false);
            };
            this._SafeStr_10491 = (_window.findChildByName("redeem") as IButtonWindow);
            if (this._SafeStr_10491 != null){
                this._SafeStr_10491.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onRedeem);
            };
            this._SafeStr_10492 = (_window.findChildByName("voucher_code") as ITextFieldWindow);
            if (this._SafeStr_10492 != null){
                this._SafeStr_10492.addEventListener(WindowKeyboardEvent.WKE_KEY_DOWN, this.windowKeyEventProcessor);
            };
            return (true);
        }
        private function onRedeem(_arg_1:WindowMouseEvent):void
        {
            this.redeem();
        }
        private function windowKeyEventProcessor(_arg_1:WindowEvent=null, _arg_2:IWindow=null):void
        {
            var _local_3:WindowKeyboardEvent = (_arg_1 as WindowKeyboardEvent);
            if (_local_3.charCode == Keyboard.ENTER){
                this.redeem();
            };
        }
        private function redeem():void
        {
            var voucher:String;
            var input:ITextFieldWindow = (_window.findChildByName("voucher_code") as ITextFieldWindow);
            if (input != null){
                voucher = input.text;
                if (voucher.length > 0){
                    page.viewer.catalog.redeemVoucher(voucher);
                    input.text = "";
                }
                else {
                    page.viewer.catalog.windowManager.alert("${catalog.voucher.empty.title}", "${catalog.voucher.empty.desc}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                    {
                        _arg_1.dispose();
                    });
                };
            };
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets

// _SafeStr_10491 = "_-162" (String#16698, DoABC#2)
// _SafeStr_10492 = "_-fF" (String#23857, DoABC#2)
// onRedeem = "_-1zy" (String#18966, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// ITextFieldWindow = "_-3EL" (String#2027, DoABC#2)
// WindowKeyboardEvent = "_-0Di" (String#1433, DoABC#2)
// CatalogWidget = "_-1pJ" (String#5844, DoABC#2)
// ICatalogWidget = "_-016" (String#3585, DoABC#2)
// RedeemItemCodeCatalogWidget = "_-2hi" (String#20762, DoABC#2)
// WKE_KEY_DOWN = "_-fs" (String#23884, DoABC#2)
// windowKeyEventProcessor = "_-rC" (String#8727, DoABC#2)


