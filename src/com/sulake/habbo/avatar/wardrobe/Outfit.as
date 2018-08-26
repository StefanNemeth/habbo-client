
package com.sulake.habbo.avatar.wardrobe
{
    import com.sulake.habbo.avatar.IOutfit;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.avatar.HabboAvatarEditor;
    import com.sulake.habbo.avatar.figuredata.FigureData;
    import flash.display.BitmapData;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.avatar.enum.AvatarSetType;

    public class Outfit implements IOutfit, IAvatarImageListener 
    {

        private var _controller:HabboAvatarEditor;
        private var _figure:String;
        private var _gender:String;
        private var _view:OutfitView;
        private var _disposed:Boolean;

        public function Outfit(_arg_1:HabboAvatarEditor, _arg_2:String, _arg_3:String)
        {
            this._controller = _arg_1;
            this._view = new OutfitView(_arg_1.manager.windowManager, _arg_1.manager.assets, !((_arg_2 == "")));
            switch (_arg_3){
                case FigureData.M:
                case "m":
                case "M":
                    _arg_3 = FigureData.M;
                    break;
                case FigureData.FEMALE:
                case "f":
                case "F":
                    _arg_3 = FigureData.FEMALE;
                    break;
            };
            this._figure = _arg_2;
            this._gender = _arg_3;
            this.update();
        }
        public function dispose():void
        {
            if (this._view){
                this._view.dispose();
                this._view = null;
            };
            this._figure = null;
            this._gender = null;
            this._disposed = true;
            this._controller = null;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function update():void
        {
            var _local_2:BitmapData;
            var _local_1:IAvatarImage = this._controller.manager.avatarRenderManager.createAvatarImage(this.figure, AvatarScaleType._SafeStr_4337, this._gender, this);
            if (_local_1){
                _local_1.setDirection(AvatarSetType._SafeStr_4457, int(FigureData.4));
                _local_2 = _local_1.TwinkleImages(AvatarSetType._SafeStr_4457, true);
                if (this._view){
                    this._view.udpate(_local_2);
                };
                _local_1.dispose();
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
        public function get view():OutfitView
        {
            return (this._view);
        }
        public function avatarImageReady(_arg_1:String):void
        {
            this.update();
        }

    }
}//package com.sulake.habbo.avatar.wardrobe

// AvatarScaleType = "_-2lF" (String#20893, DoABC#2)
// FigureData = "_-1BT" (String#836, DoABC#2)
// IOutfit = "_-058" (String#3668, DoABC#2)
// OutfitView = "_-06R" (String#3691, DoABC#2)
// _gender = "_-a0" (String#95, DoABC#2)
// _controller = "_-18D" (String#59, DoABC#2)
// _figure = "_-20u" (String#75, DoABC#2)
// _SafeStr_4337 = "_-1dF" (String#18025, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// _SafeStr_4457 = "_-2mY" (String#20943, DoABC#2)
// TwinkleImages = "_-eg" (String#2150, DoABC#2)
// M = "_-1c3" (String#17974, DoABC#2)
// avatarImageReady = "_-i" (String#8553, DoABC#2)
// IAvatarImageListener = "_-06N" (String#3688, DoABC#2)
// 4 = "_-2P4" (String#20005, DoABC#2)
// udpate = "_-Rw" (String#23322, DoABC#2)


