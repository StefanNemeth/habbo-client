
package com.sulake.habbo.communication.messages.incoming.avatar
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.avatar.WardrobeMessageParser;

    public class WardrobeMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public static const _SafeStr_7104:int = 0;
        public static const _SafeStr_7105:int = 1;

        public function WardrobeMessageEvent(_arg_1:Function)
        {
            super(_arg_1, WardrobeMessageParser);
        }
        private function getParser():WardrobeMessageParser
        {
            return ((this._parser as WardrobeMessageParser));
        }
        public function get outfits():Array
        {
            return (this.getParser().outfits);
        }
        public function get state():int
        {
            return (this.getParser().state);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.avatar

// WardrobeMessageEvent = "_-37-" (String#7448, DoABC#2)
// WardrobeMessageParser = "_-1fD" (String#5650, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// _SafeStr_7104 = "_-2nY" (String#20981, DoABC#2)
// _SafeStr_7105 = "_-0pm" (String#16044, DoABC#2)
// outfits = "_-334" (String#21623, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


