import 'package:cms/models/content.dart';
import 'package:flutter/material.dart';

class ContentView extends StatefulWidget {
  const ContentView({super.key, required this.content});
  final Content content;
  @override
  State<ContentView> createState() => _ContentView();
}

class _ContentView extends State<ContentView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.content.title),
        Text(widget.content.brand),
        Text("${widget.content.price}\$")
      ],
    );
  }
}
