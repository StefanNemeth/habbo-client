
package com.sulake.habbo.room.object.visualization.pet
{
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.text.TextFormat;
    import flash.text.TextField;
    import flash.geom.Matrix;

    public class ExperienceData 
    {

        private var _canvas:BitmapData;
        private var _SafeStr_4484:Boolean;
        private var _copy:BitmapData;
        private var _amount:int = -1;
        private var _alpha:int;

        public function ExperienceData(_arg_1:BitmapData, _arg_2:Boolean=true)
        {
            this._canvas = _arg_1;
            this._SafeStr_4484 = _arg_2;
            if (this._canvas != null){
                this._copy = this._canvas.clone();
            };
            this.setExperience(0);
        }
        public function dispose():void
        {
            if (this._copy){
                this._copy.dispose();
                this._copy = null;
            };
            if (this._canvas != null){
                if (this._SafeStr_4484){
                    this._canvas.dispose();
                };
                this._canvas = null;
            };
        }
        public function get alpha():int
        {
            return (this._alpha);
        }
        public function set alpha(_arg_1:int):void
        {
            this._alpha = _arg_1;
        }
        public function get image():BitmapData
        {
            return (this._canvas);
        }
        public function setExperience(_arg_1:int):void
        {
            if ((((this._amount == _arg_1)) || ((this._canvas == null)))){
                return;
            };
            this._canvas.copyPixels(this._copy, this._copy.rect, new Point(0, 0));
            var _local_2:TextFormat = new TextFormat();
            _local_2.font = "Volter";
            _local_2.color = 0xFFFFFF;
            _local_2.size = 9;
            var _local_3:TextField = new TextField();
            _local_3.embedFonts = true;
            _local_3.width = 30;
            _local_3.height = 12;
            _local_3.background = true;
            _local_3.backgroundColor = 0xE6C0B500;
            _local_3.defaultTextFormat = _local_2;
            _local_3.text = ("+" + _arg_1);
            var _local_4:Matrix = new Matrix();
            _local_4.translate(15, 19);
            this._canvas.draw(_local_3, _local_4);
        }

    }
}//package com.sulake.habbo.room.object.visualization.pet

// ExperienceData = "_-2yt" (String#21423, DoABC#2)
// setExperience = "_-lr" (String#24104, DoABC#2)
// _canvas = "_-0Xp" (String#588, DoABC#2)
// _SafeStr_4484 = "_-28P" (String#19347, DoABC#2)
// _amount = "_-LN" (String#8109, DoABC#2)
// _alpha = "_-0SY" (String#1474, DoABC#2)


