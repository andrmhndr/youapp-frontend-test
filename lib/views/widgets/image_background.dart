import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youapp_test/helper/images_helper.dart';

class ImageBackground extends StatelessWidget {
  const ImageBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SvgPicture.asset(
            ImagesHelper.gradientBackground,
            fit: BoxFit.cover,
          ),
        ),
        child,
      ],
    );
  }
}
