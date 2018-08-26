
package mx.core
{
    import flash.system.ApplicationDomain;
    import flash.events.Event;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.display.DisplayObjectContainer;

    public class BitmapAsset extends FlexBitmap implements IFlexAsset, IFlexDisplayObject, ILayoutDirectionElement 
    {

        mx_internal static const VERSION:String = "4.1.0.16021";
        private static var FlexVersionClass:Class;
        private static var MatrixUtilClass:Class;

        private var layoutFeaturesClass:Class;
        private var layoutFeatures:IAssetLayoutFeatures;
        private var _height:Number;
        private var _layoutDirection:String = "ltr";

        public function BitmapAsset(_arg_1:BitmapData=null, _arg_2:String="auto", _arg_3:Boolean=false)
        {
            var _local_4:ApplicationDomain;
            super(_arg_1, _arg_2, _arg_3);
            if (FlexVersionClass == null){
                _local_4 = ApplicationDomain.currentDomain;
                if (_local_4.hasDefinition("mx.core::FlexVersion")){
                    FlexVersionClass = Class(_local_4.getDefinition("mx.core::FlexVersion"));
                };
            };
            if (((FlexVersionClass) && ((FlexVersionClass["compatibilityVersion"] >= FlexVersionClass["VERSION_4_0"])))){
                this.addEventListener(Event.ADDED, this.addedHandler);
            };
        }
        override public function get x():Number
        {
            return ((((this.layoutFeatures)==null) ? super.x : this.layoutFeatures.layoutX));
        }
        override public function set x(_arg_1:Number):void
        {
            if (this.x == _arg_1){
                return;
            };
            if (this.layoutFeatures == null){
                super.x = _arg_1;
            }
            else {
                this.layoutFeatures.layoutX = _arg_1;
                this.validateTransformMatrix();
            };
        }
        override public function get y():Number
        {
            return ((((this.layoutFeatures)==null) ? super.y : this.layoutFeatures.layoutY));
        }
        override public function set y(_arg_1:Number):void
        {
            if (this.y == _arg_1){
                return;
            };
            if (this.layoutFeatures == null){
                super.y = _arg_1;
            }
            else {
                this.layoutFeatures.layoutY = _arg_1;
                this.validateTransformMatrix();
            };
        }
        override public function get z():Number
        {
            return ((((this.layoutFeatures)==null) ? super.z : this.layoutFeatures.layoutZ));
        }
        override public function set z(_arg_1:Number):void
        {
            if (this.z == _arg_1){
                return;
            };
            if (this.layoutFeatures == null){
                super.z = _arg_1;
            }
            else {
                this.layoutFeatures.layoutZ = _arg_1;
                this.validateTransformMatrix();
            };
        }
        override public function get width():Number
        {
            var _local_1:Point;
            if (this.layoutFeatures == null){
                return (super.width);
            };
            if (MatrixUtilClass != null){
                _local_1 = MatrixUtilClass["transformSize"](this.layoutFeatures.layoutWidth, this._height, transform.matrix);
            };
            return (((_local_1) ? _local_1.x : super.width));
        }
        override public function set width(_arg_1:Number):void
        {
            if (this.width == _arg_1){
                return;
            };
            if (this.layoutFeatures == null){
                super.width = _arg_1;
            }
            else {
                this.layoutFeatures.layoutWidth = _arg_1;
                this.layoutFeatures.layoutScaleX = (((this.measuredWidth)!=0) ? (_arg_1 / this.measuredWidth) : 0);
                this.validateTransformMatrix();
            };
        }
        override public function get height():Number
        {
            var _local_1:Point;
            if (this.layoutFeatures == null){
                return (super.height);
            };
            if (MatrixUtilClass != null){
                _local_1 = MatrixUtilClass["transformSize"](this.layoutFeatures.layoutWidth, this._height, transform.matrix);
            };
            return (((_local_1) ? _local_1.y : super.height));
        }
        override public function set height(_arg_1:Number):void
        {
            if (this.height == _arg_1){
                return;
            };
            if (this.layoutFeatures == null){
                super.height = _arg_1;
            }
            else {
                this._height = _arg_1;
                this.layoutFeatures.layoutScaleY = (((this.measuredHeight)!=0) ? (_arg_1 / this.measuredHeight) : 0);
                this.validateTransformMatrix();
            };
        }
        override public function get rotationX():Number
        {
            return ((((this.layoutFeatures)==null) ? super.rotationX : this.layoutFeatures.layoutRotationX));
        }
        override public function set rotationX(_arg_1:Number):void
        {
            if (this.rotationX == _arg_1){
                return;
            };
            if (this.layoutFeatures == null){
                super.rotationX = _arg_1;
            }
            else {
                this.layoutFeatures.layoutRotationX = _arg_1;
                this.validateTransformMatrix();
            };
        }
        override public function get rotationY():Number
        {
            return ((((this.layoutFeatures)==null) ? super.rotationY : this.layoutFeatures.layoutRotationY));
        }
        override public function set rotationY(_arg_1:Number):void
        {
            if (this.rotationY == _arg_1){
                return;
            };
            if (this.layoutFeatures == null){
                super.rotationY = _arg_1;
            }
            else {
                this.layoutFeatures.layoutRotationY = _arg_1;
                this.validateTransformMatrix();
            };
        }
        override public function get rotationZ():Number
        {
            return ((((this.layoutFeatures)==null) ? super.rotationZ : this.layoutFeatures.layoutRotationZ));
        }
        override public function set rotationZ(_arg_1:Number):void
        {
            if (this.rotationZ == _arg_1){
                return;
            };
            if (this.layoutFeatures == null){
                super.rotationZ = _arg_1;
            }
            else {
                this.layoutFeatures.layoutRotationZ = _arg_1;
                this.validateTransformMatrix();
            };
        }
        override public function get rotation():Number
        {
            return ((((this.layoutFeatures)==null) ? super.rotation : this.layoutFeatures.layoutRotationZ));
        }
        override public function set rotation(_arg_1:Number):void
        {
            if (this.rotation == _arg_1){
                return;
            };
            if (this.layoutFeatures == null){
                super.rotation = _arg_1;
            }
            else {
                this.layoutFeatures.layoutRotationZ = _arg_1;
                this.validateTransformMatrix();
            };
        }
        override public function get scaleX():Number
        {
            return ((((this.layoutFeatures)==null) ? super.scaleX : this.layoutFeatures.layoutScaleX));
        }
        override public function set scaleX(_arg_1:Number):void
        {
            if (this.scaleX == _arg_1){
                return;
            };
            if (this.layoutFeatures == null){
                super.scaleX = _arg_1;
            }
            else {
                this.layoutFeatures.layoutScaleX = _arg_1;
                this.layoutFeatures.layoutWidth = (Math.abs(_arg_1) * this.measuredWidth);
                this.validateTransformMatrix();
            };
        }
        override public function get scaleY():Number
        {
            return ((((this.layoutFeatures)==null) ? super.scaleY : this.layoutFeatures.layoutScaleY));
        }
        override public function set scaleY(_arg_1:Number):void
        {
            if (this.scaleY == _arg_1){
                return;
            };
            if (this.layoutFeatures == null){
                super.scaleY = _arg_1;
            }
            else {
                this.layoutFeatures.layoutScaleY = _arg_1;
                this._height = (Math.abs(_arg_1) * this.measuredHeight);
                this.validateTransformMatrix();
            };
        }
        override public function get scaleZ():Number
        {
            return ((((this.layoutFeatures)==null) ? super.scaleZ : this.layoutFeatures.layoutScaleZ));
        }
        override public function set scaleZ(_arg_1:Number):void
        {
            if (this.scaleZ == _arg_1){
                return;
            };
            if (this.layoutFeatures == null){
                super.scaleZ = _arg_1;
            }
            else {
                this.layoutFeatures.layoutScaleZ = _arg_1;
                this.validateTransformMatrix();
            };
        }
        public function get layoutDirection():String
        {
            return (this._layoutDirection);
        }
        public function set layoutDirection(_arg_1:String):void
        {
            if (_arg_1 == this._layoutDirection){
                return;
            };
            this._layoutDirection = _arg_1;
            this.invalidateLayoutDirection();
        }
        public function get measuredHeight():Number
        {
            if (bitmapData){
                return (bitmapData.height);
            };
            return (0);
        }
        public function get measuredWidth():Number
        {
            if (bitmapData){
                return (bitmapData.width);
            };
            return (0);
        }
        public function invalidateLayoutDirection():void
        {
            var _local_2:Boolean;
            var _local_1:DisplayObjectContainer = parent;
            while (_local_1) {
                if ((_local_1 is ILayoutDirectionElement)){
                    _local_2 = ((!((this._layoutDirection == null))) && (!((this._layoutDirection == ILayoutDirectionElement(_local_1).layoutDirection))));
                    if (((_local_2) && ((this.layoutFeatures == null)))){
                        this.initAdvancedLayoutFeatures();
                        if (this.layoutFeatures != null){
                            this.layoutFeatures.mirror = _local_2;
                            this.validateTransformMatrix();
                        };
                    }
                    else {
                        if (((!(_local_2)) && (this.layoutFeatures))){
                            this.layoutFeatures.mirror = _local_2;
                            this.validateTransformMatrix();
                            this.layoutFeatures = null;
                        };
                    };
                    return;
                };
                _local_1 = _local_1.parent;
            };
        }
        public function move(_arg_1:Number, _arg_2:Number):void
        {
            this.x = _arg_1;
            this.y = _arg_2;
        }
        public function setActualSize(_arg_1:Number, _arg_2:Number):void
        {
            this.width = _arg_1;
            this.height = _arg_2;
        }
        private function addedHandler(_arg_1:Event):void
        {
            this.invalidateLayoutDirection();
        }
        private function initAdvancedLayoutFeatures():void
        {
            var _local_1:ApplicationDomain;
            var _local_2:IAssetLayoutFeatures;
            if (this.layoutFeaturesClass == null){
                _local_1 = ApplicationDomain.currentDomain;
                if (_local_1.hasDefinition("mx.core::AdvancedLayoutFeatures")){
                    this.layoutFeaturesClass = Class(_local_1.getDefinition("mx.core::AdvancedLayoutFeatures"));
                };
                if (MatrixUtilClass == null){
                    if (_local_1.hasDefinition("mx.utils::MatrixUtil")){
                        MatrixUtilClass = Class(_local_1.getDefinition("mx.utils::MatrixUtil"));
                    };
                };
            };
            if (this.layoutFeaturesClass != null){
                _local_2 = new this.layoutFeaturesClass();
                _local_2.layoutScaleX = this.scaleX;
                _local_2.layoutScaleY = this.scaleY;
                _local_2.layoutScaleZ = this.scaleZ;
                _local_2.layoutRotationX = this.rotationX;
                _local_2.layoutRotationY = this.rotationY;
                _local_2.layoutRotationZ = this.rotation;
                _local_2.layoutX = this.x;
                _local_2.layoutY = this.y;
                _local_2.layoutZ = this.z;
                _local_2.layoutWidth = this.width;
                this._height = this.height;
                this.layoutFeatures = _local_2;
            };
        }
        private function validateTransformMatrix():void
        {
            if (this.layoutFeatures != null){
                if (this.layoutFeatures.is3D){
                    super.transform.matrix3D = this.layoutFeatures.computedMatrix3D;
                }
                else {
                    super.transform.matrix = this.layoutFeatures.computedMatrix;
                };
            };
        }

    }
}//package mx.core

