import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sda_hymnal/components/appDrawer.dart';
import 'package:sda_hymnal/provider/_authProvider.dart';
import 'package:sda_hymnal/provider/profileProvider.dart';
import 'package:sda_hymnal/screens/SignUp/confirmEmail.dart';
import 'package:sda_hymnal/screens/profile/profileScreen.dart';
import 'package:sda_hymnal/utils/validator.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.green,
          primaryIconTheme: IconThemeData(color: Colors.white),
          appBarTheme: AppBarTheme(
              textTheme: TextTheme(
                  title: TextStyle(color: Colors.white, fontSize: 20)))),
      title: "Log In screen",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Log Into Your Account"),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: MyDrawer(),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(child: LoginForm()),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController _emailController;
  TextEditingController _passwordController;

  bool _autoValidate;
  bool _hidePass1;

  bool _loading;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _autoValidate = false;
    _hidePass1 = true;
    _loading = false;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.account_circle,
                      color: Colors.green,
                      size: 70,
                    ),
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.green,
                      ),
                    )
                  ],
                ),
              ),
              TextFormField(
                validator: (value) => Validator.emailValidator(value),
                controller: _emailController,
                decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.green),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) => Validator.passwordValidator(value),
                controller: _passwordController,
                obscureText: _hidePass1,
                decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.green),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    suffixIcon: InkWell(
                      child: Icon(
                        _hidePass1 ? Icons.visibility : Icons.visibility_off,
                        color: Colors.green,
                      ),
                      onTap: () {
                        setState(() {
                          _hidePass1 = !_hidePass1;
                        });
                      },
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: !_loading
                    ? RaisedButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                        child: Text(
                          "LogIn",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        onPressed: () => _validateForm(context),
                        color: Colors.green,
                      )
                    : CircularProgressIndicator(
                        backgroundColor: Colors.green,
                      ),
              )
            ],
          ),
        ));
  }

  static void showMyDialogue(String title, String message, BuildContext context,
      {bool positive = true}) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.green[50],
            title: Text(
              title,
              textAlign: TextAlign.center,
            ),
            titleTextStyle:
                TextStyle(color: positive ? Colors.green : Colors.red),
            contentTextStyle:
                TextStyle(color: positive ? Colors.green : Colors.red),
            content: Container(
              child: Text(message),
              padding: EdgeInsets.all(10),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          );
        });
  }

  _validateForm(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _loading = true;
      });

      String result = await AuthProvider.instance()
          .loginUser(_emailController.text, _passwordController.text);

      setState(() {
        _loading = false;
      });

      if (result == "invalid email") {
        showMyDialogue("Invalid Email",
            "Sorry the email you entered is not valid try again", context,
            positive: false);
      } else if (result == "wrong password") {
        showMyDialogue("Wrong Password",
            "Sorry the password you entered is incorrect", context,
            positive: false);
      } else if (result == "user not found") {
        showMyDialogue("User not found",
            "Sorry the user with this email address was not found", context,
            positive: false);
      } else {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => StreamProvider.value(
                  value: ProfileProvider.instance().streamUserProfile(result),
                  child: ProfileScreen(userId: result),
                  catchError: (context, obj) {
                    print("an error occured while providing ${obj.toString()}");
                    return;
                  },
                )));
      }
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
