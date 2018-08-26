
package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.FavouriteChangedMessageParser;

    public class FavouriteChangedEvent extends MessageEvent implements IMessageEvent 
    {

        public function FavouriteChangedEvent(_arg_1:Function)
        {
            super(_arg_1, FavouriteChangedMessageParser);
        }
        public function getParser():FavouriteChangedMessageParser
        {
            return ((this._parser as FavouriteChangedMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.navigator

// FavouriteChangedEvent = "_-44" (String#22380, DoABC#2)
// FavouriteChangedMessageParser = "_-QN" (String#8210, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


