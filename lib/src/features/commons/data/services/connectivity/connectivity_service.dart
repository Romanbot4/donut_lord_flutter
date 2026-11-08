import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/config/config.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';

@LazySingleton(as: IConnectivity)
class ConnectivityService implements IConnectivity {
  final Connectivity _connectivity;
  final Dio _probe;

  ConnectivityService(this._connectivity)
    : _probe = Dio(
        BaseOptions(
          connectTimeout: _probeTimeout,
          receiveTimeout: _probeTimeout,
        ),
      );

  static const _probeTimeout = Duration(seconds: 3);

  @override
  Stream<bool> get onlineChanges =>
      _connectivity.onConnectivityChanged.asyncMap((_) => isOnline()).distinct();

  @override
  Future<bool> isOnline() async {
    final links = await _connectivity.checkConnectivity();
    if (links.every((link) => link == ConnectivityResult.none)) return false;
    return _canReachServer();
  }

  Future<bool> _canReachServer() async {
    try {
      await _probe.head<void>(FlavorizedNetworkConfig.baseUrl);
      return true;
    } on DioException catch (e) {
      return e.response != null;
    }
  }
}
