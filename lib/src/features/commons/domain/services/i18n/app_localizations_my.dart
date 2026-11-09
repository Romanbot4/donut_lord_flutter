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

  @override
  String lblShopsNearYou(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'သင့်အနီးတွင် J\'Donut ဆိုင် $count ဆိုင် ရှိပါသည်။ 😋',
    );
    return '$_temp0';
  }

  @override
  String get btnExploreNow => 'ယခုကြည့်ရှုမည်';

  @override
  String get btnOrderOnline => 'အွန်လိုင်းမှာယူရန်';

  @override
  String lblTierMember(String tier) {
    return '$tier အဖွဲ့ဝင်';
  }

  @override
  String lblPointsToNextTier(String points, String tier) {
    return '$tier အဖွဲ့ဝင်ဖြစ်ရန် $points မှတ် လိုပါသေးသည်';
  }

  @override
  String get lblTopTierReached => 'အမြင့်ဆုံးအဆင့်သို့ ရောက်ပါပြီ';

  @override
  String get lblTierBronze => 'ကြေးဝါ';

  @override
  String get lblTierSilver => 'ငွေ';

  @override
  String get lblTierGold => 'ရွှေ';

  @override
  String get lblNotifications => 'အသိပေးချက်များ';

  @override
  String get lblHome => 'ပင်မ';

  @override
  String get lblReward => 'ဆုလာဘ်';

  @override
  String get lblOrder => 'မှာယူရန်';

  @override
  String get lblWallet => 'ပိုက်ဆံအိတ်';

  @override
  String get lblSettings => 'ဆက်တင်များ';

  @override
  String get lblLogOut => 'ထွက်မည်';

  @override
  String get lblLogOutConfirmDescription =>
      'ပြန်ဝင်ရန် ဖုန်းနံပါတ်ကို ထပ်မံအတည်ပြုရပါမည်။';

  @override
  String get lblRefresh => 'ပြန်ကြိုးစားရန်';

  @override
  String get lblRefreshFailed =>
      'ပြန်လည်မွမ်းမံ၍ မရပါ။ နောက်ဆုံးရရှိထားသော မီနူးကို ပြသထားပါသည်။';

  @override
  String get lblOffline =>
      'အင်တာနက်မရှိပါ။ သိမ်းထားသော အချက်အလက်ကို ပြသထားပါသည်။';

  @override
  String get lblSectionEmpty => 'ဤနေရာတွင် မရှိသေးပါ';

  @override
  String get lblSectionError => 'ဤအပိုင်းကို ဖွင့်၍မရပါ';

  @override
  String get lblNew => 'အသစ်';

  @override
  String get btnAddToCart => 'ခြင်းထဲထည့်မည်';

  @override
  String lblPriceMmk(String price) {
    return '$price ကျပ်';
  }

  @override
  String get lblWhatsThis => 'ဤအရာက ဘာလဲ?';

  @override
  String lblAddedToCart(int quantity, String name) {
    return '$name $quantity ခု ခြင်းထဲ ထည့်ပြီးပါပြီ';
  }

  @override
  String get lblAddToCartFailed => 'ခြင်းထဲ ထည့်၍မရပါ။ ထပ်မံကြိုးစားပါ။';

  @override
  String get lblDecreaseQuantity => 'အရေအတွက် လျှော့ရန်';

  @override
  String get lblIncreaseQuantity => 'အရေအတွက် တိုးရန်';

  @override
  String lblCartItems(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ပစ္စည်း $count ခု',
    );
    return '$_temp0';
  }

  @override
  String get btnCheckOut => 'ငွေရှင်းမည်';

  @override
  String get lblJdonutRewards => 'J\' Donuts ဆုလာဘ်များ';

  @override
  String get lblRewards => 'ဆုလာဘ်များ';

  @override
  String get lblTotalPoints => 'စုစုပေါင်း အမှတ်';

  @override
  String get lblEatMoreEarnMore => 'များများစား များများရ';

  @override
  String get lblGift => 'လက်ဆောင်';

  @override
  String get btnEarn => 'ရယူမည်';

  @override
  String lblPointsShort(int points) {
    return '$points မှတ်';
  }

  @override
  String lblChallengeProgress(int current, int target) {
    return '$current/$target';
  }

  @override
  String get lblYoureHereNow => 'လက်ရှိ ဤအဆင့်တွင် ရှိနေပါသည်';

  @override
  String lblPointsToBecomeTier(String points, String tier) {
    return '$tier ဖြစ်ရန် $points မှတ် လိုပါသေးသည်';
  }

  @override
  String get lblYoullBeHereSoon => 'မကြာမီ ရောက်ရှိပါမည်';

  @override
  String get lblLogOutConfirmTitle => 'အကောင့်မှ ထွက်မလား?';

  @override
  String get btnCancel => 'မလုပ်တော့ပါ';
}
