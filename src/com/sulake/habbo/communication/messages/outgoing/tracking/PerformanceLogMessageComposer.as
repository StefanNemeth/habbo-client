
package com.sulake.habbo.communication.messages.outgoing.tracking
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class PerformanceLogMessageComposer implements IMessageComposer 
    {

        private var _elapsedTime:int = 0;
        private var _SafeStr_4807:String = "";
        private var _flashVersion:String = "";
        private var _SafeStr_4809:String = "";
        private var _SafeStr_4810:String = "";
        private var _SafeStr_4811:int = 0;
        private var _SafeStr_4812:int = 0;
        private var _SafeStr_4813:int = 0;
        private var _SafeStr_4814:int = 0;
        private var _SafeStr_4815:int = 0;
        private var _SafeStr_4816:int = 0;

        public function PerformanceLogMessageComposer(_arg_1:int, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:Boolean, _arg_7:int, _arg_8:int, _arg_9:int, _arg_10:int, _arg_11:int)
        {
            this._elapsedTime = _arg_1;
            this._SafeStr_4807 = _arg_2;
            this._flashVersion = _arg_3;
            this._SafeStr_4809 = _arg_4;
            this._SafeStr_4810 = _arg_5;
            if (_arg_6){
                this._SafeStr_4811 = 1;
            }
            else {
                this._SafeStr_4811 = 0;
            };
            this._SafeStr_4812 = _arg_7;
            this._SafeStr_4813 = _arg_8;
            this._SafeStr_4814 = _arg_9;
            this._SafeStr_4815 = _arg_10;
            this._SafeStr_4816 = _arg_11;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([this._elapsedTime, this._SafeStr_4807, this._flashVersion, this._SafeStr_4809, this._SafeStr_4810, this._SafeStr_4811, this._SafeStr_4812, this._SafeStr_4813, this._SafeStr_4814, this._SafeStr_4815, this._SafeStr_4816]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.tracking

// PerformanceLogMessageComposer = "_-2J" (String#6421, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _elapsedTime = "_-00e" (String#1382, DoABC#2)
// _SafeStr_4807 = "_-0zO" (String#4835, DoABC#2)
// _flashVersion = "_-nD" (String#8660, DoABC#2)
// _SafeStr_4809 = "_-0h-" (String#4446, DoABC#2)
// _SafeStr_4810 = "_-DT" (String#7941, DoABC#2)
// _SafeStr_4811 = "_-1TJ" (String#5420, DoABC#2)
// _SafeStr_4812 = "_-0HQ" (String#14736, DoABC#2)
// _SafeStr_4813 = "_-2Dv" (String#19564, DoABC#2)
// _SafeStr_4814 = "_-190" (String#5056, DoABC#2)
// _SafeStr_4815 = "_-1PT" (String#17487, DoABC#2)
// _SafeStr_4816 = "_-2nL" (String#7028, DoABC#2)


