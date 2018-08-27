
package com.sulake.habbo.moderation
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.ITabContextWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITabButtonWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.ISelectableWindow;
    import com.sulake.core.assets.XmlAsset;

    public class IssueBrowser 
    {

        private const _SafeStr_11869:String = "my_issues";
        private const _SafeStr_11870:String = "open_issues";
        private const _SafeStr_11871:String = "picked_issues";
        private const _SafeStr_11872:String = "closed_issues";

        private var _issueManager:IssueManager;
        private var _windowManager:IHabboWindowManager;
        private var _assets:IAssetLibrary;
        private var _window:IFrameWindow;
        private var _SafeStr_4238:ITabContextWindow;
        private var _SafeStr_11873:IIssueBrowserView;
        private var _SafeStr_11874:IIssueBrowserView;
        private var _SafeStr_11875:IIssueBrowserView;
        private var _SafeStr_11876:PickedIssuesView;

        public function IssueBrowser(_arg_1:IssueManager, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary)
        {
            this._issueManager = _arg_1;
            this._windowManager = _arg_2;
            this._assets = _arg_3;
        }
        public function get windowManager():IHabboWindowManager
        {
            return (this._windowManager);
        }
        public function get assets():IAssetLibrary
        {
            return (this._assets);
        }
        public function get issueManager():IssueManager
        {
            return (this._issueManager);
        }
        public function show():void
        {
            if (this._window == null){
                this.createMainFrame();
            };
            this._window.visible = true;
            this._window.activate();
            this.update();
        }
        public function isOpen():Boolean
        {
            return (((!((this._window == null))) && (this._window.visible)));
        }
        private function createMainFrame():void
        {
            var _local_2:IWindow;
            var _local_3:IWindow;
            var _local_4:IWindow;
            var _local_5:ITabButtonWindow;
            var _local_6:int;
            if (this._window == null){
                this._window = (this.createWindow("issue_browser_xml") as IFrameWindow);
                if (this._window == null){
                    return;
                };
                _local_2 = this._window.desktop;
                this._window.x = ((_local_2.width / 2) - (this._window.width / 2));
                this._window.y = ((_local_2.height / 2) - (this._window.height / 2));
                _local_3 = this._window.findChildByTag("close");
                if (_local_3 != null){
                    _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClose);
                };
                _local_4 = this._window.findChildByName("auto_pick");
                if (_local_4 != null){
                    _local_4.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onAutoPick);
                };
                this._SafeStr_4238 = (this._window.findChildByName("tab_context") as ITabContextWindow);
                _local_6 = 0;
                while (_local_6 < this._SafeStr_4238.numTabItems) {
                    _local_5 = this._SafeStr_4238.getTabItemAt(_local_6);
                    _local_5.addEventListener(WindowEvent.WE_SELECTED, this.onTabSelected);
                    _local_6++;
                };
            };
            this._SafeStr_4238 = (this._window.findChildByName("tab_context") as ITabContextWindow);
            if ((((this._SafeStr_4238 == null)) || ((this._SafeStr_4238.container == null)))){
                return;
            };
            var _local_1:ISelectableWindow = this._SafeStr_4238.selector.getSelectableByName("open_issues");
            this._SafeStr_4238.selector.setSelected(_local_1);
        }
        private function selectView(_arg_1:String):void
        {
            var _local_2:IIssueBrowserView = this.getView(_arg_1);
            if (this._SafeStr_11873 == _local_2){
                return;
            };
            if (this._SafeStr_11873 != null){
                this._SafeStr_11873.visible = false;
            };
            this._SafeStr_11873 = _local_2;
            if (this._SafeStr_11873 == null){
                return;
            };
            this._SafeStr_11873.view.width = this._SafeStr_4238.container.width;
            this._SafeStr_11873.view.height = this._SafeStr_4238.container.height;
            this._SafeStr_11873.visible = true;
            this._SafeStr_11873.update();
        }
        private function getView(_arg_1:String):IIssueBrowserView
        {
            switch (_arg_1){
                case this._SafeStr_11869:
                    if (this._SafeStr_11874 == null){
                        this._SafeStr_11874 = new MyIssuesView(this.issueManager, this, this._SafeStr_4238.container);
                    };
                    return (this._SafeStr_11874);
                case this._SafeStr_11870:
                    if (this._SafeStr_11875 == null){
                        this._SafeStr_11875 = new OpenIssuesView(this.issueManager, this, this._SafeStr_4238.container);
                    };
                    return (this._SafeStr_11875);
                case this._SafeStr_11871:
                    if (this._SafeStr_11876 == null){
                        this._SafeStr_11876 = new PickedIssuesView(this.issueManager, this, this._SafeStr_4238.container);
                    };
                    return (this._SafeStr_11876);
                default:
                    return (null);
            };
        }
        private function onTabSelected(_arg_1:WindowEvent):void
        {
            if ((((_arg_1 == null)) || ((_arg_1.window == null)))){
                return;
            };
            this.selectView(_arg_1.window.name);
        }
        public function update():void
        {
            if ((((this._window == null)) || (!(this._window.visible)))){
                return;
            };
            if (this._SafeStr_11873 == null){
                return;
            };
            this._SafeStr_11873.update();
        }
        public function createWindow(_arg_1:String):IWindow
        {
            if ((((this._windowManager == null)) || ((this._assets == null)))){
                return (null);
            };
            var _local_2:XmlAsset = (this._assets.getAssetByName(_arg_1) as XmlAsset);
            if ((((_local_2 == null)) || ((_local_2.content == null)))){
                return (null);
            };
            return (this._windowManager.buildFromXML((_local_2.content as XML)));
        }
        private function onClose(_arg_1:WindowMouseEvent):void
        {
            this._window.visible = false;
        }
        private function onAutoPick(_arg_1:WindowMouseEvent):void
        {
            if (this._issueManager != null){
                this._issueManager.autoPick();
            };
        }

    }
}//package com.sulake.habbo.moderation

// issueManager = "_-277" (String#19296, DoABC#2)
// autoPick = "_-Ot" (String#23201, DoABC#2)
// _SafeStr_11869 = "_-y5" (String#24618, DoABC#2)
// _SafeStr_11870 = "_-Jo" (String#22998, DoABC#2)
// _SafeStr_11871 = "_-eG" (String#23812, DoABC#2)
// _SafeStr_11872 = "_-0M4" (String#14918, DoABC#2)
// _SafeStr_11873 = "_-1gD" (String#18149, DoABC#2)
// _SafeStr_11874 = "_-1iL" (String#18222, DoABC#2)
// _SafeStr_11875 = "_-0W0" (String#15276, DoABC#2)
// _SafeStr_11876 = "_-31H" (String#21550, DoABC#2)
// createMainFrame = "_-1KJ" (String#17286, DoABC#2)
// onAutoPick = "_-22y" (String#19133, DoABC#2)
// getView = "_-1vU" (String#18777, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// ISelectableWindow = "_-nA" (String#2188, DoABC#2)
// ITabButtonWindow = "_-1Gf" (String#1649, DoABC#2)
// ITabContextWindow = "_-0L6" (String#1455, DoABC#2)
// IssueBrowser = "_-3Jw" (String#7700, DoABC#2)
// IIssueBrowserView = "_-2WK" (String#6689, DoABC#2)
// PickedIssuesView = "_-05R" (String#3674, DoABC#2)
// OpenIssuesView = "_-2gC" (String#6873, DoABC#2)
// MyIssuesView = "_-08j" (String#3734, DoABC#2)
// _SafeStr_4238 = "_-1WR" (String#1704, DoABC#2)
// isOpen = "_-2i4" (String#897, DoABC#2)
// WE_SELECTED = "_-17F" (String#16745, DoABC#2)
// onTabSelected = "_-2da" (String#6822, DoABC#2)
// onClose = "_-2Ts" (String#54, DoABC#2)
// selectView = "_-1-8" (String#1597, DoABC#2)
// getSelectableByName = "_-0EO" (String#3836, DoABC#2)
// numTabItems = "_-2Dt" (String#6317, DoABC#2)
// getTabItemAt = "_-0XL" (String#4256, DoABC#2)


