import 'package:flutter/material.dart';
import 'package:infinite_scroll_list_app/feature/presentation/widgets/photos_list_widget.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Photos'),
        centerTitle: true,
      ),
      body: PhotosList(
        scaffoldKey: scaffoldKey,
      ),
    );
  }
}
