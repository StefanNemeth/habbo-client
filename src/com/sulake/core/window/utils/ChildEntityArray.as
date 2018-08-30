
package com.sulake.core.window.utils
{
    public class ChildEntityArray extends ChildEntityArrayReader implements IChildEntityArray 
    {

        public function removeChild(_arg_1:IChildEntity):IChildEntity
        {
            var _local_2:int = _messageArray.indexOf(_arg_1);
            if (_local_2 < 0){
                return (null);
            };
            _messageArray.splice(_local_2, 1);
            return (_arg_1);
        }
        public function addChild(_arg_1:IChildEntity):IChildEntity
        {
            _messageArray.push(_arg_1);
            return (_arg_1);
        }
        public function addChildAt(_arg_1:IChildEntity, _arg_2:int):IChildEntity
        {
            _messageArray.splice(_arg_2, 0, _arg_1);
            return (_arg_1);
        }
        public function removeChildAt(_arg_1:int):IChildEntity
        {
            var _local_2:IChildEntity = _messageArray[_arg_1];
            if (_local_2 != null){
                _messageArray.splice(_arg_1, 1);
                return (_local_2);
            };
            return (null);
        }
        public function setChildIndex(_arg_1:IChildEntity, _arg_2:int):void
        {
            var _local_3:int = _messageArray.indexOf(_arg_1);
            if ((((_local_3 > -1)) && (!((_arg_2 == _local_3))))){
                _messageArray.splice(_local_3, 1);
                _messageArray.splice(_arg_2, 0, _arg_1);
            };
        }
        public function swapChildren(_arg_1:IChildEntity, _arg_2:IChildEntity):void
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:IChildEntity;
            var _local_6:int;
            if (((((!((_arg_1 == null))) && (!((_arg_2 == null))))) && (!((_arg_1 == _arg_2))))){
                _local_3 = _messageArray.indexOf(_arg_1);
                if (_local_3 < 0){
                    return;
                };
                _local_4 = _messageArray.indexOf(_arg_2);
                if (_local_4 < 0){
                    return;
                };
                if (_local_4 < _local_3){
                    _local_5 = _arg_1;
                    _arg_1 = _arg_2;
                    _arg_2 = _local_5;
                    _local_6 = _local_3;
                    _local_3 = _local_4;
                    _local_4 = _local_6;
                };
                _messageArray.splice(_local_4, 1);
                _messageArray.splice(_local_3, 1);
                _messageArray.splice(_local_3, 0, _arg_2);
                _messageArray.splice(_local_4, 0, _arg_1);
            };
        }
        public function swapChildrenAt(_arg_1:int, _arg_2:int):void
        {
            this.swapChildren(_messageArray[_arg_1], _messageArray[_arg_2]);
        }

    }
}//package com.sulake.core.window.utils

// IChildEntityArray = "_-2oU" (String#7047, DoABC#2)
// IChildEntity = "_-1NX" (String#5302, DoABC#2)
// ChildEntityArrayReader = "_-1e2" (String#5629, DoABC#2)
// ChildEntityArray = "_-w1" (String#8805, DoABC#2)
// _messageArray = "_-2oC" (String#11, DoABC#2)


