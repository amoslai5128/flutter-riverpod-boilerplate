import 'package:go_router/go_router.dart';

import 'home_page.dart';

final homeRoute = GoRoute(
  path: '/',
  builder: (context, state) => const HomePage(),
);
