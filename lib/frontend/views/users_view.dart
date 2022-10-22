import 'package:expose/backend/providers/leaders_provider.dart';
import 'package:expose/backend/providers/users_provider.dart';
import 'package:expose/frontend/shared/custom_button.dart';
import 'package:expose/frontend/shared/custom_dialog.dart';
import 'package:expose/frontend/shared/iniciatives_card.dart';
import 'package:expose/frontend/shared/leaders_card.dart';
import 'package:expose/frontend/shared/users_card.dart';
import 'package:expose/frontend/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UsersView extends StatelessWidget {
  const UsersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);

    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Administración de usuarios:",
                  style: GoogleFonts.montserrat(
                      fontSize: 50, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 15),
                  CustomButton(
                    text: "Crear usuario",
                    onPressed: () => showDialog(
                      context: context,
                      barrierColor: Colors.black.withOpacity(0.2),
                      builder: (_) {
                        return const CustomDialog(
                            title: "Registrar Usuario",
                            content: RegisterView());
                      },
                    ),
                  ),
                  const SizedBox(width: 100),
                  CustomButton(
                    text: "Atrás",
                    onPressed: () {
                      if (usersProvider.indexPreview != 0) {
                        return usersProvider.indexPreview -= 5;
                      }
                    },
                  ),
                  const SizedBox(width: 20),
                  CustomButton(
                    text: "Siguiente",
                    onPressed: () {
                      if (!usersProvider.emptyContent) {
                        return usersProvider.indexPreview += 5;
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: FutureBuilder(
                future: usersProvider.getUsers(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    usersProvider.emptyContent = false;
                    return Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      direction: Axis.horizontal,
                      children: [
                        ...snapshot.data!.map(
                          (e) => UsersCard(
                            width: 400,
                            height: 125,
                            user: e,
                          ),
                        ),
                      ],
                    );
                  }
                  if (snapshot.hasData && snapshot.data!.isEmpty) {
                    usersProvider.emptyContent = true;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "empty.svg",
                          fit: BoxFit.contain,
                          width: 300,
                          height: 300,
                        ),
                        const SizedBox(height: 50),
                        Text(
                          "Más usuarios vienen en camino",
                          style: GoogleFonts.montserrat(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                      ],
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
