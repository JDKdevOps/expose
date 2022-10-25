import 'custom_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String assetImg;
  final CustomOptions options;
  final Widget? extraOptions;
  final double? width;
  final double? height;

  const CustomCard(
      {super.key,
      required this.title,
      required this.assetImg,
      required this.options,
      this.extraOptions,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(10),
      decoration: buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: "MontserratAlternates",
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(),
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              assetImg,
              height: height,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          options,
          if (extraOptions != null) ...{
            const Divider(),
            extraOptions!,
          }
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)
        ],
      );
}

class CustomOptions extends StatelessWidget {
  final List<OptionProps> options;

  const CustomOptions({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ...options.map(
          (e) {
            return IconButton(
              icon: Icon(e.icon),
              onPressed: () => showDialog(
                context: context,
                builder: (context) => CustomDialog(
                  title: e.title,
                  content: e.content,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class OptionProps {
  late String title;
  late IconData icon;
  late Widget content;

  OptionProps({required this.title, required this.icon, required this.content});
}
