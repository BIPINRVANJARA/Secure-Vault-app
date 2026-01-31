import 'package:secure_vault/features/files/models/file_model.dart';

class FolderNode {
  final String name;
  final String path;
  final List<FileModel> files;
  final Map<String, FolderNode> subfolders;
  bool isExpanded;

  FolderNode({
    required this.name,
    required this.path,
    this.files = const [],
    Map<String, FolderNode>? subfolders,
    this.isExpanded = false,
  }) : subfolders = subfolders ?? {};

  // Build folder tree from flat file list
  static FolderNode buildTree(List<FileModel> files, Set<String> expandedPaths) {
    final root = FolderNode(
      name: 'Root',
      path: '',
      files: [],
      subfolders: {},
      isExpanded: true,
    );

    for (final file in files) {
      final parts = file.name.split('/');

      if (parts.length == 1) {
        // File in root
        root.files.add(file);
      } else {
        // File in folder(s)
        FolderNode currentNode = root;

        // Navigate/create folder structure
        for (int i = 0; i < parts.length - 1; i++) {
          final folderName = parts[i];
          final folderPath = parts.sublist(0, i + 1).join('/');

          if (!currentNode.subfolders.containsKey(folderName)) {
            currentNode.subfolders[folderName] = FolderNode(
              name: folderName,
              path: folderPath,
              files: [],
              subfolders: {},
              isExpanded: expandedPaths.contains(folderPath),
            );
          }

          currentNode = currentNode.subfolders[folderName]!;
        }

        // Add file to the deepest folder
        currentNode.files.add(file);
      }
    }

    return root;
  }

  // Get total file count recursively
  int get totalFileCount {
    int count = files.length;
    for (final subfolder in subfolders.values) {
      count += subfolder.totalFileCount;
    }
    return count;
  }

  // Get all files recursively
  List<FileModel> getAllFiles() {
    final allFiles = <FileModel>[...files];
    for (final subfolder in subfolders.values) {
      allFiles.addAll(subfolder.getAllFiles());
    }
    return allFiles;
  }
}
