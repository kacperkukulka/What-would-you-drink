import 'package:flutter/material.dart';
import 'package:what_would_you_drink/models/light_user.dart';
import 'package:what_would_you_drink/services/roomService.dart';
import 'package:what_would_you_drink/shared/constants.dart';
import 'package:provider/provider.dart';

import '../room/room_widget.dart';

class AddRoom extends StatefulWidget {
  const AddRoom({super.key});

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String? currentName;
    
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 40.0, top: 20.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            textForm(text: 'Nazwa pokoju'),
            TextFormField(
              initialValue: "",
              decoration: textInputDecoration,
              validator: (val) =>  val!.isEmpty ? 'Please enter a name' : null,
              onChanged: (val) => currentName = val,
            ),
            const SizedBox(height: 10.0,),
            ElevatedButton(
              onPressed: () async {
                if(formKey.currentState == null) return;
                if(formKey.currentState!.validate()){
                  Navigator.pop(context);
                  RoomService().addRoom(
                    name: currentName!,
                    userId: Provider.of<LightUser?>(context, listen: false)!.uid
                  ).then((value){
                    RoomService(uid: value).addIfNotExist(Provider.of<LightUser?>(context, listen: false)!.uid);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (ctx) => RoomWidget(uid: value, roomName: currentName!))
                    );
                  });
                }
              }, 
              child: const Text('Zapisz')
            ),
          ],
        ),
      )
    );
  }
}