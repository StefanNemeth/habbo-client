
package com.sulake.core.runtime.events
{
    import flash.events.IEventDispatcher;
    import com.sulake.core.runtime.IDisposable;
    import flash.events.EventDispatcher;
    import flash.utils.Dictionary;
    import com.sulake.core.Core;
    import flash.utils.getQualifiedClassName;
    import flash.events.Event;

    public class EventDispatcher implements IEventDispatcher, IDisposable 
    {

        private static const EVENT_RESULT_TRUE:uint = 0;
        private static const EVENT_RESULT_FALSE:uint = 1;
        private static const EVENT_RESULT_ERROR:uint = 2;

        protected var _disposed:Boolean = false;
        private var _eventDispatcher:EventDispatcher;
        private var _eventListenerTable:Dictionary;
        private var _result:uint;
        private var _error:Error;

        public function EventDispatcher(_arg_1:IEventDispatcher=null)
        {
            this._eventListenerTable = new Dictionary();
            super();
            this._eventDispatcher = new EventDispatcher(((_arg_1) ? _arg_1 : this));
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get error():Error
        {
            return (this._error);
        }
        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            var _local_8:EventListenerStruct;
            var _local_6:Array = this._eventListenerTable[_arg_1];
            var _local_7:EventListenerStruct = new EventListenerStruct(_arg_2, _arg_3, _arg_4, _arg_5);
            if (!_local_6){
                _local_6 = [_local_7];
                this._eventListenerTable[_arg_1] = _local_6;
                this._eventDispatcher.addEventListener(_arg_1, this.eventProcessor);
            }
            else {
                for each (_local_8 in _local_6) {
                    if ((((_local_8.callback == _arg_2)) && ((_local_8._SafeStr_8891 == _arg_3)))){
                        return;
                    };
                    if (_arg_4 > _local_8.priority){
                        _local_6.splice(_local_6.indexOf(_local_8), 0, _local_7);
                        return;
                    };
                };
                _local_6.push(_local_7);
            };
        }
        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            var _local_4:Array;
            var _local_5:uint;
            var _local_6:EventListenerStruct;
            if (!this._disposed){
                _local_4 = this._eventListenerTable[_arg_1];
                if (_local_4){
                    _local_5 = 0;
                    for each (_local_6 in _local_4) {
                        if ((((_local_6.callback == _arg_2)) && ((_local_6._SafeStr_8891 == _arg_3)))){
                            _local_4.splice(_local_5, 1);
                            _local_6.callback = null;
                            if (_local_4.length == 0){
                                delete this._eventListenerTable[_arg_1];
                            };
                            return;
                        };
                        _local_5++;
                    };
                };
            };
        }
        public function dispatchEvent(_arg_1:Event):Boolean
        {
            if (!this._disposed){
                this._result = EVENT_RESULT_TRUE;
                this._eventDispatcher.dispatchEvent(_arg_1);
                if (this._result == EVENT_RESULT_ERROR){
                    if (this._error != null){
                        Core.Core(((("Error caught when handling " + getQualifiedClassName(_arg_1)) + ": ") + this._error.message), this._error.errorID, this._error);
                    }
                    else {
                        Core.Core((("Error caught when handling " + getQualifiedClassName(_arg_1)) + ". No error data available!"), 0, this._error);
                    };
                };
                return ((this._result == EVENT_RESULT_TRUE));
            };
            return (false);
        }
        public function hasEventListener(_arg_1:String):Boolean
        {
            return (((this._disposed) ? false : !((this._eventListenerTable[_arg_1] == null))));
        }
        public function callEventListeners(_arg_1:String):void
        {
            var _local_3:EventListenerStruct;
            var _local_2:Array = this._eventListenerTable[_arg_1];
            if (_local_2){
                for each (_local_3 in _local_2) {
                    _local_3.callback(null);
                };
            };
        }
        public function willTrigger(_arg_1:String):Boolean
        {
            return (((this._disposed) ? false : !((this._eventListenerTable[_arg_1] == null))));
        }
        private function eventProcessor(event:Event):void
        {
            var callbacks:Array;
            var callback:Function;
            var struct:EventListenerStruct;
            var array:Array = this._eventListenerTable[event.type];
            if (array){
                callbacks = [];
                for each (struct in array) {
                    callbacks.push(struct.callback);
                };
                while (callbacks.length > 0) {
                    try {
                        callback = callbacks.shift();
                        (callback(event));
                    }
                    catch(e:Error) {
                        Logger.log(e.getStackTrace());
                        _result = EVENT_RESULT_ERROR;
                        _error = e;
                        return;
                    };
                };
            };
            this._result = ((event.isDefaultPrevented()) ? EVENT_RESULT_FALSE : EVENT_RESULT_TRUE);
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
                this._eventDispatcher = null;
                this._disposed = true;
            };
        }

    }
}//package com.sulake.core.runtime.events

// EventListenerStruct = "_-Pi" (String#8197, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _SafeStr_8891 = "_-l-" (String#24072, DoABC#2)
// Core = "_-1--" (String#16429, DoABC#2)


