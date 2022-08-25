import 'package:flutter/material.dart';
import 'package:android_assignment/database/database_instance.dart';
import 'package:android_assignment/entity/user.dart';

class ViewData extends StatefulWidget {
  const ViewData({Key? key}) : super(key: key);

  @override
  _ViewDataState createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  Future<List<FUser>> displayData() async {
    final database = await DatabaseInstance.instance.getDatabaseInstance();
    final result = database.userDao.findAllUsers();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<FUser>>(
        future: displayData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.person),
                  title: Text('ID: ${snapshot.data![index].id}'),
                  subtitle: Text('Name: ${snapshot.data![index].fullName}'),
                );
              },
              itemCount: snapshot.data!.length,
            );
          } else if (snapshot.hasError) {
            return Text(
              '${snapshot.error}',
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
