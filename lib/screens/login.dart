import 'package:android_assignment/http/httpuser.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();

  String username = '';
  String password = '';

  Future<bool> loginUser(String username, String password) {
    var res = HttpConnectUser().loginPost(username, password);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 100, 25, 10),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Icon(
                Icons.camera,
                size: 50,
              ),
              Text(
                "PhotoHub",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                onSaved: (value) {
                  username = value!;
                },
                validator: MultiValidator([
                  RequiredValidator(errorText: "Please enter your username")
                ]),
                decoration: InputDecoration(
                  labelText: "Username",
                  hintText: "username",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.grey[900],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: TextFormField(
                  onSaved: (value) {
                    password = value!;
                  },
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Please enter your password"),
                    MinLengthValidator(5,
                        errorText:
                            "Password should contain minimum of 5 characters"),
                  ]),
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    labelText: "Password",
                    hintText: "**********",
                    prefixIcon: Icon(
                      Icons.security,
                      size: 20,
                      color: Colors.grey[900],
                    ),
                    suffixIcon: Icon(Icons.remove_red_eye),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[900],
                    padding: EdgeInsets.fromLTRB(40, 13, 40, 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23),
                    ),
                  ),
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState!.save();
                      try {
                        bool isLogged = await loginUser(username, password);
                        if (isLogged) {
                          Fluttertoast.showToast(
                            msg: "Successfully Logged in",
                            backgroundColor: Colors.green,
                          );
                          Navigator.popAndPushNamed(context, '/homepage');
                        } else {
                          Fluttertoast.showToast(
                            msg: "Something went wrong. Please try again.",
                            backgroundColor: Colors.red,
                          );
                        }
                      } catch (err) {
                        Fluttertoast.showToast(
                          msg: "Something went wrong. Please try again.",
                          backgroundColor: Colors.red,
                        );
                      }
                    }
                  },
                  child: Text("Login"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text("Don't have an account yet?"),
              ),
              ElevatedButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey[900],
                  padding: EdgeInsets.fromLTRB(34, 13, 34, 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text("Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
