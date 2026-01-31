import 'package:flutter/material.dart';
import 'package:secure_vault/features/files/models/file_model.dart';

class FileTile extends StatelessWidget {
  final FileModel file;
  final VoidCallback onDownload;
  final VoidCallback onDelete;
  final VoidCallback? onTap;

  const FileTile({
    super.key,
    required this.file,
    required this.onDownload,
    required this.onDelete,
    this.onTap,
  });

  IconData _getCategoryIcon() {
    switch (file.category) {
      case 'image':
        return Icons.image_outlined;
      case 'video':
        return Icons.videocam_outlined;
      case 'document':
        return Icons.description_outlined;
      case 'code':
        return Icons.code_outlined;
      case 'archive':
        return Icons.folder_zip_outlined;
      case 'audio':
        return Icons.audio_file_outlined;
      default:
        return Icons.insert_drive_file_outlined;
    }
  }

  Color _getCategoryColor() {
    switch (file.category) {
      case 'image':
        return Colors.purple;
      case 'video':
        return Colors.orange;
      case 'document':
        return Colors.red;
      case 'code':
        return Colors.blue;
      case 'archive':
        return Colors.amber;
      case 'audio':
        return Colors.pink;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: _getCategoryColor().withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            _getCategoryIcon(),
            color: _getCategoryColor(),
          ),
        ),
        title: Text(
          file.displayName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          '${file.formattedSize} • ${_formatDate(file.createdAt)}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.download_outlined),
              onPressed: onDownload,
              tooltip: 'Download',
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: onDelete,
              color: Colors.red,
              tooltip: 'Delete',
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
