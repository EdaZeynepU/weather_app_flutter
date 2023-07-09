import 'package:flutter/material.dart';
import 'weather.dart';

class WherePage extends StatefulWidget {
  const WherePage({Key? key}) : super(key: key);

  @override
  State<WherePage> createState() => _WherePageState();
}



class _WherePageState extends State<WherePage> {
  String cityName="";

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image:
                DecorationImage(image: AssetImage("images/bglight.jpg"),fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 50,),
            Container(
              height: 120,
              width: 300,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.white60,borderRadius: BorderRadius.circular(10),),
              child: const Text("Enter the Name of City:",style: TextStyle(fontSize: 35),textAlign: TextAlign.center),
            ),
            Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                       Container(
                        decoration: const BoxDecoration(color: Colors.white60),
                        width: 200,
                        padding: const EdgeInsets.only(left: 15,right: 15),
                        child: TextField(
                          onChanged: (value){
                            cityName=value;
                          },
                          decoration: const InputDecoration(
                              hintText: 'City Name is...',
                          ),
                        ),
                      ),
                  const SizedBox(width: 5),
                  ElevatedButton(onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Weather(cityName:cityName)),
                    );
                    if (result == "invalid"){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Sorry, I can\'t understand where?'),
                            content: const Text('The city name is invalid. Please enter an existing place'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }, child: const Text("go")),
              ]
            ),

             const SizedBox(height: 100,),
          ],
        ),
      ),
    );
  }
}
