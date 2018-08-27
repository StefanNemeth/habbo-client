
package com.sulake.habbo.avatar.wardrobe
{
    import com.sulake.habbo.avatar.common.ISideContentView;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.assets.XmlAsset;

    public class WardrobeView implements ISideContentView 
    {

        private var _window:IWindowContainer;
        private var _SafeStr_4830:WardrobeModel;
        private var _SafeStr_8528:IItemListWindow;
        private var _SafeStr_8529:IItemListWindow;

        public function WardrobeView(_arg_1:WardrobeModel)
        {
            this._SafeStr_4830 = _arg_1;
            var _local_2:XmlAsset = (this._SafeStr_4830.controller.manager.assets.getAssetByName("avatareditor_wardrobe_base") as XmlAsset);
            this._window = (this._SafeStr_4830.controller.manager.windowManager.buildFromXML((_local_2.content as XML)) as IWindowContainer);
            this._SafeStr_8528 = (this._window.findChildByName("hc_slots") as IItemListWindow);
            this._SafeStr_8529 = (this._window.findChildByName("vip_slots") as IItemListWindow);
            this._window.visible = false;
            this.update();
        }
        public function dispose():void
        {
            this._SafeStr_4830 = null;
            this._SafeStr_8528 = null;
            if (this._window){
                this._window.dispose();
                this._window = null;
            };
        }
        public function update():void
        {
            var _local_2:WardrobeSlot;
            if (this._SafeStr_8528){
                this._SafeStr_8528.removeListItems();
            };
            if (this._SafeStr_8529){
                this._SafeStr_8529.removeListItems();
            };
            var _local_1:Array = this._SafeStr_4830.slots;
            var _local_3:int;
            while (_local_3 < _local_1.length) {
                _local_2 = _local_1[_local_3];
                if (_local_3 < 5){
                    if (this._SafeStr_8528){
                        this._SafeStr_8528.addListItem(_local_2.view);
                        _local_2.view.visible = true;
                    };
                }
                else {
                    if (this._SafeStr_8529){
                        this._SafeStr_8529.addListItem(_local_2.view);
                        _local_2.view.visible = true;
                    };
                };
                _local_3++;
            };
        }
        public function getWindowContainer():IWindowContainer
        {
            return (this._window);
        }

    }
}//package com.sulake.habbo.avatar.wardrobe

// ISideContentView = "_-1Yh" (String#5537, DoABC#2)
// WardrobeSlot = "_-2qz" (String#21120, DoABC#2)
// WardrobeView = "_-2RH" (String#6589, DoABC#2)
// _SafeStr_4830 = "_-0XB" (String#112, DoABC#2)
// getWindowContainer = "_-v8" (String#313, DoABC#2)
// removeListItems = "_-aG" (String#8425, DoABC#2)
// _SafeStr_8528 = "_-2KP" (String#19818, DoABC#2)
// _SafeStr_8529 = "_-1G8" (String#17120, DoABC#2)
// slots = "_-07U" (String#14344, DoABC#2)


