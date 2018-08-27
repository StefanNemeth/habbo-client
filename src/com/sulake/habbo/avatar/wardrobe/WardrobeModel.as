
package com.sulake.habbo.avatar.wardrobe
{
    import com.sulake.habbo.avatar.common.ISideContentModel;
    import com.sulake.habbo.avatar.HabboAvatarEditor;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.avatar.OutfitData;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.habbo.session.HabboClubLevelEnum;

    public class WardrobeModel implements ISideContentModel 
    {

        private var _controller:HabboAvatarEditor;
        private var _view:WardrobeView;
        private var _SafeStr_8532:Map;
        private var _isInitialized:Boolean = false;

        public function WardrobeModel(_arg_1:HabboAvatarEditor)
        {
            this._controller = _arg_1;
        }
        public function dispose():void
        {
            var _local_1:WardrobeSlot;
            this._controller = null;
            for each (_local_1 in this._SafeStr_8532) {
                _local_1.dispose();
                _local_1 = null;
            };
            this._SafeStr_8532 = null;
            if (this._view){
                this._view.dispose();
                this._view = null;
            };
            this._isInitialized = false;
        }
        public function reset():void
        {
            this._isInitialized = false;
        }
        private function init():void
        {
            var _local_2:WardrobeSlot;
            if (this._controller.handler != null){
                this._controller.handler.getWardrobe();
            };
            if (this._SafeStr_8532){
                for each (_local_2 in this._SafeStr_8532) {
                    _local_2.dispose();
                    _local_2 = null;
                };
            };
            this._SafeStr_8532 = new Map();
            var _local_1:int = 1;
            while (_local_1 <= 10) {
                this._SafeStr_8532.add(_local_1, new WardrobeSlot(this._controller, _local_1, this.isSlotEnabled(_local_1)));
                _local_1++;
            };
            if (this._view){
                this._view.dispose();
            };
            this._view = new WardrobeView(this);
            this._isInitialized = true;
            this.updateView();
        }
        public function get controller():HabboAvatarEditor
        {
            return (this._controller);
        }
        public function getWindowContainer():IWindowContainer
        {
            if (!this._isInitialized){
                this.init();
            };
            return (this._view.getWindowContainer());
        }
        public function updateView():void
        {
            this._view.update();
        }
        public function updateSlots(_arg_1:int, _arg_2:Array):void
        {
            var _local_3:WardrobeSlot;
            var _local_4:OutfitData;
            if (!this._isInitialized){
                return;
            };
            if (!_arg_2){
                ErrorReportStorage.addDebugData("WardrobeModel", "updateSlots: outfits is null!");
            };
            if (!this._SafeStr_8532){
                ErrorReportStorage.addDebugData("WardrobeModel", "updateSlots: _slots is null!");
            };
            for each (_local_4 in _arg_2) {
                _local_3 = (this._SafeStr_8532.getValue(_local_4.slotId) as WardrobeSlot);
                if (_local_3){
                    _local_3.update(_local_4.figureString, _local_4.gender, this.isSlotEnabled(_local_3.id));
                };
            };
        }
        private function isSlotEnabled(_arg_1:int):Boolean
        {
            if (_arg_1 <= 5){
                return (this._controller.manager.sessionData.hasUserRight("fuse_use_wardrobe", HabboClubLevelEnum._SafeStr_3943));
            };
            return (this._controller.manager.sessionData.hasUserRight("fuse_larger_wardrobe", HabboClubLevelEnum._SafeStr_3939));
        }
        public function get slots():Array
        {
            return (this._SafeStr_8532.getValues());
        }

    }
}//package com.sulake.habbo.avatar.wardrobe

// HabboClubLevelEnum = "_-1ZP" (String#17867, DoABC#2)
// ISideContentModel = "_-29F" (String#6234, DoABC#2)
// WardrobeSlot = "_-2qz" (String#21120, DoABC#2)
// WardrobeView = "_-2RH" (String#6589, DoABC#2)
// OutfitData = "_-3Q" (String#7734, DoABC#2)
// figureString = "_-P1" (String#23207, DoABC#2)
// _controller = "_-18D" (String#59, DoABC#2)
// handler = "_-06s" (String#1404, DoABC#2)
// _SafeStr_3939 = "_-2gR" (String#20706, DoABC#2)
// _SafeStr_3943 = "_-xn" (String#24604, DoABC#2)
// sessionData = "_-3Fb" (String#22101, DoABC#2)
// addDebugData = "_-04r" (String#14235, DoABC#2)
// getWindowContainer = "_-v8" (String#313, DoABC#2)
// getValues = "_-2U9" (String#20205, DoABC#2)
// updateView = "_-1Js" (String#847, DoABC#2)
// ErrorReportStorage = "_-Yg" (String#8387, DoABC#2)
// slots = "_-07U" (String#14344, DoABC#2)
// _SafeStr_8532 = "_-2Oc" (String#19989, DoABC#2)
// getWardrobe = "_-1jT" (String#18264, DoABC#2)
// isSlotEnabled = "_-1DC" (String#16990, DoABC#2)
// updateSlots = "_-1Dr" (String#5140, DoABC#2)


