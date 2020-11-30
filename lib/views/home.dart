import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getnews/helper/data.dart';
import 'package:getnews/helper/news.dart';
import 'package:getnews/model/article_model.dart';
import 'package:getnews/model/category_model.dart';
import 'package:getnews/mydrawer.dart';
import 'package:getnews/views/article.dart';
import 'package:getnews/views/categorynews.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
  News newsClass = News();
  await newsClass.getNews();
  articles = newsClass.news;
  setState(() {
    _loading = false;
  });
  }

  Future <bool> _onBackPressed(){
    return showDialog(
        context: context,
        builder: (context)=>AlertDialog(
          title:Text("Do You Really Want to Exit ??",
            style: TextStyle(
              fontFamily: "Nunito",
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("No",
                style: TextStyle(
                  fontFamily: "Nunito",
                ),
              ),
              onPressed: ()=>Navigator.pop(context,false),
            ),
            FlatButton(
              child: Text("Yes",style: TextStyle(
                fontFamily: "Nunito",
              ),
              ),
              onPressed: ()=> exit(0),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            padding: EdgeInsets.only(right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Look",style: TextStyle(fontSize: 25, fontFamily: "Quando"),),
                Text("News", style: TextStyle(color: Colors.red, fontSize:25, fontFamily: "Quando"),)
              ],
            ),
          ),
          elevation: 0.0,
        ),
        drawer: MyDrawer(),
        body:_loading ? Center(
          child: Container(
            child: CircularStepProgressIndicator(
              totalSteps: 8,
              currentStep: 5,
              width: 60,
              height: 60,
            ),
          ),
        ): SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 80,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: categories.length ,itemBuilder: (context, index){
                          return CategoryTile(
                            imageUrl: categories[index].imageUrl,
                            categoryName: categories[index].categoryName,
                          );
                    }),
                  ),

                  //BlogTiles
                  SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(top: 16),
                      child: ListView.builder(
                          itemCount: articles.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                         scrollDirection: Axis.vertical,
                          itemBuilder: (context, index){
                         return BlogTile(
                          imageUrl: articles[index].urlToImage,
                          title: articles[index].title,
                          desc: articles[index].description,
                          url: articles[index].url,
                         );
                      }),
                    ),
                  )
                ],
              ),
            ),
        ),
        ),
    );
  }
}

class CategoryTile extends StatelessWidget {

  final String imageUrl, categoryName;
  CategoryTile({this.imageUrl,this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => Category(
            category: categoryName.toLowerCase(),
          )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 14),
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius:BorderRadius.circular(10),
                child: CachedNetworkImage(imageUrl: imageUrl, width: 140, height: 80, fit: BoxFit.cover,)),
            Container(
              alignment: Alignment.center,
              width: 140, height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black26,
              ),
              child: Text(
                categoryName, style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: "Quando",
                fontWeight: FontWeight.w800,
              ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


class BlogTile extends StatelessWidget {

  final String imageUrl, title, desc, url;
  BlogTile({@required this.imageUrl, @required this.title, @required this.desc,@required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => Article(
              blogUrl: url,
            )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 14),
        child: Column(
          children: <Widget>[
            ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(imageUrl)),
            SizedBox(height: 6,),
            Text(title,style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontFamily: "Quando",
              fontSize: 18,
            ),),
            SizedBox(height: 6,),
            Text(desc, style: TextStyle(
              color: Colors.black26,
              fontFamily: "nunitoBold"
            ),),
          ],
        ),
      ),
    );
  }
}
