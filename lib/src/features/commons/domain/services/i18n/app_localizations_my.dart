// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Burmese (`my`).
class AppLocalizationsMy extends AppLocalizations {
  AppLocalizationsMy([String locale = 'my']) : super(locale);

  @override
  String get lblPressAgainToExit => 'ထွက်ရန် နောက်တစ်ကြိမ်ထပ်နှိပ်ပါ';

  @override
  String get lblLogoutSuccess => 'အကောင့်ထွက်ခြင်းအောင်မြင်ပါသည်';

  @override
  String get lblSessionExpired =>
      'သင်၏ session သက်တမ်းကုန်သွားပါပြီ — ကျေးဇူးပြု၍ ပြန်လည်ဝင်ရောက်ပါ။';

  @override
  String get btnContinue => 'ရှေ့ဆက်ရန်';

  @override
  String get btnLetsExplore => 'စတင်ကြည့်ရှုမယ်';

  @override
  String get btnLogin => 'အကောင့်ဝင်ရန်';

  @override
  String get lblAgreementPart1 => 'ရှေ့ဆက်ခြင်းဖြင့် သင်သည် ';

  @override
  String get lblAgreementPart2 => ' ကို ဖတ်ရှုသဘောတူညီပြီးဖြစ်ပါသည်။';

  @override
  String get lblAlreadyHaveAnAccount => 'အကောင့်ရှိပြီးသားလား?';

  @override
  String get lblAnd => ' နှင့် ';

  @override
  String get lblComingSoon => 'မကြာမီ ရရှိနိုင်ပါမည်';

  @override
  String get lblDateOfBirthInFuture => 'မွေးနေ့သည် အနာဂတ်ရက် မဖြစ်ရပါ';

  @override
  String get lblDateOfBirthInvalid =>
      'ဤရက်စွဲ မရှိပါ။ ရက်၊ လ နှင့် ခုနှစ်ကို စစ်ဆေးပါ';

  @override
  String lblDateOfBirthTooYoung(int age) {
    return 'အသက် $age နှစ် အနည်းဆုံး ပြည့်ရပါမည်';
  }

  @override
  String get lblDay => 'ရက်';

  @override
  String get lblEnterOtp => 'OTP ထည့်ပါ';

  @override
  String get lblEnterPhone => 'ဖုန်းနံပါတ် ထည့်ပါ';

  @override
  String get lblFirstName => 'အမည်';

  @override
  String get lblFirstNameRequired => 'အမည် ထည့်ပါ';

  @override
  String get lblLastName => 'မျိုးနွယ်အမည်';

  @override
  String get lblNameInvalid =>
      'စာလုံးနှင့် နေရာလွတ်သာ သုံးပါ၊ ဂဏန်း သို့မဟုတ် သင်္ကေတ မသုံးရပါ';

  @override
  String lblNameTooLong(int max) {
    return 'စာလုံး $max လုံးထက် မပိုရပါ';
  }

  @override
  String get lblMonth => 'လ';

  @override
  String lblOtpSent(Object phone) {
    return 'OTP ကို $phone သို့ ပေးပို့ပြီးပါပြီ။';
  }

  @override
  String get lblPrivacyPolicy => 'ကိုယ်ရေးအချက်အလက်မူဝါဒ';

  @override
  String get lblRoundFoodForEveryMood =>
      'စိတ်ခံစားမှုတိုင်းအတွက် အဝိုင်းလေးတွေ';

  @override
  String get lblLetsGetStarted => 'စတင်လိုက်ရအောင်';

  @override
  String get lblTermsOfService => 'သုံးစွဲသူစည်းကမ်းများ';

  @override
  String get lblWelcome => 'ကြိုဆိုပါသည်';

  @override
  String lblWelcomeBackUser(Object user) {
    return 'မင်္ဂလာပါ $user';
  }

  @override
  String get lblWelcomeToTheWorldOfJDonuts => 'J\'donuts ကမ္ဘာမှ ကြိုဆိုပါတယ်';

  @override
  String get lblWhatsYourDateOfBirth => 'သင့်မွေးနေ့ ဘယ်နေ့လဲ?';

  @override
  String get lblWhatsYourName => 'သင့်အမည် ဘယ်လိုခေါ်လဲ?';

  @override
  String get lblYear => 'ခုနှစ်';

  @override
  String get lblEnterValidPhoneNumber => 'မှန်ကန်သော ဖုန်းနံပါတ် ထည့်ပါ';

  @override
  String get lblResentCounterResend => 'ကုဒ်ပြန်ပေးပို့ရန်';

  @override
  String lblResendIn(String time) {
    return 'ကုဒ်မရရှိဘူးလား?\n$time မိနစ်အတွင်း ပြန်ပို့မည်';
  }

  @override
  String get lblOtpWrong => 'ကုဒ်မှားနေပါသည်။ ထပ်စမ်းကြည့်ပါ';

  @override
  String get lblOtpLocked =>
      'ကုဒ်မှားသည်မှာ များလွန်းပါသည်။ ကုဒ်အသစ်ပြန်ပို့ပြီး ထပ်စမ်းပါ';
}
