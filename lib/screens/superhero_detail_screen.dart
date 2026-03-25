import 'package:flutter/material.dart';
import 'package:super_hero/data/model/superhero_detail_response.dart';

class SuperheroDetailScreen extends StatelessWidget {
  final SuperheroDetailResponse superhero;

  const SuperheroDetailScreen({super.key, required this.superhero});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Column(
              children: [
                buildHeroHeader(),
                buildPowerStats(),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: buildAppearance(),
                ), // Appearance
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: buildBiography(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column buildBiography() {
    return Column(
      children: [
        Text(
          'Biography',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                  child: Text('Alter Ego',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                  child: Text(superhero.biographyResponse.alterEgo),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                  child:
                      Text('Aliases', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                  child: Text(superhero.biographyResponse.aliases.join(', ')),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                  child:
                      Text('Place of Birth', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                  child: Text(superhero.biographyResponse.placeOfBirth),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                  child:
                      Text('Publisher', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                  child: Text(superhero.biographyResponse.publisher),
                ),
              ],
            ),

          ],
        ),
      ],
    );
  }

  Column buildAppearance() {
    return Column(
      children: [
        Text(
          'Appearance',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
                decoration: BoxDecoration(color: Colors.blueGrey.shade50),
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                    child: Text('Gender',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                    child: Icon(superhero.appearanceResponse?.genderIcon),
                  ),
                ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                child:
                    Text('Race', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                child: Text(superhero.appearanceResponse?.race ?? 'N/A'),
              )
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                child: Text('Height',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                child:
                    Text(superhero.appearanceResponse?.heightMetric ?? 'N/A'),
              )
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                child: Text('Weight',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                child:
                    Text(superhero.appearanceResponse?.weightMetric ?? 'N/A'),
              )
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                child: Text('Eye Color',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                child: Text(superhero.appearanceResponse?.eyeColor ?? 'N/A'),
              )
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                child: Text('Hair Color',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                child: Text(superhero.appearanceResponse?.hairColor ?? 'N/A'),
              )
            ]),
          ],
        ),
      ],
    );
  }

  Column buildHeroHeader() {
    return Column(
      children: [
        Image.network(
          superhero.url,
          height: 300,
          width: double.infinity,
          fit: BoxFit.cover,
          alignment: Alignment(0, -0.6),
        ),
        Text(
          superhero.name,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          superhero.realName ?? 'N/A',
          style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
        ),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Center(
        child: Text(
          superhero.name,
          style: TextStyle(fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  SizedBox buildPowerStats() {
    return SizedBox(
      width: double.infinity,
      height: 125,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildGraphBar(
              value: superhero.powerstatsResponse?.intelligence,
              label: 'Intelligence',
              color: Colors.greenAccent),
          buildGraphBar(
              value: superhero.powerstatsResponse?.strength,
              label: 'Strength',
              color: Colors.deepOrangeAccent),
          buildGraphBar(
              value: superhero.powerstatsResponse?.speed,
              label: 'Speed',
              color: Colors.lightBlue),
          buildGraphBar(
              value: superhero.powerstatsResponse?.durability,
              label: 'Durability',
              color: Colors.blueAccent),
          buildGraphBar(
            value: superhero.powerstatsResponse?.power,
            label: 'Power',
          ),
          buildGraphBar(
              value: superhero.powerstatsResponse?.combat,
              label: 'Combat',
              color: Colors.redAccent),
        ],
      ),
    );
  }

  /// Method to build graph bar
  Column buildGraphBar(
      {double? value = 0.0,
      required String label,
      Color color = Colors.amber}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 20,
          height: (value == 0.0 ? 5 : value),
          color: color,
        ),
        Text(label),
      ],
    );
  }
}
