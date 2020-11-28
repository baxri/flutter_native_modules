import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/greate_palces.dart';
import '../screens/add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your places'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              }),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: Provider.of<GreatePlaces>(context, listen: false)
              .setPlacesFromDatabase(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<GreatePlaces>(
                  child: Text('There is places yet!'),
                  builder: (ctx, greatePlaces, ch) =>
                      greatePlaces.items.length <= 0
                          ? ch
                          : ListView.builder(
                              itemCount: greatePlaces.items.length,
                              itemBuilder: (ctx, i) => ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(greatePlaces.items[i].image),
                                ),
                                title: Text(greatePlaces.items[i].title),
                                onTap: () {
                                  // Go to detail screen
                                },
                              ),
                            ),
                ),
        ),
      ),
    );
  }
}
