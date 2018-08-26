
package com.sulake.room.utils
{
    public class XMLValidator 
    {

        public static function checkRequiredAttributes(_arg_1:Object, _arg_2:Array):Boolean
        {
            var _local_4:XML;
            var _local_5:XMLList;
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return (false);
            };
            var _local_3:int;
            if ((_arg_1 is XML)){
                _local_4 = (_arg_1 as XML);
                _local_3 = 0;
                while (_local_3 < _arg_2.length) {
                    if (_local_4.attribute(String(_arg_2[_local_3])).length() == 0){
                        return (false);
                    };
                    _local_3++;
                };
            }
            else {
                if ((_arg_1 is XMLList)){
                    _local_5 = (_arg_1 as XMLList);
                    _local_3 = 0;
                    while (_local_3 < _arg_2.length) {
                        if (_local_4.attribute(String(_arg_2[_local_3])).length() == 0){
                            return (false);
                        };
                        _local_3++;
                    };
                }
                else {
                    return (false);
                };
            };
            return (true);
        }

    }
}//package com.sulake.room.utils

