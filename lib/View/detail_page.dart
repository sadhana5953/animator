import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:provider/provider.dart';

import '../Provider/space_provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});


  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with SingleTickerProviderStateMixin{
  final int count = 9;
  late AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController=AnimationController(vsync: this,
      duration: Duration(seconds: 30),
      lowerBound: 0,
      upperBound: 1,
    );

    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    PlanetProvider planetProvider =
    Provider.of<PlanetProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xff181619),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50,),
                IconButton(onPressed: () {
                  planetProvider.changeScreen(0);
                  animationController.dispose();
                  Navigator.of(context).pop();
                }, icon: Icon(Icons.cancel,color: Colors.white,)),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('\nDistance from sun',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
                          Text('${(planetProvider.planetList[planetProvider.select].distance)} MI KM',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),),

                          Text('\nRadius',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
                          Text('3,390 Kilometers',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),),

                          Text('\nYear',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
                          Text('${planetProvider.planetList[planetProvider.select].orbital_period}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),),

                          Text('\nPlanet type',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
                          Text('Terresrial',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),),

                        ],
                      ),
                      SizedBox(width: 50,),
                      AnimatedBuilder(
                        animation: animationController,
                        builder: (context, child) => RotationTransition(
                          turns: animationController,
                          child: Container(
                            height: 300,
                            width: 300,
                            margin: EdgeInsets.only(left: 50),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                                image: DecorationImage(image: AssetImage(planetProvider.planetList[planetProvider.select].image),fit: BoxFit.cover)
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50,),
                Row(
                  children: [
                    Text('${planetProvider.planetList[planetProvider.select].name}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 50),),
                    Spacer(),
                    IconButton(onPressed: () {
                      setState(() {
                        planetProvider.likedImage(planetProvider.select);
                      });
                    }, icon: Icon(planetProvider.planetList[planetProvider.select].like==true?Icons.favorite:Icons.favorite_border,color: Colors.white,)),
                    IconButton(onPressed: () {

                    }, icon: Icon(Icons.download_for_offline_outlined,color: Colors.white,)),
                  ],
                ),
                Text('${planetProvider.planetList[planetProvider.select].subtitle}\n',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),),
                Text('${planetProvider.planetList[planetProvider.select].description} ${planetProvider.planetList[planetProvider.select].description}',style: TextStyle(color: Colors.white54,fontWeight: FontWeight.w500,fontSize: 15),overflow: TextOverflow.fade),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

bool? like;