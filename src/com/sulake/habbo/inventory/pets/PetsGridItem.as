
package com.sulake.habbo.inventory.pets
{
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetData;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class PetsGridItem 
    {

        private static const _SafeStr_8489:int = 0xCCCCCC;
        private static const _hasUnseenItems:int = 10275685;

        private var _petData:PetData;
        private var _window:IWindowContainer;
        private var _SafeStr_8491:IWindow;
        private var _SafeStr_8492:IWindow;
        private var _isSelected:Boolean;
        private var _SafeStr_8493:PetsView;
        private var _SafeStr_8494:Boolean;
        private var _SafeStr_8495:Boolean;

        public function PetsGridItem(_arg_1:PetsView, _arg_2:PetData, _arg_3:IHabboWindowManager, _arg_4:IAssetLibrary, _arg_5:IAvatarRenderManager, _arg_6:Boolean)
        {
            if ((((((((((_arg_1 == null)) || ((_arg_2 == null)))) || ((_arg_3 == null)))) || ((_arg_4 == null)))) || ((_arg_5 == null)))){
                return;
            };
            this._SafeStr_8493 = _arg_1;
            this._petData = _arg_2;
            this._SafeStr_8495 = _arg_6;
            var _local_7:XmlAsset = (_arg_4.getAssetByName("inventory_thumb_xml") as XmlAsset);
            if ((((_local_7 == null)) || ((_local_7.content == null)))){
                return;
            };
            this._window = (_arg_3.buildFromXML((_local_7.content as XML)) as IWindowContainer);
            this._SafeStr_8491 = this._window.findChildByTag("BG_COLOR");
            this._SafeStr_8492 = this._window.findChildByName("outline");
            var _local_8:BitmapDataAsset = (_arg_4.getAssetByName("thumb_selected_outline_png") as BitmapDataAsset);
            var _local_9:IBitmapWrapperWindow = (this._window.findChildByName("outline") as IBitmapWrapperWindow);
            _local_9.bitmap = (_local_8.content as BitmapData);
            _local_9.disposesBitmap = false;
            this._window.procedure = this.eventHandler;
            var _local_10:BitmapData = _arg_1.getPetImage(_arg_2.type, _arg_2.breed, _arg_2.color, 3, false);
            var _local_11:IBitmapWrapperWindow = (this._window.findChildByName("bitmap") as IBitmapWrapperWindow);
            var _local_12:BitmapData = new BitmapData(_local_11.width, _local_11.height);
            _local_12.fillRect(_local_12.rect, 0);
            _local_12.copyPixels(_local_10, _local_10.rect, new Point(((_local_12.width / 2) - (_local_10.width / 2)), ((_local_12.height / 2) - (_local_10.height / 2))));
            _local_11.bitmap = _local_12;
            this.setSelected(false);
        }
        private function eventHandler(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            switch (_arg_1.type){
                case WindowMouseEvent.WME_DOWN:
                    this._SafeStr_8493.setSelectedGridItem(this);
                    this._SafeStr_8494 = true;
                    return;
                case WindowMouseEvent.WME_UP:
                    this._SafeStr_8494 = false;
                    return;
                case WindowMouseEvent.WME_OUT:
                    if (this._SafeStr_8494){
                        this._SafeStr_8494 = false;
                        this._SafeStr_8493.placePetToRoom(this._petData.id, true);
                    };
                    return;
            };
        }
        public function setSelected(_arg_1:Boolean):void
        {
            this._isSelected = _arg_1;
            if (((!(this._window)) || (!(this._SafeStr_8491)))){
                return;
            };
            this._SafeStr_8491.color = ((this._SafeStr_8495) ? _hasUnseenItems : _SafeStr_8489);
            this._SafeStr_8492.visible = _arg_1;
        }
        public function dispose():void
        {
            this._SafeStr_8493 = null;
            this._petData = null;
            this._SafeStr_8491 = null;
            if (this._window != null){
                this._window.dispose();
                this._window = null;
            };
        }
        public function get window():IWindow
        {
            return (this._window);
        }
        public function get pet():PetData
        {
            return (this._petData);
        }

    }
}//package com.sulake.habbo.inventory.pets

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// PetData = "_-01G" (String#1387, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// PetsView = "_-N0" (String#8143, DoABC#2)
// PetsGridItem = "_-2O2" (String#6523, DoABC#2)
// eventHandler = "_-34P" (String#217, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// WME_DOWN = "_-hL" (String#23944, DoABC#2)
// WME_UP = "_-0Cs" (String#14566, DoABC#2)
// IAvatarRenderManager = "_-C9" (String#7915, DoABC#2)
// disposesBitmap = "_-03U" (String#3637, DoABC#2)
// getPetImage = "_-0Zc" (String#437, DoABC#2)
// placePetToRoom = "_-2hx" (String#20770, DoABC#2)
// setSelectedGridItem = "_-2eW" (String#20626, DoABC#2)
// _SafeStr_8489 = "_-1YT" (String#1708, DoABC#2)
// _hasUnseenItems = "_-ZF" (String#2132, DoABC#2)
// _SafeStr_8491 = "_-2y0" (String#903, DoABC#2)
// _SafeStr_8492 = "_-zz" (String#2236, DoABC#2)
// _SafeStr_8493 = "_-1GL" (String#17128, DoABC#2)
// _SafeStr_8494 = "_-mF" (String#24119, DoABC#2)
// _SafeStr_8495 = "_-2vp" (String#7196, DoABC#2)


