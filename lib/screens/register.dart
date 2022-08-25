import 'package:flutter/material.dart';
import 'package:android_assignment/http/httpuser.dart';
import 'package:android_assignment/database/database_instance.dart';
import 'package:android_assignment/entity/user.dart';
import 'package:android_assignment/model/user.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String username = '';
  String fullName = '';
  String eMail = '';
  String phoneNo = '';
  String password = '';

  insertData(String username, String fullName, String eMail, String phoneNo,
      String password) async {
    var user = FUser(
        username: username,
        fullName: fullName,
        eMail: eMail,
        phoneNo: phoneNo,
        password: password);
    final database = await DatabaseInstance.instance.getDatabaseInstance();
    await database.userDao.insertUser(user);
  }

  final _formkey = GlobalKey<FormState>();

  Future<bool> registerUser(User user) {
    var res = HttpConnectUser().registerPost(user);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        backgroundColor: Colors.grey[900],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Column(
              children: [
                TextFormField(
                  onSaved: (val) {
                    username = val!;
                  },
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Username cannot be empty"),
                  ]),
                  decoration: InputDecoration(
                    labelText: "Username",
                    hintText: "username",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onSaved: (val) {
                    fullName = val!;
                  },
                  validator: MultiValidator([
                    RequiredValidator(
                        errorText: "Please provide your Full Name"),
                  ]),
                  decoration: InputDecoration(
                    labelText: "Full Name",
                    hintText: "Full Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onSaved: (val) {
                    eMail = val!;
                  },
                  keyboardType: TextInputType.emailAddress,
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Please provide your E-Mail"),
                    EmailValidator(errorText: "Please provide a valid E-Mail"),
                  ]),
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "example@gmail.com",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onSaved: (val) {
                    phoneNo = val!;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Phone No.",
                    hintText: "xxxx-xxx-xxx",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onSaved: (val) {
                    password = val!;
                  },
                  onChanged: (val) => password = val,
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Password cannot be empty"),
                  ]),
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "**********",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value) =>
                      MatchValidator(errorText: "Password do not match")
                          .validateMatch(value!, password),
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Re-enter Password",
                    hintText: "**********",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[900],
                    padding: EdgeInsets.fromLTRB(34, 13, 34, 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23),
                    ),
                  ),
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState!.save();
                      try {
                        User u = User(
                            username: username,
                            fullName: fullName,
                            eMail: eMail,
                            phoneNo: phoneNo,
                            password: password);

                        bool isRegistered = await registerUser(u);
                        if (isRegistered) {
                          Fluttertoast.showToast(
                            msg: "Registered Successfully",
                            backgroundColor: Colors.green,
                          );
                          Navigator.popAndPushNamed(context, '/');
                        } else {
                          Fluttertoast.showToast(
                            msg: "Something went wrong. Please try again.",
                            backgroundColor: Colors.red,
                          );
                        }
                        insertData(
                            username, fullName, eMail, phoneNo, password);
                      } catch (err) {
                        Fluttertoast.showToast(
                          msg: "Something went wrong. Please try again.",
                          backgroundColor: Colors.red,
                        );
                      }
                    }
                  },
                  child: Text("Register"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/view');
                  },
                  child: Text("View local Database"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
