import 'package:flutter/material.dart';
import 'package:tugas_tigasbelas_flutter/tugas_empatbelas/api/api_postusers.dart';
import 'package:tugas_tigasbelas_flutter/tugas_empatbelas/aplikasi/detail_postuser.dart';
import 'package:tugas_tigasbelas_flutter/tugas_empatbelas/model/model_postusers.dart';

class ListScreenPostusers extends StatefulWidget {
  const ListScreenPostusers({super.key});

  @override
  State<ListScreenPostusers> createState() => _ListScreenPostusersState();
}

class _ListScreenPostusersState extends State<ListScreenPostusers> {
  late Future<List<PostUser>> _futurePosts;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _futurePosts = getUsers();
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: TextField(
        decoration: const InputDecoration(
          hintText: 'Cari judul...',
          hintStyle: TextStyle(color: Colors.white),
          border: InputBorder.none,
          icon: Icon(Icons.search, color: Colors.white),
        ),
        style: const TextStyle(color: Colors.white),
        onChanged: (value) {
          setState(() {
            searchQuery = value;
          });
        },
      ),
      backgroundColor: Color(0xffEA2F14),
    ),
    backgroundColor: Colors.white,
    body: FutureBuilder<List<PostUser>>(
      future: _futurePosts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final posts = snapshot.data!;
          final Map<int, List<PostUser>> postsByUser = {};
          for (var post in posts) {
            final userId = post.userId;
            if (userId == null) continue;

            if (!postsByUser.containsKey(userId)) {
              postsByUser[userId] = [];
            }
            postsByUser[userId]!.add(post);
          }

          final Map<int, List<PostUser>> filteredPostByUser = {};
          postsByUser.forEach((userId, postList) {
            final filteredList = postList.where((post) {
              final title = post.title ?? '';
              return title.toLowerCase().contains(searchQuery.toLowerCase());
            }).toList();

            if (filteredList.isNotEmpty) {
              filteredPostByUser[userId] = filteredList;
            }
          });

          final filteredUserIds = filteredPostByUser.keys.toList();

          return ListView.builder(
            itemCount: filteredUserIds.length,
            itemBuilder: (context, index) {
              final userId = filteredUserIds[index];
              final userPosts = filteredPostByUser[userId]!;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Card(
                  color: Color(0xffFFDEDE),
                  elevation: 2,
                  child: ExpansionTile(
                    title: Text('User ID : $userId'),
                    children: userPosts.map((post) {
                      return ListTile(
                        title: Text('Post ID: ${post.id}'),
                        subtitle: Text(post.title ?? ''),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPostuser(post: post),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(child: Text("Tidak ada data ditemukan"));
        }
      },
    ),
  );
}
}