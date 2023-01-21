import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricsAuthUtils{
  static final  localAuth = LocalAuthentication();

  static Future<bool?> authenticate()async{

    final hasBiometric = await localAuth.canCheckBiometrics;
    if(!hasBiometric) return false;
    try {
      return await localAuth.authenticate(
          localizedReason: 'use finger print to continue');

    } on PlatformException catch (e) {
      return false;
    }

  }
}