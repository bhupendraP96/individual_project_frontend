import 'package:flutter/material.dart';
import 'package:android_assignment/screens/viewpost.dart';
import 'dart:async';
import 'package:flutter/foundation.dart' as foundation;
import 'package:android_assignment/http/httpphoto.dart';
import 'package:android_assignment/model/photo.dart';

import 'package:proximity_sensor/proximity_sensor.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  bool _isNear = false;
  late StreamSubscription<dynamic> _streamSubscription;
  late Future<List<Photo>> allPosts;
  String url = 'http://192.168.0.106:90/';

  @override
  void initState() {
    super.initState();
    allPosts = HttpConnectPhoto().viewAllPhotoGet();
    listenSensor();
  }

  Future<void> listenSensor() async {
    FlutterError.onError = (FlutterErrorDetails details) {
      if (foundation.kDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      }
    };
    _streamSubscription = ProximitySensor.events.listen((int event) {
      setState(() {
        _isNear = (event > 0) ? true : false;
        if (_isNear) {
          Navigator.pushNamed(context, '/myprofile');
        }
      });
    });
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
                              uploaded: photo.uploaded,
                            ))),
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
      appBar: AppBar(
        title: Text("PhotoHub"),
        backgroundColor: Colors.grey[900],
        centerTitle: true,
      ),
      body: Container(
        color: Color.fromARGB(255, 0, 0, 0),
        child: FutureBuilder<List<Photo>>(
          future: allPosts,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
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
      ),
    );
  }
}
