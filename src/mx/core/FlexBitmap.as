
package mx.core
{
    import flash.display.Bitmap;
    import mx.utils.NameUtil;
    import flash.display.BitmapData;

    public class FlexBitmap extends Bitmap 
    {

        mx_internal static const VERSION:String = "4.1.0.16021";

        public function FlexBitmap(bitmapData:BitmapData=null, pixelSnapping:String="auto", smoothing:Boolean=false)
        {
            super(bitmapData, pixelSnapping, smoothing);
            try {
                name = NameUtil.createUniqueName(this);
            }
            catch(e:Error) {
            };
        }
        override public function toString():String
        {
            return (NameUtil.displayObjectToString(this));
        }

    }
}//package mx.core

