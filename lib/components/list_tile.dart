import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  const MyListTile({super.key,required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 20,right: 20,bottom: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.secondary
        ),
        child: ListTile(
          tileColor: Colors.white,
          title: Text(title),
          subtitle: Text(subTitle,style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
        ),
      ),
    );
  }
}
