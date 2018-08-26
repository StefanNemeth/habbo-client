
package com.sulake.habbo.tracking
{
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.core.utils.debug.GarbageMonitor;
    import flash.system.Capabilities;
    import flash.external.ExternalInterface;
    import flash.utils.getTimer;
    import flash.system.System;
    import com.sulake.habbo.communication.messages.outgoing.tracking.PerformanceLogMessageComposer;

    public class PerformanceTracker 
    {

        private var _connection:IConnection = null;
        private var _configuration:IHabboConfigurationManager = null;
        private var _SafeStr_4425:int = 0;
        private var _averageUpdateInterval:Number = 0;
        private var _SafeStr_13820:Array;
        private var _SafeStr_4807:String = "";
        private var _flashVersion:String = "";
        private var _SafeStr_4809:String = "";
        private var _SafeStr_4810:String = "";
        private var _SafeStr_4811:Boolean = false;
        private var _SafeStr_13821:GarbageMonitor = null;
        private var _SafeStr_4814:int = 0;
        private var _configuration:Boolean;
        private var _slowUpdateLimit:int = 1000;
        private var _SafeStr_4816:int = 0;
        private var _reportInterval:int = 60;
        private var _SafeStr_13802:int = 0;
        private var _reportLimit:int = 10;
        private var _SafeStr_13825:int = 0;
        private var _SafeStr_13826:Number = 0.15;
        private var _SafeStr_13827:Boolean = true;
        private var _SafeStr_13828:Number = 0;

        public function PerformanceTracker()
        {
            this._SafeStr_13820 = [];
            super();
            this._flashVersion = Capabilities.version;
            this._SafeStr_4809 = Capabilities.os;
            this._SafeStr_4811 = Capabilities.isDebugger;
            this._SafeStr_4807 = ((ExternalInterface.available) ? ExternalInterface.call("window.navigator.userAgent.toString") : "unknown");
            if (this._SafeStr_4807 == null){
                this._SafeStr_4807 = "unknown";
            };
            this._SafeStr_13821 = new GarbageMonitor();
            this.updateGarbageMonitor();
            this._SafeStr_13802 = getTimer();
        }
        public function get flashVersion():String
        {
            return (this._flashVersion);
        }
        public function get averageUpdateInterval():int
        {
            return (this._averageUpdateInterval);
        }
        public function set slowUpdateLimit(_arg_1:int):void
        {
            this._slowUpdateLimit = _arg_1;
        }
        public function set reportInterval(_arg_1:int):void
        {
            this._reportInterval = _arg_1;
        }
        public function set reportLimit(_arg_1:int):void
        {
            this._reportLimit = _arg_1;
        }
        public function set connection(_arg_1:IConnection):void
        {
            this._connection = _arg_1;
        }
        public function set configuration(_arg_1:IHabboConfigurationManager):void
        {
            this._configuration = _arg_1;
            this._reportInterval = int(this._configuration.getKey("performancetest.interval", "60"));
            this._slowUpdateLimit = int(this._configuration.getKey("performancetest.slowupdatelimit", "1000"));
            this._reportLimit = int(this._configuration.getKey("performancetest.reportlimit", "10"));
            this._SafeStr_13826 = Number(this._configuration.getKey("performancetest.distribution.deviancelimit.percent", "10"));
            this._SafeStr_13827 = Boolean(int(this._configuration.getKey("performancetest.distribution.enabled", "1")));
            this._configuration = Boolean((this._configuration.getKey("monitor.garbage.collection", "0") == "1"));
        }
        public function dispose():void
        {
        }
        private function updateGarbageMonitor():Object
        {
            var _local_2:Object;
            var _local_1:Array = this._SafeStr_13821.list;
            if ((((_local_1 == null)) || ((_local_1.length == 0)))){
                _local_2 = new GarbageTester("tester");
                this._SafeStr_13821.insert(_local_2, "tester");
                return (_local_2);
            };
            return (null);
        }
        public function update(_arg_1:uint, _arg_2:int):void
        {
            var _local_4:Object;
            var _local_5:Number;
            var _local_6:uint;
            var _local_7:Boolean;
            var _local_8:Number;
            if (this._configuration){
                _local_4 = this.updateGarbageMonitor();
                if (_local_4 != null){
                    this._SafeStr_4814++;
                    Logger.log("Garbage collection");
                };
            };
            var _local_3:Boolean;
            if (_arg_1 > this._slowUpdateLimit){
                this._SafeStr_4816++;
                _local_3 = true;
            }
            else {
                this._SafeStr_4425++;
                if (this._SafeStr_4425 <= 1){
                    this._averageUpdateInterval = _arg_1;
                }
                else {
                    _local_5 = Number(this._SafeStr_4425);
                    this._averageUpdateInterval = (((this._averageUpdateInterval * (_local_5 - 1)) / _local_5) + (Number(_arg_1) / _local_5));
                };
            };
            if (((((_arg_2 - this._SafeStr_13802) > (this._reportInterval * 1000))) && ((this._SafeStr_13825 < this._reportLimit)))){
                _local_6 = System.totalMemory;
                Logger.log((((("*** Performance tracker: average frame rate " + (1000 / this._averageUpdateInterval)) + "/s, system memory usage : ") + _local_6) + " bytes"));
                _local_7 = true;
                if (((this._SafeStr_13827) && ((this._SafeStr_13825 > 0)))){
                    _local_8 = this.differenceInPercents(this._SafeStr_13828, this._averageUpdateInterval);
                    if (_local_8 < this._SafeStr_13826){
                        _local_7 = false;
                    };
                };
                this._SafeStr_13802 = _arg_2;
                if (((_local_7) || (_local_3))){
                    this._SafeStr_13828 = this._averageUpdateInterval;
                    if (this.sendReport(_arg_2)){
                        this._SafeStr_13825++;
                    };
                };
            };
        }
        private function sendReport(_arg_1:int):Boolean
        {
            var _local_2:PerformanceLogMessageComposer;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            if (this._connection != null){
                _local_2 = null;
                _local_3 = (_arg_1 / 1000);
                _local_4 = -1;
                _local_5 = (System.totalMemory / 0x0400);
                _local_2 = new PerformanceLogMessageComposer(_local_3, this._SafeStr_4807, this._flashVersion, this._SafeStr_4809, this._SafeStr_4810, this._SafeStr_4811, _local_5, _local_4, this._SafeStr_4814, this._averageUpdateInterval, this._SafeStr_4816);
                this._connection.send(_local_2);
                this._SafeStr_4814 = 0;
                this._averageUpdateInterval = 0;
                this._SafeStr_4425 = 0;
                this._SafeStr_4816 = 0;
                return (true);
            };
            return (false);
        }
        private function differenceInPercents(_arg_1:Number, _arg_2:Number):Number
        {
            if (_arg_1 == _arg_2){
                return (0);
            };
            var _local_3:Number = _arg_1;
            var _local_4:Number = _arg_2;
            if (_arg_2 > _arg_1){
                _local_3 = _arg_2;
                _local_4 = _arg_1;
            };
            return ((100 * (1 - (_local_4 / _local_3))));
        }

    }
}//package com.sulake.habbo.tracking

// _SafeStr_13802 = "_-1y9" (String#5997, DoABC#2)
// _averageUpdateInterval = "_-de" (String#2145, DoABC#2)
// _SafeStr_13820 = "_-0F3" (String#14647, DoABC#2)
// _SafeStr_13821 = "_-3Gn" (String#22155, DoABC#2)
// _configuration = "_-1e8" (String#18063, DoABC#2)
// _slowUpdateLimit = "_-286" (String#19333, DoABC#2)
// _reportLimit = "_-2Lm" (String#19875, DoABC#2)
// _SafeStr_13825 = "_-1-q" (String#16462, DoABC#2)
// _SafeStr_13826 = "_-Ar" (String#22650, DoABC#2)
// _SafeStr_13827 = "_-1iY" (String#18229, DoABC#2)
// _SafeStr_13828 = "_-lo" (String#24102, DoABC#2)
// updateGarbageMonitor = "_-y0" (String#24614, DoABC#2)
// flashVersion = "_-a" (String#23632, DoABC#2)
// averageUpdateInterval = "_-1x9" (String#18853, DoABC#2)
// slowUpdateLimit = "_-0gs" (String#15703, DoABC#2)
// reportInterval = "_-0SG" (String#15144, DoABC#2)
// reportLimit = "_-3JZ" (String#22266, DoABC#2)
// differenceInPercents = "_-2fu" (String#20687, DoABC#2)
// sendReport = "_-3Fm" (String#22108, DoABC#2)
// GarbageMonitor = "_-04w" (String#3664, DoABC#2)
// GarbageTester = "_-2gL" (String#6877, DoABC#2)
// PerformanceLogMessageComposer = "_-2J" (String#6421, DoABC#2)
// _SafeStr_4425 = "_-vA" (String#643, DoABC#2)
// _SafeStr_4807 = "_-0zO" (String#4835, DoABC#2)
// _flashVersion = "_-nD" (String#8660, DoABC#2)
// _SafeStr_4809 = "_-0h-" (String#4446, DoABC#2)
// _SafeStr_4810 = "_-DT" (String#7941, DoABC#2)
// _SafeStr_4811 = "_-1TJ" (String#5420, DoABC#2)
// _SafeStr_4814 = "_-190" (String#5056, DoABC#2)
// _SafeStr_4816 = "_-2nL" (String#7028, DoABC#2)
// PerformanceTracker = "_-2q2" (String#21082, DoABC#2)


