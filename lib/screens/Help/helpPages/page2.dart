import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
          child: Text.rich(
        TextSpan(
          text: "User Profile and Hym Comments\n\n",
          style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 23,
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold),
          children: [
            TextSpan(
                text:
                    '''With the sda_hymnal app, you have the possibilty to comment on hyms you loved, and even share these.
But in order to do so you have to start by creating a user profile. To access user profile options, open the drawer and tap on the the icon which is like a person in a circle
\n''',
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 19,
                    color: Colors.black,
                    fontWeight: FontWeight.normal)),
            TextSpan(
              text: "Creating a User Profile\n\n",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 20,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: '''
In order to create a user profile do the following:\n
- Firstly, if you already have a user profile just login and you are good to go.
- Otherwise, enter your email and new password in the form provided to create a new account.\n
- You will be required to verify your email address. An email will be sent to the email address you entered.\n
- Once this is done, click on the "I have verified my Email" button and this will lead you to your profile page. Here you can change your email or user name and also add or change a profile picture.
''',
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            ),
            TextSpan(
              text: "\nComment on Hyms\n\n",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 20,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text:
                  ''' When you are on the page of the hym you want to comment on, tap on the comment icon at the top right of the screen where it is written "Comment"
If no one has commented yet on the app, the screen will be blank, just click on the comment icon and the text input will appear.
Type in your comment and press the send icon.\n
You can like, and reply to other people's comments, or even yours.
You can equally share comments.

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
