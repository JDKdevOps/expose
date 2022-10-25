import 'package:expose_master/backend/classes/iniciativa.dart';
import 'package:expose_master/backend/providers/dash_provider.dart';
import 'package:expose_master/backend/router/router_manager.dart';
import 'package:expose_master/backend/services/form_validators.dart';
import 'package:expose_master/frontend/dashboard/widgets/comment_section.dart';
import 'package:expose_master/frontend/shared/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CommentsView extends StatelessWidget {
  final Initiative initiative;

  const CommentsView({Key? key, required this.initiative}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: FutureBuilder(
            future: dash.getComments(initiative.idIniciativa.toString()),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: SingleChildScrollView(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      direction: Axis.horizontal,
                      children: [
                        ...snapshot.data!.map(
                          (e) => CommentSection(comment: e),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "imgs/empty.svg",
                      width: 200,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Sé el primero en comentar",
                      style: TextStyle(
                        fontFamily: "MontserratAlternates",
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
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
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 75,
          child: RouterBuilderManager.routerStatus == RouterStatus.auth
              ? Form(
                  key: dash.commentsForm,
                  child: CustomInput(
                    maxLength: 255,
                    hint: "Mi comentario",
                    label: "Escribe un comentario",
                    icon: Icons.comment_bank_outlined,
                    validator: FormValidators.defaultValidator,
                    onChanged: (p0) => dash.comment = p0,
                    iconButton: IconButton(
                      onPressed: () {
                        if (dash.commentsForm.currentState?.validate() ??
                            false) {
                          dash.commentsForm.currentState?.reset();
                          dash.postComments(initiative.idIniciativa.toString());
                        }
                      },
                      icon: const Icon(
                        Icons.send_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              : const Text(
                  "Inicia sesión para poder comentar",
                  style: TextStyle(
                    fontFamily: "MontserratAlternates",
                    fontSize: 20,
                  ),
                ),
        )
      ],
    );
  }
}
