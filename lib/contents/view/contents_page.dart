import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cms/contents/contents.dart';

import 'package:http/http.dart' as http;

class ContentsPage extends StatelessWidget {
  const ContentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: BlocProvider(
        create: (_) =>
            ContentBloc(httpClient: http.Client())..add(ContentFetched()),
        child: const ContentsList(),
      ),
    );
  }
}
