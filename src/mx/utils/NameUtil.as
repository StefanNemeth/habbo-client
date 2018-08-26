
package mx.utils
{
    import mx.core.mx_internal;
    import flash.utils.getQualifiedClassName;
    import flash.display.DisplayObject;
    import mx.core.IRepeaterClient;
    use namespace mx_internal;

    public class NameUtil 
    {

        mx_internal static const VERSION:String = "4.1.0.16021";
        private static var counter:int = 0;

        public static function createUniqueName(_arg_1:Object):String
        {
            if (!_arg_1){
                return (null);
            };
            var _local_2:String = getQualifiedClassName(_arg_1);
            var _local_3:int = _local_2.indexOf("::");
            if (_local_3 != -1){
                _local_2 = _local_2.substr((_local_3 + 2));
            };
            var _local_4:int = _local_2.charCodeAt((_local_2.length - 1));
            if ((((_local_4 >= 48)) && ((_local_4 <= 57)))){
                _local_2 = (_local_2 + "_");
            };
            return ((_local_2 + counter++));
        }
        public static function displayObjectToString(displayObject:DisplayObject):String
        {
            var result:String;
            var o:DisplayObject;
            var s:String;
            var indices:Array;
            try {
                o = displayObject;
                while (o != null) {
                    if (((((o.parent) && (o.stage))) && ((o.parent == o.stage)))) break;
                    s = ((((("id" in o)) && (o["id"]))) ? o["id"] : o.name);
                    if ((o is IRepeaterClient)){
                        indices = IRepeaterClient(o).instanceIndices;
                        if (indices){
                            s = (s + (("[" + indices.join("][")) + "]"));
                        };
                    };
                    result = (((result == null)) ? s : ((s + ".") + result));
                    o = o.parent;
                };
            }
            catch(e:SecurityError) {
            };
            return (result);
        }
        public static function getUnqualifiedClassName(_arg_1:Object):String
        {
            var _local_2:String;
            if ((_arg_1 is String)){
                _local_2 = (_arg_1 as String);
            }
            else {
                _local_2 = getQualifiedClassName(_arg_1);
            };
            var _local_3:int = _local_2.indexOf("::");
            if (_local_3 != -1){
                _local_2 = _local_2.substr((_local_3 + 2));
            };
            return (_local_2);
        }

    }
}//package mx.utils

