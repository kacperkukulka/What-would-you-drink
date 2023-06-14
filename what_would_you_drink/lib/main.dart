import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:what_would_you_drink/models/light_user.dart';
import 'package:what_would_you_drink/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:what_would_you_drink/services/auth.dart';
import 'package:what_would_you_drink/displayData/data_colors.dart' as dc;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDTXGCstCwvkb2Lg9nmEBlHaEMt_9M5DjY', 
      appId: '1:1061847055840:android:f88fb7393a564942f2ff85', 
      messagingSenderId: '1061847055840', 
      projectId: 'what-would-you-drink')
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<LightUser?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme(
            background: dc.colorBg!,
            brightness: Brightness.light,
            error: dc.colorError!,
            onBackground: dc.colorTextPrimary,
            onError: dc.colorTextSecondary,
            onPrimary: dc.colorTextSecondary,
            onSecondary: dc.colorTextSecondary,
            onSurface: dc.colorTextPrimary,
            primary: dc.colorPrimary!,
            secondary: dc.colorTextSecondary,
            surface: dc.colorBg!,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: dc.colorAppBar,
          )
        ),
        home: Wrapper(),
      ),
    );
  }
}