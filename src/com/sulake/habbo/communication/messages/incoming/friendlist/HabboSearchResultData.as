
package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboSearchResultData 
    {

        private var _avatarId:int;
        private var _avatarName:String;
        private var _avatarMotto:String;
        private var _isAvatarOnline:Boolean;
        private var _canFollow:Boolean;
        private var _avatarGender:int;
        private var _avatarFigure:String;
        private var _lastOnlineDate:String;
        private var _realName:String;

        public function HabboSearchResultData(_arg_1:IMessageDataWrapper)
        {
            this._avatarId = _arg_1.readInteger();
            this._avatarName = _arg_1.readString();
            this._avatarMotto = _arg_1.readString();
            this._isAvatarOnline = _arg_1.readBoolean();
            this._canFollow = _arg_1.readBoolean();
            _arg_1.readString();
            this._avatarGender = _arg_1.readInteger();
            this._avatarFigure = _arg_1.readString();
            this._lastOnlineDate = _arg_1.readString();
            this._realName = _arg_1.readString();
        }
        public function get avatarId():int
        {
            return (this._avatarId);
        }
        public function get avatarName():String
        {
            return (this._avatarName);
        }
        public function get avatarMotto():String
        {
            return (this._avatarMotto);
        }
        public function get isAvatarOnline():Boolean
        {
            return (this._isAvatarOnline);
        }
        public function get canFollow():Boolean
        {
            return (this._canFollow);
        }
        public function get avatarGender():int
        {
            return (this._avatarGender);
        }
        public function get avatarFigure():String
        {
            return (this._avatarFigure);
        }
        public function get lastOnlineDate():String
        {
            return (this._lastOnlineDate);
        }
        public function get realName():String
        {
            return (this._realName);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.friendlist

// _avatarName = "_-0Nn" (String#4039, DoABC#2)
// _avatarMotto = "_-x7" (String#8827, DoABC#2)
// _isAvatarOnline = "_-1Qb" (String#17537, DoABC#2)
// _canFollow = "_-171" (String#16737, DoABC#2)
// _avatarGender = "_-0AW" (String#14468, DoABC#2)
// _avatarFigure = "_-0Zt" (String#4296, DoABC#2)
// _lastOnlineDate = "_-3LW" (String#22346, DoABC#2)
// avatarName = "_-ei" (String#23831, DoABC#2)
// avatarMotto = "_-2Ab" (String#19430, DoABC#2)
// isAvatarOnline = "_-0CQ" (String#14546, DoABC#2)
// canFollow = "_-07D" (String#14333, DoABC#2)
// avatarGender = "_-2qC" (String#21089, DoABC#2)
// lastOnlineDate = "_-kw" (String#24068, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// HabboSearchResultData = "_-1Ub" (String#5446, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// realName = "_-3HH" (String#922, DoABC#2)
// _avatarId = "_-0qk" (String#592, DoABC#2)


