
package com.sulake.habbo.communication.messages.incoming.recycler
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PrizeLevelMessageData 
    {

        private var _prizeLevelId:int;
        private var _probabilityDenominator:int;
        private var _prizeTable:Array;

        public function PrizeLevelMessageData(_arg_1:IMessageDataWrapper)
        {
            this._prizeLevelId = _arg_1.readInteger();
            this._probabilityDenominator = _arg_1.readInteger();
            this._prizeTable = new Array();
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._prizeTable.push(new PrizeMessageData(_arg_1));
                _local_3++;
            };
        }
        public function get prizeLevelId():int
        {
            return (this._prizeLevelId);
        }
        public function get probabilityDenominator():int
        {
            return (this._probabilityDenominator);
        }
        public function get prizes():Array
        {
            return (this._prizeTable);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.recycler

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// PrizeLevelMessageData = "_-0gy" (String#4444, DoABC#2)
// PrizeMessageData = "_-aq" (String#8436, DoABC#2)
// _prizeLevelId = "_-14c" (String#4971, DoABC#2)
// _probabilityDenominator = "_-02E" (String#14136, DoABC#2)
// _prizeTable = "_-1ct" (String#855, DoABC#2)
// prizeLevelId = "_-BF" (String#22664, DoABC#2)
// probabilityDenominator = "_-1nl" (String#18450, DoABC#2)


