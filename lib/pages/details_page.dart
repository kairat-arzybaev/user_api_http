import 'package:api_http/models/user_model.dart';

import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final User user;

  const DetailsPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  goBack(context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.name.first} ${user.name.last}'),
        backgroundColor: Colors.amberAccent,
      ),
      body: Center(
          child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Image.network(user.picture),
          const SizedBox(
            height: 30,
          ),
          Text(user.email),
        ],
      )),
    );
  }
}
