
package com.sulake.habbo.roomevents
{
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.OpenEvent;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniTriggerEvent;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniActionEvent;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniConditionEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectRemoveMessageEvent;
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.OpenMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.OpenMessageComposer;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredFurniTriggerMessageParser;
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredFurniActionMessageParser;
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredFurniConditionMessageParser;
    import com.sulake.habbo.communication.messages.parser.handshake.UserObjectMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectRemoveMessageParser;

    public class IncomingMessages 
    {

        private var _SafeStr_5221:HabboUserDefinedRoomEvents;

        public function IncomingMessages(_arg_1:HabboUserDefinedRoomEvents)
        {
            this._SafeStr_5221 = _arg_1;
            var _local_2:IHabboCommunicationManager = this._SafeStr_5221.communication;
            _local_2.HabboCommunicationManager(new OpenEvent(this.onOpen));
            _local_2.HabboCommunicationManager(new WiredFurniTriggerEvent(this.onTrigger));
            _local_2.HabboCommunicationManager(new WiredFurniActionEvent(this.onAction));
            _local_2.HabboCommunicationManager(new WiredFurniConditionEvent(this.onCondition));
            _local_2.HabboCommunicationManager(new UserObjectEvent(this.onUserObject));
            _local_2.HabboCommunicationManager(new CloseConnectionMessageEvent(this.HabboGroupInfoManager));
            _local_2.HabboCommunicationManager(new ObjectRemoveMessageEvent(this.onObjectRemove));
        }
        private function onOpen(_arg_1:IMessageEvent):void
        {
            var _local_2:OpenMessageParser = (_arg_1 as OpenEvent).getParser();
            this._SafeStr_5221.send(new OpenMessageComposer(_local_2.stuffId));
        }
        private function onTrigger(_arg_1:IMessageEvent):void
        {
            var _local_2:WiredFurniTriggerMessageParser = (_arg_1 as WiredFurniTriggerEvent).getParser();
            this._SafeStr_5221.userDefinedRoomEventsCtrl.prepareForUpdate(_local_2.def);
        }
        private function onAction(_arg_1:IMessageEvent):void
        {
            var _local_2:WiredFurniActionMessageParser = (_arg_1 as WiredFurniActionEvent).getParser();
            this._SafeStr_5221.userDefinedRoomEventsCtrl.prepareForUpdate(_local_2.def);
        }
        private function onCondition(_arg_1:IMessageEvent):void
        {
            var _local_2:WiredFurniConditionMessageParser = (_arg_1 as WiredFurniConditionEvent).getParser();
            this._SafeStr_5221.userDefinedRoomEventsCtrl.prepareForUpdate(_local_2.def);
        }
        private function onUserObject(_arg_1:IMessageEvent):void
        {
            var _local_2:UserObjectMessageParser = (_arg_1 as UserObjectEvent).getParser();
            this._SafeStr_5221.userName = _local_2.name;
        }
        private function HabboGroupInfoManager(_arg_1:IMessageEvent):void
        {
            this._SafeStr_5221.userDefinedRoomEventsCtrl.close();
        }
        private function onObjectRemove(_arg_1:IMessageEvent):void
        {
            var _local_2:ObjectRemoveMessageParser = (_arg_1 as ObjectRemoveMessageEvent).getParser();
            Logger.log(((("Received object remove event: " + _local_2.id) + ", ") + _local_2.isExpired));
            this._SafeStr_5221.userDefinedRoomEventsCtrl.stuffRemoved(_local_2.id);
        }

    }
}//package com.sulake.habbo.roomevents

// onUserObject = "_-2A9" (String#617, DoABC#2)
// IncomingMessages = "_-2Xb" (String#216, DoABC#2)
// onObjectRemove = "_-uz" (String#8784, DoABC#2)
// prepareForUpdate = "_-1zL" (String#18941, DoABC#2)
// stuffRemoved = "_-09l" (String#14437, DoABC#2)
// onOpen = "_-1EU" (String#17048, DoABC#2)
// onTrigger = "_-0PN" (String#15037, DoABC#2)
// onAction = "_-2RI" (String#20092, DoABC#2)
// onCondition = "_-5k" (String#22452, DoABC#2)
// userDefinedRoomEventsCtrl = "_-1JG" (String#17247, DoABC#2)
// UserObjectMessageParser = "_-04X" (String#14223, DoABC#2)
// UserObjectEvent = "_-1HL" (String#17163, DoABC#2)
// OpenMessageComposer = "_-2pb" (String#21063, DoABC#2)
// WiredFurniActionMessageParser = "_-35K" (String#7414, DoABC#2)
// OpenEvent = "_-0eW" (String#15607, DoABC#2)
// OpenMessageParser = "_-m5" (String#8645, DoABC#2)
// WiredFurniConditionMessageParser = "_-2a5" (String#6761, DoABC#2)
// ObjectRemoveMessageEvent = "_-36g" (String#21754, DoABC#2)
// WiredFurniTriggerMessageParser = "_-0yP" (String#4817, DoABC#2)
// WiredFurniConditionEvent = "_-33a" (String#21645, DoABC#2)
// WiredFurniTriggerEvent = "_-1lj" (String#18363, DoABC#2)
// WiredFurniActionEvent = "_-2-d" (String#18997, DoABC#2)
// ObjectRemoveMessageParser = "_-06f" (String#3694, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// isExpired = "_-0qo" (String#16078, DoABC#2)
// communication = "_-3HD" (String#22171, DoABC#2)
// HabboCommunicationManager = "_-0r" (String#4663, DoABC#2)
// _SafeStr_5221 = "_-0D2" (String#124, DoABC#2)
// def = "_-15K" (String#16666, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// CloseConnectionMessageEvent = "_-2cv" (String#6811, DoABC#2)
// HabboGroupInfoManager = "_-0Na" (String#356, DoABC#2)


