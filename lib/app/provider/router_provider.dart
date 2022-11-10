import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature/auth/model/auth_state.dart';
import 'package:flutter_boilerplate/feature/auth/widget/routes.dart';
import 'package:flutter_boilerplate/feature/home/widget/routes.dart';
import 'package:flutter_boilerplate/shared/widget/loading_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../feature/auth/provider/auth_provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authProvider);

  return GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isAuth = auth == const AuthState.loggedIn();
      // If our async state is loading, don't perform redirects, yet
      final isSplash = state.location == '/splash';
      if (isSplash) return null;

      final currentlyInAuthRoutes = [signInRoute.path, signUpRoute.path].contains(state.path);
      if (currentlyInAuthRoutes && auth == const AuthState.loading()) return '/splash';

      return isAuth ? state.path : signInRoute.path;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const LoadingWidget(),
      ),
      GoRoute(
        path: '/404',
        builder: (context, state) => const LoadingWidget(),
      ),
      signInRoute,
      signUpRoute,
      homeRoute,
    ], // All the routes can be found there
  );
});
