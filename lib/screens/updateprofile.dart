import 'package:android_assignment/http/httpuser.dart';
import 'package:android_assignment/model/user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  String? uId;
  String? username;
  String? fullName;
  String? eMail;
  String? phoneNo;
  String? userImage;
  EditProfile(
      {Key? key,
      required this.uId,
      this.username,
      this.fullName,
      this.eMail,
      this.phoneNo,
      this.userImage})
      : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String url = 'http://192.168.0.106:90/';
  final _formkey = GlobalKey<FormState>();

  final cusername = TextEditingController();
  final cfullName = TextEditingController();
  final ceMail = TextEditingController();
  final cphoneNo = TextEditingController();

  File? _image;
  String username = '';
  String fullName = '';
  String eMail = '';
  String phoneNo = '';

  @override
  @override
  void initState() {
    super.initState();
    _image = null;
  }

  _imageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
  }

  _imageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: Colors.grey[900],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Center(
            child: Column(children: [
              Stack(
                  alignment: AlignmentDirectional.center,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      color: Colors.grey[700],
                      height: 120,
                    ),
                    Positioned(
                      top: 59,
                      child: CircleAvatar(
                        backgroundImage: _image == null
                            ? AssetImage('images/avatar.png') as ImageProvider
                            : FileImage(_image!),
                        radius: 65,
                      ),
                    )
                  ]),
              SizedBox(
                height: 18,
              ),
              IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context, builder: (builder) => bottomSheet());
                  },
                  icon: Icon(
                    Icons.add_a_photo,
                    color: Colors.white,
                    size: 30,
                  )),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextFormField(
                      enabled: false,
                      onSaved: (val) {
                        username = val!;
                      },
                      decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 190, 190, 190))),
                        labelText: widget.username,
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
                      controller: cfullName..text = widget.fullName!,
                      onSaved: (val) {
                        fullName = val!;
                      },
                      validator: MultiValidator([
                        RequiredValidator(
                            errorText: "Full Name cannot be empty"),
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
                      controller: ceMail..text = widget.eMail!,
                      onSaved: (val) {
                        eMail = val!;
                      },
                      validator: MultiValidator([
                        RequiredValidator(
                            errorText: "Username cannot be empty"),
                        EmailValidator(
                            errorText: "Please enter a valid e-Mail"),
                      ]),
                      keyboardType: TextInputType.emailAddress,
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
                      controller: cphoneNo..text = widget.phoneNo!,
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
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey[900],
                  padding: EdgeInsets.fromLTRB(30, 13, 30, 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23),
                  ),
                ),
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();
                    User user = User(
                        fullName: fullName, eMail: eMail, phoneNo: phoneNo);
                    bool res = await HttpConnectUser().updateUser(user);
                    if (res) {
                      Fluttertoast.showToast(
                          msg: "User information updated",
                          backgroundColor: Colors.green);
                      setState(() {
                        Navigator.popAndPushNamed(context, '/myprofile');
                      });
                    } else {
                      Fluttertoast.showToast(
                          msg: "Update Failed! Please try again",
                          backgroundColor: Colors.red);
                    }
                  }
                },
                child: Text("Update Information"),
              ),
              SizedBox(
                height: 15,
              ),
              TextButton.icon(
                icon: Icon(Icons.delete_outline),
                label: Text("Delete Account"),
                style: TextButton.styleFrom(
                  primary: Color.fromARGB(255, 223, 39, 26),
                  //padding: EdgeInsets.fromLTRB(30, 13, 30, 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23),
                  ),
                ),
                onPressed: () {
                  showPopUp(context);
                },
              )
            ]),
          ),
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text(
            "Select an Image",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 90, 90, 90),
                  padding: EdgeInsets.fromLTRB(14, 5, 14, 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23),
                  ),
                ),
                onPressed: () {
                  _imageFromCamera();
                  Navigator.pop(context);
                },
                icon: Icon(Icons.camera),
                label: Text("Camera"),
              ),
              SizedBox(
                width: 20,
              ),
              ElevatedButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 90, 90, 90),
                  padding: EdgeInsets.fromLTRB(14, 5, 14, 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23),
                  ),
                ),
                onPressed: () {
                  _imageFromGallery();
                  Navigator.pop(context);
                },
                icon: Icon(Icons.browse_gallery),
                label: Text("Gallery"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  showPopUp(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Are you sure you want to delete your account?',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Divider(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey[900],
                            padding: EdgeInsets.fromLTRB(14, 5, 14, 5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(23),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: EdgeInsets.fromLTRB(14, 5, 14, 5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(23),
                            ),
                          ),
                          onPressed: () async {
                            bool res = await HttpConnectUser().deleteUser();
                            if (res) {
                              Fluttertoast.showToast(
                                msg: "Account Deleted",
                                backgroundColor: Colors.green,
                              );
                              Navigator.popAndPushNamed(context, '/');
                            } else {
                              Fluttertoast.showToast(
                                msg: "Failed to delete account.",
                                backgroundColor: Colors.red,
                              );
                            }
                          },
                          child: Text('Yes'),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
