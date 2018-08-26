
package com.sulake.habbo.session
{
    public interface IUserDataManager 
    {

        function setUserData(_arg_1:IUserData):void;
        function getUserData(_arg_1:int):IUserData;
        function getUserDataByType(_arg_1:int, _arg_2:int):IUserData;
        function getUserDataByIndex(_arg_1:int):IUserData;
        function getUserBadges(_arg_1:int):Array;
        function removeUserDataByIndex(_arg_1:int):void;
        function setUserBadges(_arg_1:int, _arg_2:Array):void;
        function updateFigure(_arg_1:int, _arg_2:String, _arg_3:String):void;
        function updateCustom(_arg_1:int, _arg_2:String):void;
        function updateAchievementScore(_arg_1:int, _arg_2:int):void;
        function updateNameByIndex(_arg_1:int, _arg_2:String):void;
        function getPetUserData(_arg_1:int):IUserData;
        function requestPetInfo(_arg_1:int):void;

    }
}//package com.sulake.habbo.session

// IUserDataManager = "_-YM" (String#8379, DoABC#2)
// IUserData = "_-0n7" (String#4570, DoABC#2)
// getUserData = "_-1-1" (String#4848, DoABC#2)
// getPetUserData = "_-2Rz" (String#6606, DoABC#2)
// getUserDataByIndex = "_-1XZ" (String#5510, DoABC#2)
// setUserData = "_-Hx" (String#8038, DoABC#2)
// removeUserDataByIndex = "_-1he" (String#5701, DoABC#2)
// setUserBadges = "_-2Fj" (String#6358, DoABC#2)
// updateFigure = "_-15u" (String#1619, DoABC#2)
// updateCustom = "_-0N7" (String#4021, DoABC#2)
// updateAchievementScore = "_-1bB" (String#5581, DoABC#2)
// updateNameByIndex = "_-2vz" (String#7201, DoABC#2)
// requestPetInfo = "_-12z" (String#4933, DoABC#2)
// getUserBadges = "_-2Ny" (String#6521, DoABC#2)
// getUserDataByType = "_-1UX" (String#5443, DoABC#2)


