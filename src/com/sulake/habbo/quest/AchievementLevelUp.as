
package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.communication.messages.incoming.notifications.AchievementLevelUpData;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.filters.ColorMatrixFilter;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.outgoing.users.GetAchievementShareIdComposer;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.window.components.IBitmapWrapperWindow;

    public class AchievementLevelUp implements IDisposable 
    {

        private static const _SafeStr_12276:int = 2000;
        private static const _SafeStr_12296:int = 500;
        private static const _SafeStr_12297:int = 500;
        private static const _SafeStr_12298:int = 300;
        private static const _SafeStr_12299:int = 1400;
        private static const _SafeStr_12300:Number = 1;
        private static const _SafeStr_12301:int = 3;
        private static const _SafeStr_12302:int = 0;
        private static const _SafeStr_12303:int = 1;
        private static const _SafeStr_12304:int = 2;
        private static const _SafeStr_12305:int = 3;

        private var _window:IFrameWindow;
        private var _SafeStr_8017:HabboQuestEngine;
        private var _SafeStr_11485:AchievementLevelUpData;
        private var _SafeStr_12306:Array;
        private var _SafeStr_12307:int;
        private var _SafeStr_12308:int = 0;
        private var _SafeStr_12309:int;
        private var _SafeStr_12310:int;
        private var _SafeStr_12311:int;
        private var _SafeStr_12312:int = 3;
        private var _SafeStr_12313:BitmapData;
        private var _SafeStr_12314:Point;
        private var _SafeStr_12315:Array;
        private var _SafeStr_12316:ColorMatrixFilter;
        private var _SafeStr_12279:Animation;

        public function AchievementLevelUp(_arg_1:HabboQuestEngine)
        {
            this._SafeStr_12306 = new Array();
            this._SafeStr_12315 = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
            this._SafeStr_12316 = new ColorMatrixFilter(this._SafeStr_12315);
            super();
            this._SafeStr_8017 = _arg_1;
        }
        public function dispose():void
        {
            this._SafeStr_8017 = null;
            this._SafeStr_12306 = null;
            this._SafeStr_11485 = null;
            if (this._window){
                this._window.dispose();
                this._window = null;
            };
            if (this._SafeStr_12279){
                this._SafeStr_12279.dispose();
                this._SafeStr_12279 = null;
            };
        }
        public function get disposed():Boolean
        {
            return ((this._window == null));
        }
        public function AchievementLevelUp(_arg_1:AchievementLevelUpData):void
        {
            this._SafeStr_12306.push(_arg_1);
            this._SafeStr_8017.sessionDataManager.requestBadgeImage(_arg_1.badgeCode);
            this._SafeStr_8017.sessionDataManager.requestBadgeImage(this._SafeStr_8017.localization.getPreviousLevelBadgeId(_arg_1.badgeCode));
            if ((((this._window == null)) || (!(this._window.visible)))){
                this._SafeStr_12307 = _SafeStr_12276;
            };
            this.prepare();
        }
        private function close():void
        {
            if (this._window){
                this._window.visible = false;
                if (this._SafeStr_12306.length > 0){
                    this._SafeStr_12307 = _SafeStr_12296;
                };
            };
        }
        private function prepare():void
        {
            if (this._window != null){
                return;
            };
            this._window = IFrameWindow(this._SafeStr_8017.getXmlWindow("AchievementLevelUp"));
            this._window.findChildByTag("close").procedure = this.AchievementLevelUp;
            this._window.findChildByName("ok_button").procedure = this.AchievementLevelUp;
            this._window.findChildByName("share_button").procedure = this.AchievementLevelUp;
            new PendingImage(this._SafeStr_8017, this._window.findChildByName("reward_icon"), "ach_receive_star");
            this._window.findChildByName("achievements_link_region").procedure = this.AchievementLevelUp;
            this._window.findChildByName("close_link_region").procedure = this.AchievementLevelUp;
            this._SafeStr_12279 = this._SafeStr_8017.getTwinkleAnimation(this._window);
            this._window.visible = false;
        }
        private function show():void
        {
            this.prepare();
            this.registerParameter("achievements.levelup.title", "category", this._SafeStr_8017.getAchievementCategoryName(this._SafeStr_11485.category));
            this.registerParameter("achievements.levelup.reward", "amount", ("" + this._SafeStr_11485.levelRewardPoints));
            this.registerParameter("achievements.levelup.reward", "currency_name", this._SafeStr_8017.getActivityPointName(this._SafeStr_11485.levelRewardPointType));
            this.registerParameter("achievements.levelup.score", "amount", ("" + this._SafeStr_11485.points));
            this.registerParameter("achievements.levelup.sharedesc", "amount", ("" + this._SafeStr_11485.bonusPoints));
            this._window.findChildByName("achievement_name_txt").caption = (("'" + this._SafeStr_8017.localization.getBadgeName(this._SafeStr_11485.badgeCode)) + "'");
            var _local_1:Boolean = this.AchievementLevelUp();
            this._window.findChildByName("achievements_link_region").visible = !(_local_1);
            this._window.findChildByName("close_link_region").visible = _local_1;
            this._window.findChildByName("ok_button").visible = !(_local_1);
            this._window.findChildByName("share_button").visible = _local_1;
            this._window.findChildByName("facebook_info_txt").visible = _local_1;
            this.AchievementLevelUp();
            if (this._SafeStr_11485.level > 1){
                this.AchievementLevelUp(_SafeStr_12303);
            }
            else {
                this.AchievementLevelUp(_SafeStr_12304, _SafeStr_12299);
            };
            this._SafeStr_12279.Animation();
        }
        private function AchievementLevelUp(_arg_1:int, _arg_2:int=300):void
        {
            this._SafeStr_12313 = null;
            this._SafeStr_12308 = _arg_1;
            this._SafeStr_12310 = _arg_2;
            this._SafeStr_12309 = _arg_2;
            this._SafeStr_12311 = _SafeStr_12297;
        }
        private function AchievementLevelUp():Boolean
        {
            return ((((((this._SafeStr_11485.bonusPoints > 0)) && (this.AchievementLevelUp()))) && (this._SafeStr_8017.configuration.keyExists("facebook.user"))));
        }
        private function AchievementLevelUp():Boolean
        {
            return (!((this._SafeStr_8017.configuration.getKey("achievement.post.enabled", "1") == "0")));
        }
        private function AchievementLevelUp():void
        {
            var _local_1:Boolean = this._SafeStr_8017.configuration.keyExists("facebook.user");
            var _local_2:String = this._SafeStr_11485.badgeCode;
            if ((((this._SafeStr_11485.bonusPoints <= 0)) || (!(this.AchievementLevelUp())))){
                this._SafeStr_8017.send(new EventLogMessageComposer("Achievements", _local_2, "client.show.no_post"));
            }
            else {
                if (_local_1){
                    this._SafeStr_8017.send(new EventLogMessageComposer("Achievements", _local_2, "client.show.post"));
                }
                else {
                    this._SafeStr_8017.send(new EventLogMessageComposer("Achievements", _local_2, "client.show.no_fb"));
                };
            };
        }
        private function AchievementLevelUp(_arg_1:WindowEvent, _arg_2:IWindow=null):void
        {
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                this.close();
            };
        }
        private function AchievementLevelUp(_arg_1:WindowEvent, _arg_2:IWindow=null):void
        {
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                this.close();
            };
        }
        private function AchievementLevelUp(_arg_1:WindowEvent, _arg_2:IWindow=null):void
        {
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                this._SafeStr_8017.achievementController.show();
                this.close();
            };
        }
        private function AchievementLevelUp(_arg_1:WindowEvent, _arg_2:IWindow=null):void
        {
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                this._SafeStr_8017.send(new GetAchievementShareIdComposer(this._SafeStr_11485.achievementID));
                this._SafeStr_8017.send(new EventLogMessageComposer("Achievements", this._SafeStr_11485.badgeCode, "client.start_post"));
            };
        }
        public function update(_arg_1:uint):void
        {
            if (this._SafeStr_12307 > 0){
                this.AchievementLevelUp(_arg_1);
                return;
            };
            if (this._SafeStr_12279 != null){
                this._SafeStr_12279.update(_arg_1);
            };
            if ((((this._window == null)) || ((this._SafeStr_12308 == _SafeStr_12302)))){
                return;
            };
            switch (this._SafeStr_12308){
                case _SafeStr_12303:
                    this._SafeStr_12311 = (this._SafeStr_12311 - _arg_1);
                    this.AchievementLevelUp(true);
                    if (this._SafeStr_12311 < 0){
                        this.AchievementLevelUp(_SafeStr_12305);
                    };
                    return;
                case _SafeStr_12305:
                    this._SafeStr_12310 = (this._SafeStr_12310 - _arg_1);
                    this.AchievementLevelUp(true);
                    if (this._SafeStr_12310 < 0){
                        this.AchievementLevelUp(_SafeStr_12304);
                    };
                    return;
                case _SafeStr_12304:
                    this._SafeStr_12310 = (this._SafeStr_12310 - _arg_1);
                    this.AchievementLevelUp(false);
                    if (this._SafeStr_12310 < 0){
                        this.AchievementLevelUp(_SafeStr_12302);
                    };
                    return;
            };
        }
        private function AchievementLevelUp(_arg_1:uint):void
        {
            this._SafeStr_12307 = (this._SafeStr_12307 - _arg_1);
            if (this._SafeStr_12307 > 0){
                return;
            };
            if (this._SafeStr_12306.length < 1){
                return;
            };
            var _local_2:AchievementLevelUpData = this._SafeStr_12306.pop();
            if (((this._SafeStr_8017.sessionDataManager.SessionDataManager(_local_2.badgeCode).placeHolder) || (this._SafeStr_8017.sessionDataManager.SessionDataManager(this._SafeStr_8017.localization.getPreviousLevelBadgeId(_local_2.badgeCode)).placeHolder))){
                if (this._SafeStr_12312 > 0){
                    this._SafeStr_12306.push(_local_2);
                    this._SafeStr_12307 = _SafeStr_12276;
                    this._SafeStr_12312--;
                    return;
                };
                this._SafeStr_12312 = _SafeStr_12301;
            };
            this._SafeStr_11485 = _local_2;
            this.show();
            this._window.center();
            this._window.visible = true;
            this._window.activate();
        }
        public function AchievementLevelUp(_arg_1:String, _arg_2:String):void
        {
            if ((((((this._window == null)) || ((this._SafeStr_11485 == null)))) || (!((this._SafeStr_11485.badgeCode == _arg_1))))){
                Logger.log(((("Invalid facebook post: " + _arg_1) + ", ") + (((this._SafeStr_11485 == null)) ? "current is null" : this._SafeStr_11485.badgeCode)));
                return;
            };
            var _local_3:String = this.AchievementLevelUp("notifications.text.achievement_facebook");
            var _local_4:String = this.AchievementLevelUp("notifications.text.achievement_facebook_title");
            HabboWebTools.facebookAchievementPost(this._SafeStr_11485.badgeCode, _local_4, _local_3, _arg_2);
            this.close();
        }
        private function AchievementLevelUp(_arg_1:String):String
        {
            var _local_2:String = this._SafeStr_8017.sessionDataManager.userName;
            var _local_3:String = this._SafeStr_8017.sessionDataManager.realName;
            var _local_4:String = this._SafeStr_8017.localization.getAchievementNameForFacebook(this._SafeStr_11485.badgeCode, _local_2, _local_3, this._SafeStr_11485.level);
            var _local_5:String = this._SafeStr_8017.localization.getAchievementDescForFacebook(this._SafeStr_11485.badgeCode, _local_2, _local_3, this._SafeStr_11485.level);
            this.registerParameter(_arg_1, "badge_name", this._SafeStr_8017.localization.getBadgeName(this._SafeStr_11485.badgeCode));
            this.registerParameter(_arg_1, "badge_desc", this._SafeStr_8017.localization.getBadgeDesc(this._SafeStr_11485.badgeCode));
            this.registerParameter(_arg_1, "badge_name_fb", _local_4);
            this.registerParameter(_arg_1, "badge_desc_fb", _local_5);
            this.registerParameter(_arg_1, "level", this._SafeStr_11485.level.toString());
            this.registerParameter(_arg_1, "name", _local_2);
            this.registerParameter(_arg_1, "realname", _local_3);
            return (this._SafeStr_8017.localization.getKey(_arg_1, _arg_1));
        }
        private function registerParameter(_arg_1:String, _arg_2:String, _arg_3:String):void
        {
            this._SafeStr_8017.localization.registerParameter(_arg_1, _arg_2, _arg_3);
        }
        private function AchievementLevelUp(_arg_1:Boolean):void
        {
            this.AchievementLevelUp(_arg_1);
            var _local_2:IBitmapWrapperWindow = IBitmapWrapperWindow(this._window.findChildByName("achievement_pic_bitmap"));
            if (_local_2.bitmap == null){
                _local_2.bitmap = new BitmapData(_local_2.width, _local_2.height, true, 0);
            };
            if (this._SafeStr_12313 == null){
                this._SafeStr_12313 = ((_arg_1) ? this._SafeStr_8017.sessionDataManager.SessionDataManager(this._SafeStr_8017.localization.getPreviousLevelBadgeId(this._SafeStr_11485.badgeCode)) : this._SafeStr_8017.sessionDataManager.SessionDataManager(this._SafeStr_11485.badgeCode));
                this._SafeStr_12314 = new Point(((_local_2.width - this._SafeStr_12313.width) / 2), ((_local_2.height - this._SafeStr_12313.height) / 2));
            };
            _local_2.bitmap.fillRect(_local_2.bitmap.rect, 0);
            _local_2.bitmap.applyFilter(this._SafeStr_12313, this._SafeStr_12313.rect, this._SafeStr_12314, this._SafeStr_12316);
            _local_2.invalidate(_local_2.rectangle);
        }
        private function AchievementLevelUp(_arg_1:Boolean):void
        {
            var _local_2:int = Math.max(0, ((_arg_1) ? (this._SafeStr_12309 - this._SafeStr_12310) : this._SafeStr_12310));
            var _local_3:Number = ((_local_2 / this._SafeStr_12309) * _SafeStr_12300);
            this._SafeStr_12315[3] = _local_3;
            this._SafeStr_12315[8] = _local_3;
            this._SafeStr_12315[13] = _local_3;
            this._SafeStr_12315[0] = (1 - _local_3);
            this._SafeStr_12315[6] = (1 - _local_3);
            this._SafeStr_12315[12] = (1 - _local_3);
            this._SafeStr_12316.matrix = this._SafeStr_12315;
        }

    }
}//package com.sulake.habbo.quest

// keyExists = "_-2ME" (String#6487, DoABC#2)
// _SafeStr_11485 = "_-22W" (String#6098, DoABC#2)
// getAchievementDescForFacebook = "_-37y" (String#7469, DoABC#2)
// getAchievementNameForFacebook = "_-1o6" (String#5818, DoABC#2)
// getPreviousLevelBadgeId = "_-2Kq" (String#6459, DoABC#2)
// AchievementLevelUp = "_-2UY" (String#6656, DoABC#2)
// achievementController = "_-0e" (String#15584, DoABC#2)
// AchievementLevelUp = "_-VO" (String#23466, DoABC#2)
// Animation = "_-3BQ" (String#21939, DoABC#2)
// getAchievementCategoryName = "_-3EV" (String#22055, DoABC#2)
// SessionDataManager = "_-0SD" (String#4143, DoABC#2)
// _SafeStr_12276 = "_-2t1" (String#7138, DoABC#2)
// _SafeStr_12279 = "_-2fE" (String#6856, DoABC#2)
// getTwinkleAnimation = "_-0MD" (String#14924, DoABC#2)
// _SafeStr_12296 = "_-0Tn" (String#15199, DoABC#2)
// _SafeStr_12297 = "_-3AJ" (String#21895, DoABC#2)
// _SafeStr_12298 = "_-3-x" (String#21498, DoABC#2)
// _SafeStr_12299 = "_-0vZ" (String#16259, DoABC#2)
// _SafeStr_12300 = "_-10G" (String#16474, DoABC#2)
// _SafeStr_12301 = "_-2sy" (String#21198, DoABC#2)
// _SafeStr_12302 = "_-0mz" (String#15937, DoABC#2)
// _SafeStr_12303 = "_-3Ie" (String#22224, DoABC#2)
// _SafeStr_12304 = "_-0I0" (String#14758, DoABC#2)
// _SafeStr_12305 = "_-1tR" (String#18695, DoABC#2)
// _SafeStr_12306 = "_-04T" (String#14222, DoABC#2)
// _SafeStr_12307 = "_-2Lq" (String#19877, DoABC#2)
// _SafeStr_12308 = "_-2ax" (String#20484, DoABC#2)
// _SafeStr_12309 = "_-2uH" (String#21250, DoABC#2)
// _SafeStr_12310 = "_-34a" (String#21681, DoABC#2)
// _SafeStr_12311 = "_-3DQ" (String#22012, DoABC#2)
// _SafeStr_12312 = "_-4V" (String#22397, DoABC#2)
// _SafeStr_12313 = "_-NZ" (String#23148, DoABC#2)
// _SafeStr_12314 = "_-200" (String#19011, DoABC#2)
// _SafeStr_12315 = "_-3-f" (String#21487, DoABC#2)
// _SafeStr_12316 = "_-0vs" (String#16268, DoABC#2)
// AchievementLevelUp = "_-1XO" (String#17792, DoABC#2)
// AchievementLevelUp = "_-hx" (String#23962, DoABC#2)
// AchievementLevelUp = "_-2ym" (String#21420, DoABC#2)
// AchievementLevelUp = "_-18u" (String#16810, DoABC#2)
// getActivityPointName = "_-wi" (String#24559, DoABC#2)
// AchievementLevelUp = "_-2fz" (String#20691, DoABC#2)
// AchievementLevelUp = "_-ru" (String#24358, DoABC#2)
// AchievementLevelUp = "_-Mp" (String#23119, DoABC#2)
// AchievementLevelUp = "_-2jO" (String#20820, DoABC#2)
// AchievementLevelUp = "_-1lJ" (String#18343, DoABC#2)
// AchievementLevelUp = "_-ah" (String#23660, DoABC#2)
// AchievementLevelUp = "_-NO" (String#23140, DoABC#2)
// AchievementLevelUp = "_-2QM" (String#20060, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// HabboWebTools = "_-2pX" (String#21059, DoABC#2)
// Animation = "_-2Eu" (String#1841, DoABC#2)
// AchievementLevelUpData = "_-1h6" (String#5687, DoABC#2)
// GetAchievementShareIdComposer = "_-1iv" (String#5732, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// realName = "_-3HH" (String#922, DoABC#2)
// facebookAchievementPost = "_-I1" (String#22930, DoABC#2)
// sessionDataManager = "_-0pX" (String#4623, DoABC#2)
// bonusPoints = "_-0xr" (String#16347, DoABC#2)
// levelRewardPoints = "_-315" (String#21541, DoABC#2)
// levelRewardPointType = "_-0M3" (String#14917, DoABC#2)
// badgeCode = "_-2XO" (String#20338, DoABC#2)
// achievementID = "_-2B4" (String#19447, DoABC#2)
// SessionDataManager = "_-3DK" (String#7581, DoABC#2)
// _SafeStr_8017 = "_-1jf" (String#150, DoABC#2)
// EventLogMessageComposer = "_-2lH" (String#6984, DoABC#2)


