
package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PopularRoomTagsData implements IDisposable, MsgWithRequestId 
    {

        private var _tags:Array;
        private var _disposed:Boolean;

        public function PopularRoomTagsData(_arg_1:IMessageDataWrapper)
        {
            this._tags = new Array();
            super();
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._tags.push(new PopularTagData(_arg_1));
                _local_3++;
            };
        }
        public function dispose():void
        {
            if (this._disposed){
                return;
            };
            this._disposed = true;
            this._tags = null;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get tags():Array
        {
            return (this._tags);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.navigator

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// MsgWithRequestId = "_-1zv" (String#6029, DoABC#2)
// PopularRoomTagsData = "_-1Bn" (String#5105, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// PopularTagData = "_-2r2" (String#7100, DoABC#2)
// _tags = "_-1NU" (String#163, DoABC#2)


