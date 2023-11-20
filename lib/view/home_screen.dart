import 'package:flutter/material.dart';
import 'package:flutter_application_4/controller/home_screen_controller.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<HomeScreenController>(context, listen: false).fetchMovie();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeScreenController>(context);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Movies"),
        actions: [
          TextButton.icon(
              onPressed: () {
                scaffoldKey.currentState!.openEndDrawer();
              },
              icon: Icon(
                Icons.info_outline,
                color: Colors.brown,
              ),
              label: Text(
                "Company info",
                style: TextStyle(color: Colors.brown),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: provider.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: provider.movies?.result?.length,
                itemBuilder: (context, index) {
                  final movie = provider.movies?.result?[index];
                  var releaseDate = DateTime.fromMicrosecondsSinceEpoch(
                      movie?.releasedDate ?? 0);
                  return Column(
                    children: [
                      Container(
                        height: 160,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.arrow_drop_up_sharp,
                                            size: 50,
                                          ),
                                          Text(
                                            movie?.totalVoted.toString() ?? "",
                                            style: TextStyle(fontSize: 25),
                                          ),
                                          Icon(
                                            Icons.arrow_drop_down,
                                            size: 50,
                                          ),
                                          Text("Votes")
                                        ],
                                      ),
                                      Expanded(
                                        child: Card(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(movie
                                                            ?.poster ??
                                                        "https://t3.ftcdn.net/jpg/03/34/83/22/360_F_334832255_IMxvzYRygjd20VlSaIAFZrQWjozQH6BQ.jpg"))),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            Expanded(
                                flex: 3,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        movie?.title ?? "",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.libreBaskerville(
                                            fontSize: 19),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text.rich(TextSpan(
                                          text: "Genere:",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                          children: [
                                            TextSpan(
                                                text: movie?.genre,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal))
                                          ])),
                                      Text.rich(TextSpan(
                                          text: "Director:",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                          children: List.generate(
                                              movie?.director?.length ?? 1,
                                              (index) => TextSpan(
                                                  text: movie?.director?[index],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black))))),
                                      Text.rich(
                                        TextSpan(
                                            text: "Starring:",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold),
                                            children: List.generate(
                                                movie?.stars?.length ?? 1,
                                                (index) => TextSpan(
                                                    text: movie?.stars?[index],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.black)))),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                              "${movie?.runTime ?? ""} Mins |"),
                                          Text(" ${movie?.language} |"),
                                          Text(
                                              "${releaseDate.day} ${getMonthName(releaseDate.month)}")
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("${movie?.pageViews} views |"),
                                          Text(
                                              " voted by ${movie?.totalVoted} prople |"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 35,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            "Watch Trailer",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Divider()
                    ],
                  );
                }),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 100,
              child: Center(
                  child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/logo.png"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Company information',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              )),
              decoration: BoxDecoration(
                color: Colors.brown,
              ),
            ),
            ListTile(
              title: Text(
                'Company: Geeksynergy Technologies Pvt Ltd\n'
                'Address: Sanjayanagar, Bengaluru-56\n'
                'Phone: XXXXXXXXX09\n'
                'Email: XXXXXX@gmail.com',
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getMonthName(int month) {
    const List<String> monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return monthNames[month - 1];
  }
}
