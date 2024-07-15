
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:verbinden/presentation/pages/message/widgets/widgets.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: kAppbarDecorate('Search'),
    body: Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: [ 
        CupertinoSearchTextField(),
        
      ],),
    ),);
  }
}