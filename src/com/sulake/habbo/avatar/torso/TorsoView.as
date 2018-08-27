
package com.sulake.habbo.avatar.torso
{
    import com.sulake.habbo.avatar.common.CategoryBaseView;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryView;
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

    public class TorsoView extends CategoryBaseView implements IAvatarEditorCategoryView 
    {

        public function TorsoView(_arg_1:TorsoModel, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary)
        {
            super(_arg_2, _arg_3, _arg_1);
        }
        override public function init():void
        {
            var _local_1:XmlAsset;
            var _local_2:AvatarEditorGridView;
            if (!_window){
                _local_1 = (_assetLibrary.getAssetByName("avatareditor_torso_base") as XmlAsset);
                if (_local_1){
                    _window = IWindowContainer(_windowManager.buildFromXML((_local_1.content as XML)));
                    _window.visible = false;
                    _window.procedure = this.windowEventProc;
                };
            };
            if (!_SafeStr_5402){
                _SafeStr_5402 = new Dictionary();
                _SafeStr_5402[FigureData._SafeStr_6611] = new AvatarEditorGridView(_SafeStr_4830, FigureData._SafeStr_6611, _windowManager, _assetLibrary);
                _SafeStr_5402[FigureData._SafeStr_6612] = new AvatarEditorGridView(_SafeStr_4830, FigureData._SafeStr_6612, _windowManager, _assetLibrary);
                _SafeStr_5402[FigureData._SafeStr_6613] = new AvatarEditorGridView(_SafeStr_4830, FigureData._SafeStr_6613, _windowManager, _assetLibrary);
                _SafeStr_5402[FigureData.CHEST_PRINTS] = new AvatarEditorGridView(_SafeStr_4830, FigureData.CHEST_PRINTS, _windowManager, _assetLibrary);
            }
            else {
                for each (_local_2 in _SafeStr_5402) {
                    _local_2.initFromList();
                };
            };
            _isInitialized = true;
            attachImages();
            if (((_SafeStr_4830) && ((_SafeStr_5400 == "")))){
                _SafeStr_4830.switchCategory(FigureData._SafeStr_6612);
            };
        }
        override public function dispose():void
        {
            super.dispose();
            _SafeStr_4830 = null;
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
                case FigureData._SafeStr_6612:
                    _SafeStr_6466 = "tab_shirt";
                    break;
                case FigureData._SafeStr_6611:
                    _SafeStr_6466 = "tab_jacket";
                    break;
                case FigureData.CHEST_PRINTS:
                    _SafeStr_6466 = "tab_prints";
                    break;
                case FigureData._SafeStr_6613:
                    _SafeStr_6466 = "tab_accessories";
                    break;
                default:
                    throw (new Error((('[TorsoView] Unknown item category: "' + _arg_1) + '"')));
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
                    case "tab_jacket":
                        this.switchCategory(FigureData._SafeStr_6611);
                        break;
                    case "tab_shirt":
                        this.switchCategory(FigureData._SafeStr_6612);
                        break;
                    case "tab_accessories":
                        this.switchCategory(FigureData._SafeStr_6613);
                        break;
                    case "tab_prints":
                        this.switchCategory(FigureData.CHEST_PRINTS);
                        break;
                };
            }
            else {
                if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER){
                    switch (_arg_2.name){
                        case "tab_jacket":
                        case "tab_prints":
                        case "tab_shirt":
                        case "tab_accessories":
                            activateTab(_arg_2.name);
                            break;
                    };
                }
                else {
                    if (_arg_1.type == WindowMouseEvent.WME_OUT){
                        switch (_arg_2.name){
                            case "tab_jacket":
                            case "tab_prints":
                            case "tab_shirt":
                            case "tab_accessories":
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
}//package com.sulake.habbo.avatar.torso

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// FigureData = "_-1BT" (String#836, DoABC#2)
// TorsoModel = "_-0cj" (String#4359, DoABC#2)
// IAvatarEditorCategoryView = "_-0Au" (String#3774, DoABC#2)
// CategoryBaseView = "_-2Mf" (String#6492, DoABC#2)
// TorsoView = "_-0cS" (String#4352, DoABC#2)
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
// _SafeStr_6611 = "_-1bM" (String#17951, DoABC#2)
// _SafeStr_6612 = "_-0AK" (String#14460, DoABC#2)
// _SafeStr_6613 = "_-Os" (String#23200, DoABC#2)


