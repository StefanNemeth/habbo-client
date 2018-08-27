
package com.sulake.habbo.avatar.wardrobe
{
    import com.sulake.habbo.avatar.IOutfit;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.avatar.HabboAvatarEditor;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.avatar.figuredata.FigureData;
    import com.sulake.core.assets.XmlAsset;
    import flash.display.BitmapData;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import flash.geom.Matrix;
    import com.sulake.core.window.components.IContainerButtonWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class WardrobeSlot implements IOutfit, IAvatarImageListener 
    {

        private var _controller:HabboAvatarEditor;
        private var _figure:String;
        private var _gender:String;
        private var _isEnabled:Boolean;
        private var _view:IWindowContainer;
        private var _SafeStr_8524:IBitmapWrapperWindow;
        private var _slotId:int;
        private var _disposed:Boolean;

        public function WardrobeSlot(_arg_1:HabboAvatarEditor, _arg_2:int, _arg_3:Boolean, _arg_4:String=null, _arg_5:String=null)
        {
            this._controller = _arg_1;
            this._slotId = _arg_2;
            this.createView();
            this.update(_arg_4, _arg_5, _arg_3);
        }
        public function get id():int
        {
            return (this._slotId);
        }
        public function update(_arg_1:String, _arg_2:String, _arg_3:Boolean):void
        {
            switch (_arg_2){
                case FigureData.M:
                case "m":
                case "M":
                    _arg_2 = FigureData.M;
                    break;
                case FigureData.FEMALE:
                case "f":
                case "F":
                    _arg_2 = FigureData.FEMALE;
                    break;
            };
            this._figure = _arg_1;
            this._gender = _arg_2;
            this._isEnabled = _arg_3;
            this.updateView();
        }
        private function createView():void
        {
            var _local_1:XmlAsset = (this._controller.manager.assets.getAssetByName("wardrobe_slot") as XmlAsset);
            if (!_local_1){
                return;
            };
            this._view = (this._controller.manager.windowManager.buildFromXML((_local_1.content as XML)) as IWindowContainer);
            this._view.procedure = this.eventHandler;
            this._view.visible = false;
            this._SafeStr_8524 = (this._view.findChildByName("image") as IBitmapWrapperWindow);
        }
        public function dispose():void
        {
            this._controller = null;
            this._figure = null;
            this._gender = null;
            this._SafeStr_8524 = null;
            if (this._view){
                this._view.dispose();
                this._view = null;
            };
            this._disposed = true;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function updateView():void
        {
            var _local_1:BitmapData;
            var _local_5:IAvatarImage;
            var _local_6:BitmapDataAsset;
            var _local_7:int;
            var _local_8:int;
            var _local_2:Boolean = true;
            if (((this._figure) && (this._isEnabled))){
                _local_5 = this._controller.manager.avatarRenderManager.createAvatarImage(this.figure, AvatarScaleType._SafeStr_4337, this._gender, this);
                if (_local_5){
                    _local_5.setDirection(AvatarSetType._SafeStr_4457, parseInt(FigureData.4));
                    _local_1 = _local_5.getCroppedImage(AvatarSetType._SafeStr_4457);
                    _local_5.dispose();
                };
            }
            else {
                _local_6 = (this._controller.manager.assets.getAssetByName("wardrobe_empty_slot") as BitmapDataAsset);
                if (_local_6){
                    _local_1 = (_local_6.content as BitmapData);
                    _local_2 = false;
                };
            };
            if (!_local_1){
                return;
            };
            if (this._SafeStr_8524){
                if (this._SafeStr_8524.bitmap){
                    this._SafeStr_8524.bitmap.dispose();
                };
                this._SafeStr_8524.bitmap = new BitmapData(this._SafeStr_8524.width, this._SafeStr_8524.height, true, 0);
                _local_7 = ((this._SafeStr_8524.width - _local_1.width) / 2);
                _local_8 = ((this._SafeStr_8524.height - _local_1.height) / 2);
                this._SafeStr_8524.bitmap.draw(_local_1, new Matrix(1, 0, 0, 1, _local_7, _local_8));
            };
            if (_local_2){
                _local_1.dispose();
            };
            var _local_3:IContainerButtonWindow = (this._view.findChildByName("set_button") as IContainerButtonWindow);
            if (_local_3){
                _local_3.visible = this._isEnabled;
            };
            var _local_4:IContainerButtonWindow = (this._view.findChildByName("get_button") as IContainerButtonWindow);
            if (_local_4){
                _local_4.visible = ((this._isEnabled) && (!((this._figure == null))));
            };
        }
        private function eventHandler(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            switch (_arg_2.name){
                case "set_button":
                    this._figure = this._controller.figureData.getFigureString();
                    this._gender = this._controller.gender;
                    this._controller.handler.saveWardrobeOutfit(this._slotId, this);
                    this.updateView();
                    return;
                case "get_button":
                    if (this._figure){
                        this._controller.loadAvatarInEditor(this._figure, this._gender, this._controller.clubMemberLevel);
                    };
                    return;
            };
        }
        public function get figure():String
        {
            return (this._figure);
        }
        public function get gender():String
        {
            return (this._gender);
        }
        public function get view():IWindowContainer
        {
            return (this._view);
        }
        public function avatarImageReady(_arg_1:String):void
        {
            this.updateView();
        }

    }
}//package com.sulake.habbo.avatar.wardrobe

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// AvatarScaleType = "_-2lF" (String#20893, DoABC#2)
// IContainerButtonWindow = "_-0UF" (String#1484, DoABC#2)
// FigureData = "_-1BT" (String#836, DoABC#2)
// IOutfit = "_-058" (String#3668, DoABC#2)
// WardrobeSlot = "_-2qz" (String#21120, DoABC#2)
// _gender = "_-a0" (String#95, DoABC#2)
// _controller = "_-18D" (String#59, DoABC#2)
// _figure = "_-20u" (String#75, DoABC#2)
// handler = "_-06s" (String#1404, DoABC#2)
// eventHandler = "_-34P" (String#217, DoABC#2)
// _SafeStr_4337 = "_-1dF" (String#18025, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// _SafeStr_4457 = "_-2mY" (String#20943, DoABC#2)
// M = "_-1c3" (String#17974, DoABC#2)
// getCroppedImage = "_-2Ez" (String#6342, DoABC#2)
// avatarImageReady = "_-i" (String#8553, DoABC#2)
// _isEnabled = "_-2au" (String#895, DoABC#2)
// updateView = "_-1Js" (String#847, DoABC#2)
// _slotId = "_-34j" (String#911, DoABC#2)
// IAvatarImageListener = "_-06N" (String#3688, DoABC#2)
// _SafeStr_8524 = "_-24S" (String#19198, DoABC#2)
// 4 = "_-2P4" (String#20005, DoABC#2)
// getFigureString = "_-0-z" (String#3563, DoABC#2)
// saveWardrobeOutfit = "_-2TF" (String#20173, DoABC#2)


