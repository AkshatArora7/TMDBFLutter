import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/screens/screen2.dart';

class screen1 extends StatefulWidget {
  const screen1({Key? key}) : super(key: key);

  @override
  _screen1State createState() => _screen1State();
}

class _screen1State extends State<screen1> {
  TextEditingController yearText = TextEditingController();
  final _yearFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    getGenres().then((value) {
      setState(() {
        genre=value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 50),
            // width: _screenWidth / 5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Text(
                    'Year*',
                    style: GoogleFonts.libreBaskerville(
                        decoration: TextDecoration.none,
                        fontSize: 20,
                        color: Colors.black),
                  ),
                ),
                Container(
                    width: 150,
                    child: Material(
                        color: Colors.transparent,
                        child: Form(
                          key: _yearFormKey,
                          child: TextFormField(
                            controller: yearText,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Why Empty';
                              }
                              if (value.length < 4) {
                                return 'Not valid';
                              }
                              if (!RegExp(r"^(18|19|20)[0-9][0-9]")
                                  .hasMatch(value)) {
                                return 'Only after 1800';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            maxLength: 4,
                            style:
                                GoogleFonts.libreBaskerville(letterSpacing: 2),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: '2020',
                                hintStyle: GoogleFonts.libreBaskerville(
                                    letterSpacing: 2)),
                          ),
                        )))
              ],
            ),
          ),
          RaisedButton(
            color: Colors.teal,
            onPressed: () {
              if (_yearFormKey.currentState!.validate()) {
                _yearFormKey.currentState!.save();
                String year=yearText.text;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (myContext) => screen2(
                            yearInput: year,
                          )),
                );
              }else{
              }
            },
            padding: const EdgeInsets.all(10),
            child: Text(
              'Get Movies',
              style: GoogleFonts.libreBaskerville(letterSpacing: 2),
            ),
          )
        ],
      ),
    );
  }
}
