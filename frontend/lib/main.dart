import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripflutter/component/widgets.dart';
import 'package:tripflutter/consts.dart';
import 'firebase_options.dart';

import 'screens/schedule_selector/schedule_selector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (kDebugMode) {
    try {
      FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
      print('kDebugMode should useAuthEmulator');
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
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
      home: const MyHomePage(title: '登峰造極'),
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
    TextStyle appBarTextStyle =
        MyStyles.kTextStyleH4.copyWith(color: Colors.white);
    SizedBox appBarSpacer = const SizedBox(width: 24.0);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyles.tripTertiary,
        title: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 1160,
              maxHeight: 57,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Logo(),
                Row(
                  children: [
                    Text(
                      '關於我們',
                      style: appBarTextStyle,
                    ),
                    appBarSpacer,
                    Text(
                      '路線資訊',
                      style: appBarTextStyle,
                    ),
                    appBarSpacer,
                    Text(
                      '主題活動',
                      style: appBarTextStyle,
                    ),
                    appBarSpacer,
                    Text(
                      '登山小學堂',
                      style: appBarTextStyle,
                    ),
                    appBarSpacer,
                    Text(
                      '會員專區',
                      style: appBarTextStyle,
                    ),
                    appBarSpacer,
                    Text(
                      '註冊',
                      style: appBarTextStyle,
                    ),
                    appBarSpacer,
                    FilledButton(
                      onPressed: () {},
                      child: Text('登入'),
                      style: FilledButton.styleFrom(
                        backgroundColor: MyStyles.tripNeutral,
                        foregroundColor: MyStyles.tripTertiary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        toolbarHeight: 120,
      ),
      body:
          const ScheduleSelector(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
