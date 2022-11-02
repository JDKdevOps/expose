import 'package:expose_master/backend/classes/comments.dart';
import 'package:expose_master/backend/providers/dash_provider.dart';
import 'package:expose_master/backend/services/js_alert.dart';
import 'package:expose_master/backend/services/system.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentSection extends StatelessWidget {
  final Comments comment;

  const CommentSection({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);

    return Card(
      margin: const EdgeInsets.all(15),
      color: const Color(0xffF6F6F6),
      elevation: 5,
      child: ListTile(
        leading: Image.network(
            "https://ui-avatars.com/api/?rounded=true&name=${comment.name}"),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              comment.name!,
              style: const TextStyle(
                fontFamily: "MontserratAlternates",
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              comment.content!,
              style: const TextStyle(
                fontFamily: "MontserratAlternates",
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            comment.timestamp.toString(),
            style: const TextStyle(
                fontFamily: "MontserratAlternates", fontSize: 15),
          ),
        ),
        trailing: SystemData.userData!.tipTipoUsuario == "Coordinador" ||
                SystemData.userData!.tipTipoUsuario == "administrador"
            ? IconButton(
                onPressed: () {
                  dash.removeComment(comment.id!).then(
                    (_) {
                      jsAlert("El comentario ha sido removido exitosamente");
                    },
                  );
                },
                icon: Icon(
                  Icons.remove_circle_outline,
                  color: Colors.red[300],
                ),
              )
            : null,
      ),
    );
  }
}
