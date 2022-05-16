import 'package:diplom_work/Screens/CreateUser.dart';
import 'package:diplom_work/Screens/UserPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: ListView.separated(
        itemCount: 15,
        // physics: NeverScrollableScrollPhysics(),
        // addAutomaticKeepAlives: false,
        // cacheExtent: 100,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/26.jpg'),
            ),
            title: Text('Иванова Мария Сергеевна'),
            subtitle: Text('Отдел маркетинга'),
            trailing: Icon(Icons.edit),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const UserPage()));
            },
            selected: true,
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateUser()),
          );
        },
      ),
    );
  }
}
