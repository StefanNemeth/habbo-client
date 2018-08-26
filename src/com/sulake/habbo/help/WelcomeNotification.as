
package com.sulake.habbo.help
{
    public class WelcomeNotification 
    {

        private var _targetIconId:String;
        private var _localizationKey:String;

        public function WelcomeNotification(_arg_1:String, _arg_2:String)
        {
            this._targetIconId = _arg_1;
            this._localizationKey = _arg_2;
        }
        public function get targetIconId():String
        {
            return (this._targetIconId);
        }
        public function get localizationKey():String
        {
            return (this._localizationKey);
        }

    }
}//package com.sulake.habbo.help

// _targetIconId = "_-1NW" (String#17418, DoABC#2)
// targetIconId = "_-1LJ" (String#17325, DoABC#2)
// WelcomeNotification = "_-ka" (String#8616, DoABC#2)
// _localizationKey = "_-09T" (String#1412, DoABC#2)


