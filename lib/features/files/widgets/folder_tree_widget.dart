import 'package:flutter/material.dart';
import 'package:secure_vault/features/files/models/file_model.dart';
import 'package:secure_vault/features/files/models/folder_node.dart';
import 'package:secure_vault/features/files/widgets/file_tile.dart';

class FolderTreeWidget extends StatelessWidget {
  final FolderNode node;
  final Function(String) onToggleFolder;
  final Function(FileModel) onDownload;
  final Function(FileModel) onDelete;
  final int depth;

  const FolderTreeWidget({
    super.key,
    required this.node,
    required this.onToggleFolder,
    required this.onDownload,
    required this.onDelete,
    this.depth = 0,
  });

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[];

    // Add subfolders
    final sortedFolders = node.subfolders.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    for (final entry in sortedFolders) {
      final folderName = entry.key;
      final folderNode = entry.value;

      items.add(
        _buildFolderItem(context, folderName, folderNode),
      );

      // Show folder contents if expanded
      if (folderNode.isExpanded) {
        items.add(
          FolderTreeWidget(
            node: folderNode,
            onToggleFolder: onToggleFolder,
            onDownload: onDownload,
            onDelete: onDelete,
            depth: depth + 1,
          ),
        );
      }
    }

    // Add files in this folder
    final sortedFiles = [...node.files]
      ..sort((a, b) => a.displayName.compareTo(b.displayName));

    for (final file in sortedFiles) {
      items.add(
        Padding(
          padding: EdgeInsets.only(left: depth * 16.0),
          child: FileTile(
            file: file,
            onDownload: () => onDownload(file),
            onDelete: () => onDelete(file),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    );
  }

  Widget _buildFolderItem(
    BuildContext context,
    String folderName,
    FolderNode folderNode,
  ) {
    final fileCount = folderNode.totalFileCount;

    return Padding(
      padding: EdgeInsets.only(left: depth * 16.0),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: InkWell(
          onTap: () => onToggleFolder(folderNode.path),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(
                  folderNode.isExpanded
                      ? Icons.folder_open
                      : Icons.folder,
                  color: Colors.amber,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        folderName,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '$fileCount ${fileCount == 1 ? 'item' : 'items'}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Icon(
                  folderNode.isExpanded
                      ? Icons.expand_less
                      : Icons.expand_more,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
