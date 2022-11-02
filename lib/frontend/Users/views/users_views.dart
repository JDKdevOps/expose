import 'package:expose_master/backend/classes/users.dart';
import 'package:expose_master/backend/providers/users_providers.dart';
import 'package:expose_master/backend/services/js_alert.dart';
import 'package:expose_master/frontend/shared/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersView extends StatelessWidget {
  final Users user;
  final bool isAccepting;

  const UsersView({Key? key, required this.user, required this.isAccepting})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UsersProvider>(context);
    return FutureBuilder(
      future: users.getUserInfo(user.idUsuarioCorreo!),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                margin: const EdgeInsets.all(15),
                color: const Color(0xffF6F6F6),
                elevation: 5,
                child: ListTile(
                  leading: Image.network(
                      "https://ui-avatars.com/api/?rounded=true&name=${snapshot.data!.peNombres}"),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${snapshot.data!.peNombres!} ${snapshot.data!.peApellidoPaterno!} ${snapshot.data!.peApellidoMaterno!}",
                        style: const TextStyle(
                          fontFamily: "MontserratAlternates",
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Correo: ${snapshot.data!.idUsuarioCorreo}",
                        style: const TextStyle(
                          fontFamily: "MontserratAlternates",
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Tipo de usuario: ${snapshot.data!.tipTipoUsuario}",
                        style: const TextStyle(
                          fontFamily: "MontserratAlternates",
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      "Id de persona: ${snapshot.data!.fkIdPersona}",
                      style: const TextStyle(
                          fontFamily: "MontserratAlternates", fontSize: 15),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              CustomButton(
                  text: isAccepting ? "Activar usuario" : "Desactivar usuario",
                  onPressed: () {
                    users
                        .updateUser(snapshot.data!.idUsuarioCorreo!,
                            isAccepting ? 1 : 4)
                        .then((value) {
                      if (isAccepting || value) {
                        return jsAlert("Usuario actualizado exitosamente");
                      }
                      jsAlert("Ha ocurrido un error al actualizar el usuario");
                    });
                  })
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(color: Colors.black),
        );
      },
    );
  }
}
