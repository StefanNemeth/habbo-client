
package com.sulake.habbo.avatar.generic
{
    import com.sulake.habbo.avatar.common.CategoryBaseModel;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryModel;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.avatar.HabboAvatarEditor;
    import com.sulake.habbo.avatar.figuredata.FigureData;
    import com.sulake.habbo.avatar.common.CategoryData;
    import com.sulake.habbo.avatar.common.AvatarEditorGridPartItem;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.enum.AvatarSetType;

    public class BodyModel extends CategoryBaseModel implements IAvatarEditorCategoryModel, IAvatarImageListener 
    {

        private var _SafeStr_5409:Boolean;

        public function BodyModel(_arg_1:HabboAvatarEditor)
        {
            super(_arg_1);
        }
        override protected function init():void
        {
            super.init();
            initCategory(FigureData._SafeStr_5401);
            _isInitialized = true;
            if (!_view){
                _view = new BodyView(this, controller.manager.windowManager, controller.manager.assets);
                if (_view){
                    _view.init();
                };
            };
        }
        override public function switchCategory(_arg_1:String):void
        {
        }
        override public function selectColor(_arg_1:String, _arg_2:int, _arg_3:int):void
        {
            var _local_4:CategoryData = _categories[_arg_1];
            if (_local_4 == null){
                return;
            };
            _local_4.selectColorIndex(_arg_2, _arg_3);
            _controller.figureData.savePartSetColourId(_arg_1, _local_4.getSelectedColorIds(), true);
            this.updateSelectionsFromFigure(FigureData._SafeStr_5401);
        }
        override protected function updateSelectionsFromFigure(_arg_1:String):void
        {
            var _local_5:AvatarEditorGridPartItem;
            var _local_6:String;
            var _local_7:IAvatarImage;
            if (!_categories){
                return;
            };
            var _local_2:int = _controller.figureData.getPartSetId(FigureData._SafeStr_5401);
            var _local_3:Array = _controller.figureData.getColourIds(FigureData._SafeStr_5401);
            var _local_4:CategoryData = _categories[_arg_1];
            if (_local_4 == null){
                return;
            };
            _local_4.selectPartId(_local_2);
            _local_4.selectColorIds(_local_3);
            for each (_local_5 in _local_4.parts) {
                _local_6 = _controller.figureData.getFigureStringWithFace(_local_5.id);
                _local_7 = _controller.manager.avatarRenderManager.createAvatarImage(_local_6, AvatarScaleType._SafeStr_4336, null, this);
                _local_5.iconImage = _local_7.getCroppedImage(AvatarSetType._SafeStr_4458);
                _local_7.dispose();
            };
        }
        public function avatarImageReady(_arg_1:String):void
        {
            if (!this._SafeStr_5409){
                this._SafeStr_5409 = true;
                this.updateSelectionsFromFigure(FigureData._SafeStr_5401);
            };
        }

    }
}//package com.sulake.habbo.avatar.generic

// AvatarScaleType = "_-2lF" (String#20893, DoABC#2)
// FigureData = "_-1BT" (String#836, DoABC#2)
// IAvatarEditorCategoryModel = "_-1mx" (String#5798, DoABC#2)
// CategoryBaseModel = "_-N4" (String#8146, DoABC#2)
// CategoryData = "_-2jI" (String#6943, DoABC#2)
// AvatarEditorGridPartItem = "_-xW" (String#8833, DoABC#2)
// BodyView = "_-FU" (String#7983, DoABC#2)
// _controller = "_-18D" (String#59, DoABC#2)
// _SafeStr_4336 = "_-1wM" (String#18815, DoABC#2)
// _SafeStr_4458 = "_-327" (String#21586, DoABC#2)
// _categories = "_-EJ" (String#373, DoABC#2)
// iconImage = "_-0Pn" (String#4088, DoABC#2)
// _SafeStr_5401 = "_-06A" (String#14290, DoABC#2)
// _SafeStr_5409 = "_-05U" (String#14261, DoABC#2)
// initCategory = "_-j6" (String#24003, DoABC#2)
// selectColor = "_-2lm" (String#6999, DoABC#2)
// selectColorIndex = "_-1SJ" (String#17594, DoABC#2)
// getSelectedColorIds = "_-3Is" (String#22233, DoABC#2)
// updateSelectionsFromFigure = "_-N3" (String#8145, DoABC#2)
// selectPartId = "_-kn" (String#24060, DoABC#2)
// selectColorIds = "_-1YX" (String#17832, DoABC#2)
// getCroppedImage = "_-2Ez" (String#6342, DoABC#2)
// avatarImageReady = "_-i" (String#8553, DoABC#2)
// IAvatarImageListener = "_-06N" (String#3688, DoABC#2)


