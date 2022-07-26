import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/auth_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/home_screen.dart';
import 'screens/search_screen.dart';
import 'states/controllers_state.dart';
import 'states/overriden_state.dart';
import 'states/repos_state.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ProviderScope(
      overrides: [
        providerOfBaseAuthRepository.overrideWithProvider(providerOfAuthRepository),
        providerOfBaseDBRepository.overrideWithProvider(providerOfDBRepository),
        providerOfBaseRTDMRepository.overrideWithProvider(providerOfRTDMRepository),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: ref.read(providerOfAuthController.notifier).userLoggedIn ? HomeScreen.route : AuthScreen.route,
      routes: {
        AuthScreen.route: (ctx) => const AuthScreen(),
        HomeScreen.route: (ctx) => const HomeScreen(),
        SearchScreen.route: (ctx) => const SearchScreen(),
        ChatScreen.route: (ctx) => const ChatScreen(),
      },
      theme: ThemeData(
        textTheme: const TextTheme(
          headline3: TextStyle(color: Colors.white),
          headline6: TextStyle(
            color: Colors.white,
            // fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size.zero),
            visualDensity: VisualDensity.compact,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: const OutlineInputBorder(),
          contentPadding: EdgeInsets.zero,
          suffixIconColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
