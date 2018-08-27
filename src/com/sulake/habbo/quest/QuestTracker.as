
package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import flash.geom.Point;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.outgoing.quest.StartCampaignMessageComposer;
    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.core.window.components.IFrameWindow;

    public class QuestTracker implements IDisposable 
    {

        private static const _SafeStr_12379:int = 0;
        private static const _SafeStr_12380:int = 1;
        private static const _SafeStr_12381:int = 2;
        private static const _SafeStr_12382:int = 3;
        private static const _SafeStr_12383:int = 4;
        private static const _SafeStr_12384:int = 5;
        private static const _SafeStr_12385:int = 6;
        private static const _SafeStr_12386:Array = [-2, -3, -2, 0, 2, 3, 2, 0, 2, 1, 0, 1];
        private static const _SafeStr_12387:Array = [1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 4];
        private static const _SafeStr_12388:int = 6;
        private static const _SafeStr_12389:int = 4;
        private static const _SafeStr_12390:int = 2;
        private static const _SafeStr_12391:int = 200;
        private static const _SafeStr_12392:Array = ["a", "b", "c", "d"];
        private static const _SafeStr_12393:int = 10000;
        private static const _SafeStr_12394:int = 0;
        private static const _SafeStr_12395:int = -1;
        private static const _SafeStr_12396:Point = new Point(10, 87);
        private static const _SafeStr_12397:int = 162;
        private static const _SafeStr_12398:Number = 0.01;
        private static const _SafeStr_12399:Number = 100;
        private static const _SafeStr_12400:int = 1000;
        private static const _SafeStr_12093:String = "quest_tracker";
        private static const _SafeStr_12401:int = 10;

        private var _SafeStr_8017:HabboQuestEngine;
        private var _SafeStr_12402:QuestMessageData;
        private var _window:IWindowContainer;
        private var _SafeStr_12403:Timer;
        private var _SafeStr_12404:ProgressBar;
        private var _SafeStr_12405:int = 0;
        private var _SafeStr_12406:int = 0;
        private var _SafeStr_12407:int = 0;
        private var _SafeStr_12408:int = -1;
        private var _SafeStr_12409:int = -1;
        private var _SafeStr_12410:int = -1;
        private var _SafeStr_12411:int;
        private var _SafeStr_12412:int;
        private var _SafeStr_12413:Boolean;

        public function QuestTracker(_arg_1:HabboQuestEngine)
        {
            this._SafeStr_8017 = _arg_1;
        }
        public function dispose():void
        {
            if (this._SafeStr_8017){
                this._SafeStr_8017.toolbar.extensionView.detachExtension(_SafeStr_12093);
            };
            this._SafeStr_8017 = null;
            this._SafeStr_12402 = null;
            if (this._window){
                this._window.dispose();
                this._window = null;
            };
            if (this._SafeStr_12403){
                this._SafeStr_12403.stop();
                this._SafeStr_12403 = null;
            };
            if (this._SafeStr_12404){
                this._SafeStr_12404.dispose();
                this._SafeStr_12404 = null;
            };
        }
        public function get disposed():Boolean
        {
            return ((this._SafeStr_8017 == null));
        }
        public function onQuestCompleted(_arg_1:QuestMessageData):void
        {
            if (this._window){
                this.clearPrompt();
                this._SafeStr_12402 = _arg_1;
                this._SafeStr_12406 = 0;
                this.refreshTrackerDetails();
                this._SafeStr_12408 = 0;
                this._SafeStr_12405 = _SafeStr_12382;
            };
        }
        public function onQuestCancelled():void
        {
            this._SafeStr_12402 = null;
            if (this._window){
                this.clearPrompt();
                this._SafeStr_12404.refresh(0, 100, -1);
                this._SafeStr_12405 = _SafeStr_12381;
            };
        }
        public function onRoomEnter():void
        {
            var _local_3:int;
            var _local_1:Boolean = Boolean(parseInt(this._SafeStr_8017.configuration.getKey("new.identity", "0")));
            var _local_2:String = this.getDefaultCampaign();
            if ((((((this._SafeStr_12403 == null)) && (_local_1))) && (!((_local_2 == ""))))){
                _local_3 = int(this._SafeStr_8017.configuration.getKey("questing.startQuestDelayInSeconds", "30"));
                this._SafeStr_12403 = new Timer((_local_3 * 1000), 1);
                this._SafeStr_12403.addEventListener(TimerEvent.TIMER, this.onStartQuestTimer);
                this._SafeStr_12403.start();
                Logger.log(("Initialized start quest timer with period: " + _local_3));
            };
        }
        public function onRoomExit():void
        {
            if (((!((this._window == null))) && (this._window.visible))){
                this._window.findChildByName("more_info_txt").visible = false;
                this._window.findChildByName("more_info_region").visible = false;
            };
        }
        public function onQuest(_arg_1:QuestMessageData):void
        {
            var _local_2:Boolean = ((this._window) && (this._window.visible));
            if (_arg_1.waitPeriodSeconds > 0){
                if (_local_2){
                    this.setWindowVisible(false);
                };
                return;
            };
            this._SafeStr_12402 = _arg_1;
            this.prepareTrackerWindow();
            this.refreshTrackerDetails();
            this.refreshPromptFrames();
            this.setWindowVisible(true);
            this.hideSuccessFrames();
            if (_local_2){
                if (this._SafeStr_12405 == _SafeStr_12381){
                    this._SafeStr_12405 = _SafeStr_12380;
                };
                this.setupPrompt(this._SafeStr_12409, _SafeStr_12389, false);
            }
            else {
                this._window.x = this.getOutScreenLocationX();
                this._SafeStr_12405 = _SafeStr_12380;
                this.setupPrompt(_SafeStr_12394, _SafeStr_12390, false);
            };
        }
        private function refreshPromptFrames():void
        {
            if (!this._SafeStr_8017.isQuestWithPrompts(this._SafeStr_12402)){
                return;
            };
            var _local_1:int;
            while (_local_1 < _SafeStr_12392.length) {
                this._SafeStr_8017.setupPromptFrameImage(this._window, this._SafeStr_12402, _SafeStr_12392[_local_1]);
                _local_1++;
            };
        }
        private function prepareTrackerWindow():void
        {
            if (this._window != null){
                return;
            };
            this._window = IWindowContainer(this._SafeStr_8017.getXmlWindow("QuestTracker"));
            this._window.findChildByName("more_info_region").procedure = this.onMoreInfo;
            new PendingImage(this._SafeStr_8017, this._window.findChildByName("quest_tracker_bg"), "quest_tracker_with_bar");
            var _local_1:int = 1;
            while (_local_1 <= _SafeStr_12388) {
                new PendingImage(this._SafeStr_8017, this.getSuccessFrame(_local_1), ("checkanim" + _local_1));
                _local_1++;
            };
            this.hideSuccessFrames();
            this._SafeStr_12404 = new ProgressBar(this._SafeStr_8017, IWindowContainer(this._window.findChildByName("content_cont")), _SafeStr_12397, "quests.tracker.progress", false, _SafeStr_12396);
        }
        private function hideSuccessFrames():void
        {
            var _local_1:int = 1;
            while (_local_1 <= _SafeStr_12388) {
                this.getSuccessFrame(_local_1).visible = false;
                _local_1++;
            };
        }
        private function hidePromptFrames():void
        {
            var _local_1:int;
            while (_local_1 < _SafeStr_12392.length) {
                this.getPromptFrame(_SafeStr_12392[_local_1]).visible = false;
                _local_1++;
            };
        }
        private function getSuccessFrame(_arg_1:int):IBitmapWrapperWindow
        {
            return (IBitmapWrapperWindow(this._window.findChildByName(("success_pic_" + _arg_1))));
        }
        private function getPromptFrame(_arg_1:String):IBitmapWrapperWindow
        {
            return (IBitmapWrapperWindow(this._window.findChildByName(("prompt_pic_" + _arg_1))));
        }
        private function refreshTrackerDetails():void
        {
            this._SafeStr_8017.localization.registerParameter("quests.tracker.caption", "quest_name", this._SafeStr_8017.getQuestName(this._SafeStr_12402));
            this._window.findChildByName("desc_txt").caption = this._SafeStr_8017.getQuestDesc(this._SafeStr_12402);
            this._window.findChildByName("more_info_txt").visible = this._SafeStr_8017.currentlyInRoom;
            this._window.findChildByName("more_info_region").visible = this._SafeStr_8017.currentlyInRoom;
            var _local_1:int = Math.round(((100 * this._SafeStr_12402.completedSteps) / this._SafeStr_12402.totalSteps));
            this._SafeStr_12404.refresh(_local_1, 100, this._SafeStr_12402.id);
            this._SafeStr_8017.setupQuestImage(this._window, this._SafeStr_12402);
        }
        private function onMoreInfo(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                this._SafeStr_8017.questController.questDetails.showDetails(this._SafeStr_12402);
            };
        }
        public function update(_arg_1:uint):void
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            if (this._window == null){
                return;
            };
            this._SafeStr_12404.updateView();
            switch (this._SafeStr_12405){
                case _SafeStr_12380:
                    _local_2 = this.getDefaultLocationX();
                    _local_3 = (this._window.x - _local_2);
                    if (_local_3 > 0){
                        _local_4 = Math.max(1, Math.round(((_local_3 * _arg_1) * _SafeStr_12398)));
                        this._window.x = (this._window.x - _local_4);
                    }
                    else {
                        this._SafeStr_12405 = _SafeStr_12379;
                        this._window.x = _local_2;
                    };
                    return;
                case _SafeStr_12381:
                    _local_2 = this.getOutScreenLocationX();
                    _local_3 = (this._window.width - this._window.x);
                    if (_local_3 > 0){
                        _local_4 = Math.max(1, Math.round(((_arg_1 * _SafeStr_12399) / _local_3)));
                        this._window.x = (this._window.x + _local_4);
                    }
                    else {
                        this._SafeStr_12405 = _SafeStr_12379;
                        this._window.x = _local_2;
                        this.setWindowVisible(false);
                    };
                    return;
                case _SafeStr_12382:
                    this.hideSuccessFrames();
                    this.getSuccessFrame(_SafeStr_12387[this._SafeStr_12408]).visible = true;
                    this._SafeStr_12408++;
                    if (this._SafeStr_12408 >= _SafeStr_12387.length){
                        this._SafeStr_12405 = _SafeStr_12384;
                        this._SafeStr_12407 = _SafeStr_12400;
                    };
                    return;
                case _SafeStr_12385:
                    this.setQuestImageVisible(false);
                    this.hidePromptFrames();
                    this._SafeStr_12411 = (this._SafeStr_12411 - _arg_1);
                    this.getPromptFrame(_SafeStr_12392[this._SafeStr_12410]).visible = true;
                    if (this._SafeStr_12411 < 0){
                        this._SafeStr_12411 = _SafeStr_12391;
                        this._SafeStr_12410++;
                        if (this._SafeStr_12410 >= _SafeStr_12392.length){
                            this._SafeStr_12410 = 0;
                            this._SafeStr_12412--;
                            if (this._SafeStr_12412 < 1){
                                this.setupPrompt(_SafeStr_12393, _SafeStr_12390, true);
                                this._SafeStr_12405 = _SafeStr_12379;
                            };
                        };
                    };
                    return;
                case _SafeStr_12383:
                    if (this._SafeStr_12406 >= (_SafeStr_12386.length - 1)){
                        this._window.x = this.getDefaultLocationX();
                        this._SafeStr_12405 = _SafeStr_12379;
                        this.setupPrompt(_SafeStr_12393, _SafeStr_12390, false);
                    }
                    else {
                        this._window.x = (this.getDefaultLocationX() + _SafeStr_12386[this._SafeStr_12406]);
                        this._SafeStr_12406++;
                    };
                    return;
                case _SafeStr_12384:
                    this._SafeStr_12407 = (this._SafeStr_12407 - _arg_1);
                    if (this._SafeStr_12407 < 0){
                        this._SafeStr_12405 = _SafeStr_12379;
                        this.setWindowVisible(false);
                    };
                    return;
                case _SafeStr_12379:
                    if (this._SafeStr_12409 != _SafeStr_12395){
                        this._SafeStr_12409 = (this._SafeStr_12409 - _arg_1);
                        if (this._SafeStr_12409 < 0){
                            this._SafeStr_12409 = _SafeStr_12395;
                            if (((!((this._SafeStr_12402 == null))) && (this._SafeStr_8017.isQuestWithPrompts(this._SafeStr_12402)))){
                                if (this._SafeStr_12413){
                                    this.startNudge();
                                }
                                else {
                                    this._SafeStr_12405 = _SafeStr_12385;
                                    this._SafeStr_12410 = 0;
                                    this._SafeStr_12411 = _SafeStr_12391;
                                };
                            };
                        };
                    };
                    return;
            };
        }
        private function getDefaultLocationX():int
        {
            return (0);
        }
        private function getOutScreenLocationX():int
        {
            return ((this._window.width + _SafeStr_12401));
        }
        public function isVisible():Boolean
        {
            return (((this._window) && (this._window.visible)));
        }
        private function onStartQuestTimer(_arg_1:TimerEvent):void
        {
            if (this.hasBlockingWindow()){
                Logger.log("Quest start blocked. Waiting some more");
                this._SafeStr_12403.reset();
                this._SafeStr_12403.start();
            }
            else {
                this._SafeStr_8017.questController.questDetails.openForNextQuest = (this._SafeStr_8017.configuration.getKey("questing.showDetailsForNextQuest") == "true");
                this._SafeStr_8017.send(new StartCampaignMessageComposer(this.getDefaultCampaign(), this._SafeStr_8017.configuration.getBoolean("questing.useWing", false)));
            };
        }
        private function getDefaultCampaign():String
        {
            var _local_1:String = this._SafeStr_8017.configuration.getKey("questing.defaultCampaign");
            return ((((_local_1 == null)) ? "" : _local_1));
        }
        private function hasBlockingWindow():Boolean
        {
            var _local_2:IDesktopWindow;
            var _local_1:int;
            while (_local_1 <= 2) {
                _local_2 = this._SafeStr_8017.windowManager.getDesktop(_local_1);
                if (((!((_local_2 == null))) && (this.hasBlockingWindowInLayer(_local_2)))){
                    return (true);
                };
                _local_1++;
            };
            return (false);
        }
        private function hasBlockingWindowInLayer(_arg_1:IWindowContainer):Boolean
        {
            var _local_2:int;
            var _local_3:IWindow;
            while (_local_2 < _arg_1.numChildren) {
                _local_3 = _arg_1.getChildAt(_local_2);
                if (((!((_local_3 == null))) && (_local_3.visible))){
                    if ((_local_3 as IFrameWindow) != null){
                        if (_local_3.name != "mod_start_panel"){
                            return (true);
                        };
                    }
                    else {
                        if (_local_3.name == "welcome_screen"){
                            return (true);
                        };
                    };
                };
                _local_2++;
            };
            return (false);
        }
        private function setQuestImageVisible(_arg_1:Boolean):void
        {
            this._window.findChildByName("quest_pic_bitmap").visible = _arg_1;
        }
        private function clearPrompt():void
        {
            this.setupPrompt(_SafeStr_12395, 0, false);
        }
        private function setupPrompt(_arg_1:int, _arg_2:int, _arg_3:Boolean):void
        {
            this.setQuestImageVisible(true);
            this.hidePromptFrames();
            this._SafeStr_12409 = _arg_1;
            this._SafeStr_12412 = _arg_2;
            this._SafeStr_12413 = _arg_3;
        }
        private function startNudge():void
        {
            this._SafeStr_12406 = 0;
            this._SafeStr_12405 = _SafeStr_12383;
        }
        private function setWindowVisible(_arg_1:Boolean):void
        {
            this._window.visible = _arg_1;
            if (!_arg_1){
                this._SafeStr_8017.toolbar.extensionView.detachExtension(_SafeStr_12093);
            }
            else {
                this._SafeStr_8017.toolbar.extensionView.attachExtension(_SafeStr_12093, this._window);
            };
        }

    }
}//package com.sulake.habbo.quest

// _SafeStr_12093 = "_-0fy" (String#1523, DoABC#2)
// onQuestCompleted = "_-2Ht" (String#6400, DoABC#2)
// onQuestCancelled = "_-0wk" (String#4785, DoABC#2)
// onQuest = "_-kW" (String#8614, DoABC#2)
// questController = "_-1Hq" (String#17186, DoABC#2)
// currentlyInRoom = "_-15i" (String#16684, DoABC#2)
// questDetails = "_-2H-" (String#19684, DoABC#2)
// getQuestDesc = "_-0-A" (String#14017, DoABC#2)
// setupQuestImage = "_-1a5" (String#17898, DoABC#2)
// openForNextQuest = "_-UH" (String#23420, DoABC#2)
// getQuestName = "_-0yL" (String#16365, DoABC#2)
// isQuestWithPrompts = "_-1FF" (String#17082, DoABC#2)
// setupPromptFrameImage = "_-1n5" (String#18427, DoABC#2)
// onMoreInfo = "_-Ll" (String#8119, DoABC#2)
// getDefaultLocationX = "_-2Bs" (String#6283, DoABC#2)
// setQuestImageVisible = "_-1YC" (String#5523, DoABC#2)
// _SafeStr_12379 = "_-19w" (String#16853, DoABC#2)
// _SafeStr_12380 = "_-1Mm" (String#17390, DoABC#2)
// _SafeStr_12381 = "_-31" (String#21538, DoABC#2)
// _SafeStr_12382 = "_-wq" (String#24562, DoABC#2)
// _SafeStr_12383 = "_-0FR" (String#14663, DoABC#2)
// _SafeStr_12384 = "_-2yR" (String#21408, DoABC#2)
// _SafeStr_12385 = "_-29y" (String#19404, DoABC#2)
// _SafeStr_12386 = "_-1WM" (String#17756, DoABC#2)
// _SafeStr_12387 = "_-3Ex" (String#22074, DoABC#2)
// _SafeStr_12388 = "_-Pc" (String#23232, DoABC#2)
// _SafeStr_12389 = "_-e2" (String#23804, DoABC#2)
// _SafeStr_12390 = "_-1pO" (String#18519, DoABC#2)
// _SafeStr_12391 = "_-0h9" (String#15716, DoABC#2)
// _SafeStr_12392 = "_-02e" (String#14147, DoABC#2)
// _SafeStr_12393 = "_-1ZZ" (String#17872, DoABC#2)
// _SafeStr_12394 = "_-3CA" (String#21968, DoABC#2)
// _SafeStr_12395 = "_-7N" (String#22516, DoABC#2)
// _SafeStr_12396 = "_-0JB" (String#14808, DoABC#2)
// _SafeStr_12397 = "_-2Qk" (String#20076, DoABC#2)
// _SafeStr_12398 = "_-0pV" (String#16036, DoABC#2)
// _SafeStr_12399 = "_-AH" (String#22628, DoABC#2)
// _SafeStr_12400 = "_-lU" (String#24089, DoABC#2)
// _SafeStr_12401 = "_-KG" (String#23015, DoABC#2)
// _SafeStr_12402 = "_-2OX" (String#19987, DoABC#2)
// _SafeStr_12403 = "_-up" (String#24483, DoABC#2)
// _SafeStr_12404 = "_-0p5" (String#16019, DoABC#2)
// _SafeStr_12405 = "_-00V" (String#14074, DoABC#2)
// _SafeStr_12406 = "_-14M" (String#16630, DoABC#2)
// _SafeStr_12407 = "_-16R" (String#16715, DoABC#2)
// _SafeStr_12408 = "_-0nW" (String#15957, DoABC#2)
// _SafeStr_12409 = "_-3BU" (String#21942, DoABC#2)
// _SafeStr_12410 = "_-Gx" (String#22889, DoABC#2)
// _SafeStr_12411 = "_-1ku" (String#18327, DoABC#2)
// _SafeStr_12412 = "_-20x" (String#19050, DoABC#2)
// _SafeStr_12413 = "_-0nc" (String#15961, DoABC#2)
// clearPrompt = "_-Nf" (String#23152, DoABC#2)
// refreshTrackerDetails = "_-Wx" (String#23521, DoABC#2)
// getDefaultCampaign = "_-uk" (String#24480, DoABC#2)
// onStartQuestTimer = "_-3Ju" (String#22280, DoABC#2)
// setWindowVisible = "_-0pB" (String#16023, DoABC#2)
// prepareTrackerWindow = "_-3Bx" (String#21957, DoABC#2)
// refreshPromptFrames = "_-0QC" (String#15071, DoABC#2)
// hideSuccessFrames = "_-2FQ" (String#19620, DoABC#2)
// setupPrompt = "_-067" (String#14287, DoABC#2)
// getOutScreenLocationX = "_-2VJ" (String#20253, DoABC#2)
// getSuccessFrame = "_-27k" (String#19320, DoABC#2)
// hidePromptFrames = "_-2tL" (String#21214, DoABC#2)
// getPromptFrame = "_-OT" (String#23187, DoABC#2)
// startNudge = "_-0Jr" (String#14836, DoABC#2)
// hasBlockingWindow = "_-2DM" (String#19541, DoABC#2)
// hasBlockingWindowInLayer = "_-1vX" (String#18779, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// QuestMessageData = "_-2Vr" (String#20275, DoABC#2)
// StartCampaignMessageComposer = "_-2Vv" (String#20278, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// showDetails = "_-3H6" (String#7649, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// extensionView = "_-qR" (String#8717, DoABC#2)
// detachExtension = "_-gb" (String#8524, DoABC#2)
// attachExtension = "_-01F" (String#3587, DoABC#2)
// updateView = "_-1Js" (String#847, DoABC#2)
// isVisible = "_-1rE" (String#18592, DoABC#2)
// _SafeStr_8017 = "_-1jf" (String#150, DoABC#2)
// completedSteps = "_-fZ" (String#23868, DoABC#2)
// totalSteps = "_-1aT" (String#17912, DoABC#2)
// waitPeriodSeconds = "_-376" (String#21771, DoABC#2)
// onRoomEnter = "_-El" (String#460, DoABC#2)
// onRoomExit = "_-0Na" (String#356, DoABC#2)


