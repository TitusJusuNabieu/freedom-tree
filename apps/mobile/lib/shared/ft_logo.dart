import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freedomtree_mobile/app/theme.dart';

/// Freedom Tree's only available logo asset is a white SVG made for colored
/// backgrounds. Until a colored/dark variant is supplied, we place it inside
/// a solid ft-orange badge so it also works on light screens (matches the
/// same treatment used in the Next.js dashboard's Logo component).
class FtLogo extends StatelessWidget {
  const FtLogo({super.key, this.height = 20});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: FtColors.orange,
        borderRadius: BorderRadius.circular(6),
      ),
      child: SvgPicture.asset(
        'assets/brand/ft-logo-white.svg',
        height: height,
      ),
    );
  }
}
