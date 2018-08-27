
package com.sulake.habbo.catalog.marketplace
{
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.display.Shape;
    import flash.display.BitmapData;
    import flash.geom.Matrix;

    public class MarketplaceChart 
    {

        private var _x:Array;
        private var _y:Array;
        private var _SafeStr_10285:int;
        private var _SafeStr_10286:int;
        private var _SafeStr_10287:int = -30;
        private var _SafeStr_10288:int;

        public function MarketplaceChart(_arg_1:Array, _arg_2:Array)
        {
            this._x = _arg_1.slice();
            this._y = _arg_2.slice();
        }
        public function draw(_arg_1:int, _arg_2:int):BitmapData
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:TextField;
            var _local_7:TextFormat;
            var _local_8:int;
            var _local_9:Shape;
            var _local_10:int;
            var _local_3:BitmapData = new BitmapData(_arg_1, _arg_2);
            if (!this.available){
                return (_local_3);
            };
            this._SafeStr_10288 = 0;
            for each (_local_4 in this._y) {
                if (_local_4 > this._SafeStr_10288){
                    this._SafeStr_10288 = _local_4;
                };
            };
            _local_5 = Math.pow(10, (int(this._SafeStr_10288).toString().length - 1));
            this._SafeStr_10288 = (Math.ceil((this._SafeStr_10288 / _local_5)) * _local_5);
            _local_6 = new TextField();
            _local_7 = new TextFormat();
            _local_6.embedFonts = true;
            _local_7.font = "Volter";
            _local_7.size = 9;
            _local_6.defaultTextFormat = _local_7;
            _local_6.text = this._SafeStr_10288.toString();
            _local_3.draw(_local_6);
            this._SafeStr_10285 = ((_arg_1 - _local_6.textWidth) - 2);
            this._SafeStr_10286 = (_arg_2 - _local_6.textHeight);
            _local_8 = _local_6.textWidth;
            _local_6.text = "0";
            _local_3.draw(_local_6, new Matrix(1, 0, 0, 1, ((_local_8 - _local_6.textWidth) + 1), ((_arg_2 - _local_6.textHeight) - 1)));
            _local_9 = new Shape();
            _local_9.graphics.lineStyle(1, 0xCCCCCC);
            _local_9.graphics.moveTo(0, 0);
            _local_9.graphics.lineTo(0, this._SafeStr_10286);
            _local_10 = 0;
            while (_local_10 <= 5) {
                _local_4 = (((this._SafeStr_10286 - 1) / 5) * _local_10);
                _local_9.graphics.moveTo(0, _local_4);
                _local_9.graphics.lineTo((this._SafeStr_10285 - 1), _local_4);
                _local_10++;
            };
            _local_9.graphics.lineStyle(2, 0xFF);
            _local_9.graphics.moveTo(this.getX(0), this.getY(0));
            _local_10 = 1;
            while (_local_10 < this._x.length) {
                _local_9.graphics.lineTo(this.getX(_local_10), this.getY(_local_10));
                _local_10++;
            };
            _local_3.draw(_local_9, new Matrix(1, 0, 0, 1, (_arg_1 - this._SafeStr_10285), ((_arg_2 - this._SafeStr_10286) / 2)));
            return (_local_3);
        }
        private function getX(_arg_1:int):Number
        {
            return ((this._SafeStr_10285 + ((this._SafeStr_10285 / -(this._SafeStr_10287)) * this._x[_arg_1])));
        }
        private function getY(_arg_1:int):Number
        {
            return ((this._SafeStr_10286 - ((this._SafeStr_10286 / this._SafeStr_10288) * this._y[_arg_1])));
        }
        public function get available():Boolean
        {
            return (((((this._x) && (this._y))) && ((this._x.length > 1))));
        }

    }
}//package com.sulake.habbo.catalog.marketplace

// _SafeStr_10285 = "_-0fk" (String#15662, DoABC#2)
// _SafeStr_10286 = "_-0a8" (String#15445, DoABC#2)
// _SafeStr_10287 = "_-1Gs" (String#17146, DoABC#2)
// _SafeStr_10288 = "_-07o" (String#14356, DoABC#2)
// getX = "_-bw" (String#8454, DoABC#2)
// getY = "_-2Wq" (String#6697, DoABC#2)
// MarketplaceChart = "_-34I" (String#21670, DoABC#2)
// _y = "_-02f" (String#64, DoABC#2)


