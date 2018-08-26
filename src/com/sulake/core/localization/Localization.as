
package com.sulake.core.localization
{
    import flash.utils.Dictionary;

    public class Localization implements ILocalization 
    {

        private var _key:String;
        private var _value:String;
        private var _parameters:Dictionary;
        private var _SafeStr_8865:Array;
        private var _isInitialized:Boolean = false;

        public function Localization(_arg_1:String, _arg_2:String=null)
        {
            this._SafeStr_8865 = new Array();
            this._parameters = new Dictionary();
            this._key = _arg_1;
            this._value = _arg_2;
        }
        public function get isInitialized():Boolean
        {
            return (!((this._value == null)));
        }
        public function get key():String
        {
            return (this._key);
        }
        public function get value():String
        {
            return (this.fillParameterValues());
        }
        public function get raw():String
        {
            return (this._value);
        }
        public function setValue(_arg_1:String):void
        {
            this._value = _arg_1;
            this.updateListeners();
        }
        public function registerListener(_arg_1:ILocalizable):void
        {
            this._SafeStr_8865.push(_arg_1);
            _arg_1.localization = this.value;
        }
        public function PetDataManager(_arg_1:ILocalizable):void
        {
            var _local_2:int = this._SafeStr_8865.indexOf(_arg_1);
            if (_local_2 >= 0){
                this._SafeStr_8865.splice(_local_2, 1);
            };
        }
        public function registerParameter(_arg_1:String, _arg_2:String, _arg_3:String="%"):void
        {
            _arg_1 = ((_arg_3 + _arg_1) + _arg_3);
            this._parameters[_arg_1] = _arg_2;
            this.updateListeners();
        }
        public function updateListeners():void
        {
            var _local_1:ILocalizable;
            for each (_local_1 in this._SafeStr_8865) {
                _local_1.localization = this.value;
            };
        }
        private function fillParameterValues():String
        {
            var _local_2:String;
            var _local_3:String;
            var _local_4:RegExp;
            var _local_1:String = this._value;
            for (_local_2 in this._parameters) {
                _local_3 = this._parameters[_local_2];
                _local_4 = new RegExp(_local_2, "gim");
                if (_local_1 != null){
                    _local_1 = _local_1.replace(_local_4, _local_3);
                };
            };
            return (_local_1);
        }

    }
}//package com.sulake.core.localization

// ILocalization = "_-2EY" (String#1839, DoABC#2)
// ILocalizable = "_-3Dn" (String#2024, DoABC#2)
// Localization = "_-1UB" (String#5436, DoABC#2)
// _value = "_-3Ao" (String#188, DoABC#2)
// _parameters = "_-r-" (String#945, DoABC#2)
// isInitialized = "_-1Cr" (String#840, DoABC#2)
// raw = "_-Xc" (String#8361, DoABC#2)
// _key = "_-1-r" (String#4864, DoABC#2)
// _SafeStr_8865 = "_-0RW" (String#1471, DoABC#2)
// fillParameterValues = "_-ao" (String#23663, DoABC#2)
// updateListeners = "_-1i" (String#18210, DoABC#2)
// registerListener = "_-6e" (String#7798, DoABC#2)
// PetDataManager = "_-1Hc" (String#1653, DoABC#2)


