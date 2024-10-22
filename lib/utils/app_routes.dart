// import 'package:boom_hit_vendor_admin/src/Screens/AuthScreens/register_screen.dart';
// import 'package:get/get.dart';
//
// import '../src/Screens/AuthScreens/login_screen.dart';
// import '../src/screens/DashboardScreen/dashboard.dart';
// import '../src/screens/SplashScreen/splash_screen.dart';
//
// class AppRoutes {
//
//   static List<GetPage> routes = [
//
//     GetPage(
//       name: '/',
//       page: () => const SplashScreen(),
//       // middlewares: [GuestMiddleware()],
//     ),
//
//     GetPage(
//       name: '/login',
//       page: () => const LoginScreen(),
//      // middlewares: [AuthMiddleware()],
//     ),
//     GetPage(
//       name: '/signup',
//       page: () => const RegisterScreen(),
//     ),
//     // GetPage(
//     //   name: '/forgot',
//     //   page: () => const ForgotPasswordScreen(),
//     //   // middlewares: [GuestMiddleware()],
//     // ),
//     GetPage(
//       name: '/home',
//       page: () => DashboardScreen(),
//       //middlewares: [AuthMiddleware()],
//     ),
//   ];
// }
//
// // final SessionController _sessionController = Get.find<SessionController>();
//
// // Define your middleware
// // class AuthMiddleware extends GetMiddleware {
// //   final SessionController _sessionController = Get.find<SessionController>();
// //
// //   @override
// //   RouteSettings? redirect(String? route) {
// //     // Synchronously check token status
// //     if (_sessionController.token.isEmpty && route != '/login') {
// //       return RouteSettings(name: '/login');
// //     }
// //
// //     return null; // Allow navigation if authenticated or on login page
// //   }
// // }
//
// // class GuestMiddleware extends GetMiddleware {
// //   final SessionController _sessionController = Get.find<SessionController>();
// //
// //   @override
// //   RouteSettings? redirect(String? route) {
// //     // Synchronously check token status
// //
// //     if (_sessionController.token.isNotEmpty && route != '/home') {
// //       return RouteSettings(name: '/home');
// //     }
// //
// //     return null; // Allow navigation if authenticated or on login page
// //   }
// // }
