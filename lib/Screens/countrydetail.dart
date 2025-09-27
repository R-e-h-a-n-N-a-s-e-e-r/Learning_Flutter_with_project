import 'package:flutter/material.dart';
import 'package:covidtracker/Screens/worldStats.dart';

class CountryDetail extends StatefulWidget {
  final String name, image;
  final int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      todayDeaths,
      oneCasePerPeople;

  const CountryDetail({
    super.key,
    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.todayDeaths,
    required this.oneCasePerPeople,
  });

  @override
  State<CountryDetail> createState() => _CountryDetailState();
}

class _CountryDetailState extends State<CountryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: AlignmentGeometry.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .067,
                ),
                child: Card(
                  color: Colors.grey.shade900,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .06,
                      ),
                      ReusableRow(
                        title: 'Cases',
                        value: widget.totalCases.toString(),
                      ),
                      ReusableRow(
                        title: 'Recovered',
                        value: widget.totalRecovered.toString(),
                      ),
                      ReusableRow(
                        title: 'Death',
                        value: widget.totalDeaths.toString(),
                      ),
                      ReusableRow(
                        title: 'Active',
                        value: widget.active.toString(),
                      ),
                      ReusableRow(
                        title: 'Today Deaths',
                        value: widget.todayDeaths.toString(),
                      ),
                      ReusableRow(
                        title: 'One Case per People',
                        value: widget.oneCasePerPeople.toString(),
                      ),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                // child: Image(image: NetworkImage(widget.image)),
                backgroundImage: NetworkImage(widget.image),

              ),
            ],
          ),
        ],
      ),
    );
  }
}
