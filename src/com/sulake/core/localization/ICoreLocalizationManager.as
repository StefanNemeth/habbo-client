
package com.sulake.core.localization
{
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.utils.Map;

    public interface ICoreLocalizationManager extends IUnknown 
    {

        function registerListener(_arg_1:String, _arg_2:ILocalizable):Boolean;
        function PetDataManager(_arg_1:String, _arg_2:ILocalizable):Boolean;
        function loadLocalizationFromURL(_arg_1:String):void;
        function hasKey(_arg_1:String):Boolean;
        function getKey(_arg_1:String, _arg_2:String=""):String;
        function getRawValue(_arg_1:String, _arg_2:String=""):String;
        function updateKey(_arg_1:String, _arg_2:String):void;
        function registerParameter(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String="%"):String;
        function getLocalization(_arg_1:String):ILocalization;
        function getKeys():Array;
        function registerLocalizationDefinition(_arg_1:String, _arg_2:String, _arg_3:String):void;
        function activateLocalization(_arg_1:String):Boolean;
        function getLocalizationDefinitions():Map;
        function getLocalizationDefinition(_arg_1:String):ILocalizationDefinition;
        function getActiveLocalizationDefinition():ILocalizationDefinition;
        function printNonExistingKeys():void;

    }
}//package com.sulake.core.localization

// ILocalization = "_-2EY" (String#1839, DoABC#2)
// ILocalizable = "_-3Dn" (String#2024, DoABC#2)
// ILocalizationDefinition = "_-oS" (String#2194, DoABC#2)
// updateKey = "_-1LP" (String#5269, DoABC#2)
// registerListener = "_-6e" (String#7798, DoABC#2)
// PetDataManager = "_-1Hc" (String#1653, DoABC#2)
// registerLocalizationDefinition = "_-00S" (String#3573, DoABC#2)
// activateLocalization = "_-iU" (String#8569, DoABC#2)
// loadLocalizationFromURL = "_-rj" (String#8731, DoABC#2)
// getLocalizationDefinitions = "_-3A1" (String#7512, DoABC#2)
// getLocalizationDefinition = "_-2Ce" (String#6296, DoABC#2)
// getActiveLocalizationDefinition = "_-0n3" (String#4568, DoABC#2)
// hasKey = "_-0LB" (String#3985, DoABC#2)
// getRawValue = "_-BV" (String#7899, DoABC#2)
// printNonExistingKeys = "_-0jT" (String#4489, DoABC#2)


