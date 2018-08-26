
package com.sulake.habbo.ui.widget.playlisteditor
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IContainerButtonWindow;
    import flash.geom.ColorTransform;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBorderWindow;
    import com.sulake.core.window.components.ITextWindow;

    public class MusicInventoryGridItem 
    {

        public static const _SafeStr_6732:int = 0;
        public static const _SafeStr_6731:int = 1;
        public static const _SafeStr_6736:int = 2;
        private static const _SafeStr_6749:uint = 14612159;
        private static const _MusicInventoryGridItem:uint = 0xF1F1F1;

        private var _widget:PlayListEditorWidget;
        private var _window:IWindowContainer = null;
        private var _diskId:int;
        private var _songId:int;
        private var _toPlayListButton:IContainerButtonWindow = null;
        private var _buttonState:int;

        public function MusicInventoryGridItem(_arg_1:PlayListEditorWidget, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:ColorTransform)
        {
            this._widget = _arg_1;
            this._diskId = _arg_2;
            this._songId = _arg_3;
            this.createWindow();
            this.ITab();
            if (((!((_arg_4 == null))) && (!((_arg_5 == null))))){
                this.trackName = _arg_4;
                this.diskColor = _arg_5;
            };
        }
        public function get window():IWindow
        {
            return ((this._window as IWindow));
        }
        public function get diskId():int
        {
            return (this._diskId);
        }
        public function get songId():int
        {
            return (this._songId);
        }
        public function get toPlayListButton():IContainerButtonWindow
        {
            return (this._toPlayListButton);
        }
        public function get playButtonState():int
        {
            return (this._buttonState);
        }
        public function update(_arg_1:int, _arg_2:String, _arg_3:ColorTransform):void
        {
            if (_arg_1 == this._songId){
                this.trackName = _arg_2;
                this.diskColor = _arg_3;
            };
        }
        public function destroy():void
        {
            if (this._window){
                this._window.destroy();
            };
        }
        private function createWindow():void
        {
            var _local_3:BitmapDataAsset;
            if (this._widget == null){
                return;
            };
            var _local_1:XmlAsset = (this._widget.assets.getAssetByName("playlisteditor_music_inventory_item") as XmlAsset);
            this._window = (this._widget.windowManager.buildFromXML((_local_1.content as XML)) as IWindowContainer);
            if (this._window == null){
                throw (new Error("Failed to construct window from XML!"));
            };
            var _local_2:IWindowContainer = (this._window.getChildByName("action_buttons") as IWindowContainer);
            if (_local_2 != null){
                this._toPlayListButton = (_local_2.getChildByName("button_to_playlist") as IContainerButtonWindow);
            };
            this.MusicInventoryStatusView("title_fader", (this._window.getChildByName("title_fader_bitmap") as IBitmapWrapperWindow));
            _local_3 = (this._widget.assets.getAssetByName("icon_arrow") as BitmapDataAsset);
            if (_local_3 != null){
                if (_local_3.content != null){
                    this.buttonToPlaylistBitmap = (_local_3.content as BitmapData);
                };
            };
            this.playButtonState = _SafeStr_6732;
        }
        public function select():void
        {
            var _local_1:IBorderWindow = (this._window.getChildByName("background") as IBorderWindow);
            if (_local_1 != null){
                _local_1.color = _SafeStr_6749;
            };
            var _local_2:IWindowContainer = (this._window.getChildByName("action_buttons") as IWindowContainer);
            if (_local_2 != null){
                _local_2.visible = true;
            };
            var _local_3:IBorderWindow = (this._window.getChildByName("selected") as IBorderWindow);
            if (_local_3 != null){
                _local_3.visible = true;
            };
        }
        public function ITab():void
        {
            var _local_1:IBorderWindow = (this._window.getChildByName("background") as IBorderWindow);
            if (_local_1 != null){
                _local_1.color = _MusicInventoryGridItem;
            };
            var _local_2:IWindowContainer = (this._window.getChildByName("action_buttons") as IWindowContainer);
            if (_local_2 != null){
                _local_2.visible = false;
            };
            var _local_3:IBorderWindow = (this._window.getChildByName("selected") as IBorderWindow);
            if (_local_3 != null){
                _local_3.visible = false;
            };
        }
        public function set diskColor(_arg_1:ColorTransform):void
        {
            var _local_3:BitmapData;
            var _local_4:BitmapData;
            var _local_2:BitmapDataAsset = (this._widget.assets.getAssetByName("icon_cd_big") as BitmapDataAsset);
            if (_local_2 == null){
                return;
            };
            if (_local_2.content != null){
                _local_3 = (_local_2.content as BitmapData);
                _local_4 = _local_3.clone();
                if (_local_4 != null){
                    _local_4.colorTransform(_local_3.rect, _arg_1);
                    this.diskIconBitmap = _local_4;
                };
            };
        }
        public function set playButtonState(_arg_1:int):void
        {
            var _local_2:BitmapDataAsset;
            if (_arg_1 == _SafeStr_6732){
                _local_2 = (this._widget.assets.getAssetByName("icon_play") as BitmapDataAsset);
            }
            else {
                if (_arg_1 == _SafeStr_6731){
                    _local_2 = (this._widget.assets.getAssetByName("icon_pause") as BitmapDataAsset);
                }
                else {
                    if (_arg_1 == _SafeStr_6736){
                        _local_2 = (this._widget.assets.getAssetByName("icon_download") as BitmapDataAsset);
                    };
                };
            };
            if (_local_2 != null){
                if (_local_2.content != null){
                    this.buttonPlayPauseBitmap = (_local_2.content as BitmapData);
                };
            };
            this._buttonState = _arg_1;
        }
        public function set trackName(_arg_1:String):void
        {
            var _local_2:ITextWindow = (this._window.getChildByName("song_title_text") as ITextWindow);
            if (_local_2 != null){
                _local_2.text = _arg_1;
            };
        }
        private function set diskIconBitmap(_arg_1:BitmapData):void
        {
            var _local_2:IBitmapWrapperWindow = (this._window.getChildByName("disk_image") as IBitmapWrapperWindow);
            if (_local_2 != null){
                _local_2.bitmap = _arg_1;
            };
        }
        private function set buttonToPlaylistBitmap(_arg_1:BitmapData):void
        {
            this.MusicInventoryGridItem("button_to_playlist", "image_button_to_playlist", _arg_1);
        }
        private function set buttonPlayPauseBitmap(_arg_1:BitmapData):void
        {
            this.MusicInventoryGridItem("button_play_pause", "image_button_play_pause", _arg_1);
        }
        private function MusicInventoryGridItem(_arg_1:String, _arg_2:String, _arg_3:BitmapData):void
        {
            if (_arg_3 == null){
                return;
            };
            var _local_4:IWindowContainer = (this._window.getChildByName("action_buttons") as IWindowContainer);
            if (_local_4 == null){
                return;
            };
            _local_4 = (_local_4.getChildByName(_arg_1) as IWindowContainer);
            if (_local_4 == null){
                return;
            };
            var _local_5:IBitmapWrapperWindow = (_local_4.getChildByName(_arg_2) as IBitmapWrapperWindow);
            if (_local_5 != null){
                _local_5.bitmap = _arg_3.clone();
                _local_5.width = _arg_3.width;
                _local_5.height = _arg_3.height;
            };
        }
        private function MusicInventoryStatusView(_arg_1:String, _arg_2:IBitmapWrapperWindow):void
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

    }
}//package com.sulake.habbo.ui.widget.playlisteditor

// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// IBorderWindow = "_-0Br" (String#1422, DoABC#2)
// IContainerButtonWindow = "_-0UF" (String#1484, DoABC#2)
// PlayListEditorWidget = "_-1O-" (String#5310, DoABC#2)
// MusicInventoryGridItem = "_-Xw" (String#8369, DoABC#2)
// _diskId = "_-08o" (String#3736, DoABC#2)
// diskId = "_-0re" (String#4678, DoABC#2)
// _songId = "_-0a-" (String#241, DoABC#2)
// destroy = "_-25R" (String#615, DoABC#2)
// toPlayListButton = "_-Ig" (String#22953, DoABC#2)
// playButtonState = "_-2KU" (String#19821, DoABC#2)
// _SafeStr_6731 = "_-2I-" (String#19729, DoABC#2)
// _SafeStr_6732 = "_-0cw" (String#15547, DoABC#2)
// ITab = "_-05I" (String#3671, DoABC#2)
// _SafeStr_6736 = "_-1q4" (String#18546, DoABC#2)
// songId = "_-2fw" (String#20688, DoABC#2)
// _SafeStr_6749 = "_-3Gw" (String#7646, DoABC#2)
// _MusicInventoryGridItem = "_-0L4" (String#3980, DoABC#2)
// _toPlayListButton = "_-1ch" (String#17998, DoABC#2)
// trackName = "_-25h" (String#6154, DoABC#2)
// diskColor = "_-0QW" (String#15082, DoABC#2)
// MusicInventoryStatusView = "_-2Qz" (String#1879, DoABC#2)
// buttonToPlaylistBitmap = "_-32o" (String#21610, DoABC#2)
// diskIconBitmap = "_-08e" (String#3731, DoABC#2)
// buttonPlayPauseBitmap = "_-13a" (String#16601, DoABC#2)
// MusicInventoryGridItem = "_-0te" (String#16187, DoABC#2)


