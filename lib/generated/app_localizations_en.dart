import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get homeTitle => 'Food Donor Home';

  @override
  String get welcomeFoodDonor => 'Welcome, Food Donor!';

  @override
  String get signOut => 'Sign Out';

  @override
  String get signOutError => 'An error occurred while signing out.';

  @override
  String get drawerHeader => 'Food Donor';

  @override
  String get editProfile => 'Edit';

  @override
  String get home => 'Home';

  @override
  String get profile => 'Profile';

  @override
  String get settings => 'Settings';

  @override
  String get profilePageTitle => 'Profile Page';

  @override
  String get name => 'Name';

  @override
  String get organisationType => 'Organization Type';

  @override
  String get organisationName => 'Organization Name';

  @override
  String get doorNo => 'Door Number';

  @override
  String get street => 'Street';

  @override
  String get nearWhere => 'Near Where';

  @override
  String get city => 'City';

  @override
  String get district => 'District';

  @override
  String get pincode => 'Pincode';

  @override
  String get emailId => 'Email ID';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get saveProfile => 'Save Profile';

  @override
  String get profileSaved => 'Profile saved successfully.';

  @override
  String get errorSavingProfile => 'Error saving profile. Please try again.';

  @override
  String get requiredField => 'This field is required.';

  @override
  String get addProfile => 'Add Profile';

  @override
  String get transactionHistory => 'Transaction History';

  @override
  String get trackStatus => 'Track Status';

  @override
  String get islChatbot => 'ISL Chatbot';

  @override
  String get language => 'Language';

  @override
  String get helpAndSupport => 'Help & Support';

  @override
  String get aboutUs => 'About Us';

  @override
  String get logout => 'Logout';

  @override
  String get logoutConfirmation => 'Are you sure you want to logout?';

  @override
  String get rateUs => 'Rate Us';

  @override
  String get mobileSignalCheck => 'Mobile Signal Check';

  @override
  String get umangGuide => 'UMANG Guide';

  @override
  String get qrCode => 'QR Code';

  @override
  String get updateProfileCompletion => 'Update your profile to complete registration.';

  @override
  String profileCompletionStatus(Object completion) {
    return 'Profile Completion: $completion%';
  }

  @override
  String get vehicleType => 'Vehicle Type';

  @override
  String get vehicleNumber => 'Vehicle Number';

  @override
  String get licenseNumber => 'License Number';

  @override
  String get newOrders => 'New Orders';

  @override
  String get currentOrders => 'current Orders';

  @override
  String get noAvailableOrders => 'No available orders';

  @override
  String get pleaseLoginFirst => 'Please log in first';

  @override
  String get activeDeliveryExists => 'You already have an active delivery';

  @override
  String get orderAcceptedSuccess => 'Order Accepted Successfully';

  @override
  String errorAcceptingOrder(Object error) {
    return 'Error accepting order: $error';
  }

  @override
  String get orderRejected => 'Order Rejected';

  @override
  String errorRejectingOrder(Object error) {
    return 'Error rejecting order: $error';
  }

  @override
  String deliveryIdLabel(Object id) {
    return 'Delivery Id: $id';
  }

  @override
  String locationLabel(Object location) {
    return 'Location: $location';
  }

  @override
  String recipientNameLabel(Object name) {
    return 'Recipient Name: $name';
  }

  @override
  String quantityLabel(Object quantity) {
    return 'Quantity: $quantity';
  }

  @override
  String currentStatusLabel(Object status) {
    return 'Current Status: $status';
  }

  @override
  String doorNoLabel(Object doorNo) {
    return 'Door No: $doorNo';
  }

  @override
  String streetNameLabel(Object street) {
    return 'Street Name: $street';
  }

  @override
  String cityLabel(Object city) {
    return 'City: $city';
  }

  @override
  String pincodeLabel(Object pincode) {
    return 'Pincode: $pincode';
  }

  @override
  String paymentModeLabel(Object mode) {
    return 'Payment Mode: $mode';
  }

  @override
  String deliveryChargeLabel(Object charge) {
    return 'Delivery charge: $charge';
  }

  @override
  String recipientPhoneLabel(Object phone) {
    return 'Recipient phone: $phone';
  }

  @override
  String recipientEmailLabel(Object email) {
    return 'Recipient Email: $email';
  }

  @override
  String get accept => 'Accept';

  @override
  String get reject => 'Reject';

  @override
  String get noCompletedOrders => 'No Completed Orders';

  @override
  String orderId(Object id) {
    return 'Order ID: $id';
  }

  @override
  String get addressLabel => 'Address:';

  @override
  String get contactDetailsLabel => 'Contact Details:';

  @override
  String completedOnLabel(Object date) {
    return 'Completed On: $date';
  }

  @override
  String get noActiveDelivery => 'No Active Delivery';

  @override
  String get notifyDeliveryMessage => 'We will Notify you when you get a delivery';

  @override
  String get deliveryProgress => 'Delivery Progress';

  @override
  String steps(Object current, Object total) {
    return '$current/$total Steps';
  }

  @override
  String get addressDetails => 'Address';

  @override
  String get cantUpdateStatus => 'Cannot update status further';

  @override
  String statusUpdated(Object status) {
    return 'Status updated to \"$status\"';
  }

  @override
  String errorUpdatingStatus(Object error) {
    return 'Error updating status: $error';
  }

  @override
  String get cantLaunchMaps => 'Could not launch Google Maps';

  @override
  String errorFetchingLocation(Object error) {
    return 'Error fetching location: $error';
  }

  @override
  String get viewFoodLocation => 'View Food Location';

  @override
  String get viewDeliveryLocation => 'View Delivery Location';

  @override
  String get updateStatus => 'Update Status';

  @override
  String get completeAllFields => 'Please complete all required fields';

  @override
  String get capturePhoto => 'Capture Photo';

  @override
  String get additionalNotes => 'Additional Notes';

  @override
  String get cancel => 'Cancel';

  @override
  String confirm(Object action) {
    return 'Confirm $action';
  }

  @override
  String get deliveryPartnerTitle => 'Delivery Partner';

  @override
  String get hey => 'Hey!';

  @override
  String get myProfile => 'My Profile';

  @override
  String get viewDeliveryDetails => 'View Delivery Details';

  @override
  String errorFetchingDeliveryData(Object error) {
    return 'Error fetching delivery data: $error';
  }

  @override
  String get finished => 'Finished';

  @override
  String appVersion(Object version) {
    return 'App Version $version';
  }

  @override
  String get pendingDeliveries => 'Pending Deliveries';

  @override
  String get completedDeliveries => 'Completed Deliveries';

  @override
  String get makingDifference => 'Making a Difference';

  @override
  String get makingDifferenceContent => 'Every delivery ensures food reaches someone in need. You are creating an impact!';

  @override
  String get timelyAssistance => 'Timely Assistance';

  @override
  String get timelyAssistanceContent => 'Your dedication ensures food is delivered fresh and on time!';

  @override
  String get buildingHope => 'Building Hope';

  @override
  String get buildingHopeContent => 'By connecting donors and needers, you are building hope for a better tomorrow.';

  @override
  String get whyPartnerMatters => 'Why Being a Delivery Partner Matters?';

  @override
  String get partnerRoleDescription => 'As a delivery partner, you play a vital role in bridging the gap between those willing to give and those in need. Your efforts ensure timely delivery of food to the hungry, making an impact one delivery at a time. Your dedication contributes to a hunger-free community.';

  @override
  String get keyPoints => '• Connects food to the needy.\n• Reduces food waste.\n• Fosters a hunger-free community.\n• Provides timely assistance.\n• Helps save lives and build hope.';

  @override
  String get noUserLoggedIn => 'No user logged in';

  @override
  String get errorFetchingData => 'Error fetching data';

  @override
  String get noDataAvailable => 'No data available';

  @override
  String get profileCompletion => 'Profile Completion';

  @override
  String percentComplete(Object percent) {
    return '$percent% Complete';
  }

  @override
  String get completeProfile => 'Complete Profile';

  @override
  String get confirmSignOut => 'Confirm Sign Out';

  @override
  String get signOutConfirmation => 'Are you sure you want to sign out?';

  @override
  String get signOutButton => 'Sign Out';

  @override
  String get totalFoodUploads => 'Total Food Uploads';

  @override
  String get totalServed => 'Total Served';

  @override
  String get peopleFed => 'People Fed';

  @override
  String get homesTrustsFed => 'Homes/Trusts Fed';

  @override
  String get whyFeedNeedy => 'Why Feed the Needy?';

  @override
  String get feedNeedyDescription => 'Feeding the needy is an act of kindness and generosity that helps ensure no one goes hungry. It not only nourishes those who are struggling but also contributes to a more compassionate and caring society. When we share what we have, we make the world a better place for everyone.';

  @override
  String get feedNeedyKeyPoints => '• Ensures no one goes hungry.\n• Reduces food waste.\n• Builds a compassionate community.\n• Provides a sense of hope and dignity.\n• Helps create sustainable food systems.';

  @override
  String get activeListings => 'Active Listings';

  @override
  String get pendingRequests => 'Pending Requests';

  @override
  String get deliveryInProgress => 'Delivery In Progress';

  @override
  String get pendingApproval => 'Pending Approval';

  @override
  String listingDate(Object date) {
    return 'Dec $date';
  }

  @override
  String get uploadFoodDetails => 'Upload Food Details';

  @override
  String get foodName => 'Food Name';

  @override
  String get foodType => 'Food Type';

  @override
  String get foodCategory => 'Food Category';

  @override
  String get foodCondition => 'Food Condition';

  @override
  String get packagingType => 'Packaging Type';

  @override
  String get serveWithin => 'Serve Within';

  @override
  String get numberOfServings => 'Number of Servings';

  @override
  String get descriptionHint => 'Description(Tell about ur variety of dishes...)';

  @override
  String get whenCooked => 'When was the food cooked?';

  @override
  String cookedAt(Object datetime) {
    return 'Cooked At: $datetime';
  }

  @override
  String get pickDateTime => 'Pick Date & Time';

  @override
  String get useCurrentGPS => 'Use current GPS address';

  @override
  String get enterManualAddress => 'Enter manual address';

  @override
  String get fetchCurrentGPS => 'Fetch Current GPS';

  @override
  String get gpsSuccess => 'GPS location fetched successfully!';

  @override
  String get doorNumber => 'Door No';

  @override
  String get foodGuidelinesConfirmation => 'I confirm that the food is hygienic, safe to eat, and follows the NGO\'s donation guidelines.';

  @override
  String get uploadFood => 'Upload Food';

  @override
  String get fillAllFields => 'Please fill in all fields and accept the guidelines';

  @override
  String get userNotAuthenticated => 'User not authenticated!';

  @override
  String errorUploadingFood(Object error) {
    return 'Error uploading food details: $error';
  }

  @override
  String get gpsFetchFailed => 'Failed to fetch GPS';

  @override
  String get gpsLocationFetched => 'GPS location fetched';

  @override
  String get donorDashboard => 'Donor Dashboard';

  @override
  String get completeYourProfile => 'Complete Your Profile';

  @override
  String get profileIncompleteMessage => 'Your profile is incomplete. Please complete your profile to proceed.';

  @override
  String get goToProfile => 'Go to Profile';

  @override
  String get loading => 'Loading...';

  @override
  String get uploadedFood => 'Uploaded Food';

  @override
  String get requests => 'Requests';

  @override
  String get uploadedFoodDetail => 'Uploaded Food Detail';

  @override
  String foodId(Object id) {
    return 'Food ID: $id';
  }

  @override
  String foodNameLabel(Object name) {
    return 'Food Name: $name';
  }

  @override
  String descriptionLabel(Object description) {
    return 'Description: $description';
  }

  @override
  String servingsLabel(Object count) {
    return 'Servings: $count';
  }

  @override
  String foodTypeLabel(Object type) {
    return 'Food Type: $type';
  }

  @override
  String packageTypeLabel(Object type) {
    return 'Package Type: $type';
  }

  @override
  String foodCategoryLabel(Object category) {
    return 'Food Category: $category';
  }

  @override
  String foodConditionLabel(Object condition) {
    return 'Food Condition: $condition';
  }

  @override
  String cookedAtLabel(Object time) {
    return 'Cooked At: $time';
  }

  @override
  String uploadedAtLabel(Object time) {
    return 'Uploaded At: $time';
  }

  @override
  String statusLabel(Object status) {
    return 'Status: $status';
  }

  @override
  String get deleteFood => 'Delete Food';

  @override
  String get selectDeletionReason => 'Select Reason for Deletion';

  @override
  String get foodDistributed => 'Food Distributed';

  @override
  String get foodSpoiled => 'Food Spoiled';

  @override
  String get notAvailable => 'Not Available';

  @override
  String get others => 'Others';

  @override
  String get foodDeletedSuccess => 'Food item and related requests deleted successfully!';

  @override
  String get deletionCanceled => 'Deletion canceled: No reason selected.';

  @override
  String get loadingUploadedFood => 'Loading your uploaded food...';

  @override
  String get noFoodUploaded => 'No food uploaded yet';

  @override
  String get trackYourDelivery => 'Track Your Delivery';

  @override
  String get noDeliveryDetails => 'No delivery details available.';

  @override
  String get deliveryStatus => 'Delivery Status';

  @override
  String get orderPlaced => 'Order Placed';

  @override
  String get waitingForPartner => 'Waiting for Partner';

  @override
  String get partnerAccepted => 'Partner Accepted';

  @override
  String get foodPickedUp => 'Food Picked Up from Donor';

  @override
  String get outForDelivery => 'Out for Delivery';

  @override
  String get deliveryInProgressStatus => 'Delivery in Progress';

  @override
  String get delivered => 'Delivered!';

  @override
  String get contactDeliveryPartner => 'Contact Delivery Partner';

  @override
  String get doorDeliveryDetails => 'Door Delivery Details';

  @override
  String get basicDetails => 'Basic Details';

  @override
  String get recipientName => 'Recipient Name';

  @override
  String get enterRecipientName => 'Enter recipient name';

  @override
  String get recipientPhoneNumber => 'Recipient Phone Number';

  @override
  String get enterRecipientPhone => 'Enter recipient phone number';

  @override
  String get enterEmailId => 'Enter email ID';

  @override
  String get enterDoorNumber => 'Enter door number';

  @override
  String get enterStreet => 'Enter street';

  @override
  String get enterCity => 'Enter city';

  @override
  String get enterPinCode => 'Enter pin code';

  @override
  String get paymentDetails => 'Payment Details';

  @override
  String deliveryChargeAmount(Object amount) {
    return 'Delivery Charge: ₹$amount';
  }

  @override
  String get submitDetails => 'Submit Details';

  @override
  String pleaseEnter(Object field) {
    return 'Please enter $field.';
  }

  @override
  String get deliveryDetailsSubmitted => 'Delivery Details Submitted!';

  @override
  String errorSavingData(Object error) {
    return 'Error saving data: $error';
  }

  @override
  String get newOrderAvailable => 'New Order Available!';

  @override
  String get startFindingWay => 'Hurry! Start Finding ur Way Because Someone is waiting for You!';

  @override
  String get availableFoodSearch => 'Search food...';

  @override
  String get filterLabel => 'Filters';

  @override
  String get categoryAll => 'All';

  @override
  String get clearFilters => 'Clear Filters';

  @override
  String get applyFilters => 'Apply Filters';

  @override
  String get noActiveListings => 'No active listings available.';

  @override
  String searchErrorMessage(Object error) {
    return 'Error fetching available food: $error';
  }

  @override
  String servingsCount(Object count) {
    return '$count Servings';
  }

  @override
  String kmDistance(Object distance) {
    return '$distance km';
  }

  @override
  String get confirmRequest => 'Confirm Request';

  @override
  String get confirmRequestMessage => 'Are you sure you want to request this food?';

  @override
  String get requestSentSuccess => 'Request sent successfully';

  @override
  String errorSendingRequest(Object error) {
    return 'Error sending request: $error';
  }

  @override
  String get completeProfileFirst => 'Please complete your profile before requesting food';

  @override
  String get foodDetails => 'Food Details';

  @override
  String get loadingAddress => 'Loading address...';

  @override
  String get showDonorDetails => 'Show Donor Details';

  @override
  String get availableFood => 'Available Food';

  @override
  String get claimedFood => 'Claimed Food';

  @override
  String get activeFoodListings => 'Active Food Listings';

  @override
  String get notifications => 'Notifications';

  @override
  String get requestApproved => 'Food Request Approved';

  @override
  String get deliveryInProgressMessage => 'Your requested food is on its way.';

  @override
  String get untitled => 'Untitled';

  @override
  String errorFetchingFood(Object error) {
    return 'Error fetching available food: $error';
  }

  @override
  String get dashboard => 'Dashboard';

  @override
  String get availableFoodTab => 'Available Food';

  @override
  String get yourRequests => 'Your Requests';

  @override
  String get neederFoodRequests => 'Food Requests';

  @override
  String get neederHome => 'Needer Home';

  @override
  String get noActiveRequests => 'No active requests';

  @override
  String get searchingForFood => 'Searching for food...';

  @override
  String get requestDashboard => 'Request Dashboard';

  @override
  String get needyDashboard => 'Needy Dashboard';

  @override
  String get foodListingsTitle => 'Food Listings';

  @override
  String get noHistoryAvailable => 'No history available';

  @override
  String get foodListing => 'Food Listing';

  @override
  String get welcomeNeeder => 'Welcome! Home';

  @override
  String get neederDashboardTitle => 'Needer Dashboard';

  @override
  String get neederAvailableFood => 'Available Food';

  @override
  String get neederRequests => 'Your Requests';

  @override
  String get neederDrawerHeader => 'Food Needer';

  @override
  String get neederProfile => 'Needer Profile';

  @override
  String get neederSettings => 'Settings';

  @override
  String get trackYourRequests => 'Track Your Requests';

  @override
  String get neederNotifications => 'Notifications';

  @override
  String get neederHelp => 'Help & Support';

  @override
  String get appVersionText => 'App Version 1.0.0';

  @override
  String get copyrightText => 'Copyright© 2025 Feed The Needy';

  @override
  String get requestDetails => 'Request Details';

  @override
  String get requestIdLabel => 'Request ID';

  @override
  String get foodIdLabel => 'Food ID';

  @override
  String get donorIdLabel => 'Donor ID';

  @override
  String get neederIdLabel => 'Needer ID';

  @override
  String get neederNameLabel => 'Needer Name';

  @override
  String get createdAtLabel => 'Created At';

  @override
  String get donorNameLabel => 'Donor Name';

  @override
  String get organizationNameLabel => 'Organization Name';

  @override
  String get close => 'Close';

  @override
  String get chooseDeliveryOption => 'Choose Delivery Option';

  @override
  String get selfPickup => 'Self Pickup';

  @override
  String get homeDelivery => 'Home Delivery';

  @override
  String get trackDelivery => 'Track Delivery';

  @override
  String get invalidDeliveryId => 'Invalid delivery ID!';

  @override
  String get deliveryNotFound => 'Delivery not found!';

  @override
  String get welcomeToApp => 'Welcome to FeedtheNeedy App';

  @override
  String get welcomeMessage => 'From hotels to hearts—our app bridges the gap with food and compassion.';

  @override
  String get appSlogan => 'One app, countless smiles';

  @override
  String get sloganMessage => 'Join us in reducing food waste and feeding those in need.';

  @override
  String get getStarted => 'Get Started Today';

  @override
  String get getStartedMessage => 'Sign up and choose your role to contribute to the cause.';

  @override
  String get verification => 'Verification';

  @override
  String get appDescription => 'Reduce food wastage, fight hunger, and build a world where every meal counts.';

  @override
  String get enterPhoneNumber => 'Enter Phone Number';

  @override
  String get phoneNumberRequired => 'Phone number cannot be empty';

  @override
  String get verificationFailed => 'Verification failed';

  @override
  String get otherwise => 'Otherwise';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get enterOtp => 'Enter OTP';

  @override
  String get otpScreenTitle => 'Enter OTP';

  @override
  String get verifyOtp => 'Verify OTP';

  @override
  String get otpEmpty => 'OTP cannot be empty';

  @override
  String errorVerifyingOtp(Object error) {
    return 'Error verifying OTP: $error';
  }

  @override
  String get selectRole => 'Select Your Role';

  @override
  String get whyRoleImportant => 'Why Role Selection Is Important?';

  @override
  String get roleSelectionDesc => 'Role selection is crucial in this app to personalize the user experience and direct them to functionalities tailored to their specific role—Food Donor, Needer, or Delivery Partner. This ensures efficient service delivery and smooth interaction within the platform.';

  @override
  String get foodDonorRole => 'Food Donor 💚';

  @override
  String get foodNeederRole => 'Food Needer 🏩️';

  @override
  String get deliveryPartnerRole => 'Delivery Partner 🚚';

  @override
  String get cantChangeRole => 'You Can\'t Change the Role Later';

  @override
  String get note => 'NOTE: ';

  @override
  String get confirmRoleTitle => 'Confirm Role Selection';

  @override
  String confirmRoleMessage(Object role) {
    return 'Are you sure you want to continue as $role? This action cannot be changed later.';
  }

  @override
  String get yes => 'Yes';

  @override
  String get errorOccurred => 'An error occurred while updating your role. Please try again.';

  @override
  String get error => 'Error';
}
