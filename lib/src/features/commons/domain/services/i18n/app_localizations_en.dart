// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get lblPressAgainToExit => 'Press again to exit';

  @override
  String get lblLogoutSuccess => 'Logout successful';

  @override
  String get lblSessionExpired =>
      'Your session expired — please sign in again.';

  @override
  String get btnContinue => 'Continue';

  @override
  String get btnLetsExplore => 'Let\'s explore';

  @override
  String get btnLogin => 'Log In';

  @override
  String get lblAgreementPart1 =>
      'By continuing, you acknowledge that you have read and agree to our ';

  @override
  String get lblAgreementPart2 => '.';

  @override
  String get lblAlreadyHaveAnAccount => 'Already have an account?';

  @override
  String get lblAnd => ' and ';

  @override
  String get lblComingSoon => 'Coming soon';

  @override
  String get lblDateOfBirthInFuture => 'Date of birth can\'t be in the future';

  @override
  String get lblDateOfBirthInvalid =>
      'This date doesn\'t exist. Check the day, month and year';

  @override
  String lblDateOfBirthTooYoung(int age) {
    return 'You must be at least $age years old';
  }

  @override
  String get lblDay => 'Day';

  @override
  String get lblEnterOtp => 'Verify your number';

  @override
  String get lblEnterPhone => 'Enter your phone number';

  @override
  String get lblFirstName => 'First Name';

  @override
  String get lblFirstNameRequired => 'Please enter your first name';

  @override
  String get lblLastName => 'Last Name';

  @override
  String get lblNameInvalid =>
      'Use letters and spaces only, no numbers or symbols';

  @override
  String lblNameTooLong(int max) {
    return 'Use $max characters or fewer';
  }

  @override
  String get lblMonth => 'Month';

  @override
  String lblOtpSent(Object phone) {
    return 'We\'ve sent 6 digit OTP to $phone.';
  }

  @override
  String get lblPrivacyPolicy => 'Privacy Policy';

  @override
  String get lblRoundFoodForEveryMood => 'Round food for\nevery mood';

  @override
  String get lblLetsGetStarted => 'Let\'s get started';

  @override
  String get lblTermsOfService => 'Terms of Service';

  @override
  String get lblWelcome => 'Welcome';

  @override
  String lblWelcomeBackUser(Object user) {
    return 'Welcome back $user';
  }

  @override
  String get lblWelcomeToTheWorldOfJDonuts =>
      'Welcome to the world of J\'donuts';

  @override
  String get lblWhatsYourDateOfBirth => 'What\'s your date of birth?';

  @override
  String get lblWhatsYourName => 'What\'s your name?';

  @override
  String get lblYear => 'Year';

  @override
  String get lblEnterValidPhoneNumber => 'Enter a valid phone number';

  @override
  String get lblResentCounterResend => 'Resend code';

  @override
  String lblResendIn(String time) {
    return 'Didn\'t receive the code?\nresend in $time min';
  }

  @override
  String get lblOtpWrong => 'That code isn\'t right. Try again';

  @override
  String get lblOtpLocked =>
      'Too many wrong codes. Resend a new code to try again';

  @override
  String lblShopsNearYou(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'There are $count J\'Donut shops near you. 😋',
      one: 'There is 1 J\'Donut shop near you. 😋',
    );
    return '$_temp0';
  }

  @override
  String get btnExploreNow => 'Explore now';

  @override
  String get btnOrderOnline => 'Order online';

  @override
  String lblTierMember(String tier) {
    return '$tier member';
  }

  @override
  String lblPointsToNextTier(String points, String tier) {
    return '$points points left to become $tier Member';
  }

  @override
  String get lblTopTierReached => 'You\'re at the top tier';

  @override
  String get lblTierBronze => 'Bronze';

  @override
  String get lblTierSilver => 'Silver';

  @override
  String get lblTierGold => 'Gold';

  @override
  String get lblNotifications => 'Notifications';

  @override
  String get lblHome => 'Home';

  @override
  String get lblReward => 'Reward';

  @override
  String get lblOrder => 'Order';

  @override
  String get lblWallet => 'Wallet';

  @override
  String get lblSettings => 'Settings';

  @override
  String get lblLogOut => 'Log out';

  @override
  String get lblLogOutConfirmDescription =>
      'You\'ll need to verify your phone number again to sign back in.';

  @override
  String get lblRefresh => 'Retry';

  @override
  String get lblRefreshFailed =>
      'Couldn\'t refresh. Showing the last loaded menu.';

  @override
  String get lblOffline => 'You\'re offline. Showing saved data.';

  @override
  String get lblSectionEmpty => 'Nothing here yet';

  @override
  String get lblSectionError => 'Couldn\'t load this section';

  @override
  String get lblNew => 'New';

  @override
  String get btnAddToCart => 'Add to cart';

  @override
  String lblPriceMmk(String price) {
    return '$price MMK';
  }

  @override
  String get lblWhatsThis => 'What\'s this?';

  @override
  String lblAddedToCart(int quantity, String name) {
    return '$quantity × $name added to cart';
  }

  @override
  String get lblAddToCartFailed => 'Couldn\'t add to cart. Please try again.';

  @override
  String get lblDecreaseQuantity => 'Decrease quantity';

  @override
  String get lblIncreaseQuantity => 'Increase quantity';

  @override
  String lblCartItems(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Items',
      one: '1 Item',
    );
    return '$_temp0';
  }

  @override
  String get btnCheckOut => 'Check Out';

  @override
  String get lblJdonutRewards => 'J\' Donuts Rewards';

  @override
  String get lblRewards => 'Rewards';

  @override
  String get lblTotalPoints => 'Total points';

  @override
  String get lblEatMoreEarnMore => 'Eat more earn more';

  @override
  String get lblGift => 'Gift';

  @override
  String get btnEarn => 'Earn';

  @override
  String lblPointsShort(int points) {
    return '$points pts';
  }

  @override
  String lblChallengeProgress(int current, int target) {
    return '$current/$target';
  }

  @override
  String get lblYoureHereNow => 'You\'re here now';

  @override
  String lblPointsToBecomeTier(String points, String tier) {
    return '$points pts remaining to become $tier';
  }

  @override
  String get lblYoullBeHereSoon => 'You\'ll be here soon';
}
