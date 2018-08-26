
package com.sulake.core.window.utils
{
    import com.sulake.core.runtime.IDisposable;
    import flash.events.IEventDispatcher;
    import flash.events.Event;

    public class GenericEventQueue implements IEventQueue, IDisposable 
    {

        protected var _disposed:Boolean = false;
        protected var _eventDispatcher:IEventDispatcher;
        protected var _SafeStr_9714:Array;
        protected var _index:uint = 0;

        public function GenericEventQueue(_arg_1:IEventDispatcher)
        {
            this._SafeStr_9714 = new Array();
            this._eventDispatcher = _arg_1;
        }
        public function get length():uint
        {
            return (this._SafeStr_9714.length);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            if (!this._disposed){
                this._eventDispatcher = null;
                this._SafeStr_9714 = [];
                this._disposed = true;
            };
        }
        public function begin():void
        {
            this._index = 0;
        }
        public function next():Event
        {
            var _local_1:Event;
            if (this._index < this._SafeStr_9714.length){
                _local_1 = this._SafeStr_9714[this._index];
                this._index++;
            };
            return (_local_1);
        }
        public function remove():void
        {
            this._SafeStr_9714.splice((this._index - 1), 1);
            if (this._index > 0){
                this._index--;
            };
        }
        public function end():void
        {
            this._index = 0;
        }
        public function flush():void
        {
            this._SafeStr_9714.splice(0, this._SafeStr_9714.length);
            this._index = 0;
        }
        protected function GenericEventQueue(_arg_1:Event):void
        {
            this._SafeStr_9714.push(_arg_1);
        }

    }
}//package com.sulake.core.window.utils

// IEventQueue = "_-cw" (String#8470, DoABC#2)
// GenericEventQueue = "_-0Tz" (String#4181, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _SafeStr_9714 = "_-0an" (String#15466, DoABC#2)
// GenericEventQueue = "_-1Qe" (String#17539, DoABC#2)


