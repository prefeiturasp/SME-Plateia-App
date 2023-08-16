import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sme_plateia/gen/assets.gen.dart';

class Rodape extends StatelessWidget {
  const Rodape({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(height: 24.h),
        Assets.images.logoSaopaulo.image(
          height: 40.h,
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
