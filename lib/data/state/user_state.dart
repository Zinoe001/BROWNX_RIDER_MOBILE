import 'package:flutter/material.dart';
import 'package:flutter_utils/flutter_utils.dart';
import 'package:rider_mobile/data/model/model.dart';
import 'package:rider_mobile/data/state/base_state.dart';

class UserState extends BaseState {
  final LocalCache _localCache;

  late final ValueNotifier<UserModel?> _user = ValueNotifier(null);
  ValueNotifier<UserModel?> get user => _user;

  UserState(this._localCache) {
    init();
  }

  init() {
    getUserDetails();
  }

  Future<void> getUserDetails() async {
    try {
      final userData = _localCache.getUserData();

      if (userData == null) return;
      _user.value = UserModel.fromJson(userData);
    } catch (e) {
      handleError(e);
    }
  }

  saveCurrentUserDataToCache() async {
    if (user.value != null) {
      saveUserDataToCache(user.value!);
    }
  }

  saveUserDataToCache(UserModel user) async {
    await _localCache.saveUserData(user.toJson());
    _user.value = user;
  }

  void logOut() async {
    user.value = null;
  }
}

// final userStateProvider = Provider(
//   (ref) => UserState(ref.read(localCacheProvider)),
// );
