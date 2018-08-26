
package com.sulake.core.runtime.events
{
    import flash.events.ProgressEvent;

    public class LibraryProgressEvent extends ProgressEvent 
    {

        private var _elapsedTime:int = 0;
        private var _fileName:String = "";

        public function LibraryProgressEvent(_arg_1:String, _arg_2:uint=0, _arg_3:uint=0, _arg_4:int=0)
        {
            this._fileName = _arg_1;
            this._elapsedTime = _arg_4;
            super(ProgressEvent.PROGRESS, false, false, _arg_2, _arg_3);
        }
        public function get elapsedTime():int
        {
            return (this._elapsedTime);
        }
        public function get fileName():String
        {
            return (this._fileName);
        }

    }
}//package com.sulake.core.runtime.events

// _elapsedTime = "_-00e" (String#1382, DoABC#2)
// LibraryProgressEvent = "_-26o" (String#19282, DoABC#2)
// _fileName = "_-F6" (String#22818, DoABC#2)
// elapsedTime = "_-3Cm" (String#21986, DoABC#2)
// fileName = "_-1MC" (String#17367, DoABC#2)


