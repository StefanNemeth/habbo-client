
package com.sulake.habbo.avatar.legs
{
    import com.sulake.habbo.avatar.common.CategoryBaseModel;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryModel;
    import com.sulake.habbo.avatar.HabboAvatarEditor;
    import com.sulake.habbo.avatar.figuredata.FigureData;

    public class LegsModel extends CategoryBaseModel implements IAvatarEditorCategoryModel 
    {

        public function LegsModel(_arg_1:HabboAvatarEditor)
        {
            super(_arg_1);
        }
        override protected function init():void
        {
            super.init();
            initCategory(FigureData._SafeStr_6463);
            initCategory(FigureData._SafeStr_6464);
            initCategory(FigureData._SafeStr_6465);
            _isInitialized = true;
            if (!_view){
                _view = new LegsView(this, controller.manager.windowManager, controller.manager.assets);
                if (_view){
                    _view.init();
                };
            };
        }

    }
}//package com.sulake.habbo.avatar.legs

// FigureData = "_-1BT" (String#836, DoABC#2)
// IAvatarEditorCategoryModel = "_-1mx" (String#5798, DoABC#2)
// CategoryBaseModel = "_-N4" (String#8146, DoABC#2)
// LegsView = "_-0hu" (String#4465, DoABC#2)
// initCategory = "_-j6" (String#24003, DoABC#2)
// _SafeStr_6463 = "_-0JA" (String#14807, DoABC#2)
// _SafeStr_6464 = "_-2cW" (String#20545, DoABC#2)
// _SafeStr_6465 = "_-0Z2" (String#15404, DoABC#2)


