import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:secure_vault/core/config/supabase_config.dart';
import 'package:secure_vault/core/constants/app_constants.dart';

class StorageService {
  final SupabaseClient _supabase = SupabaseConfig.client;

  /// Upload file to Supabase Storage
  /// Path format: {userId}/{timestamp}-{filename}
  Future<String> uploadFile({
    required File file,
    required String userId,
    required String fileName,
  }) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final filePath = '$userId/$timestamp-$fileName';

    final bytes = await file.readAsBytes();
    
    await _supabase.storage.from(AppConstants.bucketName).uploadBinary(
          filePath,
          bytes,
        );

    return filePath;
  }

  /// Download file from Supabase Storage
  Future<List<int>> downloadFile(String filePath) async {
    return await _supabase.storage.from(AppConstants.bucketName).download(filePath);
  }

  /// Delete file from Supabase Storage
  Future<void> deleteFile(String filePath) async {
    await _supabase.storage.from(AppConstants.bucketName).remove([filePath]);
  }

  /// Get public URL for a file
  String getPublicUrl(String filePath) {
    return _supabase.storage.from(AppConstants.bucketName).getPublicUrl(filePath);
  }
}
