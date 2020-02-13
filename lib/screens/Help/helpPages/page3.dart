import 'package:flutter/material.dart';

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
          child: Text.rich(
        TextSpan(
          text: "Searching and Adding Favorite Hyms\n\n",
          style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 23,
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold),
          children: [
            TextSpan(
                text:
                    '''In this application, you can search for hyms based on a word or words contained in their title or based on a number contained in the hymn number.
You can equally set some hyms as favorite so that you can always quickly access them.
\n''',
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 19,
                    color: Colors.black,
                    fontWeight: FontWeight.normal)),
            TextSpan(
              text: "Searching for A Hym\n\n",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 20,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: '''
To Search for A hym by name:\n
From the home screen, tap on the icon which resembles a lens; this will open the search page. From there just type a word or words contained in the title of the hymn.
All the Hyms who's titles contain those words will appear on the screen and you can select the one you want.

To search for A Hymn by number:\n
Access the search screen through the drawer and then tap on the more icon ( 3 vertical dots), a pop up will appear tap on it and it will lead you to the search by number screen.
You can then type in a number, all hymns who's numbers contain those digits will be displayed. You can then select your hymn from there.
''',
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            ),
            TextSpan(
              text: "\nSet Favorite Hyms\n\n",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 20,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: '''To set a hymn as favorite:
- From the hym page, tap on the heart icon an the top of the screen, when it becomes pink, it means you have set the hym as favorite.
if you tap on the icon again, it will remove the hym from your favorites.

To see your favorite hyms:
- open the drawer and you will see a heart icon, tap on it and it will open a page containing all your favorite hymns. 
you can remove these hyms from you favorites by checking the delete checkbox and selecting the hymn to be removed.
''',
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
        textAlign: TextAlign.start,
      )),
    );
  }
}
