
package com.sulake.habbo.navigator
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IInteractiveWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.*;
    import com.sulake.core.window.events.*;
    import com.sulake.core.window.*;
    import com.sulake.core.window.enum.*;

    public class UserCountRenderer 
    {

        public static const _SafeStr_12019:String = "usercount";

        private var _navigator:HabboNavigator;

        public function UserCountRenderer(_arg_1:HabboNavigator)
        {
            this._navigator = _arg_1;
        }
        public function dispose():void
        {
            this._navigator = null;
        }
        public function refreshUserCount(_arg_1:int, _arg_2:IWindowContainer, _arg_3:int, _arg_4:String, _arg_5:int, _arg_6:int):void
        {
            var _local_7:IWindowContainer = IWindowContainer(_arg_2.findChildByName(_SafeStr_12019));
            if (_local_7 == null){
                _local_7 = IWindowContainer(this._navigator.getXmlWindow("grs_usercount"));
                _local_7.name = _SafeStr_12019;
                _local_7.x = _arg_5;
                _local_7.y = _arg_6;
                _arg_2.addChild(_local_7);
            };
            IInteractiveWindow(_local_7).toolTipCaption = _arg_4;
            var _local_8:ITextWindow = ITextWindow(_local_7.findChildByName("txt"));
            _local_8.text = ("" + _arg_3);
            var _local_9:String = this.getBgColor(_arg_1, _arg_3);
            this.refreshBg(_local_7, _local_9);
            _local_7.visible = true;
        }
        private function getBgColor(_arg_1:int, _arg_2:int):String
        {
            if (_arg_2 == 0){
                return ("b");
            };
            if (this.isOverBgColorLimit(_arg_1, _arg_2, "red", 92)){
                return ("r");
            };
            if (this.isOverBgColorLimit(_arg_1, _arg_2, "orange", 80)){
                return ("o");
            };
            if (this.isOverBgColorLimit(_arg_1, _arg_2, "yellow", 50)){
                return ("y");
            };
            return ("g");
        }
        private function isOverBgColorLimit(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int):Boolean
        {
            var _local_5:String = ("navigator.colorlimit." + _arg_3);
            var _local_6:int = int(this._navigator.configuration.getKey(_local_5, ("" + _arg_4)));
            var _local_7:int = ((_arg_1 * _local_6) / 100);
            return ((_arg_2 >= _local_7));
        }
        private function refreshBg(_arg_1:IWindowContainer, _arg_2:String):void
        {
            var _local_4:String;
            var _local_3:IBitmapWrapperWindow = IBitmapWrapperWindow(_arg_1.findChildByName("usercount_bg"));
            if (_local_3.tags[0] != _arg_2){
                Logger.log(("Redraw usercount bg: " + _arg_2));
                _local_3.tags.splice(0, _local_3.tags.length);
                _local_3.tags.push(_arg_2);
                _local_4 = ("usercount_fixed_" + _arg_2);
                _local_3.bitmap = this._navigator.getButtonImage(_local_4);
                _local_3.invalidate();
            };
        }
        private function refreshIcon(_arg_1:IWindowContainer, _arg_2:String, _arg_3:Boolean):void
        {
            this._navigator.refreshButton(_arg_1, _arg_2, _arg_3, null, 0);
        }

    }
}//package com.sulake.habbo.navigator

// refreshIcon = "_-3EX" (String#7603, DoABC#2)
// _SafeStr_12019 = "_-2wi" (String#21335, DoABC#2)
// isOverBgColorLimit = "_-33E" (String#21630, DoABC#2)
// IInteractiveWindow = "_-0KX" (String#1454, DoABC#2)
// UserCountRenderer = "_-LP" (String#8111, DoABC#2)
// getBgColor = "_-1GR" (String#600, DoABC#2)
// refreshUserCount = "_-2dF" (String#6816, DoABC#2)
// refreshBg = "_-1PW" (String#5343, DoABC#2)
// toolTipCaption = "_-0cC" (String#4347, DoABC#2)


