import 'package:flutter/material.dart';

class MainProfilePage extends StatefulWidget {
  const MainProfilePage({super.key});

  @override
  State<MainProfilePage> createState() => _MainProfilePageState();
}

class _MainProfilePageState extends State<MainProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              Positioned(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor
                  ),
                  
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
