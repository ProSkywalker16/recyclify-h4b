import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recyclify/OwnerHome.dart';
import 'package:recyclify/components/settings.dart';
import 'package:recyclify/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:recyclify/models/colors.dart';
import 'package:recyclify/pages/OwnerPage.dart';
import 'package:recyclify/pages/confirmation.dart';
import 'package:recyclify/pages/confirmationPage.dart';
import 'package:recyclify/pages/date&time.dart';
import 'package:recyclify/pages/login_page.dart';
import 'package:recyclify/pages/register_page.dart';
import 'package:recyclify/services/database.dart';
import 'package:recyclify/services/auth_service.dart';
import 'package:recyclify/services/navigation_service.dart';
import 'package:recyclify/utils.dart';
import 'package:recyclify/pages/splash_screen.dart'; // Import the SplashScreen
import 'package:geolocator/geolocator.dart'; // ✅ Added import for location

ThemeMode globalThemeModeVar = ThemeMode.light;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(
    MyApp(),
  );
}

Future<void> setup() async {
  await setupFirebase();
  await registerServices();
  await requestLocationPermission(); // ✅ Request location permission at startup
}

Future<void> requestLocationPermission() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
}

class MyApp extends StatefulWidget {
  late NavigationService _navigationService;
  late AuthService _authService;
  final GetIt _getIt = GetIt.instance;

  MyApp({super.key}) {
    _navigationService = _getIt.get<NavigationService>();
    _authService = _getIt.get<AuthService>();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.light;
 // Manual theme toggle
  ColorSelection colorSelected = ColorSelection.pink;

  void changeThemeMode(bool useLightMode) {
    setState(() {
      themeMode = useLightMode
      ? ThemeMode.light 
      : ThemeMode.dark;
      globalThemeModeVar = themeMode;
    });
  } 
  void changeColor(int value) {
    setState(() {
      colorSelected = ColorSelection.values[value];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: widget._navigationService.navigatorKey,
      title: 'Flutter Demo',
      themeMode: themeMode,
      theme: ThemeData(
        colorSchemeSeed: colorSelected.color,
        useMaterial3: true,
        textTheme: GoogleFonts.montserratTextTheme(),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: colorSelected.color,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      initialRoute: "/splash",
      routes: {
        "/splash": (context) => ConfirmationPAge(),
        "/login": (context) => LoginPage(),
        "/home": (context) => HomeScreen(changeTheme: changeThemeMode, changeColor: changeColor, colorSelected: colorSelected,),
        "/register": (context) => RegisterPage(),
        "/settings": (context) => Settings(),
        '/date_time': (context) => Date_Time(), 
        "/OwnerHome":(context)=> OwnerHome(),
      },
    );
  }
}
