
package com.sulake.habbo.moderation
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class MyIssuesView implements IIssueBrowserView 
    {

        private var _issueManager:IssueManager;
        private var _SafeStr_11929:IssueBrowser;
        private var _window:IWindowContainer;
        private var _SafeStr_11930:IssueListView;

        public function MyIssuesView(_arg_1:IssueManager, _arg_2:IssueBrowser, _arg_3:IWindowContainer)
        {
            this._issueManager = _arg_1;
            this._SafeStr_11929 = _arg_2;
            this._window = (this._SafeStr_11929.createWindow("my_issues_xml") as IWindowContainer);
            _arg_3.addChild(this._window);
            var _local_4:IItemListWindow = (this._window.findChildByName("issue_list") as IItemListWindow);
            this._SafeStr_11930 = new IssueListView(_arg_1, _arg_2, _local_4, "my_issues_list_item_xml");
            var _local_5:IWindow = this._window.findChildByName("release_all");
            if (_local_5 != null){
                _local_5.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onReturnAll);
            };
        }
        public function get view():IWindowContainer
        {
            return (this._window);
        }
        public function set visible(_arg_1:Boolean):void
        {
            this._window.visible = _arg_1;
        }
        public function update():void
        {
            var _local_1:Array = this._issueManager.getBundles(IssueManager._SafeStr_11935);
            this._SafeStr_11930.update(_local_1);
        }
        private function onReturnAll(_arg_1:WindowMouseEvent):void
        {
            if (this._issueManager == null){
                return;
            };
            this._issueManager.releaseAll();
        }

    }
}//package com.sulake.habbo.moderation

// _SafeStr_11929 = "_-0lg" (String#591, DoABC#2)
// _SafeStr_11930 = "_-15z" (String#1620, DoABC#2)
// getBundles = "_-10W" (String#16484, DoABC#2)
// onReturnAll = "_-Ds" (String#22765, DoABC#2)
// _SafeStr_11935 = "_-25j" (String#19247, DoABC#2)
// releaseAll = "_-1dx" (String#18055, DoABC#2)
// IssueBrowser = "_-3Jw" (String#7700, DoABC#2)
// IIssueBrowserView = "_-2WK" (String#6689, DoABC#2)
// MyIssuesView = "_-08j" (String#3734, DoABC#2)
// IssueListView = "_-0Hb" (String#3909, DoABC#2)


