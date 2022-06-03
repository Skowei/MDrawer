import 'package:mdrawer/common.dart';
import 'package:mdrawer/app/routes/app_pages.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        child: ListView(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          children: [
            DrawerHeader(
              // decoration: BoxDecoration(),
              child: Text(
                AppLocalizations.of(context)!.appTitle,
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            DrawerItem(
              icon: const FaIcon(
                FontAwesomeIcons.house,
                size: 20.0,
              ),
              title: AppLocalizations.of(context)!.page_home,
              route: Routes.home,
              selected: ModalRoute.of(context)!.settings.name == Routes.home,
            ),
            DrawerItem(
              icon: const FaIcon(
                FontAwesomeIcons.box,
                size: 20.0,
              ),
              title: AppLocalizations.of(context)!.page_about,
              route: Routes.about,
              selected: ModalRoute.of(context)!.settings.name == Routes.about,
            ),
            DrawerItem(
              icon: const FaIcon(
                FontAwesomeIcons.table,
                size: 20.0,
              ),
              title: AppLocalizations.of(context)!.page_projects,
              route: Routes.projects,
              selected: ModalRoute.of(context)!.settings.name == Routes.projects,
            ),
            const Divider(color: Colors.white12),
            ListTile(
              leading: const FaIcon(
                FontAwesomeIcons.circleHalfStroke,
                size: 20.0,
              ),
              title: Text(AppLocalizations.of(context)!.change_theme),
              onTap: () => ThemeService().changeThemeMode(),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String? title;
  final dynamic icon;
  final String? route;
  final Object? arguments;
  final bool? selected;

  const DrawerItem({
    super.key,
    this.icon,
    this.title,
    @required this.route,
    this.arguments,
    this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: selected ?? false,
      leading: icon,
      title: Text(title!),
      onTap: () {
        Get.toNamed(
          "$route",
          arguments: arguments,
        );
      },
    );
  }
}
