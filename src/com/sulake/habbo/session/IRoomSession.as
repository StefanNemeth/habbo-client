
package com.sulake.habbo.session
{
    public interface IRoomSession 
    {

        function get roomId():int;
        function get roomCategory():int;
        function get roomResources():String;
        function get state():String;
        function start():Boolean;
        function sendChatMessage(_arg_1:String):void;
        function sendChangeMottoMessage(_arg_1:String):void;
        function sendShoutMessage(_arg_1:String):void;
        function sendWhisperMessage(_arg_1:String, _arg_2:String):void;
        function sendChatTypingMessage(_arg_1:Boolean):void;
        function sendWaveMessage():void;
        function sendSignMessage(_arg_1:int):void;
        function sendDanceMessage(_arg_1:int):void;
        function sendCreditFurniRedeemMessage(_arg_1:int):void;
        function sendPresentOpenMessage(_arg_1:int):void;
        function sendOpenPetPackageMessage(_arg_1:int, _arg_2:String):void;
        function sendViralFurniFoundMessage():void;
        function sendRoomDimmerGetPresetsMessage():void;
        function sendRoomDimmerSavePresetMessage(_arg_1:int, _arg_2:int, _arg_3:uint, _arg_4:int, _arg_5:Boolean):void;
        function sendRoomDimmerChangeStateMessage():void;
        function sendConversionPoint(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String=null, _arg_5:int=0):void;
        function sendVote(_arg_1:int):void;
        function sendPollStartMessage(_arg_1:int):void;
        function sendPollRejectMessage(_arg_1:int):void;
        function sendPollAnswerMessage(_arg_1:int, _arg_2:int, _arg_3:Array):void;
        function kickUser(_arg_1:int):void;
        function banUser(_arg_1:int):void;
        function assignRights(_arg_1:int):void;
        function removeRights(_arg_1:int):void;
        function letUserIn(_arg_1:String, _arg_2:Boolean):void;
        function pickUpPet(_arg_1:int):void;
        function requestPetCommands(_arg_1:int):void;
        function quit():void;
        function kickBot(_arg_1:int):void;
        function changeQueue(_arg_1:int):void;
        function sendUpdateClothingChangeFurniture(_arg_1:int, _arg_2:String, _arg_3:String):void;
        function sendGetUserNotifications():void;
        function receivedChatWithTrackingId(_arg_1:int):void;
        function get isRoomOwner():Boolean;
        function set isRoomOwner(_arg_1:Boolean):void;
        function get isRoomController():Boolean;
        function set isRoomController(_arg_1:Boolean):void;
        function get isTradingRoom():Boolean;
        function get isPrivateRoom():Boolean;
        function set isTradingRoom(_arg_1:Boolean):void;
        function get userDataManager():IUserDataManager;
        function get isSpectatorMode():Boolean;
        function set isSpectatorMode(_arg_1:Boolean):void;
        function get arePetsAllowed():Boolean;
        function set arePetsAllowed(_arg_1:Boolean):void;

    }
}//package com.sulake.habbo.session

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// IUserDataManager = "_-YM" (String#8379, DoABC#2)
// sendConversionPoint = "_-0C0" (String#1425, DoABC#2)
// receivedChatWithTrackingId = "_-FR" (String#7981, DoABC#2)
// userDataManager = "_-lZ" (String#8636, DoABC#2)
// isRoomController = "_-xz" (String#8838, DoABC#2)
// isRoomOwner = "_-ZP" (String#8405, DoABC#2)
// isSpectatorMode = "_-10C" (String#4874, DoABC#2)
// isTradingRoom = "_-0eT" (String#4400, DoABC#2)
// arePetsAllowed = "_-1f7" (String#5646, DoABC#2)
// changeQueue = "_-2Ye" (String#1898, DoABC#2)
// roomResources = "_-9r" (String#7860, DoABC#2)
// sendViralFurniFoundMessage = "_-Zi" (String#8411, DoABC#2)
// sendPresentOpenMessage = "_-3Es" (String#7609, DoABC#2)
// sendOpenPetPackageMessage = "_-0nV" (String#4580, DoABC#2)
// sendChatMessage = "_-3D4" (String#7576, DoABC#2)
// sendWaveMessage = "_-3BE" (String#7533, DoABC#2)
// sendSignMessage = "_-1UA" (String#5435, DoABC#2)
// sendShoutMessage = "_-0Bn" (String#3791, DoABC#2)
// sendWhisperMessage = "_-2qY" (String#7086, DoABC#2)
// sendDanceMessage = "_-1SB" (String#5401, DoABC#2)
// sendCreditFurniRedeemMessage = "_-2gO" (String#6879, DoABC#2)
// letUserIn = "_-0KK" (String#3961, DoABC#2)
// sendVote = "_-2W0" (String#6684, DoABC#2)
// kickUser = "_-3-1" (String#7287, DoABC#2)
// banUser = "_-1Hb" (String#5200, DoABC#2)
// assignRights = "_-32C" (String#7350, DoABC#2)
// removeRights = "_-MI" (String#8128, DoABC#2)
// pickUpPet = "_-Tm" (String#8281, DoABC#2)
// kickBot = "_-YS" (String#8382, DoABC#2)
// requestPetCommands = "_-q5" (String#8711, DoABC#2)
// sendChangeMottoMessage = "_-mX" (String#8653, DoABC#2)
// isPrivateRoom = "_-1Wr" (String#5489, DoABC#2)
// sendUpdateClothingChangeFurniture = "_-mI" (String#8649, DoABC#2)
// sendChatTypingMessage = "_-1Ys" (String#5539, DoABC#2)
// sendRoomDimmerGetPresetsMessage = "_-0A0" (String#3758, DoABC#2)
// sendRoomDimmerSavePresetMessage = "_-0uH" (String#4730, DoABC#2)
// sendRoomDimmerChangeStateMessage = "_-23-" (String#6105, DoABC#2)
// quit = "_-3A4" (String#7513, DoABC#2)
// sendPollStartMessage = "_-0ug" (String#4736, DoABC#2)
// sendPollRejectMessage = "_-IP" (String#8047, DoABC#2)
// sendPollAnswerMessage = "_-0Tt" (String#4177, DoABC#2)


