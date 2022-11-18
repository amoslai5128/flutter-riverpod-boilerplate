import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature/auth/provider/auth_provider.dart';
import 'package:flutter_boilerplate/l10n/l10n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends ConsumerWidget {
  SignInPage({super.key});
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authProvider);

    return Scaffold(
        body: Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Column(children: <Widget>[
              const SizedBox(height: 150),
              Text(
                context.l10n.sign_in,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              auth.maybeWhen(
                error: (err) => Text(err.maybeWhen(errorWithMessage: (message) => message, orElse: () => '')),
                orElse: () => Text(auth.toString()),
              ),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: context.l10n.email_hint,
                      ),
                      controller: _emailController,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: context.l10n.password_hint,
                      ),
                      controller: _passwordController,
                      obscureText: true,
                    ),
                    Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                      const SizedBox(height: 30),
                      _widgetSignInButton(context, ref),
                      const SizedBox(height: 30),
                      Text(
                        context.l10n.new_user,
                        textAlign: TextAlign.center,
                      ),
                      _widgetSignUpButton(context),
                    ]),
                  ],
                ),
              )
            ])));
  }

  Widget _widgetSignInButton(BuildContext context, WidgetRef ref) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            ref.read(authProvider.notifier).login(_emailController.text, _passwordController.text);
          },
          child: Text(context.l10n.sign_in),
        ));
  }

  Widget _widgetSignUpButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          context.go('/singUp');
          //context.navigateTo(SignUpWidget)
          //const SignUpWidget().show(context);
        },
        child: Text(context.l10n.sign_up),
      ),
    );
  }
}
