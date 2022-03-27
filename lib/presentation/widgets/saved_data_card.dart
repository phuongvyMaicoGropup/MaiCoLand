import 'package:flutter/material.dart';

class SavedDataCard extends StatelessWidget {
  const SavedDataCard({required this.title, Key? key}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.14,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2, 2),
              blurRadius: 5,
              spreadRadius: 1.1,
            )
          ]),
      child: Stack(children: [
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.30,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.5),
                    offset: const Offset(0, 2),
                    blurRadius: 2,
                  ),
                ],
                image: const DecorationImage(
                  image: AssetImage('assets/logo.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.60,
              padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 7,
                    child: Text(
                      title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontFamily: "Montserrat",
                            fontSize: 15,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
