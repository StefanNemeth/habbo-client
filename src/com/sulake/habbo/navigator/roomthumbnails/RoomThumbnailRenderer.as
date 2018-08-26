
package com.sulake.habbo.navigator.roomthumbnails
{
    import com.sulake.habbo.navigator.HabboNavigator;
    import flash.utils.Dictionary;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomThumbnailData;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomThumbnailObjectData;
    import com.sulake.habbo.navigator.inroom.*;

    public class RoomThumbnailRenderer 
    {

        public static const _SafeStr_6010:int = 10;
        private static const _SafeStr_6011:int = 32;
        private static const _SafeStr_6012:int = 8;
        private static const _SafeStr_6013:int = -16;
        private static const _SafeStr_6014:int = 40;

        private var _navigator:HabboNavigator;
        private var _SafeStr_6015:Dictionary;
        private var _imageConfigurations:ThumbnailImageConfigurations;
        private var _order:Dictionary;
        private var _SafeStr_6017:BitmapData;

        public function RoomThumbnailRenderer(_arg_1:HabboNavigator)
        {
            this._order = new Dictionary();
            super();
            this._navigator = _arg_1;
            this._imageConfigurations = new ThumbnailImageConfigurations(this._navigator);
            this.initScreenLocsByPositions();
        }
        public function get imageConfigurations():ThumbnailImageConfigurations
        {
            return (this._imageConfigurations);
        }
        private function initScreenLocsByPositions():void
        {
            var _local_1:Dictionary = new Dictionary();
            _local_1[0] = this.getLoc(1, 0);
            _local_1[1] = this.getLoc(0, 1);
            _local_1[2] = this.getLoc(1, 1);
            _local_1[3] = this.getLoc(0, 2);
            _local_1[4] = this.getLoc(1, 2);
            _local_1[5] = this.getLoc(2, 2);
            _local_1[6] = this.getLoc(0, 3);
            _local_1[7] = this.getLoc(1, 3);
            _local_1[8] = this.getLoc(0, 4);
            _local_1[9] = this.getLoc(1, 4);
            _local_1[10] = this.getLoc(2, 4);
            this._SafeStr_6015 = _local_1;
        }
        private function getLoc(_arg_1:int, _arg_2:int):Point
        {
            var _local_3:int = ((((_arg_2 % 2))==0) ? 0 : (_SafeStr_6011 / 2));
            return (new Point(((_arg_1 * _SafeStr_6011) + _local_3), (_arg_2 * _SafeStr_6012)));
        }
        public function refreshThumbnail(_arg_1:IWindowContainer, _arg_2:RoomThumbnailData, _arg_3:Boolean):void
        {
            var _local_7:BitmapData;
            var _local_4:String = "bitmap";
            var _local_5:IBitmapWrapperWindow = IBitmapWrapperWindow(_arg_1.getChildByName(_local_4));
            if (_local_5 == null){
                _local_7 = new BitmapData(64, 64);
                _local_5 = IBitmapWrapperWindow(this._navigator.windowManager.createWindow(_local_4, "", HabboWindowType._SafeStr_6022, HabboWindowStyle._SafeStr_4662, (HabboWindowParam._SafeStr_6023 | ((_arg_3) ? HabboWindowParam._SafeStr_3731 : HabboWindowParam._SafeStr_4662)), new Rectangle(0, 0, _local_7.width, _local_7.height)));
                _local_5.bitmap = _local_7;
                _arg_1.addChild(_local_5);
            };
            var _local_6:String = _arg_2.getAsString();
            if (_local_5.tags[0] != _local_6){
                _local_5.tags.splice(0, _local_5.tags.length);
                _local_5.tags.push(_local_6);
                this.refreshBitmapContent(_local_5.bitmap, _arg_2);
                this.refreshCover(_local_5.bitmap);
                this.roundEdges(_local_5.bitmap);
                _local_5.invalidate();
            };
        }
        public function refreshBitmapContent(_arg_1:BitmapData, _arg_2:RoomThumbnailData):void
        {
            this.refreshBg(_arg_1, _arg_2.bgImgId);
            this.refreshObjects(_arg_1, _arg_2.objects);
            this.refreshFront(_arg_1, _arg_2.frontImgId);
        }
        public function roundEdges(_arg_1:BitmapData):void
        {
            var _local_3:Boolean;
            var _local_4:Boolean;
            var _local_2:int;
            while (_local_2 < 4) {
                _local_3 = (((_local_2 == 0)) || ((_local_2 == 1)));
                _local_4 = (((_local_2 == 1)) || ((_local_2 == 3)));
                this.paintCol(_arg_1, 0, 5, _local_3, _local_4);
                this.paintCol(_arg_1, 1, 3, _local_3, _local_4);
                this.paintCol(_arg_1, 2, 2, _local_3, _local_4);
                this.paintCol(_arg_1, 3, 1, _local_3, _local_4);
                this.paintCol(_arg_1, 4, 1, _local_3, _local_4);
                _local_2++;
            };
        }
        private function paintCol(_arg_1:BitmapData, _arg_2:int, _arg_3:int, _arg_4:Boolean=true, _arg_5:Boolean=true):void
        {
            var _local_7:int;
            var _local_8:int;
            var _local_6:int;
            while (_local_6 < _arg_3) {
                _local_7 = ((_arg_5) ? _arg_2 : ((_arg_1.width - _arg_2) - 1));
                _local_8 = ((_arg_4) ? _local_6 : ((_arg_1.height - _local_6) - 1));
                _arg_1.setPixel32(_local_7, _local_8, 0);
                _local_6++;
            };
        }
        private function refreshObjects(_arg_1:BitmapData, _arg_2:Array):void
        {
            var _local_3:int;
            var _local_4:RoomThumbnailObjectData;
            _local_3 = 0;
            while (_local_3 <= _SafeStr_6010) {
                this._order[_local_3] = null;
                _local_3++;
            };
            for each (_local_4 in _arg_2) {
                this._order[_local_4.pos] = _local_4;
            };
            _local_3 = 0;
            while (_local_3 <= _SafeStr_6010) {
                if (this._order[_local_3] != null){
                    this.refreshObj(_arg_1, this._order[_local_3]);
                };
                _local_3++;
            };
        }
        private function refreshBg(_arg_1:BitmapData, _arg_2:int):void
        {
            if (_arg_2 < 1){
                _arg_2 = 1;
            };
            var _local_3:ThumbnailImageConfiguration = this._imageConfigurations.TwinkleImages(ThumbnailEditorModel._SafeStr_6034, _arg_2);
            if (_local_3 == null){
                Logger.log(("Unknown bg image id: " + _arg_2));
                _local_3 = this._imageConfigurations.TwinkleImages(ThumbnailEditorModel._SafeStr_6034, 1);
            };
            var _local_4:BitmapData = _local_3.getImg();
            _arg_1.copyPixels(_local_4, _local_4.rect, new Point(0, 0), null, null, true);
        }
        private function refreshFront(_arg_1:BitmapData, _arg_2:int):void
        {
            if (_arg_2 < 1){
                return;
            };
            var _local_3:ThumbnailImageConfiguration = this._imageConfigurations.TwinkleImages(ThumbnailEditorModel._SafeStr_6036, _arg_2);
            if (_local_3 == null){
                Logger.log(("Unknown top image id: " + _arg_2));
                return;
            };
            var _local_4:BitmapData = _local_3.getImg();
            _arg_1.copyPixels(_local_4, _local_4.rect, new Point(0, 0), null, null, true);
        }
        private function refreshCover(_arg_1:BitmapData):void
        {
            if (this._SafeStr_6017 == null){
                this._SafeStr_6017 = this._navigator.getButtonImage("rico_rnd");
            };
            _arg_1.copyPixels(this._SafeStr_6017, this._SafeStr_6017.rect, new Point(0, 0), null, null, true);
        }
        private function refreshObj(_arg_1:BitmapData, _arg_2:RoomThumbnailObjectData):void
        {
            var _local_3:ThumbnailImageConfiguration = this._imageConfigurations.TwinkleImages(ThumbnailEditorModel._SafeStr_6037, _arg_2.imgId);
            if (_local_3 == null){
                Logger.log(("Unknown object image id: " + _arg_2.imgId));
                return;
            };
            if (_local_3.id == 0){
                return;
            };
            var _local_4:Point = this.getScreenLocForPos(_arg_2.pos);
            if (_local_4 == null){
                Logger.log(("Unknown object position: " + _arg_2.pos));
                return;
            };
            var _local_5:BitmapData = _local_3.getImg();
            if (_local_5 == null){
                Logger.log(("No image for " + _arg_2.imgId));
                return;
            };
            Logger.log(((("Drawing object: " + _arg_2.pos) + ", ") + _local_4));
            _arg_1.copyPixels(_local_5, _local_5.rect, new Point((_local_4.x + _SafeStr_6013), ((_local_4.y + _SafeStr_6014) - _local_5.height)), null, null, true);
        }
        public function getScreenLocForPos(_arg_1:int):Point
        {
            return (Point(this._SafeStr_6015[_arg_1]));
        }

    }
}//package com.sulake.habbo.navigator.roomthumbnails

// HabboWindowParam = "_-29D" (String#6233, DoABC#2)
// HabboWindowStyle = "_-0E1" (String#14608, DoABC#2)
// HabboWindowType = "_-29U" (String#19384, DoABC#2)
// RoomThumbnailRenderer = "_-3Kq" (String#7719, DoABC#2)
// ThumbnailImageConfigurations = "_-1RB" (String#5378, DoABC#2)
// ThumbnailImageConfiguration = "_-1Ew" (String#5156, DoABC#2)
// RoomThumbnailData = "_-2bQ" (String#6781, DoABC#2)
// RoomThumbnailObjectData = "_-bW" (String#8446, DoABC#2)
// _SafeStr_3731 = "_-B" (String#22654, DoABC#2)
// getAsString = "_-3JH" (String#22254, DoABC#2)
// refreshBitmapContent = "_-3Ky" (String#22320, DoABC#2)
// TwinkleImages = "_-eg" (String#2150, DoABC#2)
// _SafeStr_4662 = "_-0g1" (String#15673, DoABC#2)
// _SafeStr_6010 = "_-1wP" (String#18817, DoABC#2)
// _SafeStr_6011 = "_-2LO" (String#19862, DoABC#2)
// _SafeStr_6012 = "_-0nv" (String#15974, DoABC#2)
// _SafeStr_6013 = "_-30i" (String#21528, DoABC#2)
// _SafeStr_6014 = "_-DJ" (String#22742, DoABC#2)
// _SafeStr_6015 = "_-0oZ" (String#15997, DoABC#2)
// _imageConfigurations = "_-Ff" (String#22837, DoABC#2)
// _SafeStr_6017 = "_-16O" (String#16714, DoABC#2)
// initScreenLocsByPositions = "_-2oy" (String#21038, DoABC#2)
// imageConfigurations = "_-2yE" (String#21403, DoABC#2)
// getLoc = "_-2mw" (String#20958, DoABC#2)
// refreshThumbnail = "_-04K" (String#14216, DoABC#2)
// _SafeStr_6022 = "_-1t4" (String#18679, DoABC#2)
// _SafeStr_6023 = "_-Mr" (String#23121, DoABC#2)
// refreshCover = "_-0if" (String#15778, DoABC#2)
// roundEdges = "_-A9" (String#22624, DoABC#2)
// refreshBg = "_-1PW" (String#5343, DoABC#2)
// refreshObjects = "_-0Go" (String#14711, DoABC#2)
// objects = "_-8h" (String#22568, DoABC#2)
// refreshFront = "_-0jp" (String#15820, DoABC#2)
// frontImgId = "_-2Ep" (String#19597, DoABC#2)
// paintCol = "_-0bG" (String#15487, DoABC#2)
// pos = "_-g8" (String#23898, DoABC#2)
// refreshObj = "_-2W-" (String#20282, DoABC#2)
// _SafeStr_6034 = "_-gy" (String#23927, DoABC#2)
// getImg = "_-sM" (String#24375, DoABC#2)
// _SafeStr_6036 = "_-0-d" (String#14037, DoABC#2)
// _SafeStr_6037 = "_-3FA" (String#22084, DoABC#2)
// imgId = "_-wA" (String#24536, DoABC#2)
// getScreenLocForPos = "_-2jf" (String#20832, DoABC#2)


