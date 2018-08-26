
package com.sulake.habbo.avatar.cache
{
    import flash.utils.Dictionary;
    import com.sulake.habbo.avatar.AvatarImageBodyPartContainer;
    import com.sulake.habbo.avatar.AvatarImagePartContainer;

    public class AvatarImageDirectionCache 
    {

        private var _SafeStr_7988:Array;
        private var _images:Dictionary;

        public function AvatarImageDirectionCache(_arg_1:Array)
        {
            this._images = new Dictionary();
            this._SafeStr_7988 = _arg_1;
        }
        public function dispose():void
        {
            var _local_1:AvatarImageBodyPartContainer;
            for each (_local_1 in this._images) {
                if (_local_1){
                    _local_1.dispose();
                };
            };
            this._images = null;
        }
        public function getPartList():Array
        {
            return (this._SafeStr_7988);
        }
        public function getImageContainer(_arg_1:int):AvatarImageBodyPartContainer
        {
            var _local_2:String = this.getCacheKey(_arg_1);
            return (this._images[_local_2]);
        }
        public function updateImageContainer(_arg_1:AvatarImageBodyPartContainer, _arg_2:int):void
        {
            var _local_4:AvatarImageBodyPartContainer;
            var _local_3:String = this.getCacheKey(_arg_2);
            if (this._images[_local_3]){
                _local_4 = (this._images[_local_3] as AvatarImageBodyPartContainer);
                if (_local_4){
                    _local_4.dispose();
                };
            };
            this._images[_local_3] = _arg_1;
        }
        private function getCacheKey(_arg_1:int):String
        {
            var _local_3:AvatarImagePartContainer;
            var _local_2:String = "";
            for each (_local_3 in this._SafeStr_7988) {
                _local_2 = ((((_local_2 + _local_3.partId) + ":") + _local_3.AnimationFrameSequenceData(_arg_1)) + "/");
            };
            return (_local_2);
        }
        private function debugInfo(_arg_1:String):void
        {
        }

    }
}//package com.sulake.habbo.avatar.cache

// AvatarImagePartContainer = "_-39w" (String#7510, DoABC#2)
// AvatarImageBodyPartContainer = "_-Mm" (String#8137, DoABC#2)
// AvatarImageDirectionCache = "_-Qp" (String#8223, DoABC#2)
// getImageContainer = "_-3EQ" (String#22052, DoABC#2)
// getPartList = "_-0Rg" (String#15127, DoABC#2)
// updateImageContainer = "_-0ya" (String#16377, DoABC#2)
// partId = "_-0hk" (String#15738, DoABC#2)
// AnimationFrameSequenceData = "_-38K" (String#21816, DoABC#2)
// debugInfo = "_-3g" (String#924, DoABC#2)
// _SafeStr_7988 = "_-2wX" (String#21328, DoABC#2)
// getCacheKey = "_-UG" (String#23419, DoABC#2)


