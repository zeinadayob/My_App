
import 'package:flutter/material.dart';
import 'package:my_app/modules/shop_app/login/login_screen.dart';
import 'package:my_app/shared/components/components.dart';
import 'package:my_app/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class BoardingModel
{
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });

}

class OnBoardingScreen extends StatefulWidget
{
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding=
  [
    BoardingModel(
      image: 'assets/images/onboarder1.jpg',
      title: 'On Board 1 Title ',
      body: 'On Board 1 Body',
    ),
    BoardingModel(
      image: 'assets/images/onboarder1.jpg',
      title: 'On Board 2 Title ',
      body: 'On Board 2 Body',
    ),
    BoardingModel(
      image: 'assets/images/onboarder1.jpg',
      title: 'On Board 3 Title ',
      body: 'On Board 3 Body',
    )
  ];

  var BoardController =PageController();
  bool isLast=false;
  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value){
        navigateAndFinish(context, ShopLogin());
      }
    });

  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: submit,
            child: const Text('SKIP',style: TextStyle(
                color: Colors.blue
            ),
            ),
          )
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Expanded(
              child:
              PageView.builder(
                controller: BoardController,
                itemBuilder: (context,index)=>buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                onPageChanged: (int index)
                {
                  if(index==boarding.length -1)
                  {
                    setState(() {
                      isLast=true;
                    });
                  }
                  else
                  {
                    setState(() {
                      isLast=false;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 40,),
            Row(
              children:  [
                SmoothPageIndicator(
                    controller: BoardController,
                    effect: const ExpandingDotsEffect(
                        dotColor:Colors.blue ,
                        dotHeight: 10,
                        dotWidth: 10,
                        expansionFactor: 4,
                        spacing: 5
                    ),
                    count: boarding.length),
                const Spacer(),
                FloatingActionButton(
                  backgroundColor: Colors.blue,
                  onPressed: ()
                  {
                    if(isLast)
                    {
                      submit();
                    }
                    else
                    {
                      BoardController.nextPage(
                          duration: Duration(
                              milliseconds: 750
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }

                  },
                  child:const Icon(Icons.arrow_forward_ios) ,),
              ],
            ),
          ],
        ),
      ) ,
    );

  }

  Widget buildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:  [
      Expanded(child:
      Image(image: AssetImage('${model.image}'))),
      SizedBox(height: 30,),
      Text('${model.title}',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),),
      SizedBox(height: 20,),
      Text('${model.body}',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),),


    ],
  );
}