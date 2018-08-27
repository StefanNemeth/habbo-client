
package com.sulake.habbo.inventory.effects
{
    import com.sulake.habbo.inventory.IInventoryModel;
    import com.sulake.habbo.inventory.HabboInventory;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.habbo.communication.messages.outgoing.inventory.avatareffect.AvatarEffectActivatedComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.avatareffect.AvatarEffectSelectedComposer;
    import com.sulake.core.window.IWindowContainer;

    public class EffectsModel implements IInventoryModel 
    {

        private var _controller:HabboInventory;
        private var _view:EffectsView;
        private var _effects:Array;
        private var _assets:IAssetLibrary;
        private var _communication:IHabboCommunicationManager;
        private var _activeEffectsProxy:EffectListProxy;
        private var _inactiveEffectsProxy:EffectListProxy;
        private var _disposed:Boolean = false;

        public function EffectsModel(_arg_1:HabboInventory, _arg_2:IHabboWindowManager, _arg_3:IHabboCommunicationManager, _arg_4:IAssetLibrary, _arg_5:IHabboLocalizationManager)
        {
            this._controller = _arg_1;
            this._effects = new Array();
            this._assets = _arg_4;
            this._communication = _arg_3;
            this._activeEffectsProxy = new EffectListProxy(this, 1);
            this._inactiveEffectsProxy = new EffectListProxy(this, 0);
            this._view = new EffectsView(this, _arg_2, _arg_4, _arg_5, this._activeEffectsProxy, this._inactiveEffectsProxy);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            if (!this._disposed){
                this._controller = null;
                if (this._view != null){
                    this._view.dispose();
                };
                if (this._activeEffectsProxy != null){
                    this._activeEffectsProxy.dispose();
                    this._activeEffectsProxy = null;
                };
                if (this._inactiveEffectsProxy != null){
                    this._inactiveEffectsProxy.dispose();
                    this._inactiveEffectsProxy = null;
                };
                this._disposed = true;
            };
        }
        public function requestInitialization(_arg_1:int=0):void
        {
        }
        public function categorySwitch(_arg_1:String):void
        {
        }
        public function addEffect(_arg_1:Effect, _arg_2:Boolean=true):void
        {
            var _local_4:BitmapDataAsset;
            var _local_3:Effect = this.getEffect(_arg_1.type);
            if (_local_3 != null){
                _local_3.effectsInInventory++;
            }
            else {
                _local_4 = BitmapDataAsset(this._assets.getAssetByName((("fx_icon_" + _arg_1.type) + "_png")));
                if (_local_4 != null){
                    _arg_1.iconImage = BitmapData(_local_4.content);
                };
                this._effects.push(_arg_1);
            };
            if (_arg_2){
                this.refreshViews();
            };
        }
        private function getEffect(_arg_1:int):Effect
        {
            var _local_3:Effect;
            var _local_2:int;
            while (_local_2 < this._effects.length) {
                _local_3 = this._effects[_local_2];
                if (_local_3.type == _arg_1){
                    return (_local_3);
                };
                _local_2++;
            };
            return (null);
        }
        private function removeEffect(_arg_1:int):void
        {
            var _local_3:Effect;
            var _local_2:int;
            while (_local_2 < this._effects.length) {
                _local_3 = this._effects[_local_2];
                if (_local_3.type == _arg_1){
                    this._effects.splice(_local_2, 1);
                    this.refreshViews();
                    return;
                };
                _local_2++;
            };
        }
        public function refreshViews():void
        {
            this._view.updateListViews();
            this._view.updateActionView();
        }
        public function requestEffectActivated(_arg_1:int):void
        {
            this._controller.communication.getHabboMainConnection(null).send(new AvatarEffectActivatedComposer(_arg_1));
        }
        public function setEffectActivated(_arg_1:int):void
        {
            var _local_2:Effect = this.getEffect(_arg_1);
            if (_local_2 != null){
                this.stopUsingAllEffects(false, false);
                _local_2.isActive = true;
                _local_2.isInUse = true;
                this.refreshViews();
            };
        }
        public function useEffect(_arg_1:int):void
        {
            this.stopUsingAllEffects(false, false);
            var _local_2:Effect = this.getEffect(_arg_1);
            if (_local_2 == null){
                return;
            };
            if (!_local_2.isActive){
                this.requestEffectActivated(_local_2.type);
            };
            if (_local_2.isInUse == false){
                _local_2.isInUse = true;
                this._controller.communication.getHabboMainConnection(null).send(new AvatarEffectSelectedComposer(_arg_1));
                this.refreshViews();
            };
        }
        public function stopUsingEffect(_arg_1:int, _arg_2:Boolean=false):void
        {
            var _local_3:Effect = this.getEffect(_arg_1);
            if (_local_3 != null){
                if (_local_3.isInUse == true){
                    _local_3.isInUse = false;
                    if (_arg_2){
                        this._controller.communication.getHabboMainConnection(null).send(new AvatarEffectSelectedComposer(-1));
                    };
                    this.refreshViews();
                };
            };
        }
        public function stopUsingAllEffects(_arg_1:Boolean=true, _arg_2:Boolean=true):void
        {
            var _local_4:Effect;
            var _local_3:int;
            while (_local_3 < this._effects.length) {
                _local_4 = this._effects[_local_3];
                _local_4.isInUse = false;
                _local_3++;
            };
            if (_arg_1){
                this._controller.communication.getHabboMainConnection(null).send(new AvatarEffectSelectedComposer(-1));
            };
            if (_arg_2){
                this.refreshViews();
            };
        }
        public function toggleEffectSelected(_arg_1:int):void
        {
            var _local_2:Effect = this.getEffect(_arg_1);
            if (_local_2 != null){
                if (_local_2.isSelected){
                    this.setEffectDeselected(_arg_1);
                }
                else {
                    this.setEffectSelected(_arg_1);
                };
                this.refreshViews();
            };
        }
        public function setEffectSelected(_arg_1:int):void
        {
            var _local_2:Effect = this.getEffect(_arg_1);
            if (_local_2 != null){
                this.setAllEffectsDeselected(false);
                _local_2.isSelected = true;
                this.refreshViews();
            };
        }
        public function setEffectDeselected(_arg_1:int):void
        {
            var _local_2:Effect = this.getEffect(_arg_1);
            if (_local_2 != null){
                _local_2.isSelected = false;
                this.refreshViews();
            };
        }
        private function setAllEffectsDeselected(_arg_1:Boolean=true):void
        {
            var _local_3:Effect;
            var _local_2:int;
            while (_local_2 < this._effects.length) {
                _local_3 = this._effects[_local_2];
                _local_3.isSelected = false;
                _local_2++;
            };
            if (_arg_1){
                this.refreshViews();
            };
        }
        public function getSelectedEffect(_arg_1:int=-1):Effect
        {
            var _local_4:Effect;
            var _local_2:Array = this.getEffects(_arg_1);
            var _local_3:int;
            while (_local_3 < _local_2.length) {
                _local_4 = _local_2[_local_3];
                if (_local_4.isSelected){
                    return (_local_4);
                };
                _local_3++;
            };
            return (null);
        }
        private function getEffectIndex(_arg_1:int, _arg_2:int=-1):int
        {
            var _local_4:Array;
            var _local_5:int;
            var _local_6:Effect;
            var _local_3:Effect = this.getEffect(_arg_1);
            if (_local_3 != null){
                _local_4 = this.getEffects(_arg_2);
                _local_5 = 0;
                while (_local_5 < _local_4.length) {
                    _local_6 = _local_4[_local_5];
                    if (_local_6.type == _arg_1){
                        return (_local_5);
                    };
                    _local_5++;
                };
            };
            return (-1);
        }
        public function getEffects(_arg_1:int=-1):Array
        {
            var _local_4:Effect;
            var _local_2:Array = new Array();
            var _local_3:int;
            while (_local_3 < this._effects.length) {
                _local_4 = this._effects[_local_3];
                if (((((((_local_4.isActive) && ((_arg_1 == 1)))) || (((!(_local_4.isActive)) && ((_arg_1 == 0)))))) || ((_arg_1 == -1)))){
                    _local_2.push(_local_4);
                };
                _local_3++;
            };
            return (_local_2);
        }
        public function setEffectExpired(_arg_1:int):void
        {
            var _local_2:Effect = this.getEffect(_arg_1);
            if (_local_2 != null){
                if (_local_2.effectsInInventory > 1){
                    _local_2.setOneEffectExpired();
                    this.refreshViews();
                }
                else {
                    this.removeEffect(_local_2.type);
                };
            };
        }
        public function getItemInIndex(_arg_1:int, _arg_2:int=-1):Effect
        {
            var _local_3:Array = this.getEffects(_arg_2);
            if ((((_arg_1 < 0)) || ((_arg_1 >= _local_3.length)))){
                return (null);
            };
            return (_local_3[_arg_1]);
        }
        public function getWindowContainer():IWindowContainer
        {
            return (this._view.getWindowContainer());
        }
        public function closingInventoryView():void
        {
        }
        public function subCategorySwitch(_arg_1:String):void
        {
        }

    }
}//package com.sulake.habbo.inventory.effects

// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// IInventoryModel = "_-Fh" (String#7987, DoABC#2)
// EffectsModel = "_-ja" (String#8589, DoABC#2)
// Effect = "_-0Ka" (String#14863, DoABC#2)
// AvatarEffectActivatedComposer = "_-2ZH" (String#20409, DoABC#2)
// EffectsView = "_-1-K" (String#4853, DoABC#2)
// AvatarEffectSelectedComposer = "_-2aD" (String#20451, DoABC#2)
// EffectListProxy = "_-35e" (String#7422, DoABC#2)
// _controller = "_-18D" (String#59, DoABC#2)
// isInUse = "_-2LN" (String#6469, DoABC#2)
// effectsInInventory = "_-0U0" (String#4183, DoABC#2)
// isActive = "_-0q4" (String#4638, DoABC#2)
// communication = "_-3HD" (String#22171, DoABC#2)
// getHabboMainConnection = "_-0AQ" (String#809, DoABC#2)
// getWindowContainer = "_-v8" (String#313, DoABC#2)
// iconImage = "_-0Pn" (String#4088, DoABC#2)
// closingInventoryView = "_-0Lx" (String#4000, DoABC#2)
// requestInitialization = "_-2eX" (String#6842, DoABC#2)
// categorySwitch = "_-3Ad" (String#7526, DoABC#2)
// subCategorySwitch = "_-1Gu" (String#5187, DoABC#2)
// _effects = "_-1d5" (String#856, DoABC#2)
// setEffectSelected = "_-1Ct" (String#1634, DoABC#2)
// setEffectDeselected = "_-2rY" (String#1952, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// updateActionView = "_-jg" (String#8593, DoABC#2)
// addEffect = "_-1uY" (String#18737, DoABC#2)
// getEffect = "_-j-" (String#24000, DoABC#2)
// refreshViews = "_-tx" (String#24446, DoABC#2)
// removeEffect = "_-1QF" (String#17520, DoABC#2)
// updateListViews = "_-3LU" (String#7727, DoABC#2)
// requestEffectActivated = "_-2jP" (String#20821, DoABC#2)
// setEffectActivated = "_-2LA" (String#19854, DoABC#2)
// stopUsingAllEffects = "_-27X" (String#19312, DoABC#2)
// useEffect = "_-3KO" (String#22299, DoABC#2)
// stopUsingEffect = "_-9A" (String#22587, DoABC#2)
// toggleEffectSelected = "_-tV" (String#24427, DoABC#2)
// setAllEffectsDeselected = "_-0TF" (String#15180, DoABC#2)
// getSelectedEffect = "_-7B" (String#22509, DoABC#2)
// getEffects = "_-1VO" (String#17714, DoABC#2)
// getEffectIndex = "_-1Wm" (String#17771, DoABC#2)
// setEffectExpired = "_-iZ" (String#23980, DoABC#2)
// setOneEffectExpired = "_-c8" (String#23720, DoABC#2)
// getItemInIndex = "_-0Tf" (String#15196, DoABC#2)


