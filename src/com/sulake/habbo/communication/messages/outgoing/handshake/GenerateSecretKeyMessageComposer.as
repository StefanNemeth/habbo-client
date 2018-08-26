
package com.sulake.habbo.communication.messages.outgoing.handshake
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import flash.utils.ByteArray;
    import com.sulake.core.communication.encryption.CryptoTools;

    public class GenerateSecretKeyMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_4605:String;

        public function GenerateSecretKeyMessageComposer(_arg_1:String)
        {
            var _local_2:ByteArray = new ByteArray();
            _local_2.writeMultiByte(_arg_1, "iso-8859-1");
            var _local_3:ByteArray = new ByteArray();
            var _local_4:RSAKey = RSAKey.parsePublicKey(((("90e0d43db75b5b8ffc8a77e31cc9758fa43fe69f14184bef64e61574beb18fac" + "32520566f6483b246ddc3c991cb366bae975a6f6b733fd9570e8e72efc1e511f") + "f6e2bcac49bf9237222d7c2bf306300d4dfc37113bcc84fa4401c9e4f2b4c41a") + "de9654ef00bd592944838fae21a05ea59fecc961766740c82d84f4299dfb33dd"), "3");
            _local_4.encrypt(_local_2, _local_3, _local_2.length);
            _local_4.dispose();
            this._SafeStr_4605 = CryptoTools.byteArrayToHexString(_local_3);
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([this._SafeStr_4605]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.handshake

// GenerateSecretKeyMessageComposer = "_-30y" (String#7326, DoABC#2)
// CryptoTools = "_-1UR" (String#17682, DoABC#2)
// RSAKey = "_-0Iu" (String#3932, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _SafeStr_4605 = "_-kS" (String#8611, DoABC#2)
// parsePublicKey = "_-360" (String#21729, DoABC#2)
// encrypt = "_-0NA" (String#1460, DoABC#2)
// byteArrayToHexString = "_-2jw" (String#20842, DoABC#2)


