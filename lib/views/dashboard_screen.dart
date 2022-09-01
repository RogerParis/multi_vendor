import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.logout,
              color: Colors.cyan,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 20,
          children: List.generate(6, (index) {
            return Card(
                elevation: 15,
                color: Colors.blueGrey.withOpacity(0.8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Icon(
                      Icons.store,
                      size: 40,
                      color: Colors.cyan,
                    ),
                    Text(
                      'My Store',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ));
          }),
        ),
      ),
    );
  }
}
