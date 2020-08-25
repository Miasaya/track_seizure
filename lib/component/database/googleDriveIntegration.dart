import 'package:googleapis/drive/v3.dart' as go;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

final _credentials = new ServiceAccountCredentials.fromJson("/client_id.json");

const _scopes = const [go.DriveApi.DriveFileScope];

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/drive.readonly'
  ],
);

class AuthManager {
  static Future<GoogleSignInAccount> signIn() async {
    try {
      final account = await _googleSignIn.signIn();
      print('account: ${account?.toString()}');
      return account;
    } catch (error) {
      print(error);
      return null;
    }
  }

  static Future<GoogleSignInAccount> signInSilently() async {
    var account = await _googleSignIn.signInSilently();
    print('account: $account');
    return account;
  }

  static Future<void> signOut() async {
    try {
      _googleSignIn.disconnect();
    } catch (error) {
      print(error);
    }
  }
}


Future upload(File file) async {
  var client = http.Client();
  var drive = go.DriveApi(client);
  var response = await drive.files.create(
      go.File()..name = path.basename(file.absolute.path),
      uploadMedia: go.Media(file.openRead(), file.lengthSync()));

  print("Results ${response.toJson}");
}

