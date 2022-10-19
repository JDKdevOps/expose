import 'package:expose/backend/providers/system.dart';
import 'package:flutter/material.dart';

class GroupsView extends StatelessWidget {
  const GroupsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Row(
        children: [
          SizedBox(
            width: 200,
            child: SingleChildScrollView(
              child: FutureBuilder(
                builder: (context, snapshot) {
                  return Text("xd");
                },
              ),
            ),
          ),
          Divider(
            color: Colors.black,
            height: double.infinity,
          )
        ],
      ),
    );
  }
}
