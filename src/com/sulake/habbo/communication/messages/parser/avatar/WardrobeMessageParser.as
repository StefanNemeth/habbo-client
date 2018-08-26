
package com.sulake.habbo.communication.messages.parser.avatar
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.avatar.OutfitData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class WardrobeMessageParser implements IMessageParser 
    {

        private var _state:int;
        private var _outfits:Array;

        public function flush():Boolean
        {
            this._state = 0;
            this._outfits = [];
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_4:OutfitData;
            this._state = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                _local_4 = new OutfitData(_arg_1);
                this._outfits.push(_local_4);
                _local_3++;
            };
            return (true);
        }
        public function get outfits():Array
        {
            return (this._outfits);
        }
        public function get state():int
        {
            return (this._state);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.avatar

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// WardrobeMessageParser = "_-1fD" (String#5650, DoABC#2)
// OutfitData = "_-3Q" (String#7734, DoABC#2)
// outfits = "_-334" (String#21623, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)
// _outfits = "_-1-Y" (String#16450, DoABC#2)


