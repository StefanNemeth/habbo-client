
package mx.core
{
    import flash.geom.Matrix;
    import flash.geom.Matrix3D;

    public interface IAssetLayoutFeatures 
    {

        function set layoutX(_arg_1:Number):void;
        function get layoutX():Number;
        function set layoutY(_arg_1:Number):void;
        function get layoutY():Number;
        function set layoutZ(_arg_1:Number):void;
        function get layoutZ():Number;
        function get layoutWidth():Number;
        function set layoutWidth(_arg_1:Number):void;
        function set transformX(_arg_1:Number):void;
        function get transformX():Number;
        function set transformY(_arg_1:Number):void;
        function get transformY():Number;
        function set transformZ(_arg_1:Number):void;
        function get transformZ():Number;
        function set layoutRotationX(_arg_1:Number):void;
        function get layoutRotationX():Number;
        function set layoutRotationY(_arg_1:Number):void;
        function get layoutRotationY():Number;
        function set layoutRotationZ(_arg_1:Number):void;
        function get layoutRotationZ():Number;
        function set layoutScaleX(_arg_1:Number):void;
        function get layoutScaleX():Number;
        function set layoutScaleY(_arg_1:Number):void;
        function get layoutScaleY():Number;
        function set layoutScaleZ(_arg_1:Number):void;
        function get layoutScaleZ():Number;
        function set layoutMatrix(_arg_1:Matrix):void;
        function get layoutMatrix():Matrix;
        function set layoutMatrix3D(_arg_1:Matrix3D):void;
        function get layoutMatrix3D():Matrix3D;
        function get is3D():Boolean;
        function get layoutIs3D():Boolean;
        function get mirror():Boolean;
        function set mirror(_arg_1:Boolean):void;
        function get stretchX():Number;
        function set stretchX(_arg_1:Number):void;
        function get stretchY():Number;
        function set stretchY(_arg_1:Number):void;
        function get computedMatrix():Matrix;
        function get computedMatrix3D():Matrix3D;

    }
}//package mx.core

