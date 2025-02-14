import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get homeTitle => 'பதார்த்த தானியக்க வீட்டில்';

  @override
  String get welcomeFoodDonor => 'வரவேற்கின்றேன், உணவு தானியக்கர்!';

  @override
  String get signOut => 'வெளியேறு';

  @override
  String get signOutError => 'வெளியேறும் போது ஒரு பிழை ஏற்பட்டது.';

  @override
  String get drawerHeader => 'உணவு தானியக்கர்';

  @override
  String get editProfile => 'திருத்து';

  @override
  String get home => 'முகப்பு';

  @override
  String get profile => 'சுயவிவரம்';

  @override
  String get settings => 'அமைப்புகள்';

  @override
  String get profilePageTitle => 'சுயவிவரப் பக்கம்';

  @override
  String get name => 'பெயர்';

  @override
  String get organisationType => 'அமைப்பின் வகை';

  @override
  String get organisationName => 'அமைப்பின் பெயர்';

  @override
  String get doorNo => 'வாயிலின் எண்';

  @override
  String get street => 'விடுதி';

  @override
  String get nearWhere => 'எங்கே அருகில்';

  @override
  String get city => 'நகரம்';

  @override
  String get district => 'சுற்று';

  @override
  String get pincode => 'பின்கோடு';

  @override
  String get emailId => 'மின்னஞ்சல் ஐடி';

  @override
  String get phoneNumber => 'தொலைபேசி எண்';

  @override
  String get saveProfile => 'சுயவிவரத்தை சேமி';

  @override
  String get profileSaved => 'சுயவிவரம் வெற்றிகரமாக சேமிக்கப்பட்டது.';

  @override
  String get errorSavingProfile => 'சுயவிவரத்தை சேமிக்கும்போது பிழை ஏற்பட்டது. மறுபடியும் முயற்சிக்கவும்.';

  @override
  String get requiredField => 'இந்த களம் தேவையானது.';

  @override
  String get addProfile => 'சுயவிவரத்தைச் சேர்க்கவும்';

  @override
  String get transactionHistory => 'பண பரிவர்த்தனை வரலாறு';

  @override
  String get trackStatus => 'நிலைமையைத் தொடர்';

  @override
  String get islChatbot => 'ISL வட்டார ஆட்டோபோட்';

  @override
  String get language => 'மொழி';

  @override
  String get helpAndSupport => 'உதவி & ஆதரவு';

  @override
  String get aboutUs => 'எங்களைப் பற்றி';

  @override
  String get logout => 'பற்றி வெளியேறு';

  @override
  String get logoutConfirmation => 'நீங்கள் வெளியேற விரும்புகிறீர்களா?';

  @override
  String get rateUs => 'எங்களை மதிப்பிடுக';

  @override
  String get mobileSignalCheck => 'கைபேசி சிக்னல் பரிசோதனை';

  @override
  String get umangGuide => 'உமாங் வழிகாட்டி';

  @override
  String get qrCode => 'QR குறியீடு';

  @override
  String get updateProfileCompletion => 'பதிவிடலை முடிக்க உங்கள் சுயவிவரத்தை புதுப்பிக்கவும்.';

  @override
  String profileCompletionStatus(Object completion) {
    return 'சுயவிவர நிறைவு: $completion%';
  }

  @override
  String get vehicleType => 'வாகன வகை';

  @override
  String get vehicleNumber => 'வாகன எண்';

  @override
  String get licenseNumber => 'அங்கீகாரம் எண்';

  @override
  String get newOrders => 'New Orders';

  @override
  String get currentOrders => 'current Orders';

  @override
  String get noAvailableOrders => 'ஆர்டர்கள் எதுவும் இல்லை';

  @override
  String get pleaseLoginFirst => 'முதலில் உள்நுழையவும்';

  @override
  String get activeDeliveryExists => 'உங்களிடம் ஏற்கனவே ஒரு செயலில் உள்ள டெலிவரி உள்ளது';

  @override
  String get orderAcceptedSuccess => 'ஆர்டர் வெற்றிகரமாக ஏற்கப்பட்டது';

  @override
  String errorAcceptingOrder(Object error) {
    return 'ஆர்டரை ஏற்பதில் பிழை: $error';
  }

  @override
  String get orderRejected => 'ஆர்டர் நிராகரிக்கப்பட்டது';

  @override
  String errorRejectingOrder(Object error) {
    return 'ஆர்டரை நிராகரிப்பதில் பிழை: $error';
  }

  @override
  String deliveryIdLabel(Object id) {
    return 'டெலிவரி ஐடி: $id';
  }

  @override
  String locationLabel(Object location) {
    return 'இடம்: $location';
  }

  @override
  String recipientNameLabel(Object name) {
    return 'பெறுநர் பெயர்: $name';
  }

  @override
  String quantityLabel(Object quantity) {
    return 'அளவு: $quantity';
  }

  @override
  String currentStatusLabel(Object status) {
    return 'தற்போதைய நிலை: $status';
  }

  @override
  String doorNoLabel(Object doorNo) {
    return 'கதவு எண்: $doorNo';
  }

  @override
  String streetNameLabel(Object street) {
    return 'தெரு பெயர்: $street';
  }

  @override
  String cityLabel(Object city) {
    return 'நகரம்: $city';
  }

  @override
  String pincodeLabel(Object pincode) {
    return 'பின்கோடு: $pincode';
  }

  @override
  String paymentModeLabel(Object mode) {
    return 'கட்டண முறை: $mode';
  }

  @override
  String deliveryChargeLabel(Object charge) {
    return 'டெலிவரி கட்டணம்: $charge';
  }

  @override
  String recipientPhoneLabel(Object phone) {
    return 'பெறுநர் தொலைபேசி: $phone';
  }

  @override
  String recipientEmailLabel(Object email) {
    return 'பெறுநர் மின்னஞ்சல்: $email';
  }

  @override
  String get accept => 'ஏற்கவும்';

  @override
  String get reject => 'நிராகரிக்கவும்';

  @override
  String get noCompletedOrders => 'முடிக்கப்பட்ட ஆர்டர்கள் எதுவும் இல்லை';

  @override
  String orderId(Object id) {
    return 'ஆர்டர் ஐடி: $id';
  }

  @override
  String get addressLabel => 'முகவரி:';

  @override
  String get contactDetailsLabel => 'தொடர்பு விவரங்கள்:';

  @override
  String completedOnLabel(Object date) {
    return 'முடிக்கப்பட்ட தேதி: $date';
  }

  @override
  String get noActiveDelivery => 'செயலில் உள்ள டெலிவரி இல்லை';

  @override
  String get notifyDeliveryMessage => 'உங்களுக்கு டெலிவரி கிடைக்கும்போது அறிவிப்போம்';

  @override
  String get deliveryProgress => 'டெலிவரி முன்னேற்றம்';

  @override
  String steps(Object current, Object total) {
    return '$current/$total படிகள்';
  }

  @override
  String get addressDetails => 'முகவரி விவரங்கள்';

  @override
  String get cantUpdateStatus => 'நிலையை மேலும் புதுப்பிக்க முடியாது';

  @override
  String statusUpdated(Object status) {
    return 'நிலை \"$status\" க்கு புதுப்பிக்கப்பட்டது';
  }

  @override
  String errorUpdatingStatus(Object error) {
    return 'நிலையை புதுப்பிப்பதில் பிழை: $error';
  }

  @override
  String get cantLaunchMaps => 'Google Maps ஐ திறக்க முடியவில்லை';

  @override
  String errorFetchingLocation(Object error) {
    return 'இருப்பிடத்தை பெறுவதில் பிழை: $error';
  }

  @override
  String get viewFoodLocation => 'உணவு இருப்பிடத்தைக் காண்க';

  @override
  String get viewDeliveryLocation => 'டெலிவரி இருப்பிடத்தைக் காண்க';

  @override
  String get updateStatus => 'நிலையை புதுப்பிக்க';

  @override
  String get completeAllFields => 'அனைத்து தேவையான புலங்களையும் நிரப்பவும்';

  @override
  String get capturePhoto => 'புகைப்படம் எடுக்க';

  @override
  String get additionalNotes => 'கூடுதல் குறிப்புகள்';

  @override
  String get cancel => 'ரத்து செய்';

  @override
  String confirm(Object action) {
    return '$action உறுதிசெய்';
  }

  @override
  String get deliveryPartnerTitle => 'டெலிவரி பார்ட்னர்';

  @override
  String get hey => 'வணக்கம்!';

  @override
  String get myProfile => 'என் சுயவிவரம்';

  @override
  String get viewDeliveryDetails => 'டெலிவரி விவரங்களைக் காண்க';

  @override
  String errorFetchingDeliveryData(Object error) {
    return 'டெலிவரி தரவைப் பெறுவதில் பிழை: $error';
  }

  @override
  String get finished => 'முடிந்தது';

  @override
  String appVersion(Object version) {
    return 'ஆப் பதிப்பு $version';
  }

  @override
  String get pendingDeliveries => 'நிலுவையில் உள்ள டெலிவரிகள்';

  @override
  String get completedDeliveries => 'முடிக்கப்பட்ட டெலிவரிகள்';

  @override
  String get makingDifference => 'மாற்றத்தை உருவாக்குதல்';

  @override
  String get makingDifferenceContent => 'ஒவ்வொரு டெலிவரியும் உணவு தேவைப்படுபவர்களை சென்றடைகிறது. நீங்கள் தாக்கத்தை உருவாக்குகிறீர்கள்!';

  @override
  String get timelyAssistance => 'உரிய நேர உதவி';

  @override
  String get timelyAssistanceContent => 'உங்கள் அர்ப்பணிப்பு உணவு புதிதாகவும் சரியான நேரத்திலும் வழங்கப்படுவதை உறுதி செய்கிறது!';

  @override
  String get buildingHope => 'நம்பிக்கையை கட்டமைத்தல்';

  @override
  String get buildingHopeContent => 'தானியக்கர்களையும் தேவைப்படுபவர்களையும் இணைப்பதன் மூலம், சிறந்த நாளைக்கான நம்பிக்கையை கட்டமைக்கிறீர்கள்.';

  @override
  String get whyPartnerMatters => 'டெலிவரி பார்ட்னராக இருப்பது ஏன் முக்கியம்?';

  @override
  String get partnerRoleDescription => 'ஒரு டெலிவரி பார்ட்னராக, கொடுக்க விரும்புபவர்களுக்கும் தேவைப்படுபவர்களுக்கும் இடையே உள்ள இடைவெளியை நிரப்புவதில் முக்கிய பங்கு வகிக்கிறீர்கள். உங்கள் முயற்சிகள் பசியுள்ளவர்களுக்கு உரிய நேரத்தில் உணவு கிடைப்பதை உறுதி செய்கின்றன.';

  @override
  String get keyPoints => '• தேவைப்படுபவர்களுக்கு உணவை இணைக்கிறது.\n• உணவு வீணாவதைக் குறைக்கிறது.\n• பசியற்ற சமூகத்தை வளர';

  @override
  String get noUserLoggedIn => 'பயனர் உள்நுழையவில்லை';

  @override
  String get errorFetchingData => 'தரவைப் பெறுவதில் பிழை';

  @override
  String get noDataAvailable => 'தரவு எதுவும் இல்லை';

  @override
  String get profileCompletion => 'சுயவிவர நிறைவு';

  @override
  String percentComplete(Object percent) {
    return '$percent% நிறைவு';
  }

  @override
  String get completeProfile => 'சுயவிவரத்தை நிறைவு செய்யவும்';

  @override
  String get confirmSignOut => 'வெளியேறுவதை உறுதிப்படுத்தவும்';

  @override
  String get signOutConfirmation => 'நீங்கள் வெளியேற விரும்புகிறீர்களா?';

  @override
  String get signOutButton => 'வெளியேறு';

  @override
  String get totalFoodUploads => 'மொத்த உணவு பதிவேற்றங்கள்';

  @override
  String get totalServed => 'மொத்தம் வழங்கப்பட்டது';

  @override
  String get peopleFed => 'உணவளித்த மக்கள்';

  @override
  String get homesTrustsFed => 'உணவளித்த இல்லங்கள்/அறக்கட்டளைகள்';

  @override
  String get whyFeedNeedy => 'ஏன் தேவைப்படுபவர்களுக்கு உணவளிக்க வேண்டும்?';

  @override
  String get feedNeedyDescription => 'தேவைப்படுபவர்களுக்கு உணவளிப்பது அன்பு மற்றும் கொடையின் செயல், இது யாரும் பசியுடன் இல்லாமல் இருப்பதை உறுதி செய்கிறது. இது போராடுபவர்களுக்கு ஊட்டச்சத்து அளிப்பதோடு மட்டுமல்லாமல், மிகவும் இரக்கமுள்ள மற்றும் அக்கறை கொண்ட சமூகத்திற்கும் பங்களிக்கிறது.';

  @override
  String get feedNeedyKeyPoints => '• யாரும் பசியுடன் இல்லாமல் இருப்பதை உறுதி செய்கிறது.\n• உணவு வீணாவதைக் குறைக்கிறது.\n• இரக்கமுள்ள சமூகத்தை உருவாக்குகிறது.\n• நம்பிக்கை மற்றும் கண்ணியத்தை வழங்குகிறது.\n• நிலையான உணவு அமைப்புகளை உருவாக்க உதவுகிறது.';

  @override
  String get activeListings => 'செயலில் உள்ள பட்டியல்கள்';

  @override
  String get pendingRequests => 'நிலுவையில் உள்ள கோரிக்கைகள்';

  @override
  String get deliveryInProgress => 'டெலிவரி நடைபெறுகிறது';

  @override
  String get pendingApproval => 'ஒப்புதலுக்காக காத்திருக்கிறது';

  @override
  String listingDate(Object date) {
    return 'டிசம்பர் $date';
  }

  @override
  String get uploadFoodDetails => 'உணவு விவரங்களை பதிவேற்றவும்';

  @override
  String get foodName => 'உணவின் பெயர்';

  @override
  String get foodType => 'உணவு வகை';

  @override
  String get foodCategory => 'உணவு பிரிவு';

  @override
  String get foodCondition => 'உணவின் நிலை';

  @override
  String get packagingType => 'பேக்கேஜிங் வகை';

  @override
  String get serveWithin => 'எவ்வளவு நேரத்திற்குள் பரிமாற வேண்டும்';

  @override
  String get numberOfServings => 'பரிமாறல்களின் எண்ணிக்கை';

  @override
  String get descriptionHint => 'விளக்கம்(உங்கள் உணவு வகைகளைப் பற்றி கூறவும்...)';

  @override
  String get whenCooked => 'உணவு எப்போது சமைக்கப்பட்டது?';

  @override
  String cookedAt(Object datetime) {
    return 'சமைத்த நேரம்: $datetime';
  }

  @override
  String get pickDateTime => 'தேதி & நேரத்தை தேர்வு செய்யவும்';

  @override
  String get useCurrentGPS => 'தற்போதைய GPS முகவரியை பயன்படுத்தவும்';

  @override
  String get enterManualAddress => 'கைமுறை முகவரியை உள்ளிடவும்';

  @override
  String get fetchCurrentGPS => 'தற்போதைய GPS ஐ பெறவும்';

  @override
  String get gpsSuccess => 'GPS இருப்பிடம் வெற்றிகரமாக பெறப்பட்டது!';

  @override
  String get doorNumber => 'கதவு எண்';

  @override
  String get foodGuidelinesConfirmation => 'உணவு சுகாதாரமானது, சாப்பிட பாதுகாப்பானது மற்றும் NGO வின் நன்கொடை வழிகாட்டுதல்களைப் பின்பற்றுகிறது என்று உறுதிப்படுத்துகிறேன்.';

  @override
  String get uploadFood => 'உணவை பதிவேற்றவும்';

  @override
  String get fillAllFields => 'அனைத்து புலங்களையும் நிரப்பி வழிகாட்டுதல்களை ஏற்றுக்கொள்ளவும்';

  @override
  String get userNotAuthenticated => 'பயனர் அங்கீகரிக்கப்படவில்லை';

  @override
  String errorUploadingFood(Object error) {
    return 'உணவு விவரங்களை பதிவேற்றுவதில் பிழை: $error';
  }

  @override
  String get gpsFetchFailed => 'GPS ஐ பெற முடியவில்லை';

  @override
  String get gpsLocationFetched => 'GPS இருப்பிடம் பெறப்பட்டது';

  @override
  String get donorDashboard => 'தானியக்கர் டாஷ்போர்டு';

  @override
  String get completeYourProfile => 'உங்கள் சுயவிவரத்தை நிறைவு செய்யவும்';

  @override
  String get profileIncompleteMessage => 'உங்கள் சுயவிவரம் முழுமையடையவில்லை. தொடர உங்கள் சுயவிவரத்தை நிறைவு செய்யவும்.';

  @override
  String get goToProfile => 'சுயவிவரத்திற்கு செல்லவும்';

  @override
  String get loading => 'ஏற்றுகிறது...';

  @override
  String get uploadedFood => 'பதிவேற்றிய உணவு';

  @override
  String get requests => 'கோரிக்கைகள்';

  @override
  String get uploadedFoodDetail => 'பதிவேற்றிய உணவு விவரம்';

  @override
  String foodId(Object id) {
    return 'உணவு ஐடி: $id';
  }

  @override
  String foodNameLabel(Object name) {
    return 'உணவின் பெயர்: $name';
  }

  @override
  String descriptionLabel(Object description) {
    return 'விளக்கம்: $description';
  }

  @override
  String servingsLabel(Object count) {
    return 'பரிமாறல்கள்: $count';
  }

  @override
  String foodTypeLabel(Object type) {
    return 'உணவு வகை: $type';
  }

  @override
  String packageTypeLabel(Object type) {
    return 'பேக்கேஜிங் வகை: $type';
  }

  @override
  String foodCategoryLabel(Object category) {
    return 'உணவு பிரிவு: $category';
  }

  @override
  String foodConditionLabel(Object condition) {
    return 'உணவின் நிலை: $condition';
  }

  @override
  String cookedAtLabel(Object time) {
    return 'சமைத்த நேரம்: $time';
  }

  @override
  String uploadedAtLabel(Object time) {
    return 'பதிவேற்றிய நேரம்: $time';
  }

  @override
  String statusLabel(Object status) {
    return 'நிலை: $status';
  }

  @override
  String get deleteFood => 'உணவை நீக்கவும்';

  @override
  String get selectDeletionReason => 'நீக்குவதற்கான காரணத்தை தேர்வு செய்யவும்';

  @override
  String get foodDistributed => 'உணவு விநியோகிக்கப்பட்டது';

  @override
  String get foodSpoiled => 'உணவு கெட்டுவிட்டது';

  @override
  String get notAvailable => 'கிடைக்கவில்லை';

  @override
  String get others => 'மற்றவை';

  @override
  String get foodDeletedSuccess => 'உணவு மற்றும் தொடர்புடைய கோரிக்கைகள் வெற்றிகரமாக நீக்கப்பட்டன!';

  @override
  String get deletionCanceled => 'நீக்கம் ரத்து செய்யப்பட்டது: காரணம் எதுவும் தேர்வு செய்யப்படவில்லை.';

  @override
  String get loadingUploadedFood => 'உங்கள் பதிவேற்றிய உணவை ஏற்றுகிறது...';

  @override
  String get noFoodUploaded => 'உணவு எதுவும் பதிவேற்றப்படவில்லை';

  @override
  String get trackYourDelivery => 'உங்கள் டெலிவரியைக் கண்காணிக்கவும்';

  @override
  String get noDeliveryDetails => 'டெலிவரி விவரங்கள் எதுவும் இல்லை.';

  @override
  String get deliveryStatus => 'டெலிவரி நிலை';

  @override
  String get orderPlaced => 'ஆர்டர் வைக்கப்பட்டது';

  @override
  String get waitingForPartner => 'பார்ட்னருக்காக காத்திருக்கிறது';

  @override
  String get partnerAccepted => 'பார்ட்னர் ஏற்றுக்கொண்டார்';

  @override
  String get foodPickedUp => 'உணவு தானியக்கரிடமிருந்து எடுக்கப்பட்டது';

  @override
  String get outForDelivery => 'டெலிவரிக்கு புறப்பட்டது';

  @override
  String get deliveryInProgressStatus => 'டெலிவரி நடைபெறுகிறது';

  @override
  String get delivered => 'டெலிவர் செய்யப்பட்டது!';

  @override
  String get contactDeliveryPartner => 'டெலிவரி பார்ட்னரை தொடர்பு கொள்ளவும்';

  @override
  String get doorDeliveryDetails => 'கதவு டெலிவரி விவரங்கள்';

  @override
  String get basicDetails => 'அடிப்படை விவரங்கள்';

  @override
  String get recipientName => 'பெறுநர் பெயர்';

  @override
  String get enterRecipientName => 'பெறுநர் பெயரை உள்ளிடவும்';

  @override
  String get recipientPhoneNumber => 'பெறுநர் தொலைபேசி எண்';

  @override
  String get enterRecipientPhone => 'பெறுநர் தொலைபேசி எண்ணை உள்ளிடவும்';

  @override
  String get enterEmailId => 'மின்னஞ்சல் ஐடியை உள்ளிடவும்';

  @override
  String get enterDoorNumber => 'கதவு எண்ணை உள்ளிடவும்';

  @override
  String get enterStreet => 'தெருவை உள்ளிடவும்';

  @override
  String get enterCity => 'நகரத்தை உள்ளிடவும்';

  @override
  String get enterPinCode => 'பின் கோடை உள்ளிடவும்';

  @override
  String get paymentDetails => 'கட்டண விவரங்கள்';

  @override
  String deliveryChargeAmount(Object amount) {
    return 'டெலிவரி கட்டணம்: ₹$amount';
  }

  @override
  String get submitDetails => 'விவரங்களை சமர்ப்பிக்கவும்';

  @override
  String pleaseEnter(Object field) {
    return '$fieldஐ உள்ளிடவும்.';
  }

  @override
  String get deliveryDetailsSubmitted => 'டெலிவரி விவரங்கள் சமர்ப்பிக்கப்பட்டன!';

  @override
  String errorSavingData(Object error) {
    return 'தரவை சேமிப்பதில் பிழை: $error';
  }

  @override
  String get newOrderAvailable => 'புதிய ஆர்டர் கிடைக்கிறது!';

  @override
  String get startFindingWay => 'விரைவில்! யாரோ உங்களுக்காக காத்திருக்கிறார்கள், வழியைக் கண்டுபிடிக்க ஆரம்பியுங்கள்!';

  @override
  String get availableFoodSearch => 'உணவு தேடுக...';

  @override
  String get filterLabel => 'வடிகட்டிகள்';

  @override
  String get categoryAll => 'அனைத்தும்';

  @override
  String get clearFilters => 'வடிகட்டிகளை அழிக்க';

  @override
  String get applyFilters => 'வடிகட்டிகளை பயன்படுத்து';

  @override
  String get noActiveListings => 'செயலில் உள்ள பட்டியல்கள் எதுவும் இல்லை.';

  @override
  String searchErrorMessage(Object error) {
    return 'கிடைக்கக்கூடிய உணவைப் பெறுவதில் பிழை: $error';
  }

  @override
  String servingsCount(Object count) {
    return '$count பரிமாறல்கள்';
  }

  @override
  String kmDistance(Object distance) {
    return '$distance கி.மீ';
  }

  @override
  String get confirmRequest => 'கோரிக்கையை உறுதிப்படுத்தவும்';

  @override
  String get confirmRequestMessage => 'இந்த உணவை கோர விரும்புகிறீர்களா?';

  @override
  String get requestSentSuccess => 'கோரிக்கை வெற்றிகரமாக அனுப்பப்பட்டது';

  @override
  String errorSendingRequest(Object error) {
    return 'கோரிக்கையை அனுப்புவதில் பிழை: $error';
  }

  @override
  String get completeProfileFirst => 'உணவை கோருவதற்கு முன் உங்கள் சுயவிவரத்தை முடிக்கவும்';

  @override
  String get foodDetails => 'உணவு விவரங்கள்';

  @override
  String get loadingAddress => 'முகவரியை ஏற்றுகிறது...';

  @override
  String get showDonorDetails => 'தானியக்கர் விவரங்களைக் காட்டு';

  @override
  String get availableFood => 'கிடைக்கக்கூடிய உணவு';

  @override
  String get claimedFood => 'கோரப்பட்ட உணவு';

  @override
  String get activeFoodListings => 'செயலில் உள்ள உணவு பட்டியல்கள்';

  @override
  String get notifications => 'அறிவிப்புகள்';

  @override
  String get requestApproved => 'உணவு கோரிக்கை அங்கீகரிக்கப்பட்டது';

  @override
  String get deliveryInProgressMessage => 'உங்கள் கோரிய உணவு வழியில் உள்ளது.';

  @override
  String get untitled => 'தலைப்பிடப்படாதது';

  @override
  String errorFetchingFood(Object error) {
    return 'கிடைக்கக்கூடிய உணவைப் பெறுவதில் பிழை: $error';
  }

  @override
  String get dashboard => 'டாஷ்போர்டு';

  @override
  String get availableFoodTab => 'கிடைக்கக்கூடிய உணவு';

  @override
  String get yourRequests => 'உங்கள் கோரிக்கைகள்';

  @override
  String get neederFoodRequests => 'உணவு கோரிக்கைகள்';

  @override
  String get neederHome => 'தேவைப்படுபவர் முகப்பு';

  @override
  String get noActiveRequests => 'செயலில் உள்ள கோரிக்கைகள் எதுவும் இல்லை';

  @override
  String get searchingForFood => 'உணவைத் தேடுகிறது...';

  @override
  String get requestDashboard => 'கோரிக்கை டாஷ்போர்டு';

  @override
  String get needyDashboard => 'தேவைப்படுபவர் டாஷ்போர்டு';

  @override
  String get foodListingsTitle => 'உணவு பட்டியல்கள்';

  @override
  String get noHistoryAvailable => 'வரலாறு எதுவும் இல்லை';

  @override
  String get foodListing => 'உணவு பட்டியல்';

  @override
  String get welcomeNeeder => 'வரவேற்கின்றோம்! முகப்பு';

  @override
  String get neederDashboardTitle => 'உதவி பெறுபவர் டாஷ்போர்டு';

  @override
  String get neederAvailableFood => 'கிடைக்கக்கூடிய உணவு';

  @override
  String get neederRequests => 'உங்கள் கோரிக்கைகள்';

  @override
  String get neederDrawerHeader => 'உணவு உதவி பெறுபவர்';

  @override
  String get neederProfile => 'சுயவிவரம்';

  @override
  String get neederSettings => 'அமைப்புகள்';

  @override
  String get trackYourRequests => 'உங்கள் கோரிக்கைகளை கண்காணிக்க';

  @override
  String get neederNotifications => 'அறிவிப்புகள்';

  @override
  String get neederHelp => 'உதவி & ஆதரவு';

  @override
  String get appVersionText => 'செயலி பதிப்பு 1.0.0';

  @override
  String get copyrightText => 'பதிப்புரிமை© 2025 Feed The Needy';

  @override
  String get requestDetails => 'கோரிக்கை விவரங்கள்';

  @override
  String get requestIdLabel => 'கோரிக்கை ஐடி';

  @override
  String get foodIdLabel => 'உணவு ஐடி';

  @override
  String get donorIdLabel => 'தானியக்கர் ஐடி';

  @override
  String get neederIdLabel => 'தேவைப்படுபவர் ஐடி';

  @override
  String get neederNameLabel => 'தேவைப்படுபவர் பெயர்';

  @override
  String get createdAtLabel => 'உருவாக்கப்பட்ட நேரம்';

  @override
  String get donorNameLabel => 'தானியக்கர் பெயர்';

  @override
  String get organizationNameLabel => 'அமைப்பின் பெயர்';

  @override
  String get close => 'மூடு';

  @override
  String get chooseDeliveryOption => 'டெலிவரி விருப்பத்தை தேர்வு செய்யவும்';

  @override
  String get selfPickup => 'சுய பிக்கப்';

  @override
  String get homeDelivery => 'வீட்டு டெலிவரி';

  @override
  String get trackDelivery => 'டெலிவரியை கண்காணிக்க';

  @override
  String get invalidDeliveryId => 'தவறான டெலிவரி ஐடி!';

  @override
  String get deliveryNotFound => 'டெலிவரி கண்டுபிடிக்கப்படவில்லை!';

  @override
  String get welcomeToApp => 'Feed the Needy செயலிக்கு வரவேற்கிறோம்';

  @override
  String get welcomeMessage => 'ஹோட்டல்களில் இருந்து இதயங்களுக்கு—எங்கள் செயலி உணவு மற்றும் கருணையுடன் இடைவெளியை இணைக்கிறது.';

  @override
  String get appSlogan => 'ஒரு செயலி, எண்ணற்ற புன்னகைகள்';

  @override
  String get sloganMessage => 'உணவு வீணாவதைக் குறைத்து, தேவைப்படுபவர்களுக்கு உணவளிப்பதில் எங்களுடன் இணையுங்கள்.';

  @override
  String get getStarted => 'இன்றே தொடங்குங்கள்';

  @override
  String get getStartedMessage => 'உங்கள் பங்களிப்பை வழங்க பதிவு செய்து உங்கள் பங்கை தேர்வு செய்யுங்கள்.';

  @override
  String get verification => 'சரிபார்ப்பு';

  @override
  String get appDescription => 'உணவு வீணாவதைக் குறைத்து, பசியை எதிர்த்துப் போராடி, ஒவ்வொரு உணவும் முக்கியமான உலகை உருவாக்குங்கள்.';

  @override
  String get enterPhoneNumber => 'தொலைபேசி எண்ணை உள்ளிடவும்';

  @override
  String get phoneNumberRequired => 'தொலைபேசி எண் வெற்றாக இருக்க முடியாது';

  @override
  String get verificationFailed => 'சரிபார்ப்பு தோல்வியடைந்தது';

  @override
  String get otherwise => 'அல்லது';

  @override
  String get continueWithGoogle => 'Google மூலம் தொடரவும்';

  @override
  String get enterOtp => 'OTP ஐ உள்ளிடவும்';

  @override
  String get otpScreenTitle => 'OTP ஐ உள்ளிடவும்';

  @override
  String get verifyOtp => 'OTP ஐ சரிபார்க்கவும்';

  @override
  String get otpEmpty => 'OTP காலியாக இருக்க முடியாது';

  @override
  String errorVerifyingOtp(Object error) {
    return 'OTP சரிபார்ப்பதில் பிழை: $error';
  }

  @override
  String get selectRole => 'உங்கள் பங்கை தேர்வு செய்யவும்';

  @override
  String get whyRoleImportant => 'பங்கு தேர்வு ஏன் முக்கியம்?';

  @override
  String get roleSelectionDesc => 'பயனர் அனுபவத்தை தனிப்பயனாக்க மற்றும் அவர்களின் குறிப்பிட்ட பங்குக்கு ஏற்ற செயல்பாடுகளுக்கு வழிகாட்ட இந்த பயன்பாட்டில் பங்கு தேர்வு முக்கியமானது - உணவு தானியக்கர், தேவைப்படுபவர் அல்லது டெலிவரி பார்ட்னர். இது திறமையான சேவை வழங்கல் மற்றும் தளத்தில் சுமூகமான தொடர்பை உறுதி செய்கிறது.';

  @override
  String get foodDonorRole => 'உணவு தானியக்கர் 💚';

  @override
  String get foodNeederRole => 'உணவு தேவைப்படுபவர் 🏩️';

  @override
  String get deliveryPartnerRole => 'டெலிவரி பார்ட்னர் 🚚';

  @override
  String get cantChangeRole => 'நீங்கள் பிறகு பங்கை மாற்ற முடியாது';

  @override
  String get note => 'குறிப்பு: ';

  @override
  String get confirmRoleTitle => 'பங்கு தேர்வை உறுதிப்படுத்தவும்';

  @override
  String confirmRoleMessage(Object role) {
    return 'நீங்கள் $role ஆக தொடர விரும்புகிறீர்களா? இந்த செயலை பின்னர் மாற்ற முடியாது.';
  }

  @override
  String get yes => 'ஆம்';

  @override
  String get errorOccurred => 'உங்கள் பங்கை புதுப்பிக்கும் போது பிழை ஏற்பட்டது. மீண்டும் முயற்சிக்கவும்.';

  @override
  String get error => 'பிழை';
}
