
package com.sulake.habbo.moderation
{
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindowContainer;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.parser.moderation.IssueMessageData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.utils.getTimer;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class IssueListView 
    {

        private static const _SafeStr_11938:int = 20;

        private var _issueManager:IssueManager;
        private var _SafeStr_11929:IssueBrowser;
        private var _content:IItemListWindow;
        private var _assetName:String;
        private var _SafeStr_11939:IWindowContainer;
        private var _SafeStr_11940:BitmapData;
        private var _SafeStr_11941:BitmapData;

        public function IssueListView(_arg_1:IssueManager, _arg_2:IssueBrowser, _arg_3:IItemListWindow, _arg_4:String)
        {
            this._issueManager = _arg_1;
            this._SafeStr_11929 = _arg_2;
            this._content = _arg_3;
            this._assetName = _arg_4;
            this._SafeStr_11939 = (this._SafeStr_11929.createWindow(_arg_4) as IWindowContainer);
        }
        public function update(_arg_1:Array):void
        {
            var _local_2:int;
            var _local_3:IWindowContainer;
            var _local_6:IWindow;
            var _local_7:IssueBundle;
            var _local_9:IWindow;
            var _local_10:IssueMessageData;
            var _local_11:IBitmapWrapperWindow;
            var _local_12:String;
            var _local_13:BitmapDataAsset;
            var _local_14:BitmapData;
            if (this._content == null){
                return;
            };
            if ((((_arg_1 == null)) || ((_arg_1.length == 0)))){
                this._content.IItemListWindow();
                return;
            };
            _arg_1.sortOn("prioritySum", (Array.DESCENDING | Array.NUMERIC));
            var _local_4:int = this._content.numListItems;
            var _local_5:int = _arg_1.length;
            if (_local_5 > _SafeStr_11938){
                _local_5 = _SafeStr_11938;
            };
            if (_local_4 < _local_5){
                _local_2 = 0;
                while (_local_2 < (_local_5 - _local_4)) {
                    _local_3 = (this._SafeStr_11939.clone() as IWindowContainer);
                    this._content.addListItem(_local_3);
                    _local_2++;
                };
            }
            else {
                if (_local_4 > _local_5){
                    _local_2 = 0;
                    while (_local_2 < (_local_4 - _local_5)) {
                        _local_9 = this._content.IItemListWindow(0);
                        _local_9.dispose();
                        _local_2++;
                    };
                };
            };
            _local_2 = 1;
            var _local_8:int = getTimer();
            for each (_local_7 in _arg_1) {
                if (_local_2 > _SafeStr_11938) break;
                if ((((_local_7 == null)) || ((this._SafeStr_11939 == null)))){
                    return;
                };
                _local_3 = (this._content.getListItemAt((_local_2 - 1)) as IWindowContainer);
                if (_local_3 == null){
                    return;
                };
                _local_3.width = this._content.width;
                _local_3.color = (((_local_2++ % 2)) ? 4289914618 : 0xFFFFFFFF);
                _local_6 = _local_3.findChildByName("score");
                if (_local_6 != null){
                    _local_6.caption = _local_7.prioritySum.toString();
                };
                _local_10 = _local_7.getHighestPriorityIssue();
                if (_local_10 == null){
                    return;
                };
                _local_6 = _local_3.findChildByName("category");
                if (_local_6 != null){
                    _local_6.caption = IssueCategoryNames.getCategoryName(_local_10.reportedCategoryId);
                };
                _local_6 = _local_3.findChildByName("target_name");
                if (_local_6 != null){
                    if (_local_10.reportedUserId != 0){
                        _local_6.caption = _local_10.reportedUserName;
                    }
                    else {
                        _local_6.caption = _local_10.roomName;
                    };
                };
                _local_11 = (_local_3.findChildByName("target_icon") as IBitmapWrapperWindow);
                if (_local_11 != null){
                    _local_12 = ((_local_10.reportedUserId) ? "user_icon_png" : "room_icon_png");
                    _local_13 = (this._SafeStr_11929.assets.getAssetByName(_local_12) as BitmapDataAsset);
                    if (((!((_local_13 == null))) && (!(((_local_13.content as BitmapData) == null))))){
                        _local_14 = (_local_13.content as BitmapData);
                        if (_local_14 != null){
                            _local_11.bitmap = _local_14.clone();
                        };
                    };
                };
                _local_6 = _local_3.findChildByName("time");
                if (_local_6 != null){
                    _local_6.caption = _local_7.getOpenTime(_local_8);
                };
                _local_6 = _local_3.findChildByName("msgs");
                if (_local_6 != null){
                    _local_6.caption = _local_7.getMessageCount().toString();
                };
                _local_6 = _local_3.findChildByName("picker");
                if (_local_6 != null){
                    _local_6.caption = _local_7.pickerName;
                };
                _local_6 = _local_3.findChildByName("pick_button");
                if (_local_6 != null){
                    _local_6.id = _local_7.id;
                    _local_6.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onPick);
                    _local_6.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onPick);
                };
                _local_6 = _local_3.findChildByName("handle_button");
                if (_local_6 != null){
                    _local_6.id = _local_7.id;
                    _local_6.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onHandle);
                    _local_6.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onHandle);
                };
                _local_6 = _local_3.findChildByName("release_button");
                if (_local_6 != null){
                    _local_6.id = _local_7.id;
                    _local_6.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.IssueHandler);
                    _local_6.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.IssueHandler);
                };
            };
        }
        private function onPick(_arg_1:WindowMouseEvent):void
        {
            if (this._issueManager == null){
                return;
            };
            this._issueManager.pickBundle(_arg_1.window.id);
        }
        private function onHandle(_arg_1:WindowMouseEvent):void
        {
            if (this._SafeStr_11929 == null){
                return;
            };
            this._issueManager.handleBundle(_arg_1.window.id);
        }
        private function IssueHandler(_arg_1:WindowMouseEvent):void
        {
            if (this._issueManager == null){
                return;
            };
            this._issueManager.releaseBundle(_arg_1.window.id);
        }

    }
}//package com.sulake.habbo.moderation

// IssueHandler = "_-2Qb" (String#6571, DoABC#2)
// getHighestPriorityIssue = "_-22z" (String#19134, DoABC#2)
// getCategoryName = "_-0mq" (String#15933, DoABC#2)
// releaseBundle = "_-2Nx" (String#19962, DoABC#2)
// pickerName = "_-1l9" (String#18337, DoABC#2)
// getMessageCount = "_-0nm" (String#15967, DoABC#2)
// _SafeStr_11929 = "_-0lg" (String#591, DoABC#2)
// _SafeStr_11938 = "_-39l" (String#21874, DoABC#2)
// _SafeStr_11939 = "_-yf" (String#24638, DoABC#2)
// _SafeStr_11940 = "_-0u-" (String#16202, DoABC#2)
// _SafeStr_11941 = "_-1vm" (String#18789, DoABC#2)
// onPick = "_-2YO" (String#20372, DoABC#2)
// onHandle = "_-2df" (String#20589, DoABC#2)
// pickBundle = "_-cd" (String#23737, DoABC#2)
// handleBundle = "_-2Z7" (String#20403, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// IssueMessageData = "_-0K1" (String#3952, DoABC#2)
// IssueBrowser = "_-3Jw" (String#7700, DoABC#2)
// IssueBundle = "_-1x4" (String#18850, DoABC#2)
// IssueCategoryNames = "_-2eJ" (String#6840, DoABC#2)
// IssueListView = "_-0Hb" (String#3909, DoABC#2)
// _content = "_-1Q8" (String#74, DoABC#2)
// IItemListWindow = "_-0xF" (String#4796, DoABC#2)
// _assetName = "_-33u" (String#910, DoABC#2)
// IItemListWindow = "_-Td" (String#8279, DoABC#2)
// reportedCategoryId = "_-eV" (String#23822, DoABC#2)
// getOpenTime = "_-P3" (String#23209, DoABC#2)


