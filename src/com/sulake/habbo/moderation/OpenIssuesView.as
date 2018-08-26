
package com.sulake.habbo.moderation
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;

    public class OpenIssuesView implements IIssueBrowserView 
    {

        private var _issueManager:IssueManager;
        private var _SafeStr_11929:IssueBrowser;
        private var _window:IWindowContainer;
        private var _SafeStr_11930:IssueListView;

        public function OpenIssuesView(_arg_1:IssueManager, _arg_2:IssueBrowser, _arg_3:IWindowContainer)
        {
            this._issueManager = _arg_1;
            this._SafeStr_11929 = _arg_2;
            this._window = (this._SafeStr_11929.createWindow("open_issues_xml") as IWindowContainer);
            _arg_3.addChild(this._window);
            var _local_4:IItemListWindow = (this._window.findChildByName("issue_list") as IItemListWindow);
            this._SafeStr_11930 = new IssueListView(_arg_1, _arg_2, _local_4, "open_issues_list_item_xml");
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
            var _local_1:Array = this._issueManager.getBundles(IssueManager._SafeStr_11933);
            this._SafeStr_11930.update(_local_1);
        }

    }
}//package com.sulake.habbo.moderation

// _SafeStr_11929 = "_-0lg" (String#591, DoABC#2)
// _SafeStr_11930 = "_-15z" (String#1620, DoABC#2)
// getBundles = "_-10W" (String#16484, DoABC#2)
// _SafeStr_11933 = "_-2AY" (String#19428, DoABC#2)
// IssueBrowser = "_-3Jw" (String#7700, DoABC#2)
// IIssueBrowserView = "_-2WK" (String#6689, DoABC#2)
// OpenIssuesView = "_-2gC" (String#6873, DoABC#2)
// IssueListView = "_-0Hb" (String#3909, DoABC#2)


