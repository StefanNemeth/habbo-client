
package com.sulake.habbo.communication
{
    import com.sulake.core.communication.messages.IMessageConfiguration;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.communication.messages.incoming.handshake.SecretKeyEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.InitCryptoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.SessionParamsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserRightsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.AuthenticationOKMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.PingMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UniqueMachineIDEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.GenericErrorEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.DisconnectReasonEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.IdentityAccountsEvent;
    import com.sulake.habbo.communication.messages.outgoing.handshake.InitCryptoMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.handshake.GenerateSecretKeyMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.handshake.VersionCheckMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.handshake.UniqueIDMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.handshake.GetSessionParametersMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.handshake.SSOTicketMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.handshake.TryLoginMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.handshake.PongMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.handshake.InfoRetrieveMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.handshake.DisconnectMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.availability.AvailabilityStatusMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.availability.InfoHotelClosingMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.availability.InfoHotelClosedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.availability.AvailabilityTimeMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.availability.LoginFailedHotelClosedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.MessengerInitEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.NewBuddyRequestEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.NewConsoleMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.MessengerErrorEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.InstantMessageErrorEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.BuddyRequestsEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.AcceptBuddyResultEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListUpdateEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.HabboSearchResultEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FollowFriendFailedEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.RoomInviteErrorEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.RoomInviteEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FindFriendsProcessResultEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendNotificationEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.EventStreamEvent;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.MessengerInitMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.FriendListUpdateMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.SendMsgMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.AcceptBuddyMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.DeclineBuddyMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.RequestBuddyMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.RemoveBuddyMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.HabboSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.GetBuddyRequestsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.FollowFriendMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.SendRoomInviteMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.FindNewFriendsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.GetEventStreamComposer;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.SetEventStreamingAllowedComposer;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.LikeStreamEventMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.inventory.purse.CreditBalanceEvent;
    import com.sulake.habbo.communication.messages.outgoing.inventory.purse.GetCreditsInfoComposer;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListInsertEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListRemoveEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListUpdateEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.PostItPlacedEvent;
    import com.sulake.habbo.communication.messages.outgoing.inventory.furni.RequestRoomPropertySet;
    import com.sulake.habbo.communication.messages.outgoing.inventory.furni.RequestFurniInventoryComposer;
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectAddedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectActivatedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectExpiredMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectSelectedMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.inventory.avatareffect.AvatarEffectSelectedComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.avatareffect.AvatarEffectActivatedComposer;
    import com.sulake.habbo.communication.messages.incoming.inventory.badges.BadgesEvent;
    import com.sulake.habbo.communication.messages.outgoing.inventory.badges.GetBadgesComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.badges.SetActivatedBadgesComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.badges.GetBadgePointLimitsComposer;
    import com.sulake.habbo.communication.messages.incoming.inventory.badges.BadgePointLimitsEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementsEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementsScoreEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementEvent;
    import com.sulake.habbo.communication.messages.outgoing.inventory.achievements.GetAchievementsComposer;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingYouAreNotAllowedEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingOtherNotAllowedEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingOpenEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingAlreadyOpenEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingNotOpenEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingNoSuchItemEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingItemListEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingAcceptEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingCloseEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingConfirmationEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingCompletedEvent;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.UnacceptTradingComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.AcceptTradingComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.CloseTradingComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.OpenTradingComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.AddItemToTradeComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.ConfirmAcceptTradingComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.ConfirmDeclineTradingComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.RemoveItemFromTradeComposer;
    import com.sulake.habbo.communication.messages.incoming.inventory.pets.PetInventoryEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.pets.PetAddedToInventoryEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.pets.PetRemovedFromInventoryEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.pets.PetReceivedMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.inventory.pets.GetPetInventoryComposer;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceMakeOfferResult;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceCanMakeOfferResult;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceConfigurationEvent;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceBuyOfferResultEvent;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceCancelOfferResultEvent;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOffersEvent;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOwnOffersEvent;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceItemStatsEvent;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.MakeOfferMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceConfigurationMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceCanMakeOfferComposer;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.BuyMarketplaceTokensMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.BuyOfferMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.CancelOfferMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.RedeemOfferCreditsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.GetOffersMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.GetOwnOffersMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceItemStatsComposer;
    import com.sulake.habbo.communication.messages.incoming.navigator.UserFlatCatsEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatCatEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.CanCreateRoomEventEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomEventEvent;
    import com.sulake.habbo.communication.messages.outgoing.navigator.DeleteFavouriteRoomMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.AddFavouriteRoomMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.GetUserFlatCatsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.CanCreateEventMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.CreateEventMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.CancelEventMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.EditEventMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.navigator.DoorbellMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatAccessDeniedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsDataEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsErrorEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsSavedEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsSaveErrorEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.NoSuchFlatEvent;
    import com.sulake.habbo.communication.messages.outgoing.roomsettings.GetRoomSettingsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.roomsettings.SaveRoomSettingsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.roomsettings.DeleteRoomMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomsEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomSearchResultEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.PopularRoomTagsResultEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.PublicSpaceCastLibsEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.GetGuestRoomResultEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.NavigatorSettingsEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomInfoUpdatedEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomThumbnailUpdateResultEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.FavouritesEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.FavouriteChangedEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatCreatedEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomRatingEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerAddedEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerRemovedEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.CanCreateRoomEvent;
    import com.sulake.habbo.communication.messages.outgoing.navigator.GetOfficialRoomsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.GetPopularRoomTagsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.UpdateNavigatorSettingsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.GetGuestRoomMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.UpdateRoomThumbnailMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.CanCreateRoomMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.CreateFlatMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.RateFlatMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.GetPublicSpaceCastLibsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.PopularRoomsSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.RoomsWithHighestScoreSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.MyFriendsRoomsSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.RoomsWhereMyFriendsAreSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.MyRoomsSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.MyFavouriteRoomsSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.MyRoomHistorySearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.RoomTextSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.RoomTagSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.LatestEventsSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.ToggleStaffPickMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.OpenConnectionMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.RoomQueueStatusMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.RoomForwardMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.chat.ChatMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.chat.WhisperMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.chat.ShoutMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.chat.UserTypingMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.chat.FloodControlMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.FlatAccessibleMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.RoomReadyMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UsersMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserRemoveMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.HeightMapMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserUpdateMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemDataUpdateMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemAddMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemRemoveMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemUpdateMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectAddMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ViralTeaserActiveMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectDataUpdateMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectRemoveMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectUpdateMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetInfoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.HeightMapUpdateMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.SlideObjectBundleMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.YouAreSpectatorMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserChangeMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.RoomDimmerPresetsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.FloorHeightMapMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomVisualizationSettingsEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectsDataUpdateMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.PlaceObjectErrorMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.UserNameChangedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.ViralFurniGiftReceivedEvent;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.ViralFurniStatusEvent;
    import com.sulake.habbo.communication.messages.incoming.users.UserNotificationMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.WelcomeGiftStatusEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.FurnitureAliasesMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomPropertyMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.permissions.YouAreControllerMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.permissions.YouAreNotControllerMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.permissions.YouAreOwnerMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.RequestSpamWallPostItMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.RoomMessageNotificationMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.CantConnectMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetCommandsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetPlacingErrorEvent;
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetExperienceEvent;
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetRespectFailedEvent;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.GetPetCommandsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.session.OpenConnectionMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.session.OpenFlatConnectionMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.chat.ChatMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.chat.ShoutMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.chat.WhisperMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.chat.StartTypingMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.chat.CancelTypingMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.avatar.SignMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.avatar.ChangeMottoMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.session.GoToFlatMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.GetRoomEntryDataMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.UseFurnitureMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.PickupObjectMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.MoveObjectMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.SetObjectDataMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.MoveAvatarMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.PlaceObjectMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.MoveWallItemMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.PlacePetMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.RemovePetFromFlatMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.ViralTeaserFoundMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.GetMOTDMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.GetUserNotificationsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.session.ChangeQueueMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.RoomDimmerGetPresetsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.RoomDimmerSavePresetMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.RoomDimmerChangeStateMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.UseWallItemMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.GetItemDataMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.SetItemDataMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.RemoveItemMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.ViralFurniStatusMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.pets.GetPetInfoMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.GetFurnitureAliasesMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.session.QuitMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.PlacePostItMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.AddSpamWallPostItMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.room.action.DanceMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.action.WaveMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.action.CarryObjectMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.action.AvatarEffectMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.action.SleepMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.action.UseObjectMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.room.avatar.DanceMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.avatar.WaveMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.avatar.LookToMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.DiceValueMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.PresentOpenedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.OpenPetPackageRequestedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.OpenPetPackageResultMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.OneWayDoorStatusMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.PublicRoomObjectsMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.ThrowDiceMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.DiceOffMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.PresentOpenMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.CreditFurniRedeemMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.EnterOneWayDoorMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.SpinWheelOfFortuneMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.SetRandomStateMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.SetClothingChangeDataMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.QuestVendingWallItemMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.OpenPetPackageMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.OpenWelcomeGiftComposer;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.DoorOtherEndDeletedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.DoorNotInstalledMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.room.action.KickUserMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.action.AssignRightsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.action.RemoveRightsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.action.LetUserInMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.action.RemoveAllRightsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.action.BanUserMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.action.CallGuideBotMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.action.KickBotMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.users.UserTagsMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.users.GetUserTagsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.GetSelectedBadgesMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupBadgesMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupDetailsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.JoinHabboGroupMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.SelectFavouriteHabboGroupMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.DeselectFavouriteHabboGroupMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupsWhereMemberMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.users.HabboUserBadgesMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupBadgesMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.FavoriteMembershipUpdateMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupsWhereMemberMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupJoinFailedMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.users.IgnoreUserMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.GetIgnoredUsersMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.UnignoreUserMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.users.IgnoreResultMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.IgnoredUsersMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.RespectNotificationMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.PetRespectNotificationEvent;
    import com.sulake.habbo.communication.messages.outgoing.users.RespectUserMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.pets.RespectPetMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.moderation.UserBannedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.ModMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.IssueDeletedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.IssueInfoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorInitMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.IssuePickFailedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorUserInfoEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.CfhChatlogEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.RoomChatlogEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.UserChatlogEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.RoomVisitsEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorRoomInfoEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorActionResultMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.moderator.PickIssuesMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.moderator.ReleaseIssuesMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.moderator.CloseIssuesMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.moderator.GetModeratorUserInfoMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.moderator.GetUserChatlogMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.moderator.GetRoomChatlogMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.moderator.GetCfhChatlogMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.moderator.GetRoomVisitsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.moderator.GetModeratorRoomInfoMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.moderator.ModerateRoomMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.moderator.ModAlertMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.moderator.ModMessageMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.moderator.ModKickMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.moderator.ModBanMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.moderator.ModeratorActionMessageComposer;
    import default.CallForHelpMessageComposer;
    import default.GetPendingCallsForHelpMessageComposer;
    import default.DeletePendingCallsForHelpMessageComposer;
    import default.GetClientFaqsMessageComposer;
    import default.GetFaqCategoriesMessageComposer;
    import default.GetFaqTextMessageComposer;
    import default.SearchFaqsMessageComposer;
    import default.GetFaqCategoryMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.help.CallForHelpReplyMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.CallForHelpPendingCallsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.CallForHelpPendingCallsDeletedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.CallForHelpResultMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.FaqClientFaqsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.FaqCategoriesMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.FaqTextMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.FaqSearchResultsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.FaqCategoryMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.IssueCloseNotificationMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.TutorialStatusMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.HotelMergeNameChangeEvent;
    import com.sulake.habbo.communication.messages.incoming.error.ErrorReportEvent;
    import com.sulake.habbo.communication.messages.incoming.users.ChangeEmailResultEvent;
    import com.sulake.habbo.communication.messages.outgoing.users.ChangeEmailComposer;
    import com.sulake.habbo.communication.messages.incoming.users.ScrSendUserInfoEvent;
    import com.sulake.habbo.communication.messages.outgoing.users.ScrGetUserInfoMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.notifications.HabboBroadcastMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.ClubGiftNotificationEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.HabboAchievementNotificationMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.HabboAchievementBonusMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.HabboAchievementShareIdMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.HabboActivityPointNotificationMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.ActivityPointsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.InfoFeedEnableMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.PetLevelNotificationEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.MOTDNotificationEvent;
    import com.sulake.habbo.communication.messages.outgoing.users.GetAchievementShareIdComposer;
    import com.sulake.habbo.communication.messages.incoming.notifications.UnseenItemsEvent;
    import com.sulake.habbo.communication.messages.outgoing.notifications.ResetUnseenItemsComposer;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogIndexMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.PurchaseErrorMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.PurchaseOKMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.NotEnoughBalanceMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.GiftReceiverNotFoundEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.PurchaseNotAllowedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPublishedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.VoucherRedeemOkMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.VoucherRedeemErrorMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.GiftWrappingConfigurationEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.IsOfferGiftableMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.ClubGiftInfoEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.ClubGiftSelectedEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.HabboClubOffersMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.ChargeInfoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.SellablePetBreedsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.HabboClubExtendOfferMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.catalog.PurchaseFromCatalogComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.PurchaseFromCatalogAsGiftComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetGiftWrappingConfigurationComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetClubGiftInfo;
    import com.sulake.habbo.communication.messages.outgoing.catalog.SelectClubGiftComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetCatalogIndexComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetCatalogPageComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.RedeemVoucherMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetIsOfferGiftableComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetClubOffersMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetSellablePetBreedsComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.MarkCatalogNewAdditionsPageOpenedComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetHabboClubExtendOfferMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.PurchaseVipMembershipExtensionComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.PurchaseBasicMembershipExtensionComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetHabboBasicMembershipExtendOfferComposer;
    import com.sulake.habbo.communication.messages.incoming.recycler.RecyclerPrizesMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.recycler.RecyclerStatusMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.recycler.RecyclerFinishedMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.recycler.GetRecyclerPrizesMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.recycler.GetRecyclerStatusMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.recycler.RecycleItemsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.advertisement.GetRoomAdMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.advertisement.GetInterstitialMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.advertisement.RoomAdMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.advertisement.InterstitialMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.tracking.LatencyPingRequestMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.tracking.LatencyPingReportMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.tracking.PerformanceLogMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.tracking.LagWarningReportMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.tracking.LatencyPingResponseMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.poll.VoteQuestionMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.poll.VoteResultMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.poll.VoteAnswerMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.poll.PollOfferEvent;
    import com.sulake.habbo.communication.messages.incoming.poll.PollContentsEvent;
    import com.sulake.habbo.communication.messages.incoming.poll.PollErrorEvent;
    import com.sulake.habbo.communication.messages.outgoing.poll.PollRejectComposer;
    import com.sulake.habbo.communication.messages.outgoing.poll.PollStartComposer;
    import com.sulake.habbo.communication.messages.outgoing.poll.PollAnswerComposer;
    import com.sulake.habbo.communication.messages.incoming.room.publicroom.ParkBusCannotEnterMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.publicroom.ParkBusDoorMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.publicroom.OpenLockerRoomMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.room.publicroom.ExitLockerRoomMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.publicroom.ChangeRoomMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.publicroom.TryBusMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.users.ApproveNameMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.users.ApproveNameMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.sound.GetSoundMachinePlayListMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.sound.GetNowPlayingMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.sound.GetSongInfoMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.sound.GetSoundSettingsComposer;
    import com.sulake.habbo.communication.messages.outgoing.sound.SetSoundSettingsComposer;
    import com.sulake.habbo.communication.messages.outgoing.sound.AddJukeboxDiskComposer;
    import com.sulake.habbo.communication.messages.outgoing.sound.RemoveJukeboxDiskComposer;
    import com.sulake.habbo.communication.messages.outgoing.sound.GetJukeboxPlayListMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.sound.GetUserSongDisksMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.sound.SoundSettingsEvent;
    import com.sulake.habbo.communication.messages.incoming.sound.TraxSongInfoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.sound.PlayListMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.sound.UserSongDisksInventoryMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.sound.JukeboxSongDisksMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.sound.PlayListSongAddedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.sound.NowPlayingMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.sound.JukeboxPlayListFullMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.avatar.GetWardrobeMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.avatar.SaveWardrobeOutfitMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.avatar.WardrobeMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.avatar.ChangeUserNameMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.avatar.CheckUserNameMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.avatar.ChangeUserNameResultMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.avatar.CheckUserNameResultMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.register.UpdateFigureDataMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateTriggerMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateActionMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateConditionMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.OpenMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.ApplySnapshotMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniTriggerEvent;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniActionEvent;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniConditionEvent;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.OpenEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.YouArePlayingGameMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.GamePlayerValueMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestCompletedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestCancelledMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.quest.GetQuestsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.quest.AcceptQuestMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.quest.RejectQuestMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.quest.OpenQuestTrackerMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.quest.StartCampaignMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.quest.FriendRequestQuestCompleteMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.facebook.FaceBookAuthenticateEvent;
    import com.sulake.habbo.communication.messages.incoming.facebook.FaceBookErrorEvent;
    import com.sulake.habbo.communication.messages.incoming.facebook.FaceBookAppRequestEvent;
    import com.sulake.habbo.communication.messages.outgoing.facebook.FaceBookIsLoggedOnMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.facebook.FaceBookIsLoggedOffMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.facebook.FaceBookInitiateAddFriendsMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.room.camera.CameraSnapshotMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.*;
    import com.sulake.habbo.communication.messages.incoming.navigator.*;
    import com.sulake.habbo.communication.messages.outgoing.navigator.*;
    import com.sulake.habbo.communication.messages.incoming.catalog.*;
    import com.sulake.habbo.communication.messages.incoming.moderation.*;
    import com.sulake.habbo.communication.messages.incoming.friendlist.*;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.*;
    import com.sulake.habbo.communication.messages.outgoing.users.*;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.*;
    import com.sulake.habbo.communication.messages.incoming.users.*;
    import com.sulake.habbo.communication.messages.outgoing.moderator.*;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.*;
    import com.sulake.habbo.communication.messages.outgoing.catalog.*;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.*;
    import com.sulake.habbo.communication.messages.incoming.handshake.*;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.*;
    import com.sulake.habbo.communication.messages.outgoing.handshake.*;
    import com.sulake.habbo.communication.messages.incoming.notifications.*;
    import com.sulake.habbo.communication.messages.incoming.help.*;
    import com.sulake.habbo.communication.messages.incoming.room.session.*;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.*;
    import com.sulake.habbo.communication.messages.outgoing.room.action.*;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.*;
    import default.*;
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.*;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.*;
    import com.sulake.habbo.communication.messages.incoming.room.action.*;
    import com.sulake.habbo.communication.messages.incoming.poll.*;
    import com.sulake.habbo.communication.messages.outgoing.room.avatar.*;
    import com.sulake.habbo.communication.messages.outgoing.room.chat.*;
    import com.sulake.habbo.communication.messages.outgoing.poll.*;
    import com.sulake.habbo.communication.messages.incoming.room.chat.*;
    import com.sulake.habbo.communication.messages.outgoing.room.session.*;
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.*;
    import com.sulake.habbo.communication.messages.outgoing.roomsettings.*;
    import com.sulake.habbo.communication.messages.outgoing.inventory.badges.*;
    import com.sulake.habbo.communication.messages.incoming.inventory.badges.*;
    import com.sulake.habbo.communication.messages.incoming.room.publicroom.*;
    import com.sulake.habbo.communication.messages.incoming.room.permissions.*;
    import com.sulake.habbo.communication.messages.outgoing.room.publicroom.*;
    import com.sulake.habbo.communication.messages.incoming.error.*;
    import com.sulake.habbo.communication.messages.outgoing.inventory.furni.*;
    import com.sulake.habbo.communication.messages.outgoing.inventory.avatareffect.*;
    import com.sulake.habbo.communication.messages.outgoing.inventory.achievements.*;
    import com.sulake.habbo.communication.messages.outgoing.inventory.purse.*;
    import com.sulake.habbo.communication.messages.incoming.inventory.purse.*;

    public class HabboMessages implements IMessageConfiguration 
    {

        private static const _events:Map = new Map(true);
        private static const _SafeStr_10812:Map = new Map(true);

        {
            _events[1] = SecretKeyEvent;
            _events[277] = InitCryptoMessageEvent;
            _events[0x0101] = SessionParamsMessageEvent;
            _events[2] = UserRightsMessageEvent;
            _events[3] = AuthenticationOKMessageEvent;
            _events[50] = PingMessageEvent;
            _events[5] = UserObjectEvent;
            _events[439] = UniqueMachineIDEvent;
            _events[33] = GenericErrorEvent;
            _events[287] = DisconnectReasonEvent;
            _events[626] = IdentityAccountsEvent;
            _SafeStr_10812[206] = InitCryptoMessageComposer;
            _SafeStr_10812[2002] = GenerateSecretKeyMessageComposer;
            _SafeStr_10812[1170] = VersionCheckMessageComposer;
            _SafeStr_10812[813] = UniqueIDMessageComposer;
            _SafeStr_10812[1817] = GetSessionParametersMessageComposer;
            _SafeStr_10812[4011] = SSOTicketMessageComposer;
            _SafeStr_10812[756] = TryLoginMessageComposer;
            _SafeStr_10812[196] = PongMessageComposer;
            _SafeStr_10812[48] = InfoRetrieveMessageComposer;
            _SafeStr_10812[0x0200] = DisconnectMessageComposer;
            _events[290] = AvailabilityStatusMessageEvent;
            _events[291] = InfoHotelClosingMessageEvent;
            _events[292] = InfoHotelClosedMessageEvent;
            _events[293] = AvailabilityTimeMessageEvent;
            _events[294] = LoginFailedHotelClosedMessageEvent;
            _events[12] = MessengerInitEvent;
            _events[132] = NewBuddyRequestEvent;
            _events[134] = NewConsoleMessageEvent;
            _events[260] = MessengerErrorEvent;
            _events[261] = InstantMessageErrorEvent;
            _events[314] = BuddyRequestsEvent;
            _events[315] = AcceptBuddyResultEvent;
            _events[13] = FriendListUpdateEvent;
            _events[435] = HabboSearchResultEvent;
            _events[349] = FollowFriendFailedEvent;
            _events[262] = RoomInviteErrorEvent;
            _events[135] = RoomInviteEvent;
            _events[831] = FindFriendsProcessResultEvent;
            _events[833] = FriendNotificationEvent;
            _events[950] = EventStreamEvent;
            _SafeStr_10812[12] = MessengerInitMessageComposer;
            _SafeStr_10812[15] = FriendListUpdateMessageComposer;
            _SafeStr_10812[33] = SendMsgMessageComposer;
            _SafeStr_10812[37] = AcceptBuddyMessageComposer;
            _SafeStr_10812[38] = DeclineBuddyMessageComposer;
            _SafeStr_10812[39] = RequestBuddyMessageComposer;
            _SafeStr_10812[40] = RemoveBuddyMessageComposer;
            _SafeStr_10812[41] = HabboSearchMessageComposer;
            _SafeStr_10812[233] = GetBuddyRequestsMessageComposer;
            _SafeStr_10812[262] = FollowFriendMessageComposer;
            _SafeStr_10812[34] = SendRoomInviteMessageComposer;
            _SafeStr_10812[490] = FindNewFriendsMessageComposer;
            _SafeStr_10812[500] = GetEventStreamComposer;
            _SafeStr_10812[501] = SetEventStreamingAllowedComposer;
            _SafeStr_10812[502] = LikeStreamEventMessageComposer;
            _events[6] = CreditBalanceEvent;
            _SafeStr_10812[8] = GetCreditsInfoComposer;
            _events[98] = FurniListInsertEvent;
            _events[99] = FurniListRemoveEvent;
            _events[101] = FurniListUpdateEvent;
            _events[140] = FurniListEvent;
            _events[145] = PostItPlacedEvent;
            _SafeStr_10812[66] = RequestRoomPropertySet;
            _SafeStr_10812[404] = RequestFurniInventoryComposer;
            _events[460] = AvatarEffectsMessageEvent;
            _events[461] = AvatarEffectAddedMessageEvent;
            _events[462] = AvatarEffectActivatedMessageEvent;
            _events[463] = AvatarEffectExpiredMessageEvent;
            _events[464] = AvatarEffectSelectedMessageEvent;
            _SafeStr_10812[372] = AvatarEffectSelectedComposer;
            _SafeStr_10812[373] = AvatarEffectActivatedComposer;
            _events[229] = BadgesEvent;
            _SafeStr_10812[157] = GetBadgesComposer;
            _SafeStr_10812[158] = SetActivatedBadgesComposer;
            _SafeStr_10812[3032] = GetBadgePointLimitsComposer;
            _events[627] = BadgePointLimitsEvent;
            _events[436] = AchievementsEvent;
            _events[443] = AchievementsScoreEvent;
            _events[913] = AchievementEvent;
            _SafeStr_10812[370] = GetAchievementsComposer;
            _events[102] = TradingYouAreNotAllowedEvent;
            _events[103] = TradingOtherNotAllowedEvent;
            _events[104] = TradingOpenEvent;
            _events[105] = TradingAlreadyOpenEvent;
            _events[106] = TradingNotOpenEvent;
            _events[107] = TradingNoSuchItemEvent;
            _events[108] = TradingItemListEvent;
            _events[109] = TradingAcceptEvent;
            _events[110] = TradingCloseEvent;
            _events[111] = TradingConfirmationEvent;
            _events[112] = TradingCompletedEvent;
            _SafeStr_10812[68] = UnacceptTradingComposer;
            _SafeStr_10812[69] = AcceptTradingComposer;
            _SafeStr_10812[70] = CloseTradingComposer;
            _SafeStr_10812[71] = OpenTradingComposer;
            _SafeStr_10812[72] = AddItemToTradeComposer;
            _SafeStr_10812[402] = ConfirmAcceptTradingComposer;
            _SafeStr_10812[403] = ConfirmDeclineTradingComposer;
            _SafeStr_10812[405] = RemoveItemFromTradeComposer;
            _events[600] = PetInventoryEvent;
            _events[603] = PetAddedToInventoryEvent;
            _events[604] = PetRemovedFromInventoryEvent;
            _events[607] = PetReceivedMessageEvent;
            _SafeStr_10812[3000] = GetPetInventoryComposer;
            _events[610] = MarketplaceMakeOfferResult;
            _events[611] = MarketplaceCanMakeOfferResult;
            _events[612] = MarketplaceConfigurationEvent;
            _events[613] = MarketplaceBuyOfferResultEvent;
            _events[614] = MarketplaceCancelOfferResultEvent;
            _events[615] = MarketPlaceOffersEvent;
            _events[616] = MarketPlaceOwnOffersEvent;
            _events[617] = MarketplaceItemStatsEvent;
            _SafeStr_10812[3010] = MakeOfferMessageComposer;
            _SafeStr_10812[3011] = GetMarketplaceConfigurationMessageComposer;
            _SafeStr_10812[3012] = GetMarketplaceCanMakeOfferComposer;
            _SafeStr_10812[3013] = BuyMarketplaceTokensMessageComposer;
            _SafeStr_10812[3014] = BuyOfferMessageComposer;
            _SafeStr_10812[3015] = CancelOfferMessageComposer;
            _SafeStr_10812[3016] = RedeemOfferCreditsMessageComposer;
            _SafeStr_10812[3018] = GetOffersMessageComposer;
            _SafeStr_10812[3019] = GetOwnOffersMessageComposer;
            _SafeStr_10812[3020] = GetMarketplaceItemStatsComposer;
            _events[221] = UserFlatCatsEvent;
            _events[222] = FlatCatEvent;
            _events[367] = CanCreateRoomEventEvent;
            _events[370] = RoomEventEvent;
            _SafeStr_10812[20] = DeleteFavouriteRoomMessageComposer;
            _SafeStr_10812[19] = AddFavouriteRoomMessageComposer;
            _SafeStr_10812[151] = GetUserFlatCatsMessageComposer;
            _SafeStr_10812[345] = CanCreateEventMessageComposer;
            _SafeStr_10812[346] = CreateEventMessageComposer;
            _SafeStr_10812[347] = CancelEventMessageComposer;
            _SafeStr_10812[348] = EditEventMessageComposer;
            _events[91] = DoorbellMessageEvent;
            _events[131] = FlatAccessDeniedMessageEvent;
            _events[465] = RoomSettingsDataEvent;
            _events[466] = RoomSettingsErrorEvent;
            _events[467] = RoomSettingsSavedEvent;
            _events[468] = RoomSettingsSaveErrorEvent;
            _events[44] = NoSuchFlatEvent;
            _SafeStr_10812[400] = GetRoomSettingsMessageComposer;
            _SafeStr_10812[401] = SaveRoomSettingsMessageComposer;
            _SafeStr_10812[23] = DeleteRoomMessageComposer;
            _events[450] = OfficialRoomsEvent;
            _events[451] = GuestRoomSearchResultEvent;
            _events[452] = PopularRoomTagsResultEvent;
            _events[453] = PublicSpaceCastLibsEvent;
            _events[454] = GetGuestRoomResultEvent;
            _events[455] = NavigatorSettingsEvent;
            _events[456] = RoomInfoUpdatedEvent;
            _events[457] = RoomThumbnailUpdateResultEvent;
            _events[458] = FavouritesEvent;
            _events[459] = FavouriteChangedEvent;
            _events[59] = FlatCreatedEvent;
            _events[345] = RoomRatingEvent;
            _events[510] = FlatControllerAddedEvent;
            _events[511] = FlatControllerRemovedEvent;
            _events[0x0200] = CanCreateRoomEvent;
            _SafeStr_10812[380] = GetOfficialRoomsMessageComposer;
            _SafeStr_10812[382] = GetPopularRoomTagsMessageComposer;
            _SafeStr_10812[384] = UpdateNavigatorSettingsMessageComposer;
            _SafeStr_10812[385] = GetGuestRoomMessageComposer;
            _SafeStr_10812[386] = UpdateRoomThumbnailMessageComposer;
            _SafeStr_10812[387] = CanCreateRoomMessageComposer;
            _SafeStr_10812[29] = CreateFlatMessageComposer;
            _SafeStr_10812[261] = RateFlatMessageComposer;
            _SafeStr_10812[388] = GetPublicSpaceCastLibsMessageComposer;
            _SafeStr_10812[430] = PopularRoomsSearchMessageComposer;
            _SafeStr_10812[431] = RoomsWithHighestScoreSearchMessageComposer;
            _SafeStr_10812[432] = MyFriendsRoomsSearchMessageComposer;
            _SafeStr_10812[433] = RoomsWhereMyFriendsAreSearchMessageComposer;
            _SafeStr_10812[434] = MyRoomsSearchMessageComposer;
            _SafeStr_10812[435] = MyFavouriteRoomsSearchMessageComposer;
            _SafeStr_10812[436] = MyRoomHistorySearchMessageComposer;
            _SafeStr_10812[437] = RoomTextSearchMessageComposer;
            _SafeStr_10812[438] = RoomTagSearchMessageComposer;
            _SafeStr_10812[439] = LatestEventsSearchMessageComposer;
            _SafeStr_10812[483] = ToggleStaffPickMessageComposer;
            _events[18] = CloseConnectionMessageEvent;
            _events[19] = OpenConnectionMessageEvent;
            _events[259] = RoomQueueStatusMessageEvent;
            _events[286] = RoomForwardMessageEvent;
            _events[24] = ChatMessageEvent;
            _events[25] = WhisperMessageEvent;
            _events[26] = ShoutMessageEvent;
            _events[361] = UserTypingMessageEvent;
            _events[27] = FloodControlMessageEvent;
            _events[41] = FlatAccessibleMessageEvent;
            _events[69] = RoomReadyMessageEvent;
            _events[28] = UsersMessageEvent;
            _events[29] = UserRemoveMessageEvent;
            _events[31] = HeightMapMessageEvent;
            _events[32] = ObjectsMessageEvent;
            _events[34] = UserUpdateMessageEvent;
            _events[45] = ItemsMessageEvent;
            _events[48] = ItemDataUpdateMessageEvent;
            _events[83] = ItemAddMessageEvent;
            _events[84] = ItemRemoveMessageEvent;
            _events[85] = ItemUpdateMessageEvent;
            _events[93] = ObjectAddMessageEvent;
            _events[805] = ViralTeaserActiveMessageEvent;
            _events[88] = ObjectDataUpdateMessageEvent;
            _events[94] = ObjectRemoveMessageEvent;
            _events[95] = ObjectUpdateMessageEvent;
            _events[210] = PetInfoMessageEvent;
            _events[219] = HeightMapUpdateMessageEvent;
            _events[230] = SlideObjectBundleMessageEvent;
            _events[254] = YouAreSpectatorMessageEvent;
            _events[266] = UserChangeMessageEvent;
            _events[365] = RoomDimmerPresetsMessageEvent;
            _events[470] = FloorHeightMapMessageEvent;
            _events[471] = RoomEntryInfoMessageEvent;
            _events[472] = RoomVisualizationSettingsEvent;
            _events[473] = ObjectsDataUpdateMessageEvent;
            _events[516] = PlaceObjectErrorMessageEvent;
            _events[572] = UserNameChangedMessageEvent;
            _events[806] = ViralFurniGiftReceivedEvent;
            _events[807] = ViralFurniStatusEvent;
            _events[808] = UserNotificationMessageEvent;
            _events[829] = WelcomeGiftStatusEvent;
            _events[297] = FurnitureAliasesMessageEvent;
            _events[46] = RoomPropertyMessageEvent;
            _events[42] = YouAreControllerMessageEvent;
            _events[43] = YouAreNotControllerMessageEvent;
            _events[47] = YouAreOwnerMessageEvent;
            _events[911] = RequestSpamWallPostItMessageEvent;
            _events[912] = RoomMessageNotificationMessageEvent;
            _events[224] = CantConnectMessageEvent;
            _events[601] = PetInfoMessageEvent;
            _events[605] = PetCommandsMessageEvent;
            _events[608] = PetPlacingErrorEvent;
            _events[609] = PetExperienceEvent;
            _events[621] = PetRespectFailedEvent;
            _SafeStr_10812[3004] = GetPetCommandsMessageComposer;
            _SafeStr_10812[2] = OpenConnectionMessageComposer;
            _SafeStr_10812[391] = OpenFlatConnectionMessageComposer;
            _SafeStr_10812[52] = ChatMessageComposer;
            _SafeStr_10812[55] = ShoutMessageComposer;
            _SafeStr_10812[56] = WhisperMessageComposer;
            _SafeStr_10812[317] = StartTypingMessageComposer;
            _SafeStr_10812[318] = CancelTypingMessageComposer;
            _SafeStr_10812[104] = SignMessageComposer;
            _SafeStr_10812[484] = ChangeMottoMessageComposer;
            _SafeStr_10812[59] = GoToFlatMessageComposer;
            _SafeStr_10812[390] = GetRoomEntryDataMessageComposer;
            _SafeStr_10812[392] = UseFurnitureMessageComposer;
            _SafeStr_10812[67] = PickupObjectMessageComposer;
            _SafeStr_10812[73] = MoveObjectMessageComposer;
            _SafeStr_10812[74] = SetObjectDataMessageComposer;
            _SafeStr_10812[75] = MoveAvatarMessageComposer;
            _SafeStr_10812[90] = PlaceObjectMessageComposer;
            _SafeStr_10812[91] = MoveWallItemMessageComposer;
            _SafeStr_10812[3002] = PlacePetMessageComposer;
            _SafeStr_10812[3003] = RemovePetFromFlatMessageComposer;
            _SafeStr_10812[3103] = ViralTeaserFoundMessageComposer;
            _SafeStr_10812[3110] = GetMOTDMessageComposer;
            _SafeStr_10812[3105] = GetUserNotificationsMessageComposer;
            _SafeStr_10812[211] = ChangeQueueMessageComposer;
            _SafeStr_10812[341] = RoomDimmerGetPresetsMessageComposer;
            _SafeStr_10812[342] = RoomDimmerSavePresetMessageComposer;
            _SafeStr_10812[343] = RoomDimmerChangeStateMessageComposer;
            _SafeStr_10812[393] = UseWallItemMessageComposer;
            _SafeStr_10812[83] = GetItemDataMessageComposer;
            _SafeStr_10812[84] = SetItemDataMessageComposer;
            _SafeStr_10812[85] = RemoveItemMessageComposer;
            _SafeStr_10812[3104] = ViralFurniStatusMessageComposer;
            _SafeStr_10812[3001] = GetPetInfoMessageComposer;
            _SafeStr_10812[215] = GetFurnitureAliasesMessageComposer;
            _SafeStr_10812[53] = QuitMessageComposer;
            _SafeStr_10812[3254] = PlacePostItMessageComposer;
            _SafeStr_10812[3255] = AddSpamWallPostItMessageComposer;
            _events[480] = DanceMessageEvent;
            _events[481] = WaveMessageEvent;
            _events[482] = CarryObjectMessageEvent;
            _events[485] = AvatarEffectMessageEvent;
            _events[486] = SleepMessageEvent;
            _events[488] = UseObjectMessageEvent;
            _SafeStr_10812[93] = DanceMessageComposer;
            _SafeStr_10812[94] = WaveMessageComposer;
            _SafeStr_10812[79] = LookToMessageComposer;
            _events[90] = DiceValueMessageEvent;
            _events[129] = PresentOpenedMessageEvent;
            _events[825] = OpenPetPackageRequestedMessageEvent;
            _events[826] = OpenPetPackageResultMessageEvent;
            _events[312] = OneWayDoorStatusMessageEvent;
            _events[30] = PublicRoomObjectsMessageEvent;
            _SafeStr_10812[76] = ThrowDiceMessageComposer;
            _SafeStr_10812[77] = DiceOffMessageComposer;
            _SafeStr_10812[78] = PresentOpenMessageComposer;
            _SafeStr_10812[183] = CreditFurniRedeemMessageComposer;
            _SafeStr_10812[232] = EnterOneWayDoorMessageComposer;
            _SafeStr_10812[247] = SpinWheelOfFortuneMessageComposer;
            _SafeStr_10812[314] = SetRandomStateMessageComposer;
            _SafeStr_10812[480] = SetClothingChangeDataMessageComposer;
            _SafeStr_10812[3100] = QuestVendingWallItemMessageComposer;
            _SafeStr_10812[3006] = OpenPetPackageMessageComposer;
            _SafeStr_10812[3252] = OpenWelcomeGiftComposer;
            _events[63] = DoorOtherEndDeletedMessageEvent;
            _events[64] = DoorNotInstalledMessageEvent;
            _SafeStr_10812[95] = KickUserMessageComposer;
            _SafeStr_10812[96] = AssignRightsMessageComposer;
            _SafeStr_10812[97] = RemoveRightsMessageComposer;
            _SafeStr_10812[98] = LetUserInMessageComposer;
            _SafeStr_10812[155] = RemoveAllRightsMessageComposer;
            _SafeStr_10812[320] = BanUserMessageComposer;
            _SafeStr_10812[440] = CallGuideBotMessageComposer;
            _SafeStr_10812[441] = KickBotMessageComposer;
            _events[350] = UserTagsMessageEvent;
            _SafeStr_10812[263] = GetUserTagsMessageComposer;
            _SafeStr_10812[159] = GetSelectedBadgesMessageComposer;
            _SafeStr_10812[230] = GetHabboGroupBadgesMessageComposer;
            _SafeStr_10812[231] = GetHabboGroupDetailsMessageComposer;
            _SafeStr_10812[3257] = JoinHabboGroupMessageComposer;
            _SafeStr_10812[3258] = SelectFavouriteHabboGroupMessageComposer;
            _SafeStr_10812[3259] = DeselectFavouriteHabboGroupMessageComposer;
            _SafeStr_10812[3260] = GetHabboGroupsWhereMemberMessageComposer;
            _events[228] = HabboUserBadgesMessageEvent;
            _events[309] = HabboGroupBadgesMessageEvent;
            _events[310] = FavoriteMembershipUpdateMessageEvent;
            _events[311] = HabboGroupDetailsMessageEvent;
            _events[915] = HabboGroupsWhereMemberMessageEvent;
            _events[916] = HabboGroupJoinFailedMessageEvent;
            _SafeStr_10812[319] = IgnoreUserMessageComposer;
            _SafeStr_10812[321] = GetIgnoredUsersMessageComposer;
            _SafeStr_10812[322] = UnignoreUserMessageComposer;
            _events[419] = IgnoreResultMessageEvent;
            _events[420] = IgnoredUsersMessageEvent;
            _events[440] = RespectNotificationMessageEvent;
            _events[606] = PetRespectNotificationEvent;
            _SafeStr_10812[371] = RespectUserMessageComposer;
            _SafeStr_10812[3005] = RespectPetMessageComposer;
            _events[35] = UserBannedMessageEvent;
            _events[161] = ModMessageEvent;
            _events[273] = IssueDeletedMessageEvent;
            _events[530] = IssueInfoMessageEvent;
            _events[531] = ModeratorInitMessageEvent;
            _events[532] = IssuePickFailedMessageEvent;
            _events[533] = ModeratorUserInfoEvent;
            _events[534] = CfhChatlogEvent;
            _events[535] = RoomChatlogEvent;
            _events[536] = UserChatlogEvent;
            _events[537] = RoomVisitsEvent;
            _events[538] = ModeratorRoomInfoEvent;
            _events[539] = ModeratorActionResultMessageEvent;
            _SafeStr_10812[450] = PickIssuesMessageComposer;
            _SafeStr_10812[451] = ReleaseIssuesMessageComposer;
            _SafeStr_10812[452] = CloseIssuesMessageComposer;
            _SafeStr_10812[454] = GetModeratorUserInfoMessageComposer;
            _SafeStr_10812[455] = GetUserChatlogMessageComposer;
            _SafeStr_10812[456] = GetRoomChatlogMessageComposer;
            _SafeStr_10812[457] = GetCfhChatlogMessageComposer;
            _SafeStr_10812[458] = GetRoomVisitsMessageComposer;
            _SafeStr_10812[459] = GetModeratorRoomInfoMessageComposer;
            _SafeStr_10812[460] = ModerateRoomMessageComposer;
            _SafeStr_10812[461] = ModAlertMessageComposer;
            _SafeStr_10812[462] = ModMessageMessageComposer;
            _SafeStr_10812[463] = ModKickMessageComposer;
            _SafeStr_10812[464] = ModBanMessageComposer;
            _SafeStr_10812[200] = ModeratorActionMessageComposer;
            _SafeStr_10812[453] = CallForHelpMessageComposer;
            _SafeStr_10812[237] = GetPendingCallsForHelpMessageComposer;
            _SafeStr_10812[238] = DeletePendingCallsForHelpMessageComposer;
            _SafeStr_10812[416] = GetClientFaqsMessageComposer;
            _SafeStr_10812[417] = GetFaqCategoriesMessageComposer;
            _SafeStr_10812[418] = GetFaqTextMessageComposer;
            _SafeStr_10812[419] = SearchFaqsMessageComposer;
            _SafeStr_10812[420] = GetFaqCategoryMessageComposer;
            _events[274] = CallForHelpReplyMessageEvent;
            _events[319] = CallForHelpPendingCallsMessageEvent;
            _events[320] = CallForHelpPendingCallsDeletedMessageEvent;
            _events[321] = CallForHelpResultMessageEvent;
            _events[518] = FaqClientFaqsMessageEvent;
            _events[519] = FaqCategoriesMessageEvent;
            _events[520] = FaqTextMessageEvent;
            _events[521] = FaqSearchResultsMessageEvent;
            _events[522] = FaqCategoryMessageEvent;
            _events[540] = IssueCloseNotificationMessageEvent;
            _events[575] = TutorialStatusMessageEvent;
            _events[573] = HotelMergeNameChangeEvent;
            _events[299] = ErrorReportEvent;
            _events[830] = ChangeEmailResultEvent;
            _SafeStr_10812[3253] = ChangeEmailComposer;
            _events[7] = ScrSendUserInfoEvent;
            _SafeStr_10812[26] = ScrGetUserInfoMessageComposer;
            _events[139] = HabboBroadcastMessageEvent;
            _events[280] = ClubGiftNotificationEvent;
            _events[437] = HabboAchievementNotificationMessageEvent;
            _events[445] = HabboAchievementBonusMessageEvent;
            _events[444] = HabboAchievementShareIdMessageEvent;
            _events[438] = HabboActivityPointNotificationMessageEvent;
            _events[628] = ActivityPointsMessageEvent;
            _events[517] = InfoFeedEnableMessageEvent;
            _events[602] = PetLevelNotificationEvent;
            _events[810] = MOTDNotificationEvent;
            _SafeStr_10812[481] = GetAchievementShareIdComposer;
            _events[832] = UnseenItemsEvent;
            _SafeStr_10812[3111] = ResetUnseenItemsComposer;
            _events[126] = CatalogIndexMessageEvent;
            _events[127] = CatalogPageMessageEvent;
            _events[65] = PurchaseErrorMessageEvent;
            _events[67] = PurchaseOKMessageEvent;
            _events[68] = NotEnoughBalanceMessageEvent;
            _events[76] = GiftReceiverNotFoundEvent;
            _events[296] = PurchaseNotAllowedMessageEvent;
            _events[441] = CatalogPublishedMessageEvent;
            _events[212] = VoucherRedeemOkMessageEvent;
            _events[213] = VoucherRedeemErrorMessageEvent;
            _events[620] = GiftWrappingConfigurationEvent;
            _events[622] = IsOfferGiftableMessageEvent;
            _events[623] = ClubGiftInfoEvent;
            _events[624] = ClubGiftSelectedEvent;
            _events[625] = HabboClubOffersMessageEvent;
            _events[629] = ChargeInfoMessageEvent;
            _events[827] = SellablePetBreedsMessageEvent;
            _events[630] = HabboClubExtendOfferMessageEvent;
            _SafeStr_10812[100] = PurchaseFromCatalogComposer;
            _SafeStr_10812[472] = PurchaseFromCatalogAsGiftComposer;
            _SafeStr_10812[473] = GetGiftWrappingConfigurationComposer;
            _SafeStr_10812[474] = GetClubGiftInfo;
            _SafeStr_10812[475] = SelectClubGiftComposer;
            _SafeStr_10812[101] = GetCatalogIndexComposer;
            _SafeStr_10812[102] = GetCatalogPageComposer;
            _SafeStr_10812[129] = RedeemVoucherMessageComposer;
            _SafeStr_10812[3030] = GetIsOfferGiftableComposer;
            _SafeStr_10812[3031] = GetClubOffersMessageComposer;
            _SafeStr_10812[3007] = GetSellablePetBreedsComposer;
            _SafeStr_10812[3034] = MarkCatalogNewAdditionsPageOpenedComposer;
            _SafeStr_10812[3035] = GetHabboClubExtendOfferMessageComposer;
            _SafeStr_10812[3036] = PurchaseVipMembershipExtensionComposer;
            _SafeStr_10812[3037] = PurchaseBasicMembershipExtensionComposer;
            _SafeStr_10812[3038] = GetHabboBasicMembershipExtendOfferComposer;
            _events[506] = RecyclerPrizesMessageEvent;
            _events[507] = RecyclerStatusMessageEvent;
            _events[508] = RecyclerFinishedMessageEvent;
            _SafeStr_10812[412] = GetRecyclerPrizesMessageComposer;
            _SafeStr_10812[413] = GetRecyclerStatusMessageComposer;
            _SafeStr_10812[414] = RecycleItemsMessageComposer;
            _SafeStr_10812[126] = GetRoomAdMessageComposer;
            _SafeStr_10812[182] = GetInterstitialMessageComposer;
            _events[208] = RoomAdMessageEvent;
            _events[258] = InterstitialMessageEvent;
            _SafeStr_10812[315] = LatencyPingRequestMessageComposer;
            _SafeStr_10812[316] = LatencyPingReportMessageComposer;
            _SafeStr_10812[421] = PerformanceLogMessageComposer;
            _SafeStr_10812[422] = LagWarningReportMessageComposer;
            _SafeStr_10812[482] = EventLogMessageComposer;
            _events[354] = LatencyPingResponseMessageEvent;
            _events[79] = VoteQuestionMessageEvent;
            _events[80] = VoteResultMessageEvent;
            _SafeStr_10812[112] = VoteAnswerMessageComposer;
            _events[316] = PollOfferEvent;
            _events[317] = PollContentsEvent;
            _events[318] = PollErrorEvent;
            _SafeStr_10812[235] = PollRejectComposer;
            _SafeStr_10812[234] = PollStartComposer;
            _SafeStr_10812[236] = PollAnswerComposer;
            _events[81] = ParkBusCannotEnterMessageEvent;
            _events[503] = ParkBusDoorMessageEvent;
            _events[96] = OpenLockerRoomMessageEvent;
            _SafeStr_10812[108] = ExitLockerRoomMessageComposer;
            _SafeStr_10812[111] = ChangeRoomMessageComposer;
            _SafeStr_10812[113] = TryBusMessageComposer;
            _events[36] = ApproveNameMessageEvent;
            _SafeStr_10812[42] = ApproveNameMessageComposer;
            _SafeStr_10812[245] = GetSoundMachinePlayListMessageComposer;
            _SafeStr_10812[249] = GetNowPlayingMessageComposer;
            _SafeStr_10812[221] = GetSongInfoMessageComposer;
            _SafeStr_10812[228] = GetSoundSettingsComposer;
            _SafeStr_10812[229] = SetSoundSettingsComposer;
            _SafeStr_10812[0xFF] = AddJukeboxDiskComposer;
            _SafeStr_10812[0x0100] = RemoveJukeboxDiskComposer;
            _SafeStr_10812[258] = GetJukeboxPlayListMessageComposer;
            _SafeStr_10812[259] = GetUserSongDisksMessageComposer;
            _events[308] = SoundSettingsEvent;
            _events[300] = TraxSongInfoMessageEvent;
            _events[323] = PlayListMessageEvent;
            _events[333] = UserSongDisksInventoryMessageEvent;
            _events[334] = JukeboxSongDisksMessageEvent;
            _events[335] = PlayListSongAddedMessageEvent;
            _events[327] = NowPlayingMessageEvent;
            _events[337] = JukeboxPlayListFullMessageEvent;
            _SafeStr_10812[375] = GetWardrobeMessageComposer;
            _SafeStr_10812[376] = SaveWardrobeOutfitMessageComposer;
            _events[267] = WardrobeMessageEvent;
            _SafeStr_10812[470] = ChangeUserNameMessageComposer;
            _SafeStr_10812[471] = CheckUserNameMessageComposer;
            _events[570] = ChangeUserNameResultMessageEvent;
            _events[571] = CheckUserNameResultMessageEvent;
            _SafeStr_10812[44] = UpdateFigureDataMessageComposer;
            _SafeStr_10812[3050] = UpdateTriggerMessageComposer;
            _SafeStr_10812[3051] = UpdateActionMessageComposer;
            _SafeStr_10812[3052] = UpdateConditionMessageComposer;
            _SafeStr_10812[3053] = OpenMessageComposer;
            _SafeStr_10812[3054] = ApplySnapshotMessageComposer;
            _events[650] = WiredFurniTriggerEvent;
            _events[651] = WiredFurniActionEvent;
            _events[652] = WiredFurniConditionEvent;
            _events[653] = OpenEvent;
            _events[700] = YouArePlayingGameMessageEvent;
            _events[701] = GamePlayerValueMessageEvent;
            _events[800] = QuestsMessageEvent;
            _events[801] = QuestCompletedMessageEvent;
            _events[802] = QuestMessageEvent;
            _events[803] = QuestCancelledMessageEvent;
            _SafeStr_10812[3101] = GetQuestsMessageComposer;
            _SafeStr_10812[3102] = AcceptQuestMessageComposer;
            _SafeStr_10812[3106] = RejectQuestMessageComposer;
            _SafeStr_10812[3107] = OpenQuestTrackerMessageComposer;
            _SafeStr_10812[3108] = StartCampaignMessageComposer;
            _SafeStr_10812[3210] = FriendRequestQuestCompleteMessageComposer;
            _events[901] = FaceBookAuthenticateEvent;
            _events[902] = FaceBookErrorEvent;
            _events[910] = FaceBookAppRequestEvent;
            _SafeStr_10812[3300] = FaceBookIsLoggedOnMessageComposer;
            _SafeStr_10812[3301] = FaceBookIsLoggedOffMessageComposer;
            _SafeStr_10812[3311] = FaceBookInitiateAddFriendsMessageComposer;
            _events[1000] = CameraSnapshotMessageEvent;
        }
        public function get composersMapId():int
        {
            return (0);
        }
        public function get events():Map
        {
            return (_events);
        }
        public function get composers():Map
        {
            return (_SafeStr_10812);
        }

    }
}//package com.sulake.habbo.communication

// _SafeStr_10812 = "_-1kR" (String#18306, DoABC#2)
// composersMapId = "_-2V4" (String#20241, DoABC#2)
// InfoHotelClosedMessageEvent = "_-0it" (String#15786, DoABC#2)
// RecyclerFinishedMessageEvent = "_-Iu" (String#22964, DoABC#2)
// PurchaseOKMessageEvent = "_-38y" (String#21841, DoABC#2)
// ClubGiftNotificationEvent = "_-26N" (String#19269, DoABC#2)
// RoomMessageNotificationMessageEvent = "_-0eE" (String#15596, DoABC#2)
// MOTDNotificationEvent = "_-2qQ" (String#21099, DoABC#2)
// ModMessageEvent = "_-2Uh" (String#20226, DoABC#2)
// HabboBroadcastMessageEvent = "_-0xg" (String#16340, DoABC#2)
// HabboAchievementBonusMessageEvent = "_-2wf" (String#21333, DoABC#2)
// PetLevelNotificationEvent = "_-3HY" (String#22182, DoABC#2)
// ScrSendUserInfoEvent = "_-202" (String#6048, DoABC#2)
// GetMOTDMessageComposer = "_-dZ" (String#23784, DoABC#2)
// PetReceivedMessageEvent = "_-Cf" (String#22711, DoABC#2)
// UserBannedMessageEvent = "_-uX" (String#24472, DoABC#2)
// LoginFailedHotelClosedMessageEvent = "_-lF" (String#24079, DoABC#2)
// InfoFeedEnableMessageEvent = "_-2wz" (String#21347, DoABC#2)
// ClubGiftSelectedEvent = "_-1am" (String#17925, DoABC#2)
// ParkBusCannotEnterMessageEvent = "_-2yf" (String#21416, DoABC#2)
// InfoHotelClosingMessageEvent = "_-0eA" (String#15593, DoABC#2)
// PetRespectFailedEvent = "_-1Pw" (String#17506, DoABC#2)
// RespectNotificationMessageEvent = "_-0xG" (String#16323, DoABC#2)
// VoucherRedeemOkMessageEvent = "_-2Af" (String#19432, DoABC#2)
// GetGiftWrappingConfigurationComposer = "_-1KN" (String#17289, DoABC#2)
// BuyOfferMessageComposer = "_-wh" (String#24558, DoABC#2)
// MarketplaceBuyOfferResultEvent = "_-0Q7" (String#15066, DoABC#2)
// MarketplaceMakeOfferResult = "_-0tP" (String#4715, DoABC#2)
// VoucherRedeemErrorMessageEvent = "_-2Yt" (String#20390, DoABC#2)
// NotEnoughBalanceMessageEvent = "_-2Ju" (String#6437, DoABC#2)
// PurchaseFromCatalogComposer = "_-1Vz" (String#17741, DoABC#2)
// RecyclerStatusMessageEvent = "_-8f" (String#22567, DoABC#2)
// CancelOfferMessageComposer = "_-0zq" (String#16420, DoABC#2)
// RecycleItemsMessageComposer = "_-24X" (String#19202, DoABC#2)
// ApproveNameMessageComposer = "_-2IA" (String#19733, DoABC#2)
// RedeemOfferCreditsMessageComposer = "_-3EZ" (String#22058, DoABC#2)
// ClubGiftInfoEvent = "_-TI" (String#23377, DoABC#2)
// GiftWrappingConfigurationEvent = "_-1tN" (String#18692, DoABC#2)
// GetOffersMessageComposer = "_-1rt" (String#18626, DoABC#2)
// GetIsOfferGiftableComposer = "_-16u" (String#16731, DoABC#2)
// IsOfferGiftableMessageEvent = "_-3Dt" (String#22029, DoABC#2)
// GetRecyclerPrizesMessageComposer = "_-1d9" (String#18019, DoABC#2)
// GetCatalogIndexComposer = "_-cD" (String#23723, DoABC#2)
// HabboClubOffersMessageEvent = "_-347" (String#21664, DoABC#2)
// MarketPlaceOffersEvent = "_-sl" (String#24391, DoABC#2)
// PurchaseBasicMembershipExtensionComposer = "_-3Hc" (String#22184, DoABC#2)
// CatalogPublishedMessageEvent = "_-2Om" (String#19995, DoABC#2)
// MarketPlaceOwnOffersEvent = "_-2c-" (String#20524, DoABC#2)
// CatalogPageMessageEvent = "_-31o" (String#21570, DoABC#2)
// MarketplaceCancelOfferResultEvent = "_-2jK" (String#20816, DoABC#2)
// RedeemVoucherMessageComposer = "_-0bE" (String#15486, DoABC#2)
// PurchaseVipMembershipExtensionComposer = "_-E5" (String#22775, DoABC#2)
// SellablePetBreedsMessageEvent = "_-07I" (String#14338, DoABC#2)
// GetClubOffersMessageComposer = "_-2Z2" (String#20398, DoABC#2)
// GetMarketplaceItemStatsComposer = "_-DI" (String#22741, DoABC#2)
// ChargeInfoMessageEvent = "_-1mO" (String#18395, DoABC#2)
// PurchaseErrorMessageEvent = "_-Gq" (String#22884, DoABC#2)
// GetSellablePetBreedsComposer = "_-2Jj" (String#19799, DoABC#2)
// GetCatalogPageComposer = "_-2oJ" (String#21015, DoABC#2)
// RecyclerPrizesMessageEvent = "_-095" (String#14412, DoABC#2)
// GetRecyclerStatusMessageComposer = "_-3JD" (String#22250, DoABC#2)
// GetHabboClubExtendOfferMessageComposer = "_-1U7" (String#17671, DoABC#2)
// CreditBalanceEvent = "_-lg" (String#24097, DoABC#2)
// PurchaseFromCatalogAsGiftComposer = "_-zC" (String#24659, DoABC#2)
// PlaceObjectMessageComposer = "_-1To" (String#17657, DoABC#2)
// MarketplaceConfigurationEvent = "_-2eI" (String#6839, DoABC#2)
// ApproveNameMessageEvent = "_-2DN" (String#19542, DoABC#2)
// ActivityPointsMessageEvent = "_-0Fl" (String#14673, DoABC#2)
// RequestRoomPropertySet = "_-6-" (String#22465, DoABC#2)
// MarketplaceItemStatsEvent = "_-2iN" (String#6918, DoABC#2)
// HabboClubExtendOfferMessageEvent = "_-2CH" (String#19495, DoABC#2)
// HabboActivityPointNotificationMessageEvent = "_-cn" (String#23745, DoABC#2)
// PurchaseNotAllowedMessageEvent = "_-2I7" (String#19731, DoABC#2)
// MarkCatalogNewAdditionsPageOpenedComposer = "_-1F4" (String#17074, DoABC#2)
// CatalogIndexMessageEvent = "_-Xi" (String#23550, DoABC#2)
// GetOwnOffersMessageComposer = "_-2-4" (String#18974, DoABC#2)
// SetSoundSettingsComposer = "_-0Vr" (String#15272, DoABC#2)
// GetSoundSettingsComposer = "_-2mn" (String#20953, DoABC#2)
// SoundSettingsEvent = "_-0Zh" (String#15431, DoABC#2)
// ScrGetUserInfoMessageComposer = "_-32k" (String#21608, DoABC#2)
// GetBadgePointLimitsComposer = "_-2-E" (String#18978, DoABC#2)
// GetCreditsInfoComposer = "_-1YL" (String#17828, DoABC#2)
// RoomInviteEvent = "_-38C" (String#7476, DoABC#2)
// InstantMessageErrorEvent = "_-3Eh" (String#22062, DoABC#2)
// MessengerInitEvent = "_-0pu" (String#4632, DoABC#2)
// IMessageConfiguration = "_-EK" (String#7959, DoABC#2)
// HabboMessages = "_-1Q" (String#5352, DoABC#2)
// DisconnectMessageComposer = "_-YP" (String#8381, DoABC#2)
// PerformanceLogMessageComposer = "_-2J" (String#6421, DoABC#2)
// LagWarningReportMessageComposer = "_-p1" (String#8691, DoABC#2)
// LatencyPingResponseMessageEvent = "_-0pM" (String#4621, DoABC#2)
// LatencyPingReportMessageComposer = "_-0Bk" (String#3790, DoABC#2)
// LatencyPingRequestMessageComposer = "_-2OZ" (String#6530, DoABC#2)
// GetInterstitialMessageComposer = "_-2gr" (String#20724, DoABC#2)
// RoomAdMessageEvent = "_-1vW" (String#18778, DoABC#2)
// GetRoomAdMessageComposer = "_-2H3" (String#19686, DoABC#2)
// InterstitialMessageEvent = "_-wD" (String#24539, DoABC#2)
// RespectPetMessageComposer = "_-13h" (String#16606, DoABC#2)
// UserRightsMessageEvent = "_-8n" (String#7837, DoABC#2)
// GetHabboGroupDetailsMessageComposer = "_-1BD" (String#16906, DoABC#2)
// RespectUserMessageComposer = "_-7y" (String#22542, DoABC#2)
// ChatMessageComposer = "_-Fl" (String#22841, DoABC#2)
// ChangeUserNameResultMessageEvent = "_-3HW" (String#22180, DoABC#2)
// UserChangeMessageEvent = "_-a9" (String#23638, DoABC#2)
// RoomReadyMessageEvent = "_-1uW" (String#5930, DoABC#2)
// UserNameChangedMessageEvent = "_-1J2" (String#17238, DoABC#2)
// UserObjectEvent = "_-1HL" (String#17163, DoABC#2)
// AvailabilityStatusMessageEvent = "_-09L" (String#14423, DoABC#2)
// SecretKeyEvent = "_-23F" (String#6110, DoABC#2)
// PongMessageComposer = "_-1H-" (String#5188, DoABC#2)
// UniqueMachineIDEvent = "_-0xp" (String#4804, DoABC#2)
// InfoRetrieveMessageComposer = "_-10H" (String#4876, DoABC#2)
// TryLoginMessageComposer = "_-1uh" (String#5932, DoABC#2)
// VersionCheckMessageComposer = "_-0ou" (String#4613, DoABC#2)
// SessionParamsMessageEvent = "_-J4" (String#8062, DoABC#2)
// GenericErrorEvent = "_-2X" (String#6699, DoABC#2)
// SSOTicketMessageComposer = "_-0cf" (String#4356, DoABC#2)
// PingMessageEvent = "_-0bC" (String#4327, DoABC#2)
// GetSessionParametersMessageComposer = "_-1Z7" (String#5544, DoABC#2)
// UniqueIDMessageComposer = "_-1uo" (String#5935, DoABC#2)
// IdentityAccountsEvent = "_-0GI" (String#3875, DoABC#2)
// InitCryptoMessageComposer = "_-Wc" (String#8338, DoABC#2)
// GenerateSecretKeyMessageComposer = "_-30y" (String#7326, DoABC#2)
// DisconnectReasonEvent = "_-1OP" (String#5321, DoABC#2)
// InitCryptoMessageEvent = "_-Nu" (String#8163, DoABC#2)
// ErrorReportEvent = "_-0WW" (String#4237, DoABC#2)
// MessengerInitMessageComposer = "_-1gx" (String#18174, DoABC#2)
// FriendRequestQuestCompleteMessageComposer = "_-3LQ" (String#22344, DoABC#2)
// GetBuddyRequestsMessageComposer = "_-03p" (String#14195, DoABC#2)
// FollowFriendFailedEvent = "_-1bO" (String#5583, DoABC#2)
// BuddyRequestsEvent = "_-2y" (String#7239, DoABC#2)
// NewBuddyRequestEvent = "_-1iS" (String#5721, DoABC#2)
// RoomInviteErrorEvent = "_-vN" (String#24504, DoABC#2)
// FriendListUpdateMessageComposer = "_-yk" (String#24641, DoABC#2)
// HabboSearchResultEvent = "_-20z" (String#6063, DoABC#2)
// AcceptBuddyResultEvent = "_-32P" (String#7356, DoABC#2)
// MessengerErrorEvent = "_-2EF" (String#19577, DoABC#2)
// FriendListUpdateEvent = "_-l9" (String#8629, DoABC#2)
// RequestBuddyMessageComposer = "_-2QG" (String#20057, DoABC#2)
// VoteQuestionMessageEvent = "_-1WZ" (String#17761, DoABC#2)
// VoteResultMessageEvent = "_-1Gz" (String#17150, DoABC#2)
// ShoutMessageEvent = "_-Gi" (String#22877, DoABC#2)
// ChatMessageEvent = "_-f7" (String#23850, DoABC#2)
// FloodControlMessageEvent = "_-Zv" (String#23628, DoABC#2)
// PetRespectNotificationEvent = "_-247" (String#19180, DoABC#2)
// WhisperMessageEvent = "_-h1" (String#23932, DoABC#2)
// RoomDimmerPresetsMessageEvent = "_-gw" (String#23926, DoABC#2)
// ViralFurniGiftReceivedEvent = "_-35d" (String#21717, DoABC#2)
// ViralFurniStatusEvent = "_-yK" (String#24627, DoABC#2)
// DoorOtherEndDeletedMessageEvent = "_-38w" (String#21840, DoABC#2)
// DoorNotInstalledMessageEvent = "_-38b" (String#21825, DoABC#2)
// OpenPetPackageRequestedMessageEvent = "_-1EY" (String#17050, DoABC#2)
// OpenPetPackageResultMessageEvent = "_-1Ob" (String#17453, DoABC#2)
// FavoriteMembershipUpdateMessageEvent = "_-1tm" (String#18707, DoABC#2)
// PetCommandsMessageEvent = "_-V3" (String#23451, DoABC#2)
// HabboUserBadgesMessageEvent = "_-1fc" (String#5656, DoABC#2)
// UserRemoveMessageEvent = "_-2U" (String#20197, DoABC#2)
// DanceMessageEvent = "_-1dk" (String#18047, DoABC#2)
// PetPlacingErrorEvent = "_-1XB" (String#17784, DoABC#2)
// UsersMessageEvent = "_-2MA" (String#19891, DoABC#2)
// DoorbellMessageEvent = "_-03C" (String#14170, DoABC#2)
// PetInfoMessageEvent = "_-94" (String#22583, DoABC#2)
// StartTypingMessageComposer = "_-1Sh" (String#17610, DoABC#2)
// RemoveRightsMessageComposer = "_-1Op" (String#17460, DoABC#2)
// PollStartComposer = "_-332" (String#21622, DoABC#2)
// CreditFurniRedeemMessageComposer = "_-1Xf" (String#17801, DoABC#2)
// WaveMessageComposer = "_-15Q" (String#16672, DoABC#2)
// SignMessageComposer = "_-1A" (String#16857, DoABC#2)
// ViralTeaserFoundMessageComposer = "_-05s" (String#14277, DoABC#2)
// PresentOpenMessageComposer = "_-3FS" (String#22097, DoABC#2)
// GetPetCommandsMessageComposer = "_-1Mp" (String#17393, DoABC#2)
// SetClothingChangeDataMessageComposer = "_-3j" (String#22363, DoABC#2)
// CancelTypingMessageComposer = "_-0Wi" (String#15305, DoABC#2)
// RoomDimmerSavePresetMessageComposer = "_-3LP" (String#22343, DoABC#2)
// RemovePetFromFlatMessageComposer = "_-1so" (String#18669, DoABC#2)
// VoteAnswerMessageComposer = "_-25A" (String#19226, DoABC#2)
// KickUserMessageComposer = "_-3GC" (String#22127, DoABC#2)
// QuitMessageComposer = "_-FM" (String#22827, DoABC#2)
// ChangeQueueMessageComposer = "_-0MP" (String#14930, DoABC#2)
// ShoutMessageComposer = "_-0W7" (String#15283, DoABC#2)
// WhisperMessageComposer = "_-3C4" (String#21963, DoABC#2)
// RoomDimmerGetPresetsMessageComposer = "_-0zU" (String#16406, DoABC#2)
// RoomDimmerChangeStateMessageComposer = "_-IN" (String#22945, DoABC#2)
// PollAnswerComposer = "_-0P6" (String#15030, DoABC#2)
// GetUserNotificationsMessageComposer = "_-Wh" (String#23513, DoABC#2)
// OpenPetPackageMessageComposer = "_-uW" (String#24471, DoABC#2)
// KickBotMessageComposer = "_-0To" (String#15200, DoABC#2)
// BanUserMessageComposer = "_-3DU" (String#22014, DoABC#2)
// ChangeMottoMessageComposer = "_-25K" (String#19231, DoABC#2)
// PollRejectComposer = "_-2EB" (String#19574, DoABC#2)
// OpenConnectionMessageComposer = "_-0d8" (String#15555, DoABC#2)
// AssignRightsMessageComposer = "_-34R" (String#21675, DoABC#2)
// LetUserInMessageComposer = "_-2kS" (String#20862, DoABC#2)
// DanceMessageComposer = "_-05v" (String#14278, DoABC#2)
// OpenFlatConnectionMessageComposer = "_-0HY" (String#14739, DoABC#2)
// PollContentsEvent = "_-0Fi" (String#14671, DoABC#2)
// PollOfferEvent = "_-37p" (String#21798, DoABC#2)
// PollErrorEvent = "_-9t" (String#22614, DoABC#2)
// AvatarEffectsMessageEvent = "_-2SA" (String#6610, DoABC#2)
// YouAreOwnerMessageEvent = "_-0bo" (String#15504, DoABC#2)
// YouAreNotControllerMessageEvent = "_-2jG" (String#20814, DoABC#2)
// YouAreControllerMessageEvent = "_-28l" (String#19360, DoABC#2)
// ExitLockerRoomMessageComposer = "_-2Rr" (String#20112, DoABC#2)
// OpenLockerRoomMessageEvent = "_-2yd" (String#21415, DoABC#2)
// UserNotificationMessageEvent = "_-1WK" (String#17755, DoABC#2)
// PresentOpenedMessageEvent = "_-1Zb" (String#17874, DoABC#2)
// GoToFlatMessageComposer = "_-1W0" (String#17744, DoABC#2)
// OpenConnectionMessageEvent = "_-UX" (String#8296, DoABC#2)
// FlatAccessibleMessageEvent = "_-e-" (String#23802, DoABC#2)
// FlatAccessDeniedMessageEvent = "_-3Cj" (String#7570, DoABC#2)
// YouAreSpectatorMessageEvent = "_-PJ" (String#23219, DoABC#2)
// GetGuestRoomResultEvent = "_-2XI" (String#20334, DoABC#2)
// PlaceObjectErrorMessageEvent = "_-Z4" (String#23604, DoABC#2)
// OpenMessageComposer = "_-2pb" (String#21063, DoABC#2)
// OpenEvent = "_-0eW" (String#15607, DoABC#2)
// ObjectRemoveMessageEvent = "_-36g" (String#21754, DoABC#2)
// WiredFurniConditionEvent = "_-33a" (String#21645, DoABC#2)
// WiredFurniTriggerEvent = "_-1lj" (String#18363, DoABC#2)
// WiredFurniActionEvent = "_-2-d" (String#18997, DoABC#2)
// UpdateActionMessageComposer = "_-Dh" (String#22758, DoABC#2)
// UpdateTriggerMessageComposer = "_-Dg" (String#22757, DoABC#2)
// UpdateConditionMessageComposer = "_-0Et" (String#14639, DoABC#2)
// ApplySnapshotMessageComposer = "_-2OL" (String#19980, DoABC#2)
// UseFurnitureMessageComposer = "_-0I2" (String#14759, DoABC#2)
// GetClubGiftInfo = "_-2oS" (String#21022, DoABC#2)
// SelectClubGiftComposer = "_-0BI" (String#14497, DoABC#2)
// GetMarketplaceConfigurationMessageComposer = "_-K-" (String#23005, DoABC#2)
// PopularRoomsSearchMessageComposer = "_-WK" (String#23503, DoABC#2)
// RoomsWithHighestScoreSearchMessageComposer = "_-34D" (String#21668, DoABC#2)
// RoomTagSearchMessageComposer = "_-0sl" (String#16151, DoABC#2)
// MyFriendsRoomsSearchMessageComposer = "_-1I4" (String#17196, DoABC#2)
// MyFavouriteRoomsSearchMessageComposer = "_-4m" (String#22408, DoABC#2)
// RoomsWhereMyFriendsAreSearchMessageComposer = "_-JM" (String#22979, DoABC#2)
// LatestEventsSearchMessageComposer = "_-Ad" (String#22641, DoABC#2)
// MyRoomHistorySearchMessageComposer = "_-1nc" (String#18445, DoABC#2)
// GetPopularRoomTagsMessageComposer = "_-3Jr" (String#22278, DoABC#2)
// RoomTextSearchMessageComposer = "_-hy" (String#23963, DoABC#2)
// GetOfficialRoomsMessageComposer = "_-30z" (String#21537, DoABC#2)
// MyRoomsSearchMessageComposer = "_-d3" (String#23759, DoABC#2)
// GetUserFlatCatsMessageComposer = "_-Y0" (String#23561, DoABC#2)
// FavouriteChangedEvent = "_-44" (String#22380, DoABC#2)
// NavigatorSettingsEvent = "_-3KS" (String#22302, DoABC#2)
// RoomInfoUpdatedEvent = "_-047" (String#14207, DoABC#2)
// GetGuestRoomMessageComposer = "_-0va" (String#16260, DoABC#2)
// PublicSpaceCastLibsEvent = "_-ms" (String#24146, DoABC#2)
// RoomSettingsDataEvent = "_-6N" (String#22479, DoABC#2)
// RoomSettingsErrorEvent = "_-1sV" (String#18654, DoABC#2)
// FlatCreatedEvent = "_-2fj" (String#20682, DoABC#2)
// GetPublicSpaceCastLibsMessageComposer = "_-38Z" (String#21824, DoABC#2)
// NoSuchFlatEvent = "_-0fA" (String#15636, DoABC#2)
// FlatControllerAddedEvent = "_-24H" (String#19188, DoABC#2)
// UserFlatCatsEvent = "_-eB" (String#23810, DoABC#2)
// RoomSettingsSavedEvent = "_-QI" (String#23262, DoABC#2)
// PopularRoomTagsResultEvent = "_-37E" (String#21777, DoABC#2)
// RoomThumbnailUpdateResultEvent = "_-VE" (String#23458, DoABC#2)
// FavouritesEvent = "_-39L" (String#21859, DoABC#2)
// CantConnectMessageEvent = "_-0qQ" (String#16067, DoABC#2)
// RoomSettingsSaveErrorEvent = "_-iy" (String#23997, DoABC#2)
// FollowFriendMessageComposer = "_-MN" (String#23099, DoABC#2)
// CanCreateRoomEventEvent = "_-2E4" (String#19572, DoABC#2)
// GuestRoomSearchResultEvent = "_-7-" (String#22500, DoABC#2)
// OfficialRoomsEvent = "_-o0" (String#24191, DoABC#2)
// RoomEventEvent = "_-1Bg" (String#16928, DoABC#2)
// FlatControllerRemovedEvent = "_-0ki" (String#15855, DoABC#2)
// CanCreateRoomEvent = "_-1fL" (String#18111, DoABC#2)
// RoomForwardMessageEvent = "_-33g" (String#21648, DoABC#2)
// CreateFlatMessageComposer = "_-27w" (String#19327, DoABC#2)
// RateFlatMessageComposer = "_-1DX" (String#17004, DoABC#2)
// ToggleStaffPickMessageComposer = "_-2Rb" (String#20103, DoABC#2)
// DeleteFavouriteRoomMessageComposer = "_-2sr" (String#21193, DoABC#2)
// AddFavouriteRoomMessageComposer = "_-36q" (String#21758, DoABC#2)
// UpdateNavigatorSettingsMessageComposer = "_-0C2" (String#14528, DoABC#2)
// CanCreateEventMessageComposer = "_-0T6" (String#15175, DoABC#2)
// GetSongInfoMessageComposer = "_-2q3" (String#21083, DoABC#2)
// UserSongDisksInventoryMessageEvent = "_-1In" (String#17227, DoABC#2)
// GetNowPlayingMessageComposer = "_-3IV" (String#22219, DoABC#2)
// GetUserSongDisksMessageComposer = "_-1aA" (String#17901, DoABC#2)
// TraxSongInfoMessageEvent = "_-37D" (String#21776, DoABC#2)
// TradingConfirmationEvent = "_-j2" (String#8578, DoABC#2)
// PetAddedToInventoryEvent = "_-2W" (String#6683, DoABC#2)
// FurniListRemoveEvent = "_-3Ij" (String#7684, DoABC#2)
// TradingNotOpenEvent = "_-2Du" (String#6318, DoABC#2)
// BadgesEvent = "_-3HC" (String#7652, DoABC#2)
// AvatarEffectExpiredMessageEvent = "_-0Sv" (String#4158, DoABC#2)
// AchievementsScoreEvent = "_-JF" (String#8067, DoABC#2)
// AvatarEffectActivatedMessageEvent = "_-fk" (String#8508, DoABC#2)
// PostItPlacedEvent = "_-2op" (String#7053, DoABC#2)
// TradingItemListEvent = "_-1LI" (String#5267, DoABC#2)
// FurniListUpdateEvent = "_-0Xr" (String#4265, DoABC#2)
// FurniListInsertEvent = "_-0Ey" (String#3848, DoABC#2)
// TradingAlreadyOpenEvent = "_-QK" (String#8207, DoABC#2)
// RequestFurniInventoryComposer = "_-17" (String#16734, DoABC#2)
// TradingCompletedEvent = "_-2gA" (String#6872, DoABC#2)
// MarketplaceCanMakeOfferResult = "_-1OM" (String#5320, DoABC#2)
// AvatarEffectAddedMessageEvent = "_-MW" (String#8132, DoABC#2)
// PetRemovedFromInventoryEvent = "_-0LF" (String#3986, DoABC#2)
// FurniListEvent = "_-1DK" (String#5131, DoABC#2)
// UnseenItemsEvent = "_-0ZA" (String#4282, DoABC#2)
// TradingOtherNotAllowedEvent = "_-PA" (String#8187, DoABC#2)
// TradingYouAreNotAllowedEvent = "_-2vg" (String#7191, DoABC#2)
// TradingOpenEvent = "_-3JK" (String#7692, DoABC#2)
// BadgePointLimitsEvent = "_-1hx" (String#5705, DoABC#2)
// TradingCloseEvent = "_-WD" (String#8328, DoABC#2)
// TradingAcceptEvent = "_-38I" (String#7478, DoABC#2)
// PetInventoryEvent = "_-2t6" (String#7140, DoABC#2)
// RemoveItemFromTradeComposer = "_-0rS" (String#16102, DoABC#2)
// ConfirmDeclineTradingComposer = "_-3HS" (String#22177, DoABC#2)
// ConfirmAcceptTradingComposer = "_-1k9" (String#18294, DoABC#2)
// OpenTradingComposer = "_-26G" (String#19263, DoABC#2)
// CloseTradingComposer = "_-23i" (String#19164, DoABC#2)
// AddItemToTradeComposer = "_-1mn" (String#18412, DoABC#2)
// UnacceptTradingComposer = "_-fW" (String#23865, DoABC#2)
// AcceptTradingComposer = "_-2ZY" (String#20421, DoABC#2)
// ResetUnseenItemsComposer = "_-pv" (String#24269, DoABC#2)
// GetBadgesComposer = "_-0TR" (String#15188, DoABC#2)
// SetActivatedBadgesComposer = "_-12m" (String#16571, DoABC#2)
// AvatarEffectActivatedComposer = "_-2ZH" (String#20409, DoABC#2)
// AvatarEffectSelectedComposer = "_-2aD" (String#20451, DoABC#2)
// PlacePetMessageComposer = "_-1qF" (String#18553, DoABC#2)
// GetPetInventoryComposer = "_-jb" (String#24021, DoABC#2)
// BuyMarketplaceTokensMessageComposer = "_-1v3" (String#18758, DoABC#2)
// MakeOfferMessageComposer = "_-0pb" (String#16038, DoABC#2)
// GetMarketplaceCanMakeOfferComposer = "_-25I" (String#19229, DoABC#2)
// LikeStreamEventMessageComposer = "_-23U" (String#19154, DoABC#2)
// EventStreamEvent = "_-0fC" (String#15637, DoABC#2)
// SetEventStreamingAllowedComposer = "_-2Hr" (String#19721, DoABC#2)
// GetEventStreamComposer = "_-01r" (String#14122, DoABC#2)
// FindNewFriendsMessageComposer = "_-2eU" (String#20624, DoABC#2)
// FriendNotificationEvent = "_-2Vl" (String#6679, DoABC#2)
// FindFriendsProcessResultEvent = "_-3IG" (String#7672, DoABC#2)
// SendMsgMessageComposer = "_-2Gh" (String#19668, DoABC#2)
// CallGuideBotMessageComposer = "_-1JH" (String#17248, DoABC#2)
// CheckUserNameResultMessageEvent = "_-2Tb" (String#20186, DoABC#2)
// ChangeUserNameMessageComposer = "_-05J" (String#14256, DoABC#2)
// CheckUserNameMessageComposer = "_-pJ" (String#24245, DoABC#2)
// HotelMergeNameChangeEvent = "_-32D" (String#21589, DoABC#2)
// FaqTextMessageEvent = "_-0Cr" (String#14565, DoABC#2)
// FaqSearchResultsMessageEvent = "_-Pm" (String#23238, DoABC#2)
// IssueCloseNotificationMessageEvent = "_-SY" (String#23348, DoABC#2)
// TutorialStatusMessageEvent = "_-II" (String#22940, DoABC#2)
// FaqClientFaqsMessageEvent = "_-0vA" (String#16244, DoABC#2)
// CallForHelpPendingCallsDeletedMessageEvent = "_-342" (String#21659, DoABC#2)
// FaqCategoryMessageEvent = "_-248" (String#19181, DoABC#2)
// CallForHelpResultMessageEvent = "_-07k" (String#14353, DoABC#2)
// FaqCategoriesMessageEvent = "_-0OG" (String#14999, DoABC#2)
// CallForHelpReplyMessageEvent = "_-0-F" (String#14022, DoABC#2)
// GetWardrobeMessageComposer = "_-1xw" (String#18884, DoABC#2)
// QuestCompletedMessageEvent = "_-Kr" (String#8100, DoABC#2)
// RemoveJukeboxDiskComposer = "_-2Vs" (String#20276, DoABC#2)
// GetRoomChatlogMessageComposer = "_-2AI" (String#19416, DoABC#2)
// QuestsMessageEvent = "_-0xi" (String#4803, DoABC#2)
// SetRandomStateMessageComposer = "_-1mS" (String#18398, DoABC#2)
// DeletePendingCallsForHelpMessageComposer = "_-23Z" (String#19157, DoABC#2)
// RemoveBuddyMessageComposer = "_-0OX" (String#15009, DoABC#2)
// QuestMessageEvent = "_-2xP" (String#7229, DoABC#2)
// GetUserTagsMessageComposer = "_-0tf" (String#16188, DoABC#2)
// CreateEventMessageComposer = "_-19X" (String#16838, DoABC#2)
// ModeratorActionResultMessageEvent = "_-2a-" (String#20441, DoABC#2)
// PickIssuesMessageComposer = "_-0iu" (String#15787, DoABC#2)
// SleepMessageEvent = "_-0J0" (String#14800, DoABC#2)
// FlatCatEvent = "_-vD" (String#24499, DoABC#2)
// SendRoomInviteMessageComposer = "_-2fR" (String#20666, DoABC#2)
// PlacePostItMessageComposer = "_-CG" (String#22700, DoABC#2)
// AcceptQuestMessageComposer = "_-Th" (String#23394, DoABC#2)
// LookToMessageComposer = "_-29v" (String#19401, DoABC#2)
// TryBusMessageComposer = "_-0ym" (String#16382, DoABC#2)
// IssueDeletedMessageEvent = "_-0By" (String#14525, DoABC#2)
// GetSoundMachinePlayListMessageComposer = "_-21Q" (String#19069, DoABC#2)
// ViralFurniStatusMessageComposer = "_-1Nk" (String#17427, DoABC#2)
// HabboGroupsWhereMemberMessageEvent = "_-1Yk" (String#5538, DoABC#2)
// AvatarEffectSelectedMessageEvent = "_-0Dy" (String#14605, DoABC#2)
// SetObjectDataMessageComposer = "_-Go" (String#22882, DoABC#2)
// DeclineBuddyMessageComposer = "_-jt" (String#24030, DoABC#2)
// ModMessageMessageComposer = "_-2Sk" (String#20148, DoABC#2)
// GetHabboGroupsWhereMemberMessageComposer = "_-1Zd" (String#17875, DoABC#2)
// CallForHelpPendingCallsMessageEvent = "_-2wx" (String#21346, DoABC#2)
// ItemRemoveMessageEvent = "_-ex" (String#23842, DoABC#2)
// JukeboxSongDisksMessageEvent = "_-0c1" (String#15514, DoABC#2)
// HabboAchievementShareIdMessageEvent = "_-0CV" (String#3800, DoABC#2)
// UserChatlogEvent = "_-1AF" (String#16869, DoABC#2)
// DiceOffMessageComposer = "_-0ZY" (String#15425, DoABC#2)
// ModerateRoomMessageComposer = "_-2Mn" (String#19918, DoABC#2)
// PickupObjectMessageComposer = "_-0Oc" (String#15012, DoABC#2)
// FaceBookInitiateAddFriendsMessageComposer = "_-0Tj" (String#15198, DoABC#2)
// GetClientFaqsMessageComposer = "_-3u" (String#22371, DoABC#2)
// RoomChatlogEvent = "_-13V" (String#16599, DoABC#2)
// HabboGroupBadgesMessageEvent = "_-3L2" (String#7723, DoABC#2)
// UserTypingMessageEvent = "_-2Q8" (String#20050, DoABC#2)
// QuestCancelledMessageEvent = "_-0Xi" (String#4262, DoABC#2)
// OpenWelcomeGiftComposer = "_-8F" (String#22551, DoABC#2)
// HabboGroupDetailsMessageEvent = "_-2uh" (String#7173, DoABC#2)
// GetPendingCallsForHelpMessageComposer = "_-3F0" (String#22077, DoABC#2)
// AddSpamWallPostItMessageComposer = "_-0aU" (String#15454, DoABC#2)
// UseWallItemMessageComposer = "_-4c" (String#22401, DoABC#2)
// RemoveItemMessageComposer = "_-0KW" (String#14861, DoABC#2)
// GetHabboBasicMembershipExtendOfferComposer = "_-0yV" (String#16373, DoABC#2)
// FaceBookIsLoggedOnMessageComposer = "_-0ov" (String#16008, DoABC#2)
// GetHabboGroupBadgesMessageComposer = "_-1Z4" (String#17854, DoABC#2)
// RoomPropertyMessageEvent = "_-1oS" (String#18475, DoABC#2)
// ModeratorActionMessageComposer = "_-B-" (String#22655, DoABC#2)
// MoveObjectMessageComposer = "_-0e6" (String#15589, DoABC#2)
// RequestSpamWallPostItMessageEvent = "_-1v-" (String#18755, DoABC#2)
// GetFaqCategoryMessageComposer = "_-Zf" (String#23622, DoABC#2)
// PublicRoomObjectsMessageEvent = "_-25B" (String#6145, DoABC#2)
// PlayListMessageEvent = "_-2L7" (String#19852, DoABC#2)
// ObjectDataUpdateMessageEvent = "_-344" (String#21661, DoABC#2)
// MoveAvatarMessageComposer = "_-1xR" (String#18866, DoABC#2)
// GetFaqCategoriesMessageComposer = "_-0Ik" (String#14789, DoABC#2)
// OneWayDoorStatusMessageEvent = "_-316" (String#21542, DoABC#2)
// AvailabilityTimeMessageEvent = "_-0CU" (String#14548, DoABC#2)
// OpenQuestTrackerMessageComposer = "_-07J" (String#3708, DoABC#2)
// GetRoomSettingsMessageComposer = "_-7i" (String#22531, DoABC#2)
// YouArePlayingGameMessageEvent = "_-0ti" (String#16191, DoABC#2)
// ModBanMessageComposer = "_-2u0" (String#21238, DoABC#2)
// DeleteRoomMessageComposer = "_-SK" (String#23338, DoABC#2)
// NowPlayingMessageEvent = "_-0NW" (String#14973, DoABC#2)
// SearchFaqsMessageComposer = "_-1ud" (String#18742, DoABC#2)
// WelcomeGiftStatusEvent = "_-gn" (String#23923, DoABC#2)
// ReleaseIssuesMessageComposer = "_-0Vg" (String#15265, DoABC#2)
// ThrowDiceMessageComposer = "_-zR" (String#24670, DoABC#2)
// GamePlayerValueMessageEvent = "_-Y5" (String#23566, DoABC#2)
// CloseIssuesMessageComposer = "_-1BQ" (String#16915, DoABC#2)
// HabboSearchMessageComposer = "_-2Ns" (String#19959, DoABC#2)
// MoveWallItemMessageComposer = "_-13v" (String#16614, DoABC#2)
// GetPetInfoMessageComposer = "_-fj" (String#23877, DoABC#2)
// IssuePickFailedMessageEvent = "_-3Ej" (String#22064, DoABC#2)
// StartCampaignMessageComposer = "_-2Vv" (String#20278, DoABC#2)
// AcceptBuddyMessageComposer = "_-3-o" (String#21493, DoABC#2)
// SaveRoomSettingsMessageComposer = "_-0Od" (String#15013, DoABC#2)
// AchievementEvent = "_-12h" (String#4929, DoABC#2)
// ModeratorInitMessageEvent = "_-3CW" (String#21976, DoABC#2)
// RemoveAllRightsMessageComposer = "_-0Rw" (String#15132, DoABC#2)
// EditEventMessageComposer = "_-1sL" (String#18646, DoABC#2)
// GetQuestsMessageComposer = "_-2ct" (String#6810, DoABC#2)
// IssueInfoMessageEvent = "_-Ab" (String#22639, DoABC#2)
// JoinHabboGroupMessageComposer = "_-1v1" (String#18757, DoABC#2)
// HeightMapMessageEvent = "_-06-" (String#14282, DoABC#2)
// GetFaqTextMessageComposer = "_-nR" (String#24169, DoABC#2)
// EnterOneWayDoorMessageComposer = "_-0qR" (String#16068, DoABC#2)
// ItemsMessageEvent = "_-2YD" (String#20365, DoABC#2)
// CarryObjectMessageEvent = "_-0Fw" (String#14680, DoABC#2)
// AddJukeboxDiskComposer = "_-08s" (String#14400, DoABC#2)
// ModAlertMessageComposer = "_-Yq" (String#23593, DoABC#2)
// UserUpdateMessageEvent = "_-0CW" (String#14549, DoABC#2)
// ObjectsMessageEvent = "_-22v" (String#19131, DoABC#2)
// GetItemDataMessageComposer = "_-i7" (String#23970, DoABC#2)
// FaceBookAuthenticateEvent = "_-11l" (String#4911, DoABC#2)
// FloorHeightMapMessageEvent = "_-1x5" (String#18851, DoABC#2)
// ChangeEmailResultEvent = "_-1v9" (String#18763, DoABC#2)
// FaceBookIsLoggedOffMessageComposer = "_-3CF" (String#21970, DoABC#2)
// RoomVisualizationSettingsEvent = "_-2ra" (String#21140, DoABC#2)
// HeightMapUpdateMessageEvent = "_-2Rn" (String#20111, DoABC#2)
// AvatarEffectMessageEvent = "_-1Cw" (String#16979, DoABC#2)
// ParkBusDoorMessageEvent = "_-2UD" (String#20208, DoABC#2)
// GetRoomEntryDataMessageComposer = "_-2cs" (String#20559, DoABC#2)
// ItemAddMessageEvent = "_-1TD" (String#17633, DoABC#2)
// GetAchievementsComposer = "_-AY" (String#22637, DoABC#2)
// WardrobeMessageEvent = "_-37-" (String#7448, DoABC#2)
// FaceBookErrorEvent = "_-0LT" (String#3990, DoABC#2)
// UserTagsMessageEvent = "_-04R" (String#3653, DoABC#2)
// ModeratorRoomInfoEvent = "_-0m0" (String#15897, DoABC#2)
// GetAchievementShareIdComposer = "_-1iv" (String#5732, DoABC#2)
// RejectQuestMessageComposer = "_-20K" (String#19025, DoABC#2)
// ObjectAddMessageEvent = "_-2WR" (String#20302, DoABC#2)
// UpdateFigureDataMessageComposer = "_-0Qz" (String#15101, DoABC#2)
// PetExperienceEvent = "_-1NJ" (String#17410, DoABC#2)
// ChangeRoomMessageComposer = "_-12g" (String#16566, DoABC#2)
// GetModeratorUserInfoMessageComposer = "_-2fD" (String#20655, DoABC#2)
// JukeboxPlayListFullMessageEvent = "_-0kw" (String#15863, DoABC#2)
// ChangeEmailComposer = "_-CY" (String#22707, DoABC#2)
// GetFurnitureAliasesMessageComposer = "_-2vb" (String#21299, DoABC#2)
// GetCfhChatlogMessageComposer = "_-1Za" (String#17873, DoABC#2)
// ObjectsDataUpdateMessageEvent = "_-2Gx" (String#6385, DoABC#2)
// GetIgnoredUsersMessageComposer = "_-0WB" (String#15287, DoABC#2)
// CallForHelpMessageComposer = "_-tO" (String#24422, DoABC#2)
// DeselectFavouriteHabboGroupMessageComposer = "_-3p" (String#22368, DoABC#2)
// IgnoreUserMessageComposer = "_-1cl" (String#18000, DoABC#2)
// SpinWheelOfFortuneMessageComposer = "_-0Bc" (String#14512, DoABC#2)
// ItemDataUpdateMessageEvent = "_-2ga" (String#20714, DoABC#2)
// ModKickMessageComposer = "_-2TW" (String#20182, DoABC#2)
// UseObjectMessageEvent = "_-0WA" (String#15286, DoABC#2)
// CfhChatlogEvent = "_-ax" (String#23668, DoABC#2)
// ItemUpdateMessageEvent = "_-39z" (String#21884, DoABC#2)
// FaceBookAppRequestEvent = "_-26B" (String#6168, DoABC#2)
// SetItemDataMessageComposer = "_-29t" (String#19399, DoABC#2)
// WaveMessageEvent = "_-47" (String#22383, DoABC#2)
// SlideObjectBundleMessageEvent = "_-35" (String#21695, DoABC#2)
// CanCreateRoomMessageComposer = "_-2Ug" (String#20225, DoABC#2)
// RoomVisitsEvent = "_-L-" (String#23046, DoABC#2)
// FurnitureAliasesMessageEvent = "_-11g" (String#16524, DoABC#2)
// UnignoreUserMessageComposer = "_-0TE" (String#15179, DoABC#2)
// PlayListSongAddedMessageEvent = "_-2z0" (String#21427, DoABC#2)
// TradingNoSuchItemEvent = "_-FO" (String#22828, DoABC#2)
// SelectFavouriteHabboGroupMessageComposer = "_-15p" (String#16689, DoABC#2)
// ModeratorUserInfoEvent = "_-24q" (String#19216, DoABC#2)
// HabboGroupJoinFailedMessageEvent = "_-1sF" (String#5890, DoABC#2)
// QuestVendingWallItemMessageComposer = "_-1Tf" (String#17651, DoABC#2)
// ObjectUpdateMessageEvent = "_-06L" (String#14301, DoABC#2)
// CancelEventMessageComposer = "_-2Vz" (String#20281, DoABC#2)
// GetRoomVisitsMessageComposer = "_-1AB" (String#16866, DoABC#2)
// SaveWardrobeOutfitMessageComposer = "_-2yS" (String#21409, DoABC#2)
// GetJukeboxPlayListMessageComposer = "_-1-Q" (String#16444, DoABC#2)
// IgnoredUsersMessageEvent = "_-Ca" (String#7928, DoABC#2)
// GetUserChatlogMessageComposer = "_-Pp" (String#23241, DoABC#2)
// IgnoreResultMessageEvent = "_-2UA" (String#6651, DoABC#2)
// DiceValueMessageEvent = "_-1xp" (String#18881, DoABC#2)
// GetSelectedBadgesMessageComposer = "_-24x" (String#19219, DoABC#2)
// GetModeratorRoomInfoMessageComposer = "_-1cn" (String#18002, DoABC#2)
// CameraSnapshotMessageEvent = "_-2fh" (String#20680, DoABC#2)
// UpdateRoomThumbnailMessageComposer = "_-1up" (String#18750, DoABC#2)
// ViralTeaserActiveMessageEvent = "_-2mO" (String#20934, DoABC#2)
// AchievementsEvent = "_-3FG" (String#7617, DoABC#2)
// EventLogMessageComposer = "_-2lH" (String#6984, DoABC#2)
// RoomEntryInfoMessageEvent = "_-nk" (String#24182, DoABC#2)
// HabboAchievementNotificationMessageEvent = "_-2LH" (String#6465, DoABC#2)
// CloseConnectionMessageEvent = "_-2cv" (String#6811, DoABC#2)


