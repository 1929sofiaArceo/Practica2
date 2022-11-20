import 'package:flutter/material.dart';

class ItemFav extends StatelessWidget {
  final Map<String, String> content;
  ItemFav({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your favorite songs'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 70, right: 70, top: 50, bottom: 50),
                  child: Container(
                    height: 250,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Image.network(
                              content["image"]!,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Positioned(
                            top: 10, left: 5, //give the values according to your requirement
                            child: Icon(Icons.favorite),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xef4169D8),
                                borderRadius:
                                    BorderRadius.only(topRight: Radius.circular(15)),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "${content["autor"]}",
                                    style: TextStyle(color: Colors.grey[200], fontWeight: FontWeight.bold, fontSize: 20),
                                  ),
                                  Text(
                                    "${content["title"]}",
                                    style: TextStyle(color: Colors.grey[200], fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}