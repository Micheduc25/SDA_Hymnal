import 'package:flutter/material.dart';
import 'package:sda_hymnal/components/appDrawer.dart';
import 'package:sda_hymnal/provider/_authProvider.dart';
import 'package:sda_hymnal/screens/SignUp/confirmEmail.dart';
import 'package:sda_hymnal/utils/validator.dart';

class SignUpScreen extends StatelessWidget {
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
        ),
        drawer: Drawer(
          child: MyDrawer(),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(child: SignUpForm()),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
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
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => VerifyEmail(
                  email: _emailController.text,
                  userName: _nameController.text)));
        }

        setState(() {
          _loading = false;
        });

        //  await AuthProvider.instance()
        //     .saveUser(_nameController.text, _emailController.text);

      } else {
        setState(() {
          _autoValidate = true;
        });
      }
    }
  }
}
