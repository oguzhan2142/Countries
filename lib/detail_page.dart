import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {


  String formatPopulation(int population) {
    var buffer = StringBuffer();

    int counter = 1;
    for (int i = population.toString().length - 1; i >= 0; i--) {
      var char = population.toString().codeUnitAt(i);
      buffer.writeCharCode(char);
      if (counter != 0 && counter % 3 == 0) {
        buffer.write(',');
      }
      counter++;
    }
    return buffer.toString().split('').reversed.join();
  }


  String getLanguages(Map country) {
    List list = country['languages'] as List;

    var buffer = StringBuffer();
    for (var item in list) {
      buffer.write(item['name']);

      if (list[list.length - 1] != item) buffer.write(', ');
    }

    return buffer.toString();
  }

  String removeArrayParantesis(String str) {
    return str.replaceAll('[', '').replaceAll(']', '');
  }

  Widget build(BuildContext context) {
    final Map country = ModalRoute.of(context).settings.arguments;
    var infoTextStyle = TextStyle(
      fontSize: 17,
      color: Colors.white,
    );
    var titleStyle = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w800,
      color: Colors.black,
    );
    List<Widget> createCurrenciesWidgeds(Map country) {
      List list = country['currencies'] as List;
      List<Widget> widgeds = [];
      widgeds.add(Row(children: [Text('Currencies :', style: titleStyle)]));
      for (var item in list) {
        widgeds.add(SizedBox(
          height: 5,
        ));
        widgeds.add(Row(children: [
          SizedBox(
            width: 30,
          ),
          Text(
            '->  ${item['name']}  -  ${item['symbol']}',
            style: infoTextStyle,
          ),
        ]));
      }
      return widgeds;
    }

    Widget createInfoWidged(String title, String value) {
      return Wrap(
        children: [
          Text(
            '$title :',
            style: titleStyle,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            value,
            style: infoTextStyle,
          ),
        ],
      );
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          title: Text(country['name']),
          centerTitle: true,
        ),
        backgroundColor: Colors.grey[600],
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
          child: Column(children: [
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.network(
                  country['flag'],
                  height: 100,
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              country['name'],
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.3,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
                country['nativeName'],
              style: TextStyle(
                fontSize: 18,
                letterSpacing: 1.1,
              ),

            ),
            Divider(
              height: 30,
              color: Colors.grey[800],
            ),
            Container(
                alignment: Alignment.centerLeft,
                child: createInfoWidged('Capital', country['capital'])),
            SizedBox(
              height: 15,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: createInfoWidged('Region', country['region']),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: createInfoWidged('Calling Codes',
                  removeArrayParantesis(country['callingCodes'].toString())),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: createInfoWidged(
                  'Population', formatPopulation(country['population'])),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
                alignment: Alignment.centerLeft,
                child: createInfoWidged('Area', country['area'].toString())),
            SizedBox(
              height: 15,
            ),
            Container(
                alignment: Alignment.centerLeft,
                child: createInfoWidged('Languages', getLanguages(country))),
            SizedBox(
              height: 15,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: createInfoWidged('borders',
                  removeArrayParantesis(country['borders'].toString())),
            ),
            SizedBox(
              height: 15,
            ),
            Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: createCurrenciesWidgeds(country)),
          ]),
        ));
  }
}
