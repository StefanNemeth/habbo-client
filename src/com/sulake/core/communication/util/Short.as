
package com.sulake.core.communication.util
{
    import flash.utils.ByteArray;

    public class Short 
    {

        private var _SafeStr_8093:ByteArray;

        public function Short(_arg_1:int)
        {
            this._SafeStr_8093 = new ByteArray();
            this._SafeStr_8093.writeShort(_arg_1);
            this._SafeStr_8093.position = 0;
        }
        public function get value():int
        {
            var _local_1:int;
            this._SafeStr_8093.position = 0;
            if (this._SafeStr_8093.bytesAvailable){
                _local_1 = this._SafeStr_8093.readShort();
                this._SafeStr_8093.position = 0;
            };
            return (_local_1);
        }

    }
}//package com.sulake.core.communication.util

// Short = "_-0S7" (String#4139, DoABC#2)
// _SafeStr_8093 = "_-2V9" (String#20245, DoABC#2)


