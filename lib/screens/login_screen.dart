import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_chat/constants.dart';
import 'package:m_chat/cubits/login_cubit/login_cubit.dart';
import 'package:m_chat/helpers/show_snack_bar.dart';
import 'package:m_chat/screens/chat_screen.dart';
import 'package:m_chat/screens/register_screen.dart';
import 'package:m_chat/widgets/custom_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgets/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  static const String loginRoute = 'LoginRoute';

  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          Navigator.pushNamed(context, LoginScreen.loginRoute);
          isLoading = false;
        } else {
          showSnackBar(context, 'Login failed');
          isLoading = false;
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const SizedBox(height: 75),
                  Image.asset('assets/images/scholar.png', height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Meta Chat',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 75),
                    ],
                  ),
                  Row(
                    children: const [
                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  CustomTextFormField(
                    onChanged: (enteredEmail) {
                      email = enteredEmail;
                    },
                    hintText: 'Email',
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    hidePasssword: true,
                    onChanged: (enteredPassword) {
                      password = enteredPassword;
                    },
                    hintText: 'Password',
                  ),
                  const SizedBox(height: 8),
                  CustomButton(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        try {
                          BlocProvider.of<LoginCubit>(context).loginUser(email: email!, password: password!);
                          if (context.mounted) {
                            Navigator.pushNamed(context, ChatScreen.chatRoute, arguments: email);
                          }
                        } catch (ex) {
                          showSnackBar(context, 'there was an error');
                        }

                        isLoading = false;
                      } else {}
                    },
                    buttonText: 'Sign in',
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "don't have an account?  ",
                        style: TextStyle(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return RegisterScreen();
                          }));
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(color: Color(0xffC7EDE6)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
