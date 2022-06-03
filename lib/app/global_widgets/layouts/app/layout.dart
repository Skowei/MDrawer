import 'package:mdrawer/common.dart';

class AppLayout extends StatelessWidget {
  final String? title;
  final Widget? content;
  final AppBar? appbar;
  final Drawer? drawer;

  const AppLayout({Key? key, this.title, this.content, this.appbar, this.drawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getDrawer(),
      appBar: getAppBar(),
      body: content,
    );
  }

  getAppBar() {
    return appbar ?? AppBar(title: Text(title!));
  }

  getDrawer() {
    return drawer ?? const NavigationDrawer();
  }
}
