
package com.sulake.habbo.inventory.effects
{
    import com.sulake.habbo.inventory.common.IThumbListDataProvider;

    public class EffectListProxy implements IThumbListDataProvider 
    {

        private var _SafeStr_4830:EffectsModel;
        private var _SafeStr_6615:int;

        public function EffectListProxy(_arg_1:EffectsModel, _arg_2:int)
        {
            this._SafeStr_4830 = _arg_1;
            this._SafeStr_6615 = _arg_2;
        }
        public function dispose():void
        {
            this._SafeStr_4830 = null;
        }
        public function getDrawableList():Array
        {
            return (this._SafeStr_4830.EffectsModel(this._SafeStr_6615));
        }

    }
}//package com.sulake.habbo.inventory.effects

// EffectsModel = "_-ja" (String#8589, DoABC#2)
// IThumbListDataProvider = "_-2SK" (String#6616, DoABC#2)
// EffectListProxy = "_-35e" (String#7422, DoABC#2)
// _SafeStr_4830 = "_-0XB" (String#112, DoABC#2)
// getDrawableList = "_-1QO" (String#5357, DoABC#2)
// _SafeStr_6615 = "_-3Aj" (String#915, DoABC#2)
// EffectsModel = "_-1VO" (String#17714, DoABC#2)


