
package com.sulake.habbo.moderation
{
    public class BanDefinition 
    {

        private var _name:String;
        private var _banLengthHours:int;

        public function BanDefinition(_arg_1:String, _arg_2:int)
        {
            this._name = _arg_1;
            this._banLengthHours = _arg_2;
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get banLengthHours():int
        {
            return (this._banLengthHours);
        }

    }
}//package com.sulake.habbo.moderation

// banLengthHours = "_-2Mb" (String#19911, DoABC#2)
// _banLengthHours = "_-08X" (String#14387, DoABC#2)
// BanDefinition = "_-177" (String#5019, DoABC#2)


