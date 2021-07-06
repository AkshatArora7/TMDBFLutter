import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/screens/screen3.dart';

int page = 2;
List? genre;

class screen2 extends StatefulWidget {
  final String yearInput;

  const screen2({Key? key, required this.yearInput}) : super(key: key);

  @override
  _screen2State createState() => _screen2State();
}

class _screen2State extends State<screen2> {
  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Movies- ${widget.yearInput}',
          style: GoogleFonts.libreBaskerville(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            letterSpacing: 2,
            wordSpacing: 2,
          ),
        ),
      ),
      body: FutureBuilder<List>(
          future: fetchMovies(widget.yearInput),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return snapshot.data!.length == 0
                ? Center(
                    child: Text(
                    'NO MOVIES',
                    style: GoogleFonts.libreBaskerville(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      letterSpacing: 2,
                      wordSpacing: 2,
                    ),
                  ))
                : ListView(
                    children: snapshot.data!.map<Widget>((result) {
                      List id = result['genre_ids'];
                      // print(id);
                      String genredisplay = '';
                      genre!.forEach((idmap) {
                        if (id.contains(idmap['id'])) {
                          genredisplay = genredisplay + idmap['name'] + ', ';
                        }
                      });
                      String url =
                          'https://image.tmdb.org/t/p/original${result['poster_path']}';
                      // print(result);
                      return Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          height: 100,
                          // color: Colors.red,
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (myContext) => screen3(
                                        movieTitle: result['title'],
                                        movieURL: result['poster_path'],
                                        releaseDate: result['release_date'],
                                        description: result['overview'],
                                        movieRating: result['vote_average'],
                                        moviePopularity: result['popularity'])),
                              );
                            },
                            contentPadding: EdgeInsets.all(0),
                            title: Text(
                              '${result['title']}',
                              style: GoogleFonts.libreBaskerville(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
                                  letterSpacing: 2),
                            ),
                            subtitle: Text(
                              'Genre: $genredisplay',
                              style: GoogleFonts.libreBaskerville(
                                fontSize: 15,
                              ),
                            ),
                            leading: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(url),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${result['vote_average']}',
                                  style: GoogleFonts.roboto(
                                      fontSize: 25,
                                      color: Colors.black,
                                      letterSpacing: 2),
                                ),
                                Icon(Icons.star, color: Color(0xffFFD700))
                              ],
                            ),
                          ));
                    }).toList(),
                  );
          }),
    );
  }
}

Future<List> getGenres() async {
  final genrelistreponse = await http.get(Uri.parse(
      'https://api.themoviedb.org/3/genre/movie/list?api_key=671cc24d69d8eebe7bfb34993f69e860&language=en-US'));
  Map genreID = jsonDecode(genrelistreponse.body);
  return genreID['genres'];
}

Future<List> fetchMovies(String year) async {
  final response = await http.get(Uri.parse(
      'https://api.themoviedb.org/3/discover/movie?api_key=671cc24d69d8eebe7bfb34993f69e860&language=en-US&sort_by=popularity.desc&page=$page&year=$year'));
  Map moviesData = jsonDecode(response.body);
  return moviesData['results'];
}
