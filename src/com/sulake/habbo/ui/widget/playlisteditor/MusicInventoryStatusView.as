
package com.sulake.habbo.ui.widget.playlisteditor
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.components.ITextWindow;
    import flash.display.BitmapData;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import com.sulake.core.assets.BitmapDataAsset;

    public class MusicInventoryStatusView 
    {

        public static const MISV_BUY_MORE:String = "MISV_BUY_MORE";
        public static const MISV_PREVIEW_PLAYING:String = "MISV_PREVIEW_PLAYING";

        private var _container:IWindowContainer;
        private var _SafeStr_6738:Map;
        private var _widget:PlayListEditorWidget;
        private var _SafeStr_3864:String;
        private var _SafeStr_6762:ITextWindow;
        private var _SafeStr_6763:ITextWindow;

        public function MusicInventoryStatusView(_arg_1:PlayListEditorWidget, _arg_2:IWindowContainer)
        {
            this._SafeStr_6738 = new Map();
            super();
            this._container = _arg_2;
            this._widget = _arg_1;
            this.createWindows();
            this.hide();
        }
        public function destroy():void
        {
            var _local_1:IWindowContainer;
            for each (_local_1 in this._SafeStr_6738.getValues()) {
                _local_1.destroy();
            };
            this._SafeStr_6738 = null;
        }
        public function show():void
        {
            this._container.visible = true;
        }
        public function hide():void
        {
            this._container.visible = false;
        }
        public function selectView(_arg_1:String):void
        {
            this._container.removeChildAt(0);
            this._container.addChildAt((this._SafeStr_6738[_arg_1] as IWindowContainer), 0);
            this._SafeStr_3864 = _arg_1;
        }
        public function set songName(_arg_1:String):void
        {
            if (this._SafeStr_6762 == null){
                return;
            };
            this._SafeStr_6762.text = _arg_1;
        }
        public function set authorName(_arg_1:String):void
        {
            if (this._SafeStr_6763 == null){
                return;
            };
            this._SafeStr_6763.text = _arg_1;
        }
        public function setPreviewPlayingBackgroundImage(_arg_1:BitmapData, _arg_2:Boolean=true):void
        {
            this.blitBackgroundImage(MISV_PREVIEW_PLAYING, "preview_play_background_image", _arg_1);
            if (((_arg_2) && (!((_arg_1 == null))))){
                _arg_1.dispose();
            };
        }
        public function setGetMoreMusicBackgroundImage(_arg_1:BitmapData, _arg_2:Boolean=true):void
        {
            this.blitBackgroundImage(MISV_BUY_MORE, "get_more_music_background_image", _arg_1);
            if (((_arg_2) && (!((_arg_1 == null))))){
                _arg_1.dispose();
            };
        }
        private function createWindows():void
        {
            var _local_1:IWindowContainer;
            var _local_2:XmlAsset;
            var _local_3:IButtonWindow;
            var _local_4:IButtonWindow;
            _local_2 = (this._widget.assets.getAssetByName("playlisteditor_inventory_subwindow_play_preview") as XmlAsset);
            _local_1 = (this._widget.windowManager.buildFromXML((_local_2.content as XML)) as IWindowContainer);
            if (_local_1 != null){
                this._SafeStr_6738.add(MISV_PREVIEW_PLAYING, _local_1);
                this._SafeStr_6762 = (_local_1.getChildByName("preview_play_track_name") as ITextWindow);
                this._SafeStr_6763 = (_local_1.getChildByName("preview_play_author_name") as ITextWindow);
                _local_3 = (_local_1.getChildByName("stop_preview_button") as IButtonWindow);
                _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onStopPreviewClicked);
                this.setPreviewPlayingBackgroundImage(this._widget.getImageGalleryAssetBitmap(PlayListEditorWidgetAssetsEnum._SafeStr_6689));
                this.assignAssetByNameToElement("jb_icon_disc", (_local_1.getChildByName("song_name_icon_bitmap") as IBitmapWrapperWindow));
                this.assignAssetByNameToElement("jb_icon_composer", (_local_1.getChildByName("author_name_icon_bitmap") as IBitmapWrapperWindow));
            };
            _local_2 = (this._widget.assets.getAssetByName("playlisteditor_inventory_subwindow_get_more_music") as XmlAsset);
            _local_1 = (this._widget.windowManager.buildFromXML((_local_2.content as XML)) as IWindowContainer);
            if (_local_1 != null){
                this._SafeStr_6738.add(MISV_BUY_MORE, _local_1);
                _local_4 = (_local_1.getChildByName("open_catalog_button") as IButtonWindow);
                _local_4.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onOpenCatalogButtonClicked);
                this.setGetMoreMusicBackgroundImage(this._widget.getImageGalleryAssetBitmap(PlayListEditorWidgetAssetsEnum._SafeStr_6690));
            };
        }
        private function blitBackgroundImage(_arg_1:String, _arg_2:String, _arg_3:BitmapData):void
        {
            var _local_6:BitmapData;
            var _local_4:IWindowContainer = (this._SafeStr_6738[_arg_1] as IWindowContainer);
            if (_local_4 == null){
                return;
            };
            var _local_5:IBitmapWrapperWindow = (_local_4.getChildByName(_arg_2) as IBitmapWrapperWindow);
            if (_local_5 == null){
                return;
            };
            if (_arg_3 != null){
                _local_6 = new BitmapData(_local_5.width, _local_5.height, false, 0xFFFFFFFF);
                _local_6.copyPixels(_arg_3, _arg_3.rect, new Point(0, 0));
                _local_5.bitmap = _local_6;
            };
        }
        private function assignAssetByNameToElement(_arg_1:String, _arg_2:IBitmapWrapperWindow):void
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
        private function onOpenCatalogButtonClicked(_arg_1:WindowMouseEvent):void
        {
            this._widget.openSongDiskShopCataloguePage();
        }
        private function onStopPreviewClicked(_arg_1:WindowMouseEvent):void
        {
            this._widget.stopUserSong();
        }

    }
}//package com.sulake.habbo.ui.widget.playlisteditor

// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// PlayListEditorWidget = "_-1O-" (String#5310, DoABC#2)
// PlayListEditorWidgetAssetsEnum = "_-0jk" (String#4497, DoABC#2)
// _SafeStr_3864 = "_-2-T" (String#446, DoABC#2)
// getValues = "_-2U9" (String#20205, DoABC#2)
// destroy = "_-25R" (String#615, DoABC#2)
// stopUserSong = "_-0qi" (String#16075, DoABC#2)
// getImageGalleryAssetBitmap = "_-0PQ" (String#15039, DoABC#2)
// openSongDiskShopCataloguePage = "_-0v8" (String#16242, DoABC#2)
// _SafeStr_6689 = "_-1Bz" (String#16940, DoABC#2)
// _SafeStr_6690 = "_-1DW" (String#17003, DoABC#2)
// setPreviewPlayingBackgroundImage = "_-2kT" (String#20863, DoABC#2)
// setGetMoreMusicBackgroundImage = "_-2ww" (String#21345, DoABC#2)
// selectView = "_-1-8" (String#1597, DoABC#2)
// MISV_PREVIEW_PLAYING = "_-1fR" (String#18115, DoABC#2)
// MISV_BUY_MORE = "_-1sd" (String#18660, DoABC#2)
// songName = "_-uT" (String#24469, DoABC#2)
// authorName = "_-1Y5" (String#5522, DoABC#2)
// _SafeStr_6738 = "_-ge" (String#8526, DoABC#2)
// createWindows = "_-1Lv" (String#5276, DoABC#2)
// assignAssetByNameToElement = "_-2Qz" (String#1879, DoABC#2)
// _SafeStr_6762 = "_-029" (String#14132, DoABC#2)
// _SafeStr_6763 = "_-0AS" (String#14465, DoABC#2)
// blitBackgroundImage = "_-Fn" (String#22843, DoABC#2)
// onStopPreviewClicked = "_-NW" (String#23146, DoABC#2)
// onOpenCatalogButtonClicked = "_-2wu" (String#21343, DoABC#2)


