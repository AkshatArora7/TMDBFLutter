import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class screen3 extends StatefulWidget {
  final String movieTitle;
  final String movieURL;
  final String releaseDate;
  final String description;
  final double movieRating;
  final double moviePopularity;

  const screen3(
      {Key? key,
      required this.movieTitle,
      required this.movieURL,
      required this.releaseDate,
      required this.description,
      required this.movieRating,
      required this.moviePopularity})
      : super(key: key);

  @override
  _screen3State createState() => _screen3State();
}

class _screen3State extends State<screen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movieTitle),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                width: 200,
                height: 400,
                child: Image.network(
                    'https://image.tmdb.org/t/p/original${widget.movieURL}'),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Release Date: ' + widget.releaseDate,
                    style: GoogleFonts.libreBaskerville(
                        letterSpacing: 2,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'Movie Rating: ' '${widget.movieRating}',
                    style: GoogleFonts.libreBaskerville(
                        letterSpacing: 2,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'Movie Popularity: ' '${widget.moviePopularity}',
                    style: GoogleFonts.libreBaskerville(
                        letterSpacing: 2,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: Text(
              'Description',
              style: GoogleFonts.libreBaskerville(
                  letterSpacing: 2, fontSize: 30, fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            margin: EdgeInsets.all(25),
            child: Text(
              widget.description,
              style: GoogleFonts.libreBaskerville(fontSize: 15, wordSpacing: 2),
            ),
          ),
        ],
      ),
    );
  }
}
