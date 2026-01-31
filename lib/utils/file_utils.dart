import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileUtils {
  /// Save file to device storage
  static Future<String> saveFile(List<int> bytes, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    await file.writeAsBytes(bytes);
    return file.path;
  }

  /// Get file extension
  static String getExtension(String fileName) {
    final parts = fileName.split('.');
    return parts.length > 1 ? parts.last.toLowerCase() : '';
  }

  /// Format file size
  static String formatFileSize(int? bytes) {
    if (bytes == null) return '—';
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  /// Get icon for file category
  static String getCategoryIcon(String category) {
    switch (category) {
      case 'image':
        return '🖼️';
      case 'video':
        return '🎥';
      case 'document':
        return '📄';
      case 'code':
        return '💻';
      case 'archive':
        return '📦';
      case 'audio':
        return '🎵';
      default:
        return '📁';
    }
  }
}
