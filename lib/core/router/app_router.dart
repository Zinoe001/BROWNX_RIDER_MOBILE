import 'package:flutter/material.dart';
import 'package:rider_mobile/core/router/router.dart';
import 'package:rider_mobile/features/auth/forgot_password/create_new_password_successful_view.dart';
import 'package:rider_mobile/features/auth/forgot_password/create_new_password_view.dart';
import 'package:rider_mobile/features/auth/forgot_password/forgot_password_submitted_view.dart';
import 'package:rider_mobile/features/auth/forgot_password/forgot_password_view.dart';
import 'package:rider_mobile/features/auth/login/login_view.dart';
import 'package:rider_mobile/features/auth/sign_up/rider_details_view.dart';
import 'package:rider_mobile/features/auth/sign_up/sign_up_successful_view.dart';
import 'package:rider_mobile/features/auth/sign_up/sign_up_view.dart';
import 'package:rider_mobile/features/auth/verify_account/verify_account_successful_view.dart';
import 'package:rider_mobile/features/auth/verify_account/verify_account_view.dart';
import 'package:rider_mobile/features/onboarding/onboarding_view.dart';

class AppRouter {
  static PageRoute _getPageRoute({
    required RouteSettings settings,
    required Widget viewToShow,
  }) {
    return MaterialPageRoute(
      builder: (context) => viewToShow,
      settings: settings,
    );
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    Map<String, dynamic> routeArgs =
        settings.arguments != null
            ? settings.arguments as Map<String, dynamic>
            : {};

    switch (settings.name) {
      case NavigatorRoutes.onboarding:
        return _getPageRoute(
          settings: settings,
          viewToShow: const OnboardingView(),
        );
      case NavigatorRoutes.login:
        return _getPageRoute(settings: settings, viewToShow: const LogInView());
      case NavigatorRoutes.signUp:
        return _getPageRoute(
          settings: settings,
          viewToShow: const SignUpView(),
        );
      case NavigatorRoutes.riderDetails:
        var name = routeArgs[RoutingArgumentKey.name];
        var email = routeArgs[RoutingArgumentKey.email];
        var password = routeArgs[RoutingArgumentKey.password];
        var confirmPassword = routeArgs[RoutingArgumentKey.confirmPassword];
        var type = routeArgs[RoutingArgumentKey.type];
        return _getPageRoute(
          settings: settings,
          viewToShow: RiderDetailsView(
            name: name,
            email: email,
            password: password,
            confirmPassword: confirmPassword,
            type: type,
          ),
        );
      case NavigatorRoutes.signUpSuccessful:
        var email = routeArgs[RoutingArgumentKey.email];
        return _getPageRoute(
          settings: settings,
          viewToShow: SignUpSuccessfulView(email: email),
        );
      case NavigatorRoutes.verifyAccountView:
        var email = routeArgs[RoutingArgumentKey.email];
        var password = routeArgs[RoutingArgumentKey.password];
        return _getPageRoute(
          settings: settings,
          viewToShow: VerifyAccountView(email: email, isPassword: password),
        );
      case NavigatorRoutes.verifyAccountSuccessfulView:
        return _getPageRoute(
          settings: settings,
          viewToShow: VerifyAccountSuccessfulView(),
        );
      case NavigatorRoutes.forgotPassword:
        return _getPageRoute(
          settings: settings,
          viewToShow: const ForgotPasswordView(),
        );
      case NavigatorRoutes.forgotPasswordSubmitted:
        var email = routeArgs[RoutingArgumentKey.email];
        return _getPageRoute(
          settings: settings,
          viewToShow: ForgotPasswordSubmittedView(email: email),
        );
      case NavigatorRoutes.createNewPasswordView:
        var email = routeArgs[RoutingArgumentKey.email];
        return _getPageRoute(
          settings: settings,
          viewToShow: CreateNewPasswordView(email: email),
        );
      case NavigatorRoutes.createNewPasswordSuccessfulView:
        return _getPageRoute(
          settings: settings,
          viewToShow: const CreateNewPasswordSuccessfulView(),
        );

      // case NavigatorRoutes.dashboardView:
      //   return _getPageRoute(
      // settings: settings, viewToShow:
      // const DashboardView());NegotiateView

      // case NavigatorRoutes.negotiateView:
      //   return _getPageRoute(
      //     settings: settings,
      //     viewToShow: NegotiateView(),
      // //   );
      // case NavigatorRoutes.dashboardView:
      //   // var delivery = routeArgs[RoutingArgumentKey.delivery];
      //   return _getPageRoute(settings: settings, viewToShow: DashboardView());
      // case NavigatorRoutes.requestView:
      //   return _getPageRoute(settings: settings, viewToShow: RequestView());

      // /// Accept Rider View
      // case NavigatorRoutes.acceptUserHome:
      //   var deliverySelected = routeArgs[RoutingArgumentKey.deliverySelected];
      //   var onDelivery = routeArgs[RoutingArgumentKey.onDelivery];
      //   return _getPageRoute(
      //       settings: settings,
      //       viewToShow: AcceptUserHome(
      //         deliverySelected: deliverySelected,
      //         onDelivery: onDelivery,
      //       ));
      // case NavigatorRoutes.seeDetailsView:
      //   return _getPageRoute(settings: settings, viewToShow: SeeDetailsView());
      // case NavigatorRoutes.imageDisplayView:
      //   var image = routeArgs[RoutingArgumentKey.image];
      //   return _getPageRoute(
      //       settings: settings, viewToShow: ImageDisplayView(image: image));
      // case NavigatorRoutes.riderCompleteView:
      //   return _getPageRoute(
      //       settings: settings, viewToShow: RiderCompleteView());

      // // case NavigatorRoutes.inputDetailsView:
      // //   return _getPageRoute(
      // //       settings: settings, viewToShow: const InputDetailsView());
      // // case NavigatorRoutes.inputDetailsSuccessView:
      // //   return _getPageRoute(
      // //       settings: settings, viewToShow: const InputDetailsSuccessView());
      // // case NavigatorRoutes.cameraView:
      // //   var camera = routeArgs[RoutingArgumentKey.camera];
      // //   return _getPageRoute(
      // //       settings: settings, viewToShow: CameraView(cameras: camera));
      // // case NavigatorRoutes.imageDisplayView:
      // //   var image = routeArgs[RoutingArgumentKey.image];
      // //   return _getPageRoute(
      // //       settings: settings, viewToShow: ImageDisplayView(image: image));

      // case NavigatorRoutes.about:
      //   return _getPageRoute(settings: settings, viewToShow: const AboutView());
      // case NavigatorRoutes.aboutus:
      //   return _getPageRoute(
      //       settings: settings, viewToShow: const AboutUsView());
      // case NavigatorRoutes.choiceOfLanguage:
      //   return _getPageRoute(
      //       settings: settings, viewToShow: const LanguageChoice());
      // case NavigatorRoutes.contactSupport:
      //   return _getPageRoute(settings: settings, viewToShow: ContactSupport());
      // case NavigatorRoutes.deliveryStatus:
      //   return _getPageRoute(
      //       settings: settings, viewToShow: const DeliveryStatus());
      // case NavigatorRoutes.history:
      //   return _getPageRoute(settings: settings, viewToShow: const History());
      // // case NavigatorRoutes.chat:
      // //   return _getPageRoute(settings: settings, viewToShow: const Chat());
      // // case NavigatorRoutes.call:
      // //   return _getPageRoute(settings: settings, viewToShow: const CallPage());
      // case NavigatorRoutes.favorites:
      //   return _getPageRoute(settings: settings, viewToShow: const Favorites());
      // case NavigatorRoutes.legal:
      //   return _getPageRoute(
      //       settings: settings, viewToShow: const LegalDocumentations());
      // case NavigatorRoutes.logout:
      //   return _getPageRoute(settings: settings, viewToShow: const LogOut());
      // case NavigatorRoutes.myProfile:
      //   return _getPageRoute(settings: settings, viewToShow: MyProfile());
      // case NavigatorRoutes.editProfile:
      //   return _getPageRoute(settings: settings, viewToShow: EditProfile());
      // case NavigatorRoutes.changePassword:
      //   return _getPageRoute(settings: settings, viewToShow: ChangePassword());
      // case NavigatorRoutes.disableAccount:
      //   return _getPageRoute(
      //       settings: settings, viewToShow: DisableAccountView());
      // case NavigatorRoutes.appAndFeatures:
      //   return _getPageRoute(settings: settings, viewToShow: AppAndFeatures());
      // case NavigatorRoutes.payment:
      //   return _getPageRoute(
      //       settings: settings, viewToShow: const PaymentView());
      // // case NavigatorRoutes.payStackPaymentView:
      // //   return _getPageRoute(
      // //       settings: settings, viewToShow: const PayStackPaymentView());
      // case NavigatorRoutes.addCardView:
      // // return _getPageRoute(
      // //     settings: settings, viewToShow: const AddCardView());
      // case NavigatorRoutes.reportFinal:
      //   return _getPageRoute(
      //       settings: settings, viewToShow: const ReportFinal());
      // case NavigatorRoutes.reportProblem:
      //   return _getPageRoute(settings: settings, viewToShow: ReportProblem());
      // case NavigatorRoutes.settings:
      //   return _getPageRoute(settings: settings, viewToShow: const Settings());
      // case NavigatorRoutes.support:
      //   return _getPageRoute(settings: settings, viewToShow: const Support());
      // case NavigatorRoutes.terms:
      //   return _getPageRoute(
      //       settings: settings, viewToShow: const TermsAndCondition());

      default:
        return _getPageRoute(settings: settings, viewToShow: const Scaffold());
    }
  }
}
