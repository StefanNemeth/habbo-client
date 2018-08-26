
package com.sulake.habbo.avatar.alias
{
    import com.sulake.core.assets.AssetLibraryCollection;
    import flash.utils.Dictionary;
    import com.sulake.habbo.avatar.AvatarRenderManager;
    import com.sulake.core.assets.IAsset;

    public class AssetAliasCollection 
    {

        private var _assets:AssetLibraryCollection;
        private var _SafeStr_3791:Dictionary;
        private var _avatarRenderManager:AvatarRenderManager;

        public function AssetAliasCollection(_arg_1:AvatarRenderManager, _arg_2:AssetLibraryCollection)
        {
            this._avatarRenderManager = _arg_1;
            this._SafeStr_3791 = new Dictionary();
            this._assets = _arg_2;
        }
        public function dispose():void
        {
            this._assets = null;
            this._SafeStr_3791 = null;
        }
        public function reset():void
        {
            this.init();
        }
        public function init():void
        {
            var _local_2:XML;
            var _local_3:XML;
            var _local_4:String;
            var _local_5:AssetAlias;
            var _local_1:Array = this._assets.getManifests();
            for each (_local_2 in _local_1) {
                for each (_local_3 in _local_2.library.aliases.alias) {
                    _local_4 = String(_local_3.@name);
                    _local_5 = new AssetAlias(_local_3);
                    this._SafeStr_3791[_local_4] = _local_5;
                };
            };
        }
        public function addAlias(_arg_1:String, _arg_2:String, _arg_3:Boolean=false, _arg_4:Boolean=false):void
        {
            var _local_5:XML = <alias name="" link="" fliph="0" flipv="0"/>
            ;
            _local_5.@name = _arg_1;
            _local_5.@link = _arg_2;
            var _local_6:AssetAlias = new AssetAlias(_local_5);
            this._SafeStr_3791[_arg_1] = _local_6;
        }
        public function hasAlias(_arg_1:String):Boolean
        {
            var _local_2:AssetAlias = (this._SafeStr_3791[_arg_1] as AssetAlias);
            return (!((_local_2 == null)));
        }
        public function getAliasByName(_arg_1:String):AssetAlias
        {
            return ((this._SafeStr_3791[_arg_1] as AssetAlias));
        }
        public function getAssetByName(_arg_1:String):IAsset
        {
            var _local_4:AssetAlias;
            var _local_2:int = 5;
            while (((this.hasAlias(_arg_1)) && ((_local_2 >= 0)))) {
                _local_4 = (this._SafeStr_3791[_arg_1] as AssetAlias);
                _arg_1 = _local_4.link;
                _local_2--;
            };
            return (this._assets.getAssetByName(_arg_1));
        }

    }
}//package com.sulake.habbo.avatar.alias

// AssetLibraryCollection = "_-2Pg" (String#6555, DoABC#2)
// AssetAlias = "_-1G3" (String#5171, DoABC#2)
// _SafeStr_3791 = "_-Xm" (String#8363, DoABC#2)
// _avatarRenderManager = "_-2uU" (String#454, DoABC#2)
// getManifests = "_-0hi" (String#15736, DoABC#2)
// addAlias = "_-10l" (String#16490, DoABC#2)
// hasAlias = "_-bZ" (String#23695, DoABC#2)
// getAliasByName = "_-Dr" (String#22764, DoABC#2)


