
package com.sulake.habbo.avatar.common
{
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.avatar.structure.figure.IFigurePartSet;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.avatar.structure.figure.IFigurePart;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import com.sulake.core.window.components.IIconWindow;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.habbo.window.enum.HabboIconType;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.avatar.IAvatarFigureContainer;
    import com.sulake.habbo.avatar.figuredata.FigureData;
    import com.sulake.core.assets.IAsset;
    import com.sulake.habbo.avatar.structure.figure.IPartColor;

    public class AvatarEditorGridPartItem implements IAvatarImageListener 
    {

        private static var _SafeStr_9947:Array = [];

        private const _SafeStr_9948:int = 0xCCCCCC;
        private const _SafeStr_9949:int = 0xFFFFFF;
        private const _SafeStr_9950:Array = [2, 6, 0, 4, 3, 1];

        private var _SafeStr_4830:IAvatarEditorCategoryModel;
        private var _window:IWindowContainer;
        private var _SafeStr_8491:IWindow;
        private var _partSet:IFigurePartSet;
        private var _colors:Array;
        private var _SafeStr_9952:Boolean;
        private var _isSelected:Boolean = false;
        private var _iconImage:BitmapData;
        private var _SafeStr_9953:Rectangle;
        private var _colorLayerCount:int = 0;
        private var _renderManager:IAvatarRenderManager;
        private var _disposed:Boolean;
        private var _SafeStr_9956:BitmapData;

        {
            _SafeStr_9947.push("li");
            _SafeStr_9947.push("lh");
            _SafeStr_9947.push("ls");
            _SafeStr_9947.push("lc");
            _SafeStr_9947.push("bd");
            _SafeStr_9947.push("sh");
            _SafeStr_9947.push("lg");
            _SafeStr_9947.push("ch");
            _SafeStr_9947.push("ca");
            _SafeStr_9947.push("cc");
            _SafeStr_9947.push("cp");
            _SafeStr_9947.push("wa");
            _SafeStr_9947.push("rh");
            _SafeStr_9947.push("rs");
            _SafeStr_9947.push("rc");
            _SafeStr_9947.push("hd");
            _SafeStr_9947.push("fc");
            _SafeStr_9947.push("ey");
            _SafeStr_9947.push("hr");
            _SafeStr_9947.push("hrb");
            _SafeStr_9947.push("fa");
            _SafeStr_9947.push("ea");
            _SafeStr_9947.push("ha");
            _SafeStr_9947.push("he");
            _SafeStr_9947.push("ri");
        }
        public function AvatarEditorGridPartItem(_arg_1:IWindowContainer, _arg_2:IAvatarEditorCategoryModel, _arg_3:IFigurePartSet, _arg_4:Array, _arg_5:Boolean=true)
        {
            var _local_6:IFigurePart;
            var _local_7:Array;
            super();
            this._SafeStr_4830 = _arg_2;
            this._partSet = _arg_3;
            this._window = _arg_1;
            this._SafeStr_8491 = this._window.findChildByTag("BG_COLOR");
            this._colors = _arg_4;
            this._SafeStr_9952 = _arg_5;
            if (_arg_3 == null){
                this._iconImage = new BitmapData(1, 1, true, 0xFFFFFF);
            };
            if (_arg_3 != null){
                _local_7 = _arg_3.parts;
                for each (_local_6 in _local_7) {
                    this._colorLayerCount = Math.max(this._colorLayerCount, _local_6.colorLayerIndex);
                };
            };
            this._renderManager = this._SafeStr_4830.controller.manager.avatarRenderManager;
            this.AvatarEditorGridPartItem();
        }
        public function dispose():void
        {
            this._SafeStr_4830 = null;
            this._partSet = null;
            if (this._window != null){
                if (!this._window.disposed){
                    this._window.dispose();
                };
            };
            this._window = null;
            if (this._iconImage){
                this._iconImage.dispose();
            };
            this._iconImage = null;
            this._disposed = true;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get view():IWindowContainer
        {
            return (this._window);
        }
        public function get isSelected():Boolean
        {
            return (this._isSelected);
        }
        public function set isSelected(_arg_1:Boolean):void
        {
            this._isSelected = _arg_1;
            this.AvatarEditorGridPartItem();
        }
        public function get id():int
        {
            if (this._partSet == null){
                return (-1);
            };
            return (this._partSet.id);
        }
        public function get colorLayerCount():int
        {
            return (this._colorLayerCount);
        }
        public function update():void
        {
            this.AvatarEditorGridPartItem();
        }
        public function set iconImage(_arg_1:BitmapData):void
        {
            this._iconImage = _arg_1;
            this.AvatarEditorGridPartItem();
        }
        public function get partSet():IFigurePartSet
        {
            return (this._partSet);
        }
        public function set colors(_arg_1:Array):void
        {
            this._colors = _arg_1;
            this.AvatarEditorGridPartItem();
        }
        private function AvatarEditorGridPartItem():void
        {
            var _local_3:BitmapData;
            var _local_4:BitmapData;
            var _local_5:int;
            var _local_6:int;
            if (((!(this._window)) || (this._window.disposed))){
                return;
            };
            var _local_1:IBitmapWrapperWindow = (this._window.findChildByName("bitmap") as IBitmapWrapperWindow);
            if (_local_1){
                if (((!((this._iconImage == null))) && (!(this._SafeStr_9952)))){
                    _local_3 = this._iconImage;
                }
                else {
                    _local_3 = this.AvatarEditorGridPartItem();
                    if (!_local_3){
                        return;
                    };
                };
                _local_4 = ((_local_1.bitmap) ? _local_1.bitmap : new BitmapData(_local_1.width, _local_1.height));
                _local_4.fillRect(_local_4.rect, 0xFFFFFF);
                _local_5 = ((_local_4.width - _local_3.width) / 2);
                _local_6 = ((_local_4.height - _local_3.height) / 2);
                _local_4.copyPixels(_local_3, _local_3.rect, new Point(_local_5, _local_6), null, null, true);
                _local_1.bitmap = _local_4;
            };
            var _local_2:IIconWindow = (this._window.findChildByTag("CLUB_ICON") as IIconWindow);
            if (_local_2){
                if (this._partSet){
                    switch (this._partSet.clubLevel){
                        case HabboClubLevelEnum._SafeStr_3942:
                            _local_2.visible = false;
                            break;
                        case HabboClubLevelEnum._SafeStr_3943:
                            _local_2.style = HabboIconType._SafeStr_7426;
                            break;
                        case HabboClubLevelEnum._SafeStr_3939:
                            _local_2.style = HabboIconType._SafeStr_7427;
                            break;
                    };
                }
                else {
                    _local_2.visible = false;
                };
            };
            if (this._SafeStr_8491 == null){
                return;
            };
            if (this.isSelected){
                this._SafeStr_8491.color = this._SafeStr_9948;
            }
            else {
                this._SafeStr_8491.color = this._SafeStr_9949;
            };
            this._window.invalidate();
        }
        private function AvatarEditorGridPartItem():Boolean
        {
            var _local_2:IFigurePart;
            var _local_3:String;
            var _local_4:BitmapDataAsset;
            var _local_5:BitmapData;
            if (this._SafeStr_4830 == null){
                this._SafeStr_9953 = null;
                return (false);
            };
            if (((((!(this.partSet)) || (!(this.partSet.parts)))) || ((this.partSet.parts.length == 0)))){
                this._SafeStr_9953 = null;
                return (false);
            };
            if (!this._renderManager){
                return (false);
            };
            var _local_1:IAvatarFigureContainer = this._renderManager.createFigureContainer(((this.partSet.type + "-") + this.partSet.id));
            Logger.log(((("QUERYING SET:" + this.partSet.type) + "-") + this.partSet.id));
            if (!this._renderManager.isFigureReady(_local_1)){
                this._renderManager.downloadFigure(_local_1, this);
                return (false);
            };
            var _local_6:int;
            var _local_7:Boolean;
            var _local_8:Rectangle = new Rectangle();
            for each (_local_2 in this.partSet.parts) {
                if (_local_7){
                    _local_3 = ((((((((((FigureData._SafeStr_9963 + "_") + FigureData._SafeStr_9964) + "_") + _local_2.type) + "_") + _local_2.id) + "_") + this._SafeStr_9950[_local_6]) + "_") + FigureData.0);
                    _local_4 = (this._renderManager.getAssetByName(_local_3) as BitmapDataAsset);
                }
                else {
                    _local_6 = 0;
                    while (((!(_local_7)) && ((_local_6 < this._SafeStr_9950.length)))) {
                        _local_3 = ((((((((((FigureData._SafeStr_9963 + "_") + FigureData._SafeStr_9964) + "_") + _local_2.type) + "_") + _local_2.id) + "_") + this._SafeStr_9950[_local_6]) + "_") + FigureData.0);
                        _local_4 = (this._renderManager.getAssetByName(_local_3) as BitmapDataAsset);
                        if (((_local_4) && (_local_4.content))){
                            _local_7 = true;
                        }
                        else {
                            _local_6++;
                        };
                    };
                };
                if (((_local_4) && (_local_4.content))){
                    _local_5 = (_local_4.content as BitmapData);
                    _local_8 = _local_8.union(new Rectangle((-1 * _local_4.offset.x), (-1 * _local_4.offset.y), _local_5.width, _local_5.height));
                };
            };
            if (((_local_8) && ((_local_8.width > 0)))){
                this._SafeStr_9953 = _local_8;
                return (true);
            };
            return (false);
        }
        private function AvatarEditorGridPartItem():BitmapData
        {
            var _local_1:BitmapData;
            var _local_2:IFigurePart;
            var _local_3:String;
            var _local_4:BitmapDataAsset;
            var _local_5:BitmapData;
            var _local_9:IAsset;
            var _local_10:int;
            var _local_11:int;
            var _local_12:IPartColor;
            if (this.partSet == null){
                return (null);
            };
            if (this._SafeStr_4830 == null){
                return (null);
            };
            if (this._SafeStr_9953 == null){
                if (!this.AvatarEditorGridPartItem()){
                    if (!this._SafeStr_9956){
                        _local_9 = this._SafeStr_4830.controller.manager.assets.getAssetByName("avatar_editor_download_icon");
                        this._SafeStr_9956 = (_local_9.content as BitmapData);
                    };
                    return (this._SafeStr_9956);
                };
            };
            if (!this._renderManager){
                return (null);
            };
            _local_1 = new BitmapData(this._SafeStr_9953.width, this._SafeStr_9953.height, true, 0xFFFFFF);
            var _local_6:int;
            var _local_7:Boolean;
            var _local_8:Array = this.partSet.parts.concat().sort(this.AvatarEditorGridPartItem);
            for each (_local_2 in _local_8) {
                if (_local_7){
                    _local_3 = ((((((((((FigureData._SafeStr_9963 + "_") + FigureData._SafeStr_9964) + "_") + _local_2.type) + "_") + _local_2.id) + "_") + this._SafeStr_9950[_local_6]) + "_") + FigureData.0);
                    _local_4 = (this._renderManager.getAssetByName(_local_3) as BitmapDataAsset);
                }
                else {
                    _local_6 = 0;
                    while (((!(_local_7)) && ((_local_6 < this._SafeStr_9950.length)))) {
                        _local_3 = ((((((((((FigureData._SafeStr_9963 + "_") + FigureData._SafeStr_9964) + "_") + _local_2.type) + "_") + _local_2.id) + "_") + this._SafeStr_9950[_local_6]) + "_") + FigureData.0);
                        _local_4 = (this._renderManager.getAssetByName(_local_3) as BitmapDataAsset);
                        if (((_local_4) && (_local_4.content))){
                            _local_7 = true;
                        }
                        else {
                            _local_6++;
                        };
                    };
                };
                if (_local_4){
                    _local_5 = (_local_4.content as BitmapData).clone();
                    _local_10 = ((-1 * _local_4.offset.x) - this._SafeStr_9953.x);
                    _local_11 = ((-1 * _local_4.offset.y) - this._SafeStr_9953.y);
                    if (((this._SafeStr_9952) && ((_local_2.colorLayerIndex > 0)))){
                        _local_12 = this._colors[(_local_2.colorLayerIndex - 1)];
                        if (_local_12 != null){
                            _local_5.colorTransform(_local_5.rect, _local_12.colorTransform);
                        };
                    };
                    _local_1.copyPixels(_local_5, _local_5.rect, new Point(_local_10, _local_11), null, null, true);
                }
                else {
                    Logger.log(("Could not find asset: " + _local_3));
                };
            };
            return (_local_1);
        }
        private function AvatarEditorGridPartItem(_arg_1:IFigurePart, _arg_2:IFigurePart):Number
        {
            var _local_3:Number = _SafeStr_9947.indexOf(_arg_1.type);
            var _local_4:Number = _SafeStr_9947.indexOf(_arg_2.type);
            if (_local_3 < _local_4){
                return (-1);
            };
            if (_local_3 > _local_4){
                return (1);
            };
            if (_arg_1.index < _arg_2.index){
                return (-1);
            };
            if (_arg_1.index > _arg_2.index){
                return (1);
            };
            return (0);
        }
        public function avatarImageReady(_arg_1:String):void
        {
            if (!this.AvatarEditorGridPartItem()){
                return;
            };
            this.AvatarEditorGridPartItem();
        }

    }
}//package com.sulake.habbo.avatar.common

// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// HabboIconType = "_-23Y" (String#6115, DoABC#2)
// IIconWindow = "_-1ph" (String#1764, DoABC#2)
// IAvatarFigureContainer = "_-2-D" (String#6034, DoABC#2)
// IFigurePartSet = "_-5Y" (String#7773, DoABC#2)
// HabboClubLevelEnum = "_-1ZP" (String#17867, DoABC#2)
// IPartColor = "_-1dO" (String#5620, DoABC#2)
// FigureData = "_-1BT" (String#836, DoABC#2)
// IAvatarEditorCategoryModel = "_-1mx" (String#5798, DoABC#2)
// AvatarEditorGridPartItem = "_-xW" (String#8833, DoABC#2)
// _SafeStr_3939 = "_-2gR" (String#20706, DoABC#2)
// _SafeStr_3942 = "_-0G0" (String#14684, DoABC#2)
// _SafeStr_3943 = "_-xn" (String#24604, DoABC#2)
// IAvatarRenderManager = "_-C9" (String#7915, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// _SafeStr_4830 = "_-0XB" (String#112, DoABC#2)
// iconImage = "_-0Pn" (String#4088, DoABC#2)
// avatarImageReady = "_-i" (String#8553, DoABC#2)
// colorLayerIndex = "_-05t" (String#3683, DoABC#2)
// IAvatarImageListener = "_-06N" (String#3688, DoABC#2)
// _SafeStr_7426 = "_-3Ki" (String#22312, DoABC#2)
// _SafeStr_7427 = "_-4r" (String#22412, DoABC#2)
// 0 = "_-2pg" (String#21067, DoABC#2)
// _iconImage = "_-bc" (String#2138, DoABC#2)
// _SafeStr_8491 = "_-2y0" (String#903, DoABC#2)
// colorLayerCount = "_-0xO" (String#16327, DoABC#2)
// _SafeStr_9947 = "_-0Cj" (String#14558, DoABC#2)
// _SafeStr_9948 = "_-08T" (String#14384, DoABC#2)
// _SafeStr_9949 = "_-1gP" (String#18154, DoABC#2)
// _SafeStr_9950 = "_-0LO" (String#14891, DoABC#2)
// _partSet = "_-25x" (String#19256, DoABC#2)
// _SafeStr_9952 = "_-0y3" (String#16355, DoABC#2)
// _SafeStr_9953 = "_-1J6" (String#17240, DoABC#2)
// _colorLayerCount = "_-1DV" (String#17002, DoABC#2)
// _renderManager = "_-yU" (String#8845, DoABC#2)
// _SafeStr_9956 = "_-1E5" (String#17031, DoABC#2)
// AvatarEditorGridPartItem = "_-2bh" (String#20511, DoABC#2)
// AvatarEditorGridPartItem = "_-0Il" (String#14790, DoABC#2)
// AvatarEditorGridPartItem = "_-Aq" (String#22649, DoABC#2)
// createFigureContainer = "_-vG" (String#8789, DoABC#2)
// isFigureReady = "_-1Ey" (String#5157, DoABC#2)
// downloadFigure = "_-20I" (String#6051, DoABC#2)
// _SafeStr_9963 = "_-u2" (String#24451, DoABC#2)
// _SafeStr_9964 = "_-1Rs" (String#17577, DoABC#2)
// AvatarEditorGridPartItem = "_-R8" (String#23289, DoABC#2)


