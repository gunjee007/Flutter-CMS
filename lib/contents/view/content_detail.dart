import 'package:flutter/material.dart';
import 'package:cms/contents/contents.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:cms/contents/contents.dart';

class ContentDetail extends StatelessWidget {
  const ContentDetail({super.key, required this.content});

  final Content content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(content.title)),
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            Image.network(content.thumbnail),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(content.description),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "${content.price} \$",
              ),
            ),
          ]),
        )));
  }
}
