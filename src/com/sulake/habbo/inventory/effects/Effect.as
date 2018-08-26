
package com.sulake.habbo.inventory.effects
{
    import com.sulake.habbo.ui.widget.memenu.IWidgetAvatarEffect;
    import com.sulake.habbo.inventory.common.IThumbListDrawableItem;
    import flash.display.BitmapData;

    public class Effect implements IWidgetAvatarEffect, IThumbListDrawableItem 
    {

        private var _type:int;
        private var _duration:int;
        private var _effectsInInventory:int = 1;
        private var _secondsLeft:int;
        private var _isActive:Boolean = false;
        private var _isSelected:Boolean = false;
        private var _isInUse:Boolean = false;
        private var _iconImage:BitmapData;
        private var _SafeStr_8116:Date;

        public function get type():int
        {
            return (this._type);
        }
        public function get duration():int
        {
            return (this._duration);
        }
        public function get effectsInInventory():int
        {
            return (this._effectsInInventory);
        }
        public function get isActive():Boolean
        {
            return (this._isActive);
        }
        public function get isInUse():Boolean
        {
            return (this._isInUse);
        }
        public function get isSelected():Boolean
        {
            return (this._isSelected);
        }
        public function get icon():BitmapData
        {
            return (this._iconImage);
        }
        public function get iconImage():BitmapData
        {
            return (this._iconImage);
        }
        public function get secondsLeft():int
        {
            var _local_1:int;
            if (this._isActive){
                _local_1 = (this._secondsLeft - ((new Date().valueOf() - this._SafeStr_8116.valueOf()) / 1000));
                _local_1 = Math.floor(_local_1);
                if (_local_1 < 0){
                    _local_1 = 0;
                };
                return (_local_1);
            };
            return (this._secondsLeft);
        }
        public function set type(_arg_1:int):void
        {
            this._type = _arg_1;
        }
        public function set duration(_arg_1:int):void
        {
            this._duration = _arg_1;
        }
        public function set secondsLeft(_arg_1:int):void
        {
            this._secondsLeft = _arg_1;
        }
        public function set isSelected(_arg_1:Boolean):void
        {
            this._isSelected = _arg_1;
        }
        public function set isInUse(_arg_1:Boolean):void
        {
            this._isInUse = _arg_1;
        }
        public function set iconImage(_arg_1:BitmapData):void
        {
            this._iconImage = _arg_1;
        }
        public function set effectsInInventory(_arg_1:int):void
        {
            this._effectsInInventory = _arg_1;
        }
        public function set isActive(_arg_1:Boolean):void
        {
            if (((_arg_1) && (!(this._isActive)))){
                this._SafeStr_8116 = new Date();
            };
            this._isActive = _arg_1;
        }
        public function setOneEffectExpired():void
        {
            this._effectsInInventory--;
            if (this._effectsInInventory < 0){
                this._effectsInInventory = 0;
            };
            this._secondsLeft = this._duration;
            this._isActive = false;
            this._isInUse = false;
        }

    }
}//package com.sulake.habbo.inventory.effects

// IThumbListDrawableItem = "_-Sg" (String#8260, DoABC#2)
// IWidgetAvatarEffect = "_-uw" (String#8782, DoABC#2)
// Effect = "_-0Ka" (String#14863, DoABC#2)
// _isActive = "_-Aj" (String#929, DoABC#2)
// isInUse = "_-2LN" (String#6469, DoABC#2)
// effectsInInventory = "_-0U0" (String#4183, DoABC#2)
// secondsLeft = "_-I-" (String#8040, DoABC#2)
// isActive = "_-0q4" (String#4638, DoABC#2)
// iconImage = "_-0Pn" (String#4088, DoABC#2)
// _duration = "_-1OY" (String#606, DoABC#2)
// setOneEffectExpired = "_-c8" (String#23720, DoABC#2)
// _effectsInInventory = "_-19-" (String#16817, DoABC#2)
// _secondsLeft = "_-0dR" (String#15563, DoABC#2)
// _isInUse = "_-Zn" (String#8413, DoABC#2)
// _iconImage = "_-bc" (String#2138, DoABC#2)
// _SafeStr_8116 = "_-1no" (String#18452, DoABC#2)


