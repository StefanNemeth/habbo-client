
package com.sulake.habbo.tracking
{
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.communication.messages.outgoing.tracking.LagWarningReportMessageComposer;

    public class LagWarningLogger 
    {

        private var _connection:IConnection;
        private var _enabled:Boolean = false;
        private var _SafeStr_13837:int;
        private var _lastWarning:int;
        private var _SafeStr_4817:int;

        public function set connection(_arg_1:IConnection):void
        {
            this._connection = _arg_1;
        }
        public function configure(_arg_1:IHabboConfigurationManager):void
        {
            this._enabled = Boolean(int(_arg_1.getKey("lagWarningLog.enabled", "1")));
            this._SafeStr_13837 = (int(_arg_1.getKey("lagWarningLog.interval.seconds", "10")) * 1000);
        }
        public function chatLagDetected(_arg_1:int):void
        {
            if (((!(this._enabled)) || ((this._SafeStr_13837 <= 0)))){
                return;
            };
            this._SafeStr_4817++;
            this.reportWarningsAsNeeded(_arg_1);
        }
        public function update(_arg_1:int):void
        {
            this.reportWarningsAsNeeded(_arg_1);
        }
        private function reportWarningsAsNeeded(_arg_1:int):void
        {
            var _local_2:LagWarningReportMessageComposer;
            if ((((this._SafeStr_4817 == 0)) || ((this._connection == null)))){
                return;
            };
            if ((((this._lastWarning == 0)) || (((_arg_1 - this._lastWarning) > this._SafeStr_13837)))){
                _local_2 = new LagWarningReportMessageComposer(this._SafeStr_4817);
                this._connection.send(_local_2);
                this._lastWarning = _arg_1;
                this._SafeStr_4817 = 0;
            };
        }

    }
}//package com.sulake.habbo.tracking

// chatLagDetected = "_-1JX" (String#5231, DoABC#2)
// configure = "_-2eD" (String#20612, DoABC#2)
// _SafeStr_13837 = "_-1qE" (String#18552, DoABC#2)
// reportWarningsAsNeeded = "_-2Vk" (String#20270, DoABC#2)
// LagWarningReportMessageComposer = "_-p1" (String#8691, DoABC#2)
// _SafeStr_4817 = "_-2Et" (String#6340, DoABC#2)
// _enabled = "_-38q" (String#2010, DoABC#2)
// LagWarningLogger = "_-2Kc" (String#19828, DoABC#2)


