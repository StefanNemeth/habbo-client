
package com.sulake.habbo.notifications
{
    public class HabboNotificationItem 
    {

        private var _style:HabboNotificationItemStyle;
        private var _content:String;
        private var _component:HabboNotifications;

        public function HabboNotificationItem(_arg_1:String, _arg_2:HabboNotificationItemStyle, _arg_3:HabboNotifications)
        {
            this._content = _arg_1;
            this._style = _arg_2;
            this._component = _arg_3;
        }
        public function get style():HabboNotificationItemStyle
        {
            return (this._style);
        }
        public function get content():String
        {
            return (this._content);
        }
        public function dispose():void
        {
            this._content = null;
            if (this._style != null){
                this._style.dispose();
                this._style = null;
            };
            this._component = null;
        }
        public function ExecuteUiLinks():void
        {
            var _local_2:String;
            var _local_1:Array = this._style.componentLinks;
            for each (_local_2 in _local_1) {
                if (this._component != null){
                    this._component.onExecuteLink(_local_2);
                };
            };
        }

    }
}//package com.sulake.habbo.notifications

// ExecuteUiLinks = "_-21S" (String#19071, DoABC#2)
// componentLinks = "_-1Ov" (String#17465, DoABC#2)
// onExecuteLink = "_-2UN" (String#20215, DoABC#2)
// HabboNotificationItem = "_-0sR" (String#4694, DoABC#2)
// HabboNotificationItemStyle = "_-3DT" (String#7585, DoABC#2)
// _style = "_-1AT" (String#599, DoABC#2)
// _content = "_-o4" (String#96, DoABC#2)
// _component = "_-2cU" (String#305, DoABC#2)


