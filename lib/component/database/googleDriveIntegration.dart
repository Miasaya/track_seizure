import 'package:googleapis/drive/v3.dart' as go;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final _credentials = new ServiceAccountCredentials.fromJson("/client_id.json");

const _scopes = const [go.DriveApi.DriveFileScope];

class SecureStorage {
  final storage = FlutterSecureStorage();

  //Save Credentials
  Future saveCredentials(AccessToken token, String refreshToken) async {
    print(token.expiry.toIso8601String());
    await storage.write(key: "type", value: token.type);
    await storage.write(key: "data", value: token.data);
    await storage.write(key: "expiry", value: token.expiry.toString());
    await storage.write(key: "refreshToken", value: refreshToken);
  }

  //Get Saved Credentials
  Future<Map<String, dynamic>> getCredentials() async {
    var result = await storage.readAll();
    if (result.length == 0) return null;
    return result;
  }

  //Clear Saved Credentials
  Future clear() {
    return storage.deleteAll();
  }
}

class GoogleDrive {
  final storage = SecureStorage();

  Future<http.Client> getClient() async {
    var credential = await storage.getCredentials();

    if (credential == null) {
      var authClient =
          await clientViaUserConsent(_credentials.clientId, _scopes, (url) {
        launch(url);
      });
      await storage.saveCredentials(authClient.credentials.accessToken,
          authClient.credentials.refreshToken);
      return authClient;
    } else {
      print(credential["expiry"]);
      return authenticatedClient(
          http.Client(),
          AccessCredentials(
              AccessToken(credential["type"], credential["data"],
                  DateTime.tryParse(credential["expiry"])),
              credential["refreshToken"],
              _scopes));
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
}
