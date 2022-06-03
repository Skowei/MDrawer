import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mdrawer/app/global_widgets/layouts/app/layout.dart';
import 'package:mdrawer/common.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutView extends StatelessWidget {
  AboutView({super.key});

  String? title = "About MDrawer";

  var markdownData = '''
# Aplikacja wspiera język markdown. Poniżej przedstawiono przykładowe elementy.
# Pełną listę wspieranej składni znajdziesz na stronie [dokumentacji](https://www.markdownguide.org/cheat-sheet/).
# Uwaga: Aktualnie paczka nie wspiera list numerowanych i punktowanych. Nie używaj znaków 1. - * .
---
##   Nagłówki
  # Heading level 1
  ## Heading level 2
  ### Heading level 3
  #### Heading level 4
  ##### Heading level 5
  ###### Heading level 6

---
## Paragraf
  I really like using Markdown.

---
## Bold
  I just love **bold text**.

---
## Italic
  Italicized text is the *cat's meow*.

---
## Bold and Italic
  This text is ***really important***.

---
## Blockquotes
  > Dorothy followed her through many of the beautiful rooms in her castle.

---
## Blockquotes with Multiple Paragraphs
> Dorothy followed her through many of the beautiful rooms in her castle.
>
> The Witch bade her clean the pots and kettles and sweep the floor and keep the fire fed with wood.

---
## Nested Blockquotes
> Dorothy followed her through many of the beautiful rooms in her castle.
>
>> The Witch bade her clean the pots and kettles and sweep the floor and keep the fire fed with wood.

---
## Lists

### Ordered Lists
  1. First item
  2. Second item
  3. Third item
      1. Indented item
      2. Indented item
  4. Fourth item 

---
### Unorderer Lists

  - First item
  - Second item
  - Third item
      - Indented item
      - Indented item
  - Fourth item 

---
### Code 
At the command prompt, type `nano`.

---
### Horizontal Rules
  Try to put a blank line before...

  ---

  ...and after a horizontal rule. 

---
### Links
  [pingu](https://i.pinimg.com/474x/b3/ea/ae/b3eaae1fdde0885770aaf3eea5138623.jpg)
''';

  @override
  Widget build(BuildContext context) {
    title = AppLocalizations.of(context)!.page_about;
    return AppLayout(
      title: title,
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            MarkdownBody(
              data: markdownData,
              onTapLink: (text, url, title) {
                launch(url!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
