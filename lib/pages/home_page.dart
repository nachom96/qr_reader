import 'package:flutter/material.dart';
import 'package:qr_reader/widgets/custom_navigatorbar.dart';
import 'package:qr_reader/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Historial'),
        actions: [
          IconButton(
          onPressed: (){}, 
          icon: const Icon(Icons.delete_forever))
        ],
      ),
      body: const Center(
        child: Text('Home page'),
      ),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      // bottomNavigationBar: ,
    );
  }
}