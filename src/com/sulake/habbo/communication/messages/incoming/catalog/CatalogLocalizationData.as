
package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CatalogLocalizationData 
    {

        private var _images:Array;
        private var _texts:Array;

        public function CatalogLocalizationData(_arg_1:IMessageDataWrapper)
        {
            this._images = new Array();
            this._texts = new Array();
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._images.push(_arg_1.readString());
                _local_3++;
            };
            var _local_4:int = _arg_1.readInteger();
            var _local_5:int;
            while (_local_5 < _local_4) {
                this._texts.push(_arg_1.readString());
                _local_5++;
            };
        }
        public function get images():Array
        {
            return (this._images);
        }
        public function get texts():Array
        {
            return (this._texts);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.catalog

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// CatalogLocalizationData = "_-397" (String#7491, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _texts = "_-O9" (String#8166, DoABC#2)
// images = "_-0TG" (String#15181, DoABC#2)
// texts = "_-2Lf" (String#19872, DoABC#2)


