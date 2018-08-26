
package com.sulake.habbo.ui.widget.doorbell
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class DoorbellView 
    {

        private var _doorbell:DoorbellWidget;
        private var _frame:IFrameWindow;
        private var _content:IItemListWindow;

        public function DoorbellView(_arg_1:DoorbellWidget)
        {
            this._doorbell = _arg_1;
            this.createMainWindow();
        }
        public function dispose():void
        {
            this._doorbell = null;
            if (this._frame){
                this._frame.dispose();
                this._frame = null;
            };
        }
        public function update():void
        {
            var _local_1:int;
            if (this._doorbell.users.length == 0){
                this.hide();
                return;
            };
            if (this._frame != null){
                this._frame.visible = true;
            };
            if (this._content != null){
                this._content.IItemListWindow();
                _local_1 = 0;
                while (_local_1 < this._doorbell.users.length) {
                    this._content.addListItem(this.createListItem((this._doorbell.users[_local_1] as String), _local_1));
                    _local_1++;
                };
            };
        }
        private function createListItem(_arg_1:String, _arg_2:int):IWindow
        {
            var _local_6:IWindow;
            var _local_3:XmlAsset = (this._doorbell.assets.getAssetByName("doorbell_list_entry") as XmlAsset);
            var _local_4:IWindowContainer = (this._doorbell.windowManager.buildFromXML((_local_3.content as XML)) as IWindowContainer);
            if (_local_4 == null){
                throw (new Error("Failed to construct window from XML!"));
            };
            var _local_5:ITextWindow = (_local_4.findChildByName("user_name") as ITextWindow);
            if (_local_5 != null){
                _local_5.caption = _arg_1;
            };
            _local_4.name = _arg_1;
            if ((_arg_2 % 2) == 0){
                _local_4.color = 0xFFFFFFFF;
            };
            _local_6 = _local_4.findChildByName("accept");
            if (_local_6 != null){
                _local_6.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.InfoStandUserView);
            };
            _local_6 = _local_4.findChildByName("deny");
            if (_local_6 != null){
                _local_6.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.InfoStandUserView);
            };
            return (_local_4);
        }
        private function hide():void
        {
            if (this._frame == null){
                return;
            };
            this._frame.visible = false;
        }
        public function get mainWindow():IWindow
        {
            return (this._frame);
        }
        public function createMainWindow():void
        {
            if (this._frame != null){
                return;
            };
            var _local_1:XmlAsset = (this._doorbell.assets.getAssetByName("doorbell") as XmlAsset);
            this._frame = (this._doorbell.windowManager.buildFromXML((_local_1.content as XML)) as IFrameWindow);
            if (this._frame == null){
                throw (new Error("Failed to construct window from XML!"));
            };
            this._content = (this._frame.findChildByName("user_list") as IItemListWindow);
            this._frame.visible = false;
            var _local_2:IWindow = this._frame.findChildByTag("close");
            if (_local_2 != null){
                _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.PollOfferDialog);
            };
        }
        private function PollOfferDialog(_arg_1:WindowMouseEvent):void
        {
            this._doorbell.DoorbellWidget();
        }
        private function InfoStandUserView(_arg_1:WindowMouseEvent):void
        {
            var _local_2:String = _arg_1.window.parent.name;
            switch (_arg_1.window.name){
                case "accept":
                    this._doorbell.accept(_local_2);
                    return;
                case "deny":
                    this._doorbell.deny(_local_2);
                    return;
            };
        }

    }
}//package com.sulake.habbo.ui.widget.doorbell

// DoorbellWidget = "_-1Qv" (String#5372, DoABC#2)
// DoorbellView = "_-0Va" (String#4219, DoABC#2)
// mainWindow = "_-2Lh" (String#1862, DoABC#2)
// InfoStandUserView = "_-2k0" (String#247, DoABC#2)
// _content = "_-1Q8" (String#74, DoABC#2)
// users = "_-0nL" (String#15950, DoABC#2)
// DoorbellWidget = "_-sw" (String#24401, DoABC#2)
// _doorbell = "_-3-h" (String#7298, DoABC#2)
// IItemListWindow = "_-0xF" (String#4796, DoABC#2)
// createListItem = "_-mV" (String#2185, DoABC#2)
// PollOfferDialog = "_-2Ts" (String#54, DoABC#2)


