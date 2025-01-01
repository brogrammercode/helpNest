import 'dart:developer';
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

Future<String> uploadFileAndGetUrl(
    {required File file, required String path}) async {
  final supabase = Supabase.instance.client;

  await supabase.storage.from('users').upload(
        path,
        file,
        fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
      );

  String fileUrl = supabase.storage.from('users').getPublicUrl(path);

  log('File uploaded successfully! File URL: $fileUrl');

  return fileUrl;
}
