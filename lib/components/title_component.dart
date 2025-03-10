import 'package:flutter/material.dart';

class ContainerTitlePage extends StatelessWidget {
  final String title;
  final String? subtitle;

  const ContainerTitlePage({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: subtitle != '' ? 180 : 100,
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LimitedBox(
                maxWidth:  350,
                child: Text(title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 5,
                child: Divider(
                  color: Colors.grey.shade300,
                  height: 1,
                ),
              ),
            ],
          ),

          if(subtitle != '')
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LimitedBox(
                  maxWidth: 350,
                  child: Text(subtitle!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Color(0XFF4F4F4F),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
