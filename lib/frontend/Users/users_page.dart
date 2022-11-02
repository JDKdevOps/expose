import 'package:expose_master/backend/providers/users_providers.dart';
import 'package:expose_master/frontend/Users/views/users_info_view.dart';
import 'package:expose_master/frontend/Users/views/users_views.dart';
import 'package:expose_master/frontend/shared/custom_button.dart';
import 'package:expose_master/frontend/shared/custom_card.dart';
import 'package:expose_master/frontend/shared/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UsersProvider>(context);

    return Container(
      margin: const EdgeInsets.all(20),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Usuarios:",
                  style: TextStyle(
                    fontFamily: "MontserratAlternates",
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CustomButton(
                text: "Crear nuevo usuario",
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const CustomDialog(
                      title: "Registrar usuario",
                      content: UsersInfoView(isEditing: false),
                    ),
                  );
                },
              ),
            ],
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: IconButton(
                    onPressed: () {
                      if (users.index != 0) {
                        users.index -= 5;
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.black,
                      size: 50,
                    ),
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: users.getUsers(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        users.empty = false;
                        return Center(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            direction: Axis.horizontal,
                            children: [
                              ...snapshot.data!.map(
                                (e) {
                                  final state = e.fkIdEstado == 1
                                      ? "Activo"
                                      : "Rechazado";
                                  return CustomCard(
                                    width: 350,
                                    height: 80,
                                    title: e.idUsuarioCorreo!,
                                    assetImg: "imgs/initiative.svg",
                                    options: CustomOptions(
                                      options: [
                                        //Activar usuario
                                        OptionProps(
                                          title: "Activar Usuario",
                                          icon: Icons.check_circle_outline,
                                          content: UsersView(
                                              user: e, isAccepting: true),
                                        ),
                                        //Editar usuario
                                        OptionProps(
                                          title: "Editar Usuario",
                                          icon: Icons.edit_outlined,
                                          content: UsersInfoView(
                                              user: e, isEditing: true),
                                        ),
                                        //Desactivar usuario
                                        OptionProps(
                                          title: "Desactivar Usuario",
                                          icon: Icons.cancel_outlined,
                                          content: UsersView(
                                              user: e, isAccepting: false),
                                        ),
                                      ],
                                    ),
                                    extraOptions: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Estado: $state",
                                        style: const TextStyle(
                                          fontFamily: "MontserratAlternates",
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                        users.empty = true;
                        return SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "imgs/empty.svg",
                                fit: BoxFit.contain,
                                width: 300,
                                height: 300,
                              ),
                              const SizedBox(height: 50),
                              const Text(
                                "Más emprendedores en camino",
                                style: TextStyle(
                                  fontFamily: "MontserratAlternates",
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.black),
                      );
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: IconButton(
                    onPressed: () {
                      if (!users.empty) {
                        users.index += 5;
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.black,
                      size: 50,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
