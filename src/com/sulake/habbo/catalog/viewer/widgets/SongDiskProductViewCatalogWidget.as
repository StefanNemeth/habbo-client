
package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.sound.events.SongInfoReceivedEvent;
    import com.sulake.habbo.sound.HabboMusicPrioritiesEnum;
    import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
    import com.sulake.habbo.sound.ISongInfo;
    import com.sulake.habbo.catalog.viewer.IProduct;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.habbo.catalog.HabboCatalog;

    public class SongDiskProductViewCatalogWidget extends ProductViewCatalogWidget 
    {

        private var _soundManager:IHabboSoundManager;
        private var _SafeStr_10450:IWindowContainer;
        private var _SafeStr_10451:IButtonWindow;
        private var _SafeStr_10452:ITextWindow;
        private var _SafeStr_10453:int = -1;
        private var _SafeStr_10454:String = "";

        public function SongDiskProductViewCatalogWidget(_arg_1:IWindowContainer, _arg_2:IHabboSoundManager)
        {
            super(_arg_1);
            this._SafeStr_10451 = (_window.findChildByName("listen") as IButtonWindow);
            this._SafeStr_10452 = (_window.findChildByName("ctlg_song_length") as ITextWindow);
            if (this._SafeStr_10451 != null){
                this._SafeStr_10451.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClickPlay);
                this._SafeStr_10451.disable();
            };
            this._SafeStr_10450 = (_window.findChildByName("playPreviewContainer") as IWindowContainer);
            if (this._SafeStr_10450 != null){
                this._SafeStr_10450.visible = false;
            };
            this._soundManager = _arg_2;
            if (this._soundManager != null){
                this._soundManager.events.addEventListener(SongInfoReceivedEvent.SIR_TRAX_SONG_INFO_RECEIVED, this.onSongInfoReceivedEvent);
            };
        }
        override public function dispose():void
        {
            if (this._SafeStr_10451 != null){
                this._SafeStr_10451.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClickPlay);
            };
            if (((!((this._soundManager == null))) && (!((this._soundManager.musicController == null))))){
                this._soundManager.musicController.stop(HabboMusicPrioritiesEnum._SafeStr_10456);
                if (this._soundManager.events != null){
                    this._soundManager.events.removeEventListener(SongInfoReceivedEvent.SIR_TRAX_SONG_INFO_RECEIVED, this.onSongInfoReceivedEvent);
                };
                this._soundManager = null;
            };
            super.dispose();
        }
        override public function closed():void
        {
            super.closed();
            if (((!((this._soundManager == null))) && (!((this._soundManager.musicController == null))))){
                this._soundManager.musicController.stop(HabboMusicPrioritiesEnum._SafeStr_10456);
            };
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
        private function onClickPlay(_arg_1:WindowMouseEvent):void
        {
            if (((!((this._soundManager == null))) && (!((this._soundManager.musicController == null))))){
                this.forceNoFadeoutOnPlayingSong(HabboMusicPrioritiesEnum._SafeStr_6658);
                this.forceNoFadeoutOnPlayingSong(HabboMusicPrioritiesEnum._SafeStr_10456);
                this._soundManager.musicController.playSong(this._SafeStr_10453, HabboMusicPrioritiesEnum._SafeStr_10456, 15, 40, 0.5, 2);
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
        private function onSelectProduct(_arg_1:SelectProductEvent):void
        {
            if ((((_arg_1 == null)) || ((_arg_1.offer == null)))){
                return;
            };
            var _local_2:IProduct = _arg_1.offer.productContainer.firstProduct;
            if (_local_2.extraParam.length > 0){
                this._SafeStr_10453 = parseInt(_local_2.extraParam);
                if (this._SafeStr_10450 != null){
                    this._SafeStr_10450.visible = true;
                };
            }
            else {
                this._SafeStr_10453 = -1;
            };
            this.ProgressBar();
        }
        private function ProgressBar():void
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:String;
            var _local_6:String;
            var _local_7:ICoreLocalizationManager;
            var _local_8:String;
            var _local_1:Boolean;
            var _local_2:int = this.getSongLength();
            if (_local_2 >= 0){
                _local_3 = (_local_2 / 60);
                _local_4 = (_local_2 % 60);
                _local_5 = ("" + _local_3);
                _local_6 = ("" + _local_4);
                if (_local_4 < 10){
                    _local_6 = ("0" + _local_6);
                };
                _local_7 = (page.viewer.catalog as HabboCatalog).localization;
                _local_7.registerParameter("catalog.song.length", "min", _local_5);
                _local_8 = _local_7.registerParameter("catalog.song.length", "sec", _local_6);
                _local_1 = true;
                if (this._SafeStr_10452 != null){
                    this._SafeStr_10452.text = _local_8;
                };
            }
            else {
                if (this._SafeStr_10452 != null){
                    this._SafeStr_10452.text = "";
                };
            };
            if (this._SafeStr_10451 != null){
                if (_local_1){
                    this._SafeStr_10451.enable();
                }
                else {
                    this._SafeStr_10451.disable();
                };
            };
        }
        private function getSongLength():int
        {
            var _local_1:ISongInfo;
            if (((!((this._soundManager == null))) && (!((this._soundManager.musicController == null))))){
                _local_1 = this._soundManager.musicController.getSongInfo(this._SafeStr_10453);
                if (_local_1 != null){
                    return ((_local_1.length / 1000));
                };
                this._soundManager.musicController.requestSongInfoWithoutSamples(this._SafeStr_10453);
            };
            return (-1);
        }
        private function onSongInfoReceivedEvent(_arg_1:SongInfoReceivedEvent):void
        {
            if (_arg_1.id == this._SafeStr_10453){
                this.ProgressBar();
            };
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets

// onSelectProduct = "_-qr" (String#463, DoABC#2)
// _SafeStr_10450 = "_-1DL" (String#16997, DoABC#2)
// _SafeStr_10451 = "_-3-e" (String#7297, DoABC#2)
// _SafeStr_10452 = "_-0bJ" (String#15489, DoABC#2)
// _SafeStr_10453 = "_-232" (String#6106, DoABC#2)
// _SafeStr_10454 = "_-19e" (String#16843, DoABC#2)
// onClickPlay = "_-27U" (String#6190, DoABC#2)
// _SafeStr_10456 = "_-2Gz" (String#19682, DoABC#2)
// forceNoFadeoutOnPlayingSong = "_-c9" (String#8458, DoABC#2)
// getSongLength = "_-1SS" (String#17598, DoABC#2)
// ISongInfo = "_-2vd" (String#7190, DoABC#2)
// HabboMusicPrioritiesEnum = "_-2lY" (String#6994, DoABC#2)
// ProductViewCatalogWidget = "_-gM" (String#8516, DoABC#2)
// SongDiskProductViewCatalogWidget = "_-1Xx" (String#5518, DoABC#2)
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
// SIR_TRAX_SONG_INFO_RECEIVED = "_-02" (String#14127, DoABC#2)
// onSongInfoReceivedEvent = "_-1Di" (String#360, DoABC#2)
// ProgressBar = "_-1Js" (String#847, DoABC#2)
// requestSongInfoWithoutSamples = "_-3CP" (String#7560, DoABC#2)


