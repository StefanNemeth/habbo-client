
package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.IUpdateReceiver;
    import flash.geom.Point;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementData;
    import flash.utils.Timer;
    import flash.utils.Dictionary;
    import flash.geom.Matrix;
    import flash.filters.ColorMatrixFilter;
    import flash.events.TimerEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.outgoing.inventory.achievements.GetAchievementsComposer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.habbo.session.BadgeInfo;
    import com.sulake.habbo.session.events.BadgeImageReadyEvent;

    public class AchievementController implements IDisposable, IUpdateReceiver 
    {

        private static const _SafeStr_12193:int = 3;
        private static const _SafeStr_12194:int = 8;
        private static const _SafeStr_12195:int = 5;
        private static const _SafeStr_12196:int = 6;
        private static const _SafeStr_12197:int = 3;
        private static const _SafeStr_12198:int = 2;
        private static const _SafeStr_12199:int = 6;
        private static const _SafeStr_12200:int = 180;
        private static const _SafeStr_12201:int = 246;
        private static const _SafeStr_12202:int = 45;
        private static const _SafeStr_12203:Point = new Point(115, 93);
        private static const _SafeStr_12204:Point = new Point(72, 1);
        private static const _SafeStr_12205:int = 40;
        private static const _SafeStr_12206:int = 20;
        private static const _SafeStr_12207:int = 3;
        private static const _SafeStr_12208:int = 10;

        private var _SafeStr_8017:HabboQuestEngine;
        private var _window:IFrameWindow;
        private var _SafeStr_12209:IWindowContainer;
        private var _SafeStr_12210:IWindowContainer;
        private var _SafeStr_12211:IWindowContainer;
        private var _SafeStr_12212:IWindowContainer;
        private var _SafeStr_12213:IWindowContainer;
        private var _SafeStr_12214:IWindowContainer;
        private var _categories:AchievementCategories;
        private var _category:AchievementCategory;
        private var _achievement:AchievementData;
        private var _SafeStr_12215:Timer;
        private var _SafeStr_12216:Dictionary;
        private var _SafeStr_12217:ProgressBar;
        private var _SafeStr_12218:ProgressBar;
        private var _SafeStr_12219:Matrix;
        private var _SafeStr_12220:ColorMatrixFilter;
        private var _SafeStr_12221:AchievementData;
        private var _SafeStr_12222:Timer;
        private var _SafeStr_12223:Dictionary;
        private var _levelUpDialog:AchievementLevelUp;

        public function AchievementController(_arg_1:HabboQuestEngine)
        {
            this._SafeStr_12216 = new Dictionary();
            this._SafeStr_12223 = new Dictionary();
            super();
            this._SafeStr_8017 = _arg_1;
            this._SafeStr_12215 = new Timer(100, 1);
            this._SafeStr_12215.addEventListener(TimerEvent.TIMER, this.AchievementController);
            this._SafeStr_12222 = new Timer(2000, 1);
            this._SafeStr_12222.addEventListener(TimerEvent.TIMER, this.AchievementController);
            this._levelUpDialog = new AchievementLevelUp(this._SafeStr_8017);
            this._SafeStr_12219 = new Matrix();
            this._SafeStr_12220 = this.AchievementController();
            this._SafeStr_12223[16] = 1;
            this._SafeStr_12223[28] = 6;
            this._SafeStr_12223[38] = 4;
            this._SafeStr_12223[39] = 3;
            this._SafeStr_12223[40] = 1;
        }
        public static function moveAllChildrenToColumn(_arg_1:IWindowContainer, _arg_2:int, _arg_3:int):void
        {
            var _local_4:int;
            var _local_5:IWindow;
            while (_local_4 < _arg_1.numChildren) {
                _local_5 = _arg_1.getChildAt(_local_4);
                if (((((!((_local_5 == null))) && (_local_5.visible))) && ((_local_5.height > 0)))){
                    _local_5.y = _arg_2;
                    _arg_2 = (_arg_2 + (_local_5.height + _arg_3));
                };
                _local_4++;
            };
        }
        public static function getLowestPoint(_arg_1:IWindowContainer):int
        {
            var _local_4:IWindow;
            var _local_2:int;
            var _local_3:int;
            while (_local_3 < _arg_1.numChildren) {
                _local_4 = _arg_1.getChildAt(_local_3);
                if (_local_4.visible){
                    _local_2 = Math.max(_local_2, (_local_4.y + _local_4.height));
                };
                _local_3++;
            };
            return (_local_2);
        }

        public function dispose():void
        {
            this._SafeStr_8017 = null;
            this._SafeStr_12216 = null;
            if (this._window){
                this._window.dispose();
                this._window = null;
            };
            if (this._SafeStr_12215){
                this._SafeStr_12215.removeEventListener(TimerEvent.TIMER, this.AchievementController);
                this._SafeStr_12215.reset();
                this._SafeStr_12215 = null;
            };
            if (this._SafeStr_12222){
                this._SafeStr_12222.removeEventListener(TimerEvent.TIMER, this.AchievementController);
                this._SafeStr_12222.reset();
                this._SafeStr_12222 = null;
            };
            if (this._SafeStr_12217){
                this._SafeStr_12217.dispose();
                this._SafeStr_12217 = null;
            };
            if (this._SafeStr_12218){
                this._SafeStr_12218.dispose();
                this._SafeStr_12218 = null;
            };
            if (this._levelUpDialog){
                this._levelUpDialog.dispose();
                this._levelUpDialog = null;
            };
            this._SafeStr_12209 = null;
            this._SafeStr_12211 = null;
            this._SafeStr_12211 = null;
            this._SafeStr_12213 = null;
            this._SafeStr_12212 = null;
            this._SafeStr_12214 = null;
        }
        public function get disposed():Boolean
        {
            return ((this._SafeStr_8017 == null));
        }
        public function isVisible():Boolean
        {
            return (((this._window) && (this._window.visible)));
        }
        public function close():void
        {
            if (this._window){
                this._window.visible = false;
            };
        }
        public function HabboGroupInfoManager():void
        {
            this.close();
        }
        public function onToolbarClick():void
        {
            if (this.isVisible()){
                this.close();
            }
            else {
                this.show();
            };
        }
        public function show():void
        {
            if (this._categories == null){
                this._SafeStr_8017.send(new GetAchievementsComposer());
            }
            else {
                this.refresh();
                this._window.visible = true;
                this._window.activate();
            };
        }
        public function onAchievements(_arg_1:Array, _arg_2:String):void
        {
            if (this._categories == null){
                this._categories = new AchievementCategories(_arg_1);
            };
            this.refresh();
            this._window.visible = true;
            this._window.activate();
            var _local_3:AchievementCategory = this._categories.getCategoryByCode(_arg_2);
            if (_local_3 != null){
                this.AchievementController(_local_3);
            };
        }
        public function onAchievement(_arg_1:AchievementData):void
        {
            var _local_2:Boolean;
            if (this._categories != null){
                _local_2 = ((this._achievement) && ((this._achievement.type == _arg_1.type)));
                if (((_local_2) && ((_arg_1.level > this._achievement.level)))){
                    this._achievement.AchievementData();
                    this._SafeStr_12221 = _arg_1;
                    this._SafeStr_12222.start();
                }
                else {
                    this._categories.update(_arg_1);
                    if (_local_2){
                        this._achievement = _arg_1;
                    };
                };
                if (((this._window) && (this._window.visible))){
                    this.refresh();
                };
            };
        }
        private function refresh():void
        {
            this.prepareWindow();
            this.AchievementController();
            this.AchievementController();
            this.AchievementController();
            this.AchievementController();
            this.AchievementController();
            this.AchievementController();
            moveAllChildrenToColumn(this._window.content, 0, 4);
            this._window.height = (getLowestPoint(this._window.content) + _SafeStr_12202);
        }
        private function AchievementController():void
        {
            var _local_3:Boolean;
            if (this._category != null){
                this._SafeStr_12209.visible = false;
                return;
            };
            this._SafeStr_12209.visible = true;
            var _local_1:Array = this._categories.categoryList;
            var _local_2:int;
            while (true) {
                if (_local_2 < _local_1.length){
                    this.AchievementController(_local_2, _local_1[_local_2]);
                }
                else {
                    _local_3 = this.AchievementController(_local_2, null);
                    if (_local_3) break;
                };
                _local_2++;
            };
            this._SafeStr_12209.height = getLowestPoint(this._SafeStr_12209);
        }
        private function AchievementController():void
        {
            if (this._category != null){
                this._SafeStr_12214.visible = false;
                return;
            };
            this._SafeStr_12214.visible = true;
            this._SafeStr_12218.refresh(this._categories.getProgress(), this._categories.getMaxProgress(), 0);
        }
        private function AchievementController():void
        {
            var _local_3:Boolean;
            if (this._category == null){
                this._SafeStr_12210.visible = false;
                return;
            };
            this._SafeStr_12210.visible = true;
            Logger.log((((this._category.code + " has ") + this._category.achievements.length) + " achievemenets"));
            var _local_1:Array = this._category.achievements;
            var _local_2:int;
            while (true) {
                if (_local_2 < _local_1.length){
                    this.AchievementController(_local_2, _local_1[_local_2]);
                }
                else {
                    _local_3 = this.AchievementController(_local_2, null);
                    if (_local_3) break;
                };
                _local_2++;
            };
            this._SafeStr_12210.height = getLowestPoint(this._SafeStr_12210);
        }
        private function AchievementController():void
        {
            if (this._category == null){
                this._SafeStr_12213.visible = false;
                return;
            };
            this._SafeStr_12213.visible = true;
            this._SafeStr_12213.findChildByName("category_name_txt").caption = this._SafeStr_8017.getAchievementCategoryName(this._category.code);
            this._SafeStr_8017.localization.registerParameter("achievements.details.categoryprogress", "progress", ("" + this._category.getProgress()));
            this._SafeStr_8017.localization.registerParameter("achievements.details.categoryprogress", "limit", ("" + this._category.getMaxProgress()));
            this._SafeStr_8017.setupAchievementCategoryImage(this._SafeStr_12213, this._category, false);
        }
        private function AchievementController():void
        {
            if (this._category == null){
                this._SafeStr_12212.visible = false;
                return;
            };
            this._SafeStr_12212.visible = true;
        }
        private function AchievementController():void
        {
            if (this._achievement == null){
                this._SafeStr_12211.visible = false;
                return;
            };
            this._SafeStr_12211.visible = true;
            var _local_1:String = this.AchievementController(this._achievement);
            this._SafeStr_12211.findChildByName("achievement_name_txt").caption = this._SafeStr_8017.localization.getBadgeName(_local_1);
            var _local_2:String = this._SafeStr_8017.localization.getBadgeDesc(_local_1);
            this._SafeStr_12211.findChildByName("achievement_desc_txt").caption = (((_local_2 == null)) ? "" : _local_2);
            this._SafeStr_8017.localization.registerParameter("achievements.details.level", "level", ("" + ((this._achievement.finalLevel) ? this._achievement.level : (this._achievement.level - 1))));
            this._SafeStr_8017.localization.registerParameter("achievements.details.level", "limit", ("" + this._achievement.levelCount));
            this._SafeStr_8017.refreshReward(!(this._achievement.finalLevel), this._SafeStr_12211, this._achievement.levelRewardPointType, this._achievement.levelRewardPoints);
            this.AchievementController(this._SafeStr_12211, this._achievement);
            this._SafeStr_12217.refresh(this._achievement.currentPoints, this._achievement.scoreLimit, ((this._achievement.type * 10000) + this._achievement.level));
            this._SafeStr_12217.visible = !(this._achievement.finalLevel);
        }
        private function prepareWindow():void
        {
            if (this._window != null){
                return;
            };
            this._window = IFrameWindow(this._SafeStr_8017.getXmlWindow("Achievements"));
            this._window.findChildByTag("close").procedure = this.onWindowClose;
            this._window.findChildByName("back_button").procedure = this.AchievementController;
            this._window.center();
            this._window.y = _SafeStr_12206;
            this._SafeStr_12209 = IWindowContainer(this._window.findChildByName("categories_cont"));
            this._SafeStr_12213 = IWindowContainer(this._window.findChildByName("achievements_header_cont"));
            this._SafeStr_12210 = IWindowContainer(this._window.findChildByName("achievements_cont"));
            this._SafeStr_12211 = IWindowContainer(this._window.findChildByName("achievement_cont"));
            this._SafeStr_12212 = IWindowContainer(this._window.findChildByName("achievements_footer_cont"));
            this._SafeStr_12214 = IWindowContainer(this._window.findChildByName("categories_footer_cont"));
            this._SafeStr_12217 = new ProgressBar(this._SafeStr_8017, this._SafeStr_12211, _SafeStr_12200, "achievements.details.progress", true, _SafeStr_12203);
            this._SafeStr_12218 = new ProgressBar(this._SafeStr_8017, this._SafeStr_12214, _SafeStr_12201, "achievements.categories.totalprogress", true, _SafeStr_12204);
        }
        private function AchievementController(_arg_1:int, _arg_2:AchievementCategory):Boolean
        {
            var _local_3:IWindowContainer = IWindowContainer(this._SafeStr_12209.getChildByName(("" + _arg_1)));
            var _local_4:int = Math.floor((_arg_1 / _SafeStr_12193));
            var _local_5 = (_local_4 < _SafeStr_12197);
            if (_local_3 == null){
                if ((((_arg_2 == null)) && (!(_local_5)))){
                    return (true);
                };
                _local_3 = IWindowContainer(this._SafeStr_8017.getXmlWindow("AchievementCategory"));
                _local_3.name = ("" + _arg_1);
                this._SafeStr_12209.addChild(_local_3);
                new PendingImage(this._SafeStr_8017, IBitmapWrapperWindow(_local_3.findChildByName("category_bg_act")), "achievement_bkg_active1");
                new PendingImage(this._SafeStr_8017, IBitmapWrapperWindow(_local_3.findChildByName("category_bg_act_hover")), "achievement_bkg_active2");
                new PendingImage(this._SafeStr_8017, IBitmapWrapperWindow(_local_3.findChildByName("category_bg_inact")), "achievement_category_bkg_empty_3");
                _local_3.findChildByName("category_region").procedure = this.AchievementController;
                _local_3.x = ((_local_3.width + _SafeStr_12194) * (_arg_1 % _SafeStr_12193));
                _local_3.y = (((_local_3.height + _SafeStr_12195) * Math.floor((_arg_1 / _SafeStr_12193))) + _SafeStr_12196);
            };
            _local_3.findChildByName("category_region").id = _arg_1;
            _local_3.findChildByName("category_region").visible = !((_arg_2 == null));
            _local_3.findChildByName("category_bg_inact").visible = (_arg_2 == null);
            _local_3.findChildByName("category_bg_act").visible = !((_arg_2 == null));
            _local_3.findChildByName("category_bg_act_hover").visible = false;
            _local_3.findChildByName("header_txt").visible = !((_arg_2 == null));
            _local_3.findChildByName("completion_txt").visible = !((_arg_2 == null));
            _local_3.findChildByName("category_pic_bitmap").visible = !((_arg_2 == null));
            if (_arg_2){
                _local_3.findChildByName("header_txt").caption = this._SafeStr_8017.getAchievementCategoryName(_arg_2.code);
                _local_3.findChildByName("completion_txt").caption = ((_arg_2.getProgress() + "/") + _arg_2.getMaxProgress());
                this._SafeStr_8017.setupAchievementCategoryImage(_local_3, _arg_2, true);
                _local_3.visible = true;
            }
            else {
                if (_local_5){
                    _local_3.visible = true;
                }
                else {
                    _local_3.visible = false;
                };
            };
            return (false);
        }
        private function AchievementController(_arg_1:int, _arg_2:AchievementData):Boolean
        {
            var _local_9:IBitmapWrapperWindow;
            var _local_3:IWindowContainer = IWindowContainer(this._SafeStr_12210.getChildByName(("" + _arg_1)));
            var _local_4:int = Math.floor((_arg_1 / _SafeStr_12199));
            var _local_5 = (_local_4 < _SafeStr_12198);
            if (_local_3 == null){
                if ((((_arg_2 == null)) && (!(_local_5)))){
                    return (true);
                };
                _local_3 = IWindowContainer(this._SafeStr_8017.getXmlWindow("Achievement"));
                _local_3.name = ("" + _arg_1);
                this._SafeStr_12210.addChild(_local_3);
                _local_9 = (_local_3.findChildByName("achievement_pic_bitmap") as IBitmapWrapperWindow);
                _local_9.bitmap = new BitmapData(_local_9.width, _local_9.height, true, 0xFFFFFF);
                new PendingImage(this._SafeStr_8017, _local_3.findChildByName("bg_selected_bitmap"), "achievement_active");
                new PendingImage(this._SafeStr_8017, _local_3.findChildByName("bg_unselected_bitmap"), "achievement_inactive");
                _local_3.x = (_local_3.width * (_arg_1 % _SafeStr_12199));
                _local_3.y = ((_local_3.height * _local_4) + _SafeStr_12207);
                _local_3.findChildByName("bg_region").procedure = this.AchievementController;
            };
            var _local_6:IWindow = _local_3.findChildByName("bg_region");
            _local_6.id = _arg_1;
            _local_6.visible = !((_arg_2 == null));
            var _local_7:IWindow = _local_3.findChildByName("bg_unselected_bitmap");
            var _local_8:IWindow = _local_3.findChildByName("bg_selected_bitmap");
            this.refreshBadgeImage(_local_3, _arg_2);
            if (_arg_2){
                _local_7.visible = !((_arg_2 == this._achievement));
                _local_8.visible = (_arg_2 == this._achievement);
                _local_3.visible = true;
            }
            else {
                if (_local_5){
                    _local_8.visible = false;
                    _local_7.visible = true;
                    _local_3.visible = true;
                }
                else {
                    _local_3.visible = false;
                };
            };
            return (false);
        }
        private function onWindowClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                this.close();
            };
        }
        private function AchievementController(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:int = _arg_2.id;
            Logger.log(("Category index: " + _local_3));
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                this.AchievementController(this._categories.categoryList[_local_3]);
            }
            else {
                if (_arg_1.type == WindowMouseEvent.WME_OUT){
                    this.AchievementController(-999);
                }
                else {
                    if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER){
                        this.AchievementController(_local_3);
                    };
                };
            };
        }
        private function AchievementController(_arg_1:AchievementCategory):void
        {
            this._category = _arg_1;
            this._achievement = this._category.achievements[0];
            Logger.log(("Category: " + this._category.code));
            this.refresh();
            this._SafeStr_8017.send(new EventLogMessageComposer("Achievements", this._category.code, "Category selected"));
        }
        private function AchievementController(_arg_1:int):void
        {
            var _local_3:Boolean;
            var _local_4:IWindowContainer;
            var _local_5:IWindow;
            var _local_2:int;
            while (_local_2 < this._SafeStr_12209.numChildren) {
                _local_3 = (_local_2 == _arg_1);
                _local_4 = IWindowContainer(this._SafeStr_12209.getChildAt(_local_2));
                _local_4.findChildByName("category_bg_act").visible = ((!(_local_3)) && ((_local_2 < this._categories.categoryList.length)));
                _local_4.findChildByName("category_bg_act_hover").visible = _local_3;
                _local_5 = _local_4.findChildByName("hover_container");
                _local_5.x = ((_local_3) ? 0 : 1);
                _local_5.y = ((_local_3) ? 0 : 1);
                _local_2++;
            };
        }
        private function AchievementController(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            var _local_3:int = _arg_2.id;
            this._achievement = this._category.achievements[_local_3];
            this.refresh();
            this._SafeStr_8017.send(new EventLogMessageComposer("Achievements", ("" + this._achievement.type), "Achievement selected"));
        }
        private function AchievementController(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this._category = null;
            this._achievement = null;
            this.refresh();
        }
        private function refreshBadgeImage(_arg_1:IWindowContainer, _arg_2:AchievementData):void
        {
            var _local_9:BadgeInfo;
            var _local_3:IBitmapWrapperWindow = (_arg_1.findChildByName("achievement_pic_bitmap") as IBitmapWrapperWindow);
            if (_arg_2 == null){
                _local_3.visible = false;
                return;
            };
            var _local_4:String = this.AchievementController(_arg_2);
            var _local_5:BitmapData = this._SafeStr_12216[_local_4];
            var _local_6:Boolean;
            if (_local_5 == null){
                _local_9 = this._SafeStr_8017.sessionDataManager.SessionDataManager(_local_4);
                _local_5 = _local_9.image;
                _local_6 = _local_9.placeHolder;
                this._SafeStr_12216[_local_4] = _local_5;
            };
            var _local_7:int = ((_SafeStr_12205 - _local_5.height) + this.AchievementController(_arg_2.type));
            var _local_8:Point = new Point(((_local_3.width - _local_5.width) / 2), ((_local_6) ? _SafeStr_12208 : _local_7));
            _local_3.bitmap.fillRect(_local_3.bitmap.rect, 0xFFFFFF);
            if (_arg_2.firstLevelAchieved){
                _local_3.bitmap.copyPixels(_local_5, _local_5.rect, _local_8, null, null, true);
            }
            else {
                _local_3.bitmap.applyFilter(_local_5, _local_5.rect, _local_8, this._SafeStr_12220);
            };
            _local_3.visible = false;
            _local_3.visible = true;
        }
        private function AchievementController(_arg_1:IWindowContainer, _arg_2:AchievementData):void
        {
            var _local_3:IBitmapWrapperWindow = (_arg_1.findChildByName("achievement_pic_bitmap") as IBitmapWrapperWindow);
            var _local_4:String = this.AchievementController(_arg_2);
            var _local_5:BitmapData = this._SafeStr_12216[_local_4];
            if (_local_5 == null){
                _local_5 = this._SafeStr_8017.sessionDataManager.SessionDataManager(_local_4);
                this._SafeStr_12216[_local_4] = _local_5;
            };
            if (_local_3.bitmap == null){
                _local_3.bitmap = new BitmapData(_local_3.width, _local_3.height, true, 0xFFFFFF);
            };
            var _local_6:int = (2 * ((_SafeStr_12205 - _local_5.height) + this.AchievementController(_arg_2.type)));
            this._SafeStr_12219.identity();
            this._SafeStr_12219.scale(2, 2);
            this._SafeStr_12219.translate(((_local_3.width - (_local_5.width * 2)) / 2), _local_6);
            _local_3.bitmap.fillRect(_local_3.bitmap.rect, 0xFFFFFF);
            _local_3.bitmap.draw(_local_5, this._SafeStr_12219);
            if (!_arg_2.firstLevelAchieved){
                _local_3.bitmap.applyFilter(_local_3.bitmap, _local_3.bitmap.rect, new Point(0, 0), this._SafeStr_12220);
            };
            _local_3.visible = false;
            _local_3.visible = true;
        }
        private function AchievementController(_arg_1:TimerEvent):void
        {
            this._SafeStr_12215.reset();
            this.refresh();
        }
        private function AchievementController(_arg_1:TimerEvent):void
        {
            this._achievement = this._SafeStr_12221;
            this._categories.update(this._SafeStr_12221);
            this._SafeStr_12221 = null;
            this.refresh();
        }
        public function onBadgeImageReady(_arg_1:BadgeImageReadyEvent):void
        {
            if (this._window == null){
                return;
            };
            this._SafeStr_12216[_arg_1.badgeId] = _arg_1.badgeImage;
            if (!this._SafeStr_12215.running){
                this._SafeStr_12215.start();
            };
        }
        private function AchievementController():ColorMatrixFilter
        {
            var _local_1:Number = (1 / 3);
            var _local_2:Number = (1 - (_local_1 * 2));
            var _local_3:Array = [_local_2, _local_1, _local_1, 0, 0, _local_1, _local_2, _local_1, 0, 0, _local_1, _local_1, _local_2, 0, 0, 0, 0, 0, 1, 0];
            return (new ColorMatrixFilter(_local_3));
        }
        public function update(_arg_1:uint):void
        {
            if (this._SafeStr_12217 != null){
                this._SafeStr_12217.ProgressBar();
            };
            if (this._SafeStr_12218 != null){
                this._SafeStr_12218.ProgressBar();
            };
            if (this._levelUpDialog != null){
                this._levelUpDialog.update(_arg_1);
            };
        }
        private function AchievementController(_arg_1:AchievementData):String
        {
            return (((_arg_1.finalLevel) ? _arg_1.badgeId : this._SafeStr_8017.localization.getPreviousLevelBadgeId(_arg_1.badgeId)));
        }
        private function AchievementController(_arg_1:int):int
        {
            return (((this._SafeStr_12223[_arg_1]) ? this._SafeStr_12223[_arg_1] : 0));
        }
        public function get levelUpDialog():AchievementLevelUp
        {
            return (this._levelUpDialog);
        }

    }
}//package com.sulake.habbo.quest

// AchievementController = "_-1yX" (String#6003, DoABC#2)
// AchievementController = "_-2yv" (String#905, DoABC#2)
// getPreviousLevelBadgeId = "_-2Kq" (String#6459, DoABC#2)
// onAchievements = "_-2x" (String#7223, DoABC#2)
// onAchievement = "_-3BD" (String#7532, DoABC#2)
// levelUpDialog = "_-3Ft" (String#22111, DoABC#2)
// onToolbarClick = "_-2UP" (String#6654, DoABC#2)
// _SafeStr_12193 = "_-0hY" (String#15730, DoABC#2)
// _SafeStr_12194 = "_-1sh" (String#18664, DoABC#2)
// _SafeStr_12195 = "_-0JN" (String#14816, DoABC#2)
// _SafeStr_12196 = "_-k0" (String#24034, DoABC#2)
// _SafeStr_12197 = "_-2Va" (String#20264, DoABC#2)
// _SafeStr_12198 = "_-2iA" (String#20778, DoABC#2)
// _SafeStr_12199 = "_-bj" (String#23702, DoABC#2)
// _SafeStr_12200 = "_-iz" (String#23998, DoABC#2)
// _SafeStr_12201 = "_-1Gx" (String#17149, DoABC#2)
// _SafeStr_12202 = "_-3Gc" (String#7639, DoABC#2)
// _SafeStr_12203 = "_-21j" (String#19081, DoABC#2)
// _SafeStr_12204 = "_-25f" (String#19244, DoABC#2)
// _SafeStr_12205 = "_-05a" (String#14266, DoABC#2)
// _SafeStr_12206 = "_-gc" (String#23916, DoABC#2)
// _SafeStr_12207 = "_-xf" (String#24596, DoABC#2)
// _SafeStr_12208 = "_-19B" (String#16824, DoABC#2)
// _SafeStr_12209 = "_-2Ds" (String#19563, DoABC#2)
// _SafeStr_12210 = "_-0Yr" (String#15395, DoABC#2)
// _SafeStr_12211 = "_-1rA" (String#18589, DoABC#2)
// _SafeStr_12212 = "_-394" (String#21849, DoABC#2)
// _SafeStr_12213 = "_-eH" (String#23813, DoABC#2)
// _SafeStr_12214 = "_-1NL" (String#17412, DoABC#2)
// _SafeStr_12215 = "_-la" (String#24092, DoABC#2)
// _SafeStr_12216 = "_-nr" (String#24185, DoABC#2)
// _SafeStr_12217 = "_-1h3" (String#18178, DoABC#2)
// _SafeStr_12218 = "_-0EZ" (String#14627, DoABC#2)
// _SafeStr_12219 = "_-Qh" (String#8219, DoABC#2)
// _SafeStr_12220 = "_-1k3" (String#18291, DoABC#2)
// _SafeStr_12221 = "_-g3" (String#23894, DoABC#2)
// _SafeStr_12222 = "_-0Z9" (String#15410, DoABC#2)
// _SafeStr_12223 = "_-1PQ" (String#17485, DoABC#2)
// _levelUpDialog = "_-ha" (String#23951, DoABC#2)
// AchievementController = "_-1Fv" (String#17112, DoABC#2)
// AchievementController = "_-1kx" (String#18330, DoABC#2)
// AchievementController = "_-0mi" (String#15925, DoABC#2)
// moveAllChildrenToColumn = "_-07-" (String#14323, DoABC#2)
// getCategoryByCode = "_-0JX" (String#14823, DoABC#2)
// AchievementController = "_-0nK" (String#15949, DoABC#2)
// AchievementController = "_-1Fe" (String#17101, DoABC#2)
// AchievementController = "_-1dE" (String#18024, DoABC#2)
// AchievementController = "_-0XS" (String#15332, DoABC#2)
// AchievementController = "_-cB" (String#23721, DoABC#2)
// AchievementController = "_-0tE" (String#16168, DoABC#2)
// AchievementController = "_-yz" (String#24647, DoABC#2)
// categoryList = "_-32E" (String#21590, DoABC#2)
// getProgress = "_-2qB" (String#21088, DoABC#2)
// getMaxProgress = "_-2fb" (String#20674, DoABC#2)
// AchievementController = "_-1EV" (String#17049, DoABC#2)
// getAchievementCategoryName = "_-3EV" (String#22055, DoABC#2)
// setupAchievementCategoryImage = "_-VS" (String#23470, DoABC#2)
// AchievementController = "_-0CC" (String#14537, DoABC#2)
// refreshReward = "_-13f" (String#16604, DoABC#2)
// AchievementController = "_-00a" (String#14078, DoABC#2)
// AchievementController = "_-1-9" (String#16435, DoABC#2)
// AchievementController = "_-1il" (String#18235, DoABC#2)
// refreshBadgeImage = "_-1Ir" (String#5217, DoABC#2)
// AchievementController = "_-0kR" (String#15847, DoABC#2)
// SessionDataManager = "_-0SD" (String#4143, DoABC#2)
// AchievementController = "_-17j" (String#16763, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// BadgeImageReadyEvent = "_-03M" (String#14177, DoABC#2)
// AchievementController = "_-1XH" (String#5503, DoABC#2)
// BadgeInfo = "_-3V" (String#7736, DoABC#2)
// GetAchievementsComposer = "_-AY" (String#22637, DoABC#2)
// AchievementData = "_-39C" (String#7494, DoABC#2)
// AchievementCategories = "_-Do" (String#7948, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// badgeId = "_-g6" (String#23896, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// getLowestPoint = "_-0t0" (String#16161, DoABC#2)
// onWindowClose = "_-2tr" (String#136, DoABC#2)
// _categories = "_-EJ" (String#373, DoABC#2)
// badgeImage = "_-250" (String#19222, DoABC#2)
// sessionDataManager = "_-0pX" (String#4623, DoABC#2)
// levelRewardPoints = "_-315" (String#21541, DoABC#2)
// levelRewardPointType = "_-0M3" (String#14917, DoABC#2)
// code = "_-12Y" (String#4926, DoABC#2)
// prepareWindow = "_-RN" (String#219, DoABC#2)
// ProgressBar = "_-1Js" (String#847, DoABC#2)
// SessionDataManager = "_-3DK" (String#7581, DoABC#2)
// isVisible = "_-1rE" (String#18592, DoABC#2)
// IUpdateReceiver = "_-Qe" (String#8218, DoABC#2)
// _SafeStr_8017 = "_-1jf" (String#150, DoABC#2)
// achievements = "_-2JC" (String#19776, DoABC#2)
// _achievement = "_-0zK" (String#4834, DoABC#2)
// EventLogMessageComposer = "_-2lH" (String#6984, DoABC#2)
// onBadgeImageReady = "_-2f0" (String#1919, DoABC#2)
// scoreLimit = "_-0Nb" (String#14976, DoABC#2)
// currentPoints = "_-1Hf" (String#17176, DoABC#2)
// finalLevel = "_-0or" (String#16006, DoABC#2)
// levelCount = "_-22S" (String#19107, DoABC#2)
// firstLevelAchieved = "_-2Jb" (String#19794, DoABC#2)
// AchievementData = "_-0WK" (String#15292, DoABC#2)
// HabboGroupInfoManager = "_-0Na" (String#356, DoABC#2)


