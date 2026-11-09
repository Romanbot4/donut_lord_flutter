abstract class NetworkConfig {
  static const prodDomain = "https://jdonuts-mock.netlify.app/api";

  static const authStepMinimumDuration = Duration(seconds: 1);

  static const stagingDomain = "https://jdonuts-mock.netlify.app/api";

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
