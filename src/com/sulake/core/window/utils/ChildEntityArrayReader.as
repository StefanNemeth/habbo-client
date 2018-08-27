
package com.sulake.core.window.utils
{
    public class ChildEntityArrayReader implements IChildEntityArrayReader 
    {

        protected var _SafeStr_3708:Array;

        public function ChildEntityArrayReader()
        {
            this._SafeStr_3708 = new Array();
            super();
        }
        public function get numChildren():int
        {
            return (this._SafeStr_3708.length);
        }
        public function getChildAt(_arg_1:int):IChildEntity
        {
            return (this._SafeStr_3708[_arg_1]);
        }
        public function getChildByID(_arg_1:uint):IChildEntity
        {
            var _local_3:IChildEntity;
            var _local_2:uint = this._SafeStr_3708.length;
            var _local_4:uint;
            while (_local_4 < _local_2) {
                _local_3 = this._SafeStr_3708[_local_4];
                if (_local_3.id == _arg_1){
                    return (_local_3);
                };
                _local_4++;
            };
            return (null);
        }
        public function getChildByTag(_arg_1:String):IChildEntity
        {
            var _local_3:IChildEntity;
            var _local_2:uint = this._SafeStr_3708.length;
            var _local_4:uint;
            while (_local_4 < _local_2) {
                _local_3 = this._SafeStr_3708[_local_4];
                if (_local_3.tags.indexOf(_arg_1) > -1){
                    return (_local_3);
                };
                _local_4++;
            };
            return (null);
        }
        public function getChildByName(_arg_1:String):IChildEntity
        {
            var _local_3:IChildEntity;
            var _local_2:uint = this._SafeStr_3708.length;
            var _local_4:uint;
            while (_local_4 < _local_2) {
                _local_3 = this._SafeStr_3708[_local_4];
                if (_local_3.name == _arg_1){
                    return (_local_3);
                };
                _local_4++;
            };
            return (null);
        }
        public function getChildIndex(_arg_1:IChildEntity):int
        {
            return (this._SafeStr_3708.indexOf(_arg_1));
        }
        public function groupChildrenWithID(_arg_1:uint, _arg_2:Array):uint
        {
            var _local_3:IChildEntity;
            var _local_6:uint;
            var _local_4:uint;
            var _local_5:uint = this._SafeStr_3708.length;
            _local_6 = 0;
            while (_local_6 < _local_5) {
                _local_3 = this._SafeStr_3708[_local_6];
                if (_local_3.id == _arg_1){
                    _arg_2.push(_local_3);
                    _local_4++;
                };
                _local_6++;
            };
            return (_local_4);
        }
        public function groupChildrenWithTag(_arg_1:String, _arg_2:Array):uint
        {
            var _local_3:IChildEntity;
            var _local_6:uint;
            var _local_4:uint;
            var _local_5:uint = this._SafeStr_3708.length;
            _local_6 = 0;
            while (_local_6 < _local_5) {
                _local_3 = this._SafeStr_3708[_local_6];
                if (_local_3.tags.indexOf(_arg_1) > -1){
                    _arg_2.push(_local_3);
                    _local_4++;
                };
                _local_6++;
            };
            return (_local_4);
        }

    }
}//package com.sulake.core.window.utils

// IChildEntityArrayReader = "_-1kK" (String#5755, DoABC#2)
// IChildEntity = "_-1NX" (String#5302, DoABC#2)
// ChildEntityArrayReader = "_-1e2" (String#5629, DoABC#2)
// _SafeStr_3708 = "_-2oC" (String#11, DoABC#2)
// groupChildrenWithTag = "_-cU" (String#2141, DoABC#2)
// getChildByID = "_-y3" (String#2226, DoABC#2)
// getChildByTag = "_-tP" (String#2212, DoABC#2)
// groupChildrenWithID = "_-2KM" (String#1856, DoABC#2)


