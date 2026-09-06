import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';

abstract class AuthLocalDataSource {
  Future<void> saveTokens({required String accessToken, required String refreshToken});
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> clearTokens();
  Future<void> saveIdentity({required String userId, required String phoneNumber});
  Future<void> saveFullName(String fullName);
  Future<String?> getFullName();
  Future<void> saveWalletId(String walletId);
  Future<String?> getWalletId();
  Future<void> setHideBalance(bool hide);
  Future<bool> getHideBalance();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage _secureStorage;
  final SharedPreferences _prefs;

  AuthLocalDataSourceImpl({
    FlutterSecureStorage? secureStorage,
    required SharedPreferences prefs,
  })  : _secureStorage = secureStorage ?? const FlutterSecureStorage(),
        _prefs = prefs;

  @override
  Future<void> saveTokens({required String accessToken, required String refreshToken}) async {
    await _secureStorage.write(key: AppConstants.keyAccessToken, value: accessToken);
    await _secureStorage.write(key: AppConstants.keyRefreshToken, value: refreshToken);
  }

  @override
  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: AppConstants.keyAccessToken);
  }

  @override
  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: AppConstants.keyRefreshToken);
  }


  @override
  Future<void> clearTokens() async {
    await _secureStorage.delete(key: AppConstants.keyAccessToken);
    await _secureStorage.delete(key: AppConstants.keyRefreshToken);
    await _secureStorage.delete(key: AppConstants.keyPinToken);
    await _secureStorage.delete(key: AppConstants.keyWalletId);
  }

  @override
  Future<void> saveIdentity({required String userId, required String phoneNumber}) async {
    await _secureStorage.write(key: AppConstants.keyUserId, value: userId);
    await _secureStorage.write(key: AppConstants.keyPhoneNumber, value: phoneNumber);
  }

  @override
  Future<void> saveFullName(String fullName) async {
    await _secureStorage.write(key: AppConstants.keyFullName, value: fullName);
  }

  @override
  Future<String?> getFullName() async {
    return await _secureStorage.read(key: AppConstants.keyFullName);
  }

  @override
  Future<void> saveWalletId(String walletId) async {
    await _secureStorage.write(key: AppConstants.keyWalletId, value: walletId);
  }

  @override
  Future<String?> getWalletId() async {
    return await _secureStorage.read(key: AppConstants.keyWalletId);
  }

  @override
  Future<void> setHideBalance(bool hide) async {
    await _prefs.setBool(AppConstants.keyHideBalance, hide);
  }

  @override
  Future<bool> getHideBalance() async {
    return _prefs.getBool(AppConstants.keyHideBalance) ?? false;
  }
}
