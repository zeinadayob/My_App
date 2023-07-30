import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/adaptive/adaptive.dart';

class MobileScreen extends StatelessWidget {
  const MobileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
             width: double.infinity,
              color: Colors.teal,
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Text(
                    'Login Now',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email Address',

                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',

                    ),
                  ),
                  const SizedBox(height: 40,),
                  Row(
                    children:
                    [
                      Expanded(
                        child: Container(
                          color: Colors.teal,
                          height: 45,
                          child: MaterialButton(
                            onPressed: (){},
                            child:const Text(
                              'LOGIN',
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ) ,),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Container(
                          color: Colors.blueAccent,
                          height: 45,
                          child: MaterialButton(
                            onPressed: (){},
                            child:const Text(
                              'REGISTER',
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ) ,),
                        ),
                      ),

                    ],
                  ),
                  const SizedBox(height: 40,),
                  Center(
                    child: AdaptiveIndicator(os: 'And',),
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
