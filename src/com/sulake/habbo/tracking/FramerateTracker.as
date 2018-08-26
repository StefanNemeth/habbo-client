
package com.sulake.habbo.tracking
{
    import com.sulake.habbo.configuration.IHabboConfigurationManager;

    public class FramerateTracker 
    {

        private var _SafeStr_13802:int;
        private var _SafeStr_13803:int;
        private var _SafeStr_13804:int;
        private var _averageUpdateInterval:Number;
        private var _SafeStr_13806:Boolean;
        private var _SafeStr_13807:int;
        private var _SafeStr_13808:int;

        public function get frameRate():int
        {
            return (Math.round((1000 / this._averageUpdateInterval)));
        }
        public function FramerateTracker(_arg_1:IHabboConfigurationManager):void
        {
            this._SafeStr_13803 = (int(_arg_1.getKey("tracking.framerate.reportInterval.seconds", "300")) * 1000);
            this._SafeStr_13807 = int(_arg_1.getKey("tracking.framerate.maximumEvents", "5"));
            this._SafeStr_13806 = true;
        }
        public function FramerateTracker(_arg_1:uint, _arg_2:IHabboTracking, _arg_3:int):void
        {
            var _local_4:Number;
            this._SafeStr_13804++;
            if (this._SafeStr_13804 == 1){
                this._averageUpdateInterval = _arg_1;
                this._SafeStr_13802 = _arg_3;
            }
            else {
                _local_4 = Number(this._SafeStr_13804);
                this._averageUpdateInterval = (((this._averageUpdateInterval * (_local_4 - 1)) / _local_4) + (Number(_arg_1) / _local_4));
            };
            if (((this._SafeStr_13806) && (((_arg_3 - this._SafeStr_13802) >= this._SafeStr_13803)))){
                this._SafeStr_13804 = 0;
                if (this._SafeStr_13808 < this._SafeStr_13807){
                    _arg_2.trackGoogle("performance", "averageFramerate", this.frameRate);
                    this._SafeStr_13808++;
                    this._SafeStr_13802 = _arg_3;
                };
            };
        }
        public function dispose():void
        {
        }

    }
}//package com.sulake.habbo.tracking

// FramerateTracker = "_-2eD" (String#20612, DoABC#2)
// _SafeStr_13802 = "_-1y9" (String#5997, DoABC#2)
// _SafeStr_13803 = "_-0ye" (String#16380, DoABC#2)
// _SafeStr_13804 = "_-AT" (String#7877, DoABC#2)
// _averageUpdateInterval = "_-de" (String#2145, DoABC#2)
// _SafeStr_13806 = "_-2rw" (String#21153, DoABC#2)
// _SafeStr_13807 = "_-0wP" (String#16287, DoABC#2)
// _SafeStr_13808 = "_-1Of" (String#17455, DoABC#2)
// FramerateTracker = "_-Mk" (String#23116, DoABC#2)
// IHabboTracking = "_-0fl" (String#4419, DoABC#2)
// trackGoogle = "_-3Fx" (String#7630, DoABC#2)
// FramerateTracker = "_-Ud" (String#23432, DoABC#2)


