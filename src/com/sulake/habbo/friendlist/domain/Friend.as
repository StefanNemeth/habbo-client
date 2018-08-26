
package com.sulake.habbo.friendlist.domain
{
    import com.sulake.habbo.friendlist.IFriend;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import flash.display.BitmapData;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendData;

    public class Friend implements IFriend, IDisposable 
    {

        public static const _SafeStr_11186:int = "F".charCodeAt(0);
        public static const _realName:int = "M".charCodeAt(0);

        private var _id:int;
        private var _name:String;
        private var _gender:int;
        private var _online:Boolean;
        private var _followingAllowed:Boolean;
        private var _figure:String;
        private var _motto:String;
        private var _lastAccess:String;
        private var _categoryId:int;
        private var _selected:Boolean;
        private var _disposed:Boolean;
        private var _view:IWindowContainer;
        private var _face:BitmapData;
        private var _realName:String;

        public function Friend(_arg_1:FriendData)
        {
            if (_arg_1 == null){
                return;
            };
            this._id = _arg_1.id;
            this._name = _arg_1.name;
            this._gender = _arg_1.gender;
            this._online = _arg_1.online;
            this._followingAllowed = ((_arg_1.followingAllowed) && (_arg_1.online));
            this._figure = _arg_1.figure;
            this._motto = _arg_1.motto;
            this._lastAccess = _arg_1.lastAccess;
            this._categoryId = _arg_1.categoryId;
            this._realName = _arg_1.realName;
            Logger.log(((((((((((((("Creating friend: " + this.id) + ", ") + this.name) + ", ") + this.gender) + ", ") + this.online) + ", ") + this.followingAllowed) + ", ") + this.figure) + ", ") + this.categoryId));
        }
        public function dispose():void
        {
            if (this._disposed){
                return;
            };
            if (this._face != null){
                this._face.dispose();
                this._face = null;
            };
            this._disposed = true;
            this._view = null;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get gender():int
        {
            return (this._gender);
        }
        public function get online():Boolean
        {
            return (this._online);
        }
        public function get followingAllowed():Boolean
        {
            return (this._followingAllowed);
        }
        public function get figure():String
        {
            return (this._figure);
        }
        public function get motto():String
        {
            return (this._motto);
        }
        public function get lastAccess():String
        {
            return (this._lastAccess);
        }
        public function get categoryId():int
        {
            return (this._categoryId);
        }
        public function get selected():Boolean
        {
            return (this._selected);
        }
        public function get view():IWindowContainer
        {
            return (this._view);
        }
        public function get face():BitmapData
        {
            return (this._face);
        }
        public function get realName():String
        {
            return (this._realName);
        }
        public function set id(_arg_1:int):void
        {
            this._id = _arg_1;
        }
        public function set name(_arg_1:String):void
        {
            this._name = _arg_1;
        }
        public function set gender(_arg_1:int):void
        {
            this._gender = _arg_1;
        }
        public function set online(_arg_1:Boolean):void
        {
            this._online = _arg_1;
        }
        public function set followingAllowed(_arg_1:Boolean):void
        {
            this._followingAllowed = _arg_1;
        }
        public function set figure(_arg_1:String):void
        {
            this._figure = _arg_1;
        }
        public function set motto(_arg_1:String):void
        {
            this._motto = _arg_1;
        }
        public function set lastAccess(_arg_1:String):void
        {
            this._lastAccess = _arg_1;
        }
        public function set categoryId(_arg_1:int):void
        {
            this._categoryId = _arg_1;
        }
        public function set selected(_arg_1:Boolean):void
        {
            this._selected = _arg_1;
        }
        public function set view(_arg_1:IWindowContainer):void
        {
            this._view = _arg_1;
        }
        public function set face(_arg_1:BitmapData):void
        {
            this._face = _arg_1;
        }
        public function set realName(_arg_1:String):void
        {
            this._realName = _arg_1;
        }

    }
}//package com.sulake.habbo.friendlist.domain

// _lastAccess = "_-jH" (String#943, DoABC#2)
// lastAccess = "_-Es" (String#7968, DoABC#2)
// _SafeStr_11186 = "_-g1" (String#23892, DoABC#2)
// _realName = "_-1EZ" (String#17051, DoABC#2)
// _face = "_-2ge" (String#20717, DoABC#2)
// IFriend = "_-2ET" (String#6332, DoABC#2)
// FriendData = "_-XR" (String#23541, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _gender = "_-a0" (String#95, DoABC#2)
// _motto = "_-2ti" (String#453, DoABC#2)
// _figure = "_-20u" (String#75, DoABC#2)
// realName = "_-3HH" (String#922, DoABC#2)
// followingAllowed = "_-1-Z" (String#1598, DoABC#2)
// _followingAllowed = "_-0eO" (String#1518, DoABC#2)
// _categoryId = "_-1If" (String#186, DoABC#2)
// _online = "_-0-Y" (String#573, DoABC#2)


