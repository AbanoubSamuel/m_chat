import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_chat/constants.dart';
import 'package:m_chat/cubits/login_cubit/register_cubit.dart';
import 'package:m_chat/helpers/show_snack_bar.dart';
import 'package:m_chat/widgets/custom_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgets/custom_text_form_field.dart';

class RegisterScreen extends StatelessWidget {
  static const String registerRoute = 'RegisterRoute';
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          showSnackBar(context, 'Successful register');
          isLoading = false;
        } else {
          showSnackBar(context, 'Registration failed');
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
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
                        SizedBox(height: 75),
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
                          'Register',
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
                      onChanged: (enteredPassword) {
                        password = enteredPassword;
                      },
                      hintText: 'Password',
                    ),
                    const SizedBox(height: 8),
                    CustomButton(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            BlocProvider.of<RegisterCubit>(context).registerUser(email: email!, password: password!);
                          } catch (ex) {
                            showSnackBar(context, 'there was an error');
                          }
                        } else {}
                      },
                      buttonText: 'Sign up',
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?  ",
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Sign in',
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
        );
      },
    );
  }
}
