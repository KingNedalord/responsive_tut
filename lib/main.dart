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
  List<String> names = ["Baxodir", "Samandar", "Baxtiyor"];
  int index = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.3 - 3,
            height: MediaQuery.of(context).size.height,
            child: Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider(
                    thickness: 0.5,
                    height: 5,
                  );
                },
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        this.index = index;
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      color: Colors.blue,
                      child: Text(names[index]),
                    ),
                  );
                },
                itemCount: names.length,
              ),
            ),
          ),
          VerticalDivider(
            width: 3,
            thickness: 0.5,
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.7 - 3,
            height: MediaQuery.of(context).size.height,
            child: Text(
            index < 0 ? "Select a chat to start messaging" : names[index]),
          )
        ],
      ),
    );
  }
}
