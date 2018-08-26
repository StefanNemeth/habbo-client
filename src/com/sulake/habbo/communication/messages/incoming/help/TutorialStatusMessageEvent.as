
package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.TutorialStatusMessageParser;

    public class TutorialStatusMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function TutorialStatusMessageEvent(_arg_1:Function)
        {
            super(_arg_1, TutorialStatusMessageParser);
        }
        public function getParser():TutorialStatusMessageParser
        {
            return ((_parser as TutorialStatusMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.help

// TutorialStatusMessageEvent = "_-II" (String#22940, DoABC#2)
// TutorialStatusMessageParser = "_-1ZY" (String#5556, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


