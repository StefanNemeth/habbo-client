
package com.sulake.habbo.room.object.visualization.furniture
{
    import flash.utils.Dictionary;
    import flash.display.BitmapData;
    import com.sulake.room.object.visualization.IRoomObjectSprite;
    import flash.geom.ColorTransform;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import flash.geom.Point;
    import flash.display.BlendMode;
    import flash.geom.Vector3D;

    public class FurnitureParticleSystem 
    {

        private var _SafeStr_12739:Dictionary;
        private var _visualization:AnimatedFurnitureVisualization;
        private var _SafeStr_12740:int;
        private var _canvasId:int;
        private var _originalOffsetY:int;
        private var _SafeStr_12741:FurnitureParticleSystemEmitter;
        private var _canvas:BitmapData;
        private var _SafeStr_12742:IRoomObjectSprite;
        private var _hasIgnited:Boolean = false;
        private var _SafeStr_12434:int = 0;
        private var _SafeStr_12435:int = 0;
        private var _SafeStr_12744:Number = 1;
        private var _SafeStr_12745:BitmapData;
        private var _SafeStr_12746:ColorTransform;
        private var _SafeStr_12747:ColorTransform;
        private var _SafeStr_12748:Matrix;
        private var _translationMatrix:Matrix;
        private var _blend:Number = 1;

        public function FurnitureParticleSystem(_arg_1:AnimatedFurnitureVisualization)
        {
            this._SafeStr_12739 = new Dictionary();
            this._visualization = _arg_1;
            this._SafeStr_12746 = new ColorTransform();
            this._SafeStr_12746.alphaMultiplier = 1;
            this._SafeStr_12747 = new ColorTransform();
            this._SafeStr_12748 = new Matrix();
            this._translationMatrix = new Matrix();
        }
        public function dispose():void
        {
            var _local_1:FurnitureParticleSystemEmitter;
            for each (_local_1 in this._SafeStr_12739) {
                _local_1.dispose();
            };
            this._SafeStr_12739 = null;
            if (this._canvas){
                this._canvas.dispose();
                this._canvas = null;
            };
            if (this._SafeStr_12745){
                this._SafeStr_12745.dispose();
                this._SafeStr_12745 = null;
            };
            this._SafeStr_12746 = null;
            this._SafeStr_12747 = null;
            this._SafeStr_12748 = null;
            this._translationMatrix = null;
        }
        public function reset():void
        {
            if (this._SafeStr_12741){
                this._SafeStr_12741.reset();
            };
            this._SafeStr_12741 = null;
            this._hasIgnited = false;
            this.updateCanvas();
        }
        public function setAnimation(_arg_1:int):void
        {
            if (this._SafeStr_12741){
                this._SafeStr_12741.reset();
            };
            this._SafeStr_12741 = this._SafeStr_12739[_arg_1];
            this._hasIgnited = false;
            this.updateCanvas();
        }
        private function updateCanvas():void
        {
            if (!this._SafeStr_12741){
                return;
            };
            if (this._canvasId >= 0){
                this._SafeStr_12742 = this._visualization.getSprite(this._canvasId);
                if (((this._SafeStr_12742) && (this._SafeStr_12742.asset))){
                    if ((((this._SafeStr_12742.width <= 1)) || ((this._SafeStr_12742.height <= 1)))){
                        return;
                    };
                    if (this._canvas == null){
                        this._canvas = this._SafeStr_12742.asset.clone();
                        if (this._SafeStr_12746.alphaMultiplier != 1){
                            this._SafeStr_12745 = new BitmapData(this._canvas.width, this._canvas.height, true, 0xFF000000);
                        };
                    };
                    this._SafeStr_12434 = -(this._SafeStr_12742.offsetX);
                    this._SafeStr_12435 = -(this._SafeStr_12742.offsetY);
                    this._SafeStr_12742.asset = this._canvas;
                };
                if (this._canvas){
                    this._canvas.fillRect(this._canvas.rect, 0xFF000000);
                };
                if (this._SafeStr_12745){
                    this._SafeStr_12745.fillRect(this._SafeStr_12745.rect, 0xFF000000);
                };
            };
        }
        public function getSpriteYOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            if (((this._SafeStr_12741) && ((this._SafeStr_12741.roomObjectSpriteId == _arg_3)))){
                return ((this._SafeStr_12741.y * this._SafeStr_12744));
            };
            return (0);
        }
        public function controlsSprite(_arg_1:int):Boolean
        {
            if (this._SafeStr_12741){
                return ((this._SafeStr_12741.roomObjectSpriteId == _arg_1));
            };
            return (false);
        }
        public function updateSprites():void
        {
            if (((!(this._SafeStr_12741)) || (!(this._SafeStr_12742)))){
                return;
            };
            if (((this._canvas) && (!((this._SafeStr_12742.asset == this._canvas))))){
                this._SafeStr_12742.asset = this._canvas;
            };
            if (this._hasIgnited){
                if (this._SafeStr_12741.roomObjectSpriteId >= 0){
                    this._visualization.getSprite(this._SafeStr_12741.roomObjectSpriteId).visible = false;
                };
            };
        }
        public function updateAnimation():void
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:Rectangle;
            var _local_6:IGraphicAsset;
            var _local_7:BitmapData;
            var _local_9:Point;
            var _local_10:Point;
            var _local_11:FurnitureParticleSystemParticle;
            if (((!(this._SafeStr_12741)) || (!(this._SafeStr_12742)))){
                return;
            };
            var _local_1:Number = 10;
            var _local_2:Number = 0;
            var _local_8:int;
            if (((!(this._hasIgnited)) && (this._SafeStr_12741.hasIgnited))){
                this._hasIgnited = true;
            };
            _local_8 = (this._originalOffsetY * this._SafeStr_12744);
            this._SafeStr_12741.update();
            if (this._hasIgnited){
                if (this._SafeStr_12741.roomObjectSpriteId >= 0){
                    this._visualization.getSprite(this._SafeStr_12741.roomObjectSpriteId).visible = false;
                };
                if (!this._canvas){
                    this.updateCanvas();
                };
                this._canvas.lock();
                if (this._SafeStr_12746.alphaMultiplier == 1){
                    this._canvas.fillRect(this._canvas.rect, 0xFF000000);
                }
                else {
                    this._canvas.draw(this._SafeStr_12745, this._SafeStr_12748, this._SafeStr_12746, BlendMode.NORMAL, null, false);
                };
                for each (_local_11 in this._SafeStr_12741.particles) {
                    _local_2 = _local_11.y;
                    _local_3 = (this._SafeStr_12434 + ((((_local_11.x - _local_11.z) * _local_1) / 10) * this._SafeStr_12744));
                    _local_4 = ((this._SafeStr_12435 - _local_8) + ((((_local_2 + ((_local_11.x + _local_11.z) / 2)) * _local_1) / 10) * this._SafeStr_12744));
                    _local_6 = _local_11.getAsset();
                    if (_local_6){
                        _local_7 = (_local_6.asset.content as BitmapData);
                        if (((_local_11.fade) && ((_local_11.alphaMultiplier < 1)))){
                            this._translationMatrix.identity();
                            this._translationMatrix.translate((_local_3 + _local_6.offsetX), (_local_4 + _local_6.offsetY));
                            this._SafeStr_12747.alphaMultiplier = _local_11.alphaMultiplier;
                            this._canvas.draw(_local_7, this._translationMatrix, this._SafeStr_12747, BlendMode.NORMAL, null, false);
                        }
                        else {
                            _local_10 = new Point((_local_3 + _local_6.offsetX), (_local_4 + _local_6.offsetY));
                            this._canvas.copyPixels(_local_7, _local_7.rect, _local_10, null, null, true);
                        };
                    }
                    else {
                        _local_5 = new Rectangle((_local_3 - 1), (_local_4 - 1), 2, 2);
                        this._canvas.fillRect(_local_5, 0xFFFFFFFF);
                    };
                };
                this._canvas.unlock();
            };
        }
        public function parseData(_arg_1:XML):void
        {
            var _local_2:IRoomObjectSprite;
            var _local_3:XML;
            var _local_4:int;
            var _local_5:String;
            var _local_6:int;
            var _local_7:FurnitureParticleSystemEmitter;
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:Number;
            var _local_13:Number;
            var _local_14:Number;
            var _local_15:Number;
            var _local_16:String;
            var _local_17:Number;
            var _local_18:int;
            var _local_19:Boolean;
            var _local_20:Boolean;
            var _local_21:Array;
            var _local_22:IGraphicAsset;
            var _local_23:XML;
            var _local_24:XML;
            this._SafeStr_12740 = parseInt(_arg_1.@size);
            this._canvasId = ((_arg_1.hasOwnProperty("@canvas_id")) ? parseInt(_arg_1.@canvas_id) : -1);
            this._originalOffsetY = ((_arg_1.hasOwnProperty("@offset_y")) ? parseInt(_arg_1.@offset_y) : 10);
            this._SafeStr_12744 = (this._SafeStr_12740 / 64);
            this._blend = ((_arg_1.hasOwnProperty("@blend")) ? Number(_arg_1.@blend) : 1);
            this._blend = Math.min(this._blend, 1);
            this._SafeStr_12746.alphaMultiplier = this._blend;
            for each (_local_3 in _arg_1.emitter) {
                _local_4 = parseInt(_local_3.@id);
                _local_5 = _local_3.@name;
                _local_6 = parseInt(_local_3.@sprite_id);
                _local_7 = new FurnitureParticleSystemEmitter(_local_5, _local_6);
                this._SafeStr_12739[_local_4] = _local_7;
                _local_8 = parseInt(_local_3.@max_num_particles);
                _local_9 = parseInt(_local_3.@particles_per_frame);
                _local_10 = ((_local_3.hasOwnProperty("@burst_pulse")) ? parseInt(_local_3.@burst_pulse) : 1);
                _local_11 = parseInt(_local_3.@fuse_time);
                _local_12 = Number(_local_3.simulation.@force);
                _local_13 = Number(_local_3.simulation.@direction);
                _local_14 = Number(_local_3.simulation.@gravity);
                _local_15 = Number(_local_3.simulation.@airfriction);
                _local_16 = _local_3.simulation.@shape;
                _local_17 = Number(_local_3.simulation.@energy);
                for each (_local_23 in _local_3.particles.particle) {
                    _local_18 = parseInt(_local_23.@lifetime);
                    _local_19 = (((_local_23.@is_emitter)=="false") ? false : true);
                    _local_20 = ((((_local_23.hasOwnProperty("@fade")) && ((_local_23.@fade == "true")))) ? true : false);
                    _local_21 = [];
                    for each (_local_24 in _local_23.frame) {
                        _local_22 = this._visualization.assetCollection.getAsset(_local_24.@name);
                        _local_21.push(_local_22);
                    };
                    _local_7.configureParticle(_local_18, _local_19, _local_21, _local_20);
                };
                _local_7.setup(_local_8, _local_9, _local_12, new Vector3D(0, _local_13, 0), _local_14, _local_15, _local_16, _local_17, _local_11, _local_10);
            };
        }

    }
}//package com.sulake.habbo.room.object.visualization.furniture

// _SafeStr_12434 = "_-2Qt" (String#6575, DoABC#2)
// _SafeStr_12435 = "_-Ql" (String#8221, DoABC#2)
// updateSprites = "_-03G" (String#805, DoABC#2)
// controlsSprite = "_-0ob" (String#15999, DoABC#2)
// parseData = "_-fY" (String#23867, DoABC#2)
// _SafeStr_12739 = "_-300" (String#21502, DoABC#2)
// _SafeStr_12740 = "_-iM" (String#8564, DoABC#2)
// _SafeStr_12741 = "_-2mr" (String#20955, DoABC#2)
// _SafeStr_12742 = "_-3G8" (String#22123, DoABC#2)
// _hasIgnited = "_-dn" (String#8481, DoABC#2)
// _SafeStr_12744 = "_-126" (String#16540, DoABC#2)
// _SafeStr_12745 = "_-lj" (String#24100, DoABC#2)
// _SafeStr_12746 = "_-36u" (String#21761, DoABC#2)
// _SafeStr_12747 = "_-1im" (String#18236, DoABC#2)
// _SafeStr_12748 = "_-0Vz" (String#15274, DoABC#2)
// updateCanvas = "_-2Gd" (String#19667, DoABC#2)
// roomObjectSpriteId = "_-39b" (String#21865, DoABC#2)
// hasIgnited = "_-6T" (String#22482, DoABC#2)
// configureParticle = "_-0Ms" (String#14948, DoABC#2)
// AnimatedFurnitureVisualization = "_-0y2" (String#4811, DoABC#2)
// IGraphicAsset = "_-1HF" (String#5195, DoABC#2)
// IRoomObjectSprite = "_-0di" (String#4386, DoABC#2)
// FurnitureParticleSystem = "_-0Db" (String#3819, DoABC#2)
// FurnitureParticleSystemParticle = "_-0Ku" (String#3974, DoABC#2)
// FurnitureParticleSystemEmitter = "_-0q" (String#4636, DoABC#2)
// updateAnimation = "_-XZ" (String#166, DoABC#2)
// getSprite = "_-sN" (String#2210, DoABC#2)
// setAnimation = "_-ON" (String#252, DoABC#2)
// getSpriteYOffset = "_-3IZ" (String#251, DoABC#2)
// _canvas = "_-0Xp" (String#588, DoABC#2)
// _originalOffsetY = "_-hb" (String#375, DoABC#2)
// _blend = "_-2A2" (String#616, DoABC#2)
// _canvasId = "_-0SO" (String#4146, DoABC#2)


