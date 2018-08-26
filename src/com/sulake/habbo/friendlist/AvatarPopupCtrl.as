
package com.sulake.habbo.friendlist
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;

    public class AvatarPopupCtrl extends PopupCtrl 
    {

        private var _online:Boolean;
        private var _avatarName:String;
        private var _avatarMotto:String;
        private var _avatarFigure:String;
        private var _realName:String;
        private var _lastAccess:String;

        public function AvatarPopupCtrl(_arg_1:HabboFriendList)
        {
            super(_arg_1, 5, -5, "avatar_popup");
        }
        public function setData(_arg_1:Boolean, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:String=""):void
        {
            this._online = _arg_1;
            this._avatarName = _arg_2;
            this._avatarMotto = _arg_3;
            this._avatarFigure = _arg_4;
            this._lastAccess = _arg_5;
            this._realName = _arg_6;
        }
        override public function refreshContent(_arg_1:IWindowContainer):void
        {
            Util.InfostandWidget(_arg_1);
            if (this._realName != ""){
                friendList.refreshText(_arg_1, "name_text_online", this._online, this._realName);
            }
            else {
                friendList.refreshText(_arg_1, "name_text_online", this._online, this._avatarName);
            };
            friendList.refreshText(_arg_1, "name_text_offline", !(this._online), this._avatarName);
            friendList.refreshText(_arg_1, "motto_text", this._online, this._avatarMotto);
            friendList.refreshButton(_arg_1, "offline", !(this._online), null, 0);
            if (this._online){
                this.refreshFigure(_arg_1, this._avatarFigure);
                _arg_1.findChildByName("online_text").visible = true;
            }
            else {
                _arg_1.findChildByName("last_access_text").visible = true;
                friendList.registerParameter("friendlist.avatarpopup.lastaccess", "last_access", (((this._lastAccess == null)) ? "" : this._lastAccess));
            };
            _arg_1.height = (Util.getLowestPoint(_arg_1) + 10);
        }
        private function refreshFigure(_arg_1:IWindowContainer, _arg_2:String):void
        {
            var _local_3:IBitmapWrapperWindow = (_arg_1.getChildByName(HabboFriendList._SafeStr_11259) as IBitmapWrapperWindow);
            if (_local_3 == null){
                return;
            };
            if ((((_arg_2 == null)) || ((_arg_2 == "")))){
                _local_3.visible = false;
            }
            else {
                _local_3.bitmap = friendList.getAvatarFaceBitmap(_arg_2);
                if (_local_3.bitmap == null){
                    return;
                };
                _local_3.width = _local_3.bitmap.width;
                _local_3.height = _local_3.bitmap.height;
                _local_3.visible = true;
            };
        }

    }
}//package com.sulake.habbo.friendlist

// _lastAccess = "_-jH" (String#943, DoABC#2)
// _avatarName = "_-0Nn" (String#4039, DoABC#2)
// _avatarMotto = "_-x7" (String#8827, DoABC#2)
// _avatarFigure = "_-0Zt" (String#4296, DoABC#2)
// refreshFigure = "_-1JQ" (String#846, DoABC#2)
// _SafeStr_11259 = "_-2en" (String#20637, DoABC#2)
// setData = "_-1x" (String#18846, DoABC#2)
// refreshContent = "_-2Ec" (String#19590, DoABC#2)
// Util = "_-1ve" (String#445, DoABC#2)
// PopupCtrl = "_-0f4" (String#818, DoABC#2)
// AvatarPopupCtrl = "_-17v" (String#5037, DoABC#2)
// InfostandWidget = "_-14q" (String#1615, DoABC#2)
// getLowestPoint = "_-0t0" (String#16161, DoABC#2)
// _online = "_-0-Y" (String#573, DoABC#2)


