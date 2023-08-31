import 'package:flutter/material.dart';

import 'main.dart';

class Chat extends StatefulWidget {
  final int index;
  const Chat({super.key,required this.index});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  TextEditingController msg = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(box.getAt(widget.index).nickName),
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
              angle: 110, child: Icon(Icons.auto_awesome_mosaic_outlined)),
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
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.9 - 56,
              child: ListView.builder(
                itemBuilder: (context, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.lightBlue[700]),
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.all(8),
                          child: Text(box.getAt(widget.index).message[index]),
                        )
                      ],
                    ),
                  ],
                ),
                itemCount: box.getAt(widget.index)!.message.length,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.04,
                      child: Icon(Icons.upload_rounded)),
                  Expanded(
                    child: Container(
                      child: TextField(
                        controller: msg,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Write a message... ",
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.04,
                      child: Icon(Icons.add_reaction_outlined)),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.04,
                    child: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        setState(() {
                          box.getAt(widget.index).message.add(msg.value.text);
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
    );
  }
}
