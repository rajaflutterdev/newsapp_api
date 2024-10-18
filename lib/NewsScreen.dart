

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'const.dart';
import 'modelClass/newsResponeClass.dart';

class textScreen extends StatefulWidget {
  const textScreen({super.key});

  @override
  State<textScreen> createState() => _textScreenState();
}

class _textScreenState extends State<textScreen> {



  Future<NewsResponse> fetchNews() async {
    String language='en';
    // Get today's date and the date from three days ago
    final DateTime now = DateTime.now();
    final DateTime threeDaysAgo = now.subtract(const Duration(days: 3));
    // Format the dates to YYYY-MM-DD
    final String toDate = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    final String fromDate = '${threeDaysAgo.year}-${threeDaysAgo.month.toString().padLeft(2, '0')}-${threeDaysAgo.day.toString().padLeft(2, '0')}';
    final url1="https://newsapi.org/v2/everything?q=Tamil%20Nadu&language=$language&from=$fromDate&to=$toDate&apiKey=eac47f191af34467a51de375fa6e0ba3";
    //final url2 = 'https://newsapi.org/v2/everything?q=tesla&from=2024-09-18&sortBy=publishedAt&apiKey=eac47f191af34467a51de375fa6e0ba3';
    final response = await http.get(Uri.parse(url1));

    if (response.statusCode == 200) {
      return NewsResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load news');
    }

  }


  Future<void> _launchUrl(_url) async {
    // final Uri url = Uri.parse(_url);
    if (!await launchUrl(Uri.parse(_url),mode: LaunchMode.platformDefault)) {
      throw Exception('Could not launch $_url');
    }
  }


  var TodatDate=DateFormat('dd-MM-yyyy').format(DateTime.now());

  var TodatTime=DateFormat('hh:mm:a').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        title:
      Text('News',style: GoogleFonts.poppins(fontSize: mediaQueryClass.width(inputValue: 18,context: context),fontWeight: FontWeight.w600),),

      ),
      body: FutureBuilder<NewsResponse>(
        future: fetchNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.articles.isEmpty) {
            return const Center(child: Text('No news available'));
          }

          final articles = snapshot.data!.articles;

          return ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) => const Divider(thickness: 0.8,),
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return Padding(
                padding:  EdgeInsets.only(
                  top: mediaQueryClass.height(inputValue: 35,context: context),
                  bottom: mediaQueryClass.height(inputValue: 35,context: context),
                  left: mediaQueryClass.width(inputValue: 30,context: context),
                  right: mediaQueryClass.width(inputValue: 30,context: context),


                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.white,boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 2,
                        offset: Offset(1, 1),
                        blurRadius: 2
                    )
                  ],
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: ListTile(

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height:  mediaQueryClass.height(inputValue: 100,context: context),),

                        Text(article.title.toString(),style:
                        GoogleFonts.actor(fontSize: mediaQueryClass.width(inputValue: 20,context: context),fontWeight: FontWeight.w900),),
                        SizedBox(height:  mediaQueryClass.height(inputValue: 100,context: context),),
                        Text(article.description.toString(),style: GoogleFonts.poppins(fontSize: mediaQueryClass.width(inputValue: 25,context: context),fontWeight: FontWeight.w600),),
                        Text("${TodatDate.toString()} ${TodatTime.toString()}",style: GoogleFonts.poppins(fontSize: mediaQueryClass.width(inputValue: 35,context: context),fontWeight: FontWeight.normal),),
                      ],
                    ),
                    title: CachedNetworkImage(
                      imageUrl: (article.urlToImage .toString()),
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>   SizedBox(
                          height:mediaQueryClass.height(inputValue: 8.76,context: context),
                          width: mediaQueryClass.height(inputValue: 4.11,context: context),
                          child: const Center(
                            child:  CircularProgressIndicator(
                              color: Colors.red,
                            ),
                          )),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                    onTap: () {
                      _launchUrl(article.url.toString());
                      // You can navigate to the article's URL if needed
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleDetail(url: article.url)));
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}