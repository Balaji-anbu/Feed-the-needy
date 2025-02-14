import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ta.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ta')
  ];

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Food Donor Home'**
  String get homeTitle;

  /// No description provided for @welcomeFoodDonor.
  ///
  /// In en, this message translates to:
  /// **'Welcome, Food Donor!'**
  String get welcomeFoodDonor;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @signOutError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while signing out.'**
  String get signOutError;

  /// No description provided for @drawerHeader.
  ///
  /// In en, this message translates to:
  /// **'Food Donor'**
  String get drawerHeader;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editProfile;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @profilePageTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile Page'**
  String get profilePageTitle;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @organisationType.
  ///
  /// In en, this message translates to:
  /// **'Organization Type'**
  String get organisationType;

  /// No description provided for @organisationName.
  ///
  /// In en, this message translates to:
  /// **'Organization Name'**
  String get organisationName;

  /// No description provided for @doorNo.
  ///
  /// In en, this message translates to:
  /// **'Door Number'**
  String get doorNo;

  /// No description provided for @street.
  ///
  /// In en, this message translates to:
  /// **'Street'**
  String get street;

  /// No description provided for @nearWhere.
  ///
  /// In en, this message translates to:
  /// **'Near Where'**
  String get nearWhere;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @district.
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get district;

  /// No description provided for @pincode.
  ///
  /// In en, this message translates to:
  /// **'Pincode'**
  String get pincode;

  /// No description provided for @emailId.
  ///
  /// In en, this message translates to:
  /// **'Email ID'**
  String get emailId;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @saveProfile.
  ///
  /// In en, this message translates to:
  /// **'Save Profile'**
  String get saveProfile;

  /// No description provided for @profileSaved.
  ///
  /// In en, this message translates to:
  /// **'Profile saved successfully.'**
  String get profileSaved;

  /// No description provided for @errorSavingProfile.
  ///
  /// In en, this message translates to:
  /// **'Error saving profile. Please try again.'**
  String get errorSavingProfile;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get requiredField;

  /// No description provided for @addProfile.
  ///
  /// In en, this message translates to:
  /// **'Add Profile'**
  String get addProfile;

  /// No description provided for @transactionHistory.
  ///
  /// In en, this message translates to:
  /// **'Transaction History'**
  String get transactionHistory;

  /// No description provided for @trackStatus.
  ///
  /// In en, this message translates to:
  /// **'Track Status'**
  String get trackStatus;

  /// No description provided for @islChatbot.
  ///
  /// In en, this message translates to:
  /// **'ISL Chatbot'**
  String get islChatbot;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @helpAndSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpAndSupport;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUs;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logoutConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutConfirmation;

  /// No description provided for @rateUs.
  ///
  /// In en, this message translates to:
  /// **'Rate Us'**
  String get rateUs;

  /// No description provided for @mobileSignalCheck.
  ///
  /// In en, this message translates to:
  /// **'Mobile Signal Check'**
  String get mobileSignalCheck;

  /// No description provided for @umangGuide.
  ///
  /// In en, this message translates to:
  /// **'UMANG Guide'**
  String get umangGuide;

  /// No description provided for @qrCode.
  ///
  /// In en, this message translates to:
  /// **'QR Code'**
  String get qrCode;

  /// No description provided for @updateProfileCompletion.
  ///
  /// In en, this message translates to:
  /// **'Update your profile to complete registration.'**
  String get updateProfileCompletion;

  /// No description provided for @profileCompletionStatus.
  ///
  /// In en, this message translates to:
  /// **'Profile Completion: {completion}%'**
  String profileCompletionStatus(Object completion);

  /// No description provided for @vehicleType.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Type'**
  String get vehicleType;

  /// No description provided for @vehicleNumber.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Number'**
  String get vehicleNumber;

  /// No description provided for @licenseNumber.
  ///
  /// In en, this message translates to:
  /// **'License Number'**
  String get licenseNumber;

  /// No description provided for @newOrders.
  ///
  /// In en, this message translates to:
  /// **'New Orders'**
  String get newOrders;

  /// No description provided for @currentOrders.
  ///
  /// In en, this message translates to:
  /// **'current Orders'**
  String get currentOrders;

  /// No description provided for @noAvailableOrders.
  ///
  /// In en, this message translates to:
  /// **'No available orders'**
  String get noAvailableOrders;

  /// No description provided for @pleaseLoginFirst.
  ///
  /// In en, this message translates to:
  /// **'Please log in first'**
  String get pleaseLoginFirst;

  /// No description provided for @activeDeliveryExists.
  ///
  /// In en, this message translates to:
  /// **'You already have an active delivery'**
  String get activeDeliveryExists;

  /// No description provided for @orderAcceptedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Order Accepted Successfully'**
  String get orderAcceptedSuccess;

  /// No description provided for @errorAcceptingOrder.
  ///
  /// In en, this message translates to:
  /// **'Error accepting order: {error}'**
  String errorAcceptingOrder(Object error);

  /// No description provided for @orderRejected.
  ///
  /// In en, this message translates to:
  /// **'Order Rejected'**
  String get orderRejected;

  /// No description provided for @errorRejectingOrder.
  ///
  /// In en, this message translates to:
  /// **'Error rejecting order: {error}'**
  String errorRejectingOrder(Object error);

  /// No description provided for @deliveryIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Delivery Id: {id}'**
  String deliveryIdLabel(Object id);

  /// No description provided for @locationLabel.
  ///
  /// In en, this message translates to:
  /// **'Location: {location}'**
  String locationLabel(Object location);

  /// No description provided for @recipientNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Recipient Name: {name}'**
  String recipientNameLabel(Object name);

  /// No description provided for @quantityLabel.
  ///
  /// In en, this message translates to:
  /// **'Quantity: {quantity}'**
  String quantityLabel(Object quantity);

  /// No description provided for @currentStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Current Status: {status}'**
  String currentStatusLabel(Object status);

  /// No description provided for @doorNoLabel.
  ///
  /// In en, this message translates to:
  /// **'Door No: {doorNo}'**
  String doorNoLabel(Object doorNo);

  /// No description provided for @streetNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Street Name: {street}'**
  String streetNameLabel(Object street);

  /// No description provided for @cityLabel.
  ///
  /// In en, this message translates to:
  /// **'City: {city}'**
  String cityLabel(Object city);

  /// No description provided for @pincodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Pincode: {pincode}'**
  String pincodeLabel(Object pincode);

  /// No description provided for @paymentModeLabel.
  ///
  /// In en, this message translates to:
  /// **'Payment Mode: {mode}'**
  String paymentModeLabel(Object mode);

  /// No description provided for @deliveryChargeLabel.
  ///
  /// In en, this message translates to:
  /// **'Delivery charge: {charge}'**
  String deliveryChargeLabel(Object charge);

  /// No description provided for @recipientPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Recipient phone: {phone}'**
  String recipientPhoneLabel(Object phone);

  /// No description provided for @recipientEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Recipient Email: {email}'**
  String recipientEmailLabel(Object email);

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @noCompletedOrders.
  ///
  /// In en, this message translates to:
  /// **'No Completed Orders'**
  String get noCompletedOrders;

  /// No description provided for @orderId.
  ///
  /// In en, this message translates to:
  /// **'Order ID: {id}'**
  String orderId(Object id);

  /// No description provided for @addressLabel.
  ///
  /// In en, this message translates to:
  /// **'Address:'**
  String get addressLabel;

  /// No description provided for @contactDetailsLabel.
  ///
  /// In en, this message translates to:
  /// **'Contact Details:'**
  String get contactDetailsLabel;

  /// No description provided for @completedOnLabel.
  ///
  /// In en, this message translates to:
  /// **'Completed On: {date}'**
  String completedOnLabel(Object date);

  /// No description provided for @noActiveDelivery.
  ///
  /// In en, this message translates to:
  /// **'No Active Delivery'**
  String get noActiveDelivery;

  /// No description provided for @notifyDeliveryMessage.
  ///
  /// In en, this message translates to:
  /// **'We will Notify you when you get a delivery'**
  String get notifyDeliveryMessage;

  /// No description provided for @deliveryProgress.
  ///
  /// In en, this message translates to:
  /// **'Delivery Progress'**
  String get deliveryProgress;

  /// No description provided for @steps.
  ///
  /// In en, this message translates to:
  /// **'{current}/{total} Steps'**
  String steps(Object current, Object total);

  /// No description provided for @addressDetails.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get addressDetails;

  /// No description provided for @cantUpdateStatus.
  ///
  /// In en, this message translates to:
  /// **'Cannot update status further'**
  String get cantUpdateStatus;

  /// No description provided for @statusUpdated.
  ///
  /// In en, this message translates to:
  /// **'Status updated to \"{status}\"'**
  String statusUpdated(Object status);

  /// No description provided for @errorUpdatingStatus.
  ///
  /// In en, this message translates to:
  /// **'Error updating status: {error}'**
  String errorUpdatingStatus(Object error);

  /// No description provided for @cantLaunchMaps.
  ///
  /// In en, this message translates to:
  /// **'Could not launch Google Maps'**
  String get cantLaunchMaps;

  /// No description provided for @errorFetchingLocation.
  ///
  /// In en, this message translates to:
  /// **'Error fetching location: {error}'**
  String errorFetchingLocation(Object error);

  /// No description provided for @viewFoodLocation.
  ///
  /// In en, this message translates to:
  /// **'View Food Location'**
  String get viewFoodLocation;

  /// No description provided for @viewDeliveryLocation.
  ///
  /// In en, this message translates to:
  /// **'View Delivery Location'**
  String get viewDeliveryLocation;

  /// No description provided for @updateStatus.
  ///
  /// In en, this message translates to:
  /// **'Update Status'**
  String get updateStatus;

  /// No description provided for @completeAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please complete all required fields'**
  String get completeAllFields;

  /// No description provided for @capturePhoto.
  ///
  /// In en, this message translates to:
  /// **'Capture Photo'**
  String get capturePhoto;

  /// No description provided for @additionalNotes.
  ///
  /// In en, this message translates to:
  /// **'Additional Notes'**
  String get additionalNotes;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm {action}'**
  String confirm(Object action);

  /// No description provided for @deliveryPartnerTitle.
  ///
  /// In en, this message translates to:
  /// **'Delivery Partner'**
  String get deliveryPartnerTitle;

  /// No description provided for @hey.
  ///
  /// In en, this message translates to:
  /// **'Hey!'**
  String get hey;

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get myProfile;

  /// No description provided for @viewDeliveryDetails.
  ///
  /// In en, this message translates to:
  /// **'View Delivery Details'**
  String get viewDeliveryDetails;

  /// No description provided for @errorFetchingDeliveryData.
  ///
  /// In en, this message translates to:
  /// **'Error fetching delivery data: {error}'**
  String errorFetchingDeliveryData(Object error);

  /// No description provided for @finished.
  ///
  /// In en, this message translates to:
  /// **'Finished'**
  String get finished;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'App Version {version}'**
  String appVersion(Object version);

  /// No description provided for @pendingDeliveries.
  ///
  /// In en, this message translates to:
  /// **'Pending Deliveries'**
  String get pendingDeliveries;

  /// No description provided for @completedDeliveries.
  ///
  /// In en, this message translates to:
  /// **'Completed Deliveries'**
  String get completedDeliveries;

  /// No description provided for @makingDifference.
  ///
  /// In en, this message translates to:
  /// **'Making a Difference'**
  String get makingDifference;

  /// No description provided for @makingDifferenceContent.
  ///
  /// In en, this message translates to:
  /// **'Every delivery ensures food reaches someone in need. You are creating an impact!'**
  String get makingDifferenceContent;

  /// No description provided for @timelyAssistance.
  ///
  /// In en, this message translates to:
  /// **'Timely Assistance'**
  String get timelyAssistance;

  /// No description provided for @timelyAssistanceContent.
  ///
  /// In en, this message translates to:
  /// **'Your dedication ensures food is delivered fresh and on time!'**
  String get timelyAssistanceContent;

  /// No description provided for @buildingHope.
  ///
  /// In en, this message translates to:
  /// **'Building Hope'**
  String get buildingHope;

  /// No description provided for @buildingHopeContent.
  ///
  /// In en, this message translates to:
  /// **'By connecting donors and needers, you are building hope for a better tomorrow.'**
  String get buildingHopeContent;

  /// No description provided for @whyPartnerMatters.
  ///
  /// In en, this message translates to:
  /// **'Why Being a Delivery Partner Matters?'**
  String get whyPartnerMatters;

  /// No description provided for @partnerRoleDescription.
  ///
  /// In en, this message translates to:
  /// **'As a delivery partner, you play a vital role in bridging the gap between those willing to give and those in need. Your efforts ensure timely delivery of food to the hungry, making an impact one delivery at a time. Your dedication contributes to a hunger-free community.'**
  String get partnerRoleDescription;

  /// No description provided for @keyPoints.
  ///
  /// In en, this message translates to:
  /// **'• Connects food to the needy.\n• Reduces food waste.\n• Fosters a hunger-free community.\n• Provides timely assistance.\n• Helps save lives and build hope.'**
  String get keyPoints;

  /// No description provided for @noUserLoggedIn.
  ///
  /// In en, this message translates to:
  /// **'No user logged in'**
  String get noUserLoggedIn;

  /// No description provided for @errorFetchingData.
  ///
  /// In en, this message translates to:
  /// **'Error fetching data'**
  String get errorFetchingData;

  /// No description provided for @noDataAvailable.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get noDataAvailable;

  /// No description provided for @profileCompletion.
  ///
  /// In en, this message translates to:
  /// **'Profile Completion'**
  String get profileCompletion;

  /// No description provided for @percentComplete.
  ///
  /// In en, this message translates to:
  /// **'{percent}% Complete'**
  String percentComplete(Object percent);

  /// No description provided for @completeProfile.
  ///
  /// In en, this message translates to:
  /// **'Complete Profile'**
  String get completeProfile;

  /// No description provided for @confirmSignOut.
  ///
  /// In en, this message translates to:
  /// **'Confirm Sign Out'**
  String get confirmSignOut;

  /// No description provided for @signOutConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get signOutConfirmation;

  /// No description provided for @signOutButton.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOutButton;

  /// No description provided for @totalFoodUploads.
  ///
  /// In en, this message translates to:
  /// **'Total Food Uploads'**
  String get totalFoodUploads;

  /// No description provided for @totalServed.
  ///
  /// In en, this message translates to:
  /// **'Total Served'**
  String get totalServed;

  /// No description provided for @peopleFed.
  ///
  /// In en, this message translates to:
  /// **'People Fed'**
  String get peopleFed;

  /// No description provided for @homesTrustsFed.
  ///
  /// In en, this message translates to:
  /// **'Homes/Trusts Fed'**
  String get homesTrustsFed;

  /// No description provided for @whyFeedNeedy.
  ///
  /// In en, this message translates to:
  /// **'Why Feed the Needy?'**
  String get whyFeedNeedy;

  /// No description provided for @feedNeedyDescription.
  ///
  /// In en, this message translates to:
  /// **'Feeding the needy is an act of kindness and generosity that helps ensure no one goes hungry. It not only nourishes those who are struggling but also contributes to a more compassionate and caring society. When we share what we have, we make the world a better place for everyone.'**
  String get feedNeedyDescription;

  /// No description provided for @feedNeedyKeyPoints.
  ///
  /// In en, this message translates to:
  /// **'• Ensures no one goes hungry.\n• Reduces food waste.\n• Builds a compassionate community.\n• Provides a sense of hope and dignity.\n• Helps create sustainable food systems.'**
  String get feedNeedyKeyPoints;

  /// No description provided for @activeListings.
  ///
  /// In en, this message translates to:
  /// **'Active Listings'**
  String get activeListings;

  /// No description provided for @pendingRequests.
  ///
  /// In en, this message translates to:
  /// **'Pending Requests'**
  String get pendingRequests;

  /// No description provided for @deliveryInProgress.
  ///
  /// In en, this message translates to:
  /// **'Delivery In Progress'**
  String get deliveryInProgress;

  /// No description provided for @pendingApproval.
  ///
  /// In en, this message translates to:
  /// **'Pending Approval'**
  String get pendingApproval;

  /// No description provided for @listingDate.
  ///
  /// In en, this message translates to:
  /// **'Dec {date}'**
  String listingDate(Object date);

  /// No description provided for @uploadFoodDetails.
  ///
  /// In en, this message translates to:
  /// **'Upload Food Details'**
  String get uploadFoodDetails;

  /// No description provided for @foodName.
  ///
  /// In en, this message translates to:
  /// **'Food Name'**
  String get foodName;

  /// No description provided for @foodType.
  ///
  /// In en, this message translates to:
  /// **'Food Type'**
  String get foodType;

  /// No description provided for @foodCategory.
  ///
  /// In en, this message translates to:
  /// **'Food Category'**
  String get foodCategory;

  /// No description provided for @foodCondition.
  ///
  /// In en, this message translates to:
  /// **'Food Condition'**
  String get foodCondition;

  /// No description provided for @packagingType.
  ///
  /// In en, this message translates to:
  /// **'Packaging Type'**
  String get packagingType;

  /// No description provided for @serveWithin.
  ///
  /// In en, this message translates to:
  /// **'Serve Within'**
  String get serveWithin;

  /// No description provided for @numberOfServings.
  ///
  /// In en, this message translates to:
  /// **'Number of Servings'**
  String get numberOfServings;

  /// No description provided for @descriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Description(Tell about ur variety of dishes...)'**
  String get descriptionHint;

  /// No description provided for @whenCooked.
  ///
  /// In en, this message translates to:
  /// **'When was the food cooked?'**
  String get whenCooked;

  /// No description provided for @cookedAt.
  ///
  /// In en, this message translates to:
  /// **'Cooked At: {datetime}'**
  String cookedAt(Object datetime);

  /// No description provided for @pickDateTime.
  ///
  /// In en, this message translates to:
  /// **'Pick Date & Time'**
  String get pickDateTime;

  /// No description provided for @useCurrentGPS.
  ///
  /// In en, this message translates to:
  /// **'Use current GPS address'**
  String get useCurrentGPS;

  /// No description provided for @enterManualAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter manual address'**
  String get enterManualAddress;

  /// No description provided for @fetchCurrentGPS.
  ///
  /// In en, this message translates to:
  /// **'Fetch Current GPS'**
  String get fetchCurrentGPS;

  /// No description provided for @gpsSuccess.
  ///
  /// In en, this message translates to:
  /// **'GPS location fetched successfully!'**
  String get gpsSuccess;

  /// No description provided for @doorNumber.
  ///
  /// In en, this message translates to:
  /// **'Door No'**
  String get doorNumber;

  /// No description provided for @foodGuidelinesConfirmation.
  ///
  /// In en, this message translates to:
  /// **'I confirm that the food is hygienic, safe to eat, and follows the NGO\'s donation guidelines.'**
  String get foodGuidelinesConfirmation;

  /// No description provided for @uploadFood.
  ///
  /// In en, this message translates to:
  /// **'Upload Food'**
  String get uploadFood;

  /// No description provided for @fillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all fields and accept the guidelines'**
  String get fillAllFields;

  /// No description provided for @userNotAuthenticated.
  ///
  /// In en, this message translates to:
  /// **'User not authenticated!'**
  String get userNotAuthenticated;

  /// No description provided for @errorUploadingFood.
  ///
  /// In en, this message translates to:
  /// **'Error uploading food details: {error}'**
  String errorUploadingFood(Object error);

  /// No description provided for @gpsFetchFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch GPS'**
  String get gpsFetchFailed;

  /// No description provided for @gpsLocationFetched.
  ///
  /// In en, this message translates to:
  /// **'GPS location fetched'**
  String get gpsLocationFetched;

  /// No description provided for @donorDashboard.
  ///
  /// In en, this message translates to:
  /// **'Donor Dashboard'**
  String get donorDashboard;

  /// No description provided for @completeYourProfile.
  ///
  /// In en, this message translates to:
  /// **'Complete Your Profile'**
  String get completeYourProfile;

  /// No description provided for @profileIncompleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Your profile is incomplete. Please complete your profile to proceed.'**
  String get profileIncompleteMessage;

  /// No description provided for @goToProfile.
  ///
  /// In en, this message translates to:
  /// **'Go to Profile'**
  String get goToProfile;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @uploadedFood.
  ///
  /// In en, this message translates to:
  /// **'Uploaded Food'**
  String get uploadedFood;

  /// No description provided for @requests.
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get requests;

  /// No description provided for @uploadedFoodDetail.
  ///
  /// In en, this message translates to:
  /// **'Uploaded Food Detail'**
  String get uploadedFoodDetail;

  /// No description provided for @foodId.
  ///
  /// In en, this message translates to:
  /// **'Food ID: {id}'**
  String foodId(Object id);

  /// No description provided for @foodNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Food Name: {name}'**
  String foodNameLabel(Object name);

  /// No description provided for @descriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description: {description}'**
  String descriptionLabel(Object description);

  /// No description provided for @servingsLabel.
  ///
  /// In en, this message translates to:
  /// **'Servings: {count}'**
  String servingsLabel(Object count);

  /// No description provided for @foodTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Food Type: {type}'**
  String foodTypeLabel(Object type);

  /// No description provided for @packageTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Package Type: {type}'**
  String packageTypeLabel(Object type);

  /// No description provided for @foodCategoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Food Category: {category}'**
  String foodCategoryLabel(Object category);

  /// No description provided for @foodConditionLabel.
  ///
  /// In en, this message translates to:
  /// **'Food Condition: {condition}'**
  String foodConditionLabel(Object condition);

  /// No description provided for @cookedAtLabel.
  ///
  /// In en, this message translates to:
  /// **'Cooked At: {time}'**
  String cookedAtLabel(Object time);

  /// No description provided for @uploadedAtLabel.
  ///
  /// In en, this message translates to:
  /// **'Uploaded At: {time}'**
  String uploadedAtLabel(Object time);

  /// No description provided for @statusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status: {status}'**
  String statusLabel(Object status);

  /// No description provided for @deleteFood.
  ///
  /// In en, this message translates to:
  /// **'Delete Food'**
  String get deleteFood;

  /// No description provided for @selectDeletionReason.
  ///
  /// In en, this message translates to:
  /// **'Select Reason for Deletion'**
  String get selectDeletionReason;

  /// No description provided for @foodDistributed.
  ///
  /// In en, this message translates to:
  /// **'Food Distributed'**
  String get foodDistributed;

  /// No description provided for @foodSpoiled.
  ///
  /// In en, this message translates to:
  /// **'Food Spoiled'**
  String get foodSpoiled;

  /// No description provided for @notAvailable.
  ///
  /// In en, this message translates to:
  /// **'Not Available'**
  String get notAvailable;

  /// No description provided for @others.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get others;

  /// No description provided for @foodDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Food item and related requests deleted successfully!'**
  String get foodDeletedSuccess;

  /// No description provided for @deletionCanceled.
  ///
  /// In en, this message translates to:
  /// **'Deletion canceled: No reason selected.'**
  String get deletionCanceled;

  /// No description provided for @loadingUploadedFood.
  ///
  /// In en, this message translates to:
  /// **'Loading your uploaded food...'**
  String get loadingUploadedFood;

  /// No description provided for @noFoodUploaded.
  ///
  /// In en, this message translates to:
  /// **'No food uploaded yet'**
  String get noFoodUploaded;

  /// No description provided for @trackYourDelivery.
  ///
  /// In en, this message translates to:
  /// **'Track Your Delivery'**
  String get trackYourDelivery;

  /// No description provided for @noDeliveryDetails.
  ///
  /// In en, this message translates to:
  /// **'No delivery details available.'**
  String get noDeliveryDetails;

  /// No description provided for @deliveryStatus.
  ///
  /// In en, this message translates to:
  /// **'Delivery Status'**
  String get deliveryStatus;

  /// No description provided for @orderPlaced.
  ///
  /// In en, this message translates to:
  /// **'Order Placed'**
  String get orderPlaced;

  /// No description provided for @waitingForPartner.
  ///
  /// In en, this message translates to:
  /// **'Waiting for Partner'**
  String get waitingForPartner;

  /// No description provided for @partnerAccepted.
  ///
  /// In en, this message translates to:
  /// **'Partner Accepted'**
  String get partnerAccepted;

  /// No description provided for @foodPickedUp.
  ///
  /// In en, this message translates to:
  /// **'Food Picked Up from Donor'**
  String get foodPickedUp;

  /// No description provided for @outForDelivery.
  ///
  /// In en, this message translates to:
  /// **'Out for Delivery'**
  String get outForDelivery;

  /// No description provided for @deliveryInProgressStatus.
  ///
  /// In en, this message translates to:
  /// **'Delivery in Progress'**
  String get deliveryInProgressStatus;

  /// No description provided for @delivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered!'**
  String get delivered;

  /// No description provided for @contactDeliveryPartner.
  ///
  /// In en, this message translates to:
  /// **'Contact Delivery Partner'**
  String get contactDeliveryPartner;

  /// No description provided for @doorDeliveryDetails.
  ///
  /// In en, this message translates to:
  /// **'Door Delivery Details'**
  String get doorDeliveryDetails;

  /// No description provided for @basicDetails.
  ///
  /// In en, this message translates to:
  /// **'Basic Details'**
  String get basicDetails;

  /// No description provided for @recipientName.
  ///
  /// In en, this message translates to:
  /// **'Recipient Name'**
  String get recipientName;

  /// No description provided for @enterRecipientName.
  ///
  /// In en, this message translates to:
  /// **'Enter recipient name'**
  String get enterRecipientName;

  /// No description provided for @recipientPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Recipient Phone Number'**
  String get recipientPhoneNumber;

  /// No description provided for @enterRecipientPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter recipient phone number'**
  String get enterRecipientPhone;

  /// No description provided for @enterEmailId.
  ///
  /// In en, this message translates to:
  /// **'Enter email ID'**
  String get enterEmailId;

  /// No description provided for @enterDoorNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter door number'**
  String get enterDoorNumber;

  /// No description provided for @enterStreet.
  ///
  /// In en, this message translates to:
  /// **'Enter street'**
  String get enterStreet;

  /// No description provided for @enterCity.
  ///
  /// In en, this message translates to:
  /// **'Enter city'**
  String get enterCity;

  /// No description provided for @enterPinCode.
  ///
  /// In en, this message translates to:
  /// **'Enter pin code'**
  String get enterPinCode;

  /// No description provided for @paymentDetails.
  ///
  /// In en, this message translates to:
  /// **'Payment Details'**
  String get paymentDetails;

  /// No description provided for @deliveryChargeAmount.
  ///
  /// In en, this message translates to:
  /// **'Delivery Charge: ₹{amount}'**
  String deliveryChargeAmount(Object amount);

  /// No description provided for @submitDetails.
  ///
  /// In en, this message translates to:
  /// **'Submit Details'**
  String get submitDetails;

  /// No description provided for @pleaseEnter.
  ///
  /// In en, this message translates to:
  /// **'Please enter {field}.'**
  String pleaseEnter(Object field);

  /// No description provided for @deliveryDetailsSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Delivery Details Submitted!'**
  String get deliveryDetailsSubmitted;

  /// No description provided for @errorSavingData.
  ///
  /// In en, this message translates to:
  /// **'Error saving data: {error}'**
  String errorSavingData(Object error);

  /// No description provided for @newOrderAvailable.
  ///
  /// In en, this message translates to:
  /// **'New Order Available!'**
  String get newOrderAvailable;

  /// No description provided for @startFindingWay.
  ///
  /// In en, this message translates to:
  /// **'Hurry! Start Finding ur Way Because Someone is waiting for You!'**
  String get startFindingWay;

  /// No description provided for @availableFoodSearch.
  ///
  /// In en, this message translates to:
  /// **'Search food...'**
  String get availableFoodSearch;

  /// No description provided for @filterLabel.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filterLabel;

  /// No description provided for @categoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get categoryAll;

  /// No description provided for @clearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear Filters'**
  String get clearFilters;

  /// No description provided for @applyFilters.
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get applyFilters;

  /// No description provided for @noActiveListings.
  ///
  /// In en, this message translates to:
  /// **'No active listings available.'**
  String get noActiveListings;

  /// No description provided for @searchErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Error fetching available food: {error}'**
  String searchErrorMessage(Object error);

  /// No description provided for @servingsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Servings'**
  String servingsCount(Object count);

  /// No description provided for @kmDistance.
  ///
  /// In en, this message translates to:
  /// **'{distance} km'**
  String kmDistance(Object distance);

  /// No description provided for @confirmRequest.
  ///
  /// In en, this message translates to:
  /// **'Confirm Request'**
  String get confirmRequest;

  /// No description provided for @confirmRequestMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to request this food?'**
  String get confirmRequestMessage;

  /// No description provided for @requestSentSuccess.
  ///
  /// In en, this message translates to:
  /// **'Request sent successfully'**
  String get requestSentSuccess;

  /// No description provided for @errorSendingRequest.
  ///
  /// In en, this message translates to:
  /// **'Error sending request: {error}'**
  String errorSendingRequest(Object error);

  /// No description provided for @completeProfileFirst.
  ///
  /// In en, this message translates to:
  /// **'Please complete your profile before requesting food'**
  String get completeProfileFirst;

  /// No description provided for @foodDetails.
  ///
  /// In en, this message translates to:
  /// **'Food Details'**
  String get foodDetails;

  /// No description provided for @loadingAddress.
  ///
  /// In en, this message translates to:
  /// **'Loading address...'**
  String get loadingAddress;

  /// No description provided for @showDonorDetails.
  ///
  /// In en, this message translates to:
  /// **'Show Donor Details'**
  String get showDonorDetails;

  /// No description provided for @availableFood.
  ///
  /// In en, this message translates to:
  /// **'Available Food'**
  String get availableFood;

  /// No description provided for @claimedFood.
  ///
  /// In en, this message translates to:
  /// **'Claimed Food'**
  String get claimedFood;

  /// No description provided for @activeFoodListings.
  ///
  /// In en, this message translates to:
  /// **'Active Food Listings'**
  String get activeFoodListings;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @requestApproved.
  ///
  /// In en, this message translates to:
  /// **'Food Request Approved'**
  String get requestApproved;

  /// No description provided for @deliveryInProgressMessage.
  ///
  /// In en, this message translates to:
  /// **'Your requested food is on its way.'**
  String get deliveryInProgressMessage;

  /// No description provided for @untitled.
  ///
  /// In en, this message translates to:
  /// **'Untitled'**
  String get untitled;

  /// No description provided for @errorFetchingFood.
  ///
  /// In en, this message translates to:
  /// **'Error fetching available food: {error}'**
  String errorFetchingFood(Object error);

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @availableFoodTab.
  ///
  /// In en, this message translates to:
  /// **'Available Food'**
  String get availableFoodTab;

  /// No description provided for @yourRequests.
  ///
  /// In en, this message translates to:
  /// **'Your Requests'**
  String get yourRequests;

  /// No description provided for @neederFoodRequests.
  ///
  /// In en, this message translates to:
  /// **'Food Requests'**
  String get neederFoodRequests;

  /// No description provided for @neederHome.
  ///
  /// In en, this message translates to:
  /// **'Needer Home'**
  String get neederHome;

  /// No description provided for @noActiveRequests.
  ///
  /// In en, this message translates to:
  /// **'No active requests'**
  String get noActiveRequests;

  /// No description provided for @searchingForFood.
  ///
  /// In en, this message translates to:
  /// **'Searching for food...'**
  String get searchingForFood;

  /// No description provided for @requestDashboard.
  ///
  /// In en, this message translates to:
  /// **'Request Dashboard'**
  String get requestDashboard;

  /// No description provided for @needyDashboard.
  ///
  /// In en, this message translates to:
  /// **'Needy Dashboard'**
  String get needyDashboard;

  /// No description provided for @foodListingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Food Listings'**
  String get foodListingsTitle;

  /// No description provided for @noHistoryAvailable.
  ///
  /// In en, this message translates to:
  /// **'No history available'**
  String get noHistoryAvailable;

  /// No description provided for @foodListing.
  ///
  /// In en, this message translates to:
  /// **'Food Listing'**
  String get foodListing;

  /// No description provided for @welcomeNeeder.
  ///
  /// In en, this message translates to:
  /// **'Welcome! Home'**
  String get welcomeNeeder;

  /// No description provided for @neederDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Needer Dashboard'**
  String get neederDashboardTitle;

  /// No description provided for @neederAvailableFood.
  ///
  /// In en, this message translates to:
  /// **'Available Food'**
  String get neederAvailableFood;

  /// No description provided for @neederRequests.
  ///
  /// In en, this message translates to:
  /// **'Your Requests'**
  String get neederRequests;

  /// No description provided for @neederDrawerHeader.
  ///
  /// In en, this message translates to:
  /// **'Food Needer'**
  String get neederDrawerHeader;

  /// No description provided for @neederProfile.
  ///
  /// In en, this message translates to:
  /// **'Needer Profile'**
  String get neederProfile;

  /// No description provided for @neederSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get neederSettings;

  /// No description provided for @trackYourRequests.
  ///
  /// In en, this message translates to:
  /// **'Track Your Requests'**
  String get trackYourRequests;

  /// No description provided for @neederNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get neederNotifications;

  /// No description provided for @neederHelp.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get neederHelp;

  /// No description provided for @appVersionText.
  ///
  /// In en, this message translates to:
  /// **'App Version 1.0.0'**
  String get appVersionText;

  /// No description provided for @copyrightText.
  ///
  /// In en, this message translates to:
  /// **'Copyright© 2025 Feed The Needy'**
  String get copyrightText;

  /// No description provided for @requestDetails.
  ///
  /// In en, this message translates to:
  /// **'Request Details'**
  String get requestDetails;

  /// No description provided for @requestIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Request ID'**
  String get requestIdLabel;

  /// No description provided for @foodIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Food ID'**
  String get foodIdLabel;

  /// No description provided for @donorIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Donor ID'**
  String get donorIdLabel;

  /// No description provided for @neederIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Needer ID'**
  String get neederIdLabel;

  /// No description provided for @neederNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Needer Name'**
  String get neederNameLabel;

  /// No description provided for @createdAtLabel.
  ///
  /// In en, this message translates to:
  /// **'Created At'**
  String get createdAtLabel;

  /// No description provided for @donorNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Donor Name'**
  String get donorNameLabel;

  /// No description provided for @organizationNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Organization Name'**
  String get organizationNameLabel;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @chooseDeliveryOption.
  ///
  /// In en, this message translates to:
  /// **'Choose Delivery Option'**
  String get chooseDeliveryOption;

  /// No description provided for @selfPickup.
  ///
  /// In en, this message translates to:
  /// **'Self Pickup'**
  String get selfPickup;

  /// No description provided for @homeDelivery.
  ///
  /// In en, this message translates to:
  /// **'Home Delivery'**
  String get homeDelivery;

  /// No description provided for @trackDelivery.
  ///
  /// In en, this message translates to:
  /// **'Track Delivery'**
  String get trackDelivery;

  /// No description provided for @invalidDeliveryId.
  ///
  /// In en, this message translates to:
  /// **'Invalid delivery ID!'**
  String get invalidDeliveryId;

  /// No description provided for @deliveryNotFound.
  ///
  /// In en, this message translates to:
  /// **'Delivery not found!'**
  String get deliveryNotFound;

  /// No description provided for @welcomeToApp.
  ///
  /// In en, this message translates to:
  /// **'Welcome to FeedtheNeedy App'**
  String get welcomeToApp;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'From hotels to hearts—our app bridges the gap with food and compassion.'**
  String get welcomeMessage;

  /// No description provided for @appSlogan.
  ///
  /// In en, this message translates to:
  /// **'One app, countless smiles'**
  String get appSlogan;

  /// No description provided for @sloganMessage.
  ///
  /// In en, this message translates to:
  /// **'Join us in reducing food waste and feeding those in need.'**
  String get sloganMessage;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started Today'**
  String get getStarted;

  /// No description provided for @getStartedMessage.
  ///
  /// In en, this message translates to:
  /// **'Sign up and choose your role to contribute to the cause.'**
  String get getStartedMessage;

  /// No description provided for @verification.
  ///
  /// In en, this message translates to:
  /// **'Verification'**
  String get verification;

  /// No description provided for @appDescription.
  ///
  /// In en, this message translates to:
  /// **'Reduce food wastage, fight hunger, and build a world where every meal counts.'**
  String get appDescription;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Phone Number'**
  String get enterPhoneNumber;

  /// No description provided for @phoneNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone number cannot be empty'**
  String get phoneNumberRequired;

  /// No description provided for @verificationFailed.
  ///
  /// In en, this message translates to:
  /// **'Verification failed'**
  String get verificationFailed;

  /// No description provided for @otherwise.
  ///
  /// In en, this message translates to:
  /// **'Otherwise'**
  String get otherwise;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @enterOtp.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP'**
  String get enterOtp;

  /// No description provided for @otpScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP'**
  String get otpScreenTitle;

  /// No description provided for @verifyOtp.
  ///
  /// In en, this message translates to:
  /// **'Verify OTP'**
  String get verifyOtp;

  /// No description provided for @otpEmpty.
  ///
  /// In en, this message translates to:
  /// **'OTP cannot be empty'**
  String get otpEmpty;

  /// No description provided for @errorVerifyingOtp.
  ///
  /// In en, this message translates to:
  /// **'Error verifying OTP: {error}'**
  String errorVerifyingOtp(Object error);

  /// No description provided for @selectRole.
  ///
  /// In en, this message translates to:
  /// **'Select Your Role'**
  String get selectRole;

  /// No description provided for @whyRoleImportant.
  ///
  /// In en, this message translates to:
  /// **'Why Role Selection Is Important?'**
  String get whyRoleImportant;

  /// No description provided for @roleSelectionDesc.
  ///
  /// In en, this message translates to:
  /// **'Role selection is crucial in this app to personalize the user experience and direct them to functionalities tailored to their specific role—Food Donor, Needer, or Delivery Partner. This ensures efficient service delivery and smooth interaction within the platform.'**
  String get roleSelectionDesc;

  /// No description provided for @foodDonorRole.
  ///
  /// In en, this message translates to:
  /// **'Food Donor 💚'**
  String get foodDonorRole;

  /// No description provided for @foodNeederRole.
  ///
  /// In en, this message translates to:
  /// **'Food Needer 🏩️'**
  String get foodNeederRole;

  /// No description provided for @deliveryPartnerRole.
  ///
  /// In en, this message translates to:
  /// **'Delivery Partner 🚚'**
  String get deliveryPartnerRole;

  /// No description provided for @cantChangeRole.
  ///
  /// In en, this message translates to:
  /// **'You Can\'t Change the Role Later'**
  String get cantChangeRole;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'NOTE: '**
  String get note;

  /// No description provided for @confirmRoleTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Role Selection'**
  String get confirmRoleTitle;

  /// No description provided for @confirmRoleMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to continue as {role}? This action cannot be changed later.'**
  String confirmRoleMessage(Object role);

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while updating your role. Please try again.'**
  String get errorOccurred;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ta'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ta': return AppLocalizationsTa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
