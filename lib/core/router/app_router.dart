import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/login/login_screen.dart';
import '../../features/auth/presentation/otp/otp_screen.dart';
import '../../features/auth/presentation/signup/signup_screen.dart';
import '../../features/category/presentation/screens/category_screen.dart';
import '../../features/chat/presentation/screens/chat_screen.dart';
import '../../features/favorites/presentation/screens/favorites_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/notification/presentation/screens/notification_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/report/presentation/screens/report_screen.dart';
import '../../features/search_filter/presentation/screens/search_filter_screen.dart';

class AppRouter {
  AppRouter._();

  static const String initial = '/';
  static const String login = '/login';
  static const String auth = '/auth';
  static const String signup = '/signup';
  static const String register = '/register';
  static const String otp = '/otp';
  static const String home = '/home';
  static const String category = '/category';
  static const String search = '/search';
  static const String chat = '/chat';
  static const String favorites = '/favorites';
  static const String profile = '/profile';
  static const String notification = '/notification';
  static const String report = '/report';

  static final GoRouter router = GoRouter(
    initialLocation: login,
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) => login,
      ),
      GoRoute(
        path: login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: auth,
        name: 'auth',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: signup,
        name: 'signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: register,
        name: 'register',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: otp,
        name: 'otp',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final target = extra?['target'] as String? ?? 'sujon.ahmed@gmail.com';
          return OtpScreen(
            target: target,
          );
        },
      ),
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: category,
        name: 'category',
        builder: (context, state) => const CategoryScreen(),
      ),
      GoRoute(
        path: search,
        name: 'search',
        builder: (context, state) => const SearchFilterScreen(),
      ),
      GoRoute(
        path: chat,
        name: 'chat',
        builder: (context, state) => const ChatScreen(),
      ),
      GoRoute(
        path: favorites,
        name: 'favorites',
        builder: (context, state) => const FavoritesScreen(),
      ),
      GoRoute(
        path: profile,
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: notification,
        name: 'notification',
        builder: (context, state) => const NotificationScreen(),
      ),
      GoRoute(
        path: report,
        name: 'report',
        builder: (context, state) => const ReportScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('No route defined for ${state.uri.toString()}'),
      ),
    ),
  );
}
