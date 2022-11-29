
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_start/provider/news_provider.dart';
import 'package:project_start/widgets/tab_bar_widget.dart';
class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 15,
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: TabBar(
            indicatorColor: Colors.red,
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.black,
            labelStyle: TextStyle(fontSize: 18),
            tabs: [
              Tab(
                text: ('Hollywood'),
              ),
              Tab(
                text: ('Gaming'),
              ),
              Tab(
                text: ('Olyampic'),
              ),
            ],
          ),
        ),
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 250,

                child: TabBarView(
                  children:[
                    TabBarWidget('hollywood'),
                    TabBarWidget('gaming'),
                    TabBarWidget('olyampic'),

        ]
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Expanded(child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Search News',
                        contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                        border: OutlineInputBorder()
                      ),
                    ),
                    Container(
                      height: 200,
                      child: Consumer(
                          builder: (context, ref, child){
                            final newsData= ref.watch(searchNewsProvider);
                            print(newsData);
                            return newsData.isEmpty ? Container(
                              height: 500,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.purple,
                                ),
                              ),
                            ): Container(
                                height: 400,
                                width: double.infinity,
                                // child: Text(query),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                    itemCount: newsData.length,
                                    itemBuilder: (context, index){
                                      return Container(
                                          padding: EdgeInsets.all(5),
                                          margin: EdgeInsets.only(right: 10),
                                          height: 150,
                                          width: 300,

                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: CachedNetworkImage(
                                                  errorWidget: (ctx, string, stk){
                                                    return Image.asset('assets/images/noimage.png');
                                                  },
                                                  imageUrl: newsData[index].media,
                                                  height: 150,
                                                  width: 300,
                                                  fit: BoxFit.cover,),
                                              ),
                                              SizedBox(height: 10,),
                                              Text(newsData[index].title, maxLines: 2,),
                                              SizedBox(height: 5,),
                                              Text(newsData[index].published_date)
                                            ],

                                          )
                                      );

                                    }
                                )
                            );
                          }
                      ),
                    ),
                  ],
                ),
                ),
              )
            ],
          ),
      ),
    );
  }
}
