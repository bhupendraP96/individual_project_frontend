import 'package:android_assignment/http/httpphoto.dart';
import 'package:android_assignment/http/httpuser.dart';
import 'package:android_assignment/screens/updateposts.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ViewPost extends StatefulWidget {
  final String? pid;
  final String? userId;
  final String? owner;
  final String? title;
  final String? description;
  final String? location;
  final String? category;
  final String? imageName;
  final List? likes;
  final String? uploaded;
  const ViewPost(
      {Key? key,
      required this.pid,
      this.userId,
      this.owner,
      this.title,
      this.description,
      this.location,
      this.category,
      this.likes,
      this.uploaded,
      required this.imageName})
      : super(key: key);

  @override
  State<ViewPost> createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  String url = 'http://192.168.0.106:90/';
  String uid = HttpConnectUser.uid;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      widget.title;
      if (widget.likes!.contains(uid)) {
        isLiked = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        title: Text(widget.title!),
        backgroundColor: Colors.grey[900],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            LimitedBox(
              maxWidth: double.infinity,
              child: Container(
                color: Color.fromARGB(255, 31, 31, 31),
                padding: EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                child: Image.network(url + widget.imageName!),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(3, 10, 3, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 1, color: Colors.white),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        splashRadius: 25,
                        onPressed: () async {
                          var res = await HttpConnectPhoto()
                              .likePhoto(widget.pid!, uid);
                          if (res) {
                            setState(() {
                              isLiked = true;
                            });
                          } else {
                            setState(() {
                              isLiked = false;
                            });
                          }
                        },
                        icon: isLiked
                            ? Icon(
                                Icons.favorite_rounded,
                                size: 33,
                                color: Colors.red,
                              )
                            : Icon(
                                Icons.favorite_outline_rounded,
                                size: 33,
                                color: Colors.white,
                              ),
                      ),
                      IconButton(
                        splashRadius: 25,
                        onPressed: () {},
                        icon: Icon(
                          Icons.mode_comment_outlined,
                          size: 26,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        splashRadius: 25,
                        onPressed: () {},
                        icon: Icon(
                          Icons.share_outlined,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      uid == widget.userId
                          ? Expanded(
                              child: IconButton(
                                  splashRadius: 25,
                                  padding: EdgeInsets.only(right: 15),
                                  alignment: Alignment.centerRight,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                UpdatePosts(pid: widget.pid!)));
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  )),
                            )
                          : Text(""),
                    ],
                  ),
                  Divider(
                    color: Colors.white,
                    indent: 13,
                    endIndent: 13,
                  ),
                  Text(
                    widget.title!,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      children: [
                        TextSpan(text: "Uploaded by :  "),
                        TextSpan(
                            text: widget.owner,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, '/');
                              }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.location_pin,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: widget.location,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                        TextSpan(text: "       Uploaded : "),
                        TextSpan(
                          text: widget.uploaded,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: 25,
                    color: Colors.white,
                    indent: 13,
                    endIndent: 13,
                  ),
                  RichText(
                      text: TextSpan(
                    children: [
                      TextSpan(text: "Description :  "),
                      TextSpan(
                          text: widget.description,
                          style: TextStyle(color: Colors.white)),
                    ],
                  )),
                  Divider(
                    height: 25,
                    color: Colors.white,
                    indent: 13,
                    endIndent: 13,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: "Category :  "),
                        TextSpan(
                            text: widget.category,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(3, 10, 3, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 1, color: Colors.white),
              ),
              child: Column(
                children: [
                  Text(
                    "Comments",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    height: 25,
                    color: Colors.white,
                    indent: 13,
                    endIndent: 13,
                    thickness: 2,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
