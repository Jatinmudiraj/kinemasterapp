import 'package:flutter/material.dart';
import 'package:kindmaster/components/colors.dart';
import 'package:kindmaster/screens/editScreen.dart';
import 'package:kindmaster/screens/video_picker_screen.dart';

class CreateProject extends StatefulWidget {
  const CreateProject({key});

  @override
  State<CreateProject> createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  TextEditingController projectName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: bgcolor,
        // title: Text("New Project"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: FloatingActionButton.extended(
                backgroundColor: bgcolor,
                onPressed: () {},
                label: Row(
                  children: const [
                    Icon(Icons.move_to_inbox_sharp),
                    Text("Import")
                  ],
                )),
          )
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Text(
                          "Project Name",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: TextField(
                          controller: projectName,
                          decoration: const InputDecoration(
                            hintText: "Enter Project Name",
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32))),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32))),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Text(
                          "Aspect ratio",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      Wrap(
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              child: InkWell(
                                onTap: () {},
                                child: CircleAvatar(
                                  backgroundColor: Colors.black26,
                                  radius: 50,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.airplay_rounded),
                                      Text("16:9")
                                    ],
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: FloatingActionButton.extended(
                  backgroundColor: ButtonColor,
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VideoEditorExample()));
                  },
                  heroTag: const Text("Create"),
                  label: const Text(
                    "Create",
                    style: TextStyle(fontSize: 20),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
