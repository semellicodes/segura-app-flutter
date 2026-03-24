import 'package:flutter/material.dart';
import 'package:segura_app/theme/app_colors.dart';

class BotoesZoomWidget extends StatelessWidget {
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;

  const BotoesZoomWidget({
    super.key,
    required this.onZoomIn,
    required this.onZoomOut,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      right: 20,
      child: Column(
        children: [
          FloatingActionButton(
            heroTag: "btnZoomIn",
            backgroundColor: AppColors.ajuda,
            mini: true,
            onPressed: onZoomIn,
            child: const Icon(Icons.add, color: Colors.white),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "btnZoomOut",
            backgroundColor: AppColors.ajuda,
            mini: true,
            onPressed: onZoomOut,
            child: const Icon(Icons.remove, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
