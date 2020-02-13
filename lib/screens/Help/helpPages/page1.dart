import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
          child: Text.rich(
        TextSpan(
          text: "Getting Started\n\n",
          style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 23,
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold),
          children: [
            TextSpan(
                text:
                    '''To open a hym of your choice, you have a variety of options on the home screen: \n
- You can directly type in the number of the hym at the number input widget(where the # is) and then tap on the "Go" button, this will open the screen of that particular hymn.\n
- You can equally tap on the image where we have A-Z, this will open a page in which the hyms are arranged in alphabetic order. From there tap on the letter which corresponds to the first letter of the title of your hym and then just select the hym you want\n
- You can also tap on the image where we have the symbol of a musical note. This will open a page in which the hyms are arranged according to themes like in the hymnal. All you have to do is select a theme, and then select a hymn.\n
\n''',
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 19,
                    color: Colors.black,
                    fontWeight: FontWeight.normal)),
            TextSpan(
              text: "Playing Hyms\n\n",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 20,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: '''
In order to play a hym do the following:\n
- Open the the hym you want to play
- You can tap directly on the play button at the bottom of the page; this will play the hymn online, so make sure you have an active internet connection. Not to worrym the music files are very light.\n
- You can also tap on the download button (right-most botton at the bottom of the screen with an arrow pointing downwards) to download the hymn into your phone and play it locally anytime you want to without an internet connection.\n

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
