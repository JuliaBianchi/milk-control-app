import 'package:flutter/material.dart';
import 'package:milkcontrolapp/components/textformfield_search.dart';
import 'package:page_transition/page_transition.dart';

class AppBarPagesComponent extends StatelessWidget implements PreferredSizeWidget {
  final Widget nextPage;
  final Widget currentPage;
  final Widget? form;
  final String title;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool? visible;

  const AppBarPagesComponent({
    super.key,
    this.controller,
    this.onChanged,
    this.visible = false,
    this.form,
    required this.nextPage,
    required this.currentPage,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      color: const Color(0xff194a7a),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 5, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Navigator.push(
                  context,
                  PageTransition(
                    child: nextPage,
                    type: PageTransitionType.leftToRightWithFade,
                    childCurrent: currentPage,
                  ),
                ),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                ),
                color: Colors.white,
              ),
              Visibility(
                visible: visible!,
                child: IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    PageTransition(
                      child: form!,
                      type: PageTransitionType.rightToLeftWithFade,
                    ),
                  ),
                  icon: const Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.white,
                  ),
                  tooltip: 'Adicionar',
                  alignment: Alignment.centerRight,
                ),
              ),
            ],
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 15),

        TextFormFieldSearch(
          controller: controller,
          onChanged: onChanged,
        ),
      ]),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(180);
}