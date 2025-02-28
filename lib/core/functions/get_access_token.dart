// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

Future<String> getAccessToken() async {
  String accessToken = '';
  try {
    final serviceAccountJson =
        await rootBundle.loadString('assets/firebase-adminsdk.json');
    final accountCredentials = ServiceAccountCredentials.fromJson(
      json.decode(serviceAccountJson),
    );
    const scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
    final client = http.Client();
    try {
      final accessCredentials = await obtainAccessCredentialsViaServiceAccount(
        accountCredentials,
        scopes,
        client,
      );
      accessToken = accessCredentials.accessToken.data;
      print('Access Token: $accessToken');
    } catch (e) {
      print('Error obtaining access token: $e');
    } finally {
      client.close();
    }
  } catch (e) {
    print('Error loading service account JSON: $e');
  }
  return accessToken;
}
