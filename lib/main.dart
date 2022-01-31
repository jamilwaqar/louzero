import 'package:firebase_core/firebase_core.dart';
import 'package:louzero/controller/notification_manager.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/controller/get/auth_controller.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/ui/page/auth/login.dart';
import 'package:louzero/ui/page/dashboard/dashboard.dart';
import 'package:country_picker/country_picker.dart';
import 'controller/api/api_manager.dart';
import 'controller/get/base_controller.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationManager.init();
  await GetStorage.init();
  await Backendless.initApp(
      applicationId: APIManager.applicationId,
      androidApiKey: APIManager.androidApiKey,
      jsApiKey: APIManager.jsApiKey,
      iosApiKey: APIManager.iosApiKey);
  Get.put(AuthController(Backendless.userService), permanent: true);
  Get.put(BaseController());
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

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!Get.find<AuthController>().loggedIn.value && Get.find<AuthController>().isAuthUser) {
        NavigationController().loading();
        return const AppBaseScaffold(
          logoOnly: true,
        );
      }
      NavigationController().loading(isLoading: false);
      if (Get.find<AuthController>().loggedIn.value) {
        return DashboardPage();
      }
      return const LoginPage();
    });
  }
}
