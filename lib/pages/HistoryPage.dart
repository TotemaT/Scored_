import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('HistoryScaffold'),
      appBar: AppBar(
        title: Text('Scored!'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 156),
                child: Text(
                  'No history found :(',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.black38
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 32, bottom: 8),
                child: Text(
                  'Log in to get your previous parties',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black38
                  )
                )
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 64),
                child: Text(
                  'or launch a new party now !',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black38
                  )
                )
              ),
              SvgPicture.asset(
                'assets/arrow_down.svg',
                semanticsLabel: 'Arrow pointing to the create party button',
                height: 32,
                color: Colors.black38,
              )
            ],
          ),
        )
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 4,
        color: Theme.of(context).primaryColor,
        child: Row(
          children: [
            IconButton(icon: Icon(Icons.menu), onPressed: () {}),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => log("Clicked fab"),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked
    );
  }
}
