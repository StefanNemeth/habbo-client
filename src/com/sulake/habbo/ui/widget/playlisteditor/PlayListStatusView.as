
package com.sulake.habbo.ui.widget.playlisteditor
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.components.IContainerButtonWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.assets.BitmapDataAsset;

    public class PlayListStatusView 
    {

        public static const PLSV_ADD_SONGS:String = "PLSV_ADD_SONGS";
        public static const PLSV_START_PLAYBACK:String = "PLSV_START_PLAYBACK";
        public static const PLSV_NOW_PLAYING:String = "PLSV_NOW_PLAYING";

        private var _container:IWindowContainer;
        private var _SafeStr_6738:Map;
        private var _widget:PlayListEditorWidget;
        private var _SafeStr_3864:String;

        public function PlayListStatusView(_arg_1:PlayListEditorWidget, _arg_2:IWindowContainer)
        {
            this._SafeStr_6738 = new Map();
            super();
            this._container = _arg_2;
            this._widget = _arg_1;
            this.createWindows();
        }
        public function destroy():void
        {
            var _local_1:IWindowContainer;
            for each (_local_1 in this._SafeStr_6738.getValues()) {
                _local_1.destroy();
            };
            this._SafeStr_6738 = null;
        }
        public function selectView(_arg_1:String):void
        {
            this._container.removeChildAt(0);
            this._container.addChildAt((this._SafeStr_6738[_arg_1] as IWindowContainer), 0);
            this._SafeStr_3864 = _arg_1;
        }
        public function set nowPlayingTrackName(_arg_1:String):void
        {
            if (this._SafeStr_3864 != PLSV_NOW_PLAYING){
                return;
            };
            var _local_2:IWindowContainer = this._SafeStr_6738[this._SafeStr_3864];
            var _local_3:ITextWindow = (_local_2.getChildByName("now_playing_track_name") as ITextWindow);
            if (_local_3 != null){
                _local_3.text = _arg_1;
            };
        }
        public function set nowPlayingAuthorName(_arg_1:String):void
        {
            if (this._SafeStr_3864 != PLSV_NOW_PLAYING){
                return;
            };
            var _local_2:IWindowContainer = this._SafeStr_6738[this._SafeStr_3864];
            var _local_3:ITextWindow = (_local_2.getChildByName("now_playing_author_name") as ITextWindow);
            if (_local_3 != null){
                _local_3.text = _arg_1;
            };
        }
        public function set addSongsBackgroundImage(_arg_1:BitmapData):void
        {
            if (_arg_1 == null){
                return;
            };
            var _local_2:IWindowContainer = this._SafeStr_6738[PLSV_ADD_SONGS];
            if (_local_2 == null){
                return;
            };
            var _local_3:IBitmapWrapperWindow = (_local_2.getChildByName("background_image") as IBitmapWrapperWindow);
            if (_local_3 == null){
                return;
            };
            _local_3.bitmap = _arg_1.clone();
            _local_3.width = _arg_1.width;
            _local_3.height = _arg_1.height;
        }
        private function createWindows():void
        {
            var _local_1:IWindowContainer;
            var _local_2:XmlAsset;
            var _local_3:IButtonWindow;
            var _local_4:IContainerButtonWindow;
            _local_2 = (this._widget.assets.getAssetByName("playlisteditor_playlist_subwindow_add_songs") as XmlAsset);
            _local_1 = (this._widget.windowManager.buildFromXML((_local_2.content as XML)) as IWindowContainer);
            if (_local_1 != null){
                this._SafeStr_6738.add(PLSV_ADD_SONGS, _local_1);
            };
            _local_2 = (this._widget.assets.getAssetByName("playlisteditor_playlist_subwindow_play_now") as XmlAsset);
            _local_1 = (this._widget.windowManager.buildFromXML((_local_2.content as XML)) as IWindowContainer);
            if (_local_1 != null){
                this._SafeStr_6738.add(PLSV_START_PLAYBACK, _local_1);
                _local_3 = (_local_1.getChildByName("play_now_button") as IButtonWindow);
                _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onPlayPauseClicked);
            };
            _local_2 = (this._widget.assets.getAssetByName("playlisteditor_playlist_subwindow_nowplaying") as XmlAsset);
            _local_1 = (this._widget.windowManager.buildFromXML((_local_2.content as XML)) as IWindowContainer);
            if (_local_1 != null){
                this._SafeStr_6738.add(PLSV_NOW_PLAYING, _local_1);
                _local_4 = (_local_1.getChildByName("button_pause") as IContainerButtonWindow);
                _local_4.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onPlayPauseClicked);
                this.assignAssetToElement("icon_pause_large", (_local_4.getChildByName("pause_image") as IBitmapWrapperWindow));
                this.assignAssetToElement("jb_icon_disc", (_local_1.getChildByName("song_name_icon_bitmap") as IBitmapWrapperWindow));
                this.assignAssetToElement("jb_icon_composer", (_local_1.getChildByName("author_name_icon_bitmap") as IBitmapWrapperWindow));
            };
        }
        private function assignAssetToElement(_arg_1:String, _arg_2:IBitmapWrapperWindow):void
        {
            var _local_4:BitmapData;
            var _local_3:BitmapDataAsset = (this._widget.assets.getAssetByName(_arg_1) as BitmapDataAsset);
            if (_local_3 != null){
                if (((!((_arg_2 == null))) && (!((_local_3.content == null))))){
                    _local_4 = (_local_3.content as BitmapData);
                    _arg_2.bitmap = _local_4.clone();
                };
            };
        }
        private function onPlayPauseClicked(_arg_1:WindowMouseEvent):void
        {
            this._widget.sendTogglePlayPauseStateMessage();
        }

    }
}//package com.sulake.habbo.ui.widget.playlisteditor

// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// IContainerButtonWindow = "_-0UF" (String#1484, DoABC#2)
// PlayListEditorWidget = "_-1O-" (String#5310, DoABC#2)
// PlayListStatusView = "_-1Nn" (String#5307, DoABC#2)
// _SafeStr_3864 = "_-2-T" (String#446, DoABC#2)
// getValues = "_-2U9" (String#20205, DoABC#2)
// destroy = "_-25R" (String#615, DoABC#2)
// sendTogglePlayPauseStateMessage = "_-0Z4" (String#15406, DoABC#2)
// addSongsBackgroundImage = "_-2Md" (String#19913, DoABC#2)
// selectView = "_-1-8" (String#1597, DoABC#2)
// PLSV_NOW_PLAYING = "_-2v5" (String#21282, DoABC#2)
// PLSV_START_PLAYBACK = "_-6p" (String#22492, DoABC#2)
// PLSV_ADD_SONGS = "_-0kO" (String#15845, DoABC#2)
// nowPlayingTrackName = "_-2VF" (String#6669, DoABC#2)
// nowPlayingAuthorName = "_-2zC" (String#7269, DoABC#2)
// _SafeStr_6738 = "_-ge" (String#8526, DoABC#2)
// createWindows = "_-1Lv" (String#5276, DoABC#2)
// onPlayPauseClicked = "_-0Bm" (String#14519, DoABC#2)
// assignAssetToElement = "_-0iz" (String#15790, DoABC#2)


