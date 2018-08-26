
package com.sulake.habbo.ui.widget.avatarinfo
{
    public class FriendNameView extends AvatarInfoView 
    {

        private var _objectId:int;

        public function FriendNameView(_arg_1:AvatarInfoWidget)
        {
            super(_arg_1);
        }
        public static function setup(_arg_1:FriendNameView, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:int, _arg_6:int):void
        {
            _arg_1._objectId = _arg_6;
            _arg_1._SafeStr_6835 = 8000;
            AvatarInfoView.setup(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, false);
            _arg_1._window.color = 4288528218;
        }

        public function get objectId():int
        {
            return (this._objectId);
        }
        override public function dispose():void
        {
            super.dispose();
        }

    }
}//package com.sulake.habbo.ui.widget.avatarinfo

// AvatarInfoWidget = "_-3Bt" (String#7549, DoABC#2)
// AvatarInfoView = "_-1fg" (String#5659, DoABC#2)
// FriendNameView = "_-zr" (String#8880, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// _SafeStr_6835 = "_-20o" (String#19044, DoABC#2)


