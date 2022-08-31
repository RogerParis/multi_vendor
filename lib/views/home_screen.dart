import 'package:flutter/material.dart';
import 'package:multi_vendor/views/inner_screens/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: InkWell(
            onTap: (() {
              Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
                return const SearchScreen();
              })));
            }),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.6,
                  color: Colors.cyan,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 30,
                  ),
                  const Text(
                    'What are you looking for',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                  Container(
                    height: 33,
                    width: 74,
                    decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Center(
                      child: Text(
                        'Search',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          bottom: const TabBar(tabs: [
            RepeatedTab(
              title: 'Men',
            ),
            RepeatedTab(
              title: 'Women',
            ),
            RepeatedTab(
              title: 'Kids',
            ),
            RepeatedTab(
              title: 'Shoes',
            ),
          ]),
        ),
        body: const TabBarView(
          children: [
            Center(
              child: Text('Men Category'),
            ),
            Center(
              child: Text('Women Category'),
            ),
            Center(
              child: Text('Kids Category'),
            ),
            Center(
              child: Text('Shoes Category'),
            ),
          ],
        ),
      ),
    );
  }
}

class RepeatedTab extends StatelessWidget {
  final String title;
  const RepeatedTab({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }
}
