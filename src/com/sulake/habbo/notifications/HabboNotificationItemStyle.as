
package com.sulake.habbo.notifications
{
    import flash.display.BitmapData;
    import com.sulake.core.utils.Map;

    public class HabboNotificationItemStyle 
    {

        private var _componentLinks:Array;
        private var _icon:BitmapData;
        private var _SafeStr_12090:Boolean;
        private var _iconSrc:String;

        public function HabboNotificationItemStyle(_arg_1:Map, _arg_2:BitmapData, _arg_3:Boolean, _arg_4:String)
        {
            if (_arg_1 == null){
                this._componentLinks = [];
                this._icon = null;
            }
            else {
                this._componentLinks = _arg_1["uilinks"];
                this._icon = _arg_1["icon"];
            };
            if (_arg_2 != null){
                this._icon = _arg_2;
                this._SafeStr_12090 = _arg_3;
            }
            else {
                this._SafeStr_12090 = false;
            };
            this._iconSrc = _arg_4;
        }
        public function dispose():void
        {
            if (((this._SafeStr_12090) && (!((this._icon == null))))){
                this._icon.dispose();
                this._icon = null;
            };
        }
        public function get icon():BitmapData
        {
            return (this._icon);
        }
        public function get componentLinks():Array
        {
            return (this._componentLinks);
        }
        public function get iconSrc():String
        {
            return (this._iconSrc);
        }

    }
}//package com.sulake.habbo.notifications

// componentLinks = "_-1Ov" (String#17465, DoABC#2)
// _componentLinks = "_-2Il" (String#19759, DoABC#2)
// _SafeStr_12090 = "_-1fb" (String#18122, DoABC#2)
// _iconSrc = "_-3DJ" (String#22008, DoABC#2)
// iconSrc = "_-2xt" (String#21388, DoABC#2)
// HabboNotificationItemStyle = "_-3DT" (String#7585, DoABC#2)


