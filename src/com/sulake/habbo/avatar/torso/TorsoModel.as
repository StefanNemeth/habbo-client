
package com.sulake.habbo.avatar.torso
{
    import com.sulake.habbo.avatar.common.CategoryBaseModel;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryModel;
    import com.sulake.habbo.avatar.HabboAvatarEditor;
    import com.sulake.habbo.avatar.figuredata.FigureData;

    public class TorsoModel extends CategoryBaseModel implements IAvatarEditorCategoryModel 
    {

        public function TorsoModel(_arg_1:HabboAvatarEditor)
        {
            super(_arg_1);
        }
        override protected function init():void
        {
            super.init();
            initCategory(FigureData._SafeStr_6611);
            initCategory(FigureData._SafeStr_6612);
            initCategory(FigureData._SafeStr_6613);
            initCategory(FigureData.CHEST_PRINTS);
            _isInitialized = true;
            if (!_view){
                _view = new TorsoView(this, controller.manager.windowManager, controller.manager.assets);
                if (_view){
                    _view.init();
                };
            };
        }

    }
}//package com.sulake.habbo.avatar.torso

// FigureData = "_-1BT" (String#836, DoABC#2)
// IAvatarEditorCategoryModel = "_-1mx" (String#5798, DoABC#2)
// CategoryBaseModel = "_-N4" (String#8146, DoABC#2)
// TorsoModel = "_-0cj" (String#4359, DoABC#2)
// TorsoView = "_-0cS" (String#4352, DoABC#2)
// initCategory = "_-j6" (String#24003, DoABC#2)
// _SafeStr_6611 = "_-1bM" (String#17951, DoABC#2)
// _SafeStr_6612 = "_-0AK" (String#14460, DoABC#2)
// _SafeStr_6613 = "_-Os" (String#23200, DoABC#2)


