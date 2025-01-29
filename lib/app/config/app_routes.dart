import 'package:get/get.dart';
import 'package:souq_ai/app/mvvm/view/account_deletion_view/account_deletion_view.dart';
import 'package:souq_ai/app/mvvm/view/change_password/change_password_view.dart';
import 'package:souq_ai/app/mvvm/view/confirm_otp/confirm_otp_view.dart';
import 'package:souq_ai/app/mvvm/view/membership_view.dart';
import 'package:souq_ai/app/mvvm/view/navbar_view.dart';
import 'package:souq_ai/app/mvvm/view/notification_view/notification_view.dart';
import 'package:souq_ai/app/mvvm/view/sign_in_view.dart';
import 'package:souq_ai/app/mvvm/view/signup_view.dart';
import 'package:souq_ai/app/mvvm/view/subscription_view/subscription_view.dart';
import 'package:souq_ai/app/mvvm/view_model/auth_controllers/account_deletion_controller.dart';
import 'package:souq_ai/app/mvvm/view_model/auth_controllers/change_password_controller.dart';
import 'package:souq_ai/app/mvvm/view_model/auth_controllers/sign_in_controller.dart';
import 'package:souq_ai/app/mvvm/view_model/auth_controllers/sign_up_controller.dart';
import 'package:souq_ai/app/mvvm/view_model/cryptcurrency_controller.dart';
import 'package:souq_ai/app/mvvm/view_model/home_controller.dart';
import '../mvvm/view/about_us_view.dart';
import '../mvvm/view/charity_institute_view.dart';
import '../mvvm/view/drawer_view/drawer_view.dart';
import '../mvvm/view/screening_detail_view.dart';
import '../mvvm/view/splash_view.dart';
import '../mvvm/view_model/app_drawer_controller.dart';
import '../mvvm/view_model/auth_controllers/confirm_otp_controller.dart';
import 'package:souq_ai/app/mvvm/view/terms_and_conditions_view.dart';
import 'package:souq_ai/app/mvvm/view/personal_details_view.dart';
import 'package:souq_ai/app/mvvm/view/privacy_policy_view.dart';
import '../mvvm/view_model/auth_controllers/signal_controller.dart';
import '../mvvm/view_model/portfolio_controller.dart';
import '../mvvm/view_model/splash_controller.dart';
import '../mvvm/view_model/zakat_controller.dart';

abstract class AppRoutes {
  AppRoutes._();

  static const splashView = '/splashView';
  static const notificationView = '/notificationView';
  static const signInView = '/signInView';
  static const signUpView = '/signUpView';
  static const membershipView = '/membershipView';
  static const navbarView = '/navbarView';
  static const drawerView = '/drawerView';
  static const changePasswordView = '/changePasswordView';
  static const confirmOtpView = '/confirmOtpView';
  static const accountDeletionView = '/accountDeletionView';

  static const privacyPolicyView = '/privacyPolicyView';
  static const termsAndConditionsView = '/termsAndConditionsView';
  static const personalDetailsView = '/personalDetailsView';
  static const aboutUsView = '/aboutUsView';
  static const subscriptionView = '/subscriptionView';
  static const charityInstituteView = '/charityInstituteView';
  static const screeningDetailView = '/screeningDetailView';

//ss
}

abstract class AppPages {
  AppPages._();

  static final routes = <GetPage>[
    GetPage(
        name: AppRoutes.splashView,
        page: () => const SplashView(),
        transition: Transition.fade, // Transition added
        binding: BindingsBuilder(() {
          Get.lazyPut<SplashController>(() => SplashController());
        })),
    GetPage(
        name: AppRoutes.notificationView,
        page: () => const NotificationView(),
        transition: Transition.zoom, // Transition added
        binding: BindingsBuilder(() {
          // Get.lazyPut<SplashController>(() => SplashController());
        })),
    GetPage(
        name: AppRoutes.signInView,
        page: () => const SignInView(),
        transition: Transition.rightToLeft, // Transition added
        binding: BindingsBuilder(() {
          Get.lazyPut<SignInController>(() => SignInController());
        })),
    GetPage(
        name: AppRoutes.signUpView,
        page: () => const SignUpView(),
        transition: Transition.leftToRight, // Transition added
        binding: BindingsBuilder(() {
          Get.lazyPut<SignUpController>(() => SignUpController());
        })),
    GetPage(
        name: AppRoutes.membershipView,
        page: () => const MembershipView(),
        transition: Transition.downToUp, // Transition added
        binding: BindingsBuilder(() {
          // Get.lazyPut<SplashController>(() => SplashController());
        })),
    GetPage(
        name: AppRoutes.navbarView,
        page: () => const NavBarView(),
        transition: Transition.fadeIn, // Transition added
        binding: BindingsBuilder(() {
          Get.lazyPut<HomeController>(() => HomeController());
          Get.lazyPut<CryptocurrencyController>(() => CryptocurrencyController());
          Get.lazyPut<ZakatController>(() => ZakatController());
          Get.lazyPut<PortfolioController>(() => PortfolioController());
          Get.lazyPut<SignalController>(() => SignalController());
        })),
    GetPage(
        name: AppRoutes.drawerView,
        page: () => const AppDrawerView(),
        transition: Transition.rightToLeftWithFade, // Transition added
        binding: BindingsBuilder(() {
          Get.lazyPut<AppDrawerController>(() => AppDrawerController());
        })),
    GetPage(
        name: AppRoutes.changePasswordView,
        page: () => const ChangePasswordView(),
        transition: Transition.upToDown, // Transition added
        binding: BindingsBuilder(() {
          Get.lazyPut<ChangePasswordController>(() => ChangePasswordController());
        })),
    GetPage(
        name: AppRoutes.confirmOtpView,
        page: () => const ConfirmOtpView(),
        transition: Transition.cupertino, // Transition added
        binding: BindingsBuilder(() {
          Get.lazyPut<ConfirmOtpController>(() => ConfirmOtpController());
        })),
    GetPage(
        name: AppRoutes.accountDeletionView,
        page: () => const AccountDeletionView(),
        transition: Transition.zoom, // Transition added
        binding: BindingsBuilder(() {
          Get.lazyPut<AccountDeletionController>(() => AccountDeletionController());
          Get.lazyPut<AppDrawerController>(() => AppDrawerController());
        })),
    GetPage(
        name: AppRoutes.aboutUsView,
        page: () => const AboutUsView(),
        transition: Transition.size, // Transition added
        binding: BindingsBuilder(() {
          Get.lazyPut<AppDrawerController>(() => AppDrawerController());
        })),
    GetPage(
        name: AppRoutes.termsAndConditionsView,
        page: () => const TermsAndConditionsView(),
        transition: Transition.leftToRightWithFade, // Transition added
        binding: BindingsBuilder(() {
          Get.lazyPut<AppDrawerController>(() => AppDrawerController());
        })),
    GetPage(
        name: AppRoutes.privacyPolicyView,
        page: () => const PrivacyPolicyView(),
        transition: Transition.rightToLeftWithFade, // Transition added
        binding: BindingsBuilder(() {
          Get.lazyPut<AppDrawerController>(() => AppDrawerController());
        })),
    GetPage(
        name: AppRoutes.personalDetailsView,
        page: () => const PersonalDetailsView(),
        transition: Transition.fade, // Transition added
        binding: BindingsBuilder(() {
          Get.lazyPut<AppDrawerController>(() => AppDrawerController());
        })),
    GetPage(
        name: AppRoutes.subscriptionView,
        page: () => const SubscriptionView(),
        transition: Transition.zoom, // Transition added
        binding: BindingsBuilder(() {
          // Get.lazyPut<SplashController>(() => SplashController());
        })),
    GetPage(
        name: AppRoutes.charityInstituteView,
        page: () => const CharityInstituteView(),
        transition: Transition.downToUp, // Transition added
        binding: BindingsBuilder(() {
          Get.lazyPut<ZakatController>(() => ZakatController());
        })),
    GetPage(
        name: AppRoutes.screeningDetailView,
        page: () => const ScreeningDetailView(),
        transition: Transition.fadeIn, // Transition added
        binding: BindingsBuilder(() {
          Get.lazyPut<CryptocurrencyController>(() => CryptocurrencyController());
        })),
  ];
}
