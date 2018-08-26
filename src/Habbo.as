
package 
{
    import flash.display.MovieClip;
    import flash.display.DisplayObjectContainer;
    import flash.text.TextField;
    import flash.utils.Timer;
    import flash.events.Event;
    import flash.external.ExternalInterface;
    import flash.net.URLRequest;
    import flash.net.URLVariables;
    import flash.system.Capabilities;
    import flash.system.System;
    import flash.net.URLRequestMethod;
    import flash.net.navigateToURL;
    import flash.display.StageScaleMode;
    import flash.display.StageQuality;
    import flash.display.StageAlign;
    import flash.events.ProgressEvent;
    import flash.events.HTTPStatusEvent;
    import flash.events.IOErrorEvent;
    import flash.events.TimerEvent;
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import flash.utils.getDefinitionByName;
    import flash.display.Bitmap;
    import flash.text.TextFormat;
    import flash.text.TextFieldAutoSize;
    import flash.display.Stage;

    public class Habbo extends MovieClip 
    {

        protected static var PROCESSLOG_ENABLED:Boolean = false;
        private static var _crashed:Boolean = false;
        private static var _crashURL:String = "";
        public static const _SafeStr_3402:String = "client.init.start";
        public static const _SafeStr_3403:String = "client.init.swf.error";
        public static const _SafeStr_3404:String = "client.init.swf.loaded";
        private static const _SafeStr_3405:String = "client.starting";
        public static const _SafeStr_3406:String = "client.init.core.init";
        public static const _SafeStr_3407:String = "client.init.core.fail";
        public static const _SafeStr_3408:String = "crash_time";
        public static const _SafeStr_3409:String = "error_ctx";
        public static const _SafeStr_3410:String = "flash_version";
        public static const _SafeStr_3411:String = "avg_update";
        public static const _SafeStr_3412:String = "debug";
        public static const _SafeStr_3413:String = "error_desc";
        public static const _SafeStr_3414:String = "error_cat";
        public static const ERROR_VARIABLE_DATA:String = "error_data";
        public static const _SafeStr_3415:int = 9;
        public static const _SafeStr_3416:int = 11;
        public static const _SafeStr_3417:String = "fileLoadingBar";
        public static const _SafeStr_3418:String = "fileBarSprite";
        public static const _SafeStr_3419:String = "byteLoadingBar";
        public static const _SafeStr_3420:String = "byteBarSprite";
        public static const _SafeStr_3421:String = "background";
        public static const _SafeStr_3422:String = "habboLogo";
        public static const _SafeStr_3423:String = "textField";

        private const _SafeStr_3424:Array = [[".", "..", "...", ""], [" [*    ]", " [ *   ]", " [  *  ]", " [   * ]", " [    *]", " [   * ]", " [  *  ]", " [ *   ]"], [".", "..", "....", "...", "..", ".", ""]];

        private var _disposed:Boolean = false;
        private var _SafeStr_3425:Boolean = false;
        private var _SafeStr_3426:DisplayObjectContainer;
        private var _SafeStr_3427:int = 0;
        private var _SafeStr_3428:String;
        private var _SafeStr_3429:TextField;
        private var _SafeStr_3430:Timer;
        private var habboLogoClass:Class;
        private var _SafeStr_3431:Array;
        private var _SafeStr_3432:int = 0;

        public function Habbo()
        {
            this.habboLogoClass = Habbo_habboLogoClass;
            super();
            stop();
            if (stage){
                this.onAddedToStage(null);
            }
            else {
                addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            };
        }
        public static function trackLoginStep(_arg_1:String):void
        {
            if (Habbo.PROCESSLOG_ENABLED){
                Logger.log(("* HabboMain Login Step: " + _arg_1));
                if (ExternalInterface.available){
                    ExternalInterface.call("FlashExternalInterface.logLoginStep", _arg_1);
                }
                else {
                    Logger.log("HabboMain: ExternalInterface is not available, tracking is disabled");
                };
            };
        }
        public static function reportCrash(_arg_1:String, _arg_2:int, _arg_3:Error):void
        {
            var _local_4:String;
            var _local_5:URLRequest;
            var _local_6:URLVariables;
            var _local_7:String;
            if (!Habbo._crashed){
                Habbo._crashed = true;
                _local_4 = Habbo._crashURL;
                _local_5 = new URLRequest(_local_4);
                _local_6 = new URLVariables();
                _local_6[_SafeStr_3408] = new Date().getTime().toString();
                _local_7 = "";
                _local_6[_SafeStr_3409] = _local_7;
                _local_6[_SafeStr_3410] = Capabilities.version;
                _local_6[_SafeStr_3411] = 0;
                _local_6[_SafeStr_3413] = _arg_1;
                _local_6[_SafeStr_3414] = String(_arg_2);
                if (_arg_3 != null){
                    _local_6[ERROR_VARIABLE_DATA] = String(_arg_3.getStackTrace());
                };
                _local_6[_SafeStr_3412] = (("Memory usage: " + Math.round((System.totalMemory / (0x0400 * 0x0400)))) + " MB");
                _local_5.data = _local_6;
                _local_5.method = URLRequestMethod.POST;
                navigateToURL(_local_5, "_self");
            };
        }

        private function onAddedToStage(_arg_1:Event):void
        {
            var _local_3:String;
            removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            Habbo.PROCESSLOG_ENABLED = (stage.loaderInfo.parameters["processlog.enabled"] == "1");
            trackLoginStep(_SafeStr_3402);
            var _local_2:String = stage.loaderInfo.parameters["client.fatal.error.url"];
            if (_local_2 != null){
                Habbo._crashURL = _local_2;
            }
            else {
                _local_3 = stage.loaderInfo.parameters["url.prefix"];
                if (_local_3 != null){
                    Habbo._crashURL = (_local_3 + "/flash_client_error");
                };
            };
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.quality = StageQuality.LOW;
            stage.align = StageAlign.TOP_LEFT;
            stage.addEventListener(Event.RESIZE, this.onResize);
            root.loaderInfo.addEventListener(ProgressEvent.PROGRESS, this.onPreLoadingProgress);
            root.loaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, this.onPreLoadingStatus);
            root.loaderInfo.addEventListener(Event.COMPLETE, this.onPreLoadingCompleted);
            root.loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onPreLoadingFailed);
            this._SafeStr_3431 = this._SafeStr_3424[int((Math.random() * (this._SafeStr_3424.length - 1)))];
            this._SafeStr_3430 = new Timer(250, 0);
            this._SafeStr_3430.addEventListener(TimerEvent.TIMER, this.onVisualizationUpdate);
            this._SafeStr_3426 = this.createLoadingScreen();
            addChild(this._SafeStr_3426);
            this.positionLoadingScreenDisplayElements(this._SafeStr_3426);
            addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            this.checkPreLoadingStatus();
        }
        private function dispose():void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            root.removeEventListener(Event.RESIZE, this.onResize);
            if (!this._disposed){
                this._disposed = true;
                if (this._SafeStr_3429){
                    this._SafeStr_3429 = null;
                };
                if (this._SafeStr_3426){
                    this.disposeLoadingScreen(this._SafeStr_3426);
                    removeChild(this._SafeStr_3426);
                    this._SafeStr_3426 = null;
                };
                if (parent){
                    parent.removeChild(this);
                };
            };
        }
        private function onPreLoadingProgress(_arg_1:Event):void
        {
            this.checkPreLoadingStatus();
            if (this._SafeStr_3426){
                this.updateLoadingBar(this._SafeStr_3426, (root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal));
            };
        }
        private function onPreLoadingStatus(_arg_1:HTTPStatusEvent):void
        {
            this._SafeStr_3427 = _arg_1.status;
        }
        private function onPreLoadingCompleted(event:Event):void
        {
            try {
                this.checkPreLoadingStatus();
            }
            catch(error:Error) {
                trackLoginStep(_SafeStr_3403);
                reportCrash(("Failed to finalize main swf preloading: " + error.message), _SafeStr_3415, error);
            };
        }
        private function onPreLoadingFailed(_arg_1:IOErrorEvent):void
        {
            trackLoginStep(_SafeStr_3403);
            reportCrash(((("Failed to finalize main swf preloading: " + _arg_1.text) + " / HTTP status: ") + this._SafeStr_3427), _SafeStr_3415, null);
        }
        private function checkPreLoadingStatus():void
        {
            if (!this._SafeStr_3425){
                if (root.loaderInfo.bytesLoaded == root.loaderInfo.bytesTotal){
                    this.finalizePreloading();
                };
            };
        }
        private function finalizePreloading():void
        {
            var _local_1:Class;
            var _local_2:Sprite;
            var _local_3:DisplayObject;
            if (!this._SafeStr_3425){
                this._SafeStr_3425 = true;
                trackLoginStep(_SafeStr_3404);
                if (this._SafeStr_3426){
                    _local_2 = (this._SafeStr_3426.getChildByName(_SafeStr_3419) as Sprite);
                    _local_2.visible = false;
                };
                root.loaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.onPreLoadingProgress);
                root.loaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, this.onPreLoadingStatus);
                root.loaderInfo.removeEventListener(Event.COMPLETE, this.onPreLoadingCompleted);
                root.loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onPreLoadingFailed);
                nextFrame();
                _local_1 = Class(getDefinitionByName("HabboMain"));
                if (_local_1){
                    _local_3 = (new (_local_1)(this._SafeStr_3426) as DisplayObject);
                    if (_local_3){
                        _local_3.addEventListener(Event.REMOVED, this.onMainRemoved);
                        addChild(_local_3);
                    };
                };
            };
        }
        private function onResize(_arg_1:Event):void
        {
            if (_arg_1.type == Event.RESIZE){
                if (this._SafeStr_3426){
                    this.positionLoadingScreenDisplayElements(this._SafeStr_3426);
                };
            };
        }
        private function onEnterFrame(_arg_1:Event):void
        {
            parent.setChildIndex(this, (parent.numChildren - 1));
        }
        private function onMainRemoved(_arg_1:Event):void
        {
            this.dispose();
        }
        private function onVisualizationUpdate(_arg_1:Event):void
        {
            if (this._SafeStr_3429){
                if (this._SafeStr_3432 >= this._SafeStr_3431.length){
                    this._SafeStr_3432 = 0;
                };
                this._SafeStr_3429.text = ((this._SafeStr_3428 + "") + this._SafeStr_3431[this._SafeStr_3432]);
                this._SafeStr_3432++;
            };
        }
        private function updateLoadingBar(_arg_1:DisplayObjectContainer, _arg_2:Number):void
        {
            var _local_11:int;
            var _local_12:int;
            var _local_3 = 200;
            var _local_4:int = 20;
            var _local_5:int = 1;
            var _local_6:int = 1;
            var _local_7:Sprite = (_arg_1.getChildByName(_SafeStr_3417) as Sprite);
            var _local_8:Sprite = (_local_7.getChildByName(_SafeStr_3418) as Sprite);
            var _local_9:Sprite = (_arg_1.getChildByName(_SafeStr_3419) as Sprite);
            var _local_10:Sprite = (_local_9.getChildByName(_SafeStr_3420) as Sprite);
            _local_8.x = (_local_5 + _local_6);
            _local_8.y = (_local_5 + _local_6);
            _local_8.graphics.clear();
            _local_11 = ((_local_4 - (_local_5 * 2)) - (_local_6 * 2));
            _local_12 = 0;
            _local_8.graphics.beginFill(12241619);
            _local_8.graphics.drawRect(0, 0, _local_12, (_local_11 / 2));
            _local_8.graphics.endFill();
            _local_8.graphics.beginFill(9216429);
            _local_8.graphics.drawRect(0, (_local_11 / 2), _local_12, ((_local_11 / 2) + 1));
            _local_8.graphics.endFill();
            _local_10.x = (_local_5 + _local_6);
            _local_10.y = (_local_5 + _local_6);
            _local_10.graphics.clear();
            _local_11 = ((_local_4 - (_local_5 * 2)) - (_local_6 * 2));
            _local_12 = (((_local_3 - (_local_5 * 2)) - (_local_6 * 2)) * _arg_2);
            _local_10.graphics.beginFill(0xFF0000);
            _local_10.graphics.drawRect(0, 0, _local_12, (_local_11 / 2));
            _local_10.graphics.endFill();
            _local_10.graphics.beginFill(0xB30000);
            _local_10.graphics.drawRect(0, (_local_11 / 2), _local_12, ((_local_11 / 2) + 1));
            _local_10.graphics.endFill();
        }
        public function createLoadingScreen():DisplayObjectContainer
        {
            var _local_5:Sprite;
            var _local_6:Sprite;
            var _local_1:Sprite = new Sprite();
            var _local_2:Sprite = new Sprite();
            _local_2.name = _SafeStr_3421;
            _local_2.graphics.clear();
            _local_2.graphics.beginFill(0xFF000000);
            _local_2.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
            _local_1.addChild(_local_2);
            var _local_3:Bitmap = (new this.habboLogoClass() as Bitmap);
            _local_3.name = _SafeStr_3422;
            _local_1.addChild(_local_3);
            this._SafeStr_3429 = new TextField();
            this._SafeStr_3429.name = _SafeStr_3423;
            if (stage.loaderInfo.parameters[_SafeStr_3405] != null){
                this._SafeStr_3428 = stage.loaderInfo.parameters[_SafeStr_3405];
            }
            else {
                this._SafeStr_3428 = _SafeStr_3405;
            };
            var _local_4:TextFormat = new TextFormat();
            _local_4.font = "Verdana";
            _local_4.color = 0xFF0000;
            _local_4.size = 9;
            this._SafeStr_3429.defaultTextFormat = _local_4;
            this._SafeStr_3429.text = this._SafeStr_3428;
            this._SafeStr_3429.autoSize = TextFieldAutoSize.LEFT;
            _local_1.addChild(this._SafeStr_3429);
            _local_5 = new Sprite();
            _local_5.name = _SafeStr_3417;
            _local_5.graphics.lineStyle(1, 0xFFFFFF);
            _local_5.graphics.beginFill(2500143);
            _local_5.graphics.drawRect(1, 0, (200 - 1), 0);
            _local_5.graphics.drawRect(200, 1, 0, (20 - 1));
            _local_5.graphics.drawRect(1, 20, (200 - 1), 0);
            _local_5.graphics.drawRect(0, 1, 0, (20 - 1));
            _local_5.graphics.endFill();
            _local_1.addChild(_local_5);
            _local_6 = new Sprite();
            _local_6.name = _SafeStr_3418;
            _local_5.addChild(_local_6);
            _local_5 = new Sprite();
            _local_5.name = _SafeStr_3419;
            _local_5.graphics.lineStyle(1, 0x888888);
            _local_5.graphics.beginFill(2500143);
            _local_5.graphics.drawRect(1, 0, (200 - 1), 0);
            _local_5.graphics.drawRect(200, 1, 0, (20 - 1));
            _local_5.graphics.drawRect(1, 20, (200 - 1), 0);
            _local_5.graphics.drawRect(0, 1, 0, (20 - 1));
            _local_5.graphics.endFill();
            _local_1.addChild(_local_5);
            _local_6 = new Sprite();
            _local_6.name = _SafeStr_3420;
            _local_5.addChild(_local_6);
            _local_5.visible = true;
            this.updateLoadingBar(_local_1, 0);
            this.positionLoadingScreenDisplayElements(_local_1);
            this._SafeStr_3430.start();
            return (_local_1);
        }
        public function disposeLoadingScreen(_arg_1:DisplayObjectContainer):void
        {
            var _local_2:DisplayObject;
            _local_2 = _arg_1.getChildByName(_SafeStr_3421);
            if (_local_2){
                _arg_1.removeChild(_local_2);
            };
            if (this._SafeStr_3429){
                _arg_1.removeChild(this._SafeStr_3429);
            };
            _local_2 = _arg_1.getChildByName(_SafeStr_3422);
            if (_local_2){
                _arg_1.removeChild(_local_2);
            };
            _local_2 = _arg_1.getChildByName(_SafeStr_3417);
            if (_local_2){
                _arg_1.removeChild(_local_2);
            };
            _local_2 = _arg_1.getChildByName(_SafeStr_3419);
            if (_local_2){
                _arg_1.removeChild(_local_2);
            };
            if (this._SafeStr_3430){
                this._SafeStr_3430.stop();
                this._SafeStr_3430 = null;
            };
        }
        private function positionLoadingScreenDisplayElements(_arg_1:DisplayObjectContainer):void
        {
            var _local_2:Stage = _arg_1.stage;
            var _local_3:Sprite = (_arg_1.getChildByName(_SafeStr_3421) as Sprite);
            if (_local_3){
                _local_3.x = 0;
                _local_3.y = 0;
                _local_3.graphics.clear();
                _local_3.graphics.beginFill(0xFF000000);
                _local_3.graphics.drawRect(0, 0, ((_local_2) ? _local_2.stageWidth : _arg_1.width), ((_local_2) ? _local_2.stageHeight : _arg_1.height));
            };
            var _local_4:Bitmap = (_arg_1.getChildByName(_SafeStr_3422) as Bitmap);
            if (_local_4){
                _local_4.x = 117;
                _local_4.y = 57;
            };
            var _local_5:TextField = (_arg_1.getChildByName(_SafeStr_3423) as TextField);
            if (_local_5){
                _local_5.x = (191 - (_local_5.width / 2));
                if (_local_4){
                    _local_5.y = (((_local_4.y + _local_4.height) + 28) - 10);
                };
            };
            var _local_6:Sprite = (_arg_1.getChildByName(_SafeStr_3417) as Sprite);
            if (_local_6){
                _local_6.x = 89;
                _local_6.y = 149;
            };
            var _local_7:Sprite = (_arg_1.getChildByName(_SafeStr_3419) as Sprite);
            if (_local_7){
                _local_7.x = 89;
                _local_7.y = 179;
            };
        }

    }
}//package 

// Habbo_habboLogoClass = "_-3LN" (String#6, DoABC#1)
// _SafeStr_3402 = "_-WM" (String#228, DoABC#1)
// _SafeStr_3403 = "_-9e" (String#224, DoABC#1)
// _SafeStr_3404 = "_-0Sf" (String#196, DoABC#1)
// _SafeStr_3405 = "_-2-g" (String#210, DoABC#1)
// _SafeStr_3406 = "_-fC" (String#232, DoABC#1)
// _SafeStr_3407 = "_-2Kn" (String#214, DoABC#1)
// _SafeStr_3408 = "_-0E6" (String#191, DoABC#1)
// _SafeStr_3409 = "_-JE" (String#226, DoABC#1)
// _SafeStr_3410 = "_-4L" (String#223, DoABC#1)
// _SafeStr_3411 = "_-12B" (String#201, DoABC#1)
// _SafeStr_3412 = "_-0ut" (String#198, DoABC#1)
// _SafeStr_3413 = "_-1pd" (String#209, DoABC#1)
// _SafeStr_3414 = "_-2vA" (String#218, DoABC#1)
// _SafeStr_3415 = "_-eU" (String#231, DoABC#1)
// _SafeStr_3416 = "_-Yw" (String#229, DoABC#1)
// _SafeStr_3417 = "_-2hE" (String#217, DoABC#1)
// _SafeStr_3418 = "_-0wz" (String#200, DoABC#1)
// _SafeStr_3419 = "_-2zj" (String#220, DoABC#1)
// _SafeStr_3420 = "_-1TT" (String#206, DoABC#1)
// _SafeStr_3421 = "_-0BR" (String#190, DoABC#1)
// _SafeStr_3422 = "_-2-w" (String#211, DoABC#1)
// _SafeStr_3423 = "_-0K4" (String#193, DoABC#1)
// _SafeStr_3424 = "_-0MT" (String#194, DoABC#1)
// _SafeStr_3425 = "_-3JQ" (String#222, DoABC#1)
// _SafeStr_3426 = "_-2GU" (String#213, DoABC#1)
// _SafeStr_3427 = "_-p2" (String#234, DoABC#1)
// _SafeStr_3428 = "_-0ve" (String#199, DoABC#1)
// _SafeStr_3429 = "_-1Ph" (String#205, DoABC#1)
// _SafeStr_3430 = "_-1Ox" (String#204, DoABC#1)
// _SafeStr_3431 = "_-0RL" (String#195, DoABC#1)
// _SafeStr_3432 = "_-aR" (String#230, DoABC#1)
// onAddedToStage = "_-0EB" (String#192, DoABC#1)
// trackLoginStep = "_-2T-" (String#216, DoABC#1)
// reportCrash = "_-lB" (String#233, DoABC#1)
// onResize = "_-0iX" (String#197, DoABC#1)
// onPreLoadingProgress = "_-K3" (String#227, DoABC#1)
// onPreLoadingStatus = "_-2wL" (String#219, DoABC#1)
// onPreLoadingCompleted = "_-02G" (String#188, DoABC#1)
// onPreLoadingFailed = "_-1Ou" (String#203, DoABC#1)
// onVisualizationUpdate = "_-1WQ" (String#207, DoABC#1)
// createLoadingScreen = "_-1B4" (String#202, DoABC#1)
// positionLoadingScreenDisplayElements = "_-yu" (String#236, DoABC#1)
// onEnterFrame = "_-20T" (String#212, DoABC#1)
// checkPreLoadingStatus = "_-375" (String#221, DoABC#1)
// disposeLoadingScreen = "_-2Ls" (String#215, DoABC#1)
// updateLoadingBar = "_-087" (String#189, DoABC#1)
// finalizePreloading = "_-1iQ" (String#208, DoABC#1)
// onMainRemoved = "_-t4" (String#235, DoABC#1)


