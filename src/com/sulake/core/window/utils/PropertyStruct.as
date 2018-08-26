
package com.sulake.core.window.utils
{
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import com.sulake.core.utils.Map;
    import flash.utils.getQualifiedClassName;

    public class PropertyStruct 
    {

        public static const _SafeStr_8991:String = "hex";
        public static const _SafeStr_8992:String = "int";
        public static const _SafeStr_8993:String = "uint";
        public static const _SafeStr_8994:String = "Number";
        public static const _SafeStr_8996:String = "Boolean";
        public static const _SafeStr_8998:String = "String";
        public static const _SafeStr_8999:String = "Point";
        public static const _SafeStr_9000:String = "Rectangle";
        public static const _SafeStr_9001:String = "Array";
        public static const _SafeStr_9002:String = "Map";

        private var _key:String;
        private var _value:Object;
        private var _type:String;
        private var _valid:Boolean;
        private var _SafeStr_9734:Boolean;
        private var _range:Array;

        public function PropertyStruct(_arg_1:String, _arg_2:Object, _arg_3:String, _arg_4:Boolean, _arg_5:Array=null)
        {
            this._key = _arg_1;
            this._value = _arg_2;
            this._type = _arg_3;
            this._valid = _arg_4;
            this._SafeStr_9734 = (((((((_arg_3 == _SafeStr_9002)) || ((_arg_3 == _SafeStr_9001)))) || ((_arg_3 == _SafeStr_8999)))) || ((_arg_3 == _SafeStr_9000)));
            this._range = _arg_5;
        }
        public function get key():String
        {
            return (this._key);
        }
        public function get value():Object
        {
            return (this._value);
        }
        public function get type():String
        {
            return (this._type);
        }
        public function get valid():Boolean
        {
            return (this._valid);
        }
        public function get range():Array
        {
            return (this._range);
        }
        public function toString():String
        {
            switch (this._type){
                case _SafeStr_8991:
                    return (("0x" + uint(this._value).toString(16)));
                case _SafeStr_8996:
                    return ((((Boolean(this._value))==true) ? "true" : "false"));
                case _SafeStr_8999:
                    return ((((("Point(" + Point(this._value).x) + ", ") + Point(this._value).y) + ")"));
                case _SafeStr_9000:
                    return ((((((((("Rectangle(" + Rectangle(this._value).x) + ", ") + Rectangle(this._value).y) + ", ") + Rectangle(this._value).width) + ", ") + Rectangle(this._value).height) + ")"));
            };
            return (String(this.value));
        }
        public function toXMLString():String
        {
            var _local_1:String;
            var _local_2:int;
            var _local_3:Map;
            var _local_4:Array;
            var _local_5:Point;
            var _local_6:Rectangle;
            switch (this._type){
                case _SafeStr_9002:
                    _local_3 = (this._value as Map);
                    _local_1 = (((('<var key="' + this._key) + '">\r<value>\r<') + this._type) + ">\r");
                    _local_2 = 0;
                    while (_local_2 < _local_3.length) {
                        _local_1 = (_local_1 + (((((('<var key="' + _local_3.getKey(_local_2)) + '" value="') + _local_3.getWithIndex(_local_2)) + '" type="') + getQualifiedClassName(_local_3.getWithIndex(_local_2))) + '" />\r'));
                        _local_2++;
                    };
                    _local_1 = (_local_1 + (("</" + this._type) + ">\r</value>\r</var>"));
                    break;
                case _SafeStr_9001:
                    _local_4 = (this._value as Array);
                    _local_1 = (((('<var key="' + this._key) + '">\r<value>\r<') + this._type) + ">\r");
                    _local_2 = 0;
                    while (_local_2 < _local_4.length) {
                        _local_1 = (_local_1 + (((((('<var key="' + String(_local_2)) + '" value="') + _local_4[_local_2]) + '" type="') + getQualifiedClassName(_local_4[_local_2])) + '" />\r'));
                        _local_2++;
                    };
                    _local_1 = (_local_1 + (("</" + this._type) + ">\r</value>\r</var>"));
                    break;
                case _SafeStr_8999:
                    _local_5 = (this._value as Point);
                    _local_1 = (((('<var key="' + this._key) + '">\r<value>\r<') + this._type) + ">\r");
                    _local_1 = (_local_1 + (((('<var key="x" value="' + _local_5.x) + '" type="') + _SafeStr_8992) + '" />\r'));
                    _local_1 = (_local_1 + (((('<var key="y" value="' + _local_5.y) + '" type="') + _SafeStr_8992) + '" />\r'));
                    _local_1 = (_local_1 + (("</" + this._type) + ">\r</value>\r</var>"));
                    break;
                case _SafeStr_9000:
                    _local_6 = (this._value as Rectangle);
                    _local_1 = (((('<var key="' + this._key) + '">\r<value>\r<') + this._type) + ">\r");
                    _local_1 = (_local_1 + (((('<var key="x" value="' + _local_6.x) + '" type="') + _SafeStr_8992) + '" />\r'));
                    _local_1 = (_local_1 + (((('<var key="y" value="' + _local_6.y) + '" type="') + _SafeStr_8992) + '" />\r'));
                    _local_1 = (_local_1 + (((('<var key="width" value="' + _local_6.width) + '" type="') + _SafeStr_8992) + '" />\r'));
                    _local_1 = (_local_1 + (((('<var key="height" value="' + _local_6.height) + '" type="') + _SafeStr_8992) + '" />\r'));
                    _local_1 = (_local_1 + (("</" + this._type) + ">\r</value>\r</var>"));
                    break;
                case _SafeStr_8991:
                    _local_1 = ((((((('<var key="' + this._key) + '" value="') + "0x") + uint(this._value).toString(16)) + '" type="') + this._type) + '" />');
                    break;
                default:
                    _local_1 = (((((('<var key="' + this._key) + '" value="') + this._value) + '" type="') + this._type) + '" />');
            };
            return (_local_1);
        }

    }
}//package com.sulake.core.window.utils

// PropertyStruct = "_-t6" (String#24410, DoABC#2)
// _value = "_-3Ao" (String#188, DoABC#2)
// _key = "_-1-r" (String#4864, DoABC#2)
// _SafeStr_8991 = "_-23W" (String#19156, DoABC#2)
// _SafeStr_8992 = "_-5d" (String#22447, DoABC#2)
// _SafeStr_8993 = "_-O-" (String#23167, DoABC#2)
// _SafeStr_8994 = "_-0yp" (String#16384, DoABC#2)
// _SafeStr_8996 = "_-0gH" (String#15685, DoABC#2)
// _SafeStr_8998 = "_-1lW" (String#18353, DoABC#2)
// _SafeStr_8999 = "_-32d" (String#21601, DoABC#2)
// _SafeStr_9000 = "_-ma" (String#24130, DoABC#2)
// _SafeStr_9001 = "_-2Pe" (String#20029, DoABC#2)
// _SafeStr_9002 = "_-2Wa" (String#20307, DoABC#2)
// valid = "_-H2" (String#22891, DoABC#2)
// _valid = "_-1np" (String#18453, DoABC#2)
// _SafeStr_9734 = "_-1ZN" (String#17865, DoABC#2)
// _range = "_-0dv" (String#15583, DoABC#2)
// range = "_-Rc" (String#23308, DoABC#2)


