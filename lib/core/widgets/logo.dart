import 'package:flutter/material.dart';
import '/core/core.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 60,
        ),
        Assets.logos.appLogo.image(
          width: 250,
          height: 115,
        ),
      ],
    );
  }
}
