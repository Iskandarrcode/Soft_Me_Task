import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soft_me/ui/screens/login_register_screen/login_screen.dart';
import 'package:soft_me/ui/widgets/navigation_bar/navigation_bar.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Stream<dynamic> getToken() async* {
    final prefs = await SharedPreferences.getInstance();
    yield prefs.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: getToken(),
        builder: (context, snapshot) {
          print("snapshot DAta");
          print(snapshot.data);
          if (snapshot.hasData) {
            return const NavigationBars();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
