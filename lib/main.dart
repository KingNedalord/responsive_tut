import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_tut/profile.dart';

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
    // TODO: implement initState
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
            if (constraints.maxWidth > 500) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3 - 3,
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
                                  tileColor:
                                      box.getAt(index).isSelected == false
                                          ? Color(0xFF1b263b)
                                          : Colors.blue[700],
                                  onTap: () {
                                    setState(() {
                                      this.index = index;
                                      for (var row in box.values) {
                                        row.isSelected = false;
                                      }
                                      box.getAt(index)!.isSelected = true;
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
                      width: 3,
                      thickness: 0.5,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.7 - 3,
                        height: MediaQuery.of(context).size.height,
                        color: Color(0xFF0d1b2a),
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
                                  backgroundColor: Color(0xFF1b263b),
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
                                        child: Icon(Icons
                                            .auto_awesome_mosaic_outlined)),
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
                                      MediaQuery.of(context).size.width * 0.7 -
                                          3,
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
                                          itemBuilder: (context, index) =>
                                              Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color:
                                                        Colors.lightBlue[700]),
                                                padding: EdgeInsets.all(8),
                                                margin: EdgeInsets.all(8),
                                                child: Text(box
                                                    .getAt(this.index)!
                                                    .message[index]),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.04 -
                                                    6,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.1,
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
                                                        0.04 -
                                                    6,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.1,
                                                child: Icon(Icons
                                                    .add_reaction_outlined)),
                                            Container(
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.04 -
                                                  6,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
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
              );
            } else {
              return Container(
                color: Colors.blue,
              );
            }
          },
        ),
      ),
    );
  }
}
