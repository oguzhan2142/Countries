import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final searchTextController = TextEditingController();
  final url = 'https://restcountries.eu/rest/v2/all';
  Future<List> futureCountries;

  void search() {
    print(searchTextController.text);
    Navigator.pushNamed(context, '/detail');
  }

  Future<List> getData() async {
    Response response = await get(url);
    List list = json.decode(response.body);

    for (Map country in list) {
      if (country['flag'] == null) list.remove(country);
    }
    return list;
  }

  @override
  void initState() {
    super.initState();
    futureCountries = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Countries'),
          centerTitle: true,
          backgroundColor: Colors.grey[800]),
      body: grid(),
      backgroundColor: Colors.grey[600],
    );
  }

  Widget createCard(Map country) {
    String imageURL = country['flag'];

    var image = SvgPicture.network(
      imageURL,
    );

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detail', arguments: country);
      },
      child: SizedBox(
        child: image,
      ),
    );
  }

  List<Widget> createAllCards(AsyncSnapshot snapshot) {
    List<Widget> widgeds = [];

    List list = snapshot.data as List;
    for (int i = 0; i < list.length; i++) {
      var card = createCard(snapshot.data[i]);
      if (card != null) widgeds.add(card);
    }
    return widgeds;
  }

  Widget grid() {
    return FutureBuilder(
      future: futureCountries,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CustomScrollView(
            primary: false,
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverGrid.count(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 1,
                    crossAxisCount: 3,
                    children: createAllCards(snapshot)),
              ),
            ],
          );
        } else {
          return Center(child: Text('Data Loading...'));
        }
      },
    );
  }
}
