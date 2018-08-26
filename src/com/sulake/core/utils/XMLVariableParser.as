
package com.sulake.core.utils
{
    import flash.geom.Point;
    import flash.geom.Rectangle;

    public class XMLVariableParser 
    {

        public static const _SafeStr_8991:String = "hex";
        public static const _SafeStr_8992:String = "int";
        public static const _SafeStr_8993:String = "uint";
        public static const _SafeStr_8994:String = "Number";
        public static const _SafeStr_8995:String = "float";
        public static const _SafeStr_8996:String = "Boolean";
        public static const _SafeStr_8997:String = "bool";
        public static const _SafeStr_8998:String = "String";
        public static const _SafeStr_8999:String = "Point";
        public static const _SafeStr_9000:String = "Rectangle";
        public static const _SafeStr_9001:String = "Array";
        public static const _SafeStr_9002:String = "Map";
        private static const _SafeStr_9003:String = "key";
        private static const TYPE:String = "type";
        private static const _SafeStr_9004:String = "value";
        private static const _SafeStr_9005:String = "true";
        private static const _SafeStr_9006:String = "false";
        private static const X:String = "x";
        private static const Y:String = "y";
        private static const _SafeStr_9007:String = "width";
        private static const _SafeStr_9008:String = "height";
        private static const ,:String = ",";

        public static function parseVariableList(_arg_1:XMLList, _arg_2:Map, _arg_3:Array=null):uint
        {
            var _local_5:uint;
            var _local_4:uint = _arg_1.length();
            _local_5 = 0;
            while (_local_5 < _local_4) {
                XMLVariableParser.parseVariableToken(_arg_1[_local_5], _arg_2, _arg_3);
                _local_5++;
            };
            return (_local_4);
        }
        private static function parseVariableToken(_arg_1:XML, _arg_2:Map, _arg_3:Array=null):void
        {
            var _local_4:String;
            var _local_6:String;
            var _local_7:XMLList;
            var _local_8:XML;
            var _local_9:XML;
            var _local_5:String = _SafeStr_8998;
            _local_7 = _arg_1.attribute(_SafeStr_9003);
            if (_local_7.length() > 0){
                _local_4 = String(_arg_1.attribute(_SafeStr_9003));
            }
            else {
                _local_4 = _arg_1.child(_SafeStr_9003)[0];
            };
            _local_7 = _arg_1.attribute(TYPE);
            if (_local_7.length() > 0){
                _local_5 = String(_arg_1.attribute(TYPE));
            };
            _local_7 = _arg_1.attribute(_SafeStr_9004);
            if (_local_7.length() > 0){
                _local_6 = String(_arg_1.attribute(_SafeStr_9004));
            };
            if (_local_6 != null){
                _arg_2[_local_4] = XMLVariableParser.castStringToType(_local_6, _local_5);
            }
            else {
                _local_8 = _arg_1.child(_SafeStr_9004)[0];
                if (_local_8 != null){
                    _local_9 = _local_8.child(0)[0];
                    _local_6 = _local_9.children()[0];
                    _local_5 = _local_9.localName();
                    _arg_2[_local_4] = XMLVariableParser.parseValueType(_local_9, _local_5);
                }
                else {
                    if ((((_local_5 == _SafeStr_9002)) || ((_local_5 == _SafeStr_9001)))){
                        _arg_2[_local_4] = XMLVariableParser.parseValueType(_arg_1, _local_5);
                    };
                };
            };
            if (_arg_3){
                _arg_3.push(_local_5);
            };
        }
        public static function castStringToType(_arg_1:String, _arg_2:String):Object
        {
            switch (_arg_2){
                case _SafeStr_8993:
                    return (uint(_arg_1));
                case _SafeStr_8992:
                    return (int(_arg_1));
                case _SafeStr_8994:
                    return (Number(_arg_1));
                case _SafeStr_8995:
                    return (Number(_arg_1));
                case _SafeStr_8996:
                    return ((((_arg_1 == _SafeStr_9005)) || ((int(_arg_1) > 0))));
                case _SafeStr_8997:
                    return ((((_arg_1 == _SafeStr_9005)) || ((int(_arg_1) > 0))));
                case _SafeStr_8991:
                    return (uint(_arg_1));
                case _SafeStr_9001:
                    return (_arg_1.split(,));
                default:
                    return (String(_arg_1));
            };
        }
        public static function parseValueType(_arg_1:XML, _arg_2:String):Object
        {
            var _local_3:Map;
            var _local_4:Point;
            var _local_5:Rectangle;
            var _local_6:Array;
            var _local_7:String;
            switch (_arg_2){
                case _SafeStr_8998:
                    return (String(_arg_1));
                case _SafeStr_8999:
                    _local_4 = new Point();
                    _local_4.x = Number(_arg_1.attribute(X));
                    _local_4.y = Number(_arg_1.attribute(Y));
                    return (_local_4);
                case _SafeStr_9000:
                    _local_5 = new Rectangle();
                    _local_5.x = Number(_arg_1.attribute(X));
                    _local_5.y = Number(_arg_1.attribute(Y));
                    _local_5.width = Number(_arg_1.attribute(_SafeStr_9007));
                    _local_5.height = Number(_arg_1.attribute(_SafeStr_9008));
                    return (_local_5);
                case _SafeStr_9001:
                    _local_3 = new Map();
                    parseVariableList(_arg_1.children(), _local_3);
                    _local_6 = new Array();
                    for (_local_7 in _local_3) {
                        _local_6.push(_local_3[_local_7]);
                    };
                    return (_local_6);
                case _SafeStr_9002:
                    _local_3 = new Map();
                    XMLVariableParser.parseVariableList(_arg_1.children(), _local_3);
                    return (_local_3);
            };
            throw (new Error((('Unable to parse data type "' + _arg_2) + '", unknown type!')));
        }

    }
}//package com.sulake.core.utils

// XMLVariableParser = "_-pR" (String#24252, DoABC#2)
// _SafeStr_8991 = "_-23W" (String#19156, DoABC#2)
// _SafeStr_8992 = "_-5d" (String#22447, DoABC#2)
// _SafeStr_8993 = "_-O-" (String#23167, DoABC#2)
// _SafeStr_8994 = "_-0yp" (String#16384, DoABC#2)
// _SafeStr_8995 = "_-231" (String#19136, DoABC#2)
// _SafeStr_8996 = "_-0gH" (String#15685, DoABC#2)
// _SafeStr_8997 = "_-2uV" (String#21261, DoABC#2)
// _SafeStr_8998 = "_-1lW" (String#18353, DoABC#2)
// _SafeStr_8999 = "_-32d" (String#21601, DoABC#2)
// _SafeStr_9000 = "_-ma" (String#24130, DoABC#2)
// _SafeStr_9001 = "_-2Pe" (String#20029, DoABC#2)
// _SafeStr_9002 = "_-2Wa" (String#20307, DoABC#2)
// _SafeStr_9003 = "_-08R" (String#14382, DoABC#2)
// _SafeStr_9004 = "_-2s6" (String#21162, DoABC#2)
// _SafeStr_9005 = "_-2hb" (String#6898, DoABC#2)
// _SafeStr_9006 = "_-0Z" (String#15402, DoABC#2)
// _SafeStr_9007 = "_-iG" (String#2163, DoABC#2)
// _SafeStr_9008 = "_-hz" (String#2162, DoABC#2)
// , = "_-1gk" (String#5678, DoABC#2)


