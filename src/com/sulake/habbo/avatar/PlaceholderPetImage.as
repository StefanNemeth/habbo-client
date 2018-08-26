
package com.sulake.habbo.avatar
{
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.utils.Map;
    import flash.display.BitmapData;
    import com.sulake.habbo.avatar.structure.AvatarCanvas;
    import com.sulake.habbo.avatar.alias.AssetAliasCollection;
    import flash.geom.Point;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;

    public class PlaceholderPetImage extends PetImage 
    {

        private var _assets:IAssetLibrary;
        private var _SafeStr_10103:Map;
        private var _image:BitmapData;

        public function PlaceholderPetImage(_arg_1:AvatarStructure, _arg_2:AssetAliasCollection, _arg_3:String, _arg_4:String, _arg_5:IAssetLibrary)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            this._assets = _arg_5;
            this._SafeStr_10103 = new Map();
            var _local_6:AvatarCanvas = _structure.getCanvas(_scale, _SafeStr_10078.definition.geometryType);
            if (_local_6){
                this._image = new BitmapData(_local_6.width, _local_6.height, true, 0xFFFFFF);
            };
        }
        override public function dispose():void
        {
            var _local_1:BitmapData;
            if (this._SafeStr_10103){
                for each (_local_1 in this._SafeStr_10103) {
                };
                this._SafeStr_10103.dispose();
                (this._SafeStr_10103 = null);
            };
            if (this._image){
                (this._image = null);
            };
            (this._assets = null);
            super.dispose();
        }
        override public function getCroppedImage(_arg_1:String):BitmapData
        {
            if (_disposed){
                return (null);
            };
            var _local_2:BitmapData = this.getPlaceHolderImage(_SafeStr_10077, _scale);
            if (!_local_2){
                return (null);
            };
            return (_local_2.clone());
        }
        override public function TwinkleImages(_arg_1:String, _arg_2:Boolean):BitmapData
        {
            if (_disposed){
                return (null);
            };
            var _local_3:BitmapData = this.getPlaceHolderImage(_SafeStr_10077, _scale);
            if (((!(_local_3)) || (!(this._image)))){
                return (null);
            };
            this._image.fillRect(this._image.rect, 0xFFFFFF);
            this._image.copyPixels(_local_3, _local_3.rect, new Point(((this._image.width - _local_3.width) / 2), (this._image.height - _local_3.height)), null, null, true);
            if (_arg_2){
                return (this._image.clone());
            };
            return (this._image);
        }
        private function getPlaceHolderImage(_arg_1:int, _arg_2:String):BitmapData
        {
            var _local_5:BitmapDataAsset;
            var _local_3:String = "pet_placeholder_";
            if (_arg_2 == AvatarScaleType._SafeStr_4337){
                _local_3 = (_local_3 + "s");
                _local_3;
            };
            _local_3 = (_local_3 + _arg_1.toString());
            _local_3;
            _local_3 = (_local_3 + "_png");
            _local_3;
            var _local_4:BitmapData = this._SafeStr_10103.getValue(_local_3);
            if (!_local_4){
                _local_5 = (this._assets.getAssetByName(_local_3) as BitmapDataAsset);
                _local_4 = (_local_5.content as BitmapData);
                _local_4;
                this._SafeStr_10103.add(_local_3, _local_4.clone());
                _local_4 = this._SafeStr_10103.getValue(_local_3);
                _local_4;
            };
            return (_local_4);
        }
        override public function IAvatarImage():Boolean
        {
            return (true);
        }

    }
}//package com.sulake.habbo.avatar

// _SafeStr_10077 = "_-2jr" (String#6951, DoABC#2)
// _SafeStr_10078 = "_-0hg" (String#4461, DoABC#2)
// _SafeStr_10103 = "_-1TU" (String#17644, DoABC#2)
// getPlaceHolderImage = "_-fO" (String#23863, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// AvatarScaleType = "_-2lF" (String#20893, DoABC#2)
// PetImage = "_-0in" (String#4477, DoABC#2)
// PlaceholderPetImage = "_-2mW" (String#7012, DoABC#2)
// AvatarStructure = "_-2PN" (String#6550, DoABC#2)
// AvatarCanvas = "_-1UP" (String#5441, DoABC#2)
// _SafeStr_4337 = "_-1dF" (String#18025, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// TwinkleImages = "_-eg" (String#2150, DoABC#2)
// _image = "_-35u" (String#78, DoABC#2)
// getCroppedImage = "_-2Ez" (String#6342, DoABC#2)
// IAvatarImage = "_-128" (String#4919, DoABC#2)


