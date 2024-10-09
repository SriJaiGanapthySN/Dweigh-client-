import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class SvgLoader extends StatelessWidget {
  const SvgLoader({
    super.key,
    required this.assetPath,
    required this.height,
    required this.width,
  });

  final String assetPath;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      width: width,
      height: height,
      fit: BoxFit.contain,
    );
  }
}
