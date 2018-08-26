
package com.sulake.habbo.communication.messages.outgoing.inventory.badges
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class SetActivatedBadgesComposer implements IMessageComposer 
    {

        private const _SafeStr_5938:int = 5;

        private var _SafeStr_5939:Array;

        public function SetActivatedBadgesComposer()
        {
            this._SafeStr_5939 = new Array();
        }
        public function addActivatedBadge(_arg_1:String):void
        {
            if (this._SafeStr_5939.length >= this._SafeStr_5938){
                return;
            };
            this._SafeStr_5939.push(_arg_1);
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            var _local_1:Array = new Array();
            var _local_2:int = 1;
            while (_local_2 <= this._SafeStr_5938) {
                if (_local_2 <= this._SafeStr_5939.length){
                    _local_1.push(_local_2);
                    _local_1.push(this._SafeStr_5939[(_local_2 - 1)]);
                }
                else {
                    _local_1.push(_local_2);
                    _local_1.push("");
                };
                _local_2++;
            };
            return (_local_1);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.inventory.badges

// SetActivatedBadgesComposer = "_-12m" (String#16571, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _SafeStr_5938 = "_-1Qa" (String#17536, DoABC#2)
// _SafeStr_5939 = "_-0o" (String#15977, DoABC#2)
// addActivatedBadge = "_-I7" (String#22934, DoABC#2)


