import 'package:flutter/material.dart';

import 'user_service.dart';

class Details extends StatelessWidget {
  final User user;
  const Details({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.name.first} ${user.name.last}'),
        backgroundColor: Colors.blue,
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
        ),
      ),
    );
  }
}
