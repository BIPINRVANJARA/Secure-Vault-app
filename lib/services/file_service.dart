import 'dart:io';
import 'package:secure_vault/core/config/supabase_config.dart';
import 'package:secure_vault/features/files/models/file_model.dart';
import 'package:secure_vault/services/storage_service.dart';
import 'package:mime/mime.dart';

class FileService {
  final _supabase = SupabaseConfig.client;
  final _storageService = StorageService();

  /// Fetch all files for the current user
  Future<List<FileModel>> fetchFiles(String userId) async {
    final response = await _supabase
        .from('files')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => FileModel.fromJson(json))
        .toList();
  }

  /// Upload file with metadata
  Future<FileModel> uploadFile({
    required File file,
    required String userId,
    required String fileName,
  }) async {
    try {
      // 1. Upload to storage
      final bucketPath = await _storageService.uploadFile(
        file: file,
        userId: userId,
        fileName: fileName,
      );

      // 2. Get file metadata
      final mimeType = lookupMimeType(file.path);
      final sizeBytes = await file.length();

      // 3. Insert into database
      final response = await _supabase.from('files').insert({
        'user_id': userId,
        'name': fileName,
        'bucket_path': bucketPath,
        'mime_type': mimeType,
        'size_bytes': sizeBytes,
      }).select().single();

      return FileModel.fromJson(response);
    } catch (e) {
      // If database insert fails, try to clean up storage
      rethrow;
    }
  }

  /// Delete file (both storage and database)
  Future<void> deleteFile(FileModel file) async {
    // 1. Delete from storage
    await _storageService.deleteFile(file.bucketPath);

    // 2. Delete from database
    await _supabase.from('files').delete().eq('id', file.id);
  }

  /// Download file
  Future<List<int>> downloadFile(FileModel file) async {
    return await _storageService.downloadFile(file.bucketPath);
  }
}
