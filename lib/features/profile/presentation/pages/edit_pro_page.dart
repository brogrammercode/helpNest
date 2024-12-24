import 'package:flutter/material.dart';
import 'package:helpnest/core/utils/common_widgets.dart';

class EditProPage extends StatefulWidget {
  const EditProPage({super.key});

  @override
  State<EditProPage> createState() => _EditProPageState();
}

class _EditProPageState extends State<EditProPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          CustomTextFormField(labelText: "Name", controller: _name),
          CustomTextFormField(
              labelText: "Phone Number", controller: _phoneNumber),
          CustomTextFormField(labelText: "Address", controller: _address),
          CustomTextFormField(labelText: "Gender", controller: _gender),
        ],
      ),
    );
  }
}
