import 'package:flutter/material.dart';
import 'package:sda_hymnal/components/appDrawer.dart';
import 'package:sda_hymnal/provider/_authProvider.dart';
import 'package:sda_hymnal/screens/Login/login.dart';
import 'package:sda_hymnal/screens/SignUp/confirmEmail.dart';
import 'package:sda_hymnal/utils/preferences/preferences.dart';
import 'package:sda_hymnal/utils/validator.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen(this.settings);
  final MyAppSettings settings;

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  StreamingSharedPreferences _prefs;

  @override
  void initState() {
    StreamingSharedPreferences.instance.then((prefs) {
      _prefs = prefs;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.green,
          primaryIconTheme: IconThemeData(color: Colors.white),
          appBarTheme: AppBarTheme(
              textTheme: TextTheme(
                  title: TextStyle(color: Colors.white, fontSize: 20)))),
      title: "Sign Up screen",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Create an Account"),
          centerTitle: true,
          actions: <Widget>[
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: "login",
                  child: Text("Login"),
                )
              ],
              onSelected: (value) {
                if (value == "login") {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LoginScreen(
                            settings: widget.settings,
                          )));
                }
              },
            )
          ],
        ),
        drawer: Drawer(
          child: _prefs != null
              ? MyDrawer(settings: MyAppSettings(_prefs))
              : Drawer(),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(child: SignUpForm(this.widget.settings)),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  SignUpForm(this.settings);
  final MyAppSettings settings;
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _confirmPasswordController;
  bool _autoValidate;
  bool _hidePass1;
  bool _hidePass2;
  bool _loading;
  bool _rememberMe;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _autoValidate = false;
    _hidePass1 = true;
    _hidePass2 = true;
    _loading = false;
    _rememberMe = false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.green,
                      ),
                    )
                  ],
                ),
              ),
              TextFormField(
                validator: (value) => Validator.textValidator(value),
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: "UserName",
                    labelStyle: TextStyle(color: Colors.green),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              ),
              SizedBox(
                height: 20,
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
              TextFormField(
                validator: (value) => Validator.passwordValidator(value),
                controller: _confirmPasswordController,
                obscureText: _hidePass2,
                decoration: InputDecoration(
                    labelText: "Confirm Password",
                    labelStyle: TextStyle(color: Colors.green),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    suffixIcon: InkWell(
                      child: Icon(
                        _hidePass2 ? Icons.visibility : Icons.visibility_off,
                        color: Colors.green,
                      ),
                      onTap: () {
                        setState(() {
                          _hidePass2 = !_hidePass2;
                        });
                      },
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.center,
                width: double.infinity,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Checkbox(
                      activeColor: Colors.green,
                      value: _rememberMe,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = !_rememberMe;
                        });
                      },
                    ),
                    Text(
                      "Remember Me ",
                      style: TextStyle(color: Colors.green),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: !_loading
                    ? RaisedButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        onPressed: () =>
                            _validateForm(context, widget.settings),
                        color: Colors.green,
                      )
                    : CircularProgressIndicator(
                        backgroundColor: Colors.blueAccent,
                        strokeWidth: 7,
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

  _validateForm(BuildContext context, MyAppSettings settings) async {
    if (_passwordController.text != _confirmPasswordController.text) {
      showMyDialogue("Passwords Mismatch",
          "Sorry the two passwords entered do not match", context,
          positive: false);
    } else {
      if (_formKey.currentState.validate()) {
        setState(() {
          _loading = true;
        });
        String status = await AuthProvider.instance()
            .createUser(_emailController.text, _passwordController.text);

        if (status == "already used") {
          showMyDialogue(
              "Email Already Used",
              "Sorry, the email you entered is already used by another person",
              context,
              positive: false);
        } else if (status == "invalid email") {
          showMyDialogue(
              "Invalid Email", "Sorry the email you used is not valid", context,
              positive: false);
        } else if (status == "email sent") {
          if (_rememberMe) {
            await settings.email.setValue(_emailController.text);
            // if (val) print("successfully stored email");

            await settings.password.setValue(_passwordController.text);
            // if (val) print("Successfuly stored password");

          }
          await settings.userName.setValue(_nameController.text);
          await settings.updateMode.setValue("create");
          await settings.hasAccount.setValue(true);

          // if (val) print("hasAccount set to true");

          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => VerifyEmail(
                    email: _emailController.text,
                    userName: _nameController.text,
                    settings: widget.settings,
                  )));
        }

        setState(() {
          _loading = false;
        });
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
    }
  }
}
