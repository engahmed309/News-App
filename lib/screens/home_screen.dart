import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  final List news = [];
  final List newsInput = [];
  Future getData() async {
    var url = Uri.parse("https://thiet.edu.eg/api/news");
    final response = await http.get(url);
    final responseBody = jsonDecode(response.body);
    print(responseBody);

    setState(() {
      news.addAll(responseBody);
    });
  }

  void initState() {
    getData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("News App")),
      body: news.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (context, index) => Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "User Id :${news[index]['name']}",
                          style: TextStyle(color: Colors.green),
                        ),
                        Text(
                          news[index]['photo'],
                          style: TextStyle(color: Colors.cyan),
                        ),
                        Image.network(
                            "http://thiet.edu.eg/public/storage/web/news/AVciGlE5LzHPA6fTJfsVIFiLiqK7BIksbyPGHYrp.jpg"),
                        Text(
                          news[index]['department_id'].toString(),
                        ),
                        Text(
                          parse(news[index]['input']).body!.text,
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
              itemCount: news.length),
    );
  }
}
