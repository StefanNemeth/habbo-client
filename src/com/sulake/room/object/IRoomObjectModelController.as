
package com.sulake.room.object
{
    public interface IRoomObjectModelController extends IRoomObjectModel 
    {

        function setNumber(_arg_1:String, _arg_2:Number, _arg_3:Boolean=false):void;
        function setString(_arg_1:String, _arg_2:String, _arg_3:Boolean=false):void;
        function setNumberArray(_arg_1:String, _arg_2:Array, _arg_3:Boolean=false):void;
        function setStringArray(_arg_1:String, _arg_2:Array, _arg_3:Boolean=false):void;

    }
}//package com.sulake.room.object

// setStringArray = "_-1by" (String#5598, DoABC#2)
// IRoomObjectModel = "_-253" (String#6141, DoABC#2)
// IRoomObjectModelController = "_-1yp" (String#6010, DoABC#2)


