import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import './item_fav.dart';
// import './match_song.dart';
// import './proveedor.dart';
// import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class FavSongs extends StatefulWidget {
  FavSongs({super.key, required this.song});
  final List<Map<String, String>> song;

  @override
  State<FavSongs> createState() => _FavSongsState();
}

class _FavSongsState extends State<FavSongs> {

  @override
  void initState() {
    super.initState();
    print("Iniciando fav songs");
    FirebaseFirestore.instance
    .collection('favSongs')
    .get()
    .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
            print(doc["title"]);
        });
    });
  }

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
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: this.widget.song.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50, top: 25, bottom: 25),
                  child: GestureDetector(
                    onTap: (){
                      showAlertDialogRedirect(context, this.widget.song[index]["url"]);
                      setState(() {});
                    },
                    child: Container(
                      height: 270,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                              child: Image.network(
                                "${this.widget.song[index]["image"]}",
                                fit: BoxFit.fill,
                              ),
                            ),
                            Positioned(
                              top: 10, left: 5, //give the values according to your requirement
                              child: IconButton(icon: Icon(Icons.favorite), onPressed: () {
                                print(this.widget.song[index]["autor"]);
                                showAlertDialog(context, index, this.widget.song[index]["title"]);
                                setState(() {});
                              },),
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
                                      "${this.widget.song[index]["autor"]}",
                                      style: TextStyle(color: Colors.grey[200], fontWeight: FontWeight.bold, fontSize: 20),
                                    ),
                                    Text(
                                      "${this.widget.song[index]["title"]}",
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
              );
            }
          ),
        ),
      ],
    ));
  }
  showAlertDialog(BuildContext context, index, title) {
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed:  () async{
        print(index);
        this.widget.song.removeAt(index);
        await FirebaseFirestore.instance
          .collection('favSongs')
          .get()
          .then((QuerySnapshot querySnapshot) {
              querySnapshot.docs.forEach((doc) {
                  if(doc["title"] == title){
                    FirebaseFirestore.instance.collection('favSongs').doc(doc.id).delete();
                  }
              });
          });
        setState(() {});
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Eliminar de favoritos"),
      content: Text("El elemento será eliminado de favoritos, ¿Quieres continuar?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}


showAlertDialogRedirect(BuildContext context, url) {
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed:  () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("Continue"),
    onPressed:  () {
      _launchUrl(Uri.parse(url));
      Navigator.pop(context);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Abrir cancion"),
    content: Text("Sera redirigido a ver opciones para abrir la canción, ¿Quiere continuar?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Future<void> _launchUrl(_url) async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}