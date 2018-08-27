
package com.sulake.habbo.sound.trax
{
    import __AS3__.vec.Vector;

    public class TraxChannelSample 
    {

        private var _sample:TraxSample = null;
        private var _offset:int = 0;

        public function TraxChannelSample(_arg_1:TraxSample, _arg_2:int)
        {
            this._sample = _arg_1;
            this._offset = _arg_2;
        }
        public function setSample(_arg_1:Vector.<int>, _arg_2:int, _arg_3:int):void
        {
            this._offset = this._sample.setSample(_arg_1, _arg_2, _arg_3, this._offset);
        }
        public function addSample(_arg_1:Vector.<int>, _arg_2:int, _arg_3:int):void
        {
            this._offset = this._sample.addSample(_arg_1, _arg_2, _arg_3, this._offset);
        }

    }
}//package com.sulake.habbo.sound.trax

// TraxSample = "_-285" (String#6206, DoABC#2)
// TraxChannelSample = "_-0JT" (String#3942, DoABC#2)
// setSample = "_-1IC" (String#17201, DoABC#2)
// addSample = "_-tt" (String#24443, DoABC#2)


