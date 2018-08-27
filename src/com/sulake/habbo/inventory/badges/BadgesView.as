
package com.sulake.habbo.inventory.badges
{
    import com.sulake.habbo.inventory.IInventoryView;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowEvent;

    public class BadgesView implements IInventoryView 
    {

        private var _windowManager:IHabboWindowManager;
        private var _view:IWindowContainer;
        private var _SafeStr_4830:BadgesModel;
        private var _SafeStr_8564:IItemGridWindow;
        private var _SafeStr_8565:IItemGridWindow;
        private var _disposed:Boolean = false;

        public function BadgesView(_arg_1:BadgesModel, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary)
        {
            this._SafeStr_4830 = _arg_1;
            this._windowManager = _arg_2;
            var _local_4:IAsset = _arg_3.getAssetByName("inventory_badges_xml");
            var _local_5:XmlAsset = XmlAsset(_local_4);
            this._view = IWindowContainer(this._windowManager.buildFromXML(XML(_local_5.content)));
            this._view.visible = false;
            var _local_6:IWindow = this._view.findChildByName("wearBadge_button");
            if (_local_6 != null){
                _local_6.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onWearBadgeClick);
            };
            this._SafeStr_8564 = (this._view.findChildByName("inactive_items") as IItemGridWindow);
            this._SafeStr_8564.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onInactiveBadgeClick);
            this._SafeStr_8565 = (this._view.findChildByName("active_items") as IItemGridWindow);
            this._SafeStr_8565.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onActiveBadgeClick);
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
            this._windowManager = null;
            this._SafeStr_4830 = null;
            this._SafeStr_8564 = null;
            this._SafeStr_8565 = null;
            if (this._view){
                this._view.dispose();
                this._view = null;
            };
        }
        public function getWindowContainer():IWindowContainer
        {
            if ((((this._view == null)) || (this._view.disposed))){
                return (null);
            };
            return (this._view);
        }
        public function get isVisible():Boolean
        {
            return (((!((this._view.parent == null))) && (this._view.visible)));
        }
        public function updateAll():void
        {
            this.updateListViews();
            this.updateActionView();
        }
        private function updateListViews():void
        {
            var _local_3:Badge;
            if ((((this._view == null)) || (this._view.disposed))){
                return;
            };
            var _local_1:Number = this._SafeStr_8564.scrollV;
            this._SafeStr_8564.removeGridItems();
            this._SafeStr_8565.removeGridItems();
            var _local_2:Array = this._SafeStr_4830.getBadges(BadgesModel._SafeStr_8541);
            var _local_4:int;
            while (_local_4 < _local_2.length) {
                _local_3 = (_local_2[_local_4] as Badge);
                if (!_local_3.isInUse){
                    this._SafeStr_8564.addGridItem(_local_3.window);
                    _local_3.window.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onInactiveBadgeClick);
                };
                _local_4++;
            };
            if (_local_1 > 0){
                this._SafeStr_8564.scrollV = _local_1;
            };
            var _local_5:Array = this._SafeStr_4830.getBadges(BadgesModel._SafeStr_8542);
            _local_4 = 0;
            while (_local_4 < _local_5.length) {
                _local_3 = (_local_5[_local_4] as Badge);
                this._SafeStr_8565.addGridItem(_local_3.window);
                _local_3.window.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onActiveBadgeClick);
                _local_4++;
            };
        }
        public function updateActionView():void
        {
            var _local_3:Array;
            if ((((this._view == null)) || (this._view.disposed))){
                return;
            };
            var _local_1:IButtonWindow = (this._view.findChildByName("wearBadge_button") as IButtonWindow);
            if (_local_1 == null){
                return;
            };
            var _local_2:Badge = this._SafeStr_4830.getSelectedBadge();
            if (_local_2 == null){
                _local_1.disable();
                this.setBadgeName(null);
                this.setBadgeDescriptionText(null);
                this.setBadgeDescriptionImage(null);
            }
            else {
                if (_local_2.isInUse){
                    _local_1.caption = "${inventory.badges.clearbadge}";
                }
                else {
                    _local_1.caption = "${inventory.badges.wearbadge}";
                };
                this.setBadgeName(this._SafeStr_4830.controller.localization.getBadgeName(_local_2.type));
                this.setBadgeDescriptionText(this._SafeStr_4830.controller.localization.getBadgeDesc(_local_2.type));
                this.setBadgeDescriptionImage(_local_2.iconImage);
                _local_3 = this._SafeStr_4830.getBadges(BadgesModel._SafeStr_8542);
                if (((((!((_local_3 == null))) && ((_local_3.length >= this._SafeStr_4830.getMaxActiveCount())))) && (!(_local_2.isInUse)))){
                    _local_1.disable();
                }
                else {
                    _local_1.enable();
                };
            };
        }
        private function setBadgeDescriptionImage(_arg_1:BitmapData):void
        {
            if ((((this._view == null)) || (this._view.disposed))){
                return;
            };
            var _local_2:IBitmapWrapperWindow = (this._view.findChildByName("badgeDescriptionImage") as IBitmapWrapperWindow);
            if (_local_2 == null){
                return;
            };
            if (_local_2.bitmap != null){
                _local_2.bitmap.dispose();
            };
            _local_2.bitmap = new BitmapData(_local_2.width, _local_2.height, true, 0);
            _local_2.bitmap.fillRect(_local_2.bitmap.rect, 0);
            if (_arg_1 == null){
                _arg_1 = new BitmapData(_local_2.width, _local_2.height);
            };
            var _local_3:Point = new Point(((_local_2.width - _arg_1.width) / 2), ((_local_2.height - _arg_1.height) / 2));
            _local_2.bitmap.copyPixels(_arg_1, _arg_1.rect, _local_3, null, null, true);
            _local_2.invalidate();
        }
        private function setBadgeName(_arg_1:String):void
        {
            if ((((this._view == null)) || (this._view.disposed))){
                return;
            };
            var _local_2:ITextWindow = (this._view.findChildByName("badgeName") as ITextWindow);
            if (_local_2 == null){
                return;
            };
            if (_arg_1 == null){
                _local_2.text = "";
            }
            else {
                _local_2.text = "";
                _local_2.text = _arg_1;
            };
        }
        private function setBadgeDescriptionText(_arg_1:String):void
        {
            if ((((this._view == null)) || (this._view.disposed))){
                return;
            };
            var _local_2:ITextWindow = (this._view.findChildByName("badgeDescriptionText") as ITextWindow);
            if (_local_2 == null){
                return;
            };
            if (_arg_1 == null){
                _local_2.text = "${inventory.effects.defaultdescription}";
            }
            else {
                _local_2.text = "";
                _local_2.text = _arg_1;
            };
        }
        private function onInactiveBadgeClick(_arg_1:WindowEvent):void
        {
            var _local_2:int = this._SafeStr_8564.getGridItemIndex(_arg_1.window);
            var _local_3:Badge = this._SafeStr_4830.getBadgeFromInactive(_local_2);
            if (_local_3 != null){
                this._SafeStr_4830.setBadgeSelected(_local_3.type);
            };
        }
        private function onActiveBadgeClick(_arg_1:WindowEvent):void
        {
            var _local_2:int = this._SafeStr_8565.getGridItemIndex(_arg_1.window);
            var _local_3:Badge = this._SafeStr_4830.getBadgeFromActive(_local_2);
            if (_local_3 != null){
                this._SafeStr_4830.setBadgeSelected(_local_3.type);
            };
        }
        private function onWearBadgeClick(_arg_1:WindowEvent):void
        {
            var _local_2:Badge = this._SafeStr_4830.getSelectedBadge();
            if (_local_2 != null){
                this._SafeStr_4830.toggleBadgeWearing(_local_2.type);
            };
        }

    }
}//package com.sulake.habbo.inventory.badges

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IItemGridWindow = "_-265" (String#1809, DoABC#2)
// BadgesModel = "_-2zV" (String#7278, DoABC#2)
// IInventoryView = "_-1g8" (String#5665, DoABC#2)
// Badge = "_-244" (String#19179, DoABC#2)
// isInUse = "_-2LN" (String#6469, DoABC#2)
// _SafeStr_4830 = "_-0XB" (String#112, DoABC#2)
// removeGridItems = "_-1Bp" (String#5106, DoABC#2)
// addGridItem = "_-2vh" (String#7192, DoABC#2)
// getWindowContainer = "_-v8" (String#313, DoABC#2)
// iconImage = "_-0Pn" (String#4088, DoABC#2)
// isVisible = "_-1rE" (String#18592, DoABC#2)
// updateActionView = "_-jg" (String#8593, DoABC#2)
// updateListViews = "_-3LU" (String#7727, DoABC#2)
// _SafeStr_8541 = "_-2aE" (String#20452, DoABC#2)
// _SafeStr_8542 = "_-0uS" (String#16219, DoABC#2)
// getMaxActiveCount = "_-X8" (String#23527, DoABC#2)
// updateAll = "_-ff" (String#23874, DoABC#2)
// toggleBadgeWearing = "_-1mH" (String#18392, DoABC#2)
// getBadges = "_-2J4" (String#19770, DoABC#2)
// setBadgeSelected = "_-2Dy" (String#19566, DoABC#2)
// getSelectedBadge = "_-br" (String#23708, DoABC#2)
// getBadgeFromActive = "_-2m4" (String#20921, DoABC#2)
// getBadgeFromInactive = "_-12e" (String#16565, DoABC#2)
// _SafeStr_8564 = "_-2VB" (String#20247, DoABC#2)
// _SafeStr_8565 = "_-11p" (String#16531, DoABC#2)
// onWearBadgeClick = "_-3-J" (String#21474, DoABC#2)
// onInactiveBadgeClick = "_-1yU" (String#18908, DoABC#2)
// onActiveBadgeClick = "_-2zF" (String#21430, DoABC#2)
// setBadgeName = "_-392" (String#21847, DoABC#2)
// setBadgeDescriptionText = "_-2Qc" (String#20069, DoABC#2)
// setBadgeDescriptionImage = "_-1-o" (String#16460, DoABC#2)


