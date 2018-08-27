
package com.sulake.habbo.messenger.domain
{
    public interface IConversationsDeps 
    {

        function getTabCount():int;
        function getText(_arg_1:String):String;
        function createConversation(_arg_1:int):Conversation;
        function refresh(_arg_1:Boolean):void;
        function addMsgToView(_arg_1:Conversation, _arg_2:Message):void;

    }
}//package com.sulake.habbo.messenger.domain

// IConversationsDeps = "_-16j" (String#5011, DoABC#2)
// Message = "_-0r8" (String#4665, DoABC#2)
// Conversation = "_-Ej" (String#7965, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// getTabCount = "_-FK" (String#7977, DoABC#2)
// createConversation = "_-Qw" (String#8225, DoABC#2)
// addMsgToView = "_-nV" (String#8668, DoABC#2)


