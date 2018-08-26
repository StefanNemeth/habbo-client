
package com.sulake.habbo.ui.widget.chooser
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import flash.external.ExternalInterface;
    import com.sulake.habbo.ui.widget.events.ChooserItem;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.IWindow;

    public class ChooserView 
    {

        private const _SafeStr_5582:uint = 4293848814;
        private const _SafeStr_5583:uint = 0;
        private const _SafeStr_6605:uint = 4282169599;

        private var _widget:ChooserWidgetBase;
        private var _title:String;
        private var _window:IFrameWindow;
        private var _itemList:IItemListWindow;
        private var _items:Array;
        private var _SafeStr_6606:Boolean;
        private var _SafeStr_6607:int;

        public function ChooserView(_arg_1:ChooserWidgetBase, _arg_2:String)
        {
            this._widget = _arg_1;
            this._title = _arg_2;
            ExternalInterface.addCallback("closeExtraWidget", this.hideWindow);
        }
        public function dispose():void
        {
            if (this._window != null){
                this._window.dispose();
                this._window = null;
            };
        }
        public function IssueBrowser():Boolean
        {
            return (((!((this._window == null))) && (this._window.visible)));
        }
        public function populate(_arg_1:Array, _arg_2:Boolean):void
        {
            var _local_4:ChooserItem;
            var _local_5:IWindowContainer;
            var _local_6:int;
            var _local_7:ITextWindow;
            if (this._widget == null){
                return;
            };
            if (this._window == null){
                this.createWindow();
            };
            if ((((((this._window == null)) || ((this._itemList == null)))) || ((_arg_1 == null)))){
                return;
            };
            this._itemList.IItemListWindow();
            var _local_3:XmlAsset = XmlAsset(this._widget.assets.getAssetByName("chooser_item"));
            if (_local_3 == null){
                return;
            };
            this._items = _arg_1.slice();
            this._SafeStr_6606 = _arg_2;
            _local_6 = 0;
            while (_local_6 < _arg_1.length) {
                _local_4 = (_arg_1[_local_6] as ChooserItem);
                if (_local_4 != null){
                    _local_5 = (this._widget.windowManager.buildFromXML((_local_3.content as XML)) as IWindowContainer);
                    if (_local_5 == null){
                        return;
                    };
                    _local_7 = (_local_5.findChildByName("itemtext") as ITextWindow);
                    if (_local_7 == null){
                        return;
                    };
                    _local_5.id = _local_6;
                    if (this._SafeStr_6606){
                        _local_7.text = ((_local_4.name + " id: ") + _local_4.id);
                    }
                    else {
                        _local_7.text = _local_4.name;
                    };
                    _local_5.color = (((_local_6 % 2)) ? this._SafeStr_5583 : this._SafeStr_5582);
                    _local_5.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onListItemClicked);
                    this._itemList.addListItem(_local_5);
                };
                _local_6++;
            };
            _local_6 = 0;
            while (_local_6 < this._itemList.numListItems) {
                _local_5 = (this._itemList.getListItemAt(_local_6) as IWindowContainer);
                if (_local_5 != null){
                    _local_5.width = this._itemList.width;
                };
                _local_6++;
            };
            this._SafeStr_6607 = -1;
        }
        private function createWindow():void
        {
            var _local_1:XmlAsset = XmlAsset(this._widget.assets.getAssetByName("chooser_view"));
            if (_local_1 == null){
                return;
            };
            this._window = (this._widget.windowManager.buildFromXML((_local_1.content as XML)) as IFrameWindow);
            if (this._window == null){
                return;
            };
            this._window.caption = this._title;
            this._itemList = (this._window.findChildByName("item_list") as IItemListWindow);
            var _local_2:IWindow = this._window.findChildByTag("close");
            if (_local_2 != null){
                _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.PollOfferDialog);
            };
            if (this._window.parent != null){
                this._window.x = (this._window.parent.width - this._window.width);
                this._window.y = 0;
            };
        }
        private function hideWindow():void
        {
            if (this._window != null){
                this._window.dispose();
                this._window = null;
            };
        }
        private function onListItemClicked(_arg_1:WindowMouseEvent):void
        {
            if ((((((_arg_1 == null)) || ((_arg_1.window == null)))) || ((this._items == null)))){
                return;
            };
            var _local_2:int = _arg_1.window.id;
            if ((((_local_2 < 0)) || ((_local_2 > this._items.length)))){
                return;
            };
            var _local_3:ChooserItem = (this._items[_local_2] as ChooserItem);
            if (_local_3 == null){
                return;
            };
            this._widget.choose(_local_3.id, _local_3.category);
            this.highlightItem(_local_2);
        }
        private function highlightItem(_arg_1:int):void
        {
            var _local_2:IWindowContainer;
            if ((((((((this._itemList == null)) || ((_arg_1 < 0)))) || ((_arg_1 > this._itemList.numListItems)))) || ((_arg_1 == this._SafeStr_6607)))){
                return;
            };
            if (this._SafeStr_6607 != -1){
                _local_2 = (this._itemList.getListItemAt(this._SafeStr_6607) as IWindowContainer);
                if (_local_2 != null){
                    _local_2.color = (((this._SafeStr_6607 % 2)) ? this._SafeStr_5583 : this._SafeStr_5582);
                };
            };
            _local_2 = (this._itemList.getListItemAt(_arg_1) as IWindowContainer);
            if (_local_2 != null){
                _local_2.color = this._SafeStr_6605;
                this._SafeStr_6607 = _arg_1;
            };
        }
        public function removeItem(_arg_1:int, _arg_2:int):void
        {
            var _local_3:ChooserItem;
            if ((((this._items == null)) || ((this._itemList == null)))){
                return;
            };
            var _local_4:int;
            while (_local_4 < this._items.length) {
                _local_3 = (this._items[_local_4] as ChooserItem);
                if (_local_3 != null){
                    if ((((_local_3.id == _arg_1)) && ((_local_3.category == _arg_2)))){
                        this._items.splice(_local_4, 1);
                        break;
                    };
                };
                _local_4++;
            };
            this.populate(this._items, this._SafeStr_6606);
        }
        private function PollOfferDialog(_arg_1:WindowMouseEvent):void
        {
            this.hideWindow();
        }

    }
}//package com.sulake.habbo.ui.widget.chooser

// ChooserWidgetBase = "_-1UM" (String#5439, DoABC#2)
// ChooserView = "_-2b-" (String#6772, DoABC#2)
// ChooserItem = "_-2XQ" (String#6710, DoABC#2)
// IssueBrowser = "_-2i4" (String#897, DoABC#2)
// hideWindow = "_-0Lm" (String#3998, DoABC#2)
// IItemListWindow = "_-0xF" (String#4796, DoABC#2)
// PollOfferDialog = "_-2Ts" (String#54, DoABC#2)
// _SafeStr_5582 = "_-2ih" (String#1929, DoABC#2)
// _SafeStr_5583 = "_-2HF" (String#1846, DoABC#2)
// _itemList = "_-Tp" (String#310, DoABC#2)
// choose = "_-14o" (String#16647, DoABC#2)
// _SafeStr_6605 = "_-0nf" (String#15962, DoABC#2)
// _SafeStr_6606 = "_-Zm" (String#23626, DoABC#2)
// _SafeStr_6607 = "_-1wG" (String#18809, DoABC#2)
// onListItemClicked = "_-VM" (String#23464, DoABC#2)
// highlightItem = "_-15O" (String#16670, DoABC#2)
// removeItem = "_-2gu" (String#6888, DoABC#2)


