
package com.sulake.habbo.ui.widget.infostand
{
    import com.sulake.habbo.catalog.IHabboCatalog;
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
    import com.sulake.habbo.ui.widget.events.RoomWidgetSongUpdateEvent;

    public class InfoStandJukeboxView extends InfoStandFurniView 
    {

        private var _songId:int = -1;
        private var _songName:String = "";
        private var _songAuthor:String = "";

        public function InfoStandJukeboxView(_arg_1:InfostandWidget, _arg_2:String, _arg_3:IHabboCatalog)
        {
            super(_arg_1, _arg_2, _arg_3);
        }
        override public function dispose():void
        {
            super.dispose();
        }
        override protected function createWindow(_arg_1:String):void
        {
            var _local_4:IWindow;
            var _local_5:BitmapDataAsset;
            var _local_6:BitmapData;
            var _local_9:int;
            var _local_2:XmlAsset = (_widget.assets.getAssetByName("jukebox_view") as XmlAsset);
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
                _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, onClose);
            };
            if (_buttons != null){
                _local_9 = 0;
                while (_local_9 < _buttons.numListItems) {
                    _local_4 = _buttons.getListItemAt(_local_9);
                    _local_4.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, onButtonClicked);
                    _local_9++;
                };
            };
            _SafeStr_14009 = _border.findChildByTag("catalog");
            if (_SafeStr_14009 != null){
                _SafeStr_14009.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, onCatalogButtonClicked);
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
        private function set nowPlayingTrackName(_arg_1:String):void
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
        }
        private function set nowPlayingAuthorName(_arg_1:String):void
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
        }
        public function updateSongInfo(_arg_1:RoomWidgetSongUpdateEvent):void
        {
            if (_arg_1.type == RoomWidgetSongUpdateEvent.RWSUE_PLAYING_CHANGED){
                this._songId = _arg_1.songId;
            };
            if (_arg_1.songId == this._songId){
                this._songName = _arg_1.songName;
                this._songAuthor = _arg_1.songAuthor;
                this.updateNowPlaying((this._songId >= 0));
            };
        }
        private function updateNowPlaying(_arg_1:Boolean):void
        {
            var _local_3:String;
            var _local_2:ITextWindow = (_SafeStr_13990.getListItemByName("now_playing_text") as ITextWindow);
            if (_local_2 != null){
                if (_arg_1){
                    _local_3 = _widget.localizations.getKey("infostand.jukebox.text.now.playing");
                }
                else {
                    _local_3 = _widget.localizations.getKey("infostand.jukebox.text.not.playing");
                };
                _local_2.text = _local_3;
            };
            if (_arg_1){
                this.nowPlayingTrackName = this._songName;
                this.nowPlayingAuthorName = this._songAuthor;
            }
            else {
                this.nowPlayingTrackName = "";
                this.nowPlayingAuthorName = "";
            };
            updateWindow();
        }

    }
}//package com.sulake.habbo.ui.widget.infostand

// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// _border = "_-0NB" (String#815, DoABC#2)
// _songAuthor = "_-36O" (String#7438, DoABC#2)
// songAuthor = "_-0Jg" (String#14829, DoABC#2)
// _SafeStr_13990 = "_-38U" (String#2009, DoABC#2)
// _SafeStr_14009 = "_-ST" (String#23345, DoABC#2)
// onCatalogButtonClicked = "_-TK" (String#23378, DoABC#2)
// updateSongInfo = "_-oi" (String#24223, DoABC#2)
// updateNowPlaying = "_-pL" (String#24247, DoABC#2)
// IBorderWindow = "_-0Br" (String#1422, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// InfoStandFurniView = "_-1e5" (String#5631, DoABC#2)
// InfoStandJukeboxView = "_-3Fa" (String#7621, DoABC#2)
// RoomWidgetSongUpdateEvent = "_-0rz" (String#16120, DoABC#2)
// onButtonClicked = "_-2k0" (String#247, DoABC#2)
// onClose = "_-2Ts" (String#54, DoABC#2)
// _songId = "_-0a-" (String#241, DoABC#2)
// nowPlayingTrackName = "_-2VF" (String#6669, DoABC#2)
// nowPlayingAuthorName = "_-2zC" (String#7269, DoABC#2)
// songName = "_-uT" (String#24469, DoABC#2)
// songId = "_-2fw" (String#20688, DoABC#2)
// updateWindow = "_-2s1" (String#451, DoABC#2)
// RWSUE_PLAYING_CHANGED = "_-3LG" (String#22337, DoABC#2)


