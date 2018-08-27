
package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;

    public class PurseCatalogWidget extends CatalogWidget implements ICatalogWidget 
    {

        public function PurseCatalogWidget(_arg_1:IWindowContainer)
        {
            super(_arg_1);
        }
        override public function dispose():void
        {
            super.dispose();
        }
        override public function init():Boolean
        {
            var _local_2:String;
            var _local_3:ITextWindow;
            var _local_4:ITextWindow;
            var _local_5:ITextWindow;
            var _local_6:IButtonWindow;
            if (!super.init()){
                return (false);
            };
            var _local_1:Array = ["vouchers_btn", "coins_btn"];
            for each (_local_2 in _local_1) {
                _local_6 = (_window.findChildByName(_local_2) as IButtonWindow);
                if (_local_6 != null){
                    _local_6.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseClick);
                };
            };
            _local_3 = (_window.findChildByName("purse_info_tickets") as ITextWindow);
            _local_4 = (_window.findChildByName("purse_info_film") as ITextWindow);
            _local_5 = (_window.findChildByName("purse_amount") as ITextWindow);
            _local_5.text = page.viewer.catalog.getPurse().credits.toString();
            return (true);
        }
        private function onMouseClick(event:WindowMouseEvent):void
        {
            var element:IWindow = (event.target as IWindow);
            var id:String = element.name;
            switch (id){
                case "vouchers_btn":
                    page.viewer.catalog.windowManager.alert("Purse Voucher", "Vouchers clicked", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                    {
                        _arg_1.dispose();
                    });
                    return;
                case "coins_btn":
                    page.viewer.catalog.windowManager.alert("Purse Credits", "Credits clicked", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                    {
                        _arg_1.dispose();
                    });
                    return;
                default:
                    Logger.log("PurseCatalogWidget: unknonwn button");
            };
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// CatalogWidget = "_-1pJ" (String#5844, DoABC#2)
// ICatalogWidget = "_-016" (String#3585, DoABC#2)
// PurseCatalogWidget = "_-3I4" (String#22204, DoABC#2)
// onMouseClick = "_-0Kd" (String#584, DoABC#2)


