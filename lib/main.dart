import 'package:flutter/material.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:louzero/bloc/base/base.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/controller/state/auth_manager.dart';
import 'package:louzero/ui/page/auth/login.dart';
import 'package:louzero/ui/page/base_scaffold.dart';
import 'package:louzero/ui/page/dashboard/dashboard.dart';
import 'package:country_picker/country_picker.dart';
import 'package:provider/provider.dart';
import 'controller/api/api_manager.dart';
import 'controller/get/base_controller.dart';
import 'controller/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(BaseController());
  await GetStorage.init();
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
    return GetMaterialApp(
      localizationsDelegates: const [
        CountryLocalizations.delegate,
      ],
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
      valueListenable: AuthManager().loggedIn,
      builder: (ctx, value, child) {
        if (!value && AuthManager().isAuthUser) {
          NavigationController().loading();
          return const BaseScaffold();
        }
        NavigationController().loading(isLoading: false);
        if (value) {
          return DashboardPage();
        }
        return const LoginPage();
      },
    );
  }
}
