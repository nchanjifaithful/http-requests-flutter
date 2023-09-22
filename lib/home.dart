import 'package:flutter/material.dart';

import 'details.dart';
import 'user_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<User>> futureUsers;

  @override
  void initState() {
    // TODO: implement initState
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
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                      itemBuilder: ((context, index) {
                        User user = snapshot.data[index];
                        return ListTile(
                          title: Text(user.email),
                          subtitle: Text(user.name.first),
                          trailing: const Icon(Icons.chevron_right_outlined),
                          onTap: (() => {openPage(context, user)}),
                        );
                      }),
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: Colors.black,
                        );
                      },
                      itemCount: snapshot.data.length);
                } else if (snapshot.hasError) {
                  return Text('ERROR ${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ));
  }

  openPage(context, User user) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Details(user: user)));
  }
}
