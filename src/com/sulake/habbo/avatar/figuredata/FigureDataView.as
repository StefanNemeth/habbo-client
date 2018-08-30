
package com.sulake.habbo.avatar.figuredata
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.geom.Point;

    public class FigureDataView 
    {

        private var _windowManager:IHabboWindowManager;
        private var _assetLibrary:IAssetLibrary;
        private var _window:IWindowContainer;
        private var _imageContainer:IBitmapWrapperWindow;
        private var _SafeStr_10016:BitmapData;

        public function FigureDataView(_arg_1:IHabboWindowManager, _arg_2:IAssetLibrary)
        {
            this._assetLibrary = _arg_2;
            this._windowManager = _arg_1;
            var _local_3:XmlAsset = (this._assetLibrary.getAssetByName("AvatarEditorImage") as XmlAsset);
            if (_local_3){
                this._window = IWindowContainer(this._windowManager.buildFromXML((_local_3.content as XML)));
            };
            var _local_4:BitmapDataAsset = (this._assetLibrary.getAssetByName("platform") as BitmapDataAsset);
            if (_local_4){
                this._SafeStr_10016 = (_local_4.content as BitmapData);
            };
            if (this._window != null){
                this._imageContainer = (this._window.findChildByName("bitmap") as IBitmapWrapperWindow);
            };
        }
        public function udpate(_arg_1:BitmapData):void
        {
            if (((this._imageContainer) && (this._SafeStr_10016))){
                this._imageContainer.bitmap = new BitmapData(this._imageContainer.width, this._imageContainer.height, true, 0xFFFFFF);
                this._imageContainer.bitmap.copyPixels(this._SafeStr_10016, this._SafeStr_10016.rect, new Point(0, ((this._imageContainer.height - this._SafeStr_10016.height) - 8)));
                this._imageContainer.bitmap.copyPixels(_arg_1, _arg_1.rect, new Point(4, 0), null, null, true);
            };
        }
        public function get window():IWindowContainer
        {
            return (this._window);
        }

    }
}//package com.sulake.habbo.avatar.figuredata

// _SafeStr_10016 = "_-0um" (String#16228, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// _imageContainer = "_-3AP" (String#2014, DoABC#2)
// udpate = "_-Rw" (String#23322, DoABC#2)


