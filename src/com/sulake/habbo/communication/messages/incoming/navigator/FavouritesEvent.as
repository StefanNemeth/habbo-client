
package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.FavouritesMessageParser;

    public class FavouritesEvent extends MessageEvent implements IMessageEvent 
    {

        public function FavouritesEvent(_arg_1:Function)
        {
            super(_arg_1, FavouritesMessageParser);
        }
        public function getParser():FavouritesMessageParser
        {
            return ((this._parser as FavouritesMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.navigator

// FavouritesMessageParser = "_-Om" (String#8181, DoABC#2)
// FavouritesEvent = "_-39L" (String#21859, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


