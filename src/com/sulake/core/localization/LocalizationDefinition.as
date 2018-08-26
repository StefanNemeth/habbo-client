
package com.sulake.core.localization
{
    public class LocalizationDefinition implements ILocalizationDefinition 
    {

        private var _languageCode:String;
        private var _countryCode:String;
        private var _encoding:String;
        private var _name:String;
        private var _url:String;

        public function LocalizationDefinition(_arg_1:String, _arg_2:String, _arg_3:String)
        {
            var _local_4:Array = _arg_1.split("_");
            this._languageCode = _local_4[0];
            var _local_5:Array = String(_local_4[1]).split(".");
            this._countryCode = _local_5[0];
            this._encoding = _local_5[1];
            this._name = _arg_2;
            this._url = _arg_3;
        }
        public function get id():String
        {
            return (((((this._languageCode + "_") + this._countryCode) + ".") + this._encoding));
        }
        public function get languageCode():String
        {
            return (this._languageCode);
        }
        public function get countryCode():String
        {
            return (this._countryCode);
        }
        public function get encoding():String
        {
            return (this._encoding);
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get url():String
        {
            return (this._url);
        }

    }
}//package com.sulake.core.localization

// ILocalizationDefinition = "_-oS" (String#2194, DoABC#2)
// LocalizationDefinition = "_-1PB" (String#5336, DoABC#2)
// _url = "_-3Jl" (String#151, DoABC#2)
// languageCode = "_-2S1" (String#6608, DoABC#2)
// countryCode = "_-2yl" (String#7255, DoABC#2)
// encoding = "_-k1" (String#8603, DoABC#2)
// _languageCode = "_-0Ie" (String#14786, DoABC#2)
// _countryCode = "_-2FU" (String#19622, DoABC#2)
// _encoding = "_-2Sz" (String#20161, DoABC#2)


