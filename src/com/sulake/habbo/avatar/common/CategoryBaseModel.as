
package com.sulake.habbo.avatar.common
{
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.avatar.HabboAvatarEditor;
    import com.sulake.core.window.IWindowContainer;

    public class CategoryBaseModel implements IAvatarEditorCategoryModel 
    {

        protected var _categories:Map;
        protected var _controller:HabboAvatarEditor;
        protected var _isInitialized:Boolean = false;
        protected var _view:IAvatarEditorCategoryView;
        private var _disposed:Boolean;

        public function CategoryBaseModel(_arg_1:HabboAvatarEditor)
        {
            this._controller = _arg_1;
        }
        public function dispose():void
        {
            if (this._view != null){
                this._view.dispose();
            };
            this._view = null;
            this._categories = null;
            this._controller = null;
            this._disposed = true;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        protected function init():void
        {
            if (!this._categories){
                this._categories = new Map();
            };
        }
        public function reset():void
        {
            var _local_1:CategoryData;
            this._isInitialized = false;
            for each (_local_1 in this._categories) {
                if (_local_1){
                    _local_1.dispose();
                };
            };
            this._categories = new Map();
            if (this._view){
                this._view.reset();
            };
        }
        protected function initCategory(_arg_1:String):void
        {
            var _local_3:CategoryData;
            var _local_2:CategoryData = this._categories[_arg_1];
            if (_local_2 == null){
                _local_3 = this._controller.generateDataContent(this, _arg_1);
                if (_local_3){
                    this._categories[_arg_1] = _local_3;
                    this.updateSelectionsFromFigure(_arg_1);
                };
            };
        }
        public function switchCategory(_arg_1:String):void
        {
            if (!this._isInitialized){
                this.init();
            };
            if (this._view){
                this._view.switchCategory(_arg_1);
            };
        }
        protected function updateSelectionsFromFigure(_arg_1:String):void
        {
            if (((((!(this._categories)) || (!(this._controller)))) || (!(this._controller.figureData)))){
                return;
            };
            var _local_2:CategoryData = this._categories[_arg_1];
            if (_local_2 == null){
                return;
            };
            var _local_3:int = this._controller.figureData.getPartSetId(_arg_1);
            var _local_4:Array = this._controller.figureData.getColourIds(_arg_1);
            if (!_local_4){
                _local_4 = new Array();
            };
            _local_2.selectPartId(_local_3);
            _local_2.selectColorIds(_local_4);
            if (this._view){
                this._view.showPalettes(_arg_1, _local_4.length);
            };
        }
        public function hasClubItemsOverLevel(_arg_1:int):Boolean
        {
            var _local_3:CategoryData;
            var _local_4:Boolean;
            if (!this._categories){
                return (false);
            };
            var _local_2:Boolean;
            for each (_local_3 in this._categories) {
                if (_local_3){
                    _local_4 = _local_3.hasClubSelectionsOverLevel(_arg_1);
                    if (_local_4){
                        _local_2 = true;
                    };
                };
            };
            return (_local_2);
        }
        public function stripClubItemsOverLevel(_arg_1:int):Boolean
        {
            var _local_5:String;
            var _local_6:CategoryData;
            var _local_7:Boolean;
            var _local_8:AvatarEditorGridPartItem;
            if (!this._categories){
                return (false);
            };
            var _local_2:Array = this._categories.getKeys();
            var _local_3:Boolean;
            var _local_4:int;
            while (_local_4 < _local_2.length) {
                _local_5 = _local_2[_local_4];
                _local_6 = this._categories[_local_5];
                _local_7 = false;
                if (_local_6.stripClubItemsOverLevel(_arg_1)){
                    _local_7 = true;
                };
                if (_local_6.stripClubColorsOverLevel(_arg_1)){
                    _local_7 = true;
                };
                if (_local_7){
                    _local_8 = _local_6.getCurrentPart();
                    if (((((((_local_8) && (this._controller))) && (this._controller.figureData))) && (_local_6))){
                        this._controller.figureData.savePartData(_local_5, _local_8.id, _local_6.getSelectedColorIds(), true);
                    };
                    _local_3 = true;
                };
                _local_4++;
            };
            return (_local_3);
        }
        public function _SafeStr_4847(_arg_1:String, _arg_2:int):void
        {
            var _local_3:CategoryData = this._categories[_arg_1];
            if (_local_3 == null){
                return;
            };
            _local_3.selectPartIndex(_arg_2);
            var _local_4:AvatarEditorGridPartItem = _local_3.getCurrentPart();
            if (!_local_4){
                return;
            };
            if (this._view){
                this._view.showPalettes(_arg_1, _local_4.colorLayerCount);
            };
            if (((this._controller) && (this._controller.figureData))){
                this._controller.figureData.savePartData(_arg_1, _local_4.id, _local_3.getSelectedColorIds(), true);
            };
        }
        public function selectColor(_arg_1:String, _arg_2:int, _arg_3:int):void
        {
            var _local_4:CategoryData = this._categories[_arg_1];
            if (_local_4 == null){
                return;
            };
            _local_4.selectColorIndex(_arg_2, _arg_3);
            if (((this._controller) && (this._controller.figureData))){
                this._controller.figureData.savePartSetColourId(_arg_1, _local_4.getSelectedColorIds(), true);
            };
        }
        public function get controller():HabboAvatarEditor
        {
            return (this._controller);
        }
        public function getWindowContainer():IWindowContainer
        {
            if (!this._isInitialized){
                this.init();
            };
            if (!this._view){
                return (null);
            };
            return (this._view.getWindowContainer());
        }
        public function getCategoryData(_arg_1:String):CategoryData
        {
            if (!this._isInitialized){
                this.init();
            };
            if (!this._categories){
                return (null);
            };
            return (this._categories[_arg_1]);
        }

    }
}//package com.sulake.habbo.avatar.common

// IAvatarEditorCategoryModel = "_-1mx" (String#5798, DoABC#2)
// CategoryBaseModel = "_-N4" (String#8146, DoABC#2)
// CategoryData = "_-2jI" (String#6943, DoABC#2)
// AvatarEditorGridPartItem = "_-xW" (String#8833, DoABC#2)
// IAvatarEditorCategoryView = "_-0Au" (String#3774, DoABC#2)
// _controller = "_-18D" (String#59, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// _categories = "_-EJ" (String#373, DoABC#2)
// getWindowContainer = "_-v8" (String#313, DoABC#2)
// showPalettes = "_-3AL" (String#7520, DoABC#2)
// getCategoryData = "_-2rW" (String#7114, DoABC#2)
// _SafeStr_4847 = "continue" (String#9328, DoABC#2)
// initCategory = "_-j6" (String#24003, DoABC#2)
// selectColor = "_-2lm" (String#6999, DoABC#2)
// selectColorIndex = "_-1SJ" (String#17594, DoABC#2)
// getSelectedColorIds = "_-3Is" (String#22233, DoABC#2)
// updateSelectionsFromFigure = "_-N3" (String#8145, DoABC#2)
// selectPartId = "_-kn" (String#24060, DoABC#2)
// selectColorIds = "_-1YX" (String#17832, DoABC#2)
// hasClubItemsOverLevel = "_-0bi" (String#4340, DoABC#2)
// stripClubItemsOverLevel = "_-0C1" (String#3793, DoABC#2)
// generateDataContent = "_-15w" (String#16694, DoABC#2)
// hasClubSelectionsOverLevel = "_-1rX" (String#18609, DoABC#2)
// stripClubColorsOverLevel = "_-0oz" (String#16011, DoABC#2)
// getCurrentPart = "_-aT" (String#23652, DoABC#2)
// savePartData = "_-15W" (String#16676, DoABC#2)
// selectPartIndex = "_-0ca" (String#15538, DoABC#2)
// colorLayerCount = "_-0xO" (String#16327, DoABC#2)


