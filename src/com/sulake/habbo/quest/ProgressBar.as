
package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import flash.display.BitmapData;
    import flash.filters.ColorMatrixFilter;
    import flash.geom.Point;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.ITextWindow;

    public class ProgressBar implements IDisposable 
    {

        private static const _SafeStr_12353:int = 3;
        private static const _SafeStr_12354:int = 10;

        private var _SafeStr_8017:HabboQuestEngine;
        private var _window:IWindowContainer;
        private var _SafeStr_12355:int;
        private var _SafeStr_12356:String;
        private var _SafeStr_12357:Boolean;
        private var _SafeStr_12358:int;
        private var _SafeStr_12359:int;
        private var _SafeStr_12360:int;
        private var _SafeStr_12361:int;
        private var _SafeStr_12362:int;
        private var _SafeStr_12363:Boolean;
        private var _SafeStr_12364:BitmapData;
        private var _SafeStr_12365:Array;
        private var _SafeStr_12366:ColorMatrixFilter;

        public function ProgressBar(_arg_1:HabboQuestEngine, _arg_2:IWindowContainer, _arg_3:int, _arg_4:String, _arg_5:Boolean, _arg_6:Point)
        {
            this._SafeStr_12365 = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
            this._SafeStr_12366 = new ColorMatrixFilter(this._SafeStr_12365);
            super();
            this._SafeStr_8017 = _arg_1;
            this._window = _arg_2;
            this._SafeStr_12355 = _arg_3;
            this._SafeStr_12356 = _arg_4;
            this._SafeStr_12357 = _arg_5;
            var _local_7:IWindowContainer = IWindowContainer(this._window.findChildByName("progress_bar_cont"));
            if (_local_7 == null){
                _local_7 = IWindowContainer(this._SafeStr_8017.getXmlWindow("ProgressBar"));
                this._window.addChild(_local_7);
                _local_7.x = _arg_6.x;
                _local_7.y = _arg_6.y;
                _local_7.width = (this._SafeStr_12355 + _SafeStr_12354);
            };
            if (_arg_5){
                new PendingImage(this._SafeStr_8017, this._window.findChildByName("bar_l"), "ach_progressbar1");
                new PendingImage(this._SafeStr_8017, this._window.findChildByName("bar_c"), "ach_progressbar2");
                new PendingImage(this._SafeStr_8017, this._window.findChildByName("bar_r"), "ach_progressbar3");
            };
            new PendingImage(this._SafeStr_8017, this._window.findChildByName("bar_a_c"), "ach_progressbar4");
            new PendingImage(this._SafeStr_8017, this._window.findChildByName("bar_a_r"), "ach_progressbar5");
        }
        public function refresh(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            var _local_4:Boolean = ((!((_arg_3 == this._SafeStr_12360))) || (!((_arg_2 == this._SafeStr_12359))));
            this._SafeStr_12359 = _arg_2;
            this._SafeStr_12358 = _arg_1;
            this._SafeStr_12361 = this._SafeStr_12362;
            this._SafeStr_12360 = _arg_3;
            if (_local_4){
                this._SafeStr_12362 = this.getProgressWidth(this._SafeStr_12358);
            };
            this._SafeStr_12363 = true;
            this.updateView();
        }
        public function set visible(_arg_1:Boolean):void
        {
            var _local_2:IWindowContainer = IWindowContainer(this._window.findChildByName("progress_bar_cont"));
            if (_local_2 != null){
                _local_2.visible = _arg_1;
            };
        }
        public function updateView():void
        {
            var _local_7:IBitmapWrapperWindow;
            var _local_8:IBitmapWrapperWindow;
            var _local_9:int;
            if (!this._SafeStr_12363){
                return;
            };
            var _local_1:IBitmapWrapperWindow = IBitmapWrapperWindow(this._window.findChildByName("bar_a_c"));
            var _local_2:IBitmapWrapperWindow = IBitmapWrapperWindow(this._window.findChildByName("bar_a_r"));
            if ((((_local_1.bitmap == null)) || ((_local_2.bitmap == null)))){
                return;
            };
            if (this._SafeStr_12357){
                _local_7 = IBitmapWrapperWindow(this._window.findChildByName("bar_c"));
                _local_8 = IBitmapWrapperWindow(this._window.findChildByName("bar_r"));
                if ((((_local_7.bitmap == null)) || ((_local_8.bitmap == null)))){
                    return;
                };
                _local_7.width = this._SafeStr_12355;
                _local_8.x = (this._SafeStr_12355 + _local_1.x);
            };
            if (this._SafeStr_12364 == null){
                this._SafeStr_12364 = _local_1.bitmap.clone();
            };
            var _local_3:int = this.getProgressWidth(this._SafeStr_12358);
            if (this._SafeStr_12362 < _local_3){
                _local_9 = Math.min(Math.abs((this._SafeStr_12362 - _local_3)), Math.abs((this._SafeStr_12361 - _local_3)));
                this._SafeStr_12362 = Math.min(_local_3, (this._SafeStr_12362 + Math.max(1, Math.round(Math.sqrt(_local_9)))));
            };
            var _local_4 = (this._SafeStr_12362 > 0);
            _local_1.visible = _local_4;
            _local_2.visible = _local_4;
            if (_local_4){
                _local_1.width = this._SafeStr_12364.width;
                if (this._SafeStr_12362 < _local_3){
                    this.changeProgressColorFilter();
                    _local_1.bitmap.applyFilter(this._SafeStr_12364, this._SafeStr_12364.rect, new Point(0, 0), this._SafeStr_12366);
                }
                else {
                    _local_1.bitmap.copyPixels(this._SafeStr_12364, this._SafeStr_12364.rect, new Point(0, 0), null, null, true);
                };
                _local_1.width = this._SafeStr_12362;
                _local_2.x = (this._SafeStr_12362 + _local_1.x);
            };
            this._SafeStr_12363 = (this._SafeStr_12362 < _local_3);
            var _local_5:ITextWindow = ITextWindow(this._window.findChildByName("progress_txt"));
            var _local_6:int = ((this._SafeStr_12363) ? Math.round(((this._SafeStr_12362 / this._SafeStr_12355) * this._SafeStr_12359)) : this._SafeStr_12358);
            this._SafeStr_8017.localization.registerParameter(this._SafeStr_12356, "progress", ("" + _local_6));
            this._SafeStr_8017.localization.registerParameter(this._SafeStr_12356, "limit", ("" + this._SafeStr_12359));
            _local_5.caption = this._SafeStr_8017.localization.getKey(this._SafeStr_12356, this._SafeStr_12356);
            _local_5.x = ((_SafeStr_12353 + _local_1.x) + ((this._SafeStr_12355 - _local_5.width) / 2));
        }
        public function dispose():void
        {
            this._SafeStr_8017 = null;
            this._window = null;
        }
        public function get disposed():Boolean
        {
            return ((this._SafeStr_8017 == null));
        }
        private function getProgressWidth(_arg_1:int):int
        {
            return (Math.max(0, Math.round(((this._SafeStr_12355 * _arg_1) / this._SafeStr_12359))));
        }
        private function changeProgressColorFilter():void
        {
            var _local_1:int = this.getProgressWidth(this._SafeStr_12358);
            var _local_2:int = (_local_1 - this._SafeStr_12361);
            if (_local_2 == 0){
                return;
            };
            var _local_3:Number = ((_local_1 - this._SafeStr_12362) / _local_2);
            this._SafeStr_12365[3] = _local_3;
            this._SafeStr_12365[8] = _local_3;
            this._SafeStr_12365[0] = (1 - _local_3);
            this._SafeStr_12365[6] = (1 - _local_3);
            this._SafeStr_12365[12] = (1 - _local_3);
            this._SafeStr_12366.matrix = this._SafeStr_12365;
        }

    }
}//package com.sulake.habbo.quest

// _SafeStr_12353 = "_-0th" (String#16190, DoABC#2)
// _SafeStr_12354 = "_-0UC" (String#15213, DoABC#2)
// _SafeStr_12355 = "_-0Eo" (String#14635, DoABC#2)
// _SafeStr_12356 = "_-2gq" (String#20723, DoABC#2)
// _SafeStr_12357 = "_-1H6" (String#17157, DoABC#2)
// _SafeStr_12358 = "_-Op" (String#23197, DoABC#2)
// _SafeStr_12359 = "_-2U-" (String#20198, DoABC#2)
// _SafeStr_12360 = "_-05W" (String#14263, DoABC#2)
// _SafeStr_12361 = "_-2z3" (String#21428, DoABC#2)
// _SafeStr_12362 = "_-2" (String#18968, DoABC#2)
// _SafeStr_12363 = "_-3Io" (String#22230, DoABC#2)
// _SafeStr_12364 = "_-0qc" (String#16071, DoABC#2)
// _SafeStr_12365 = "_-2rF" (String#21128, DoABC#2)
// _SafeStr_12366 = "_-09j" (String#14436, DoABC#2)
// getProgressWidth = "_-pK" (String#24246, DoABC#2)
// changeProgressColorFilter = "_-e8" (String#23808, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// updateView = "_-1Js" (String#847, DoABC#2)
// _SafeStr_8017 = "_-1jf" (String#150, DoABC#2)


