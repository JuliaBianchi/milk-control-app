import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppbarHomepage extends StatelessWidget {
  final String? nome;
  final String leading;
  final String trailing;
  final Widget? widget;
  final void Function()? onPressedTrailing;
  final void Function()? onPressedLeading;

  const AppbarHomepage({
    super.key,
    this.nome,
    this.widget,
    required this.leading,
    required this.trailing,
    this.onPressedTrailing,
    this.onPressedLeading,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              height: 280,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(40)),
                color: Color(0xff194a7a),
              ),
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: onPressedLeading,
                            icon: SvgPicture.asset(
                              leading,
                              height: 30,
                              width: 30,
                            ),
                          ),
                          IconButton(
                            onPressed: onPressedTrailing,
                            icon: SvgPicture.asset(
                              trailing,
                              height: 30,
                              width: 30,
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/icons/user.svg', height: 40, width: 40,),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              if (nome != null)
                                Text(
                                  nome!,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  // Navigator.of(context).pop();
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.resolveWith<Color?>(
                                          (Set<WidgetState> states) {
                                    return Color(0xffD1E9F6);
                                  }),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.settings,
                                      color: Color(0xff194a7a),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Meu Perfil',
                                      style: TextStyle(
                                        color: Color(0xff194a7a),
                                        fontSize: 18,
                                        fontFamily: 'Overpass',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 280,
            right: 0,
            child: Container(
              color: const Color(0xff194a7a),
              height: 100,
              width: 200,
            ),
          ),
          Positioned(
            top: 280,
            child: Container(
              padding: const EdgeInsets.only(top: 60),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(40)),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
        ],
      ),
    );
  }
}
