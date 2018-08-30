
package com.sulake.habbo.navigator.roomthumbnails
{
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.habbo.navigator.Util;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomThumbnailObjectData;
    import com.sulake.habbo.communication.messages.outgoing.navigator.UpdateRoomThumbnailMessageComposer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import flash.utils.Dictionary;
    import flash.geom.Point;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import com.sulake.core.window.enum.WindowType;
    import com.sulake.core.window.events.*;
    import com.sulake.core.window.enum.*;

    public class RoomThumbnailCtrl 
    {

        private var _navigator:HabboNavigator;
        private var _window:IWindowContainer;
        private var _active:Boolean;
        private var _modelController:ThumbnailEditorModel;
        private var _SafeStr_6054:IButtonWindow;
        private var _SafeStr_6055:IButtonWindow;
        private var _SafeStr_6056:IButtonWindow;
        private var _SafeStr_6057:IWindowContainer;
        private var _SafeStr_6058:IWindowContainer;

        public function RoomThumbnailCtrl(_arg_1:HabboNavigator)
        {
            this._navigator = _arg_1;
            this._modelController = new ThumbnailEditorModel();
        }
        public function set active(_arg_1:Boolean):void
        {
            this._active = _arg_1;
            if (this._active){
                this._modelController.data = this._navigator.data.enteredGuestRoom.thumbnail.getCopy();
            };
        }
        public function get active():Boolean
        {
            return (this._active);
        }
        public function close():void
        {
            this._active = false;
        }
        private function prepareWindow(_arg_1:IWindowContainer):void
        {
            if (this._window != null){
                return;
            };
            this._window = IWindowContainer(this._navigator.getXmlWindow("ros_roomicon_editor"));
            _arg_1.addChildAt(this._window, 0);
            this._SafeStr_6054 = IButtonWindow(this.find("bg_tab"));
            this._SafeStr_6055 = IButtonWindow(this.find("top_tab"));
            this._SafeStr_6056 = IButtonWindow(this.find("obj_tab"));
            this._SafeStr_6057 = IWindowContainer(this.find("tile_grid"));
            this._SafeStr_6058 = IWindowContainer(this.find("now_editing_container"));
            Util.setProcDirectly(this.find("save"), this.onSaveButton);
            Util.setProcDirectly(this.find("cancel"), this.onCancelButton);
            Util.setProcDirectly(this._SafeStr_6054, this.onBgTabButton);
            Util.setProcDirectly(this._SafeStr_6055, this.onTopTabButton);
            Util.setProcDirectly(this._SafeStr_6056, this.onObjTabButton);
        }
        private function find(_arg_1:String):IWindow
        {
            var _local_2:IWindow = this._window.findChildByName(_arg_1);
            if (_local_2 == null){
                throw (new Error((("Window element with name: " + _arg_1) + " cannot be found!")));
            };
            return (_local_2);
        }
        private function getImgSelectorContainer(_arg_1:int):IWindowContainer
        {
            return (IWindowContainer(this._window.findChildByName(("img_selector_container_" + _arg_1))));
        }
        private function onSaveButton(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_4:RoomThumbnailObjectData;
            var _local_5:UpdateRoomThumbnailMessageComposer;
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            Logger.log("save clicked");
            var _local_3:Array = new Array();
            for each (_local_4 in this._modelController.data.objects) {
                if (_local_4.imgId > 0){
                    _local_3.push(_local_4);
                };
            };
            _local_5 = new UpdateRoomThumbnailMessageComposer(this._navigator.data.enteredGuestRoom.flatId, this._modelController.data.bgImgId, this._modelController.data.frontImgId, _local_3.length);
            for each (_local_4 in _local_3) {
                _local_5.addObj(_local_4.pos, _local_4.imgId);
            };
            this._navigator.send(_local_5);
        }
        private function onCancelButton(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            Logger.log("cancel clicked");
            this._navigator.roomInfoViewCtrl.backToRoomSettings();
        }
        private function onBgTabButton(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            Logger.log("bg tab clicked");
            this._modelController.mode = ThumbnailEditorModel._SafeStr_6034;
            this.reload();
        }
        private function onTopTabButton(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            Logger.log("top tab clicked");
            this._modelController.mode = ThumbnailEditorModel._SafeStr_6036;
            this.reload();
        }
        private function onObjTabButton(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            Logger.log("obj tab clicked");
            this._modelController.mode = ThumbnailEditorModel._SafeStr_6037;
            this.reload();
        }
        private function onSelectPos(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            Logger.log(("obj pos clicked: " + _arg_2.id));
            this._modelController.setPos(_arg_2.id);
            this.reload();
        }
        private function onImgSel(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            Logger.log(("img selected: " + _arg_2.id));
            this._modelController.setImg(_arg_2.id);
            this.reload();
        }
        public function refresh(_arg_1:IWindowContainer):void
        {
            if (!this._active){
                return;
            };
            this.prepareWindow(_arg_1);
            this.refreshHeader();
            this.refreshTab();
            this.refreshEditArea();
            this.refreshImgSelectors();
            this._window.height = (Util.getLowestPoint(this._window) + 4);
            this._window.visible = true;
        }
        private function reload():void
        {
            this._navigator.roomInfoViewCtrl.reload();
        }
        private function refreshTab():void
        {
            this.setEnabled(this._SafeStr_6054, !((this._modelController.mode == ThumbnailEditorModel._SafeStr_6034)));
            this.setEnabled(this._SafeStr_6055, !((this._modelController.mode == ThumbnailEditorModel._SafeStr_6036)));
            this.setEnabled(this._SafeStr_6056, !((this._modelController.mode == ThumbnailEditorModel._SafeStr_6037)));
        }
        private function refreshEditArea():void
        {
            var _local_1:IWindowContainer = this._SafeStr_6058;
            Util.hideChildren(_local_1);
            this.refreshEditImg(_local_1, "edit_bg", (this._modelController.mode == ThumbnailEditorModel._SafeStr_6034));
            this.refreshEditImg(_local_1, "edit_top", (this._modelController.mode == ThumbnailEditorModel._SafeStr_6036));
            this.refreshEditImg(_local_1, "edit_obj", (this._modelController.mode == ThumbnailEditorModel._SafeStr_6037), false);
            if (this._modelController.mode == ThumbnailEditorModel._SafeStr_6037){
                this.refreshPositionGrid();
            };
        }
        private function refreshEditImg(_arg_1:IWindowContainer, _arg_2:String, _arg_3:Boolean, _arg_4:Boolean=true):void
        {
            if (!_arg_3){
                return;
            };
            var _local_5:IBitmapWrapperWindow = IBitmapWrapperWindow(_arg_1.findChildByName(_arg_2));
            if (_local_5.bitmap != null){
                _local_5.visible = true;
                return;
            };
            var _local_6:BitmapData = this._navigator.getButtonImage(_arg_2);
            if (_arg_4){
                this._navigator.thumbRenderer.roundEdges(_local_6);
            };
            _local_5.bitmap = _local_6;
            _local_5.visible = true;
        }
        private function refreshPositionGrid():void
        {
            var _local_3:int;
            var _local_4:IBitmapWrapperWindow;
            var _local_5:IBitmapWrapperWindow;
            var _local_1:IWindowContainer = this._SafeStr_6057;
            _local_1.visible = true;
            if (_local_1.numChildren == 0){
                while (_local_3 <= RoomThumbnailRenderer._SafeStr_6010) {
                    _local_4 = this._navigator.getButton(("pos_" + _local_3), "rico_tile", this.onSelectPos, 0, 0, _local_3);
                    this.refreshTileLoc(_local_4, _local_3);
                    _local_1.addChild(_local_4);
                    _local_5 = this._navigator.getButton(("block_" + _local_3), "rico_tile_x", this.onSelectPos, 0, 0, _local_3);
                    _local_5.visible = false;
                    this.refreshTileLoc(_local_5, _local_3);
                    _local_1.addChild(_local_5);
                    _local_3++;
                };
                _local_1.addChild(this._navigator.getButton("selected", "rico_tile_s", null, 0, 0));
            };
            var _local_2:IBitmapWrapperWindow = IBitmapWrapperWindow(_local_1.findChildByName("selected"));
            if (this._modelController.selected == null){
                _local_2.visible = false;
                return;
            };
            _local_2.visible = true;
            this.refreshTileLoc(_local_2, this._modelController.selected.pos);
            this.refreshBlockedTiles(_local_1);
        }
        private function refreshBlockedTiles(_arg_1:IWindowContainer):void
        {
            var _local_3:int;
            var _local_2:Dictionary = this._modelController.getBlockedPositions();
            while (_local_3 <= RoomThumbnailRenderer._SafeStr_6010) {
                _arg_1.findChildByName(("block_" + _local_3)).visible = !((_local_2[_local_3] == null));
                _local_3++;
            };
        }
        private function refreshTileLoc(_arg_1:IBitmapWrapperWindow, _arg_2:int):void
        {
            var _local_3:Point = this._navigator.thumbRenderer.getScreenLocForPos(_arg_2);
            _arg_1.x = _local_3.x;
            _arg_1.y = _local_3.y;
        }
        private function refreshImgSelectors():void
        {
            this.refreshImgSelector(ThumbnailEditorModel._SafeStr_6034);
            this.refreshImgSelector(ThumbnailEditorModel._SafeStr_6036);
            this.refreshImgSelector(ThumbnailEditorModel._SafeStr_6037);
        }
        private function refreshImgSelector(_arg_1:int):void
        {
            var _local_7:ThumbnailImageConfiguration;
            var _local_2:IWindowContainer = this.getImgSelectorContainer(_arg_1);
            if (this._modelController.mode != _arg_1){
                _local_2.visible = false;
                return;
            };
            _local_2.visible = true;
            var _local_3:IItemListWindow = IItemListWindow(_local_2.findChildByName("img_list"));
            if (_local_3.numListItems == 0){
                this.populateImgList(_local_3, _arg_1);
            };
            var _local_4:Array = this._navigator.thumbRenderer.imageConfigurations.getImageList(_arg_1);
            var _local_5:int = this._modelController.getImgId();
            var _local_6:int;
            while (_local_6 < _local_4.length) {
                _local_7 = _local_4[_local_6];
                Logger.log(((("CHECK SELECTED: " + _local_5) + ", ") + _local_7.id));
                _local_7.setSelected((_local_7.id == _local_5));
                _local_6++;
            };
        }
        private function populateImgList(_arg_1:IItemListWindow, _arg_2:int):void
        {
            var _local_9:int;
            var _local_10:ThumbnailImageConfiguration;
            var _local_11:IRegionWindow;
            var _local_12:IBitmapWrapperWindow;
            var _local_3:int = 66;
            var _local_4:int = 3;
            var _local_5:int = 66;
            var _local_6:Array = this._navigator.thumbRenderer.imageConfigurations.getImageList(_arg_2);
            var _local_7:IWindowContainer;
            var _local_8:int;
            while (_local_8 < _local_6.length) {
                _local_9 = (_local_8 % _local_4);
                if (_local_9 == 0){
                    _local_7 = IWindowContainer(this._navigator.windowManager.createWindow(("row_" + _local_8), "", HabboWindowType._SafeStr_3728, HabboWindowStyle._SafeStr_3729, HabboWindowParam._SafeStr_6023, new Rectangle(0, 0, _arg_1.width, _local_3)));
                    _arg_1.addListItem(_local_7);
                };
                _local_10 = _local_6[_local_8];
                _local_11 = IRegionWindow(this._navigator.windowManager.createWindow(("img_" + _local_8), "", WindowType._SafeStr_6090, HabboWindowStyle._SafeStr_4662, (HabboWindowParam._SafeStr_3731 | HabboWindowParam._SafeStr_6023), new Rectangle((_local_9 * _local_5), 0, _local_5, _local_3), this.onImgSel, _local_10.id));
                _local_11.mouseThreshold = 0;
                _local_12 = IBitmapWrapperWindow(this._navigator.windowManager.createWindow(("img_" + _local_8), "", HabboWindowType._SafeStr_6022, HabboWindowStyle._SafeStr_4662, HabboWindowParam._SafeStr_6023, new Rectangle(0, 0, _local_5, _local_3), this.onImgSel, _local_10.id));
                _local_12.bitmap = new BitmapData(_local_12.width, _local_12.height);
                _local_10.registerListImg(_local_12);
                _local_11.addChild(_local_12);
                _local_7.addChild(_local_11);
                _local_8++;
            };
        }
        private function setEnabled(_arg_1:IButtonWindow, _arg_2:Boolean):void
        {
            if (_arg_2){
                _arg_1.enable();
            }
            else {
                _arg_1.disable();
            };
        }
        private function refreshHeader():void
        {
            this._navigator.thumbRenderer.refreshThumbnail(IWindowContainer(this._window.findChildByName("picframe")), this._modelController.data, false);
        }

    }
}//package com.sulake.habbo.navigator.roomthumbnails

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// HabboWindowParam = "_-29D" (String#6233, DoABC#2)
// HabboWindowStyle = "_-0E1" (String#14608, DoABC#2)
// HabboWindowType = "_-29U" (String#19384, DoABC#2)
// RoomThumbnailRenderer = "_-3Kq" (String#7719, DoABC#2)
// WindowType = "_-1yl" (String#6008, DoABC#2)
// IRegionWindow = "_-dg" (String#2146, DoABC#2)
// Util = "_-1ve" (String#445, DoABC#2)
// ThumbnailImageConfiguration = "_-1Ew" (String#5156, DoABC#2)
// RoomThumbnailObjectData = "_-bW" (String#8446, DoABC#2)
// RoomThumbnailCtrl = "_-2z2" (String#7264, DoABC#2)
// UpdateRoomThumbnailMessageComposer = "_-1up" (String#18750, DoABC#2)
// _SafeStr_3728 = "_-1IW" (String#5215, DoABC#2)
// _SafeStr_3729 = "_-06z" (String#14322, DoABC#2)
// _SafeStr_3731 = "_-B" (String#22654, DoABC#2)
// hideChildren = "_-14q" (String#1615, DoABC#2)
// thumbnail = "_-02n" (String#14150, DoABC#2)
// thumbRenderer = "_-2Ac" (String#19431, DoABC#2)
// flatId = "_-3CK" (String#21973, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// getLowestPoint = "_-0t0" (String#16161, DoABC#2)
// refreshTab = "_-26v" (String#6182, DoABC#2)
// _SafeStr_4662 = "_-0g1" (String#15673, DoABC#2)
// _modelController = "_-0XB" (String#112, DoABC#2)
// addObj = "_-1Uy" (String#17703, DoABC#2)
// _SafeStr_6010 = "_-1wP" (String#18817, DoABC#2)
// imageConfigurations = "_-2yE" (String#21403, DoABC#2)
// refreshThumbnail = "_-04K" (String#14216, DoABC#2)
// _SafeStr_6022 = "_-1t4" (String#18679, DoABC#2)
// _SafeStr_6023 = "_-Mr" (String#23121, DoABC#2)
// roundEdges = "_-A9" (String#22624, DoABC#2)
// objects = "_-8h" (String#22568, DoABC#2)
// frontImgId = "_-2Ep" (String#19597, DoABC#2)
// pos = "_-g8" (String#23898, DoABC#2)
// _SafeStr_6034 = "_-gy" (String#23927, DoABC#2)
// _SafeStr_6036 = "_-0-d" (String#14037, DoABC#2)
// _SafeStr_6037 = "_-3FA" (String#22084, DoABC#2)
// imgId = "_-wA" (String#24536, DoABC#2)
// getScreenLocForPos = "_-2jf" (String#20832, DoABC#2)
// getImageList = "_-zA" (String#24657, DoABC#2)
// registerListImg = "_-1ca" (String#17993, DoABC#2)
// _SafeStr_6054 = "_-u9" (String#24455, DoABC#2)
// _SafeStr_6055 = "_-1MM" (String#17373, DoABC#2)
// _SafeStr_6056 = "_-Kq" (String#23037, DoABC#2)
// _SafeStr_6057 = "_-0GF" (String#14694, DoABC#2)
// _SafeStr_6058 = "_-r1" (String#24316, DoABC#2)
// getCopy = "_-119" (String#16504, DoABC#2)
// enteredGuestRoom = "_-2Qx" (String#20085, DoABC#2)
// prepareWindow = "_-RN" (String#219, DoABC#2)
// setProcDirectly = "_-24s" (String#19218, DoABC#2)
// onSaveButton = "_-2AC" (String#19411, DoABC#2)
// onCancelButton = "_-27z" (String#19329, DoABC#2)
// onBgTabButton = "_-05m" (String#14273, DoABC#2)
// onTopTabButton = "_-Au" (String#22652, DoABC#2)
// onObjTabButton = "_-1rN" (String#18599, DoABC#2)
// getImgSelectorContainer = "_-2VH" (String#20251, DoABC#2)
// backToRoomSettings = "_-fe" (String#23873, DoABC#2)
// roomInfoViewCtrl = "_-HS" (String#22911, DoABC#2)
// mode = "_-3Cz" (String#2023, DoABC#2)
// reload = "_-3AK" (String#7519, DoABC#2)
// onSelectPos = "_-2pD" (String#21048, DoABC#2)
// setPos = "_-05A" (String#14250, DoABC#2)
// onImgSel = "_-0my" (String#15936, DoABC#2)
// setImg = "_-wg" (String#24557, DoABC#2)
// refreshHeader = "_-18C" (String#834, DoABC#2)
// refreshEditArea = "_-0Sr" (String#15164, DoABC#2)
// refreshImgSelectors = "_-2tV" (String#21222, DoABC#2)
// setEnabled = "_-05S" (String#1399, DoABC#2)
// refreshEditImg = "_-1wd" (String#18828, DoABC#2)
// refreshPositionGrid = "_-1zd" (String#18953, DoABC#2)
// getButton = "_-1sK" (String#18645, DoABC#2)
// refreshTileLoc = "_-09p" (String#14439, DoABC#2)
// refreshBlockedTiles = "_-2ab" (String#20469, DoABC#2)
// getBlockedPositions = "_-yo" (String#24643, DoABC#2)
// refreshImgSelector = "_-0ha" (String#15731, DoABC#2)
// populateImgList = "_-0wO" (String#16286, DoABC#2)
// getImgId = "_-0gW" (String#15694, DoABC#2)
// _SafeStr_6090 = "_-34m" (String#21687, DoABC#2)
// mouseThreshold = "_-0OA" (String#4051, DoABC#2)


