
package com.sulake.core.window.events
{
    import com.sulake.core.runtime.IDisposable;
    import flash.utils.Dictionary;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.runtime.events.EventListenerStruct;

    public class WindowEventDispatcher implements IDisposable 
    {

        private static const EVENT_RESULT_TRUE:uint = 0;
        private static const EVENT_RESULT_FALSE:uint = 1;
        private static const EVENT_RESULT_ERROR:uint = 2;

        protected var _disposed:Boolean = false;
        private var _eventListenerTable:Dictionary;
        private var _result:uint;
        private var _error:Error;

        public function WindowEventDispatcher(_arg_1:IWindow)
        {
            this._eventListenerTable = new Dictionary();
            super();
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get error():Error
        {
            return (this._error);
        }
        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:int=0):void
        {
            var _local_6:EventListenerStruct;
            var _local_4:Array = this._eventListenerTable[_arg_1];
            var _local_5:EventListenerStruct = new EventListenerStruct(_arg_2, false, _arg_3);
            if (!_local_4){
                _local_4 = [_local_5];
                this._eventListenerTable[_arg_1] = _local_4;
            }
            else {
                for each (_local_6 in _local_4) {
                    if (_local_6.callback == _arg_2){
                        return;
                    };
                    if (_arg_3 > _local_6.priority){
                        _local_4.splice(_local_4.indexOf(_local_6), 0, _local_5);
                        return;
                    };
                };
                _local_4.push(_local_5);
            };
        }
        public function removeEventListener(_arg_1:String, _arg_2:Function):void
        {
            var _local_3:Array;
            var _local_4:uint;
            var _local_5:EventListenerStruct;
            if (!this._disposed){
                _local_3 = this._eventListenerTable[_arg_1];
                if (_local_3){
                    _local_4 = 0;
                    for each (_local_5 in _local_3) {
                        if (_local_5.callback == _arg_2){
                            _local_3.splice(_local_4, 1);
                            _local_5.callback = null;
                            if (_local_3.length == 0){
                                delete this._eventListenerTable[_arg_1];
                            };
                            return;
                        };
                        _local_4++;
                    };
                };
            };
        }
        public function dispatchEvent(_arg_1:WindowEvent):Boolean
        {
            var _local_2:Array;
            var _local_3:Array;
            var _local_4:Function;
            var _local_5:EventListenerStruct;
            if (!this._disposed){
                this._result = EVENT_RESULT_TRUE;
                _local_2 = this._eventListenerTable[_arg_1.type];
                if (_local_2){
                    _local_3 = [];
                    for each (_local_5 in _local_2) {
                        _local_3.push(_local_5.callback);
                    };
                    while (_local_3.length > 0) {
                        _local_4 = _local_3.shift();
                        (_local_4(_arg_1));
                    };
                };
                this._result = ((_arg_1.isDefaultPrevented()) ? EVENT_RESULT_FALSE : EVENT_RESULT_TRUE);
                return ((this._result == EVENT_RESULT_TRUE));
            };
            return (false);
        }
        public function hasEventListener(_arg_1:String):Boolean
        {
            return (((this._disposed) ? false : !((this._eventListenerTable[_arg_1] == null))));
        }
        public function dispose():void
        {
            var _local_1:Object;
            var _local_2:Array;
            var _local_3:EventListenerStruct;
            if (!this._disposed){
                for (_local_1 in this._eventListenerTable) {
                    _local_2 = (this._eventListenerTable[_local_1] as Array);
                    for each (_local_3 in _local_2) {
                        _local_3.callback = null;
                    };
                    delete this._eventListenerTable[_local_1];
                };
                this._eventListenerTable = null;
                this._disposed = true;
            };
        }

    }
}//package com.sulake.core.window.events

// EventListenerStruct = "_-Pi" (String#8197, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// WindowEventDispatcher = "_-2VY" (String#6674, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)


