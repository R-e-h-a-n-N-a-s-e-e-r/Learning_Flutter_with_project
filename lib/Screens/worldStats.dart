import 'package:covidtracker/Models/WorldStatModel.dart';
import 'package:covidtracker/Screens/countriesListScreen.dart';
import 'package:covidtracker/Services/fetchWorldStats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import '';

class Worldstats extends StatefulWidget {
  const Worldstats({super.key});

  @override
  State<Worldstats> createState() => _WorldstatsState();
}

class _WorldstatsState extends State<Worldstats> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // WorldStatesViewModel newsListViewModel = WorldStatesViewModel();
  FetchWorldStats fetchWorldStats = FetchWorldStats();

  final colorList = <Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .01),
              FutureBuilder(
                future: fetchWorldStats.fetchWorldRecords(),
                builder: (context, AsyncSnapshot<WorldStatModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                        controller: _controller,
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "Total": double.parse(
                              snapshot.data!.cases!.toString(),
                            ),
                            "Recovered": double.parse(
                              snapshot.data!.recovered.toString(),
                            ),
                            "Deaths": double.parse(
                              snapshot.data!.deaths.toString(),
                            ),
                          },
                          animationDuration: Duration(milliseconds: 1200),
                          chartLegendSpacing: 32,
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          colorList: colorList,
                          initialAngleInDegree: 0,
                          chartType: ChartType.ring,
                          ringStrokeWidth: 25,
                          legendOptions: const LegendOptions(
                            showLegendsInRow: false,
                            legendPosition: LegendPosition.left,
                            showLegends: true,
                            legendTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValueBackground: true,
                            showChartValues: true,
                            showChartValuesInPercentage: true,
                            showChartValuesOutside: true,
                            decimalPlaces: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * .03,
                          ),
                          child: Card(
                            child: Column(
                              children: [
                                ReusableRow(
                                  title: 'Total Cases',
                                  value: snapshot.data!.cases.toString(),
                                ),
                                ReusableRow(
                                  title: 'Deaths',
                                  value: snapshot.data!.deaths.toString(),
                                ),
                                ReusableRow(
                                  title: 'Recovered',
                                  value: snapshot.data!.recovered.toString(),
                                ),
                                ReusableRow(
                                  title: 'Active',
                                  value: snapshot.data!.active.toString(),
                                ),

                                ReusableRow(
                                  title: 'Affected Countries',
                                  value: snapshot.data!.affectedCountries
                                      .toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Countrieslistscreen(),
                              ),
                            );
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(child: Text('Track Countries')),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title, value;

  const ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(value,),
            ],
          ),
          SizedBox(height: 5),
          Divider(color: Colors.grey.shade800),
        ],
      ),
    );
  }
}
