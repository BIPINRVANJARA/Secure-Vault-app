class AppConstants {
  // Storage
  static const String bucketName = 'vault-files';
  
  // Routes
  static const String loginRoute = '/login';
  static const String signupRoute = '/signup';
  static const String filesRoute = '/files';
  static const String cameraRoute = '/camera';
  
  // File categories
  static const List<String> imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp'];
  static const List<String> videoExtensions = ['mp4', 'avi', 'mkv', 'mov', 'wmv', 'flv', 'webm'];
  static const List<String> documentExtensions = ['pdf', 'doc', 'docx', 'txt', 'rtf', 'odt'];
  static const List<String> codeExtensions = ['py', 'java', 'js', 'jsx', 'ts', 'tsx', 'cpp', 'c', 'dart'];
  static const List<String> archiveExtensions = ['zip', 'rar', '7z', 'tar', 'gz'];
  
  // Upload settings
  static const int imageQuality = 85;
  static const int maxFileSize = 100 * 1024 * 1024; // 100MB
}
