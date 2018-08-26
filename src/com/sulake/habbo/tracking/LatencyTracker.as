
package com.sulake.habbo.tracking
{
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.communication.messages.incoming.tracking.LatencyPingResponseMessageEvent;
    import flash.utils.getTimer;
    import com.sulake.habbo.communication.messages.outgoing.tracking.LatencyPingRequestMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.tracking.LatencyPingReportMessageComposer;
    import com.sulake.habbo.communication.messages.parser.tracking.LatencyPingResponseMessageParser;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class LatencyTracker 
    {

        private var _state:Boolean = false;
        private var _configuration:IHabboConfigurationManager;
        private var _communication:IHabboCommunicationManager;
        private var _connection:IConnection;
        private var _SafeStr_13839:int = 0;
        private var _SafeStr_13840:int = 0;
        private var _SafeStr_13841:int = 0;
        private var _SafeStr_13842:int = 0;
        private var _SafeStr_13843:int = 0;
        private var _SafeStr_13844:int = 0;
        private var _SafeStr_13845:Array;
        private var _SafeStr_13846:Map;

        public function set configuration(_arg_1:IHabboConfigurationManager):void
        {
            this._configuration = _arg_1;
        }
        public function set communication(_arg_1:IHabboCommunicationManager):void
        {
            this._communication = _arg_1;
        }
        public function set connection(_arg_1:IConnection):void
        {
            this._connection = _arg_1;
        }
        public function dispose():void
        {
            this._state = false;
            this._configuration = null;
            this._communication = null;
            this._connection = null;
            if (this._SafeStr_13846 != null){
                this._SafeStr_13846.dispose();
                this._SafeStr_13846 = null;
            };
            this._SafeStr_13845 = null;
        }
        public function init():void
        {
            if ((((((this._configuration == null)) || ((this._communication == null)))) || ((this._connection == null)))){
                return;
            };
            this._SafeStr_13840 = int(this._configuration.getKey("latencytest.interval"));
            this._SafeStr_13841 = int(this._configuration.getKey("latencytest.report.index"));
            this._SafeStr_13842 = int(this._configuration.getKey("latencytest.report.delta"));
            this._communication.HabboCommunicationManager(new LatencyPingResponseMessageEvent(this.LatencyTracker));
            if (this._SafeStr_13840 < 1){
                return;
            };
            this._SafeStr_13846 = new Map();
            this._SafeStr_13845 = new Array();
            this._state = true;
        }
        public function update(_arg_1:uint, _arg_2:int):void
        {
            if (!this._state){
                return;
            };
            if ((_arg_2 - this._SafeStr_13843) > this._SafeStr_13840){
                this.LatencyTracker();
            };
        }
        private function LatencyTracker():void
        {
            this._SafeStr_13843 = getTimer();
            this._SafeStr_13846.add(this._SafeStr_13839, this._SafeStr_13843);
            this._connection.send(new LatencyPingRequestMessageComposer(this._SafeStr_13839));
            this._SafeStr_13839++;
        }
        private function LatencyTracker(_arg_1:IMessageEvent):void
        {
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:LatencyPingReportMessageComposer;
            if ((((this._SafeStr_13846 == null)) || ((this._SafeStr_13845 == null)))){
                return;
            };
            var _local_2:LatencyPingResponseMessageParser = (_arg_1 as LatencyPingResponseMessageEvent).getParser();
            var _local_3:int = this._SafeStr_13846.getValue(_local_2.requestId);
            this._SafeStr_13846.remove(_local_2.requestId);
            var _local_4:int = (getTimer() - _local_3);
            this._SafeStr_13845.push(_local_4);
            if ((((this._SafeStr_13845.length == this._SafeStr_13841)) && ((this._SafeStr_13841 > 0)))){
                _local_5 = 0;
                _local_6 = 0;
                _local_7 = 0;
                _local_8 = 0;
                while (_local_8 < this._SafeStr_13845.length) {
                    _local_5 = (_local_5 + this._SafeStr_13845[_local_8]);
                    _local_8++;
                };
                _local_9 = (_local_5 / this._SafeStr_13845.length);
                _local_8 = 0;
                while (_local_8 < this._SafeStr_13845.length) {
                    if (this._SafeStr_13845[_local_8] < (_local_9 * 2)){
                        _local_6 = (_local_6 + this._SafeStr_13845[_local_8]);
                        _local_7++;
                    };
                    _local_8++;
                };
                if (_local_7 == 0){
                    this._SafeStr_13845 = [];
                    return;
                };
                _local_10 = (_local_6 / _local_7);
                if ((((Math.abs((_local_9 - this._SafeStr_13844)) > this._SafeStr_13842)) || ((this._SafeStr_13844 == 0)))){
                    this._SafeStr_13844 = _local_9;
                    _local_11 = new LatencyPingReportMessageComposer(_local_9, _local_10, this._SafeStr_13845.length);
                    this._connection.send(_local_11);
                };
                this._SafeStr_13845 = [];
            };
        }

    }
}//package com.sulake.habbo.tracking

// _SafeStr_13839 = "_-2Za" (String#20423, DoABC#2)
// _SafeStr_13840 = "_-072" (String#14326, DoABC#2)
// _SafeStr_13841 = "_-1Hr" (String#17187, DoABC#2)
// _SafeStr_13842 = "_-1ej" (String#18087, DoABC#2)
// _SafeStr_13843 = "_-2Jc" (String#19795, DoABC#2)
// _SafeStr_13844 = "_-1EI" (String#17039, DoABC#2)
// _SafeStr_13845 = "extends" (String#45027, DoABC#2)
// _SafeStr_13846 = "_-2-Z" (String#18994, DoABC#2)
// LatencyTracker = "_-0hN" (String#15723, DoABC#2)
// LatencyTracker = "_-1Nz" (String#17434, DoABC#2)
// LatencyPingResponseMessageEvent = "_-0pM" (String#4621, DoABC#2)
// LatencyPingResponseMessageParser = "_-1iU" (String#5722, DoABC#2)
// LatencyPingReportMessageComposer = "_-0Bk" (String#3790, DoABC#2)
// LatencyPingRequestMessageComposer = "_-2OZ" (String#6530, DoABC#2)
// requestId = "_-li" (String#24099, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// communication = "_-3HD" (String#22171, DoABC#2)
// HabboCommunicationManager = "_-0r" (String#4663, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// LatencyTracker = "_-RJ" (String#23297, DoABC#2)


