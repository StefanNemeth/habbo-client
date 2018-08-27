
package com.sulake.habbo.room.object.visualization.pet
{
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.IPetImageListener;
    import com.sulake.core.assets.IAsset;

    public class PetVisualizationData implements IRoomObjectVisualizationData 
    {

        private var _avatarRenderer:IAvatarRenderManager = null;

        public function get avatarRenderer():IAvatarRenderManager
        {
            return (this._avatarRenderer);
        }
        public function set avatarRenderer(_arg_1:IAvatarRenderManager):void
        {
            this._avatarRenderer = _arg_1;
        }
        public function initialize(_arg_1:XML):Boolean
        {
            return (true);
        }
        public function dispose():void
        {
            this._avatarRenderer = null;
        }
        public function getAvatar(_arg_1:String, _arg_2:Number, _arg_3:IPetImageListener):IAvatarImage
        {
            var _local_4:IAvatarImage;
            if (this._avatarRenderer != null){
                _local_4 = null;
                if (_arg_2 > 48){
                    _local_4 = this._avatarRenderer.createPetImageFromFigure(_arg_1, AvatarScaleType._SafeStr_4336, _arg_3);
                }
                else {
                    _local_4 = this._avatarRenderer.createPetImageFromFigure(_arg_1, AvatarScaleType._SafeStr_4337, _arg_3);
                };
                return (_local_4);
            };
            return (null);
        }
        public function getLayerCount(_arg_1:String):Number
        {
            return (0);
        }
        public function getAvatarRendererAsset(_arg_1:String):IAsset
        {
            if (this._avatarRenderer == null){
                return (null);
            };
            return (this._avatarRenderer.assets.getAssetByName(_arg_1));
        }

    }
}//package com.sulake.habbo.room.object.visualization.pet

// AvatarScaleType = "_-2lF" (String#20893, DoABC#2)
// IRoomObjectVisualizationData = "_-26A" (String#6167, DoABC#2)
// PetVisualizationData = "_-l7" (String#8627, DoABC#2)
// avatarRenderer = "_-Jv" (String#23003, DoABC#2)
// getAvatar = "_-1el" (String#18089, DoABC#2)
// createPetImageFromFigure = "_-0Sk" (String#4153, DoABC#2)
// _SafeStr_4336 = "_-1wM" (String#18815, DoABC#2)
// _SafeStr_4337 = "_-1dF" (String#18025, DoABC#2)
// getLayerCount = "_-0wW" (String#16290, DoABC#2)
// getAvatarRendererAsset = "_-0Zg" (String#15430, DoABC#2)
// IAvatarRenderManager = "_-C9" (String#7915, DoABC#2)


