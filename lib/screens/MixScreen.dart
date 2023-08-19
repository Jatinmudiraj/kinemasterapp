import 'package:flutter/material.dart';
import 'package:kindmaster/components/colors.dart';
import 'package:kindmaster/dummy/dummyVideoScroll.dart';

class MixScreen extends StatefulWidget {
  const MixScreen({key});

  @override
  State<MixScreen> createState() => _MixScreenState();
}

class _MixScreenState extends State<MixScreen> {
  PageController controller = PageController(initialPage: 0);
  List<DummyVideo> myvideo = [
    DummyVideo(
      image: 'assets/bg.jpeg',
      title: '#Inksoft Original',
      likes: '250',
      duration: '01:30',
      shares: '500',
      message: '805',
      ratio: '2:2',
      ),
      DummyVideo(
      image: 'assets/bg.jpeg',
      title: ' Original',
      likes: '250',
      duration: '01:30',
      shares: '500',
      message: '805',
      ratio: '2:2',
      ),
      DummyVideo(
      image: 'assets/bg.jpeg',
      title: '#InkOriginal',
      likes: '250',
      duration: '01:30',
      shares: '500',
      message: '805',
      ratio: '2:2',
      ),
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgcolor,
        body: PageView.builder(
            scrollDirection: Axis.vertical,
            controller: controller,
            itemCount: myvideo.length,
            itemBuilder: (BuildContext context, int itemIndex) {
              return Container(
                decoration: BoxDecoration(
                    color: Colors.red,
                    image: DecorationImage(
                        image: AssetImage(myvideo[itemIndex].image),
                        fit: BoxFit.cover)),
                width: double.infinity,
                height: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 28),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                  size: 50,
                                )),
                             Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                myvideo[itemIndex].likes,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 28),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.message,
                                  color: Colors.white,
                                  size: 50,
                                )),
                             Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                myvideo[itemIndex].message,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 28),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.share,
                                  color: Colors.white,
                                  size: 50,
                                )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                myvideo[itemIndex].shares,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  myvideo[itemIndex].title,
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal: 8),
                              //   child: Text("More",style: TextStyle(fontSize: 15,color: Colors.white),),
                              // ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.lock_clock,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                myvideo[itemIndex].duration,
                                style: const TextStyle(color: Colors.white),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.rectangle,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                myvideo[itemIndex].ratio,
                                style: const TextStyle(color: Colors.white),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${myvideo[itemIndex].shares} Downloads",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                width: 35,
                              ),
                              Container(
                                width: 80,
                                child: FloatingActionButton.extended(
                                  backgroundColor:
                                      const Color.fromARGB(250, 253, 77, 61),
                                  onPressed: () {},
                                  label: const Text("USE"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ]),
              );
            }));
  }
}
