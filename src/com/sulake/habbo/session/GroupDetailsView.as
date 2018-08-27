
package com.sulake.habbo.session
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsData;
    import flash.geom.Matrix;
    import com.sulake.habbo.session.events.BadgeImageReadyEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupEntryData;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupsWhereMemberMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.users.JoinHabboGroupMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.SelectFavouriteHabboGroupMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.DeselectFavouriteHabboGroupMessageComposer;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.habbo.window.utils.IAlertDialog;

    public class GroupDetailsView 
    {

        public static const _SafeStr_13629:String = "HabboGroups";

        private var _SafeStr_13621:SessionDataManager;
        private var _window:IWindowContainer;
        private var _content:IItemListWindow;
        private var _SafeStr_10540:HabboGroupDetailsData;
        private var _SafeStr_12219:Matrix;

        public function GroupDetailsView(_arg_1:SessionDataManager)
        {
            this._SafeStr_12219 = new Matrix();
            super();
            this._SafeStr_13621 = _arg_1;
            this._SafeStr_12219.scale(2, 2);
            this._SafeStr_13621.events.addEventListener(BadgeImageReadyEvent.BIRE_BADGE_IMAGE_READY, this.onBadgeImageReady);
        }
        public static function moveChildrenToColumn(_arg_1:IWindowContainer, _arg_2:Array, _arg_3:int, _arg_4:int):void
        {
            var _local_5:String;
            var _local_6:IWindow;
            for each (_local_5 in _arg_2) {
                _local_6 = _arg_1.getChildByName(_local_5);
                if (((((!((_local_6 == null))) && (_local_6.visible))) && ((_local_6.height > 0)))){
                    _local_6.y = _arg_3;
                    _arg_3 = (_arg_3 + (_local_6.height + _arg_4));
                };
            };
        }
        public static function getLowestPoint(_arg_1:IWindowContainer):int
        {
            var _local_4:IWindow;
            var _local_2:int;
            var _local_3:int;
            while (_local_3 < _arg_1.numChildren) {
                _local_4 = _arg_1.getChildAt(_local_3);
                if (_local_4.visible){
                    _local_2 = Math.max(_local_2, (_local_4.y + _local_4.height));
                };
                _local_3++;
            };
            return (_local_2);
        }

        public function onBadgeImageReady(_arg_1:BadgeImageReadyEvent):void
        {
            var _local_3:IWindowContainer;
            var _local_4:IBitmapWrapperWindow;
            if (((((!((this._window == null))) && (!((this._SafeStr_10540 == null))))) && ((_arg_1.badgeId == this._SafeStr_10540.badgeCode)))){
                this.refreshBadgeImage();
            };
            var _local_2:int;
            while (_local_2 < this._content.numListItems) {
                _local_3 = IWindowContainer(this._content.getListItemAt(_local_2));
                _local_4 = (_local_3.findChildByName("group_entry_logo") as IBitmapWrapperWindow);
                if (_local_4.tags[0] == _arg_1.badgeId){
                    if (_local_4.bitmap == null){
                        _local_4.bitmap = new BitmapData(_local_4.width, _local_4.height);
                    };
                    _local_4.bitmap.fillRect(_local_4.bitmap.rect, 0xFFFFFF);
                    _local_4.bitmap.draw(_arg_1.badgeImage);
                    _local_4.invalidate(_local_4.rectangle);
                };
                _local_2++;
            };
        }
        private function prepareWindow():void
        {
            if (this._window != null){
                return;
            };
            this._window = IFrameWindow(this._SafeStr_13621.getXmlWindow("group_info"));
            this._window.findChildByTag("close").procedure = this.onClose;
            this.setProc("group_homepage_link_region", this.onHomepageLink);
            this.setProc("group_room_link_region", this.onRoomLink);
            this._window.findChildByName("join_button").procedure = this.onJoin;
            this._window.findChildByName("my_groups_region").procedure = this.onMyGroups;
            this._content = IItemListWindow(this._window.findChildByName("groups_item_list"));
            this._window.center();
        }
        private function setVisibleContainer(_arg_1:String, _arg_2:String):void
        {
            this.prepareWindow();
            this._window.caption = this._SafeStr_13621.localization.getKey(_arg_2, _arg_2);
            this._window.findChildByName("groups_container").visible = false;
            this._window.findChildByName("group_container").visible = false;
            this._window.findChildByName(_arg_1).visible = true;
        }
        public function onGroups(_arg_1:Array):void
        {
            this.setVisibleContainer("groups_container", "group.owngroups.title");
            this.refreshGroups(_arg_1);
        }
        private function refreshGroups(_arg_1:Array):void
        {
            var _local_3:Boolean;
            this._content.autoArrangeItems = false;
            var _local_2:int;
            while (true) {
                if (_local_2 < _arg_1.length){
                    this.refreshEntry(true, _local_2, _arg_1[_local_2]);
                }
                else {
                    _local_3 = this.refreshEntry(false, _local_2, null);
                    if (_local_3) break;
                };
                _local_2++;
            };
            this._content.autoArrangeItems = true;
        }
        private function getListEntry(_arg_1:int):IWindowContainer
        {
            var _local_2:IRegionWindow = IRegionWindow(this._SafeStr_13621.getXmlWindow("group_entry"));
            _local_2.findChildByName("bg").color = this.getBgColor(_arg_1);
            _local_2.procedure = this.onSelectGroup;
            this.setImageButton(_local_2, "make_favourite", this.onMakeFavourite, "make_favourite");
            this.setImageButton(_local_2, "clear_favourite", this.onClearFavourite, "clear_favourite");
            return (_local_2);
        }
        private function setImageButton(_arg_1:IRegionWindow, _arg_2:String, _arg_3:Function, _arg_4:String):void
        {
            var _local_5:IRegionWindow = IRegionWindow(_arg_1.findChildByName(_arg_2));
            _local_5.procedure = _arg_3;
            var _local_6:IBitmapWrapperWindow = IBitmapWrapperWindow(_local_5.findChildByName("icon"));
            _local_6.bitmap = this._SafeStr_13621.getButtonImage(_arg_4);
        }
        private function getBgColor(_arg_1:int):uint
        {
            return (((((_arg_1 % 2))!=0) ? 0xFFFFFFFF : 4292797682));
        }
        private function refreshEntry(_arg_1:Boolean, _arg_2:int, _arg_3:HabboGroupEntryData):Boolean
        {
            var _local_4:IWindowContainer = IWindowContainer(this._content.getListItemAt(_arg_2));
            if (_local_4 == null){
                if (!_arg_1){
                    return (true);
                };
                _local_4 = this.getListEntry(_arg_2);
                this._content.addListItem(_local_4);
            };
            if (_arg_1){
                this.refreshEntryDetails(_local_4, _arg_3);
                _local_4.visible = true;
                _local_4.height = 43;
            }
            else {
                _local_4.height = 0;
                _local_4.visible = false;
            };
            return (false);
        }
        public function refreshEntryDetails(_arg_1:IWindowContainer, _arg_2:HabboGroupEntryData):void
        {
            _arg_1.findChildByName("group_name_txt").caption = _arg_2.groupName;
            _arg_1.id = _arg_2.groupId;
            this.refreshEntryBadgeImage(_arg_1, _arg_2);
            _arg_1.findChildByName("clear_favourite").visible = _arg_2.favourite;
            _arg_1.findChildByName("make_favourite").visible = !(_arg_2.favourite);
        }
        public function onGroupDetails(_arg_1:HabboGroupDetailsData):void
        {
            this._SafeStr_10540 = _arg_1;
            this.setVisibleContainer("group_container", "group.title");
            this._window.findChildByName("group_name").caption = _arg_1.groupName;
            var _local_2:ITextWindow = ITextWindow(this._window.findChildByName("group_description"));
            _local_2.caption = _arg_1.description;
            _local_2.height = (_local_2.textHeight + 5);
            this._window.findChildByName("join_button").visible = (_arg_1.status == HabboGroupDetailsData._SafeStr_5510);
            this._window.findChildByName("membership_pending_txt").visible = (_arg_1.status == HabboGroupDetailsData._SafeStr_5512);
            this._SafeStr_13621.windowManager.registerLocalizationParameter("group.membercount", "totalMembers", ("" + _arg_1.totalMembers));
            this._window.findChildByName("group_room_link_region").visible = (_arg_1.roomId > -1);
            this._SafeStr_13621.windowManager.registerLocalizationParameter("group.room.link", "room_name", _arg_1.roomName);
            this.refreshBadgeImage();
            var _local_3:IWindowContainer = IWindowContainer(this._window.findChildByName("group_container"));
            moveChildrenToColumn(_local_3, ["group_header", "group_description", "group_footer"], 0, 0);
            var _local_4:int = _local_3.height;
            _local_3.height = getLowestPoint(_local_3);
            this._window.height = (this._window.height + (_local_3.height - _local_4));
            this._window.visible = true;
        }
        private function refreshBadgeImage():void
        {
            var _local_1:IBitmapWrapperWindow = (this._window.findChildByName("group_logo") as IBitmapWrapperWindow);
            if (_local_1.bitmap == null){
                _local_1.bitmap = new BitmapData(_local_1.width, _local_1.height);
            };
            var _local_2:BitmapData = this._SafeStr_13621.getGroupBadgeImage(this._SafeStr_10540.badgeCode);
            _local_1.bitmap.fillRect(_local_1.bitmap.rect, 0xFFFFFF);
            if (_local_2 != null){
                _local_1.bitmap.draw(_local_2, this._SafeStr_12219);
                _local_1.invalidate(_local_1.rectangle);
            };
        }
        private function refreshEntryBadgeImage(_arg_1:IWindowContainer, _arg_2:HabboGroupEntryData):void
        {
            var _local_3:IBitmapWrapperWindow = (_arg_1.findChildByName("group_entry_logo") as IBitmapWrapperWindow);
            if (_local_3.tags[0] == _arg_2.badgeCode){
                return;
            };
            _local_3.tags[0] = _arg_2.badgeCode;
            if (_local_3.bitmap == null){
                _local_3.bitmap = new BitmapData(_local_3.width, _local_3.height);
            };
            var _local_4:BitmapData = this._SafeStr_13621.getGroupBadgeImage(_arg_2.badgeCode);
            _local_3.bitmap.fillRect(_local_3.bitmap.rect, 0xFFFFFF);
            if (_local_4 != null){
                _local_3.bitmap.draw(_local_4);
                _local_3.invalidate(_local_3.rectangle);
            };
        }
        private function setProc(_arg_1:String, _arg_2:Function):void
        {
            var _local_3:IWindow = this._window.findChildByName(_arg_1);
            _local_3.mouseThreshold = 0;
            _local_3.procedure = _arg_2;
        }
        private function onMyGroups(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this._SafeStr_13621.send(new GetHabboGroupsWhereMemberMessageComposer());
            this._SafeStr_13621.send(new EventLogMessageComposer(_SafeStr_13629, "", "my groups"));
        }
        private function onSelectGroup(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this._SafeStr_13621.showGroupBadgeInfo(_arg_2.id);
            this._SafeStr_13621.send(new EventLogMessageComposer(_SafeStr_13629, ("" + _arg_2.id), "select"));
        }
        private function onJoin(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this._SafeStr_13621.send(new JoinHabboGroupMessageComposer(this._SafeStr_10540.groupId));
            this._SafeStr_13621.send(new EventLogMessageComposer(_SafeStr_13629, ("" + this._SafeStr_10540.groupId), "join"));
        }
        private function onMakeFavourite(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this._SafeStr_13621.send(new SelectFavouriteHabboGroupMessageComposer(_arg_2.parent.id));
            this._SafeStr_13621.send(new EventLogMessageComposer(_SafeStr_13629, ("" + _arg_2.parent.id), "make favourite"));
        }
        private function onClearFavourite(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this._SafeStr_13621.send(new DeselectFavouriteHabboGroupMessageComposer(_arg_2.parent.id));
            this._SafeStr_13621.send(new EventLogMessageComposer(_SafeStr_13629, ("" + _arg_2.parent.id), "clear favourite"));
        }
        private function onHomepageLink(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            var _local_3:String = this._SafeStr_13621.configuration.getKey("group.homepage.url", "http://%predefined%/groups/%groupid%/id");
            _local_3 = _local_3.replace("%groupid%", this._SafeStr_10540.groupId);
            this.openExternalLink(_local_3);
            this._SafeStr_13621.send(new EventLogMessageComposer(_SafeStr_13629, ("" + this._SafeStr_10540.groupId), "homepage"));
        }
        private function onRoomLink(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this._SafeStr_13621.roomSessionManager.gotoRoom(false, this._SafeStr_10540.roomId);
            this.close();
            this._SafeStr_13621.send(new EventLogMessageComposer(_SafeStr_13629, ("" + this._SafeStr_10540.groupId), "base"));
        }
        private function onClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this.close();
        }
        public function close():void
        {
            if (this._window != null){
                this._window.visible = false;
            };
        }
        private function openExternalLink(_arg_1:String):void
        {
            if (_arg_1 != ""){
                this._SafeStr_13621.windowManager.alert("${catalog.alert.external.link.title}", "${catalog.alert.external.link.desc}", 0, this.onExternalLink);
                HabboWebTools.navigateToURL(_arg_1, "_empty");
            };
        }
        private function onExternalLink(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
        }

    }
}//package com.sulake.habbo.session

// onExternalLink = "_-022" (String#575, DoABC#2)
// openExternalLink = "_-0kn" (String#823, DoABC#2)
// _SafeStr_10540 = "_-0yG" (String#1586, DoABC#2)
// onSelectGroup = "_-GV" (String#8007, DoABC#2)
// setProc = "_-333" (String#1990, DoABC#2)
// gotoRoom = "_-Fa" (String#7986, DoABC#2)
// _SafeStr_12219 = "_-Qh" (String#8219, DoABC#2)
// refreshBadgeImage = "_-1Ir" (String#5217, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// BadgeImageReadyEvent = "_-03M" (String#14177, DoABC#2)
// HabboWebTools = "_-2pX" (String#21059, DoABC#2)
// _SafeStr_13621 = "_-2nA" (String#7025, DoABC#2)
// onGroupDetails = "_-u1" (String#8767, DoABC#2)
// onGroups = "_-2bX" (String#20506, DoABC#2)
// _SafeStr_13629 = "_-0RY" (String#15122, DoABC#2)
// onHomepageLink = "_-0fe" (String#15658, DoABC#2)
// onRoomLink = "_-11" (String#16499, DoABC#2)
// onJoin = "_-3Kd" (String#22308, DoABC#2)
// onMyGroups = "_-Q8" (String#23256, DoABC#2)
// setVisibleContainer = "_-1RW" (String#17565, DoABC#2)
// refreshGroups = "_-2aL" (String#20457, DoABC#2)
// setImageButton = "_-0el" (String#15615, DoABC#2)
// onMakeFavourite = "_-ut" (String#24486, DoABC#2)
// onClearFavourite = "_-XF" (String#23532, DoABC#2)
// refreshEntryBadgeImage = "_-1UG" (String#17677, DoABC#2)
// IRegionWindow = "_-dg" (String#2146, DoABC#2)
// GroupDetailsView = "_-7M" (String#7812, DoABC#2)
// GetHabboGroupsWhereMemberMessageComposer = "_-1Zd" (String#17875, DoABC#2)
// JoinHabboGroupMessageComposer = "_-1v1" (String#18757, DoABC#2)
// DeselectFavouriteHabboGroupMessageComposer = "_-3p" (String#22368, DoABC#2)
// SelectFavouriteHabboGroupMessageComposer = "_-15p" (String#16689, DoABC#2)
// HabboGroupDetailsData = "_-13j" (String#16607, DoABC#2)
// HabboGroupEntryData = "_-sd" (String#24384, DoABC#2)
// badgeId = "_-g6" (String#23896, DoABC#2)
// refreshEntry = "_-2v6" (String#308, DoABC#2)
// getBgColor = "_-1GR" (String#600, DoABC#2)
// _content = "_-1Q8" (String#74, DoABC#2)
// getListEntry = "_-S4" (String#8248, DoABC#2)
// refreshEntryDetails = "_-xU" (String#24589, DoABC#2)
// getLowestPoint = "_-0t0" (String#16161, DoABC#2)
// moveChildrenToColumn = "_-fI" (String#23859, DoABC#2)
// BIRE_BADGE_IMAGE_READY = "_-38f" (String#21828, DoABC#2)
// badgeImage = "_-250" (String#19222, DoABC#2)
// onClose = "_-2Ts" (String#54, DoABC#2)
// badgeCode = "_-2XO" (String#20338, DoABC#2)
// _SafeStr_5510 = "_-3EI" (String#22048, DoABC#2)
// _SafeStr_5512 = "_-1KO" (String#17290, DoABC#2)
// groupName = "_-2fN" (String#20663, DoABC#2)
// prepareWindow = "_-RN" (String#219, DoABC#2)
// mouseThreshold = "_-0OA" (String#4051, DoABC#2)
// roomSessionManager = "_-1bj" (String#5594, DoABC#2)
// showGroupBadgeInfo = "_-1Qo" (String#1680, DoABC#2)
// getGroupBadgeImage = "_-KC" (String#2087, DoABC#2)
// EventLogMessageComposer = "_-2lH" (String#6984, DoABC#2)
// onBadgeImageReady = "_-2f0" (String#1919, DoABC#2)


