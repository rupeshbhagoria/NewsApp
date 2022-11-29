import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_start/provider/news_provider.dart';

class TabBarWidget extends StatelessWidget {
final String query;
TabBarWidget(this.query);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child){
        final newsData= ref.watch(newsProvider(query));
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
            scrollDirection: Axis.horizontal,
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
    );
  }
}
