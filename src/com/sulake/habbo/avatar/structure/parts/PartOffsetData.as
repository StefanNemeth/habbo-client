
package com.sulake.habbo.avatar.structure.parts
{
    import com.sulake.core.utils.Map;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.geom.Point;

    public final class PartOffsetData 
    {

        private static var _instance:PartOffsetData;
        private static var _parsed:Boolean = false;
        private static var _offsets:Map = new Map();

        public function PartOffsetData()
        {
            if (PartOffsetData._instance != null){
                throw (new Error("PartOffsetData is a singleton class. Use getInstance() instead of constructor!"));
            };
        }
        public static function dispose():void
        {
            if (PartOffsetData._instance != null){
                PartOffsetData._offsets = new Map();
                PartOffsetData._parsed = false;
                PartOffsetData._instance = null;
            };
        }
        public static function getInstance(_arg_1:IAssetLibrary):PartOffsetData
        {
            var _local_2:String;
            var _local_3:String;
            var _local_4:XML;
            var _local_5:int;
            var _local_6:int;
            var _local_7:String;
            if (PartOffsetData._instance == null){
                PartOffsetData._instance = new (PartOffsetData)();
                _local_2 = "pet";
                _local_5 = 0;
                _local_6 = 9;
                _local_3 = "h";
                _local_5 = 0;
                while (_local_5 < _local_6) {
                    _local_7 = ((((((_local_3 + "_") + _local_2) + "_") + "offsets") + "_") + _local_5);
                    if (_arg_1.hasAsset(_local_7)){
                        _local_4 = (_arg_1.getAssetByName(_local_7).content as XML);
                        PartOffsetData._offsets.add(_local_7, parseXml(_local_4));
                    };
                    _local_5++;
                };
                _local_3 = "sh";
                _local_5 = 0;
                while (_local_5 < _local_6) {
                    _local_7 = ((((((_local_3 + "_") + _local_2) + "_") + "offsets") + "_") + _local_5);
                    if (_arg_1.hasAsset(_local_7)){
                        _local_4 = (_arg_1.getAssetByName(_local_7).content as XML);
                        PartOffsetData._offsets.add(_local_7, parseXml(_local_4));
                    };
                    _local_5++;
                };
                PartOffsetData._parsed = true;
            };
            return (PartOffsetData._instance);
        }
        private static function parseXml(_arg_1:XML):Map
        {
            var _local_3:XML;
            var _local_4:String;
            var _local_5:Map;
            var _local_6:XML;
            var _local_7:String;
            var _local_8:Map;
            var _local_9:XML;
            var _local_10:String;
            var _local_11:Map;
            var _local_12:XML;
            var _local_13:String;
            var _local_14:Map;
            var _local_15:XML;
            var _local_16:Object;
            if (_arg_1 == null){
                return (null);
            };
            var _local_2:Map = new Map();
            for each (_local_3 in _arg_1.direction) {
                _local_4 = _local_3.@id;
                _local_5 = _local_2.getValue(_local_4);
                if (_local_5 == null){
                    _local_5 = new Map();
                    _local_2.add(_local_4, _local_5);
                };
                for each (_local_6 in _local_3.action) {
                    _local_7 = _local_6.@type;
                    _local_8 = _local_5.getValue(_local_7);
                    if (_local_8 == null){
                        _local_8 = new Map();
                        _local_5.add(_local_7, _local_8);
                    };
                    for each (_local_9 in _local_6.parttype) {
                        _local_10 = _local_9.@type;
                        _local_11 = _local_8.getValue(_local_10);
                        if (_local_11 == null){
                            _local_11 = new Map();
                            _local_8.add(_local_10, _local_11);
                        };
                        for each (_local_12 in _local_9.frame) {
                            _local_13 = _local_12.@number;
                            _local_14 = _local_11.getValue(_local_13);
                            if (_local_14 == null){
                                _local_14 = new Map();
                                _local_11.add(_local_13, _local_14);
                            };
                            for each (_local_15 in _local_12.offset) {
                                if (_local_15.hasOwnProperty("@aliasaction")){
                                    if (String(_local_15.@aliasaction).length == 0) continue;
                                    _local_16 = new Object();
                                    _local_16.aliasAction = new String(_local_15.@aliasaction);
                                    _local_16.aliasFrame = int(_local_15.@aliasframe);
                                    _local_14.add("alias", _local_16);
                                }
                                else {
                                    _local_14.add("offset", new Point(_local_15.@x, _local_15.@y));
                                };
                            };
                        };
                    };
                };
            };
            return (_local_2);
        }

        public function loadOffsets(_arg_1:IAssetLibrary):void
        {
            var _local_3:String;
            var _local_4:XML;
            var _local_7:String;
            var _local_2:String = "pet";
            var _local_5:int;
            var _local_6:int = 9;
            _local_3 = "h";
            _local_5 = 0;
            while (_local_5 < _local_6) {
                _local_7 = ((((((_local_3 + "_") + _local_2) + "_") + "offsets") + "_") + _local_5);
                if (_arg_1.hasAsset(_local_7)){
                    _local_4 = (_arg_1.getAssetByName(_local_7).content as XML);
                    PartOffsetData._offsets.add(_local_7, parseXml(_local_4));
                };
                _local_5++;
            };
            _local_3 = "sh";
            _local_5 = 0;
            while (_local_5 < _local_6) {
                _local_7 = ((((((_local_3 + "_") + _local_2) + "_") + "offsets") + "_") + _local_5);
                if (_arg_1.hasAsset(_local_7)){
                    _local_4 = (_arg_1.getAssetByName(_local_7).content as XML);
                    PartOffsetData._offsets.add(_local_7, parseXml(_local_4));
                };
                _local_5++;
            };
        }
        public function getOffset(_arg_1:int, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:int, _arg_6:int):Point
        {
            var _local_14:Object;
            var _local_15:Point;
            if (PartOffsetData._offsets == null){
                return (null);
            };
            var _local_7:String = "pet";
            var _local_8:String = ((((((_arg_2 + "_") + _local_7) + "_") + "offsets") + "_") + _arg_1);
            var _local_9:Map = PartOffsetData._offsets.getValue(_local_8);
            if (_local_9 == null){
                Logger.log(("Offsets were not found for: " + _local_8));
                return (null);
            };
            var _local_10:Map = _local_9.getValue(String(_arg_6));
            if (_local_10 == null){
                return (null);
            };
            var _local_11:Map = _local_10.getValue(_arg_4);
            if (_local_11 == null){
                return (null);
            };
            var _local_12:Map = _local_11.getValue(_arg_3);
            if (_local_12 == null){
                return (null);
            };
            var _local_13:Map = _local_12.getValue(String(_arg_5));
            if (_local_13 == null){
                return (null);
            };
            if (_local_13.getValue("alias") != null){
                _local_14 = _local_13.getValue("alias");
                return (this.getOffset(_arg_1, _arg_2, _arg_3, (_local_14.aliasAction as String), _local_14.aliasFrame, _arg_6));
            };
            _local_15 = _local_13.getValue("offset");
            if (_local_15 == null){
                return (null);
            };
            return (_local_15.clone());
        }

    }
}//package com.sulake.habbo.avatar.structure.parts

// parseXml = "_-PW" (String#23226, DoABC#2)
// loadOffsets = "_-2R4" (String#20087, DoABC#2)
// getOffset = "_-2Cj" (String#19513, DoABC#2)
// PartOffsetData = "_-8B" (String#22548, DoABC#2)
// getInstance = "_-n5" (String#24157, DoABC#2)


