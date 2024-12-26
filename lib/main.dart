import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpnest/core/config/firebase_options.dart';
import 'package:helpnest/core/config/theme.dart';
import 'package:helpnest/features/home/presentation/pages/home_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(411.42857142857144, 843.4285714285714),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            themeMode: ThemeMode.light,
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            debugShowCheckedModeBanner: false,
            home: const HomeController(),
          );
        });
  }
}
