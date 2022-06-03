import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mdrawer/app/global_widgets/layouts/app/layout.dart';
import 'package:mdrawer/common.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  String? title = 'Home Page';

  var markdownData = '''

# Słowem wstępu
### Autorem aplikacji jest Maciej Skowroński.
### Aplikacja MDrawer oferuje tworzenie wielu tablic projektowych zawierających taski.
### Projekty jak i taski zawierają nazwę, opis oraz kolor.
### Funkcjonalność projektów oraz tasków są niemal identyczne.
### Opisy tasków oraz projektów mogą być zapisywane w formacie markdown!
### Taski można skreślać poprzez zaznaczenie checkboxa!
### Aktualnie aplikacja wspiera jedną listę tasków dla danego projektu.
### Po więcej informacji przejdź na stronę "Jak Używać".

# Nawigacja
### Po wejściu w "Projekty" wyświetli nam się lista aktualnych projektów.
### Możemy dodać nowy projekt klikając + na pasku nawigacyjnym.
### Po dodadniu projektu możemy go podejrzeć, edytować oraz usunąć.
### Projekty można zamieniać kolejnością klikając i przytrzymując.
### Aby otworzyć dany projekt, kliknij go.
### ta sama logika tyczy się tasków z wyjątkiem otwierania :)
''';

  @override
  Widget build(BuildContext context) {
    title = AppLocalizations.of(context)!.page_home;
    return AppLayout(
      title: title,
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            MarkdownBody(
              data: markdownData,
            )
          ],
        ),
      ),
    );
  }
}
