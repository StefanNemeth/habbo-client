
package com.sulake.habbo.avatar.head
{
    import com.sulake.habbo.avatar.common.CategoryBaseView;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryView;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryModel;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.avatar.common.AvatarEditorGridView;
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Dictionary;
    import com.sulake.habbo.avatar.figuredata.FigureData;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class HeadView extends CategoryBaseView implements IAvatarEditorCategoryView 
    {

        public function HeadView(_arg_1:IAvatarEditorCategoryModel, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary)
        {
            super(_arg_2, _arg_3, _arg_1);
        }
        override public function init():void
        {
            var _local_1:XmlAsset;
            var _local_2:AvatarEditorGridView;
            if (!_window){
                _local_1 = (_assetLibrary.getAssetByName("avatareditor_head_base") as XmlAsset);
                if (_local_1){
                    _window = IWindowContainer(_windowManager.buildFromXML((_local_1.content as XML)));
                    _window.visible = false;
                    _window.procedure = this.windowEventProc;
                };
            };
            if (!_SafeStr_5402){
                _SafeStr_5402 = new Dictionary();
                _SafeStr_5402[FigureData._SafeStr_6467] = new AvatarEditorGridView(_SafeStr_4830, FigureData._SafeStr_6467, _windowManager, _assetLibrary);
                _SafeStr_5402[FigureData._SafeStr_6468] = new AvatarEditorGridView(_SafeStr_4830, FigureData._SafeStr_6468, _windowManager, _assetLibrary);
                _SafeStr_5402[FigureData._SafeStr_6469] = new AvatarEditorGridView(_SafeStr_4830, FigureData._SafeStr_6469, _windowManager, _assetLibrary);
                _SafeStr_5402[FigureData._SafeStr_6470] = new AvatarEditorGridView(_SafeStr_4830, FigureData._SafeStr_6470, _windowManager, _assetLibrary);
                _SafeStr_5402[FigureData._SafeStr_6471] = new AvatarEditorGridView(_SafeStr_4830, FigureData._SafeStr_6471, _windowManager, _assetLibrary);
            }
            else {
                for each (_local_2 in _SafeStr_5402) {
                    _local_2.initFromList();
                };
            };
            _isInitialized = true;
            attachImages();
            if (((_SafeStr_4830) && ((_SafeStr_5400 == "")))){
                _SafeStr_4830.switchCategory(FigureData._SafeStr_6467);
            };
        }
        public function switchCategory(_arg_1:String):void
        {
            if (_window == null){
                return;
            };
            if (_window.disposed){
                return;
            };
            if (_SafeStr_5400 == _arg_1){
                return;
            };
            inactivateTab(_SafeStr_6466);
            switch (_arg_1){
                case FigureData._SafeStr_6467:
                    _SafeStr_6466 = "tab_hair";
                    break;
                case FigureData._SafeStr_6468:
                    _SafeStr_6466 = "tab_hat";
                    break;
                case FigureData._SafeStr_6469:
                    _SafeStr_6466 = "tab_accessories";
                    break;
                case FigureData._SafeStr_6470:
                    _SafeStr_6466 = "tab_eyewear";
                    break;
                case FigureData._SafeStr_6471:
                    _SafeStr_6466 = "tab_masks";
                    break;
                default:
                    throw (new Error((('[HeadView] Unknown item category: "' + _arg_1) + '"')));
            };
            _SafeStr_5400 = _arg_1;
            activateTab(_SafeStr_6466);
            if (!_isInitialized){
                this.init();
            };
            updateGridView();
        }
        private function windowEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                switch (_arg_2.name){
                    case "tab_hair":
                        this.switchCategory(FigureData._SafeStr_6467);
                        break;
                    case "tab_hat":
                        this.switchCategory(FigureData._SafeStr_6468);
                        break;
                    case "tab_accessories":
                        this.switchCategory(FigureData._SafeStr_6469);
                        break;
                    case "tab_eyewear":
                        this.switchCategory(FigureData._SafeStr_6470);
                        break;
                    case "tab_masks":
                        this.switchCategory(FigureData._SafeStr_6471);
                        break;
                };
            }
            else {
                if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER){
                    switch (_arg_2.name){
                        case "tab_hair":
                        case "tab_hat":
                        case "tab_accessories":
                        case "tab_eyewear":
                        case "tab_masks":
                            activateTab(_arg_2.name);
                            break;
                    };
                }
                else {
                    if (_arg_1.type == WindowMouseEvent.WME_OUT){
                        switch (_arg_2.name){
                            case "tab_hair":
                            case "tab_hat":
                            case "tab_accessories":
                            case "tab_eyewear":
                            case "tab_masks":
                                if (_SafeStr_6466 != _arg_2.name){
                                    inactivateTab(_arg_2.name);
                                };
                                return;
                        };
                    };
                };
            };
        }

    }
}//package com.sulake.habbo.avatar.head

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// FigureData = "_-1BT" (String#836, DoABC#2)
// IAvatarEditorCategoryModel = "_-1mx" (String#5798, DoABC#2)
// IAvatarEditorCategoryView = "_-0Au" (String#3774, DoABC#2)
// CategoryBaseView = "_-2Mf" (String#6492, DoABC#2)
// HeadView = "_-WZ" (String#8335, DoABC#2)
// AvatarEditorGridView = "_-28U" (String#6213, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// _SafeStr_4830 = "_-0XB" (String#112, DoABC#2)
// _SafeStr_5400 = "_-1zp" (String#18961, DoABC#2)
// _SafeStr_5402 = "_-0Lb" (String#14897, DoABC#2)
// initFromList = "_-ME" (String#23093, DoABC#2)
// updateGridView = "_-BT" (String#22671, DoABC#2)
// attachImages = "_-2jH" (String#6942, DoABC#2)
// activateTab = "_-339" (String#21625, DoABC#2)
// inactivateTab = "_-SE" (String#23334, DoABC#2)
// _SafeStr_6466 = "_-1DU" (String#17001, DoABC#2)
// _SafeStr_6467 = "_-3o" (String#22367, DoABC#2)
// _SafeStr_6468 = "_-1Pm" (String#17499, DoABC#2)
// _SafeStr_6469 = "_-2xX" (String#21374, DoABC#2)
// _SafeStr_6470 = "_-2IJ" (String#19739, DoABC#2)
// _SafeStr_6471 = "_-2o2" (String#21003, DoABC#2)


