
package com.sulake.habbo.avatar.hotlooks
{
    import com.sulake.habbo.avatar.common.CategoryBaseModel;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryModel;
    import flash.utils.Dictionary;
    import com.sulake.habbo.avatar.figuredata.FigureData;
    import com.sulake.habbo.avatar.HabboAvatarEditor;
    import com.sulake.habbo.avatar.wardrobe.Outfit;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import com.sulake.core.assets.XmlAsset;
    import flash.events.Event;
    import com.sulake.habbo.avatar.common.CategoryData;
    import com.sulake.habbo.avatar.wardrobe.*;

    public class HotLooksModel extends CategoryBaseModel implements IAvatarEditorCategoryModel 
    {

        public static const _SafeStr_4840:String = "hot_looks";
        public static const _SafeStr_4841:String = "my_looks";

        private var _SafeStr_4842:Dictionary;

        public function HotLooksModel(_arg_1:HabboAvatarEditor)
        {
            super(_arg_1);
            this._SafeStr_4842 = new Dictionary();
            this._SafeStr_4842[FigureData.M] = new Array();
            this._SafeStr_4842[FigureData.FEMALE] = new Array();
            this._SafeStr_4842[(FigureData.M + ".index")] = 0;
            this._SafeStr_4842[(FigureData.FEMALE + ".index")] = 0;
            this.requestHotLooks();
        }
        override public function dispose():void
        {
            super.dispose();
            this._SafeStr_4842 = null;
        }
        override protected function init():void
        {
            if (!_view){
                _view = new HotLooksView(this, controller.manager.windowManager, controller.manager.assets);
            };
            _view.init();
            _isInitialized = true;
        }
        public function selectHotLook(_arg_1:int):void
        {
            var _local_2:Array = this._SafeStr_4842[_controller.gender];
            var _local_3:Outfit = _local_2[_arg_1];
            if (_local_3 != null){
                if (_local_3.figure == ""){
                    return;
                };
                _controller.loadAvatarInEditor(_local_3.figure, _local_3.gender, _controller.clubMemberLevel);
            };
        }
        public function get hotLooks():Array
        {
            return (this._SafeStr_4842[_controller.gender]);
        }
        private function requestHotLooks():void
        {
            var _local_1:String = _controller.manager.configuration.getKey("avatareditor.promohabbos");
            var _local_2:URLRequest = new URLRequest(_local_1);
            var _local_3:AssetLoaderStruct = _controller.manager.assets.loadAssetFromFile("hotLooksConfiguration", _local_2, "text/xml");
            _local_3.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.onHotLooksConfiguration);
        }
        private function onHotLooksConfiguration(_arg_1:Event=null):void
        {
            var _local_4:XML;
            var _local_5:XML;
            var _local_6:Outfit;
            var _local_2:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            if (_local_2 == null){
                return;
            };
            var _local_3:XmlAsset = (_controller.manager.assets.getAssetByName("hotLooksConfiguration") as XmlAsset);
            if (_local_3 != null){
                _local_4 = (_local_3.content as XML);
                for each (_local_5 in _local_4.habbo) {
                    _local_6 = new Outfit(_controller, _local_5.@figure, _local_5.@gender);
                    (this._SafeStr_4842[_local_6.gender] as Array).push(_local_6);
                };
            }
            else {
                Logger.log("Could not retrieve Hot Looks from the server.");
            };
        }
        override public function switchCategory(_arg_1:String):void
        {
        }
        override public function getCategoryData(_arg_1:String):CategoryData
        {
            return (null);
        }
        override public function _SafeStr_4847(_arg_1:String, _arg_2:int):void
        {
        }

    }
}//package com.sulake.habbo.avatar.hotlooks

// FigureData = "_-1BT" (String#836, DoABC#2)
// IAvatarEditorCategoryModel = "_-1mx" (String#5798, DoABC#2)
// CategoryBaseModel = "_-N4" (String#8146, DoABC#2)
// CategoryData = "_-2jI" (String#6943, DoABC#2)
// HotLooksView = "_-K1" (String#8084, DoABC#2)
// _controller = "_-18D" (String#59, DoABC#2)
// hotLooks = "_-2aX" (String#20465, DoABC#2)
// selectHotLook = "_-2PP" (String#20019, DoABC#2)
// _SafeStr_4840 = "_-1e" (String#18058, DoABC#2)
// _SafeStr_4841 = "_-2UC" (String#20207, DoABC#2)
// _SafeStr_4842 = "_-2fc" (String#20675, DoABC#2)
// M = "_-1c3" (String#17974, DoABC#2)
// requestHotLooks = "_-1zW" (String#18948, DoABC#2)
// onHotLooksConfiguration = "_-1x0" (String#18847, DoABC#2)
// getCategoryData = "_-2rW" (String#7114, DoABC#2)
// _SafeStr_4847 = "continue" (String#9328, DoABC#2)
// AssetLoaderStruct = "_-0R2" (String#4112, DoABC#2)


