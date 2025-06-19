import 'package:flutter/material.dart';
import 'package:tugas_tigasbelas_flutter/pertemuan_22/api/http_resep.dart';
import 'package:tugas_tigasbelas_flutter/pertemuan_22/model/model_user.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            FutureBuilder(
              future: getUsers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  final users = snapshot.data;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: users?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      final user = users?[index];
                      return ListTile(
                        title: Text("${user?.firstName} ${user?.lastName}"),
                        subtitle: Text(user?.email ?? ''),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user?.avatar ?? ''),
                        ),
                      );
                    },
                  );
                } else {
                  return Text("Error: ${snapshot.error}");
                }
              },
            ),
          
        ],
      ),
    );
  }
}
