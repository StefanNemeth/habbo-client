
package com.sulake.habbo.messenger
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.friendlist.IHabboFriendList;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.messenger.domain.Conversations;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboSoundManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDAvatarRenderManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboFriendList;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.communication.messages.incoming.friendlist.MessengerInitEvent;
    import com.sulake.habbo.messenger.domain.ConversationsDeps;
    import com.sulake.habbo.communication.messages.incoming.friendlist.NewConsoleMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.RoomInviteEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.InstantMessageErrorEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.messenger.domain.Conversation;
    import com.sulake.habbo.friendlist.IFriend;
    import flash.display.BitmapData;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.habbo.sound.HabboSoundTypesEnum;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.window.events.WindowMouseEvent;
    import flash.utils.Dictionary;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.NewConsoleMessageMessageParser;
    import com.sulake.habbo.messenger.domain.Message;
    import com.sulake.habbo.communication.messages.parser.friendlist.RoomInviteMessageParser;
    import com.sulake.habbo.communication.messages.parser.friendlist.InstantMessageErrorMessageParser;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.*;
    import com.sulake.habbo.messenger.domain.*;

    public class HabboMessenger extends Component implements IHabboMessenger, IAvatarImageListener 
    {

        public static const _SafeStr_11259:String = "face";

        private var _windowManager:IHabboWindowManager;
        private var _communication:IHabboCommunicationManager;
        private var _configuration:IHabboConfigurationManager;
        private var _localization:IHabboLocalizationManager;
        private var _friendList:IHabboFriendList;
        private var _SafeStr_11072:IAvatarRenderManager;
        private var _conversations:Conversations;
        private var _messengerView:MessengerView;
        private var _soundManager:IHabboSoundManager;

        public function HabboMessenger(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            lock();
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
            queueInterface(new IIDHabboSoundManager(), this.onSoundManagerReady);
            queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationReady);
            queueInterface(new IIDAvatarRenderManager(), this.onAvatarRenderedReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationReady);
            queueInterface(new IIDHabboLocalizationManager(), this.onLocalizationReady);
            queueInterface(new IIDHabboFriendList(), this.onFriendListReady);
        }
        override public function dispose():void
        {
            if (this._soundManager){
                this._soundManager.release(new IIDHabboSoundManager());
                this._soundManager = null;
            };
            if (this._windowManager){
                this._windowManager.release(new IIDHabboWindowManager());
                this._windowManager = null;
            };
            if (this._communication){
                this._communication.release(new IIDHabboCommunicationManager());
                this._communication = null;
            };
            if (this._configuration){
                this._configuration.release(new IIDHabboConfigurationManager());
                this._configuration = null;
            };
            if (this._localization){
                this._localization.release(new IIDHabboLocalizationManager());
                this._localization = null;
            };
            if (this._friendList){
                this._friendList.release(new IIDHabboFriendList());
                this._friendList = null;
            };
            if (this._SafeStr_11072){
                this._SafeStr_11072.release(new IIDAvatarRenderManager());
                this._SafeStr_11072 = null;
            };
            if (this._messengerView){
                this._messengerView.dispose();
                this._messengerView = null;
            };
            super.dispose();
        }
        private function onSoundManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._soundManager = (_arg_2 as IHabboSoundManager);
            this.tryInit();
        }
        private function onWindowManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._windowManager = (_arg_2 as IHabboWindowManager);
            this.tryInit();
        }
        private function onCommunicationReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._communication = (_arg_2 as IHabboCommunicationManager);
            this.tryInit();
        }
        private function onAvatarRenderedReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._SafeStr_11072 = (_arg_2 as IAvatarRenderManager);
            this.tryInit();
        }
        private function onConfigurationReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._configuration = (_arg_2 as IHabboConfigurationManager);
            this.tryInit();
        }
        private function onLocalizationReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._localization = (_arg_2 as IHabboLocalizationManager);
            this.tryInit();
        }
        private function onFriendListReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._friendList = (_arg_2 as IHabboFriendList);
            this.tryInit();
        }
        private function tryInit():void
        {
            if (((((((((((((this._windowManager) && (this._communication))) && (this._configuration))) && (this._localization))) && (this._friendList))) && (this._SafeStr_11072))) && (this._soundManager))){
                unlock();
                this._communication.addHabboConnectionMessageEvent(new MessengerInitEvent(this.onMessengerInit));
            };
        }
        private function onMessengerInit(_arg_1:IMessageEvent):void
        {
            this._conversations = new Conversations(new ConversationsDeps(this));
            this._messengerView = new MessengerView(this);
            this._communication.addHabboConnectionMessageEvent(new NewConsoleMessageEvent(this.onNewConsoleMessage));
            this._communication.addHabboConnectionMessageEvent(new RoomInviteEvent(this.onRoomInvite));
            this._communication.addHabboConnectionMessageEvent(new InstantMessageErrorEvent(this.onInstantMessageError));
        }
        public function startConversation(_arg_1:int):void
        {
            var _local_2:Conversation = this._conversations.addConversation(_arg_1);
            if (_local_2 == null){
                Logger.log((("No friend " + _arg_1) + " found. Shouldn't happen"));
            }
            else {
                this._conversations.setSelected(_local_2);
                this._messengerView.openMessenger();
                this._messengerView.refresh();
            };
        }
        public function getActiveConversation():IConversation
        {
            return (((this._conversations) ? this._conversations.findSelectedConversation() : null));
        }
        public function setFollowingAllowed(_arg_1:int, _arg_2:Boolean):void
        {
            this._conversations.setFollowingAllowedAndUpdateView(_arg_1, _arg_2);
        }
        public function setOnlineStatus(_arg_1:int, _arg_2:Boolean):void
        {
            this._conversations.setOnlineStatusAndUpdateView(_arg_1, _arg_2);
        }
        public function createConversation(_arg_1:int):Conversation
        {
            var _local_2:IFriend = this._friendList.getFriend(_arg_1);
            if (_local_2 == null){
                Logger.log(("No friend found with: " + _arg_1));
                return (null);
            };
            Logger.log(((((((("A FRIEND FOUND: " + _local_2.id) + ", ") + _local_2.name) + ", ") + _local_2.gender) + ", ") + _local_2.figure));
            return (new Conversation(_local_2.id, _local_2.name, _local_2.figure, _local_2.followingAllowed));
        }
        public function getAvatarFaceBitmap(_arg_1:String):BitmapData
        {
            var _local_3:BitmapData;
            var _local_2:IAvatarImage = this._SafeStr_11072.createAvatarImage(_arg_1, AvatarScaleType._SafeStr_4337, null, this);
            if (_local_2){
                _local_3 = _local_2.getImage(AvatarSetType._SafeStr_4458, true);
                _local_2.dispose();
                return (_local_3);
            };
            return (null);
        }
        public function send(_arg_1:IMessageComposer):void
        {
            this._communication.getHabboMainConnection(null).send(_arg_1);
        }
        public function playSendSound():void
        {
            if (this._soundManager != null){
                this._soundManager.playSound(HabboSoundTypesEnum._SafeStr_11737);
            };
        }
        public function isOpen():Boolean
        {
            return (((this._messengerView) && (this._messengerView.isMessengerOpen())));
        }
        public function toggleMessenger():void
        {
            if (this._messengerView){
                if (this._messengerView.isMessengerOpen()){
                    this._messengerView.close();
                }
                else {
                    this._messengerView.openMessenger();
                };
            };
        }
        public function openHabboWebPage(linkAlias:String, params:Dictionary, event:WindowEvent):void
        {
            params["predefined"] = this.getPageParam("url.prefix");
            var url:String = this.getVariable(linkAlias, params);
            var webWindowName:String = "habboMain";
            try {
                HabboWebTools.navigateToURL(url, webWindowName);
            }
            catch(e:Error) {
                Logger.log(("GOT ERROR: " + e));
            };
            var wme:WindowMouseEvent = (event as WindowMouseEvent);
        }
        public function getText(_arg_1:String):String
        {
            return (this._localization.getKey(_arg_1, _arg_1));
        }
        private function getPageParam(_arg_1:String):String
        {
            var _local_2:String;
            if (_arg_1 == "url.prefix"){
                _local_2 = "d31.web.varoke.net";
                _local_2 = this._configuration.getKey("url.prefix", _local_2);
                _local_2 = _local_2.replace("http://", "");
                return (_local_2.replace("https://", ""));
            };
            return (null);
        }
        private function getVariable(_arg_1:String, _arg_2:Dictionary):String
        {
            return (this._configuration.getKey(_arg_1, _arg_1, _arg_2));
        }
        private function onNewConsoleMessage(_arg_1:IMessageEvent):void
        {
            var _local_2:NewConsoleMessageMessageParser = (_arg_1 as NewConsoleMessageEvent).getParser();
            Logger.log(((("Received console msg: " + _local_2.messageText) + ", ") + _local_2.senderId));
            var _local_3:Message = new Message(Message._SafeStr_4667, _local_2.senderId, _local_2.messageText, Util.getFormattedNow());
            this.addMsg(_local_3);
        }
        private function onRoomInvite(_arg_1:IMessageEvent):void
        {
            var _local_2:RoomInviteMessageParser = (_arg_1 as RoomInviteEvent).getParser();
            var _local_3:Message = new Message(Message._SafeStr_4671, _local_2.senderId, ((this.getText("messenger.invitation") + " ") + _local_2.messageText), Util.getFormattedNow());
            this.addMsg(_local_3);
        }
        private function addMsg(_arg_1:Message):void
        {
            this._conversations.addMessageAndUpdateView(_arg_1);
            if (!this._messengerView.isMessengerOpen()){
                if (this._soundManager != null){
                    this._soundManager.playSound(HabboSoundTypesEnum._SafeStr_11740);
                };
            };
        }
        private function onInstantMessageError(_arg_1:IMessageEvent):void
        {
            var _local_2:InstantMessageErrorMessageParser = (_arg_1 as InstantMessageErrorEvent).getParser();
            var _local_3:Message = new Message(Message._SafeStr_4669, _local_2.userId, this.getInstantMessageErrorText(_local_2.errorCode), Util.getFormattedNow());
            this._conversations.addMessageAndUpdateView(_local_3);
        }
        private function getInstantMessageErrorText(_arg_1:int):String
        {
            if (_arg_1 == 3){
                return (this.getText("messenger.error.receivermuted"));
            };
            if (_arg_1 == 4){
                return (this.getText("messenger.error.sendermuted"));
            };
            if (_arg_1 == 5){
                return (this.getText("messenger.error.offline"));
            };
            if (_arg_1 == 6){
                return (this.getText("messenger.error.notfriend"));
            };
            if (_arg_1 == 7){
                return (this.getText("messenger.error.busy"));
            };
            return (("Unknown im error " + _arg_1));
        }
        public function refreshButton(_arg_1:IWindowContainer, _arg_2:String, _arg_3:Boolean, _arg_4:Function, _arg_5:int):void
        {
            var _local_6:IBitmapWrapperWindow = (_arg_1.findChildByName(_arg_2) as IBitmapWrapperWindow);
            this.refreshButtonDir(_local_6, _arg_2, _arg_3, _arg_4, _arg_5);
        }
        public function refreshButtonDir(_arg_1:IBitmapWrapperWindow, _arg_2:String, _arg_3:Boolean, _arg_4:Function, _arg_5:int):void
        {
            if (!_arg_3){
                _arg_1.visible = false;
            }
            else {
                this.prepareButton(_arg_1, _arg_2, _arg_4, _arg_5);
                _arg_1.visible = true;
            };
        }
        private function prepareButton(_arg_1:IBitmapWrapperWindow, _arg_2:String, _arg_3:Function, _arg_4:int):void
        {
            _arg_1.id = _arg_4;
            if (_arg_1.bitmap != null){
                return;
            };
            _arg_1.bitmap = this.getButtonImage(_arg_2);
            _arg_1.width = _arg_1.bitmap.width;
            _arg_1.height = _arg_1.bitmap.height;
            _arg_1.procedure = _arg_3;
        }
        public function getButtonImage(_arg_1:String):BitmapData
        {
            var _local_5:BitmapData;
            var _local_2:IAsset = assets.getAssetByName((_arg_1 + "_png"));
            var _local_3:BitmapDataAsset = (_local_2 as BitmapDataAsset);
            Logger.log(("GETTING ASSET: " + _arg_1));
            var _local_4:BitmapData = (_local_3.content as BitmapData);
            Logger.log(((("GOT ASSET: " + _local_2) + ", ") + _local_4));
            _local_5 = new BitmapData(_local_4.width, _local_4.height, true, 0);
            _local_5.draw(_local_4);
            return (_local_5);
        }
        public function getXmlWindow(_arg_1:String):IWindow
        {
            var _local_2:IAsset = assets.getAssetByName((_arg_1 + "_xml"));
            var _local_3:XmlAsset = XmlAsset(_local_2);
            return (this._windowManager.buildFromXML(XML(_local_3.content)));
        }
        public function isEmbeddedMinimailEnabled():Boolean
        {
            var _local_1:String = this._configuration.getKey("client.minimail.embed.enabled");
            return ((_local_1 == "true"));
        }
        public function avatarImageReady(_arg_1:String):void
        {
            if (this._messengerView){
                this._messengerView.refresh();
            };
        }
        public function get windowManager():IHabboWindowManager
        {
            return (this._windowManager);
        }
        public function get conversations():Conversations
        {
            return (this._conversations);
        }
        public function get messengerView():MessengerView
        {
            return (this._messengerView);
        }

    }
}//package com.sulake.habbo.messenger

// IID = "_-3KV" (String#7712, DoABC#2)
// onCommunicationReady = "_-3Ix" (String#372, DoABC#2)
// onFriendListReady = "_-1N-" (String#849, DoABC#2)
// toggleMessenger = "_-2E7" (String#1838, DoABC#2)
// onNewConsoleMessage = "_-1Gn" (String#5184, DoABC#2)
// onRoomInvite = "_-3Fn" (String#7626, DoABC#2)
// getActiveConversation = "_-0WJ" (String#4233, DoABC#2)
// _SafeStr_11072 = "_-2PE" (String#1873, DoABC#2)
// setFollowingAllowed = "_-32S" (String#7358, DoABC#2)
// setOnlineStatus = "_-0QG" (String#4097, DoABC#2)
// openHabboWebPage = "_-2w" (String#7202, DoABC#2)
// _SafeStr_11259 = "_-2en" (String#20637, DoABC#2)
// isEmbeddedMinimailEnabled = "_-2F1" (String#19604, DoABC#2)
// getVariable = "_-0xX" (String#4801, DoABC#2)
// onAvatarRenderedReady = "_-NF" (String#8149, DoABC#2)
// onMessengerInit = "_-iQ" (String#8566, DoABC#2)
// prepareButton = "_-08W" (String#807, DoABC#2)
// isMessengerOpen = "_-1dh" (String#18044, DoABC#2)
// openMessenger = "_-04S" (String#14221, DoABC#2)
// conversations = "_-1Zf" (String#17877, DoABC#2)
// playSendSound = "_-B8" (String#22660, DoABC#2)
// _conversations = "_-2W2" (String#20283, DoABC#2)
// _messengerView = "_-LK" (String#23059, DoABC#2)
// tryInit = "_-tw" (String#24445, DoABC#2)
// onInstantMessageError = "_-04A" (String#14209, DoABC#2)
// _SafeStr_11737 = "_-0u3" (String#16205, DoABC#2)
// getPageParam = "_-2jD" (String#20812, DoABC#2)
// addMsg = "_-1kg" (String#18316, DoABC#2)
// _SafeStr_11740 = "_-WS" (String#23509, DoABC#2)
// getInstantMessageErrorText = "_-3J0" (String#22239, DoABC#2)
// refreshButtonDir = "_-1dZ" (String#18037, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// AvatarScaleType = "_-2lF" (String#20893, DoABC#2)
// HabboWebTools = "_-2pX" (String#21059, DoABC#2)
// HabboSoundTypesEnum = "_-0vP" (String#16253, DoABC#2)
// IConversation = "_-1me" (String#5792, DoABC#2)
// ConversationsDeps = "_-Ol" (String#8180, DoABC#2)
// RoomInviteEvent = "_-38C" (String#7476, DoABC#2)
// IFriend = "_-2ET" (String#6332, DoABC#2)
// MessengerView = "_-2hj" (String#6900, DoABC#2)
// RoomInviteMessageParser = "_-1OK" (String#17445, DoABC#2)
// InstantMessageErrorEvent = "_-3Eh" (String#22062, DoABC#2)
// NewConsoleMessageMessageParser = "_-01u" (String#14124, DoABC#2)
// InstantMessageErrorMessageParser = "_-1eQ" (String#5636, DoABC#2)
// Util = "_-1ve" (String#445, DoABC#2)
// MessengerInitEvent = "_-0pu" (String#4632, DoABC#2)
// Message = "_-0r8" (String#4665, DoABC#2)
// Conversations = "_-3Fq" (String#7628, DoABC#2)
// Conversation = "_-Ej" (String#7965, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// IHabboSoundManager = "_-0vD" (String#4750, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// isOpen = "_-2i4" (String#897, DoABC#2)
// _SafeStr_4337 = "_-1dF" (String#18025, DoABC#2)
// IAvatarRenderManager = "_-C9" (String#7915, DoABC#2)
// _SafeStr_4458 = "_-327" (String#21586, DoABC#2)
// getImage = "_-eg" (String#2150, DoABC#2)
// addHabboConnectionMessageEvent = "_-0r" (String#4663, DoABC#2)
// getHabboMainConnection = "_-0AQ" (String#809, DoABC#2)
// senderId = "_-2GI" (String#19654, DoABC#2)
// messageText = "_-0EC" (String#14615, DoABC#2)
// createConversation = "_-Qw" (String#8225, DoABC#2)
// _SafeStr_4667 = "_-0T3" (String#15172, DoABC#2)
// _SafeStr_4669 = "_-372" (String#21770, DoABC#2)
// _SafeStr_4671 = "_-28X" (String#19351, DoABC#2)
// findSelectedConversation = "_-0wy" (String#16309, DoABC#2)
// addConversation = "_-230" (String#19135, DoABC#2)
// addMessageAndUpdateView = "_-2aB" (String#20449, DoABC#2)
// setOnlineStatusAndUpdateView = "_-03o" (String#14194, DoABC#2)
// setFollowingAllowedAndUpdateView = "_-26j" (String#19280, DoABC#2)
// followingAllowed = "_-1-Z" (String#1598, DoABC#2)
// getFormattedNow = "_-1y3" (String#18889, DoABC#2)
// avatarImageReady = "_-i" (String#8553, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// IHabboMessenger = "_-0EF" (String#3832, DoABC#2)
// IAvatarImageListener = "_-06N" (String#3688, DoABC#2)
// getFriend = "_-WG" (String#8329, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// onWindowManagerReady = "_-34x" (String#94, DoABC#2)
// onLocalizationReady = "_-uK" (String#167, DoABC#2)
// onSoundManagerReady = "_-2hg" (String#369, DoABC#2)
// IHabboFriendList = "_-29N" (String#6237, DoABC#2)
// onConfigurationReady = "_-x5" (String#190, DoABC#2)


