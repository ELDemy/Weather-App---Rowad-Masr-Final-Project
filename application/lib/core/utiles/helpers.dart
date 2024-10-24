import 'dart:developer';

import 'package:flutter/material.dart';

class Helpers {
  static void showSnackBar(BuildContext context, String text) {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(text)),
      );
    } on Exception catch (e) {
      log(e.toString());
      return;
    }
  }

  static void showMaterialBanner(BuildContext context, String text) async {
    try {
      ScaffoldMessenger.of(context).clearMaterialBanners();
      ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          backgroundColor: Colors.black,
          dividerColor: Colors.black,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  )),
            ],
          ),
          actions: const [SizedBox()],
        ),
      );
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
}
