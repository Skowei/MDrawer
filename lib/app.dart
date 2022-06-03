import 'package:flutter_localizations/flutter_localizations.dart';
// Project Imports
import 'package:mdrawer/lang/locales.dart';
import 'package:mdrawer/app/routes/app_pages.dart';
import 'package:mdrawer/common.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MDrawer',

      debugShowCheckedModeBanner: false,

      /// Theme Settings
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeService().getThemeMode(),

      /// Controllers disposing
      smartManagement: SmartManagement.full,

      /// Localization settings(for translations)
      supportedLocales: supportedLocalesList,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate,
      ],

      /// Routing Settings
      initialRoute: AppPages.initial, //'/',
      getPages: AppPages.routes,
      unknownRoute: AppPages.unknownView,
      transitionDuration: const Duration(seconds: 0),
    );
  }
}
