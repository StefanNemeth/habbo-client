
package com.sulake.habbo.communication.messages.incoming.inventory.furni
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.furni.PostItPlacedParser;

    public class PostItPlacedEvent extends MessageEvent implements IMessageEvent 
    {

        public function PostItPlacedEvent(_arg_1:Function)
        {
            super(_arg_1, PostItPlacedParser);
        }
        public function getParser():PostItPlacedParser
        {
            return ((this._parser as PostItPlacedParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.furni

// PostItPlacedEvent = "_-2op" (String#7053, DoABC#2)
// PostItPlacedParser = "_-10u" (String#16494, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


