import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_chat/cubits/login_cubit/login_cubit.dart';
import 'package:m_chat/screens/chat_screen.dart';
import 'package:m_chat/screens/login_screen.dart';
import 'package:m_chat/screens/register_screen.dart';
import 'package:wakelock/wakelock.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MetaChat());
}

class MetaChat extends StatelessWidget {
  const MetaChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Wakelock.toggle(enable: true);
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: MaterialApp(
        routes: {
          LoginScreen.loginRoute: (context) => LoginScreen(),
          RegisterScreen.registerRoute: (context) => RegisterScreen(),
          ChatScreen.chatRoute: (context) => ChatScreen(),
        },
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.loginRoute,
      ),
    );
  }
}
