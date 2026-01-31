import 'package:equatable/equatable.dart';

class FileModel extends Equatable {
  final String id;
  final String userId;
  final String name;
  final String bucketPath;
  final String? mimeType;
  final int? sizeBytes;
  final DateTime createdAt;

  const FileModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.bucketPath,
    this.mimeType,
    this.sizeBytes,
    required this.createdAt,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      bucketPath: json['bucket_path'] as String,
      mimeType: json['mime_type'] as String?,
      sizeBytes: json['size_bytes'] as int?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'bucket_path': bucketPath,
      'mime_type': mimeType,
      'size_bytes': sizeBytes,
      'created_at': createdAt.toIso8601String(),
    };
  }

  String get displayName => name.split('/').last;
  
  String get extension {
    final parts = name.split('.');
    return parts.length > 1 ? parts.last.toLowerCase() : '';
  }
  
  String get category {
    final ext = extension;
    if (['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp'].contains(ext)) return 'image';
    if (['mp4', 'avi', 'mkv', 'mov', 'wmv'].contains(ext)) return 'video';
    if (['pdf', 'doc', 'docx', 'txt', 'rtf'].contains(ext)) return 'document';
    if (['py', 'java', 'js', 'jsx', 'ts', 'tsx', 'dart', 'cpp'].contains(ext)) return 'code';
    if (['zip', 'rar', '7z', 'tar', 'gz'].contains(ext)) return 'archive';
    if (['mp3', 'wav', 'ogg', 'flac', 'm4a'].contains(ext)) return 'audio';
    return 'file';
  }

  String get formattedSize {
    if (sizeBytes == null) return '—';
    final bytes = sizeBytes!;
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  @override
  List<Object?> get props => [id, userId, name, bucketPath, mimeType, sizeBytes, createdAt];
}
