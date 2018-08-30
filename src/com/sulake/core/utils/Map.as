
package com.sulake.core.utils
{
    import flash.utils.Proxy;
    import com.sulake.core.runtime.IDisposable;
    import flash.utils.Dictionary;
    import com.sulake.core.Core;
    import flash.utils.flash_proxy; 
    use namespace flash.utils.flash_proxy;

    public class Map extends Proxy implements IDisposable 
    {

        private var _length:uint;
        private var _SafeStr_8890:Dictionary;
        private var _messageArray:Array;
        private var _keys:Array;
        private var _singleWrite:Boolean = false;

        public function Map(_arg_1:Boolean=false)
        {
            this._singleWrite = _arg_1;
            this._length = 0;
            this._SafeStr_8890 = new Dictionary();
            this._messageArray = [];
            this._keys = [];
        }
        public function get length():uint
        {
            return (this._length);
        }
        public function get disposed():Boolean
        {
            return ((this._SafeStr_8890 == null));
        }
        public function dispose():void
        {
            var _local_1:Object;
            if (this._SafeStr_8890 != null){
                for (_local_1 in this._SafeStr_8890) {
                    delete this._SafeStr_8890[_local_1];
                };
                this._SafeStr_8890 = null;
            };
            this._length = 0;
            this._messageArray = null;
            this._keys = null;
        }
        public function reset():void
        {
            var _local_1:Object;
            for (_local_1 in this._SafeStr_8890) {
                delete this._SafeStr_8890[_local_1];
            };
            this._length = 0;
            this._messageArray = [];
            this._keys = [];
        }
        public function unshift(_arg_1:*, _arg_2:*):Boolean
        {
            if (this._SafeStr_8890[_arg_1] != null){
                return (false);
            };
            this._SafeStr_8890[_arg_1] = _arg_2;
            this._messageArray.unshift(_arg_2);
            this._keys.unshift(_arg_1);
            this._length++;
            return (true);
        }
        public function add(_arg_1:*, _arg_2:*):Boolean
        {
            if (this._SafeStr_8890[_arg_1] != null){
                return (false);
            };
            this._SafeStr_8890[_arg_1] = _arg_2;
            this._messageArray[this._length] = _arg_2;
            this._keys[this._length] = _arg_1;
            this._length++;
            return (true);
        }
        public function getValue(_arg_1:*)
        {
            return (this._SafeStr_8890[_arg_1]);
        }
        public function remove(_arg_1:*)
        {
            var _local_2:Object = this._SafeStr_8890[_arg_1];
            if (_local_2 == null){
                return (null);
            };
            var _local_3:int = this._messageArray.indexOf(_local_2);
            if (_local_3 >= 0){
                this._messageArray.splice(_local_3, 1);
                this._keys.splice(_local_3, 1);
                this._length--;
            };
            delete this._SafeStr_8890[_arg_1];
            return (_local_2);
        }
        public function getWithIndex(_arg_1:int)
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this._length)))){
                return (null);
            };
            return (this._messageArray[_arg_1]);
        }
        public function getKey(_arg_1:int)
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this._length)))){
                return (null);
            };
            return (this._keys[_arg_1]);
        }
        public function getKeys():Array
        {
            return (this._keys.slice());
        }
        public function getValues():Array
        {
            return (this._messageArray.slice());
        }
        override flash_proxy function getProperty(_arg_1:*)
        {
            if ((_arg_1 is QName)){
                _arg_1 = QName(_arg_1).localName;
            };
            return (this._SafeStr_8890[_arg_1]);
        }
        override flash_proxy function setProperty(_arg_1:*, _arg_2:*):void
        {
            if ((_arg_1 is QName)){
                _arg_1 = QName(_arg_1).localName;
            };
            if (this._singleWrite){
                if (this._SafeStr_8890[_arg_1] != null){
                    Core.error(((("Trying to write to a single write Map. Key: " + _arg_1) + ", value: ") + _arg_2), true, Core._SafeStr_9058);
                };
            };
            this._SafeStr_8890[_arg_1] = _arg_2;
            var _local_3:int = this._keys.indexOf(_arg_1);
            if (_local_3 == -1){
                this._messageArray[this._length] = _arg_2;
                this._keys[this._length] = _arg_1;
                this._length++;
            }
            else {
                this._messageArray.splice(_local_3, 1, _arg_2);
            };
        }
        override flash_proxy function nextNameIndex(_arg_1:int):int
        {
            if (_arg_1 < this._keys.length){
                return ((_arg_1 + 1));
            };
            return (0);
        }
        override flash_proxy function nextName(_arg_1:int):String
        {
            return (this._keys[(_arg_1 - 1)]);
        }
        override flash_proxy function nextValue(_arg_1:int)
        {
            return (this._messageArray[(_arg_1 - 1)]);
        }
        override flash_proxy function callProperty(_arg_1:*, ... _args)
        {
            var _local_3:String;
            if (_arg_1.localName == "toString"){
                return ("Map");
            };
            return (null);
        }

    }
}//package com.sulake.core.utils

// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _messageArray = "_-2oC" (String#11, DoABC#2)
// getValues = "_-2U9" (String#20205, DoABC#2)
// _SafeStr_8890 = "_-0EV" (String#3839, DoABC#2)
// _SafeStr_9058 = "_-MM" (String#23098, DoABC#2)


