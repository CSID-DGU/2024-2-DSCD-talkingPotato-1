import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wooahan/data/provider/search_term/search_term_local_provider.dart';
import 'package:wooahan/data/provider/search_term/search_term_local_provider_impl.dart';
import 'package:wooahan/data/provider/system/system_provider.dart';
import 'package:wooahan/data/provider/system/system_provider_impl.dart';
import 'package:wooahan/data/provider/user/user_local_provider.dart';
import 'package:wooahan/data/provider/user/user_local_provider_impl.dart';

class StorageFactory {
  static late final GetStorage _normalStorage;
  static late final FlutterSecureStorage _secureStorage;

  static SystemProvider? _systemProvider;

  static UserLocalProvider? _userLocalProvider;
  static SearchTermLocalProvider? _searchTermLocalProvider;

  static SystemProvider get systemProvider => _systemProvider!;
  static UserLocalProvider get userLocalProvider => _userLocalProvider!;
  static SearchTermLocalProvider get searchTermLocalProvider =>
      _searchTermLocalProvider!;

  static Future<void> onInit() async {
    await GetStorage.init();

    _normalStorage = GetStorage();
    _secureStorage = const FlutterSecureStorage();
  }

  static Future<void> onReady() async {
    _systemProvider = SystemProviderImpl(
      normalStorage: _normalStorage,
      secureStorage: _secureStorage,
    );

    _userLocalProvider = UserLocalProviderImpl(
      storage: _normalStorage,
    );
    _searchTermLocalProvider = SearchTermLocalProviderImpl(
      storage: _normalStorage,
    );

    await _systemProvider!.onInit();
  }
}
