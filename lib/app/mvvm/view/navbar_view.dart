import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:souq_ai/app/config/app_assets.dart';
import 'package:souq_ai/app/mvvm/view/navbar_views/cryptocurrency_view.dart';
import 'package:souq_ai/app/mvvm/view/navbar_views/home_view.dart';
import 'package:souq_ai/app/mvvm/view/navbar_views/portfolio_view.dart';
import 'package:souq_ai/app/mvvm/view/navbar_views/signal_view.dart';
import 'package:souq_ai/app/mvvm/view/navbar_views/zakat_view.dart';
import '../../config/app_colors.dart';
import '../../config/app_text_style.dart';

class NavBarView extends StatefulWidget {
  const NavBarView({super.key});

  @override
  _NavBarViewState createState() => _NavBarViewState();
}

class _NavBarViewState extends State<NavBarView> with SingleTickerProviderStateMixin {
  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(AppAssets.home, color: AppColors.white),
        inactiveIcon: SvgPicture.asset(
          AppAssets.home,
          height: 20.sp,
        ),
        title: ("Home"),
        activeColorPrimary: AppColors.primary,
        activeColorSecondary: AppColors.white,
        inactiveColorPrimary: AppColors.white,
        textStyle: AppTextStyles.customText14(
          color: AppColors.white,
        ),
        iconSize: 18.sp,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(AppAssets.balance, color: AppColors.white),
        inactiveIcon: SvgPicture.asset(AppAssets.balance, height: 20.sp),
        title: ("Crypto"),
        activeColorPrimary: AppColors.primary,
        activeColorSecondary: AppColors.white,
        inactiveColorPrimary: AppColors.white,
        textStyle: AppTextStyles.customText14(
          color: AppColors.white,
        ),
        iconSize: 18.sp,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(AppAssets.group, color: AppColors.white, height: 20.sp,),
        inactiveIcon: SvgPicture.asset(AppAssets.group, height: 20.sp),
        title: ("Signal"),
        activeColorPrimary: AppColors.primary,
        activeColorSecondary: AppColors.white,
        inactiveColorPrimary: AppColors.white,
        textStyle: AppTextStyles.customText14(
          color: AppColors.white,
        ),
        iconSize: 18.sp,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(AppAssets.zakatIcon, height: 25.sp,),
        inactiveIcon:  Image.asset(AppAssets.zakatIcon, height: 20.sp,),
        title: ("Zakat"),
        activeColorPrimary: AppColors.primary,
        activeColorSecondary: AppColors.white,
        inactiveColorPrimary: AppColors.white,
        textStyle: AppTextStyles.customText14(
          color: AppColors.white,
        ),
        iconSize: 18.sp,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(AppAssets.office, color: AppColors.white),
        inactiveIcon: SvgPicture.asset(AppAssets.office, height: 20.sp),
        title: ("Portfolio"),
        activeColorPrimary: AppColors.primary,
        activeColorSecondary: AppColors.white,
        inactiveColorPrimary: AppColors.white,
        textStyle: AppTextStyles.customText14(
          color: AppColors.white,
        ),
        iconSize: 18.sp,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PersistentTabView(context,
            controller: _controller,
            screens: const [
              HomeView(),
              CryptocurrencyView(),
              SignalView(),
              ZakatView(),
              PortfolioView(),
            ],
            items: _navBarsItems(),
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            stateManagement: false,
            hideNavigationBarWhenKeyboardAppears: true,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            backgroundColor: AppColors.transparent,
            isVisible: true,
            animationSettings: const NavBarAnimationSettings(
              navBarItemAnimation: ItemAnimationSettings(
                duration: Duration(milliseconds: 200),
                curve: Curves.ease,
              ),
              screenTransitionAnimation: ScreenTransitionAnimationSettings(
                animateTabTransition: true,
                duration: Duration(milliseconds: 130),
                screenTransitionAnimationType: ScreenTransitionAnimationType.slide,
              ),
            ),
            confineToSafeArea: false,
            navBarHeight: 66.h,
            navBarStyle: NavBarStyle.style9,
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: NavBarDecoration(
              border: Border.all(width: 0.2, color: Colors.white),
              borderRadius: BorderRadius.circular(5.sp),
            ) // Choose the nav bar style with this property
            ));
  }
}
