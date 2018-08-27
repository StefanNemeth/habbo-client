
package com.sulake.habbo.ui.widget.playlisteditor
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IContainerButtonWindow;
    import flash.geom.ColorTransform;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.assets.XmlAsset;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.IBorderWindow;
    import com.sulake.core.window.components.ITextWindow;

    public class PlayListEditorItem 
    {

        public static const PLEI_ICON_STATE_NORMAL:String = "PLEI_ICON_STATE_NORMAL";
        public static const PLEI_ICON_STATE_PLAYING:String = "PLEI_ICON_STATE_PLAYING";
        private static const _SafeStr_6749:uint = 14283002;
        private static const _SafeStr_6750:uint = 0xF1F1F1;

        private var _widget:PlayListEditorWidget;
        private var _window:IWindowContainer;
        private var _removeButton:IContainerButtonWindow = null;
        private var _colorTransform:ColorTransform;

        public function PlayListEditorItem(_arg_1:PlayListEditorWidget, _arg_2:String, _arg_3:String, _arg_4:ColorTransform)
        {
            this._widget = _arg_1;
            this._colorTransform = _arg_4;
            this.createWindow();
            this.setIconState(PLEI_ICON_STATE_NORMAL);
            this.deselect();
            this.trackName = _arg_2;
            this.trackAuthor = _arg_3;
            this.diskColor = _arg_4;
        }
        public function get window():IWindow
        {
            return ((this._window as IWindow));
        }
        public function get removeButton():IContainerButtonWindow
        {
            return (this._removeButton);
        }
        private function createWindow():void
        {
            var _local_2:BitmapDataAsset;
            if (this._widget == null){
                return;
            };
            var _local_1:XmlAsset = (this._widget.assets.getAssetByName("playlisteditor_playlist_item") as XmlAsset);
            this._window = (this._widget.windowManager.buildFromXML((_local_1.content as XML)) as IWindowContainer);
            if (this._window == null){
                throw (new Error("Failed to construct window from XML!"));
            };
            _local_2 = (this._widget.assets.getAssetByName("icon_arrow_left") as BitmapDataAsset);
            if (_local_2 != null){
                if (_local_2.content != null){
                    this.buttonRemoveBitmap = (_local_2.content as BitmapData);
                };
            };
            this.assignAssetByNameToElement("jb_icon_disc", (this._window.getChildByName("song_name_icon_bitmap") as IBitmapWrapperWindow));
            this.assignAssetByNameToElement("jb_icon_composer", (this._window.getChildByName("author_name_icon_bitmap") as IBitmapWrapperWindow));
            var _local_3:IWindowContainer = (this._window.getChildByName("action_buttons") as IWindowContainer);
            if (_local_3 != null){
                _local_3 = (_local_3.getChildByName("button_border") as IWindowContainer);
                if (_local_3 != null){
                    this._removeButton = (_local_3.getChildByName("button_remove_from_playlist") as IContainerButtonWindow);
                };
            };
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
        public function deselect():void
        {
            var _local_1:IBorderWindow = (this._window.getChildByName("background") as IBorderWindow);
            if (_local_1 != null){
                _local_1.color = _SafeStr_6750;
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
        public function setIconState(_arg_1:String):void
        {
            var _local_2:BitmapDataAsset;
            var _local_3:BitmapData;
            switch (_arg_1){
                case PLEI_ICON_STATE_NORMAL:
                    this.diskColor = this._colorTransform;
                    return;
                case PLEI_ICON_STATE_PLAYING:
                    _local_2 = (this._widget.assets.getAssetByName("icon_notes_small") as BitmapDataAsset);
                    if (_local_2 == null){
                        return;
                    };
                    if (_local_2.content != null){
                        _local_3 = (_local_2.content as BitmapData);
                        this.diskIconBitmap = _local_3.clone();
                    };
                    return;
            };
        }
        public function set diskColor(_arg_1:ColorTransform):void
        {
            var _local_3:BitmapData;
            var _local_4:BitmapData;
            var _local_2:BitmapDataAsset = (this._widget.assets.getAssetByName("icon_cd_small") as BitmapDataAsset);
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
        public function set trackName(_arg_1:String):void
        {
            var _local_2:ITextWindow = (this._window.getChildByName("song_title_text") as ITextWindow);
            if (_local_2 != null){
                _local_2.text = _arg_1;
            };
        }
        public function set trackAuthor(_arg_1:String):void
        {
            var _local_2:ITextWindow = (this._window.getChildByName("song_author_text") as ITextWindow);
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
        private function set buttonRemoveBitmap(_arg_1:BitmapData):void
        {
            if (_arg_1 == null){
                return;
            };
            var _local_2:IWindowContainer = (this._window.getChildByName("action_buttons") as IWindowContainer);
            if (_local_2 == null){
                return;
            };
            _local_2 = (_local_2.getChildByName("button_border") as IWindowContainer);
            if (_local_2 == null){
                return;
            };
            _local_2 = (_local_2.getChildByName("button_remove_from_playlist") as IWindowContainer);
            if (_local_2 == null){
                return;
            };
            var _local_3:IBitmapWrapperWindow = (_local_2.getChildByName("button_remove_from_playlist_image") as IBitmapWrapperWindow);
            if (_local_3 != null){
                _local_3.bitmap = _arg_1.clone();
                _local_3.width = _arg_1.width;
                _local_3.height = _arg_1.height;
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

    }
}//package com.sulake.habbo.ui.widget.playlisteditor

// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// IBorderWindow = "_-0Br" (String#1422, DoABC#2)
// IContainerButtonWindow = "_-0UF" (String#1484, DoABC#2)
// PlayListEditorWidget = "_-1O-" (String#5310, DoABC#2)
// PlayListEditorItem = "_-01c" (String#3594, DoABC#2)
// _colorTransform = "_-0yf" (String#300, DoABC#2)
// deselect = "_-05I" (String#3671, DoABC#2)
// removeButton = "_-3Fh" (String#22105, DoABC#2)
// setIconState = "_-so" (String#24393, DoABC#2)
// PLEI_ICON_STATE_NORMAL = "_-0xa" (String#16336, DoABC#2)
// PLEI_ICON_STATE_PLAYING = "_-0K7" (String#14848, DoABC#2)
// _SafeStr_6749 = "_-3Gw" (String#7646, DoABC#2)
// _SafeStr_6750 = "_-0L4" (String#3980, DoABC#2)
// trackName = "_-25h" (String#6154, DoABC#2)
// diskColor = "_-0QW" (String#15082, DoABC#2)
// assignAssetByNameToElement = "_-2Qz" (String#1879, DoABC#2)
// diskIconBitmap = "_-08e" (String#3731, DoABC#2)
// _removeButton = "_-1-e" (String#4861, DoABC#2)
// trackAuthor = "_-2VW" (String#20263, DoABC#2)
// buttonRemoveBitmap = "_-2a8" (String#20447, DoABC#2)


