import 'package:covidtracker/Services/fetchWorldStats.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Countrieslistscreen extends StatefulWidget {
  const Countrieslistscreen({super.key});

  @override
  State<Countrieslistscreen> createState() => _CountrieslistscreenState();
}

class _CountrieslistscreenState extends State<Countrieslistscreen> {
  TextEditingController searchController = TextEditingController();
  FetchWorldStats fetchWorldStats = FetchWorldStats();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value){
                  setState(() {

                  });
                },
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search with country name ',
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: fetchWorldStats.fetchCountryRecords(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          // period: Duration(milliseconds: 700),
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          child: ListTile(
                            title: Container(
                              width: 80,
                              height: 10,
                              color: Colors.white,
                            ),
                            subtitle: Container(
                              width: 80,
                              height: 10,
                              color: Colors.white,
                            ),
                            leading: Container(
                              width: 50,
                              height: 50,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];
                        if(searchController.text.isEmpty){
                          return ListTile(
                            title: Text(
                              snapshot.data![index]['country'],
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                            subtitle: Text(
                              snapshot.data![index]['cases'].toString(),
                            ),
                            leading: Image(
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                snapshot.data![index]['countryInfo']['flag'],
                              ),
                            ),
                          );
                        }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                          return ListTile(
                            title: Text(
                              snapshot.data![index]['country'],
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                            subtitle: Text(
                              snapshot.data![index]['cases'].toString(),
                            ),
                            leading: Image(
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                snapshot.data![index]['countryInfo']['flag'],
                              ),
                            ),
                          );
                        }else{
                          return Container();
                        }


                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
