import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:android_assignment/http/httpphoto.dart';
import 'package:android_assignment/http/httpuser.dart';
import 'package:android_assignment/model/photo.dart';
import 'package:android_assignment/screens/updateprofile.dart';
import 'package:android_assignment/screens/viewpost.dart';
import 'package:android_assignment/model/user.dart';
import 'package:android_assignment/main.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({Key? key}) : super(key: key);

  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  late Future<List<Photo>> userPhotos;
  String url = 'http://192.168.0.106:90/';
  List<double>? _accelerometerValues;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  String? uid;
  String? username = '';
  String? fullName = '';
  String? eMail = '';
  String? phoneNo = '';
  List? followers;
  List? following;
  int? followersCount = 0;
  int? followingCount = 0;
  String? userImage = '';

  String tuid = HttpConnectUser.uid;

  @override
  void initState() {
    super.initState();
    Future<User> userData = HttpConnectUser().myProfileGet();

    userData.then((value) => {
          setState(() {
            uid = value.id;
            username = value.username;
            fullName = value.fullName;
            eMail = value.eMail;
            phoneNo = value.phoneNo;
            followers = value.followers;
            following = value.following;
            // followersCount = value.followers!.length;
            userImage = value.userImage;
          })
        });

    userPhotos = HttpConnectPhoto().usersPostsGet(tuid);

    _streamSubscriptions.add(
      accelerometerEvents.listen(
        (AccelerometerEvent event) {
          setState(() {
            _accelerometerValues = <double>[event.x, event.y, event.z];
            if (event.x > 9) {
              notify();
              Navigator.popAndPushNamed(context, '/');
            }
          });
        },
      ),
    );
  }

  Widget postCard(Photo photo) {
    return Card(
      color: Colors.black,
      child: Column(
        children: [
          LimitedBox(
            maxHeight: 500,
            child: InkWell(
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ViewPost(
                            pid: photo.id,
                            userId: photo.userId,
                            owner: photo.owner,
                            title: photo.title,
                            description: photo.description,
                            location: photo.location,
                            category: photo.category,
                            imageName: photo.imageName,
                            likes: photo.likes,
                            uploaded: photo.uploaded))),
              },
              child: Image.network(
                url + photo.imageName!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Row(
            children: [
              Text(photo.title!, style: TextStyle(color: Colors.white)),
              IconButton(
                alignment: Alignment.bottomRight,
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_outline_rounded,
                  color: Colors.white,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/');
            },
            icon: Icon(Icons.logout)),
        title: Text("My Profile"),
        backgroundColor: Colors.grey[900],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
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
                      backgroundImage: userImage == '' || userImage == null
                          ? AssetImage('images/avatar.png') as ImageProvider
                          : NetworkImage(url + userImage!),
                      radius: 65,
                    ),
                  ),
                  Positioned(
                    top: 83,
                    right: 0,
                    child: TextButton.icon(
                      onLongPress: () => Navigator.pushNamed(context, '/'),
                      icon: Icon(Icons.edit,
                          color: Color.fromARGB(255, 241, 241, 241)),
                      label: Text("Edit",
                          style: TextStyle(
                              color: Color.fromARGB(255, 241, 241, 241),
                              fontSize: 15)),
                      style: TextButton.styleFrom(
                        // backgroundColor: Colors.grey[900],
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => EditProfile(
                                      uId: uid,
                                      username: username,
                                      fullName: fullName,
                                      eMail: eMail,
                                      phoneNo: phoneNo,
                                      userImage: userImage,
                                    )));
                      },
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 85,
                  ),
                  Text(
                    fullName!,
                    style: TextStyle(
                        color: Color.fromARGB(255, 236, 236, 236),
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "@ $username",
                    style: TextStyle(
                      color: Color.fromARGB(255, 207, 207, 207),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "$followersCount Followers     $followingCount Following",
                    style: TextStyle(
                        color: Color.fromARGB(255, 216, 216, 216),
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    WidgetSpan(
                        child: Icon(
                      Icons.email_outlined,
                      color: Color.fromARGB(255, 207, 207, 207),
                    )),
                    TextSpan(
                        text: "   $eMail",
                        style: TextStyle(
                            color: Color.fromARGB(255, 207, 207, 207)))
                  ])),
                  Divider(
                    color: Colors.white,
                    height: 40,
                  )
                ],
              ),
              FutureBuilder<List<Photo>>(
                future: userPhotos,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      //   primary: true,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return postCard(snapshot.data![index]);
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
