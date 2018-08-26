
package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FavouritesMessageParser implements IMessageParser 
    {

        private var _limit:int;
        private var _favouriteRoomIds:Array;

        public function flush():Boolean
        {
            this._favouriteRoomIds = new Array();
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._limit = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._favouriteRoomIds.push(_arg_1.readInteger());
                _local_3++;
            };
            return (true);
        }
        public function get limit():int
        {
            return (this._limit);
        }
        public function get favouriteRoomIds():Array
        {
            return (this._favouriteRoomIds);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.navigator

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// FavouritesMessageParser = "_-Om" (String#8181, DoABC#2)
// _limit = "_-1nj" (String#1760, DoABC#2)
// _favouriteRoomIds = "_-y9" (String#24620, DoABC#2)
// favouriteRoomIds = "_-0Az" (String#14487, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


