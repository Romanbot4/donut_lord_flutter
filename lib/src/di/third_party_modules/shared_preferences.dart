import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class SharedPreferencesProvider {
  @preResolve
  @lazySingleton
  Future<SharedPreferences> provide() async {
    return await SharedPreferences.getInstance();
  }
}
