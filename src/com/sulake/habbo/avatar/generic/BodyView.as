
package com.sulake.habbo.avatar.generic
{
    import com.sulake.habbo.avatar.common.CategoryBaseView;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryView;
    import com.sulake.habbo.avatar.figuredata.FigureData;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryModel;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.avatar.common.AvatarEditorGridView;
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Dictionary;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class BodyView extends CategoryBaseView implements IAvatarEditorCategoryView 
    {

        private const _SafeStr_5398:String = "tab_boy";
        private const _SafeStr_5399:String = "tab_girl";

        public function BodyView(_arg_1:IAvatarEditorCategoryModel, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary)
        {
            super(_arg_2, _arg_3, _arg_1);
            _SafeStr_5400 = FigureData._SafeStr_5401;
        }
        override public function reset():void
        {
            super.reset();
            _SafeStr_5400 = FigureData._SafeStr_5401;
        }
        override public function init():void
        {
            var _local_1:XmlAsset;
            var _local_2:AvatarEditorGridView;
            if (!_window){
                _local_1 = (_assetLibrary.getAssetByName("avatareditor_generic_base") as XmlAsset);
                if (_local_1){
                    _window = IWindowContainer(_windowManager.buildFromXML((_local_1.content as XML)));
                    _window.visible = false;
                    _window.procedure = this.windowEventProc;
                };
            };
            if (!_SafeStr_5402){
                _SafeStr_5402 = new Dictionary();
                _SafeStr_5402[FigureData._SafeStr_5401] = new AvatarEditorGridView(_SafeStr_4830, FigureData._SafeStr_5401, _windowManager, _assetLibrary);
            }
            else {
                for each (_local_2 in _SafeStr_5402) {
                    _local_2.initFromList();
                };
            };
            _isInitialized = true;
            updateGridView();
            attachImages();
            this.updateGenderTab();
        }
        override public function getWindowContainer():IWindowContainer
        {
            if (!_isInitialized){
                this.init();
            };
            this.updateGenderTab();
            return (_window);
        }
        public function updateGenderTab():void
        {
            if (_SafeStr_4830 == null){
                return;
            };
            switch (_SafeStr_4830.controller.gender){
                case FigureData.M:
                    activateTab(this._SafeStr_5398);
                    inactivateTab(this._SafeStr_5399);
                    return;
                case FigureData.FEMALE:
                    activateTab(this._SafeStr_5399);
                    inactivateTab(this._SafeStr_5398);
                    return;
            };
        }
        public function switchCategory(_arg_1:String):void
        {
            this.updateGenderTab();
        }
        private function windowEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                switch (_arg_2.name){
                    case this._SafeStr_5398:
                        _SafeStr_4830.controller.gender = FigureData.M;
                        _arg_1.stopPropagation();
                        break;
                    case this._SafeStr_5399:
                        _SafeStr_4830.controller.gender = FigureData.FEMALE;
                        _arg_1.stopPropagation();
                        break;
                };
            }
            else {
                if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER){
                    switch (_arg_2.name){
                        case this._SafeStr_5398:
                        case this._SafeStr_5399:
                            activateTab(_arg_2.name);
                            break;
                    };
                }
                else {
                    if (_arg_1.type == WindowMouseEvent.WME_OUT){
                        switch (_arg_2.name){
                            case this._SafeStr_5398:
                            case this._SafeStr_5399:
                                this.updateGenderTab();
                                return;
                        };
                    };
                };
            };
        }

    }
}//package com.sulake.habbo.avatar.generic

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// FigureData = "_-1BT" (String#836, DoABC#2)
// IAvatarEditorCategoryModel = "_-1mx" (String#5798, DoABC#2)
// IAvatarEditorCategoryView = "_-0Au" (String#3774, DoABC#2)
// CategoryBaseView = "_-2Mf" (String#6492, DoABC#2)
// BodyView = "_-FU" (String#7983, DoABC#2)
// AvatarEditorGridView = "_-28U" (String#6213, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// _SafeStr_4830 = "_-0XB" (String#112, DoABC#2)
// getWindowContainer = "_-v8" (String#313, DoABC#2)
// M = "_-1c3" (String#17974, DoABC#2)
// _SafeStr_5398 = "_-k" (String#24032, DoABC#2)
// _SafeStr_5399 = "_-2BH" (String#19454, DoABC#2)
// _SafeStr_5400 = "_-1zp" (String#18961, DoABC#2)
// _SafeStr_5401 = "_-06A" (String#14290, DoABC#2)
// _SafeStr_5402 = "_-0Lb" (String#14897, DoABC#2)
// initFromList = "_-ME" (String#23093, DoABC#2)
// updateGridView = "_-BT" (String#22671, DoABC#2)
// attachImages = "_-2jH" (String#6942, DoABC#2)
// updateGenderTab = "_-1gW" (String#18159, DoABC#2)
// activateTab = "_-339" (String#21625, DoABC#2)
// inactivateTab = "_-SE" (String#23334, DoABC#2)


