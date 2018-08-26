
package com.sulake.core.window.utils
{
    import com.sulake.core.utils.XMLVariableParser;
    import com.sulake.core.utils.Map;

    public class XMLPropertyArrayParser extends XMLVariableParser 
    {

        public static function parse(_arg_1:XMLList):Array
        {
            var _local_5:int;
            var _local_2:Map = new Map();
            var _local_3:Array = new Array();
            var _local_4:Array = new Array();
            _local_5 = XMLVariableParser.parseVariableList(_arg_1, _local_2, _local_3);
            var _local_6:int;
            while (_local_6 < _local_5) {
                _local_4.push(new PropertyStruct(_local_2.getKey(_local_6), _local_2.getWithIndex(_local_6), _local_3[_local_6], true));
                _local_6++;
            };
            return (_local_4);
        }

    }
}//package com.sulake.core.window.utils

// XMLVariableParser = "_-pR" (String#24252, DoABC#2)
// PropertyStruct = "_-t6" (String#24410, DoABC#2)
// XMLPropertyArrayParser = "_-0b" (String#4324, DoABC#2)


