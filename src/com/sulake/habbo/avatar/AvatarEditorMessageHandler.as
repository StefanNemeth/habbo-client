
package com.sulake.habbo.avatar
{
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.communication.messages.incoming.avatar.WardrobeMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserRightsMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.avatar.SaveWardrobeOutfitMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.avatar.GetWardrobeMessageComposer;
    import com.sulake.habbo.avatar.enum.AvatarEditorInstanceId;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class AvatarEditorMessageHandler 
    {

        private var _communication:IHabboCommunicationManager;
        private var _controller:HabboAvatarEditorManager;

        public function AvatarEditorMessageHandler(_arg_1:HabboAvatarEditorManager, _arg_2:IHabboCommunicationManager)
        {
            this._controller = _arg_1;
            this._communication = _arg_2;
            this._communication.addHabboConnectionMessageEvent(new WardrobeMessageEvent(this.onWardrobe));
            this._communication.addHabboConnectionMessageEvent(new UserRightsMessageEvent(this.onUserRights));
        }
        public function dispose():void
        {
            this._communication = null;
            this._controller = null;
        }
        public function saveWardrobeOutfit(_arg_1:int, _arg_2:IOutfit):void
        {
            if (this._communication == null){
                return;
            };
            var _local_3:SaveWardrobeOutfitMessageComposer = new SaveWardrobeOutfitMessageComposer(_arg_1, _arg_2.figure, _arg_2.gender);
            this._communication.getHabboMainConnection(null).send(_local_3);
            _local_3.dispose();
            _local_3 = null;
        }
        public function getWardrobe():void
        {
            if (this._communication == null){
                return;
            };
            var _local_1:GetWardrobeMessageComposer = new GetWardrobeMessageComposer();
            this._communication.getHabboMainConnection(null).send(_local_1);
            _local_1.dispose();
            _local_1 = null;
        }
        private function onWardrobe(_arg_1:WardrobeMessageEvent):void
        {
            if ((((_arg_1 == null)) || (!(this._controller)))){
                return;
            };
            var _local_2:HabboAvatarEditor = this._controller.getEditor(AvatarEditorInstanceId._SafeStr_6812);
            if (_local_2){
                _local_2.wardrobe.updateSlots(_arg_1.state, _arg_1.outfits);
            };
        }
        private function onUserRights(_arg_1:IMessageEvent):void
        {
            if ((((_arg_1 == null)) || (!(this._controller)))){
                return;
            };
            var _local_2:HabboAvatarEditor = this._controller.getEditor(AvatarEditorInstanceId._SafeStr_6812);
            if (_local_2){
                _local_2.clubMemberLevel = this._controller.sessionData.clubLevel;
                _local_2.update();
            };
        }

    }
}//package com.sulake.habbo.avatar

// onUserRights = "_-36C" (String#632, DoABC#2)
// getEditor = "_-z1" (String#24651, DoABC#2)
// UserRightsMessageEvent = "_-8n" (String#7837, DoABC#2)
// AvatarEditorInstanceId = "_-3Bn" (String#21953, DoABC#2)
// AvatarEditorMessageHandler = "_-2jV" (String#6945, DoABC#2)
// GetWardrobeMessageComposer = "_-1xw" (String#18884, DoABC#2)
// WardrobeMessageEvent = "_-37-" (String#7448, DoABC#2)
// SaveWardrobeOutfitMessageComposer = "_-2yS" (String#21409, DoABC#2)
// IOutfit = "_-058" (String#3668, DoABC#2)
// _controller = "_-18D" (String#59, DoABC#2)
// sessionData = "_-3Fb" (String#22101, DoABC#2)
// addHabboConnectionMessageEvent = "_-0r" (String#4663, DoABC#2)
// getHabboMainConnection = "_-0AQ" (String#809, DoABC#2)
// _SafeStr_6812 = "_-2OT" (String#19984, DoABC#2)
// outfits = "_-334" (String#21623, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// saveWardrobeOutfit = "_-2TF" (String#20173, DoABC#2)
// getWardrobe = "_-1jT" (String#18264, DoABC#2)
// updateSlots = "_-1Dr" (String#5140, DoABC#2)


