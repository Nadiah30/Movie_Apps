import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:ndialog/ndialog.dart';

void main() => runApp(const HomePage());

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

// ignore: camel_case_types
class _HomePageState extends State<HomePage> {
  dynamic actors, genre, release, title = "Queen of Katwe", desc = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Movie Apps'),
            centerTitle: true,
            backgroundColor: Colors.red[600],
          ),
          body: Center(
              child: Container(
                  color: Colors.amber,
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        //controller: Controller,
                        decoration: InputDecoration(
                            hintText: 'Movie name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                      const SizedBox(
                        height: 8, //to separate two box in the appbar
                      ),
                      ElevatedButton(
                          onPressed: _loadMovie,
                          child: const Text("Load Movie")),
                      Text(desc,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      FloatingActionButton(
                        onPressed: () {},
                        backgroundColor: Colors.red[600],
                        child: const Text("Done"),
                      ),
                    ],
                  ))),
        ));
  }

  Future<void> _loadMovie() async {
    // ignore: unused_local_variable
    var apikey = "3eafcdac";
    var url = Uri.parse('http://www.omdbapi.com/?t=$title&apikey=3eafcdac');
    var response = await http.get(url);
    //var rescode = response.statusCode;
    if (response.statusCode == 200) {
      var jsonData = response.body;
      var parsedData = json.decode(jsonData);
      setState(() {
        var title = parsedData['Title'];
        var year = parsedData['Year'];
        var released = parsedData['Released'];
        var genre = parsedData['Genre'];
        var director = parsedData['Director'];
        var actors = parsedData['Actors'];
        var poster = parsedData['poster'];

        desc =
            "Search result for $title is $genre and $released. The actors are $actors and directed by $director.";
      });
    } else {
      setState(() {
        desc = "No record";
      });
    }
  }
}
