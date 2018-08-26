
package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.catalog.viewer.IDragAndDropDoneReceiver;
    import flash.display.BitmapData;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetInitPurchaseEvent;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetUpdateRoomPreviewEvent;
    import flash.geom.Point;

    public class RoomPreviewCatalogWidget extends CatalogWidget implements ICatalogWidget, IGetImageListener, IDragAndDropDoneReceiver 
    {

        private var _SafeStr_10529:int = -1;
        private var _SafeStr_10530:int = -1;
        private var _SafeStr_10531:BitmapData = null;
        private var _imageStoreWindow:BitmapData = null;
        private var _SafeStr_5001:Object;
        private var _offer:Offer;

        public function RoomPreviewCatalogWidget(_arg_1:IWindowContainer)
        {
            super(_arg_1);
        }
        override public function dispose():void
        {
            if (this._SafeStr_10531 != null){
                this._SafeStr_10531.dispose();
                this._SafeStr_10531 = null;
            };
            if (this._imageStoreWindow != null){
                this._imageStoreWindow.dispose();
                this._imageStoreWindow = null;
            };
            events.removeEventListener(WidgetEvent.CWE_UPDATE_ROOM_PREVIEW, this.onUpdateRoomPreview);
            super.dispose();
        }
        override public function init():Boolean
        {
            if (!super.init()){
                return (false);
            };
            var _local_1:IBitmapWrapperWindow = (window.getChildByName("catalog_floor_preview_example") as IBitmapWrapperWindow);
            _local_1.procedure = this.eventProc;
            events.addEventListener(WidgetEvent.CWE_UPDATE_ROOM_PREVIEW, this.onUpdateRoomPreview);
            events.addEventListener(WidgetEvent.CWE_SELECT_PRODUCT, this.onPreviewProduct);
            return (true);
        }
        private function onPreviewProduct(_arg_1:SelectProductEvent):void
        {
            if (_arg_1 == null){
                return;
            };
            this._offer = _arg_1.offer;
        }
        private function eventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == WindowMouseEvent.WME_UP){
                this._SafeStr_5001 = null;
            }
            else {
                if (_arg_1.type == WindowMouseEvent.WME_DOWN){
                    if (_arg_2 == null){
                        return;
                    };
                    this._SafeStr_5001 = _arg_2;
                }
                else {
                    if ((((((_arg_1.type == WindowMouseEvent.WME_OUT)) && (!((this._SafeStr_5001 == null))))) && ((this._SafeStr_5001 == _arg_2)))){
                        if (this._offer){
                            (page.viewer.catalog as HabboCatalog).requestSelectedItemToMover(this, this._offer);
                            this._SafeStr_5001 = null;
                        };
                    }
                    else {
                        if (_arg_1.type == WindowMouseEvent.WME_UP){
                            (this._SafeStr_5001 == null);
                        }
                        else {
                            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                                (this._SafeStr_5001 == null);
                            }
                            else {
                                if (_arg_1.type == WindowMouseEvent.WME_DOUBLE_CLICK){
                                    this._SafeStr_5001 = null;
                                };
                            };
                        };
                    };
                };
            };
        }
        public function onDragAndDropDone(_arg_1:Boolean):void
        {
            if (disposed){
                return;
            };
            if (_arg_1){
                events.dispatchEvent(new CatalogWidgetInitPurchaseEvent(false));
            };
        }
        public function stopDragAndDrop():void
        {
        }
        private function onUpdateRoomPreview(_arg_1:CatalogWidgetUpdateRoomPreviewEvent):void
        {
            var _local_5:BitmapData;
            var _local_6:BitmapData;
            var _local_2:String = "ads_twi_windw";
            var _local_3:ImageResult = page.viewer.roomEngine.getRoomImage(_arg_1.floorType, _arg_1.wallType, _arg_1.landscapeType, _arg_1.tileSize, this, _local_2);
            var _local_4:ImageResult = page.viewer.roomEngine.getGenericRoomObjectImage(_local_2, "", new Vector3d(180, 0, 0), _arg_1.tileSize, this);
            if (((!((_local_3 == null))) && (!((_local_4 == null))))){
                this._SafeStr_10529 = _local_3.id;
                this._SafeStr_10530 = _local_4.id;
                _local_5 = (_local_3.data as BitmapData);
                _local_6 = (_local_4.data as BitmapData);
                if (this._SafeStr_10531 != null){
                    this._SafeStr_10531.dispose();
                };
                if (this._imageStoreWindow != null){
                    this._imageStoreWindow.dispose();
                };
                this._SafeStr_10531 = _local_5;
                this._imageStoreWindow = _local_6;
                this.setRoomImage(_local_5, _local_6);
            };
        }
        private function setRoomImage(_arg_1:BitmapData, _arg_2:BitmapData):void
        {
            var _local_3:IBitmapWrapperWindow;
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            if (((((!((_arg_1 == null))) && (!((_arg_2 == null))))) && (!(window.disposed)))){
                _local_3 = (window.getChildByName("catalog_floor_preview_example") as IBitmapWrapperWindow);
                if (_local_3 != null){
                    if (_local_3.bitmap == null){
                        _local_3.bitmap = new BitmapData(_local_3.width, _local_3.height, true, 0xFFFFFF);
                    };
                    _local_4 = -45;
                    _local_5 = 20;
                    _local_3.bitmap.fillRect(_local_3.bitmap.rect, 0xFFFFFF);
                    _local_6 = (((_local_3.width - _arg_1.width) / 2) + _local_4);
                    _local_7 = (((_local_3.height - _arg_1.height) / 2) + _local_5);
                    _local_3.bitmap.copyPixels(_arg_1, _arg_1.rect, new Point(_local_6, _local_7), null, null, true);
                    _local_8 = ((_local_3.width / 2) + _local_4);
                    _local_9 = (((_local_3.height / 2) + _local_5) - _arg_2.height);
                    _local_8 = (_local_8 + 1);
                    _local_9 = (_local_9 + 44);
                    _local_3.bitmap.copyPixels(_arg_2, _arg_2.rect, new Point(_local_8, _local_9), null, null, true);
                    _local_3.invalidate();
                };
            };
        }
        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            if (disposed){
                return;
            };
            switch (_arg_1){
                case this._SafeStr_10529:
                    this._SafeStr_10529 = 0;
                    if (this._SafeStr_10531 != null){
                        this._SafeStr_10531.dispose();
                    };
                    this._SafeStr_10531 = _arg_2;
                    break;
                case this._SafeStr_10530:
                    this._SafeStr_10530 = 0;
                    if (this._imageStoreWindow != null){
                        this._imageStoreWindow.dispose();
                    };
                    this._imageStoreWindow = _arg_2;
                    break;
            };
            if (((!((this._SafeStr_10531 == null))) && (!((this._imageStoreWindow == null))))){
                this.setRoomImage(this._SafeStr_10531, this._imageStoreWindow);
            };
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets

// requestSelectedItemToMover = "_-Xj" (String#23551, DoABC#2)
// stopDragAndDrop = "_-1PY" (String#17490, DoABC#2)
// onPreviewProduct = "_-r4" (String#2207, DoABC#2)
// _SafeStr_10529 = "_-2sV" (String#21179, DoABC#2)
// _SafeStr_10530 = "_-0Ee" (String#14630, DoABC#2)
// _SafeStr_10531 = "_-0Of" (String#15015, DoABC#2)
// onUpdateRoomPreview = "_-15-" (String#16653, DoABC#2)
// setRoomImage = "_-1aD" (String#17903, DoABC#2)
// ImageResult = "_-31w" (String#21576, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// IDragAndDropDoneReceiver = "_-Vz" (String#8320, DoABC#2)
// Offer = "_-0m2" (String#4550, DoABC#2)
// CatalogWidget = "_-1pJ" (String#5844, DoABC#2)
// ICatalogWidget = "_-016" (String#3585, DoABC#2)
// IGetImageListener = "_-2i7" (String#6909, DoABC#2)
// RoomPreviewCatalogWidget = "_-DO" (String#7939, DoABC#2)
// CatalogWidgetInitPurchaseEvent = "_-2yJ" (String#7244, DoABC#2)
// CatalogWidgetUpdateRoomPreviewEvent = "_-1w1" (String#5958, DoABC#2)
// floorType = "_-1D4" (String#16985, DoABC#2)
// wallType = "_-0n5" (String#15942, DoABC#2)
// landscapeType = "_-29h" (String#19391, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// WME_DOWN = "_-hL" (String#23944, DoABC#2)
// WME_UP = "_-0Cs" (String#14566, DoABC#2)
// onDragAndDropDone = "_-05o" (String#3681, DoABC#2)
// _SafeStr_5001 = "_-1CR" (String#1632, DoABC#2)
// eventProc = "_-0xb" (String#1584, DoABC#2)
// WME_DOUBLE_CLICK = "_-Y3" (String#23564, DoABC#2)
// _offer = "_-1jb" (String#165, DoABC#2)
// tileSize = "_-2va" (String#21298, DoABC#2)


