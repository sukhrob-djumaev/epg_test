import 'package:flutter/material.dart';

class AppAsyncError extends StatelessWidget {
  final String text;
  final VoidCallback onRetry;
  const AppAsyncError({super.key, required this.text, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(text), TextButton(onPressed: onRetry, child: const Text("Retry"))],
      ),
    );
  }
}
