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
                width: size.width * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 125),
                    Text(
                      'Expose',
                      style: GoogleFonts.montserrat(
                          fontSize: 80, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Text('Todo comienza con una idea',
                        style: GoogleFonts.montserrat(
                            fontSize: 25, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
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
      width: size.width * 0.5,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(80),
            child: SvgPicture.asset(
              'pitch.svg',
              fit: BoxFit.contain,
            ),
          ),
        ],
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
