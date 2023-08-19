import 'package:flutter/material.dart';
import 'package:kindmaster/components/colors.dart';
import 'package:kindmaster/dummy/DummySearchGrid.dart';
import 'package:kindmaster/dummy/dummyCategories.dart';

class Search extends StatefulWidget {
  const Search({key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<DummyCategories> categories = [
    DummyCategories(categoryName: 'All'),
    DummyCategories(categoryName: 'Marketing'),
    DummyCategories(categoryName: 'Corporate'),
    DummyCategories(categoryName: 'Celebrations'),
    DummyCategories(categoryName: 'Festival/Holidays'),
    DummyCategories(categoryName: 'Social Media'),
    DummyCategories(categoryName: 'Vlog'),
    DummyCategories(categoryName: 'Review'),
    DummyCategories(categoryName: 'Tutorial'),
  ];

  List<DummySearch> mySearch = [
    DummySearch(
      image: 'https://i.pinimg.com/originals/21/f9/8b/21f98bb955af7b9e9f34fc8aba6c2aa1.jpg',
      likes: '10k',
      downloads: '500'
    ),
    DummySearch(
      image: 'https://st2.depositphotos.com/2001755/8564/i/450/depositphotos_85647140-stock-photo-beautiful-landscape-with-birds.jpg',
      likes: '1k',
      downloads: '5'
    ),
    DummySearch(
      image: 'https://cdn.pixabay.com/photo/2015/04/19/08/32/rose-729509__340.jpg',
      likes: '11k',
      downloads: '50'
    ),
    
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 52,
              decoration: const BoxDecoration(),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: 'Search for the project',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  fillColor: ShadowColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: ListView.builder(
                    itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton.extended(
                            backgroundColor: ShadowColor,
                            onPressed: () {},
                            label: Text(categories[index].categoryName)),
                      );
                    }))),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: mySearch.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15.0,
                  ),
                  itemBuilder: ((context, index) {
                    return Container(
                      width: 200,
                      height: 600,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  mySearch[index].image),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(25)),
                      child: Stack(children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                              gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                Colors.transparent,
                                Colors.black,
                              ])),
                        ),
                        Positioned(
                            top: 0,
                            bottom: -130,
                            left: 13,
                            right: 0,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.download,
                                  color: Colors.white,
                                ),
                                Text(
                                  mySearch[index].downloads,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                ),
                                Text(
                                  mySearch[index].likes,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ))
                      ]),
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
