
package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class OffenceCategoryData implements INamed, IDisposable 
    {

        private var _name:String;
        private var _offences:Array;
        private var _disposed:Boolean;

        public function OffenceCategoryData(_arg_1:IMessageDataWrapper)
        {
            this._offences = new Array();
            super();
            this._name = _arg_1.readString();
            Logger.log(("READ CAT: " + this._name));
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._offences.push(new OffenceData(_arg_1));
                _local_3++;
            };
        }
        public function dispose():void
        {
            if (this._disposed){
                return;
            };
            this._disposed = true;
            this._offences = null;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get offences():Array
        {
            return (this._offences);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.moderation

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// INamed = "_-11E" (String#4899, DoABC#2)
// OffenceCategoryData = "_-10g" (String#4888, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// OffenceData = "_-10e" (String#4886, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _offences = "_-1w5" (String#18801, DoABC#2)
// offences = "_-2-3" (String#18973, DoABC#2)


