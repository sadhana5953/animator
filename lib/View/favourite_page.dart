import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/space_provider.dart';
import 'detail_page.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    PlanetProvider planetProvider =
    Provider.of<PlanetProvider>(context);
    return  Scaffold(
      body: Center(child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(image: NetworkImage('https://images.unsplash.com/photo-1628498188904-036f5e25e93e?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8c3RhcnJ5JTIwc2t5fGVufDB8fDB8fHww',),fit: BoxFit.cover,opacity: 0.5)
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15,top: 60,bottom: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(onPressed: () {
                    planetProvider.changeScreen(0);
                    Navigator.of(context).pop();
                  }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
                  Text('Favorite Screen',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: planetProvider.favouriteList.length,
                  itemBuilder: (context, index) =>
                      Container(
                        height: 80,
                        width: 300,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border:Border.all(color: Colors.white,width: 2),
                        ),
                        child:
                        ListTile(
                          onTap: () {
                            for(int i=0;i<planetProvider.planetList.length;i++)
                            {
                              if(planetProvider.planetList[i].name==planetProvider.favouriteList[index].name)
                              {
                                planetProvider.select=i;
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage(),));
                              }
                            }
                          },
                          leading: Image.asset(planetProvider.favouriteList[index].image),
                          trailing: IconButton(onPressed: () {
                            planetProvider.removeLiked(index, planetProvider.favouriteList[index].name);
                          }, icon: Icon(Icons.delete_outline,color: Colors.white,size: 30,)),
                          title: Text('${planetProvider.favouriteList[index].name}',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),
                          subtitle: Text('${planetProvider.favouriteList[index].subtitle}',style: TextStyle(color: Colors.white60,fontSize: 17,fontWeight: FontWeight.w500),),
                        ),
                      ),),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
