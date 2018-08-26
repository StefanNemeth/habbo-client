
package com.sulake.habbo.navigator.mainview
{
    import com.sulake.habbo.navigator.IViewCtrl;
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.navigator.TagRenderer;
    import com.sulake.habbo.communication.messages.incoming.navigator.PopularTagData;
    import com.sulake.habbo.navigator.Util;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.*;
    import com.sulake.habbo.navigator.*;
    import com.sulake.core.window.events.*;
    import com.sulake.core.window.*;
    import com.sulake.core.window.enum.*;

    public class PopularTagsListCtrl implements IViewCtrl 
    {

        private var _navigator:HabboNavigator;
        private var _content:IWindowContainer;
        private var _content:IItemListWindow;
        private var _SafeStr_4205:int;
        private var _SafeStr_4206:TagRenderer;

        public function PopularTagsListCtrl(_arg_1:HabboNavigator):void
        {
            this._navigator = _arg_1;
            this._SafeStr_4206 = new TagRenderer(this._navigator);
        }
        public function dispose():void
        {
            if (this._SafeStr_4206){
                this._SafeStr_4206.dispose();
                this._SafeStr_4206 = null;
            };
        }
        public function set content(_arg_1:IWindowContainer):void
        {
            this._content = _arg_1;
            this._content = IItemListWindow(this._content.findChildByName("item_list"));
        }
        public function get content():IWindowContainer
        {
            return (this._content);
        }
        public function refresh():void
        {
            var _local_4:PopularTagData;
            var _local_1:Array = this._navigator.data.popularTags.tags;
            var _local_2:IWindowContainer = IWindowContainer(this._content.getListItemAt(0));
            if (_local_2 == null){
                _local_2 = IWindowContainer(this._navigator.getXmlWindow("grs_popular_tag_row"));
                this._content.addListItem(_local_2);
            };
            Util.InfostandWidget(_local_2);
            var _local_3:int;
            while (_local_3 < this._navigator.data.popularTags.tags.length) {
                _local_4 = this._navigator.data.popularTags.tags[_local_3];
                this._SafeStr_4206.refreshTag(_local_2, _local_3, _local_4.tagName);
                _local_3++;
            };
            Util.layoutChildrenInArea(_local_2, _local_2.width, 18, 3);
            _local_2.height = Util.getLowestPoint(_local_2);
            this._content.findChildByName("no_tags_found").visible = (_local_1.length < 1);
        }
        private function refreshTagName(_arg_1:IWindowContainer, _arg_2:PopularTagData):void
        {
            var _local_3:String = "txt";
            var _local_4:ITextWindow = ITextWindow(_arg_1.findChildByName(_local_3));
            if (_arg_2 == null){
                return;
            };
            _local_4.visible = true;
            _local_4.text = _arg_2.tagName;
        }

    }
}//package com.sulake.habbo.navigator.mainview

// Util = "_-1ve" (String#445, DoABC#2)
// IViewCtrl = "_-D9" (String#7935, DoABC#2)
// PopularTagsListCtrl = "_-0Ay" (String#3776, DoABC#2)
// TagRenderer = "_-35E" (String#7412, DoABC#2)
// PopularTagData = "_-2r2" (String#7100, DoABC#2)
// InfostandWidget = "_-14q" (String#1615, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// _content = "_-o4" (String#96, DoABC#2)
// _content = "_-1Q8" (String#74, DoABC#2)
// _SafeStr_4205 = "_-1Z5" (String#17855, DoABC#2)
// _SafeStr_4206 = "_-2ux" (String#901, DoABC#2)
// popularTags = "_-dQ" (String#23778, DoABC#2)
// refreshTag = "_-1-R" (String#16445, DoABC#2)
// tagName = "_-mQ" (String#24124, DoABC#2)
// layoutChildrenInArea = "_-0f9" (String#15635, DoABC#2)
// getLowestPoint = "_-0t0" (String#16161, DoABC#2)
// refreshTagName = "_-2Nd" (String#19950, DoABC#2)


