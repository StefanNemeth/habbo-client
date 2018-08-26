
package com.sulake.habbo.ui.widget.infostand
{
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.ui.widget.events.RoomWidgetFurniInfoUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetSongUpdateEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.IBorderWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetInfostandExtraParamEnum;

    public class InfoStandSongDiskView extends InfoStandFurniView 
    {

        private var _songId:int = -1;

        public function InfoStandSongDiskView(_arg_1:InfostandWidget, _arg_2:String, _arg_3:IHabboCatalog)
        {
            super(_arg_1, _arg_2, _arg_3);
        }
        override public function dispose():void
        {
            super.dispose();
        }
        override public function update(_arg_1:RoomWidgetFurniInfoUpdateEvent):void
        {
            super.update(_arg_1);
            this._songId = this.InfoStandSongDiskView(_arg_1.extraParam);
        }
        public function InfoStandJukeboxView(_arg_1:RoomWidgetSongUpdateEvent):void
        {
            if ((((_arg_1.type == RoomWidgetSongUpdateEvent.RWSUE_DATA_RECEIVED)) && ((_arg_1.songId == this._songId)))){
                this.trackName = _arg_1.songName;
                this.authorName = _arg_1.songAuthor;
            };
        }
        override protected function createWindow(_arg_1:String):void
        {
            var _local_4:IWindow;
            var _local_5:BitmapDataAsset;
            var _local_6:BitmapData;
            var _local_9:int;
            var _local_2:XmlAsset = (_widget.assets.getAssetByName("songdisk_view") as XmlAsset);
            _window = (_widget.windowManager.buildFromXML((_local_2.content as XML)) as IItemListWindow);
            if (_window == null){
                throw (new Error("Failed to construct window from XML!"));
            };
            _border = (_window.getListItemByName("info_border") as IBorderWindow);
            _buttons = (_window.getListItemByName("button_list") as IItemListWindow);
            if (_border != null){
                _SafeStr_13990 = (_border.findChildByName("infostand_element_list") as IItemListWindow);
            };
            _window.name = _arg_1;
            _widget.mainContainer.addChild(_window);
            var _local_3:IWindow = _border.findChildByTag("close");
            if (_local_3 != null){
                _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, PollOfferDialog);
            };
            if (_buttons != null){
                _local_9 = 0;
                while (_local_9 < _buttons.numListItems) {
                    _local_4 = _buttons.getListItemAt(_local_9);
                    _local_4.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, InfoStandUserView);
                    _local_9++;
                };
            };
            _SafeStr_14009 = _border.findChildByTag("catalog");
            if (_SafeStr_14009 != null){
                _SafeStr_14009.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, InfoStandFurniView);
            };
            var _local_7:IBitmapWrapperWindow = (_border.findChildByName("icon_disc") as IBitmapWrapperWindow);
            if (_local_7 != null){
                _local_5 = (_widget.assets.getAssetByName("jb_icon_disc") as BitmapDataAsset);
                _local_6 = (_local_5.content as BitmapData);
                _local_7.bitmap = _local_6.clone();
            };
            var _local_8:IBitmapWrapperWindow = (_border.findChildByName("icon_composer") as IBitmapWrapperWindow);
            if (_local_8 != null){
                _local_5 = (_widget.assets.getAssetByName("jb_icon_composer") as BitmapDataAsset);
                _local_6 = (_local_5.content as BitmapData);
                _local_8.bitmap = _local_6.clone();
            };
        }
        private function set trackName(_arg_1:String):void
        {
            var _local_2:IWindowContainer = (_SafeStr_13990.getListItemByName("trackname_container") as IWindowContainer);
            if (_local_2 == null){
                return;
            };
            var _local_3:ITextWindow = (_local_2.getChildByName("track_name_text") as ITextWindow);
            if (_local_3 == null){
                return;
            };
            _local_3.text = _arg_1;
            _local_3.visible = true;
            _local_3.height = (_local_3.textHeight + 5);
            InfoStandUserView();
        }
        private function set authorName(_arg_1:String):void
        {
            var _local_2:IWindowContainer = (_SafeStr_13990.getListItemByName("creatorname_container") as IWindowContainer);
            if (_local_2 == null){
                return;
            };
            var _local_3:ITextWindow = (_local_2.getChildByName("track_creator_text") as ITextWindow);
            if (_local_3 == null){
                return;
            };
            _local_3.text = _arg_1;
            _local_3.visible = true;
            _local_3.height = (_local_3.textHeight + 5);
            InfoStandUserView();
        }
        private function InfoStandSongDiskView(_arg_1:String):int
        {
            var _local_2:String;
            if (_arg_1 != null){
                _local_2 = _arg_1.substr(RoomWidgetInfostandExtraParamEnum.RWEIEP_SONGDISK.length, _arg_1.length);
                return (parseInt(_local_2));
            };
            return (-1);
        }

    }
}//package com.sulake.habbo.ui.widget.infostand

// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// _border = "_-0NB" (String#815, DoABC#2)
// songAuthor = "_-0Jg" (String#14829, DoABC#2)
// _SafeStr_13990 = "_-38U" (String#2009, DoABC#2)
// _SafeStr_14009 = "_-ST" (String#23345, DoABC#2)
// InfoStandFurniView = "_-TK" (String#23378, DoABC#2)
// InfoStandSongDiskView = "_-1yP" (String#18905, DoABC#2)
// InfoStandJukeboxView = "_-oi" (String#24223, DoABC#2)
// IBorderWindow = "_-0Br" (String#1422, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// RoomWidgetInfostandExtraParamEnum = "_-2ru" (String#7121, DoABC#2)
// InfoStandFurniView = "_-1e5" (String#5631, DoABC#2)
// InfoStandSongDiskView = "_-03l" (String#3641, DoABC#2)
// RoomWidgetFurniInfoUpdateEvent = "_-1V1" (String#5455, DoABC#2)
// RoomWidgetSongUpdateEvent = "_-0rz" (String#16120, DoABC#2)
// InfoStandUserView = "_-2k0" (String#247, DoABC#2)
// RWEIEP_SONGDISK = "_-0eV" (String#15606, DoABC#2)
// extraParam = "_-AM" (String#7874, DoABC#2)
// PollOfferDialog = "_-2Ts" (String#54, DoABC#2)
// _songId = "_-0a-" (String#241, DoABC#2)
// songName = "_-uT" (String#24469, DoABC#2)
// authorName = "_-1Y5" (String#5522, DoABC#2)
// songId = "_-2fw" (String#20688, DoABC#2)
// trackName = "_-25h" (String#6154, DoABC#2)
// InfoStandUserView = "_-2s1" (String#451, DoABC#2)
// RWSUE_DATA_RECEIVED = "_-0BQ" (String#14503, DoABC#2)


