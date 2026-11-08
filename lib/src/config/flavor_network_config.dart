import 'network_config.dart';
import 'package:jdonuts/flavors.dart';

abstract class FlavorizedNetworkConfig {
  static String get baseUrl {
    switch (F.appFlavor) {
      case Flavor.uat:
        return NetworkConfig.stagingDomain;
      default:
        return NetworkConfig.prodDomain;
    }
  }
}
