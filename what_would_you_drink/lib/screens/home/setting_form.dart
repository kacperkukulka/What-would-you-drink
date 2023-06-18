import 'package:flutter/material.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  int currentStrength = 400;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 60.0, top: 30.0),
      child: Form(
        child: Column(
          children: [
            Slider(
              value: 100, 
              min: 100,
              max: 800,
              divisions: 8,
              onChanged: (v){
                
              }
            )
          ],
        ),
      )
    );
  }
}