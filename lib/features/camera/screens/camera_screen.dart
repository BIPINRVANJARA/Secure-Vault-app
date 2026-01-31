import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:secure_vault/features/camera/screens/preview_screen.dart';
import 'package:secure_vault/utils/permission_utils.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _captureImage();
  }

  Future<void> _captureImage() async {
    // Request camera permission
    final hasPermission = await PermissionUtils.requestCameraPermission();
    if (!hasPermission) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Camera permission denied')),
        );
        Navigator.pop(context);
      }
      return;
    }

    // Capture image
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );

    if (image != null && mounted) {
      // Navigate to preview screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewScreen(imageFile: File(image.path)),
        ),
      );
    } else {
      // User cancelled, go back
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera')),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
