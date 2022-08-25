import 'package:flutter/material.dart';
import 'package:android_assignment/model/photo.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:android_assignment/http/httpphoto.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  final _formkey = GlobalKey<FormState>();
  File? _image;
  String title = '';
  String description = '';
  String location = '';
  String category = '';

  String? value;
  @override
  void initState() {
    super.initState();
    _image = null;
    category = "Uncategorized";
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

  final items = [
    'Uncategorized',
    'Abstract',
    'Animals',
    'Architecture',
    'Art',
    'Black and White',
    'Crowd',
    'Fashion',
    'Film',
    'Food',
    'Landscape',
    'Macro',
    'Nature',
    'Night',
    'People',
    'Sport',
    'Street',
    'Travel',
    'Urban',
    'Vehicles'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new post"),
        backgroundColor: Colors.grey[900],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: _image == null
                        ? AssetImage('images/image_placeholder.png')
                            as ImageProvider
                        : FileImage(_image!),
                    fit: BoxFit.cover,
                  )),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 90, 90, 90),
                    padding: EdgeInsets.fromLTRB(34, 13, 34, 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23),
                    ),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context, builder: (builder) => bottomSheet());
                  },
                  icon: Icon(Icons.upload),
                  label: Text("Select Image"),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        onSaved: (val) {
                          title = val!;
                        },
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Title cannot be empty"),
                        ]),
                        decoration: InputDecoration(
                          labelText: "Title",
                          hintText: "Title",
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
                          description = val!;
                        },
                        decoration: InputDecoration(
                          labelText: "Description",
                          hintText: "Describe your image",
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
                          location = val!;
                        },
                        decoration: InputDecoration(
                          labelText: "Location ",
                          hintText: "Location",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(30)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<String>(
                            hint: Text("Select Category"),
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            value: value,
                            items: items.map(buildMenuItem).toList(),
                            onChanged: (value) => setState(() {
                              category = value!;
                            }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
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
                            if (_formkey.currentState!.validate()) {
                              _formkey.currentState!.save();
                              Photo photo = Photo(
                                  title: title,
                                  description: description,
                                  location: location,
                                  category: category);

                              HttpConnectPhoto().addPhotoPost(photo, _image!);
                              setState(() {
                                Navigator.pushNamed(context, '/viewpost');
                              });
                            } else {
                              Fluttertoast.showToast(
                                msg: "Upload failed. Try Again",
                                backgroundColor: Colors.red,
                              );
                            }
                          },
                          child: Text("Upload"))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
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

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(),
      ));
}
