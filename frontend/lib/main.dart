import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripflutter/consts.dart';
import 'component/my_app_bar.dart';
import 'package:tripflutter/screens/schedule_manager/pay.dart';
import 'package:tripflutter/screens/schedule_manager/schedule_manager_controller.dart';
import 'firebase_options.dart';

import 'middleware.dart';
import 'modules/auth_service.dart';
import 'modules/home_controller.dart';
import 'screens/auth_login_pages/login_page.dart';
import 'screens/auth_signup_pages/signup_page.dart';
import 'screens/schedule_detail/schdule_detail.dart';
import 'screens/schedule_selector/schedule_selector.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

late final FirebaseApp app;
late final FirebaseAuth auth;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  auth = FirebaseAuth.instanceFor(app: app);

  if (kDebugMode) {
    try {
      FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
      print('kDebugMode should useAuthEmulator');
      await auth.useAuthEmulator('127.0.0.1', 9099);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Get.put(FirebaseAuthService());
  Get.put(HomeController()); //TODO 廢棄
  Get.put(ScheduleManagerController());
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: MyStyles.tripPrimary,
        textTheme: GoogleFonts.notoSansTextTheme(
          ThemeData(brightness: Brightness.light).textTheme,
        ),
      ),
      initialRoute: AppLinks.SCHEDUL,
      getPages: [
        GetPage(
          name: AppLinks.SIGNUP,
          page: () => const SignUpPage(),
        ),
        GetPage(
          name: AppLinks.LOGIN,
          page: () => const LoginPage(),
        ),
        GetPage(
          name: AppLinks.SCHEDUL,
          page: () => const MyHomePage(title: '登峰造極'),
          children: [
            GetPage(
                name: AppLinks.DETAIL,
                page: () => const ScheduleDetailPage(),
                children: [
                  GetPage(
                    name: AppLinks.PAY,
                    page: () => const Pay(),
                    middlewares: [PayMiddleware()],
                  ),
                ]),
          ],
        ),
        GetPage(
          name: AppLinks.LOGIN,
          page: () => const LoginPage(),
        ),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(),
      body:
          ScheduleSelector(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
