
package com.sulake.habbo.avatar.head
{
    import com.sulake.habbo.avatar.common.CategoryBaseModel;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryModel;
    import com.sulake.habbo.avatar.HabboAvatarEditor;
    import com.sulake.habbo.avatar.figuredata.FigureData;

    public class HeadModel extends CategoryBaseModel implements IAvatarEditorCategoryModel 
    {

        public function HeadModel(_arg_1:HabboAvatarEditor)
        {
            super(_arg_1);
        }
        override protected function init():void
        {
            super.init();
            initCategory(FigureData._SafeStr_6467);
            initCategory(FigureData._SafeStr_6468);
            initCategory(FigureData._SafeStr_6469);
            initCategory(FigureData._SafeStr_6470);
            initCategory(FigureData._SafeStr_6471);
            _isInitialized = true;
            if (!_view){
                _view = new HeadView(this, controller.manager.windowManager, controller.manager.assets);
                if (_view){
                    _view.init();
                };
            };
        }

    }
}//package com.sulake.habbo.avatar.head

// FigureData = "_-1BT" (String#836, DoABC#2)
// IAvatarEditorCategoryModel = "_-1mx" (String#5798, DoABC#2)
// CategoryBaseModel = "_-N4" (String#8146, DoABC#2)
// HeadView = "_-WZ" (String#8335, DoABC#2)
// initCategory = "_-j6" (String#24003, DoABC#2)
// _SafeStr_6467 = "_-3o" (String#22367, DoABC#2)
// _SafeStr_6468 = "_-1Pm" (String#17499, DoABC#2)
// _SafeStr_6469 = "_-2xX" (String#21374, DoABC#2)
// _SafeStr_6470 = "_-2IJ" (String#19739, DoABC#2)
// _SafeStr_6471 = "_-2o2" (String#21003, DoABC#2)


