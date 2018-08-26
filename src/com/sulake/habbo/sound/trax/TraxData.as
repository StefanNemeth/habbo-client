
package com.sulake.habbo.sound.trax
{
    import com.sulake.core.utils.Map;

    public class TraxData 
    {

        private var _channels:Array;
        private var _SafeStr_6117:Map;

        public function TraxData(_arg_1:String)
        {
            var _local_2:Array;
            var _local_6:Array;
            var _local_7:int;
            var _local_8:String;
            var _local_9:String;
            var _local_10:int;
            var _local_11:Array;
            var _local_12:TraxChannel;
            var _local_13:int;
            var _local_14:Array;
            var _local_15:int;
            var _local_16:int;
            this._SafeStr_6117 = new Map();
            super();
            this._channels = [];
            var _local_3:Array = _arg_1.split(":");
            var _local_4:String = String(_local_3[(_local_3.length - 1)]);
            if (_local_4.indexOf("meta") != -1){
                _local_6 = _local_4.split(";");
                _local_7 = 0;
                while (_local_7 < _local_6.length) {
                    _local_8 = String(_local_6[_local_7]).split(",")[0];
                    _local_9 = String(_local_6[_local_7]).split(",")[1];
                    this._SafeStr_6117.add(_local_8, _local_9);
                    _local_7++;
                };
                _local_2 = _local_3.slice(0, (_local_3.length - 1));
            }
            else {
                _local_2 = _local_3;
            };
            var _local_5:int;
            while (_local_5 < (_local_2.length / 2)) {
                if (_local_2[(_local_5 * 2)].toString().length > 0){
                    _local_10 = int(_local_2[(_local_5 * 2)]);
                    _local_11 = _local_2[((_local_5 * 2) + 1)].toString().split(";");
                    _local_12 = new TraxChannel(_local_10);
                    _local_13 = 0;
                    while (_local_13 < _local_11.length) {
                        _local_14 = _local_11[_local_13].toString().split(",");
                        if (_local_14.length != 2){
                            Logger.log("Trax load error: invalid song data string");
                            return;
                        };
                        _local_15 = int(_local_14[0]);
                        _local_16 = int(_local_14[1]);
                        _local_12.TraxChannel(new TraxChannelItem(_local_15, _local_16));
                        _local_13++;
                    };
                    this._channels.push(_local_12);
                };
                _local_5++;
            };
        }
        public function get channels():Array
        {
            return (this._channels);
        }
        public function getSampleIds():Array
        {
            var _local_3:TraxChannel;
            var _local_4:int;
            var _local_5:TraxChannelItem;
            var _local_1:Array = [];
            var _local_2:int;
            while (_local_2 < this._channels.length) {
                _local_3 = (this._channels[_local_2] as TraxChannel);
                _local_4 = 0;
                while (_local_4 < _local_3.itemCount) {
                    _local_5 = _local_3.GroupItem(_local_4);
                    if (_local_1.indexOf(_local_5.id) == -1){
                        _local_1.push(_local_5.id);
                    };
                    _local_4++;
                };
                _local_2++;
            };
            return (_local_1);
        }
        public function get hasMetaData():Boolean
        {
            return (!((this._SafeStr_6117["meta"] == null)));
        }
        public function get metaCutMode():Boolean
        {
            return ((this._SafeStr_6117["c"] == "1"));
        }
        public function get metaTempo():int
        {
            return ((this._SafeStr_6117["t"] as int));
        }

    }
}//package com.sulake.habbo.sound.trax

// TraxData = "_-kA" (String#8604, DoABC#2)
// TraxChannelItem = "_-0kh" (String#4515, DoABC#2)
// TraxChannel = "_-2yL" (String#7246, DoABC#2)
// GroupItem = "_-0un" (String#16229, DoABC#2)
// _channels = "_-5V" (String#22443, DoABC#2)
// _SafeStr_6117 = "_-1T7" (String#17630, DoABC#2)
// TraxChannel = "_-0xc" (String#16337, DoABC#2)
// channels = "_-2lP" (String#20897, DoABC#2)
// getSampleIds = "_-1c-" (String#17971, DoABC#2)
// itemCount = "_-1fH" (String#18108, DoABC#2)
// hasMetaData = "_-1BR" (String#16916, DoABC#2)
// metaCutMode = "_-Cw" (String#22724, DoABC#2)
// metaTempo = "_-uH" (String#24463, DoABC#2)


