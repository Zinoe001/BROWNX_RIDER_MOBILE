import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_utils/flutter_utils.dart';
import 'package:rider_mobile/core/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

final networkServiceProvider = Provider((ref) {
  final network = NetworkServiceImpl(
    interceptors: [LoggingInterceptor()],
  );
  network.accessToken = ref.watch(localCacheProvider).getToken();
  return network;
});
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(); // This gets overridden in main()
});

final localCacheProvider = Provider<LocalCacheImpl>((ref) {
  final sharedPrefs = ref.watch(sharedPreferencesProvider);
  return LocalCacheImpl(
    sharedPreferences: sharedPrefs,
    userDataStorageKey: CacheKeys.user,
  );
});
