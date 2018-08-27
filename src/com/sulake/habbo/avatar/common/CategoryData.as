
package com.sulake.habbo.avatar.common
{
    import com.sulake.habbo.avatar.structure.figure.IPartColor;
    import com.sulake.habbo.avatar.structure.figure.IFigurePartSet;

    public class CategoryData 
    {

        private const _SafeStr_9939:int = 2;

        private var _parts:Array;
        private var _SafeStr_6867:Array;
        private var _SafeStr_9940:int = -1;
        private var _SafeStr_9941:Array;

        public function CategoryData(_arg_1:Array, _arg_2:Array)
        {
            this._parts = _arg_1;
            this._SafeStr_6867 = _arg_2;
        }
        public function dispose():void
        {
            var _local_1:AvatarEditorGridPartItem;
            var _local_2:Array;
            var _local_3:AvatarEditorGridColorItem;
            if (this._parts){
                for each (_local_1 in this._parts) {
                    _local_1.dispose();
                };
                this._parts = null;
            };
            if (this._SafeStr_6867){
                for each (_local_2 in (this._SafeStr_6867 as Array)) {
                    if (_local_2){
                        for each (_local_3 in _local_2) {
                            _local_3.dispose();
                        };
                    };
                };
                this._SafeStr_6867 = null;
            };
            this._SafeStr_9940 = -1;
            this._SafeStr_9941 = null;
        }
        public function selectPartId(_arg_1:int):void
        {
            var _local_3:AvatarEditorGridPartItem;
            if (!this._parts){
                return;
            };
            var _local_2:int;
            while (_local_2 < this._parts.length) {
                _local_3 = this._parts[_local_2];
                if (_local_3.id == _arg_1){
                    this.selectPartIndex(_local_2);
                    return;
                };
                _local_2++;
            };
        }
        public function selectColorIds(_arg_1:Array):void
        {
            var _local_2:AvatarEditorGridColorItem;
            var _local_4:Array;
            var _local_5:int;
            var _local_6:int;
            var _local_7:AvatarEditorGridColorItem;
            if (!this._SafeStr_6867){
                return;
            };
            if (!_arg_1){
                return;
            };
            this._SafeStr_9941 = new Array(_arg_1.length);
            var _local_3:int;
            while (_local_3 < this._SafeStr_6867.length) {
                _local_4 = this.getPalette(_local_3);
                if (_local_4){
                    if (_arg_1.length > _local_3){
                        _local_5 = _arg_1[_local_3];
                    }
                    else {
                        _local_7 = (_local_4[0] as AvatarEditorGridColorItem);
                        if (((_local_7) && (_local_7.partColor))){
                            _local_5 = _local_7.partColor.id;
                        };
                    };
                    _local_6 = 0;
                    while (_local_6 < _local_4.length) {
                        _local_2 = (_local_4[_local_6] as AvatarEditorGridColorItem);
                        if (_local_2.partColor.id == _local_5){
                            this._SafeStr_9941[_local_3] = _local_6;
                            _local_2.isSelected = true;
                        }
                        else {
                            _local_2.isSelected = false;
                        };
                        _local_6++;
                    };
                };
                _local_3++;
            };
            this.updatePartColors();
        }
        public function selectPartIndex(_arg_1:int):AvatarEditorGridPartItem
        {
            var _local_2:AvatarEditorGridPartItem;
            var _local_3:AvatarEditorGridPartItem;
            if (!this._parts){
                return (null);
            };
            if ((((this._SafeStr_9940 >= 0)) && ((this._parts.length > this._SafeStr_9940)))){
                _local_2 = this._parts[this._SafeStr_9940];
                if (_local_2){
                    _local_2.isSelected = false;
                };
            };
            if (this._parts.length > _arg_1){
                _local_3 = (this._parts[_arg_1] as AvatarEditorGridPartItem);
                if (_local_3){
                    _local_3.isSelected = true;
                    this._SafeStr_9940 = _arg_1;
                    return (_local_3);
                };
            };
            return (null);
        }
        public function selectColorIndex(_arg_1:int, _arg_2:int):AvatarEditorGridColorItem
        {
            var _local_3:Array = this.getPalette(_arg_2);
            if (!_local_3){
                return (null);
            };
            if (_local_3.length <= _arg_1){
                return (null);
            };
            this.deselectColorIndex(this._SafeStr_9941[_arg_2], _arg_2);
            this._SafeStr_9941[_arg_2] = _arg_1;
            var _local_4:AvatarEditorGridColorItem = (_local_3[_arg_1] as AvatarEditorGridColorItem);
            if (!_local_4){
                return (null);
            };
            _local_4.isSelected = true;
            this.updatePartColors();
            return (_local_4);
        }
        private function deselectColorIndex(_arg_1:int, _arg_2:int):void
        {
            var _local_3:Array = this.getPalette(_arg_2);
            if (!_local_3){
                return;
            };
            if (_local_3.length <= _arg_1){
                return;
            };
            var _local_4:AvatarEditorGridColorItem = (_local_3[_arg_1] as AvatarEditorGridColorItem);
            if (!_local_4){
                return;
            };
            _local_4.isSelected = false;
        }
        public function getSelectedColorIds():Array
        {
            var _local_7:Array;
            var _local_8:AvatarEditorGridColorItem;
            if (((!(this._SafeStr_9941)) || ((this._SafeStr_9941.length == 0)))){
                return (null);
            };
            if (((!(this._SafeStr_6867)) || ((this._SafeStr_6867.length == 0)))){
                return (null);
            };
            var _local_1:Array = (this._SafeStr_6867[0] as Array);
            if (((!(_local_1)) || ((_local_1.length == 0)))){
                return (null);
            };
            var _local_2:AvatarEditorGridColorItem = (_local_1[0] as AvatarEditorGridColorItem);
            if (((!(_local_2)) || (!(_local_2.partColor)))){
                return (null);
            };
            var _local_3:int = _local_2.partColor.id;
            var _local_4:Array = new Array();
            var _local_5:int;
            while (_local_5 < this._SafeStr_9941.length) {
                _local_7 = this._SafeStr_6867[_local_5];
                if (!((!(_local_7)) || ((_local_7.length <= _local_5)))){
                    if (_local_7.length > this._SafeStr_9941[_local_5]){
                        _local_8 = (_local_7[this._SafeStr_9941[_local_5]] as AvatarEditorGridColorItem);
                        if (((_local_8) && (_local_8.partColor))){
                            _local_4.push(_local_8.partColor.id);
                        }
                        else {
                            _local_4.push(_local_3);
                        };
                    }
                    else {
                        _local_4.push(_local_3);
                    };
                };
                _local_5++;
            };
            var _local_6:AvatarEditorGridPartItem = this.getCurrentPart();
            if (!_local_6){
                return (null);
            };
            return (_local_4.slice(0, Math.max(_local_6.colorLayerCount, 1)));
        }
        private function getSelectedColors():Array
        {
            var _local_2:AvatarEditorGridColorItem;
            var _local_1:Array = new Array();
            var _local_3:int;
            while (_local_3 < this._SafeStr_9941.length) {
                _local_2 = this.getSelectedColor(_local_3);
                if (_local_2){
                    _local_1.push(_local_2.partColor);
                }
                else {
                    _local_1.push(null);
                };
                _local_3++;
            };
            return (_local_1);
        }
        public function getSelectedColor(_arg_1:int):AvatarEditorGridColorItem
        {
            var _local_2:Array = this.getPalette(_arg_1);
            if (((!(_local_2)) || ((_local_2.length <= this._SafeStr_9941[_arg_1])))){
                return (null);
            };
            return ((_local_2[this._SafeStr_9941[_arg_1]] as AvatarEditorGridColorItem));
        }
        public function getCurrentColorId(_arg_1:int):int
        {
            var _local_2:AvatarEditorGridColorItem = this.getSelectedColor(_arg_1);
            if (((_local_2) && (_local_2.partColor))){
                return (_local_2.partColor.id);
            };
            return (0);
        }
        public function get parts():Array
        {
            return (this._parts);
        }
        public function getPalette(_arg_1:int):Array
        {
            if (!this._SafeStr_9941){
                return (null);
            };
            if (!this._SafeStr_6867){
                return (null);
            };
            if (this._SafeStr_6867.length <= _arg_1){
                return (null);
            };
            return ((this._SafeStr_6867[_arg_1] as Array));
        }
        public function getCurrentPart():AvatarEditorGridPartItem
        {
            return ((this._parts[this._SafeStr_9940] as AvatarEditorGridPartItem));
        }
        private function updatePartColors():void
        {
            var _local_2:AvatarEditorGridPartItem;
            var _local_1:Array = this.getSelectedColors();
            for each (_local_2 in this._parts) {
                if (_local_2){
                    _local_2.colors = _local_1;
                };
            };
        }
        public function hasClubSelectionsOverLevel(_arg_1:int):Boolean
        {
            var _local_6:int;
            var _local_7:IPartColor;
            var _local_8:IFigurePartSet;
            var _local_2:Boolean;
            var _local_3:Array = this.getSelectedColors();
            if (_local_3){
                _local_6 = 0;
                while (_local_6 < _local_3.length) {
                    _local_7 = _local_3[_local_6];
                    if (((_local_7) && ((_local_7.clubLevel > _arg_1)))){
                        _local_2 = true;
                    };
                    _local_6++;
                };
            };
            var _local_4:Boolean;
            var _local_5:AvatarEditorGridPartItem = this.getCurrentPart();
            if (((_local_5) && (_local_5.partSet))){
                _local_8 = _local_5.partSet;
                if (((_local_8) && ((_local_8.clubLevel > _arg_1)))){
                    _local_4 = true;
                };
            };
            return (((_local_2) || (_local_4)));
        }
        public function stripClubItemsOverLevel(_arg_1:int):Boolean
        {
            var _local_3:IFigurePartSet;
            var _local_4:AvatarEditorGridPartItem;
            var _local_2:AvatarEditorGridPartItem = this.getCurrentPart();
            if (((_local_2) && (_local_2.partSet))){
                _local_3 = _local_2.partSet;
                if (_local_3.clubLevel > _arg_1){
                    _local_4 = this.selectPartIndex(0);
                    if (((_local_4) && ((_local_4.partSet == null)))){
                        this.selectPartIndex(1);
                    };
                    return (true);
                };
            };
            return (false);
        }
        public function stripClubColorsOverLevel(_arg_1:int):Boolean
        {
            var _local_9:IPartColor;
            var _local_2:Array = new Array();
            var _local_3:Array = this.getSelectedColors();
            var _local_4:Boolean;
            var _local_5:Array = this.getPalette(0);
            if (((!(_local_5)) || ((_local_5.length == 0)))){
                return (false);
            };
            var _local_6:AvatarEditorGridColorItem = (_local_5[0] as AvatarEditorGridColorItem);
            if (((!(_local_6)) || (_local_6.partColor))){
                return (false);
            };
            var _local_7:int = _local_6.partColor.id;
            var _local_8:int;
            while (_local_8 < _local_3.length) {
                _local_9 = _local_3[_local_8];
                if (!_local_9){
                    _local_2.push(_local_7);
                    _local_4 = true;
                }
                else {
                    if (_local_9.clubLevel > _arg_1){
                        _local_2.push(_local_7);
                        _local_4 = true;
                    }
                    else {
                        _local_2.push(_local_9.id);
                    };
                };
                _local_8++;
            };
            if (_local_4){
                this.selectColorIds(_local_2);
            };
            return (_local_4);
        }

    }
}//package com.sulake.habbo.avatar.common

// IFigurePartSet = "_-5Y" (String#7773, DoABC#2)
// IPartColor = "_-1dO" (String#5620, DoABC#2)
// AvatarEditorGridColorItem = "_-14G" (String#4963, DoABC#2)
// CategoryData = "_-2jI" (String#6943, DoABC#2)
// AvatarEditorGridPartItem = "_-xW" (String#8833, DoABC#2)
// selectColorIndex = "_-1SJ" (String#17594, DoABC#2)
// getSelectedColorIds = "_-3Is" (String#22233, DoABC#2)
// selectPartId = "_-kn" (String#24060, DoABC#2)
// selectColorIds = "_-1YX" (String#17832, DoABC#2)
// _SafeStr_6867 = "_-2YU" (String#893, DoABC#2)
// stripClubItemsOverLevel = "_-0C1" (String#3793, DoABC#2)
// hasClubSelectionsOverLevel = "_-1rX" (String#18609, DoABC#2)
// stripClubColorsOverLevel = "_-0oz" (String#16011, DoABC#2)
// getCurrentPart = "_-aT" (String#23652, DoABC#2)
// selectPartIndex = "_-0ca" (String#15538, DoABC#2)
// colorLayerCount = "_-0xO" (String#16327, DoABC#2)
// partColor = "_-1Sa" (String#17605, DoABC#2)
// _SafeStr_9939 = "_-2H9" (String#19691, DoABC#2)
// _SafeStr_9940 = "_-2SH" (String#20129, DoABC#2)
// _SafeStr_9941 = "_-0Lr" (String#14908, DoABC#2)
// updatePartColors = "_-29i" (String#19392, DoABC#2)
// deselectColorIndex = "_-3CM" (String#21974, DoABC#2)
// getSelectedColors = "_-1ms" (String#18417, DoABC#2)
// getSelectedColor = "_-24y" (String#19220, DoABC#2)
// getCurrentColorId = "_-52" (String#22421, DoABC#2)


