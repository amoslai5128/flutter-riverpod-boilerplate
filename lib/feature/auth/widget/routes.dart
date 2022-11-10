import 'sign_in_page.dart';
import 'sign_up_page.dart';
import 'package:go_router/go_router.dart';

final signInRoute = GoRoute(
  path: '/signIn',
  builder: (context, state) => SignInPage(),
);

final signUpRoute = GoRoute(
  path: '/signUp',
  builder: (context, state) => SignUpPage(),
);
