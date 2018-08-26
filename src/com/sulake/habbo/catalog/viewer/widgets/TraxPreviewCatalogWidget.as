
package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.sound.HabboMusicPrioritiesEnum;
    import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
    import com.sulake.habbo.catalog.viewer.IProduct;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.habbo.sound.ISongInfo;

    public class TraxPreviewCatalogWidget extends CatalogWidget implements ICatalogWidget 
    {

        private var _soundManager:IHabboSoundManager;
        private var _SafeStr_10451:IButtonWindow;
        private var _SafeStr_10453:int = -1;

        public function TraxPreviewCatalogWidget(_arg_1:IWindowContainer, _arg_2:IHabboSoundManager)
        {
            super(_arg_1);
            this._SafeStr_10451 = (_window.findChildByName("listen") as IButtonWindow);
            Logger.log(("Trax listener found button: " + this._SafeStr_10451));
            if (this._SafeStr_10451 != null){
                this._SafeStr_10451.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClickPlay);
                this._SafeStr_10451.disable();
            };
            this._soundManager = _arg_2;
        }
        override public function dispose():void
        {
            if (this._SafeStr_10451 != null){
                this._SafeStr_10451.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClickPlay);
            };
            if (((!((this._soundManager == null))) && (!((this._soundManager.musicController == null))))){
                this._soundManager.musicController.stop(HabboMusicPrioritiesEnum._SafeStr_10456);
                this._soundManager = null;
            };
            super.dispose();
        }
        override public function init():Boolean
        {
            if (!super.init()){
                return (false);
            };
            if (page.offers.length == 0){
                return (false);
            };
            events.addEventListener(WidgetEvent.CWE_SELECT_PRODUCT, this.onSelectProduct);
            return (true);
        }
        override public function closed():void
        {
            super.closed();
            if (((!((this._soundManager == null))) && (!((this._soundManager.musicController == null))))){
                this._soundManager.musicController.stop(HabboMusicPrioritiesEnum._SafeStr_10456);
            };
        }
        private function onSelectProduct(_arg_1:SelectProductEvent):void
        {
            if ((((_arg_1 == null)) || ((_arg_1.offer == null)))){
                return;
            };
            var _local_2:Boolean;
            var _local_3:IProduct = _arg_1.offer.productContainer.firstProduct;
            if (_local_3.extraParam.length > 0){
                this._SafeStr_10453 = parseInt(_local_3.extraParam);
                _local_2 = true;
            };
            if (this._SafeStr_10451 != null){
                if (_local_2){
                    this._SafeStr_10451.enable();
                }
                else {
                    this._SafeStr_10451.disable();
                };
            };
        }
        private function onClickPlay(_arg_1:WindowMouseEvent):void
        {
            if (((!((this._soundManager == null))) && (!((this._soundManager.musicController == null))))){
                this.forceNoFadeoutOnPlayingSong(HabboMusicPrioritiesEnum._SafeStr_6658);
                this.forceNoFadeoutOnPlayingSong(HabboMusicPrioritiesEnum._SafeStr_10456);
                this._soundManager.musicController.playSong(this._SafeStr_10453, HabboMusicPrioritiesEnum._SafeStr_10456, 15, 40, 0, 2);
            };
        }
        private function forceNoFadeoutOnPlayingSong(_arg_1:int):void
        {
            var _local_3:ISongInfo;
            var _local_2:int = this._soundManager.musicController.getSongIdPlayingAtPriority(_arg_1);
            if (_local_2 != -1){
                _local_3 = this._soundManager.musicController.getSongInfo(_local_2);
                if (_local_3.soundObject != null){
                    _local_3.soundObject.fadeOutSeconds = 0;
                };
            };
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets

// onSelectProduct = "_-qr" (String#463, DoABC#2)
// _SafeStr_10451 = "_-3-e" (String#7297, DoABC#2)
// _SafeStr_10453 = "_-232" (String#6106, DoABC#2)
// onClickPlay = "_-27U" (String#6190, DoABC#2)
// _SafeStr_10456 = "_-2Gz" (String#19682, DoABC#2)
// forceNoFadeoutOnPlayingSong = "_-c9" (String#8458, DoABC#2)
// CatalogWidget = "_-1pJ" (String#5844, DoABC#2)
// ICatalogWidget = "_-016" (String#3585, DoABC#2)
// ISongInfo = "_-2vd" (String#7190, DoABC#2)
// HabboMusicPrioritiesEnum = "_-2lY" (String#6994, DoABC#2)
// TraxPreviewCatalogWidget = "_-JI" (String#8069, DoABC#2)
// fadeOutSeconds = "_-0GD" (String#3874, DoABC#2)
// IHabboSoundManager = "_-0vD" (String#4750, DoABC#2)
// extraParam = "_-AM" (String#7874, DoABC#2)
// firstProduct = "_-KM" (String#8089, DoABC#2)
// musicController = "_-1Qk" (String#5366, DoABC#2)
// getSongIdPlayingAtPriority = "_-u5" (String#8768, DoABC#2)
// _SafeStr_6658 = "_-1VW" (String#17722, DoABC#2)
// getSongInfo = "_-0Fc" (String#3864, DoABC#2)
// soundObject = "_-HA" (String#8022, DoABC#2)
// playSong = "_-0VK" (String#4210, DoABC#2)


