import 'dart:convert';
import 'package:cms/components/detailView.dart';
import 'package:http/http.dart' as http;
import 'package:cms/models/content.dart';
import 'package:flutter/material.dart';

Future<Content> fetchContent() async {
  final response =
      await http.get(Uri.parse('https://dummyjson.com/products/2'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Content.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreen();
}

class _DetailScreen extends State<DetailScreen> {
  late Future<Content> futureContent;

  @override
  void initState() {
    super.initState();
    futureContent = fetchContent();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<Content>(
        future: futureContent,
        builder: (context, item) {
          if (item.hasData) {
            return ContentView(content: item.data!);
          } else if (item.hasError) {
            return Text('${item.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
