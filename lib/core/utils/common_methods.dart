import 'dart:developer';
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

Future<String?> uploadFileAndGetUrl(
    {required File file, required String path, String bucket = "users"}) async {
  try {
    final supabase = Supabase.instance.client;

    await supabase.storage.from(bucket).upload(
          path,
          file,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
        );

    String fileUrl = supabase.storage.from(bucket).getPublicUrl(path);

    log('File uploaded successfully! File URL: $fileUrl');

    return fileUrl;
  } catch (e) {
    log("UPLOAD_FILE_ERROR: $e");
    return null;
  }
}
