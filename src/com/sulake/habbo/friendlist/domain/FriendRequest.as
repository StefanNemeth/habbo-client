
package com.sulake.habbo.friendlist.domain
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestData;

    public class FriendRequest implements IDisposable 
    {

        public static const _SafeStr_7173:int = 1;
        public static const _SafeStr_11184:int = 2;
        public static const _SafeStr_11185:int = 3;
        public static const _state:int = 4;

        private var _requestId:int;
        private var _requesterName:String;
        private var _requesterUserId:int;
        private var _state:int = 1;
        private var _disposed:Boolean;
        private var _view:IWindowContainer;

        public function FriendRequest(_arg_1:FriendRequestData)
        {
            this._requestId = _arg_1.requestId;
            this._requesterName = _arg_1.requesterName;
            this._requesterUserId = _arg_1.requesterUserId;
        }
        public function dispose():void
        {
            if (this._disposed){
                return;
            };
            this._disposed = true;
            if (this.view != null){
                this.view.destroy();
                this.view = null;
            };
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get requestId():int
        {
            return (this._requestId);
        }
        public function get requesterName():String
        {
            return (this._requesterName);
        }
        public function get requesterUserId():int
        {
            return (this._requesterUserId);
        }
        public function get view():IWindowContainer
        {
            return (this._view);
        }
        public function get state():int
        {
            return (this._state);
        }
        public function set view(_arg_1:IWindowContainer):void
        {
            this._view = _arg_1;
        }
        public function set state(_arg_1:int):void
        {
            this._state = _arg_1;
        }

    }
}//package com.sulake.habbo.friendlist.domain

// _requesterName = "_-2vo" (String#7195, DoABC#2)
// _requesterUserId = "_-31V" (String#7336, DoABC#2)
// requesterUserId = "_-3Gh" (String#22150, DoABC#2)
// _state = "_-1f4" (String#18101, DoABC#2)
// _SafeStr_11184 = "_-1pF" (String#18511, DoABC#2)
// _SafeStr_11185 = "_-2Nc" (String#19949, DoABC#2)
// FriendRequestData = "_-1aw" (String#17931, DoABC#2)
// FriendRequest = "_-2Nq" (String#887, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _requestId = "_-1GH" (String#301, DoABC#2)
// requestId = "_-li" (String#24099, DoABC#2)
// requesterName = "_-1ki" (String#18318, DoABC#2)
// destroy = "_-25R" (String#615, DoABC#2)
// _SafeStr_7173 = "_-bS" (String#23691, DoABC#2)


