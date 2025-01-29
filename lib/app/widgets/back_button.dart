import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../config/app_assets.dart';

class CryptoBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData? icon;
  const CryptoBackButton({super.key, this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap : (){
        HapticFeedback.mediumImpact();

        if(onTap == null){
        Navigator.pop(context);

        }else{
          onTap!();
        }
      },
      child: SvgPicture.asset(AppAssets.backButtonIcon,),
    );
  }
}