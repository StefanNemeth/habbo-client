
package com.sulake.habbo.session
{
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.core.utils.Map;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.communication.messages.incoming.users.UserTagsMessageEvent;
    import com.sulake.habbo.session.events.UserTagsReceivedEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.communication.messages.outgoing.users.GetUserTagsMessageComposer;

    public class UserTagManager 
    {

        private var _communication:IHabboCommunicationManager;
        private var _SafeStr_13647:Map;
        private var _events:IEventDispatcher;

        public function UserTagManager(_arg_1:IEventDispatcher)
        {
            this._SafeStr_13647 = new Map();
            this._events = _arg_1;
        }
        public function set communication(_arg_1:IHabboCommunicationManager):void
        {
            this._communication = _arg_1;
            this._communication.addHabboConnectionMessageEvent(new UserTagsMessageEvent(this.onUserTags));
        }
        private function onUserTags(_arg_1:IMessageEvent):void
        {
            var _local_2:UserTagsMessageEvent = (_arg_1 as UserTagsMessageEvent);
            var _local_3:int = _local_2.userId;
            var _local_4:Array = _local_2.tags;
            this._SafeStr_13647.add(_local_3, _local_4);
            this._events.dispatchEvent(new UserTagsReceivedEvent(_local_3, _local_4.slice()));
        }
        public function getTags(_arg_1:int):Array
        {
            var _local_2:Array = (this._SafeStr_13647.getValue(_arg_1) as Array);
            if (_local_2 != null){
                return (_local_2.slice());
            };
            if (this._communication == null){
                Logger.log("oops! communication interface not ready");
            };
            var _local_3:IConnection = this._communication.getHabboMainConnection(null);
            _local_3.send(new GetUserTagsMessageComposer(_arg_1));
            return (null);
        }

    }
}//package com.sulake.habbo.session

// _SafeStr_13647 = "_-C6" (String#22696, DoABC#2)
// getTags = "_-f" (String#23844, DoABC#2)
// UserTagManager = "_-2D" (String#19521, DoABC#2)
// GetUserTagsMessageComposer = "_-0tf" (String#16188, DoABC#2)
// UserTagsMessageEvent = "_-04R" (String#3653, DoABC#2)
// UserTagsReceivedEvent = "_-09C" (String#14416, DoABC#2)
// communication = "_-3HD" (String#22171, DoABC#2)
// addHabboConnectionMessageEvent = "_-0r" (String#4663, DoABC#2)
// getHabboMainConnection = "_-0AQ" (String#809, DoABC#2)
// onUserTags = "_-T6" (String#2113, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)


