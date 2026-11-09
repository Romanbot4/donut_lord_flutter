abstract class NetworkConfig {
  static const prodDomain = "https://kyawpyaephyo.dev/api";

  static const authStepMinimumDuration = Duration(seconds: 1);

  static const stagingDomain = "http://192.168.18.39:3000/api";

  static const Map<String, String> defaultHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  static const receiveTimeout = Duration(seconds: 8);
  static const connectTimeout = Duration(seconds: 8);
  static const sendTimeout = Duration(seconds: 8);

  static const maxRetries = 2;
  static const retryDelay = Duration(milliseconds: 500);
}
