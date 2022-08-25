import 'package:flutter/material.dart';
import 'package:android_assignment/http/httpphoto.dart';
import 'package:android_assignment/model/photo.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class UpdatePosts extends StatefulWidget {
  final String pid;
  const UpdatePosts({Key? key, required this.pid}) : super(key: key);

  @override
  State<UpdatePosts> createState() => _UpdatePostsState();
}

class _UpdatePostsState extends State<UpdatePosts> {
  final _formkey = GlobalKey<FormState>();
  late Future<Photo> photoData;
  final String url = 'http://192.168.0.106:90/';

  String title = '';
  String description = '';
  String location = '';
  String category = '';
  String imageName = '';
  late List likes;

  String? value;

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

  Future<bool> updatePost(Photo photo) {
    return HttpConnectPhoto().updateImagePut(photo);
  }

  @override
  void initState() {
    super.initState();
    photoData = HttpConnectPhoto().photoDataGet(widget.pid);
    photoData.then((pvalue) => setState(
          () {
            title = pvalue.title!;
            description = pvalue.description!;
            location = pvalue.location!;
            imageName = pvalue.imageName!;
            category = pvalue.category!;
          },
        ));

    //title = photoData['title'];
  }

  final ctitle = TextEditingController();
  final cdescription = TextEditingController();
  final clocation = TextEditingController();
  final ccategory = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Post"),
        backgroundColor: Colors.grey[900],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              LimitedBox(
                maxWidth: double.infinity,
                child: Container(
                  color: Color.fromARGB(255, 31, 31, 31),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: Image.network(url + imageName),
                ),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(10, 25, 10, 15),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: ctitle..text = title,
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
                        controller: cdescription..text = description,
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
                        controller: clocation..text = location,
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
                              //   hint: Text(category),
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              value: category,
                              items: items.map(buildMenuItem).toList(),
                              onChanged: (value) => category = value!),
                        ),
                      ),
                    ],
                  )),
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
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();
                    try {
                      Photo p = Photo(
                          id: widget.pid,
                          title: title,
                          description: description,
                          location: location,
                          category: category);
                      bool res = await updatePost(p);
                      if (res) {
                        Fluttertoast.showToast(
                          msg: "Your post has been updated",
                          backgroundColor: Colors.green,
                        );
                        setState(() {
                          Navigator.popAndPushNamed(context, '/homepage');
                        });
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
                child: Text("Update Post"),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton.icon(
                icon: Icon(Icons.delete_outline),
                label: Text("Delete Post"),
                style: TextButton.styleFrom(
                  primary: Color.fromARGB(255, 223, 39, 26),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23),
                  ),
                ),
                onPressed: () {
                  showPopUp(context);
                },
              )
            ],
          ),
        ),
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
                    'Are you sure to delete this post?',
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
                            bool res =
                                await HttpConnectPhoto().deletePost(widget.pid);
                            if (res) {
                              Fluttertoast.showToast(
                                msg: "Post Deleted",
                                backgroundColor: Colors.green,
                              );
                              Navigator.popAndPushNamed(context, '/homepage');
                            } else {
                              Fluttertoast.showToast(
                                msg: "Failed to delete post.",
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

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(),
      ));
}
