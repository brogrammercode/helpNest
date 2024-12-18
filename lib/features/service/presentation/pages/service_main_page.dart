import 'package:flutter/material.dart';

class ServiceMainPage extends StatefulWidget {
  const ServiceMainPage({super.key});

  @override
  State<ServiceMainPage> createState() => _ServiceMainPageState();
}

class _ServiceMainPageState extends State<ServiceMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Services",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
