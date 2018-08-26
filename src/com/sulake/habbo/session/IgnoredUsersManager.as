
package com.sulake.habbo.session
{
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.communication.messages.incoming.users.IgnoreResultMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.IgnoredUsersMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.users.GetIgnoredUsersMessageComposer;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.users.IgnoreUserMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.UnignoreUserMessageComposer;

    public class IgnoredUsersManager 
    {

        private var _session:SessionDataManager;
        private var _ignoredUsers:Array;
        private var _SafeStr_13640:Array;

        public function IgnoredUsersManager(_arg_1:SessionDataManager)
        {
            this._ignoredUsers = [];
            this._SafeStr_13640 = [];
            super();
            this._session = _arg_1;
        }
        public function dispose():void
        {
            this._session = null;
        }
        public function registerMessageEvents():void
        {
            var _local_1:IConnection = this._session.communication.HabboCommunicationManager(null);
            if (_local_1 == null){
                return;
            };
            _local_1.addMessageEvent(new IgnoreResultMessageEvent(this.onIgnoreResult));
            _local_1.addMessageEvent(new IgnoredUsersMessageEvent(this.onIgnoreList));
        }
        public function initIgnoreList():void
        {
            this._session.send(new GetIgnoredUsersMessageComposer(this._session.userName));
        }
        private function onIgnoreList(_arg_1:IMessageEvent):void
        {
            var _local_2:IgnoredUsersMessageEvent = (_arg_1 as IgnoredUsersMessageEvent);
            this._ignoredUsers = _local_2.ignoredUsers;
        }
        private function onIgnoreResult(_arg_1:IMessageEvent):void
        {
            var _local_2:IgnoreResultMessageEvent = (_arg_1 as IgnoreResultMessageEvent);
            var _local_3:String = String(this._SafeStr_13640.shift());
            switch (_local_2.result){
                case 0:
                    return;
                case 1:
                    this.addUserToIgnoreList(_local_3);
                    return;
                case 2:
                    this.addUserToIgnoreList(_local_3);
                    this._ignoredUsers.shift();
                    return;
                case 3:
                    this.removeUserFromIgnoreList(_local_3);
                    return;
            };
        }
        private function addUserToIgnoreList(_arg_1:String):void
        {
            if (this._ignoredUsers.indexOf(_arg_1) < 0){
                this._ignoredUsers.push(_arg_1);
            };
        }
        private function removeUserFromIgnoreList(_arg_1:String):void
        {
            var _local_2:int = this._ignoredUsers.indexOf(_arg_1);
            if (_local_2 >= 0){
                this._ignoredUsers.splice(_local_2, 1);
            };
        }
        public function SessionDataManager(_arg_1:String):void
        {
            this._SafeStr_13640.push(_arg_1);
            this._session.send(new IgnoreUserMessageComposer(_arg_1));
        }
        public function SessionDataManager(_arg_1:String):void
        {
            this._SafeStr_13640.push(_arg_1);
            this._session.send(new UnignoreUserMessageComposer(_arg_1));
        }
        public function isIgnored(_arg_1:String):Boolean
        {
            return ((this._ignoredUsers.indexOf(_arg_1) >= 0));
        }

    }
}//package com.sulake.habbo.session

// _SafeStr_13640 = "_-2o8" (String#21008, DoABC#2)
// registerMessageEvents = "_-do" (String#23792, DoABC#2)
// onIgnoreResult = "_-0P8" (String#15031, DoABC#2)
// onIgnoreList = "_-38u" (String#21839, DoABC#2)
// initIgnoreList = "_-xQ" (String#24586, DoABC#2)
// addUserToIgnoreList = "_-0Gz" (String#14717, DoABC#2)
// removeUserFromIgnoreList = "_-1K" (String#17274, DoABC#2)
// IgnoredUsersManager = "_-00Q" (String#3572, DoABC#2)
// GetIgnoredUsersMessageComposer = "_-0WB" (String#15287, DoABC#2)
// IgnoreUserMessageComposer = "_-1cl" (String#18000, DoABC#2)
// UnignoreUserMessageComposer = "_-0TE" (String#15179, DoABC#2)
// IgnoredUsersMessageEvent = "_-Ca" (String#7928, DoABC#2)
// IgnoreResultMessageEvent = "_-2UA" (String#6651, DoABC#2)
// communication = "_-3HD" (String#22171, DoABC#2)
// HabboCommunicationManager = "_-0AQ" (String#809, DoABC#2)
// _session = "_-32Q" (String#627, DoABC#2)
// ignoredUsers = "_-2n0" (String#20962, DoABC#2)
// isIgnored = "_-0NV" (String#4031, DoABC#2)
// SessionDataManager = "_-2nM" (String#7029, DoABC#2)
// SessionDataManager = "_-2jq" (String#6950, DoABC#2)


