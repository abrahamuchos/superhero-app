import 'package:flutter/material.dart';
import 'package:super_hero/data/model/superhero_detail_response.dart';
import 'package:super_hero/data/model/superhero_response.dart';
import 'package:super_hero/data/repository.dart';
import 'package:super_hero/screens/superhero_detail_screen.dart';

class SuperheroSearchScreen extends StatefulWidget {
  const SuperheroSearchScreen({super.key});

  @override
  State<SuperheroSearchScreen> createState() => _State();
}

class _State extends State<SuperheroSearchScreen> {
  Future<SuperheroResponse?>? _superHeroInfo;
  final Repository _repository = Repository();
  bool _isTextEmpty = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SuperHero Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: searchBar(),
            ),
            bodyList(),
          ],
        ),
      ),
    );
  }

  TextField searchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Busca un superhéroe",
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
      ),
      onChanged: (text) {
        setState(() {
          _isTextEmpty = text.isEmpty;
          _superHeroInfo = _repository.fetchSuperHeroInfo(text);
        });
      },
    );
  }

  /// List about superheros
  FutureBuilder<SuperheroResponse?> bodyList() {
    return FutureBuilder(
      future: _superHeroInfo,
      builder: (context, snapshot) {
        if (_isTextEmpty) return Center(child: Text("Introduce un nombre"));

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (snapshot.hasData) {
          var superheroList = snapshot.data?.result;

          return Expanded(
            child: ListView.builder(
                itemCount: superheroList?.length ?? 0,
                itemBuilder: (context, index) {
                  if (superheroList != null) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: itemSuperHero(superheroList[index]),
                    );
                  } else {
                    return Text('Error');
                  }
                }),
          );
        } else {
          return Text('No hay resultados');
        }
      },
    );
  }

  /// Item Card to SuperHero
  GestureDetector itemSuperHero(SuperheroDetailResponse item) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SuperheroDetailScreen(superhero: item),
          )),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.blueGrey,
        ),
        child: Column(
          children: [
            Image.network(
              item.url,
              height: 290,
              width: double.infinity,
              fit: BoxFit.fitWidth,
              alignment: Alignment(0, -0.6),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: Text(
                item.name,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
