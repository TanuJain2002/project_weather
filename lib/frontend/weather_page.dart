import 'dart:developer';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:project_weather/constants.dart';
import 'package:project_weather/backend/weather_model.dart';
import 'package:project_weather/backend/call_to_api.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();

  getData() {}
}

class _WeatherPageState extends State<WeatherPage> {
  Future<WeatherModel> getData(bool isCurrentCity, String cityName) async {
    return await CallToApi().callWeatherAPi(isCurrentCity, cityName);
  }

  TextEditingController textController = TextEditingController(text: "");
  Future<WeatherModel>? _myData;
  @override
  void initState() {
    setState(() {
      _myData = getData(true, "");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: FutureBuilder(
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If error occured
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error.toString()} occurred',
                  style: TextStyle(fontSize: 18),
                ),
              );

              // if data has no errors
            } else if (snapshot.hasData) {
              // Extracting data from snapshot object
              final data = snapshot.data as WeatherModel;
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(0.8, 1),
                    colors: <Color>[
                      Color.fromARGB(255, 35, 180, 9),
                      Color.fromARGB(255, 151, 219, 49),
                      Color.fromARGB(255, 241, 11, 22),
                      Color.fromARGB(255, 240, 91, 185),
                      Color.fromARGB(255, 224, 44, 176),
                    ],
                    tileMode: TileMode.mirror,
                  ),
                ),
                width: double.infinity,
                height: double.infinity,
                child: SafeArea(
                  child: Column(
                    children: [
                      AnimSearchBar(
  rtl: true,
  width: 400,
  color: Color.fromARGB(255, 227, 39, 121),
  textController: textController,
  suffixIcon: Icon(
    Icons.search,
    color: const Color.fromARGB(255, 7, 0, 0),
    size: 26,
  ),
  onSubmitted: (value) {
    if (value.isEmpty) {
      log("No city entered");
    } else {
      setState(() {
        _myData = getData(false, value);
      });
    }
    FocusScope.of(context).unfocus();
    textController.clear();
  },
  onSuffixTap: () async {
                          textController.text == ""
                              ? log("No city entered")
                              : setState(() {
                                  _myData = getData(false, textController.text);
                                });

                          FocusScope.of(context).unfocus();
                          textController.clear();
                        },
  
  style: f14RblackLetterSpacing2,
),
                      // AnimSearchBar(
                      //   rtl: true,
                      //   width: 400,
                      //   color: Color(0xffffb56b),
                      //   textController: textController,
                      //   suffixIcon: Icon(
                      //     Icons.search,
                      //     color: Colors.black,
                      //     size: 26,
                      //   ),
                      //   onSuffixTap: () async {
                      //     textController.text == ""
                      //         ? log("No city entered")
                      //         : setState(() {
                      //             _myData = getData(false, textController.text);
                      //           });

                      //     FocusScope.of(context).unfocus();
                      //     textController.clear();
                      //   },
                      //   style: f14RblackLetterSpacing2,
                      // ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              data.city,
                              style: f24Rwhitebold,
                            ),
                            height25,
                            Text(
                              data.desc,
                              style: f16PW,
                            ),
                            height25,
                            Text(
                              "${data.temp}°C",
                              style: f42Rwhitebold,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Text("${snapshot.connectionState} occured"),
            );
          }
          return Center(
            child: Text("Server timed out!"),
          );
        },
        future: _myData!,
      ),
    );
  }
}