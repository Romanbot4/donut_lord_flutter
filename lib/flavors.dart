enum Flavor {
  uat,
  prod,
}

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.uat:
        return 'JDonuts UAT';
      case Flavor.prod:
        return 'JDonuts';
    }
  }

}
