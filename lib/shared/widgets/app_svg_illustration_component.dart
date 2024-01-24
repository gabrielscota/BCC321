import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppSvgIllustrationComponent extends StatelessWidget {
  final String assetName;
  final Color? color;
  final double? height;
  final double? width;
  final BoxFit fit;

  const AppSvgIllustrationComponent({
    super.key,
    required this.assetName,
    this.color,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      height: height,
      width: width,
      fit: fit,
    );
  }
}
