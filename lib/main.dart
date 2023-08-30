import 'package:flutter/material.dart';
import 'package:responsive_tut/tablet.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Chats> chats = [
    Chats(ava_photo: "anwar.jpg", nickName: "Anwar"),
    Chats(ava_photo: "ava.png", nickName: "adam_w")
  ];

   chatSelected(int currentIndex) {
    //  ListView.builder(
    //   itemBuilder: (context, index) {
    //  return Row(
    //    children: [
    //      ClipOval(
    //        child: SizedBox.fromSize(
    //          size: Size.fromRadius(30), // Image radius
    //          child: Image.asset(chats[currentIndex].ava_photo,
    //              fit: BoxFit.cover),
    //        ),
    //      ),
    //      Text(chats[currentIndex].nickName)
    //    ],
    //  );
    //   },
    //   itemCount: 1,
    // );
     Text("ok");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints boxConstraints) {
          if (boxConstraints.maxWidth > 500) {
            return Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: ClipOval(
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(30), // Image radius
                            child: Image.asset(chats[index].ava_photo,
                                fit: BoxFit.cover),
                          ),
                        ),
                        title: Text(chats[index].nickName),
                        onLongPress: chatSelected(index),
                      );
                    },
                    itemCount: chats.length,
                  ),
                ),
              ],
            );
          } else {
            return Container(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: ClipOval(
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(30), // Image radius
                        child: Image.asset(chats[index].ava_photo,
                            fit: BoxFit.cover),
                      ),
                    ),
                    title: Text(chats[index].nickName),
                  );
                },
                itemCount: chats.length,
              ),
            );
          }
        },
      ),
    );
  }
}
