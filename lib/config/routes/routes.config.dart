import 'package:flutter/material.dart';
import 'package:shareticket/core/auth/screen/forgot_password_email_send_screen.dart';
import 'package:shareticket/core/auth/screen/forgot_password_screen.dart';
import 'package:shareticket/core/auth/screen/login_mobile_screen.dart';
import 'package:shareticket/core/auth/screen/login_screen.dart';
import 'package:shareticket/core/auth/screen/otp_forgot_password_screen.dart';
import 'package:shareticket/core/auth/screen/register_screen.dart';
import 'package:shareticket/core/auth/screen/register_success_screen.dart';
import 'package:shareticket/core/not_found/not_found_screen.dart';
import 'package:shareticket/core/onboarding/onboarding_screen.dart';
import 'package:shareticket/core/splash/splash_screen.dart';
import 'package:shareticket/modules/account/screen/change_language_screen.dart';
import 'package:shareticket/modules/account/screen/change_password_screen.dart';
import 'package:shareticket/modules/account/screen/delete_confirmation_screen.dart';
import 'package:shareticket/modules/account/screen/profile_detail_screen.dart';
import 'package:shareticket/modules/account/screen/tos_privacy_screen.dart';
import 'package:shareticket/modules/article/screen/article_screen.dart';
import 'package:shareticket/modules/base/screen/base_screen.dart';
import 'package:shareticket/modules/dashboard/dashboard_screen.dart';
import 'package:shareticket/modules/event/screen/event_list_screen.dart';
import 'package:shareticket/modules/event/screen/expired_screen.dart';
import 'package:shareticket/modules/event/screen/order_detail_screen.dart';
import 'package:shareticket/modules/event/screen/payment_method_screen.dart';
import 'package:shareticket/modules/event/screen/payment_screen.dart';
import 'package:shareticket/modules/event/screen/stage_detail_screen.dart';
import 'package:shareticket/modules/event/screen/success_screen.dart';
import 'package:shareticket/modules/home/screen/add_phone_screen.dart';
import 'package:shareticket/modules/home/screen/article_by_category_screen.dart';
import 'package:shareticket/modules/home/screen/article_by_id_screen.dart';
import 'package:shareticket/modules/event/screen/event_detail_screen.dart';
import 'package:shareticket/modules/home/screen/location_city_screen.dart';
import 'package:shareticket/modules/home/screen/location_picker_screen.dart';
import 'package:shareticket/modules/home/screen/location_province_screen.dart';
import 'package:shareticket/modules/home/screen/promo_detail_screen.dart';
import 'package:shareticket/modules/notification/screen/notification_detail_screen.dart';
import 'package:shareticket/modules/notification/screen/notification_screen.dart';
import 'package:shareticket/modules/ticket/screen/my_ticket_detail_screen.dart';

class RouteConfig {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var argument = settings.arguments;

    switch (settings.name) {
      // SplashScreen
      case SplashScreen.path:
        return goTo(const SplashScreen());

      // Dashboard
      case DashboardScreen.path:
        return goTo(DashboardScreen(argument: argument as DashboardArgument));

      // Onboarding
      case OnboardingScreen.path:
        return goTo(const OnboardingScreen());

      // Autentication
      case LoginScreen.path:
        return goTo(const LoginScreen());
      case LoginMobileScreen.path:
        return goTo(const LoginMobileScreen());
      case RegisterScreen.path:
        return goTo(const RegisterScreen());
      case OtpScreen.path:
        return goTo(OtpScreen(
          argument: argument as OtpArgument,
        ));
      case ForgotPasswordScreen.path:
        return goTo(const ForgotPasswordScreen());
      case ForgotPasswordSentScreen.path:
        return goTo(ForgotPasswordSentScreen(
            argument: argument as ForgotPasswordSentArgument));
      case ChanePasswordScreen.path:
        return goTo(
            ChanePasswordScreen(argument: argument as ChanePasswordArgument));
      case RegisterSuccessScreen.path:
        return goTo(const RegisterSuccessScreen());

      // Phone
      case AddPhoneNumberScreen.path:
        return goTo(const AddPhoneNumberScreen());

      // Article
      case ArticleByCategoryScreen.path:
        return goTo(const ArticleByCategoryScreen());
      case ArticleByIdScreen.path:
        return goTo(ArticleByIdScreen(
          argument: argument as ArticleByIdArgument,
        ));

      // Notification
      case NotificationScreen.path:
        return goTo(const NotificationScreen());
      case NotificationDetailScreen.path:
        return goTo(const NotificationDetailScreen());
      // Account

      case ProfileDetailScreen.path:
        return goTo(
            ProfileDetailScreen(argument: argument as ProfileDetailArgument));
      case TosPrivacyScreen.path:
        return goTo(TosPrivacyScreen(argument: argument as TosPrivacyArgument));

      case ChangeLanguageScreen.path:
        return goTo(const ChangeLanguageScreen());

      case MyTicketDetailScreen.path:
        return goTo(MyTicketDetailScreen(
          argument: argument as MyTicketDetailArgument,
        ));
      case PromoDetailScreen.path:
        return goTo(const PromoDetailScreen());
      case EventDetailScreen.path:
        return goTo(EventDetailScreen(
          argument: argument as EventDetailArgument,
        ));
      case OrderDetailScreen.path:
        return goTo(
            OrderDetailScreen(argument: argument as OrderDetailArgument));
      case PaymentMethodScreen.path:
        return goTo(
            PaymentMethodScreen(argument: argument as PaymentMethodArgument));
      case PaymentScreen.path:
        return goTo(PaymentScreen(argument: argument as PaymentArgument));
      case SuccessScreen.path:
        return goTo(SuccessScreen(
          argument: argument as SuccessArgument,
        ));
      case ExpiredScreen.path:
        return goTo(ExpiredScreen(
          argument: argument as ExpiredArgument,
        ));

      case DeleteConfirmationScreen.path:
        return goTo(DeleteConfirmationScreen());
      case ArticleScreen.path:
        return goTo(const ArticleScreen());
      case EventScreen.path:
        return goTo(EventScreen(argument: argument as EventArgument));
      case BaseScreen.path:
        return goTo(const BaseScreen());
      case LocationProvinceScreen.path:
        return goTo(const LocationProvinceScreen());
      case LocationCityScreen.path:
        return goTo(
            LocationCityScreen(argument: argument as LocationCityArgument));

      case LocationPickerScreen.path:
        return goTo(const LocationPickerScreen());
      case StageDetailScreen.path:
        return goTo(
            StageDetailScreen(argument: argument as StageDetailArgument));
      // case TicketDetailScreen.path:
      //   return goTo(
      //       TicketDetailScreen(argument: argument as TicketDetailArgument));
    }

    return goTo(const NotFoundScreen());
    // return
  }

  // static backToHome(BuildContext context) {
  //   Navigator.popAndPushNamed(context, RouteConfig.DASHBOARD);
  // }

  static MaterialPageRoute goTo(screen) {
    return MaterialPageRoute(builder: (context) => screen);
  }
}
