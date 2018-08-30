
package com.sulake.habbo.inventory.badges
{
    import com.sulake.habbo.inventory.IInventoryModel;
    import com.sulake.habbo.inventory.HabboInventory;
    import com.sulake.core.utils.Map;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.session.events.BadgeImageReadyEvent;
    import com.sulake.habbo.communication.messages.outgoing.inventory.badges.GetBadgesComposer;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.habbo.communication.messages.outgoing.inventory.badges.SetActivatedBadgesComposer;
    import com.sulake.habbo.inventory.enum.InventoryCategory;
    import flash.events.Event;
    import com.sulake.habbo.inventory.events.HabboInventoryTrackingEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.communication.messages.outgoing.notifications.ResetUnseenItemsComposer;
    import com.sulake.habbo.communication.messages.outgoing.notifications.UnseenItemCategoryEnum;

    public class BadgesModel implements IInventoryModel 
    {

        public static const _SafeStr_8540:int = -1;
        public static const _SafeStr_8541:int = 0;
        public static const _SafeStr_8542:int = 1;

        private const _maxActiveCount:int = 5;

        private var _controller:HabboInventory;
        private var _view:BadgesView;
        private var _badges:Array;
        private var _SafeStr_8544:Array;
        private var _SafeStr_8222:Map;
        private var _SafeStr_8545:Array;
        private var _assets:IAssetLibrary;
        private var _communication:IHabboCommunicationManager;
        private var _sessionDataManager:ISessionDataManager;
        private var _windowManager:IHabboWindowManager;
        private var _disposed:Boolean = false;

        public function BadgesModel(_arg_1:HabboInventory, _arg_2:IHabboWindowManager, _arg_3:IHabboCommunicationManager, _arg_4:IAssetLibrary, _arg_5:ISessionDataManager)
        {
            this._controller = _arg_1;
            this._windowManager = _arg_2;
            this._badges = new Array();
            this._SafeStr_8544 = new Array();
            this._assets = _arg_4;
            this._communication = _arg_3;
            this._sessionDataManager = _arg_5;
            this._sessionDataManager.events.addEventListener(BadgeImageReadyEvent.BIRE_BADGE_IMAGE_READY, this.onBadgeImageReady);
            this._view = new BadgesView(this, _arg_2, _arg_4);
            this._SafeStr_8545 = [];
            this._SafeStr_8222 = new Map();
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            if (this._disposed){
                return;
            };
            this._disposed = true;
            this._controller = null;
            this._windowManager = null;
            this._badges = null;
            this._SafeStr_8544 = null;
            if (this._SafeStr_8222){
                this._SafeStr_8222.dispose();
                this._SafeStr_8222 = null;
            };
            if (this._view != null){
                this._view.dispose();
                this._view = null;
            };
            this._assets = null;
            this._communication = null;
            if (this._sessionDataManager != null){
                this._sessionDataManager.events.removeEventListener(BadgeImageReadyEvent.BIRE_BADGE_IMAGE_READY, this.onBadgeImageReady);
                this._sessionDataManager = null;
            };
        }
        public function requestInitialization(_arg_1:int=0):void
        {
            this._communication.getHabboMainConnection(null).send(new GetBadgesComposer());
        }
        public function getMaxActiveCount():int
        {
            return (this._maxActiveCount);
        }
        public function updateView():void
        {
            if (this._view != null){
                this._view.updateAll();
            };
        }
        private function updateActionView():void
        {
            if (this._view != null){
                this._view.updateActionView();
            };
        }
        private function startWearingBadge(_arg_1:Badge):void
        {
            this._SafeStr_8544.push(_arg_1);
            _arg_1.isInUse = true;
        }
        private function stopWearingBadge(_arg_1:Badge):void
        {
            var _local_2:int;
            while (_local_2 < this._SafeStr_8544.length) {
                if (this._SafeStr_8544[_local_2] == _arg_1){
                    this._SafeStr_8544.splice(_local_2, 1);
                    _arg_1.isInUse = false;
                    return;
                };
                _local_2++;
            };
        }
        public function updateBadge(_arg_1:String, _arg_2:Boolean, _arg_3:int=0):void
        {
            var _local_5:IAsset;
            var _local_6:XmlAsset;
            var _local_7:IWindowContainer;
            var _local_8:BitmapDataAsset;
            var _local_9:IBitmapWrapperWindow;
            var _local_10:Boolean;
            var _local_11:Badge;
            if (_arg_3 > 0){
                this._SafeStr_8222.add(_arg_1, _arg_3);
            };
            var _local_4:Badge = this.getBadge(_arg_1);
            if (_local_4 != null){
                if (_local_4.isInUse != _arg_2){
                    if (_arg_2){
                        this.startWearingBadge(_local_4);
                    }
                    else {
                        this.stopWearingBadge(_local_4);
                    };
                };
            }
            else {
                _local_5 = this._assets.getAssetByName("inventory_thumb_xml");
                _local_6 = XmlAsset(_local_5);
                _local_7 = (this._windowManager.buildFromXML(XML(_local_6.content)) as IWindowContainer);
                _local_8 = (this._assets.getAssetByName("thumb_selected_outline_png") as BitmapDataAsset);
                _local_9 = (_local_7.findChildByName("outline") as IBitmapWrapperWindow);
                _local_9.bitmap = (_local_8.content as BitmapData);
                _local_9.disposesBitmap = false;
                _local_10 = !((this._SafeStr_8545.indexOf(_arg_3) == -1));
                _local_11 = new Badge(_arg_1, _local_7, _local_10);
                _local_11.iconImage = this._sessionDataManager.getBadgeImage(_arg_1);
                if (_local_10){
                    this._badges.unshift(_local_11);
                }
                else {
                    this._badges.push(_local_11);
                };
                if (_arg_2){
                    this.startWearingBadge(_local_11);
                };
            };
        }
        private function getBadge(_arg_1:String):Badge
        {
            var _local_3:Badge;
            var _local_2:int;
            while (_local_2 < this._badges.length) {
                _local_3 = this._badges[_local_2];
                if (_local_3.type == _arg_1){
                    return (_local_3);
                };
                _local_2++;
            };
            return (null);
        }
        public function removeBadge(_arg_1:String):void
        {
            var _local_3:Badge;
            var _local_2:int;
            while (_local_2 < this._badges.length) {
                _local_3 = this._badges[_local_2];
                if (_local_3.type == _arg_1){
                    this._badges.splice(_local_2, 1);
                    this.stopWearingBadge(_local_3);
                    this.updateView();
                    return;
                };
                _local_2++;
            };
        }
        public function toggleBadgeWearing(_arg_1:String):void
        {
            var _local_2:Badge = this.getBadge(_arg_1);
            if (_local_2 != null){
                if (_local_2.isInUse){
                    this.stopWearingBadge(_local_2);
                }
                else {
                    this.startWearingBadge(_local_2);
                };
                this.saveBadgeSelection();
            };
        }
        public function saveBadgeSelection():void
        {
            var _local_4:Badge;
            var _local_1:SetActivatedBadgesComposer = new SetActivatedBadgesComposer();
            var _local_2:Array = this.getBadges(_SafeStr_8542);
            var _local_3:int;
            while (_local_3 < _local_2.length) {
                _local_4 = _local_2[_local_3];
                _local_1.addActivatedBadge(_local_4.type);
                _local_3++;
            };
            this._communication.getHabboMainConnection(null).send(_local_1);
        }
        public function setBadgeSelected(_arg_1:String):void
        {
            var _local_3:Badge;
            var _local_2:int;
            while (_local_2 < this._badges.length) {
                _local_3 = (this._badges[_local_2] as Badge);
                if (_local_3 != null){
                    _local_3.isSelected = (_local_3.type == _arg_1);
                };
                _local_2++;
            };
            this.updateActionView();
        }
        public function forceSelection():void
        {
            var _local_1:Badge = this.getSelectedBadge();
            if (_local_1 != null){
                return;
            };
            var _local_2:Array = this.getBadges(_SafeStr_8541);
            if (((!((_local_2 == null))) && ((_local_2.length > 0)))){
                _local_1 = (_local_2[0] as Badge);
                _local_1.isSelected = true;
                this.updateView();
                return;
            };
            var _local_3:Array = this.getBadges(_SafeStr_8542);
            if (((!((_local_3 == null))) && ((_local_3.length > 0)))){
                _local_1 = (_local_3[0] as Badge);
                _local_1.isSelected = true;
                this.updateView();
            };
        }
        public function getSelectedBadge(_arg_1:int=-1):Badge
        {
            var _local_4:Badge;
            var _local_2:Array = this.getBadges(_arg_1);
            var _local_3:int;
            while (_local_3 < _local_2.length) {
                _local_4 = _local_2[_local_3];
                if (_local_4.isSelected){
                    return (_local_4);
                };
                _local_3++;
            };
            return (null);
        }
        public function getBadges(_arg_1:int=-1):Array
        {
            var _local_2:Array;
            var _local_3:Badge;
            switch (_arg_1){
                case _SafeStr_8540:
                    return (this._badges);
                case _SafeStr_8541:
                    _local_2 = new Array();
                    for each (_local_3 in this._badges) {
                        if (!_local_3.isInUse){
                            _local_2.push(_local_3);
                        };
                    };
                    return (_local_2);
                case _SafeStr_8542:
                    return (this._SafeStr_8544);
            };
            Logger.log("Unexpected filter. Returning an empty array to maintain backward compatibility");
            return (new Array());
        }
        public function getBadgeFromActive(_arg_1:int):Badge
        {
            return (this.getItemInIndex(_arg_1, _SafeStr_8542));
        }
        public function getBadgeFromInactive(_arg_1:int):Badge
        {
            return (this.getItemInIndex(_arg_1, _SafeStr_8541));
        }
        public function getItemInIndex(_arg_1:int, _arg_2:int=-1):Badge
        {
            var _local_3:Array = this.getBadges(_arg_2);
            if ((((_arg_1 < 0)) || ((_arg_1 >= _local_3.length)))){
                return (null);
            };
            return (_local_3[_arg_1]);
        }
        public function getWindowContainer():IWindowContainer
        {
            return (this._view.getWindowContainer());
        }
        private function onBadgeImageReady(_arg_1:BadgeImageReadyEvent):void
        {
            var _local_2:Badge = this.getBadge(_arg_1.badgeId);
            if (_local_2 != null){
                _local_2.iconImage = _arg_1.badgeImage.clone();
                this.updateActionView();
            };
        }
        public function closingInventoryView():void
        {
            if (this._view.isVisible){
                this.resetUnseenItems();
            };
        }
        public function categorySwitch(_arg_1:String):void
        {
            if ((((_arg_1 == InventoryCategory._SafeStr_7061)) && (this._controller.isVisible))){
                this._controller.events.dispatchEvent(new Event(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_BADGES));
            };
        }
        public function subCategorySwitch(_arg_1:String):void
        {
        }
        public function get controller():HabboInventory
        {
            return (this._controller);
        }
        public function addUnseenBadges(_arg_1:Array):void
        {
            var _local_2:int;
            if (_arg_1 == null){
                return;
            };
            for each (_local_2 in _arg_1) {
                if (this._SafeStr_8545.indexOf(_local_2) == -1){
                    this._SafeStr_8545.push(_local_2);
                };
            };
        }
        public function getUnseenItemCount():int
        {
            return (this._SafeStr_8545.length);
        }
        public function resetUnseenItems():void
        {
            var _local_2:Badge;
            if (!this._controller.isMainViewActive){
                return;
            };
            var _local_1:IConnection = this._communication.getHabboMainConnection(null);
            if (((this._SafeStr_8545) && ((this._SafeStr_8545.length > 0)))){
                _local_1.send(new ResetUnseenItemsComposer(UnseenItemCategoryEnum._SafeStr_6770));
                this._SafeStr_8545 = [];
                for each (_local_2 in this._badges) {
                    _local_2.isUnseen = false;
                };
                this.updateView();
                this._controller.updateUnseenItemCounts();
            };
        }

    }
}//package com.sulake.habbo.inventory.badges

// ISessionDataManager = "_-Bk" (String#7907, DoABC#2)
// BadgeImageReadyEvent = "_-03M" (String#14177, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// InventoryCategory = "_-04Y" (String#14224, DoABC#2)
// IInventoryModel = "_-Fh" (String#7987, DoABC#2)
// BadgesModel = "_-2zV" (String#7278, DoABC#2)
// UnseenItemCategoryEnum = "_-0Ua" (String#15227, DoABC#2)
// Badge = "_-244" (String#19179, DoABC#2)
// ResetUnseenItemsComposer = "_-pv" (String#24269, DoABC#2)
// GetBadgesComposer = "_-0TR" (String#15188, DoABC#2)
// SetActivatedBadgesComposer = "_-12m" (String#16571, DoABC#2)
// badgeId = "_-g6" (String#23896, DoABC#2)
// _controller = "_-18D" (String#59, DoABC#2)
// isInUse = "_-2LN" (String#6469, DoABC#2)
// getHabboMainConnection = "_-0AQ" (String#809, DoABC#2)
// BIRE_BADGE_IMAGE_READY = "_-38f" (String#21828, DoABC#2)
// badgeImage = "_-250" (String#19222, DoABC#2)
// _badges = "_-0Gg" (String#298, DoABC#2)
// getWindowContainer = "_-v8" (String#313, DoABC#2)
// iconImage = "_-0Pn" (String#4088, DoABC#2)
// closingInventoryView = "_-0Lx" (String#4000, DoABC#2)
// requestInitialization = "_-2eX" (String#6842, DoABC#2)
// categorySwitch = "_-3Ad" (String#7526, DoABC#2)
// subCategorySwitch = "_-1Gu" (String#5187, DoABC#2)
// addActivatedBadge = "_-I7" (String#22934, DoABC#2)
// disposesBitmap = "_-03U" (String#3637, DoABC#2)
// _SafeStr_6770 = "_-39Q" (String#7500, DoABC#2)
// updateView = "_-1Js" (String#847, DoABC#2)
// _SafeStr_7061 = "_-3KY" (String#22306, DoABC#2)
// getBadgeImage = "_-3DK" (String#7581, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// isVisible = "_-1rE" (String#18592, DoABC#2)
// resetUnseenItems = "_-0qm" (String#16077, DoABC#2)
// updateActionView = "_-jg" (String#8593, DoABC#2)
// isMainViewActive = "_-jz" (String#24031, DoABC#2)
// getUnseenItemCount = "_-133" (String#16582, DoABC#2)
// updateUnseenItemCounts = "_-ik" (String#23988, DoABC#2)
// getItemInIndex = "_-0Tf" (String#15196, DoABC#2)
// _SafeStr_8222 = "_-1SR" (String#5405, DoABC#2)
// HabboInventoryTrackingEvent = "_-1r0" (String#18582, DoABC#2)
// isUnseen = "_-FH" (String#22825, DoABC#2)
// _SafeStr_8540 = "_-TH" (String#23376, DoABC#2)
// _SafeStr_8541 = "_-2aE" (String#20452, DoABC#2)
// _SafeStr_8542 = "_-0uS" (String#16219, DoABC#2)
// _maxActiveCount = "_-Sf" (String#23352, DoABC#2)
// _SafeStr_8544 = "_-2s2" (String#21159, DoABC#2)
// _SafeStr_8545 = "_-0QP" (String#15077, DoABC#2)
// _sessionDataManager = "_-0kq" (String#149, DoABC#2)
// onBadgeImageReady = "_-2f0" (String#1919, DoABC#2)
// getMaxActiveCount = "_-X8" (String#23527, DoABC#2)
// updateAll = "_-ff" (String#23874, DoABC#2)
// startWearingBadge = "_-1YA" (String#17822, DoABC#2)
// stopWearingBadge = "_-15l" (String#16686, DoABC#2)
// updateBadge = "_-0FX" (String#14667, DoABC#2)
// getBadge = "_-2Vn" (String#20272, DoABC#2)
// removeBadge = "_-002" (String#14054, DoABC#2)
// toggleBadgeWearing = "_-1mH" (String#18392, DoABC#2)
// saveBadgeSelection = "_-0YK" (String#15372, DoABC#2)
// getBadges = "_-2J4" (String#19770, DoABC#2)
// setBadgeSelected = "_-2Dy" (String#19566, DoABC#2)
// forceSelection = "_-Jl" (String#22996, DoABC#2)
// getSelectedBadge = "_-br" (String#23708, DoABC#2)
// getBadgeFromActive = "_-2m4" (String#20921, DoABC#2)
// getBadgeFromInactive = "_-12e" (String#16565, DoABC#2)
// addUnseenBadges = "_-2jp" (String#20839, DoABC#2)


