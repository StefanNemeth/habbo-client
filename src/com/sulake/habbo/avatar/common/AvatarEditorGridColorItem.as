
package com.sulake.habbo.avatar.common
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.avatar.structure.figure.IPartColor;
    import flash.display.BitmapData;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import com.sulake.core.window.components.IIconWindow;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.habbo.window.enum.HabboIconType;

    public class AvatarEditorGridColorItem 
    {

        private var _SafeStr_4830:IAvatarEditorCategoryModel;
        private var _window:IWindowContainer;
        private var _partColor:IPartColor;
        private var _isSelected:Boolean = false;
        private var _SafeStr_9934:BitmapData;
        private var _SafeStr_9935:BitmapData;
        private var _SafeStr_9936:BitmapData;

        public function AvatarEditorGridColorItem(_arg_1:IWindowContainer, _arg_2:IAvatarEditorCategoryModel, _arg_3:IPartColor)
        {
            this._SafeStr_4830 = _arg_2;
            this._window = _arg_1;
            this._window.background = true;
            this._partColor = _arg_3;
            var _local_4:BitmapDataAsset = (_arg_2.controller.manager.assets.getAssetByName("editor_clr_40x32_1") as BitmapDataAsset);
            this._SafeStr_9934 = (_local_4.content as BitmapData);
            var _local_5:BitmapDataAsset = (_arg_2.controller.manager.assets.getAssetByName("editor_clr_40x32_2") as BitmapDataAsset);
            this._SafeStr_9935 = (_local_5.content as BitmapData);
            var _local_6:BitmapDataAsset = (_arg_2.controller.manager.assets.getAssetByName("editor_clr_40x32_3") as BitmapDataAsset);
            this._SafeStr_9936 = (_local_6.content as BitmapData);
            this.GroupItem();
        }
        public function dispose():void
        {
            this._SafeStr_4830 = null;
            if (this._window != null){
                if (!this._window.disposed){
                    this._window.dispose();
                };
            };
            this._window = null;
            this._partColor = null;
            this._SafeStr_9934 = null;
            this._SafeStr_9935 = null;
            this._SafeStr_9936 = null;
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
            this.GroupItem();
        }
        private function GroupItem():void
        {
            var _local_5:BitmapData;
            if (this._window == null){
                return;
            };
            if (this._window.disposed){
                return;
            };
            var _local_1:IBitmapWrapperWindow = (this._window.findChildByTag("BG_BORDER") as IBitmapWrapperWindow);
            if (_local_1 != null){
                _local_1.bitmap = new BitmapData(this._SafeStr_9934.width, this._SafeStr_9934.height, true, 0);
                _local_1.bitmap.copyPixels(this._SafeStr_9934, this._SafeStr_9934.rect, new Point(0, 0));
            };
            var _local_2:IBitmapWrapperWindow = (this._window.findChildByTag("COLOR_IMAGE") as IBitmapWrapperWindow);
            if (_local_2 != null){
                _local_2.bitmap = new BitmapData(this._SafeStr_9935.width, this._SafeStr_9935.height, true, 0);
                _local_5 = this._SafeStr_9935.clone();
                _local_5.colorTransform(_local_5.rect, this._partColor.colorTransform);
                _local_2.bitmap.copyPixels(_local_5, _local_5.rect, new Point(0, 0));
            };
            var _local_3:IBitmapWrapperWindow = (this._window.findChildByTag("COLOR_CHOSEN") as IBitmapWrapperWindow);
            if (_local_3 != null){
                if (this._isSelected){
                    _local_3.bitmap = new BitmapData(this._SafeStr_9936.width, this._SafeStr_9936.height, true, 0xFFFFFF);
                    _local_3.bitmap.copyPixels(this._SafeStr_9936, this._SafeStr_9936.rect, new Point(0, 0), null, null, true);
                    _local_3.visible = true;
                }
                else {
                    _local_3.visible = false;
                };
            };
            var _local_4:IIconWindow = (this._window.findChildByTag("CLUB_ICON") as IIconWindow);
            if (_local_4){
                if (this._partColor){
                    switch (this._partColor.clubLevel){
                        case HabboClubLevelEnum._SafeStr_3942:
                            _local_4.visible = false;
                            break;
                        case HabboClubLevelEnum._SafeStr_3943:
                            _local_4.style = HabboIconType._SafeStr_7426;
                            _local_4.visible = true;
                            break;
                        case HabboClubLevelEnum._SafeStr_3939:
                            _local_4.style = HabboIconType._SafeStr_7427;
                            _local_4.visible = true;
                            break;
                    };
                }
                else {
                    _local_4.visible = false;
                };
            };
        }
        public function get partColor():IPartColor
        {
            return (this._partColor);
        }

    }
}//package com.sulake.habbo.avatar.common

// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// HabboIconType = "_-23Y" (String#6115, DoABC#2)
// IIconWindow = "_-1ph" (String#1764, DoABC#2)
// HabboClubLevelEnum = "_-1ZP" (String#17867, DoABC#2)
// IPartColor = "_-1dO" (String#5620, DoABC#2)
// IAvatarEditorCategoryModel = "_-1mx" (String#5798, DoABC#2)
// AvatarEditorGridColorItem = "_-14G" (String#4963, DoABC#2)
// _SafeStr_3939 = "_-2gR" (String#20706, DoABC#2)
// _SafeStr_3942 = "_-0G0" (String#14684, DoABC#2)
// _SafeStr_3943 = "_-xn" (String#24604, DoABC#2)
// _SafeStr_4830 = "_-0XB" (String#112, DoABC#2)
// _SafeStr_7426 = "_-3Ki" (String#22312, DoABC#2)
// _SafeStr_7427 = "_-4r" (String#22412, DoABC#2)
// _partColor = "_-0tM" (String#16174, DoABC#2)
// _SafeStr_9934 = "_-1LC" (String#5265, DoABC#2)
// _SafeStr_9935 = "_-0pG" (String#4618, DoABC#2)
// _SafeStr_9936 = "_-0IR" (String#3923, DoABC#2)
// GroupItem = "_-rZ" (String#8730, DoABC#2)
// partColor = "_-1Sa" (String#17605, DoABC#2)


