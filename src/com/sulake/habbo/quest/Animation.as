
package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;

    public class Animation implements IDisposable 
    {

        private var _canvas:IBitmapWrapperWindow;
        private var _SafeStr_12182:int;
        private var _SafeStr_12183:Boolean;
        private var _sprites:Array;

        public function Animation(_arg_1:IBitmapWrapperWindow)
        {
            this._sprites = new Array();
            super();
            this._canvas = _arg_1;
            this._canvas.visible = false;
            if (_arg_1.bitmap == null){
                _arg_1.bitmap = new BitmapData(_arg_1.width, _arg_1.height, true, 0);
            };
        }
        public function dispose():void
        {
            var _local_1:AnimationObject;
            this._canvas = null;
            if (this._sprites){
                for each (_local_1 in this._sprites) {
                    _local_1.dispose();
                };
                this._sprites = null;
            };
        }
        public function get disposed():Boolean
        {
            return ((this._canvas == null));
        }
        public function addObject(_arg_1:AnimationObject):void
        {
            this._sprites.push(_arg_1);
        }
        public function stop():void
        {
            this._SafeStr_12183 = false;
            this._canvas.visible = false;
        }
        public function Animation():void
        {
            var _local_1:AnimationObject;
            this._SafeStr_12182 = 0;
            this._SafeStr_12183 = true;
            for each (_local_1 in this._sprites) {
                _local_1.Twinkle();
            };
            this.draw();
            this._canvas.visible = true;
        }
        public function update(_arg_1:uint):void
        {
            if (this._SafeStr_12183){
                this._SafeStr_12182 = (this._SafeStr_12182 + _arg_1);
                this.draw();
            };
        }
        private function draw():void
        {
            var _local_1:Boolean;
            var _local_2:AnimationObject;
            var _local_3:BitmapData;
            this._canvas.bitmap.fillRect(this._canvas.bitmap.rect, 0);
            if (this._SafeStr_12183){
                _local_1 = false;
                for each (_local_2 in this._sprites) {
                    if (!_local_2.isFinished(this._SafeStr_12182)){
                        _local_1 = true;
                        _local_3 = _local_2.getBitmap(this._SafeStr_12182);
                        if (_local_3 != null){
                            this._canvas.bitmap.copyPixels(_local_3, _local_3.rect, _local_2.Twinkle(this._SafeStr_12182));
                        };
                    };
                };
            };
            this._canvas.invalidate(this._canvas.rectangle);
            this._SafeStr_12183 = _local_1;
        }

    }
}//package com.sulake.habbo.quest

// _SafeStr_12182 = "_-1X7" (String#17782, DoABC#2)
// _SafeStr_12183 = "_-2GN" (String#19656, DoABC#2)
// Animation = "_-3BQ" (String#21939, DoABC#2)
// Twinkle = "_-3Hw" (String#7665, DoABC#2)
// isFinished = "_-2pC" (String#7064, DoABC#2)
// getBitmap = "_-0zS" (String#4837, DoABC#2)
// Animation = "_-2Eu" (String#1841, DoABC#2)
// AnimationObject = "_-0y7" (String#4813, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _canvas = "_-0Xp" (String#588, DoABC#2)
// Twinkle = "_-GB" (String#7997, DoABC#2)
// _sprites = "_-2vJ" (String#455, DoABC#2)
// addObject = "_-0EW" (String#1435, DoABC#2)


