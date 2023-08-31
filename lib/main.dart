import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_tut/profile.dart';

import 'chat.dart';

late Box box;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<Chats>(ChatsAdapter());
  box = await Hive.openBox<Chats>("messages");
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Chats> chats = [
    Chats(ava_photo: "", nickName: "", message: []),
    Chats(ava_photo: "assets/ava.png", nickName: "adam_w", message: []),
    Chats(ava_photo: "assets/anwar.jpg", nickName: "anwar", message: []),
  ];
  int index = 0;
  TextEditingController msg = TextEditingController();

  @override
  void initState() {
    super.initState();
    box.addAll(chats);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, value, child) => LayoutBuilder(
          builder: (context, constraints) {
            return Scaffold(
                body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Row(
                children: [
                  Container(
                    width: constraints.maxWidth > 600
                        ? MediaQuery.of(context).size.width * 0.3 - 3
                        : MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        itemBuilder: (context, index) => index == 0
                            ? SizedBox(
                                width: 0,
                                height: 0,
                              )
                            : ListTile(
                                title: Text(
                                  box.getAt(index).nickName,
                                  style: TextStyle(color: Colors.white),
                                ),
                                tileColor: box.getAt(index).isSelected == false
                                    ? Color(0xFF003554)
                                    : Colors.blue[700],
                                onTap: () {
                                  setState(() {
                                    this.index = index;
                                    for (var row in box.values) {
                                      row.isSelected = false;
                                    }
                                    if (constraints.maxWidth > 600) {
                                      box.getAt(index)!.isSelected = true;
                                    }
                                    if (constraints.maxWidth < 600) {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  Chat(index: this.index)));
                                    }
                                  });
                                },
                                subtitle: Text(
                                  box.getAt(index).message.isEmpty
                                      ? ""
                                      : box.getAt(index).message.last,
                                  style: TextStyle(color: Colors.grey),
                                ),
                                leading: ClipOval(
                                  child: SizedBox.fromSize(
                                    size: Size.fromRadius(25), // Image radius
                                    child: Image.asset(
                                        box.getAt(index).ava_photo,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                        itemCount: box.length),
                  ),
                  VerticalDivider(
                    width: constraints.maxWidth > 600 ? 3 : 0,
                  ),
                  Container(
                      width: constraints.maxWidth > 600
                          ? MediaQuery.of(context).size.width * 0.7 - 3
                          : 0,
                      height: constraints.maxWidth > 600
                          ? MediaQuery.of(context).size.height
                          : 0,
                      color: Color(0xFF006494),
                      child: index == 0
                          ? Center(
                              child: Text(
                                "Select a chat to start messaging",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : Scaffold(
                              appBar: AppBar(
                                title: Text(box.getAt(index).nickName),
                                backgroundColor: Color(0xFF003554),
                                actions: [
                                  Icon(Icons.search_outlined),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(Icons.call),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Transform.rotate(
                                      angle: 110,
                                      child: Icon(
                                          Icons.auto_awesome_mosaic_outlined)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(Icons.more_vert),
                                  SizedBox(
                                    width: 10,
                                  )
                                ],
                              ),
                              body: Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.7 - 3,
                                height: MediaQuery.of(context).size.height,
                                child: Column(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                                  0.9 -
                                              56,
                                      child: ListView.builder(
                                        itemCount:
                                            box.getAt(index)!.message.length,
                                        itemBuilder: (context, index) => Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors
                                                          .lightBlue[700]),
                                                  padding: EdgeInsets.all(8),
                                                  margin: EdgeInsets.all(8),
                                                  child: Text(box
                                                      .getAt(this.index)!
                                                      .message[index]),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04,
                                              child:
                                                  Icon(Icons.upload_rounded)),
                                          Expanded(
                                            child: Container(
                                              child: TextField(
                                                controller: msg,
                                                decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintText:
                                                        "Write a message... ",
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey)),
                                              ),
                                            ),
                                          ),
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04,
                                              child: Icon(
                                                  Icons.add_reaction_outlined)),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04,
                                            child: IconButton(
                                              icon: Icon(Icons.send),
                                              onPressed: () {
                                                setState(() {
                                                  box
                                                      .getAt(index)
                                                      .message
                                                      .add(msg.value.text);
                                                  msg.text = "";
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ))
                ],
              ),
            ));


          },
        ),
      ),
    );
  }
}
