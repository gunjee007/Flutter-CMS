import 'package:flutter/material.dart';
import 'package:cms/contents/contents.dart';

final ButtonStyle style = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.cyan);

class ContentListItem extends StatelessWidget {
  const ContentListItem({required this.content, super.key});

  final Content content;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: TextButton(
        child: ListTile(
          leading: Text('${content.id}', style: textTheme.bodySmall),
          title: Text(content.title),
          isThreeLine: true,
          subtitle: Text(content.brand),
          dense: true,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ContentDetail(
                      content: content,
                    )),
          );
        },
      ),
    );
  }
}
