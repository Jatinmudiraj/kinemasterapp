import 'package:flutter/material.dart';
import 'package:kindmaster/components/colors.dart';
import 'package:kindmaster/screens/CreateProject.dart';
import 'package:kindmaster/screens/Me.dart';
import 'package:kindmaster/widgets/ProjectWidgets.dart';

import '../dummy/dummyProject.dart';

class Create extends StatefulWidget {
  const Create({key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  List<DummyProjects> dummyP = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateProject()));

                        // setState(() {
                        //   dummyP.add(
                        //   DummyProjects(
                        //       title: "Title1",
                        //       image: "assets/img.jpg",
                        //       subtitle: 'Subtitle1'),
                        // );
                        // });
                      },
                      child: ProjectWidget()),
                  Expanded(
                      child: ListView.builder(
                          itemCount: dummyP.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                shadowColor: Colors.white,
                                color: bgcolor,
                                child: ListTile(
                                  leading: Image(
                                      image: AssetImage(dummyP[index].image)),
                                  trailing: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      )),
                                  title: Text(
                                    dummyP[index].title,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    'Last seen:' + dummyP[index].subtitle,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            );
                          })),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
