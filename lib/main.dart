import 'package:flutter/material.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:louzero/controller/state/auth_state.dart';
import 'package:louzero/ui/page/auth/login.dart';
import 'package:louzero/ui/page/dashboard/dashboard.dart';

import 'controller/api/api_manager.dart';
import 'controller/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Backendless.setUrl(APIManager.API_HOST);
  await Backendless.initApp(
      applicationId: APIManager.APPLICATION_ID,
      androidApiKey: APIManager.ANDROID_API_KEY,
      iosApiKey: APIManager.IOS_API_KEY);
  await Utils().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: "Roboto"),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AuthStateManager().loggedIn,
      builder: (ctx, value, child) {
        if (value) {
          return const DashboardPage();
        }
        return const LoginPage();
      },
    );

  }
}
