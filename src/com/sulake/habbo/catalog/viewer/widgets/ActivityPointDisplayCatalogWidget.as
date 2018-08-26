
package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.catalog.purse.PurseUpdateEvent;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.catalog.viewer.Offer;

    public class ActivityPointDisplayCatalogWidget extends CatalogWidget implements ICatalogWidget 
    {

        public function ActivityPointDisplayCatalogWidget(_arg_1:IWindowContainer)
        {
            super(_arg_1);
        }
        override public function dispose():void
        {
            var _local_1:HabboCatalog = HabboCatalog(page.viewer.catalog);
            _local_1.events.removeEventListener(PurseUpdateEvent._SafeStr_6445, this.onPurseUpdate);
            super.dispose();
        }
        override public function init():Boolean
        {
            if (!super.init()){
                return (false);
            };
            var _local_1:HabboCatalog = HabboCatalog(page.viewer.catalog);
            _local_1.events.addEventListener(PurseUpdateEvent._SafeStr_6445, this.onPurseUpdate);
            return (this.updateAmount());
        }
        private function updateAmount():Boolean
        {
            var _local_5:BitmapData;
            var _local_6:IBitmapWrapperWindow;
            if (disposed){
                return (false);
            };
            if (_window == null){
                return (false);
            };
            var _local_1:int = this.getActivityPointType();
            if (_local_1 < 1){
                _window.visible = false;
                return (false);
            };
            var _local_2:HabboCatalog = HabboCatalog(page.viewer.catalog);
            var _local_3:String = ("catalog.purchase.youractivitypoints." + _local_1);
            _local_2.localization.registerParameter(_local_3, "activitypoints", ("" + _local_2.getPurse().getActivityPointsForType(_local_1)));
            _window.findChildByName("activity_points_txt").caption = _local_2.localization.getKey(_local_3);
            var _local_4:BitmapDataAsset = (_local_2.assets.getAssetByName(("icon_activity_point_" + _local_1)) as BitmapDataAsset);
            if (_local_4){
                _local_5 = BitmapData(_local_4.content);
                _local_6 = IBitmapWrapperWindow(_window.findChildByName("activity_point_icon"));
                _local_6.disposesBitmap = false;
                _local_6.bitmap = _local_5;
                _local_6.width = _local_5.width;
                _local_6.height = _local_5.height;
            };
            _window.visible = true;
            return (true);
        }
        private function onPurseUpdate(_arg_1:PurseUpdateEvent):void
        {
            this.updateAmount();
        }
        private function getActivityPointType():int
        {
            var _local_1:Offer;
            if ((((page == null)) || ((page.offers == null)))){
                return (0);
            };
            for each (_local_1 in page.offers) {
                if (_local_1.activityPointType > 0){
                    return (_local_1.activityPointType);
                };
            };
            return (0);
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets

// onPurseUpdate = "_-04x" (String#14239, DoABC#2)
// updateAmount = "_-0Y-" (String#15356, DoABC#2)
// getActivityPointType = "_-2b4" (String#20490, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// PurseUpdateEvent = "_-11t" (String#16533, DoABC#2)
// Offer = "_-0m2" (String#4550, DoABC#2)
// CatalogWidget = "_-1pJ" (String#5844, DoABC#2)
// ICatalogWidget = "_-016" (String#3585, DoABC#2)
// ActivityPointDisplayCatalogWidget = "_-0T-" (String#4159, DoABC#2)
// activityPointType = "_-1gh" (String#5677, DoABC#2)
// getActivityPointsForType = "_-1c9" (String#5603, DoABC#2)
// disposesBitmap = "_-03U" (String#3637, DoABC#2)
// _SafeStr_6445 = "_-2CW" (String#19505, DoABC#2)


