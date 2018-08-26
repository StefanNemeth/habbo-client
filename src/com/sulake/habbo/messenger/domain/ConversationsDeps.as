
package com.sulake.habbo.messenger.domain
{
    import com.sulake.habbo.messenger.HabboMessenger;

    public class ConversationsDeps implements IConversationsDeps 
    {

        private var _messenger:HabboMessenger;

        public function ConversationsDeps(_arg_1:HabboMessenger)
        {
            this._messenger = _arg_1;
        }
        public function MessengerView():int
        {
            return (this._messenger.messengerView.MessengerView());
        }
        public function getText(_arg_1:String):String
        {
            return (this._messenger.getText(_arg_1));
        }
        public function createConversation(_arg_1:int):Conversation
        {
            return (this._messenger.createConversation(_arg_1));
        }
        public function refresh(_arg_1:Boolean):void
        {
            this._messenger.messengerView.refresh();
        }
        public function MessengerView(_arg_1:Conversation, _arg_2:Message):void
        {
            this._messenger.messengerView.MessengerView(_arg_1, _arg_2);
        }

    }
}//package com.sulake.habbo.messenger.domain

// IConversationsDeps = "_-16j" (String#5011, DoABC#2)
// ConversationsDeps = "_-Ol" (String#8180, DoABC#2)
// Message = "_-0r8" (String#4665, DoABC#2)
// Conversation = "_-Ej" (String#7965, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// MessengerView = "_-FK" (String#7977, DoABC#2)
// createConversation = "_-Qw" (String#8225, DoABC#2)
// MessengerView = "_-nV" (String#8668, DoABC#2)


