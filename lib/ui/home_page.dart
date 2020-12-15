import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Map> _getSearch() async {
    http.Response response;

    //retorno da API
    var request = http.Request('GET', Uri.parse(
        'https://jsonmock.hackerrank.com/api/movies/search/?Title={titulo_do_filme}'));

    http.StreamedResponse respo = await request.send();

    if (response.statusCode == 200) {
      print(await respo);
    }
    else {
      print(response.reasonPhrase);
    }

    return json.decode(request.body);
  }

  @override
  void initState() {
    super.initState();

    _getSearch().then((map) {
      print(map);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color(0xFF00826d),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
                "https://lh3.googleusercontent.com/proxy/Z55-zHE2B7ju7Y3v-H4cvC1jiqpOnwKb85poir4XntGNRlVwJd2k4zCVbMJmn3vbanRlh4CchdhpekrakTUai2SafgMw_R9uSwMJQ4XUikloO53Ti2Q-1xpelmgDWg",
                width: 60),

            Text("Movies for Years",
              style: TextStyle(color: Colors.white),),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15.0),
            child: TextField(
              decoration: InputDecoration(
                  labelText: "Busque por título, ano...",
                  labelStyle: TextStyle(color: Colors.teal),
                  border: OutlineInputBorder()
              ),
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,

            ),
          ),

          Expanded(
            child: FutureBuilder(
              future: _getSearch(),
              // Função builder retorna o estado do snapshot, se o snapshot está carregando os dados irá mostrar um progress indicator
              //Se não, mostrará os dados
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Container(
                        width: 200.0,
                        height: 200.0,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.teal),
                          strokeWidth: 5.0,
                        )
                    );
                  default:
                    if (snapshot.hasError) {
                      return Container();
                    }
                    else {
                      return _createMoviesTable(context, snapshot);
                    }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

// Grid para aparecer os filmes em ordem aleatória
  Widget _createMoviesTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder
      (
      padding: EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount
        (
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0
      ),

      // contagem de quantos filmes aparecerão
      itemCount: snapshot.data["data"].lenght,
      // retorna um widget com um gif ou imagem que o app estará consumindo da API
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Image.network(
              snapshot.data["data"][index]["images"]["fixed_height"]["url"],
              height: 300.0,
              fit: BoxFit.cover),
        );
      },
    );
  }

}