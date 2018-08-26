
package com.sulake.habbo.communication.messages.incoming.handshake
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.GenericErrorParser;

    public class GenericErrorEvent extends MessageEvent implements IMessageEvent 
    {

        public function GenericErrorEvent(_arg_1:Function)
        {
            super(_arg_1, GenericErrorParser);
        }
        public function getParser():GenericErrorParser
        {
            return ((this._parser as GenericErrorParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.handshake

// GenericErrorEvent = "_-2X" (String#6699, DoABC#2)
// GenericErrorParser = "_-2ft" (String#6864, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


