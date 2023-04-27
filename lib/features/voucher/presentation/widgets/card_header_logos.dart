import 'package:flutter/widgets.dart';
import 'package:sme_plateia/gen/assets.gen.dart';

class CardHeaderLogoWidget extends StatelessWidget {
  const CardHeaderLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Assets.images.logo.image(),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Assets.images.logoSaopaulo.image(),
          ),
        ),
      ],
    );
  }
}
