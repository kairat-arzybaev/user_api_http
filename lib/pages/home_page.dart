import 'package:api_http/models/user_model.dart';
import 'package:api_http/services/user_service.dart';
import 'package:flutter/material.dart';

import 'details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<User>> futureUsers;

  openPage(context, User user) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => DetailsPage(
                  user: user,
                ))));
  }

  @override
  void initState() {
    super.initState();
    futureUsers = UserService().getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('People'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          var users = await UserService().getUser();
          setState(() {
            futureUsers = Future.value(users);
          });
        },
        child: Center(
          child: FutureBuilder<List<User>>(
            future: futureUsers,
            builder: ((context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                    itemBuilder: ((context, index) {
                      User user = snapshot.data?[index];
                      return ListTile(
                        title: Text(user.email),
                        subtitle: Text(user.name.first),
                        trailing: const Icon(Icons.chevron_right_outlined),
                        onTap: (() => {openPage(context, user)}),
                      );
                    }),
                    separatorBuilder: ((context, index) {
                      return const Divider(
                        color: Colors.black26,
                      );
                    }),
                    itemCount: snapshot.data!.length);
              } else if (snapshot.hasError) {
                return Text('Error: {$snapshot.error}');
              }

              return const CircularProgressIndicator();
            }),
          ),
        ),
      ),
    );
  }
}
