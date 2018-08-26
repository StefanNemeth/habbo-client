
package com.sulake.habbo.avatar.pets
{
    import com.sulake.core.utils.Map;

    public interface IPetDataManager 
    {

        function PetDataManager(_arg_1:int, _arg_2:IPetDataListener=null):IPetData;
        function get species():Map;
        function PetDataManager(_arg_1:IPetDataListener=null):void;

    }
}//package com.sulake.habbo.avatar.pets

// IPetDataManager = "_-03y" (String#3647, DoABC#2)
// IPetData = "_-0mZ" (String#4560, DoABC#2)
// IPetDataListener = "_-r6" (String#8726, DoABC#2)
// PetDataManager = "_-2Tw" (String#6646, DoABC#2)
// PetDataManager = "_-1Hc" (String#1653, DoABC#2)


