import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class App_Bar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 150.0,
      floating: false,
      title:  Text(
          'Collapsing AppBar',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,

        background: Image.network(
          'https://picsum.photos/800/600',
          fit: BoxFit.cover,
        ),
      ),
      actions: [
        IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.gear)),
        IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.share)),
        IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.sun)),
      ],
    );
  }
}
