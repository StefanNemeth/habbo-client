
package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.catalog.recycler.IRecyclerVisualization;
    import com.sulake.habbo.catalog.viewer.CatalogObjectMover;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.recycler.IRecycler;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.habbo.catalog.recycler.RecyclerLogic;
    import com.sulake.habbo.catalog.recycler.FurniSlotItem;
    import com.sulake.habbo.room.ImageResult;
    import flash.geom.Point;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.room.ISelectedRoomObjectData;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.room.object.RoomObjectOperationEnum;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.assets.BitmapDataAsset;

    public class RecyclerCatalogWidget extends CatalogWidget implements ICatalogWidget, IRecyclerVisualization 
    {

        private var _SafeStr_10534:CatalogObjectMover;

        public function RecyclerCatalogWidget(_arg_1:IWindowContainer)
        {
            super(_arg_1);
        }
        private function get recycler():IRecycler
        {
            return (page.viewer.catalog.getRecycler());
        }
        override public function dispose():void
        {
            if (this._SafeStr_10534 != null){
                this._SafeStr_10534.dispose();
                this._SafeStr_10534 = null;
            };
            if (this.recycler != null){
                this.recycler.cancel();
            };
            super.dispose();
        }
        override public function init():Boolean
        {
            if (!super.init()){
                return (false);
            };
            if (this.recycler == null){
                return (false);
            };
            this.recycler.init(this);
            return (true);
        }
        public function RecyclerCatalogWidget():void
        {
            var _local_1:XML = this.getAssetXML("recyclerWidgetInactive");
            if (_local_1 == null){
                return;
            };
            window.buildFromXML(_local_1);
            this.RecyclerCatalogWidget();
            var _local_2:ITextWindow = ((window.parent as IWindowContainer).findChildByName("ctlg_header_text") as ITextWindow);
            if (_local_2 != null){
                _local_2.text = page.viewer.catalog.localization.getKey("recycler.info.closed");
            };
        }
        public function RecyclerCatalogWidget(_arg_1:int):void
        {
            var _local_2:String = String(int((_arg_1 / 60)));
            var _local_3:String = String((_arg_1 % 60));
            page.viewer.catalog.localization.registerParameter("recycler.alert.timeout", "minutes", _local_2);
            page.viewer.catalog.localization.registerParameter("recycler.alert.timeout", "seconds", _local_3);
            var _local_4:XML = this.getAssetXML("recyclerWidgetTimeout");
            if (_local_4 == null){
                return;
            };
            window.removeChildAt(0);
            window.addChild(page.viewer.catalog.windowManager.buildFromXML(_local_4));
            var _local_5:ITextWindow = ((window.parent as IWindowContainer).findChildByName("ctlg_header_text") as ITextWindow);
            if (_local_5 != null){
                _local_5.text = page.viewer.catalog.localization.getKey("recycler.alert.timeout");
            };
        }
        public function RecyclerCatalogWidget():void
        {
            var _local_1:XML = this.getAssetXML("recyclerWidgetInactive");
            if (_local_1 == null){
                return;
            };
            window.removeChildAt(0);
            window.addChild(page.viewer.catalog.windowManager.buildFromXML(_local_1));
            this.RecyclerCatalogWidget();
            var _local_2:ITextWindow = ((window.parent as IWindowContainer).findChildByName("ctlg_header_text") as ITextWindow);
            if (_local_2 != null){
                _local_2.text = "";
            };
        }
        public function RecyclerCatalogWidget():void
        {
            var _local_1:XML = this.getAssetXML("recyclerWidgetInactive");
            if (_local_1 == null){
                return;
            };
            window.removeChildAt(0);
            window.addChild(page.viewer.catalog.windowManager.buildFromXML(_local_1));
            this.RecyclerCatalogWidget();
            var _local_2:ITextWindow = ((window.parent as IWindowContainer).findChildByName("ctlg_header_text") as ITextWindow);
            if (_local_2 != null){
                _local_2.text = page.viewer.catalog.localization.getKey("recycler.info.finished");
            };
        }
        public function RecyclerCatalogWidget():void
        {
            var _local_1:XML = this.getAssetXML("recyclerWidget");
            if (_local_1 == null){
                return;
            };
            window.removeChildAt(0);
            window.addChild(page.viewer.catalog.windowManager.buildFromXML(_local_1));
            this.RecyclerCatalogWidget();
            window.procedure = this.RecyclerCatalogWidget;
            window.parent.procedure = this.RecyclerCatalogWidget;
            var _local_2:ITextWindow = ((window.parent as IWindowContainer).findChildByName("ctlg_header_text") as ITextWindow);
            if (_local_2 != null){
                _local_2.text = page.viewer.catalog.localization.getKey("recycler.info.ready");
            };
        }
        private function RecyclerCatalogWidget():void
        {
            var _local_2:int;
            var _local_3:IBitmapWrapperWindow;
            var _local_1:BitmapData = this.RecyclerCatalogWidget("ctlg_recycler_slot_bg");
            if (_local_1 == null){
                return;
            };
            _local_2 = 1;
            while (_local_2 <= RecyclerLogic._SafeStr_10336) {
                _local_3 = (window.findChildByName(("slot_bg_" + _local_2)) as IBitmapWrapperWindow);
                if (_local_3 != null){
                    _local_3.bitmap = _local_1.clone();
                    _local_3.procedure = this.RecyclerCatalogWidget;
                };
                _local_2++;
            };
            _local_2 = 1;
            while (_local_2 <= RecyclerLogic._SafeStr_10336) {
                _local_3 = (window.findChildByName(("slot_img_" + _local_2)) as IBitmapWrapperWindow);
                if (_local_3 != null){
                    _local_3.bitmap = _local_1.clone();
                    _local_3.procedure = this.RecyclerCatalogWidget;
                };
                _local_2++;
            };
        }
        public function RecyclerCatalogWidget():void
        {
            var _local_2:IBitmapWrapperWindow;
            var _local_3:FurniSlotItem;
            var _local_4:ImageResult;
            var _local_5:BitmapData;
            var _local_6:Point;
            if ((((window == null)) || ((this.recycler == null)))){
                return;
            };
            var _local_1:int;
            while (_local_1 < RecyclerLogic._SafeStr_10336) {
                _local_2 = (window.findChildByName(("slot_img_" + (_local_1 + 1))) as IBitmapWrapperWindow);
                if (_local_2 == null){
                    return;
                };
                _local_3 = this.recycler.RecyclerLogic(_local_1);
                if (_local_3 == null){
                    _local_2.bitmap = new BitmapData(1, 1, true, 0xFFFFFF);
                }
                else {
                    _local_4 = this.MarketPlaceCatalogWidget(_local_3);
                    if (((!((_local_4 == null))) && (!((_local_4.data == null))))){
                        _local_5 = new BitmapData(_local_2.width, _local_2.height, true, 0xFFFFFF);
                        _local_5.fillRect(_local_5.rect, 0xFFFFFF);
                        _local_6 = new Point(((_local_2.width - _local_4.data.width) / 2), ((_local_2.height - _local_4.data.height) / 2));
                        _local_5.copyPixels(_local_4.data, _local_4.data.rect, _local_6, null, null, true);
                        _local_2.bitmap = _local_5;
                        _local_4.data.dispose();
                    };
                };
                _local_1++;
            };
        }
        private function MarketPlaceCatalogWidget(_arg_1:FurniSlotItem):ImageResult
        {
            var _local_2:ImageResult;
            if ((((_arg_1 == null)) || ((page.viewer.roomEngine == null)))){
                return (null);
            };
            if (_arg_1.category == RoomObjectCategoryEnum._SafeStr_4329){
                return (page.viewer.roomEngine.getFurnitureIcon(_arg_1.typeId, null));
            };
            if (_arg_1.category == RoomObjectCategoryEnum._SafeStr_4330){
                return (page.viewer.roomEngine.getWallItemIcon(_arg_1.typeId, null, _arg_1.xxxExtra));
            };
            return (null);
        }
        private function RecyclerCatalogWidget(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:IRoomEngine = page.viewer.roomEngine;
            if (_local_3 == null){
                return;
            };
            var _local_4:ISelectedRoomObjectData = _local_3.RoomEngine(_local_3.activeRoomId, _local_3.activeRoomCategory);
            switch (_arg_1.type){
                case WindowMouseEvent.WME_OUT:
                    if (this._SafeStr_10534 != null){
                        this._SafeStr_10534.CatalogObjectMover();
                    };
                    return;
                case WindowMouseEvent.WME_MOVE:
                    if (this._SafeStr_10534 != null){
                        this._SafeStr_10534.RecyclerCatalogWidget(_arg_1, _arg_2, _local_4);
                    };
                    return;
                case WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER:
                    if (this._SafeStr_10534 == null){
                        this._SafeStr_10534 = new CatalogObjectMover();
                        this._SafeStr_10534.mainContainer = window;
                        this._SafeStr_10534.roomEngine = _local_3;
                    };
                    return;
            };
        }
        private function RecyclerCatalogWidget(event:WindowEvent, target:IWindow):void
        {
            var slotId:int;
            var roomEngine:IRoomEngine = page.viewer.roomEngine;
            if ((((roomEngine == null)) || ((this.recycler == null)))){
                return;
            };
            var objectData:ISelectedRoomObjectData = roomEngine.RoomEngine(roomEngine.activeRoomId, roomEngine.activeRoomCategory);
            if (event.type == WindowMouseEvent.WME_UP){
                if (event.window.name.indexOf("slot_") == 0){
                    slotId = (int(event.window.name.charAt((event.window.name.length - 1))) - 1);
                    if (objectData != null){
                        if (objectData.operation != RoomObjectOperationEnum.OBJECT_PLACE){
                            page.viewer.catalog.windowManager.alert("${generic.alert.title}", "${catalog.alert.recycler.inventory}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                            {
                                _arg_1.dispose();
                            });
                            return;
                        };
                        this.recycler.RecyclerLogic(slotId, objectData.id, objectData.category, objectData.typeId, objectData.instanceData);
                    }
                    else {
                        this.recycler.RecyclerLogic(slotId);
                    };
                    roomEngine.RoomEngine();
                    if (this._SafeStr_10534 != null){
                        this._SafeStr_10534.CatalogObjectMover();
                    };
                    return;
                };
            };
            if (event.type == WindowMouseEvent.WME_MOVE){
                this.RecyclerCatalogWidget(event, target);
            };
        }
        public function RecyclerCatalogWidget(_arg_1:Boolean):void
        {
            if (((disposed) || ((window == null)))){
                return;
            };
            var _local_2:IWindow = window.findChildByName("recycler_recycle");
            if (_local_2 != null){
                if (_arg_1){
                    _local_2.enable();
                    _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.RecyclerCatalogWidget);
                }
                else {
                    _local_2.disable();
                };
            };
        }
        private function RecyclerCatalogWidget(_arg_1:WindowMouseEvent):void
        {
            if (this.recycler != null){
                this.recycler.RecyclerLogic();
            };
        }
        private function getAssetXML(_arg_1:String):XML
        {
            var _local_2:XmlAsset = (page.viewer.catalog.assets.getAssetByName(_arg_1) as XmlAsset);
            if (_local_2 == null){
                return (null);
            };
            return ((_local_2.content as XML));
        }
        private function RecyclerCatalogWidget(_arg_1:String):BitmapData
        {
            var _local_2:BitmapDataAsset = (page.viewer.catalog.assets.getAssetByName(_arg_1) as BitmapDataAsset);
            if (_local_2 == null){
                return (null);
            };
            return ((_local_2.content as BitmapData));
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets

// RecyclerLogic = "_-06m" (String#3697, DoABC#2)
// RecyclerLogic = "_-Wq" (String#8345, DoABC#2)
// RecyclerLogic = "_-1oW" (String#5832, DoABC#2)
// RecyclerLogic = "_-0VV" (String#4216, DoABC#2)
// _SafeStr_10336 = "_-0g8" (String#15677, DoABC#2)
// RecyclerCatalogWidget = "_-uS" (String#8772, DoABC#2)
// RecyclerCatalogWidget = "_-0kj" (String#4516, DoABC#2)
// RecyclerCatalogWidget = "_-3IN" (String#7676, DoABC#2)
// RecyclerCatalogWidget = "_-IF" (String#8044, DoABC#2)
// RecyclerCatalogWidget = "_-1kQ" (String#5758, DoABC#2)
// RecyclerCatalogWidget = "_-0qa" (String#4652, DoABC#2)
// _SafeStr_10534 = "_-1AN" (String#16876, DoABC#2)
// RecyclerCatalogWidget = "_-rG" (String#24327, DoABC#2)
// RecyclerCatalogWidget = "_-2Sv" (String#20157, DoABC#2)
// RecyclerCatalogWidget = "_-0vF" (String#16246, DoABC#2)
// RoomEngine = "_-2oq" (String#899, DoABC#2)
// RecyclerCatalogWidget = "_-1mP" (String#18396, DoABC#2)
// ImageResult = "_-31w" (String#21576, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// ISelectedRoomObjectData = "_-J6" (String#8063, DoABC#2)
// IRecycler = "_-0fo" (String#4421, DoABC#2)
// RecyclerLogic = "_-21p" (String#6082, DoABC#2)
// IRecyclerVisualization = "_-2gZ" (String#6880, DoABC#2)
// FurniSlotItem = "_-19d" (String#5069, DoABC#2)
// CatalogWidget = "_-1pJ" (String#5844, DoABC#2)
// ICatalogWidget = "_-016" (String#3585, DoABC#2)
// RoomObjectOperationEnum = "_-0Zp" (String#15436, DoABC#2)
// RecyclerCatalogWidget = "_-0cp" (String#4362, DoABC#2)
// CatalogObjectMover = "_-2Op" (String#6538, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// WME_MOVE = "_-1ee" (String#18084, DoABC#2)
// WME_UP = "_-0Cs" (String#14566, DoABC#2)
// _SafeStr_4329 = "_-bN" (String#23687, DoABC#2)
// _SafeStr_4330 = "_-0cQ" (String#15531, DoABC#2)
// activeRoomId = "_-kJ" (String#2172, DoABC#2)
// activeRoomCategory = "_-1qo" (String#1770, DoABC#2)
// RecyclerCatalogWidget = "_-09V" (String#3748, DoABC#2)
// operation = "_-0Ag" (String#3770, DoABC#2)
// MarketPlaceCatalogWidget = "_-2ST" (String#889, DoABC#2)
// CatalogObjectMover = "_-1SZ" (String#17604, DoABC#2)
// getAssetXML = "_-1XT" (String#364, DoABC#2)
// RoomEngine = "_-0w6" (String#4772, DoABC#2)
// RoomObjectCategoryEnum = "_-1eh" (String#5639, DoABC#2)
// RecyclerCatalogWidget = "_-1Dr" (String#5140, DoABC#2)


