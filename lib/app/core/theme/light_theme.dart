part of 'package:mdrawer/app/core/theme/theme.dart';

ThemeData get lightTheme => ThemeData.light().copyWith(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Palette.gray[50],
      appBarTheme: AppBarTheme(
        backgroundColor: Palette.rose[400],
      ),
    );
