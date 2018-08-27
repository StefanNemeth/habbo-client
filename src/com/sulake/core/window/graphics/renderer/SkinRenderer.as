
package com.sulake.core.window.graphics.renderer
{
    import flash.utils.Dictionary;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindow;
    import flash.display.IBitmapDrawable;
    import flash.geom.Rectangle;

    public class SkinRenderer implements ISkinRenderer 
    {

        private var _name:String;
        private var _disposed:Boolean = false;
        protected var _SafeStr_4060:Dictionary;
        protected var _templatesByState:Dictionary;
        protected var _SafeStr_4061:Dictionary;
        protected var _SafeStr_4062:Dictionary;

        public function SkinRenderer(_arg_1:String)
        {
            this._name = _arg_1;
            this._SafeStr_4060 = new Dictionary();
            this._templatesByState = new Dictionary();
            this._SafeStr_4061 = new Dictionary();
            this._SafeStr_4062 = new Dictionary();
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function parse(_arg_1:IAsset, _arg_2:XMLList, _arg_3:IAssetLibrary):void
        {
        }
        public function dispose():void
        {
            var _local_1:String;
            if (!this._disposed){
                for (_local_1 in this._SafeStr_4061) {
                    ISkinLayout(this._SafeStr_4061[_local_1]).dispose();
                    delete this._SafeStr_4061[_local_1];
                };
                this._SafeStr_4061 = null;
                this._SafeStr_4062 = null;
                for (_local_1 in this._SafeStr_4060) {
                    ISkinTemplate(this._SafeStr_4060[_local_1]).dispose();
                    delete this._SafeStr_4060[_local_1];
                };
                this._SafeStr_4060 = null;
                this._templatesByState = null;
            };
        }
        public function draw(_arg_1:IWindow, _arg_2:IBitmapDrawable, _arg_3:Rectangle, _arg_4:uint, _arg_5:Boolean):void
        {
        }
        public function isStateDrawable(_arg_1:uint):Boolean
        {
            return (false);
        }
        public function getLayoutByState(_arg_1:uint):ISkinLayout
        {
            return (this._SafeStr_4062[_arg_1]);
        }
        public function registerLayoutForRenderState(_arg_1:uint, _arg_2:String):void
        {
            var _local_3:ISkinLayout = this._SafeStr_4061[_arg_2];
            if (_local_3 == null){
                throw (new Error((('Layout "' + _arg_2) + '" not found in renderer!')));
            };
            this._SafeStr_4062[_arg_1] = _local_3;
        }
        public function removeLayoutFromRenderState(_arg_1:uint):void
        {
            delete this._SafeStr_4062[_arg_1];
        }
        public function hasLayoutForState(_arg_1:uint):Boolean
        {
            return (!((this._SafeStr_4062[_arg_1] == null)));
        }
        public function getTemplateByState(_arg_1:uint):ISkinTemplate
        {
            return (this._templatesByState[_arg_1]);
        }
        public function registerTemplateForRenderState(_arg_1:uint, _arg_2:String):void
        {
            var _local_3:ISkinTemplate = this._SafeStr_4060[_arg_2];
            if (_local_3 == null){
                throw (new Error((('Template "' + _arg_2) + '" not found in renderer!')));
            };
            this._templatesByState[_arg_1] = _local_3;
        }
        public function removeTemplateFromRenderState(_arg_1:uint):void
        {
            delete this._templatesByState[_arg_1];
        }
        public function hasTemplateForState(_arg_1:uint):Boolean
        {
            return (!((this._templatesByState[_arg_1] == null)));
        }
        public function addLayout(_arg_1:ISkinLayout):ISkinLayout
        {
            this._SafeStr_4061[_arg_1.name] = _arg_1;
            return (_arg_1);
        }
        public function getLayoutByName(_arg_1:String):ISkinLayout
        {
            return (this._SafeStr_4061[_arg_1]);
        }
        public function removeLayout(_arg_1:ISkinLayout):ISkinLayout
        {
            var _local_2:Object;
            var _local_3:uint;
            _arg_1 = this._SafeStr_4060[_arg_1.name];
            if (_arg_1 != null){
                for (_local_2 in this._SafeStr_4062) {
                    _local_3 = (_local_2 as uint);
                    if (this._SafeStr_4062[_local_3] == _arg_1){
                        this.removeLayoutFromRenderState(_local_3);
                    };
                };
                delete this._SafeStr_4061[_arg_1.name];
            };
            return (_arg_1);
        }
        public function addTemplate(_arg_1:ISkinTemplate):ISkinTemplate
        {
            this._SafeStr_4060[_arg_1.name] = _arg_1;
            return (_arg_1);
        }
        public function getTemplateByName(_arg_1:String):ISkinTemplate
        {
            return (this._SafeStr_4060[_arg_1]);
        }
        public function removeTemplate(_arg_1:ISkinTemplate):ISkinTemplate
        {
            var _local_2:Object;
            var _local_3:uint;
            _arg_1 = this._SafeStr_4060[_arg_1.name];
            if (_arg_1 != null){
                for (_local_2 in this._templatesByState) {
                    _local_3 = (_local_2 as uint);
                    if (this._templatesByState[_local_3] == _arg_1){
                        this.removeTemplateFromRenderState(_local_3);
                    };
                };
                delete this._SafeStr_4060[_arg_1.name];
            };
            return (_arg_1);
        }

    }
}//package com.sulake.core.window.graphics.renderer

// ISkinLayout = "_-m8" (String#2182, DoABC#2)
// ISkinRenderer = "_-1uJ" (String#1780, DoABC#2)
// ISkinTemplate = "_-31I" (String#1988, DoABC#2)
// SkinRenderer = "_-bE" (String#8445, DoABC#2)
// isStateDrawable = "_-0hI" (String#4452, DoABC#2)
// addLayout = "_-2RX" (String#6597, DoABC#2)
// getLayoutByName = "_-2lX" (String#6993, DoABC#2)
// removeLayout = "_-1Kq" (String#5260, DoABC#2)
// getLayoutByState = "_-AQ" (String#7876, DoABC#2)
// registerLayoutForRenderState = "_-ZK" (String#8402, DoABC#2)
// removeLayoutFromRenderState = "_-bY" (String#8447, DoABC#2)
// hasLayoutForState = "_-0pf" (String#4625, DoABC#2)
// addTemplate = "_-1FX" (String#5163, DoABC#2)
// getTemplateByName = "_-3Bh" (String#7544, DoABC#2)
// removeTemplate = "_-2qc" (String#7088, DoABC#2)
// getTemplateByState = "_-1Lf" (String#5271, DoABC#2)
// registerTemplateForRenderState = "_-U7" (String#8289, DoABC#2)
// removeTemplateFromRenderState = "_-tc" (String#8760, DoABC#2)
// hasTemplateForState = "_-2E6" (String#6323, DoABC#2)
// _SafeStr_4060 = "_-0Ew" (String#14642, DoABC#2)
// _SafeStr_4061 = "_-2zW" (String#21439, DoABC#2)
// _SafeStr_4062 = "_-IB" (String#22936, DoABC#2)


