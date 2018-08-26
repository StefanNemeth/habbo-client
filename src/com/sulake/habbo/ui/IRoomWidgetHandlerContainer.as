
package com.sulake.habbo.ui
{
    import com.sulake.habbo.tracking.IHabboTracking;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.session.ISessionDataManager;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.friendlist.IHabboFriendList;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.navigator.IHabboNavigator;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.habbo.avatar.IHabboAvatarEditor;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.help.IHabboHelp;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.habbo.moderation.IHabboModeration;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.roomevents.IHabboUserDefinedRoomEvents;
    import com.sulake.core.communication.connection.IConnection;
    import flash.geom.Rectangle;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;

    public interface IRoomWidgetHandlerContainer 
    {

        function get habboTracking():IHabboTracking;
        function get roomSession():IRoomSession;
        function get sessionDataManager():ISessionDataManager;
        function get events():IEventDispatcher;
        function get roomEngine():IRoomEngine;
        function get friendList():IHabboFriendList;
        function get avatarRenderManager():IAvatarRenderManager;
        function get inventory():IHabboInventory;
        function get toolbar():IHabboToolbar;
        function get navigator():IHabboNavigator;
        function get roomWidgetFactory():IRoomWidgetFactory;
        function get roomSessionManager():IRoomSessionManager;
        function get avatarEditor():IHabboAvatarEditor;
        function get catalog():IHabboCatalog;
        function get localization():IHabboLocalizationManager;
        function get habboHelp():IHabboHelp;
        function get config():IHabboConfigurationManager;
        function get soundManager():IHabboSoundManager;
        function get moderation():IHabboModeration;
        function get windowManager():IHabboWindowManager;
        function get userDefinedRoomEvents():IHabboUserDefinedRoomEvents;
        function get connection():IConnection;
        function IRoomWidgetHandlerContainer(_arg_1:uint, _arg_2:int):void;
        function IRoomWidgetHandlerContainer():int;
        function IRoomWidgetHandlerContainer():Rectangle;
        function IRoomWidgetHandlerContainer():void;
        function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent;
        function IRoomWidgetHandlerContainer(_arg_1:IRoomWidgetHandler):void;
        function IRoomWidgetHandlerContainer(_arg_1:IRoomWidgetHandler):void;

    }
}//package com.sulake.habbo.ui

// ISessionDataManager = "_-Bk" (String#7907, DoABC#2)
// IHabboAvatarEditor = "_-N2" (String#8144, DoABC#2)
// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// roomWidgetFactory = "_-1y0" (String#5994, DoABC#2)
// IRoomWidgetHandlerContainer = "_-1-s" (String#4865, DoABC#2)
// IRoomWidgetHandlerContainer = "_-0Vt" (String#4226, DoABC#2)
// IRoomWidgetHandlerContainer = "_-8Y" (String#7833, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// IHabboNavigator = "_-2rk" (String#7118, DoABC#2)
// IHabboSoundManager = "_-0vD" (String#4750, DoABC#2)
// IAvatarRenderManager = "_-C9" (String#7915, DoABC#2)
// sessionDataManager = "_-0pX" (String#4623, DoABC#2)
// soundManager = "_-1sN" (String#5892, DoABC#2)
// IHabboInventory = "_-ud" (String#8776, DoABC#2)
// IHabboTracking = "_-0fl" (String#4419, DoABC#2)
// roomSession = "_-0cq" (String#4363, DoABC#2)
// avatarEditor = "_-1mJ" (String#5786, DoABC#2)
// IHabboUserDefinedRoomEvents = "_-2Ae" (String#6258, DoABC#2)
// moderation = "_-Id" (String#8055, DoABC#2)
// IRoomWidgetHandlerContainer = "_-iH" (String#8561, DoABC#2)
// habboHelp = "_-015" (String#3584, DoABC#2)
// habboTracking = "_-1ZQ" (String#5552, DoABC#2)
// IRoomWidgetHandlerContainer = "_-0lq" (String#4543, DoABC#2)
// roomSessionManager = "_-1bj" (String#5594, DoABC#2)
// userDefinedRoomEvents = "_-2pN" (String#7068, DoABC#2)
// IRoomWidgetHandlerContainer = "_-1ZD" (String#5545, DoABC#2)
// IHabboHelp = "_-2o3" (String#7041, DoABC#2)
// IHabboToolbar = "_-0Wr" (String#4245, DoABC#2)
// IHabboFriendList = "_-29N" (String#6237, DoABC#2)
// IHabboModeration = "_-1nO" (String#5806, DoABC#2)


