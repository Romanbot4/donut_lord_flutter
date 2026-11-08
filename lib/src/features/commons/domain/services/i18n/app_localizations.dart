import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_my.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'i18n/app_localizations.dart';
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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('my'),
  ];

  /// No description provided for @lblPressAgainToExit.
  ///
  /// In en, this message translates to:
  /// **'Press again to exit'**
  String get lblPressAgainToExit;

  /// No description provided for @lblLogoutSuccess.
  ///
  /// In en, this message translates to:
  /// **'Logout successful'**
  String get lblLogoutSuccess;

  /// No description provided for @lblSessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Your session expired — please sign in again.'**
  String get lblSessionExpired;

  /// No description provided for @btnContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get btnContinue;

  /// No description provided for @btnLetsExplore.
  ///
  /// In en, this message translates to:
  /// **'Let\'s explore'**
  String get btnLetsExplore;

  /// No description provided for @btnLogin.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get btnLogin;

  /// No description provided for @lblAgreementPart1.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you acknowledge that you have read and agree to our '**
  String get lblAgreementPart1;

  /// No description provided for @lblAgreementPart2.
  ///
  /// In en, this message translates to:
  /// **'.'**
  String get lblAgreementPart2;

  /// No description provided for @lblAlreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get lblAlreadyHaveAnAccount;

  /// No description provided for @lblAnd.
  ///
  /// In en, this message translates to:
  /// **' and '**
  String get lblAnd;

  /// No description provided for @lblComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get lblComingSoon;

  /// No description provided for @lblDateOfBirthInFuture.
  ///
  /// In en, this message translates to:
  /// **'Date of birth can\'t be in the future'**
  String get lblDateOfBirthInFuture;

  /// No description provided for @lblDateOfBirthInvalid.
  ///
  /// In en, this message translates to:
  /// **'This date doesn\'t exist. Check the day, month and year'**
  String get lblDateOfBirthInvalid;

  /// No description provided for @lblDateOfBirthTooYoung.
  ///
  /// In en, this message translates to:
  /// **'You must be at least {age} years old'**
  String lblDateOfBirthTooYoung(int age);

  /// No description provided for @lblDay.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get lblDay;

  /// No description provided for @lblEnterOtp.
  ///
  /// In en, this message translates to:
  /// **'Verify your number'**
  String get lblEnterOtp;

  /// No description provided for @lblEnterPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get lblEnterPhone;

  /// No description provided for @lblFirstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get lblFirstName;

  /// No description provided for @lblFirstNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your first name'**
  String get lblFirstNameRequired;

  /// No description provided for @lblLastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lblLastName;

  /// No description provided for @lblNameInvalid.
  ///
  /// In en, this message translates to:
  /// **'Use letters and spaces only, no numbers or symbols'**
  String get lblNameInvalid;

  /// No description provided for @lblNameTooLong.
  ///
  /// In en, this message translates to:
  /// **'Use {max} characters or fewer'**
  String lblNameTooLong(int max);

  /// No description provided for @lblMonth.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get lblMonth;

  /// No description provided for @lblOtpSent.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent 6 digit OTP to {phone}.'**
  String lblOtpSent(Object phone);

  /// No description provided for @lblPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get lblPrivacyPolicy;

  /// No description provided for @lblRoundFoodForEveryMood.
  ///
  /// In en, this message translates to:
  /// **'Round food for\nevery mood'**
  String get lblRoundFoodForEveryMood;

  /// No description provided for @lblLetsGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Let\'s get started'**
  String get lblLetsGetStarted;

  /// No description provided for @lblTermsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get lblTermsOfService;

  /// No description provided for @lblWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get lblWelcome;

  /// No description provided for @lblWelcomeBackUser.
  ///
  /// In en, this message translates to:
  /// **'Welcome back {user}'**
  String lblWelcomeBackUser(Object user);

  /// No description provided for @lblWelcomeToTheWorldOfJDonuts.
  ///
  /// In en, this message translates to:
  /// **'Welcome to the world of J\'donuts'**
  String get lblWelcomeToTheWorldOfJDonuts;

  /// No description provided for @lblWhatsYourDateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'What\'s your date of birth?'**
  String get lblWhatsYourDateOfBirth;

  /// No description provided for @lblWhatsYourName.
  ///
  /// In en, this message translates to:
  /// **'What\'s your name?'**
  String get lblWhatsYourName;

  /// No description provided for @lblYear.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get lblYear;

  /// No description provided for @lblEnterValidPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number'**
  String get lblEnterValidPhoneNumber;

  /// No description provided for @lblResentCounterResend.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get lblResentCounterResend;

  /// No description provided for @lblResendIn.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code?\nresend in {time} min'**
  String lblResendIn(String time);

  /// No description provided for @lblOtpWrong.
  ///
  /// In en, this message translates to:
  /// **'That code isn\'t right. Try again'**
  String get lblOtpWrong;

  /// No description provided for @lblOtpLocked.
  ///
  /// In en, this message translates to:
  /// **'Too many wrong codes. Resend a new code to try again'**
  String get lblOtpLocked;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'my'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'my':
      return AppLocalizationsMy();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
