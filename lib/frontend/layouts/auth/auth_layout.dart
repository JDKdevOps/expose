import 'package:expose/frontend/shared/link_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthLayout extends StatelessWidget {
  final Widget child;

  const AuthLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              _Background(size: size),
              SizedBox(
                height: size.height * 0.95,
                width: size.width * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 45),
                    Text(
                      'Todo comienza con una idea',
                      style: GoogleFonts.montserratAlternates(
                          fontSize: 65, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 30),
                    Expanded(child: child),
                  ],
                ),
              ),
            ],
          ),
          const _LinkBar()
        ],
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.95,
      width: size.width * 0.6,
      child: Container(
        margin: const EdgeInsets.all(50),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(15),
          shape: BoxShape.rectangle,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: Row(
                children: const [
                  Icon(Icons.circle_outlined),
                  Icon(Icons.circle_outlined),
                  Icon(Icons.circle_outlined),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: SvgPicture.asset(
                      'pitch.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    left: 600,
                    child: Text(
                      'Expose',
                      style: GoogleFonts.montserratAlternates(
                          fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _LinkBar extends StatelessWidget {
  const _LinkBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: const [
        LinkText(text: 'Política de Privacidad'),
        LinkText(text: 'Términos y condiciones'),
        LinkText(text: 'Tratamiento de datos'),
        LinkText(text: 'Estado'),
        LinkText(text: 'Acerca de'),
        LinkText(text: 'Centro de ayuda'),
      ],
    );
  }
}
