
package com.sulake.habbo.communication.messages.incoming.advertisement
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.advertisement.InterstitialMessageParser;

    public class InterstitialMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function InterstitialMessageEvent(_arg_1:Function)
        {
            super(_arg_1, InterstitialMessageParser);
        }
        public function getParser():InterstitialMessageParser
        {
            return ((this._parser as InterstitialMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.advertisement

// InterstitialMessageParser = "_-154" (String#4980, DoABC#2)
// InterstitialMessageEvent = "_-wD" (String#24539, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


