/* import 'dart:io';

import 'package:wardrobe/configurations/serviceLocator/locator.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wardrobe/global/constants/strings/appStrings/appStrings.dart';

class StorageService {
  Future saveFile({
    required String name,

    ///String
    ///extension without '.' e.g. png, pdf
    required String filyType,

    ///List<int> bytes
    required List<int> bytes,
  }) async {
    Future<String?> _getSavingDir() async {
      try {
        Directory? phoneDir = await getExternalStorageDirectory();

        String newPath = "";
        List<String> paths = phoneDir!.path.split("/");
        for (int x = 1; x < paths.length; x++) {
          String folder = paths[x];
          if (folder != "Android") {
            newPath += "/" + folder;
          } else {
            break;
          }
        }
        String dirPath = '$newPath/Download/${GeneralString.appName}';
        //debugPrint(dirPath);
        Directory ugDir = Directory(dirPath);
        bool dirExists = await ugDir.exists();
        if (!dirExists) {
          ugDir.create();
        }
        return dirPath;
      } on PlatformException catch (e) {
        //debugPrint("Failed to get file directory: '${e.message}'.");
        return null;
      }
    }

    Future<String?> _getPermissionPath() async {
      if (await Permission.storage.request().isGranted) {
        return _getSavingDir().then((value) => value);
      } else {
        UiHelper().showToast(msg: 'Cannot save without storage permission.');
        return null;
      }
    }

    _saveFile(String dirPath) {
      File file = File(dirPath + "/$name.$filyType");
      file.writeAsBytes(bytes).then((value) {
        if (Platform.isAndroid) {
          UiHelper().showToast(
              msg:
                  'File saved successfully on Download/${GeneralString.appName} folder.');
        } else {
          UiHelper().showToast(
              msg:
                  'File saved successfully on ${GeneralString.appName} folder.');
        }
      }).catchError(
          (onError) => UiHelper().showToast(msg: 'Failed to save file.'));
    }

    if (Platform.isIOS) {
      Directory dir = await getApplicationDocumentsDirectory();
      _saveFile(dir.path);
    } else {
      PermissionStatus storagePermission = await Permission.storage.status;
      /*  if (storagePermission.isUndetermined) {
        _getPermissionPath().then((value) {
          if (value != null) _saveFile(value);
        });
      } else */
      if (storagePermission.isDenied) {
        _getPermissionPath().then((value) {
          if (value != null) _saveFile(value);
        });
      } else if (storagePermission.isGranted) {
        _getSavingDir().then((value) {
          if (value != null) _saveFile(value);
        });
      } else
        UiHelper().showToast(msg: 'Please allow storage permission to save.');
    }
  }
}
 */