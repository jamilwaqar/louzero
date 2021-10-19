import 'package:flutter/material.dart';
import 'package:backendless_sdk/backendless_sdk.dart';

import 'controller/api/api_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Backendless.setUrl(APIManager.API_HOST);
  await Backendless.initApp(
      applicationId: APIManager.APPLICATION_ID,
      androidApiKey: APIManager.ANDROID_API_KEY,
      iosApiKey: APIManager.IOS_API_KEY);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
    return Container();
  }
}
