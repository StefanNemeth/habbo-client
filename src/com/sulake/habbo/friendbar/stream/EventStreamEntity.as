
package com.sulake.habbo.friendbar.stream
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.assets.IAssetLibrary;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.friendbar.utils.LinkTarget;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.AssetLoaderStruct;
    import flash.display.BitmapData;
    import flash.net.URLRequest;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.localization.ILocalization;
    import com.sulake.habbo.friendbar.utils.LinkResolver;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.components.ITextWindow;
    import __AS3__.vec.*;

    public class EventStreamEntity implements IDisposable 
    {

        public static var _SafeStr_9686:IWindowContainer;
        public static var _SafeStr_10962:IHabboLocalizationManager;
        public static var ASSETS:IAssetLibrary;
        public static var _SafeStr_10964:IHabboEventStream;
        private static const _SafeStr_10984:Vector.<EventStreamEntity> = new Vector.<EventStreamEntity>();
        private static const _SafeStr_10985:String = "title";
        private static const _SafeStr_10986:String = "message";
        private static const LINK:String = "link";
        private static const TEXT:String = "text";
        private static const _SafeStr_10987:String = "time";
        private static const _SafeStr_10988:String = "canvas";
        private static const LIKE_REGION:String = "like";
        private static const _SafeStr_10989:String = "border";
        private static const _SafeStr_10990:String = "label";
        private static const _SafeStr_10991:String = "icon";
        private static const _SafeStr_5582:uint = 4293519841;
        private static const _SafeStr_5583:uint = 4292467926;
        private static const _SafeStr_10992:uint = 0xFF0077B6;
        private static const _SafeStr_10993:uint = 4283058242;
        private static const _SafeStr_10994:uint = 0xFFFFFFFF;
        private static const _SafeStr_10995:String = "minutes";
        private static const _SafeStr_10996:String = "hours";
        private static const _SafeStr_10997:String = "days";

        private var _window:IWindowContainer;
        private var _disposed:Boolean = false;
        private var _recycled:Boolean = false;
        private var _id:int = -1;
        private var _linkTarget:LinkTarget;
        private var _minutesElapsed:int;
        private var _imageFilePath:String;

        public function EventStreamEntity():void
        {
            this._window = (_SafeStr_9686.clone() as IWindowContainer);
            this._window.findChildByName(LINK).addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onLinkClicked);
        }
        public static function allocate():EventStreamEntity
        {
            var _local_1:EventStreamEntity = (((_SafeStr_10984.length > 0)) ? _SafeStr_10984.pop() : new (EventStreamEntity)());
            _local_1._recycled = false;
            return (_local_1);
        }

        public function set id(_arg_1:int):void
        {
            this._id = _arg_1;
        }
        public function get id():int
        {
            return (this._id);
        }
        public function set even(_arg_1:Boolean):void
        {
            this._window.color = ((_arg_1) ? _SafeStr_5582 : _SafeStr_5583);
            this._window.findChildByName(_SafeStr_10989).visible = false;
        }
        public function get even():Boolean
        {
            return ((this._window.color == _SafeStr_5582));
        }
        public function set title(_arg_1:String):void
        {
            this._window.findChildByName(_SafeStr_10985).caption = _arg_1;
        }
        public function get title():String
        {
            return (((this._window) ? this._window.findChildByName(_SafeStr_10985).caption : null));
        }
        public function set message(_arg_1:String):void
        {
            this._window.findChildByName(_SafeStr_10986).caption = _arg_1;
        }
        public function get message():String
        {
            return (((this._window) ? this._window.findChildByName(_SafeStr_10986).caption : null));
        }
        public function set numberOfLikes(_arg_1:int):void
        {
            IWindowContainer(this._window.findChildByName(LIKE_REGION)).findChildByName(_SafeStr_10990).caption = String(_arg_1);
        }
        public function get numberOfLikes():int
        {
            return (((this._window) ? parseInt(IWindowContainer(this._window.findChildByName(LIKE_REGION)).findChildByName(_SafeStr_10990).caption) : 0));
        }
        public function set isLikable(_arg_1:Boolean):void
        {
            this.setIsLikable(_arg_1);
        }
        public function set isLikingEnabled(_arg_1:Boolean):void
        {
            if (this._window){
                this._window.findChildByName(LIKE_REGION).visible = _arg_1;
            };
        }
        public function set linkTarget(_arg_1:LinkTarget):void
        {
            this._linkTarget = _arg_1;
            var _local_2:IWindowContainer = IWindowContainer(this._window.findChildByName(LINK));
            if (this._linkTarget.type == LinkTarget.NONE){
                _local_2.visible = false;
            }
            else {
                _local_2.visible = true;
                _local_2.getChildByName(TEXT).caption = _arg_1.text;
            };
        }
        public function get linkTarget():LinkTarget
        {
            return (this._linkTarget);
        }
        public function set imageFilePath(_arg_1:String):void
        {
            var _local_2:IAsset;
            var _local_3:AssetLoaderStruct;
            if (_arg_1 != this._imageFilePath){
                this._imageFilePath = _arg_1;
                _local_2 = ASSETS.getAssetByName(_arg_1);
                if (_local_2){
                    this.image = (_local_2.content as BitmapData);
                }
                else {
                    _local_3 = ASSETS.loadAssetFromFile(_arg_1, new URLRequest(_arg_1));
                    _local_3.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.onImageFileLoaded);
                    _local_3.addEventListener(AssetLoaderEvent._SafeStr_4221, this.onImageFileLoaded);
                };
            };
        }
        public function set image(_arg_1:BitmapData):void
        {
            var _local_2:IBitmapWrapperWindow;
            var _local_3:int;
            var _local_4:int;
            if (((((!(this.disposed)) && (this._window))) && (_arg_1))){
                _local_2 = (this._window.findChildByName(_SafeStr_10988) as IBitmapWrapperWindow);
                _local_3 = (_local_2.x + (_local_2.width / 2));
                _local_4 = (_local_2.y + (_local_2.height / 2));
                _local_2.bitmap = _arg_1;
                _local_2.x = (_local_3 - (_arg_1.width / 2));
                _local_2.y = (_local_4 - (_arg_1.height / 2));
                _local_2.width = _arg_1.width;
                _local_2.height = _arg_1.height;
                this._imageFilePath = null;
            };
        }
        public function get window():IWindow
        {
            return (this._window);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get recycled():Boolean
        {
            return (this._recycled);
        }
        public function set minutesElapsed(_arg_1:int):void
        {
            this._minutesElapsed = _arg_1;
            var _local_2:String = _SafeStr_10995;
            if (this._minutesElapsed >= (24 * 60)){
                _local_2 = _SafeStr_10997;
                _arg_1 = (_arg_1 / (24 * 60));
            }
            else {
                if (this._minutesElapsed >= 60){
                    _local_2 = _SafeStr_10996;
                    _arg_1 = (_arg_1 / 60);
                };
            };
            var _local_3:ILocalization = _SafeStr_10962.getLocalization((("friendbar.stream." + _local_2) + ".ago"));
            this._window.findChildByName(_SafeStr_10987).caption = ((_local_3) ? _local_3.raw.replace("%value%", String(_arg_1)) : "...?");
        }
        public function get minutesElapsed():int
        {
            return (this._minutesElapsed);
        }
        public function recycle():void
        {
            if (!this._recycled){
                if (!this._disposed){
                    this._window.parent = null;
                    IBitmapWrapperWindow(this._window.findChildByName(_SafeStr_10988)).bitmap = null;
                    this.setIsLikable(false);
                    this._recycled = true;
                    _SafeStr_10984.push(this);
                };
            };
        }
        public function dispose():void
        {
            if (!this._disposed){
                this.setIsLikable(false);
                if (this._window){
                    this._window.findChildByName(LINK).removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onLinkClicked);
                    this._window.dispose();
                    this._window = null;
                };
                if (this._recycled){
                    _SafeStr_10984.splice(_SafeStr_10984.indexOf(this), 1);
                    this._recycled = false;
                };
                this._disposed = true;
            };
        }
        private function onLinkClicked(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IWindow;
            if (LinkResolver.open(this._linkTarget)){
                _local_2 = this._window.findChildByName(LINK);
                _local_2.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onLinkClicked);
                _local_2.visible = false;
            };
        }
        private function onLikeMouseEvent(_arg_1:WindowMouseEvent):void
        {
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                if (((_SafeStr_10964) && (!(_SafeStr_10964.disposed)))){
                    _SafeStr_10964.IHabboEventStream(this);
                };
            }
            else {
                if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER){
                    IWindowContainer(this._window.findChildByName(LIKE_REGION)).findChildByName(_SafeStr_10989).visible = true;
                }
                else {
                    if (_arg_1.type == WindowMouseEvent.WME_OUT){
                        IWindowContainer(this._window.findChildByName(LIKE_REGION)).findChildByName(_SafeStr_10989).visible = false;
                    };
                };
            };
        }
        private function setIsLikable(_arg_1:Boolean):void
        {
            var _local_2:IRegionWindow = (this._window.findChildByName(LIKE_REGION) as IRegionWindow);
            _local_2.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onLikeMouseEvent);
            _local_2.removeEventListener(WindowMouseEvent.WME_OUT, this.onLikeMouseEvent);
            _local_2.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onLikeMouseEvent);
            ITextWindow(_local_2.findChildByName(_SafeStr_10990)).underline = _arg_1;
            ITextWindow(_local_2.findChildByName(_SafeStr_10990)).textColor = ((_arg_1) ? _SafeStr_10992 : _SafeStr_10993);
            if (_arg_1){
                _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onLikeMouseEvent);
                _local_2.addEventListener(WindowMouseEvent.WME_OUT, this.onLikeMouseEvent);
                _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onLikeMouseEvent);
                _local_2.enable();
            }
            else {
                _local_2.disable();
            };
        }
        private function onImageFileLoaded(_arg_1:AssetLoaderEvent):void
        {
            var _local_2:AssetLoaderStruct;
            var _local_3:IAsset;
            if (_arg_1.type == AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE){
                _local_2 = (_arg_1.target as AssetLoaderStruct);
                if (_local_2.assetName == this._imageFilePath){
                    _local_3 = ASSETS.getAssetByName(this._imageFilePath);
                    if (_local_3){
                        this.image = (_local_3.content as BitmapData);
                    };
                };
            };
        }

    }
}//package com.sulake.habbo.friendbar.stream

// _imageFilePath = "_-1i6" (String#5712, DoABC#2)
// imageFilePath = "_-18y" (String#16814, DoABC#2)
// numberOfLikes = "_-aS" (String#23651, DoABC#2)
// isLikable = "_-0TJ" (String#15183, DoABC#2)
// IHabboEventStream = "_-1tw" (String#5918, DoABC#2)
// _SafeStr_10962 = "_-2hq" (String#20767, DoABC#2)
// ASSETS = "_-391" (String#21846, DoABC#2)
// _SafeStr_10964 = "_-0ri" (String#16110, DoABC#2)
// isLikingEnabled = "_-2HJ" (String#19696, DoABC#2)
// minutesElapsed = "_-2S-" (String#20118, DoABC#2)
// even = "_-1TK" (String#17638, DoABC#2)
// _SafeStr_10984 = "_-3FN" (String#22092, DoABC#2)
// _SafeStr_10985 = "_-0rO" (String#4672, DoABC#2)
// _SafeStr_10986 = "_-34f" (String#629, DoABC#2)
// _SafeStr_10987 = "_-1DH" (String#16995, DoABC#2)
// _SafeStr_10988 = "_-IE" (String#933, DoABC#2)
// _SafeStr_10989 = "_-GY" (String#22872, DoABC#2)
// _SafeStr_10990 = "_-1VU" (String#17720, DoABC#2)
// _SafeStr_10991 = "_-11S" (String#16515, DoABC#2)
// _SafeStr_10992 = "_-gJ" (String#23907, DoABC#2)
// _SafeStr_10993 = "_-rI" (String#24329, DoABC#2)
// _SafeStr_10994 = "_-0XI" (String#15326, DoABC#2)
// _SafeStr_10995 = "_-3LO" (String#22342, DoABC#2)
// _SafeStr_10996 = "_-12J" (String#16550, DoABC#2)
// _SafeStr_10997 = "_-19v" (String#16852, DoABC#2)
// _minutesElapsed = "_-26R" (String#19270, DoABC#2)
// onLinkClicked = "_-Pq" (String#23242, DoABC#2)
// setIsLikable = "_-8t" (String#22575, DoABC#2)
// onImageFileLoaded = "_-1wC" (String#18806, DoABC#2)
// recycled = "_-0Zq" (String#4294, DoABC#2)
// onLikeMouseEvent = "_-2nU" (String#20978, DoABC#2)
// ILocalization = "_-2EY" (String#1839, DoABC#2)
// IRegionWindow = "_-dg" (String#2146, DoABC#2)
// IHabboEventStream = "_-2Uk" (String#6661, DoABC#2)
// LinkResolver = "_-0WN" (String#4235, DoABC#2)
// LinkTarget = "_-1HG" (String#1650, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// _SafeStr_4221 = "_-0eh" (String#15613, DoABC#2)
// _SafeStr_5582 = "_-2ih" (String#1929, DoABC#2)
// _SafeStr_5583 = "_-2HF" (String#1846, DoABC#2)
// raw = "_-Xc" (String#8361, DoABC#2)
// AssetLoaderStruct = "_-0R2" (String#4112, DoABC#2)
// allocate = "_-08G" (String#14374, DoABC#2)
// _linkTarget = "_-8x" (String#7841, DoABC#2)
// _recycled = "_-2vB" (String#1963, DoABC#2)
// _SafeStr_9686 = "_-2XJ" (String#6707, DoABC#2)


