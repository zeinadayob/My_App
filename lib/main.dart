


import 'package:desktop_window/desktop_window.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/desktop.dart';
import 'package:my_app/layout/News_app/News_Layout.dart';
import 'package:my_app/layout/shop_app/cubite/cubite.dart';
import 'package:my_app/layout/shop_app/shop_layout.dart';
import 'package:my_app/layout/social_app/cubite/cubite.dart';
import 'package:my_app/layout/social_app/social_layout.dart';
import 'package:my_app/mobile.dart';
import 'package:my_app/modules/native_code.dart';
import 'package:my_app/modules/shop_app/login/login_screen.dart';
import 'package:my_app/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:my_app/modules/social_app/social_login/social_login_screen.dart';
import 'package:my_app/shared/components/components.dart';
import 'package:my_app/shared/components/constants.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'layout/News_app/Cubit/cubite.dart';
import 'shared/bloc_observe.dart';
import 'shared/cubites/cubite.dart';
import 'shared/cubites/states.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/remote/dio_helper.dart';
import 'shared/stayles/stayles.dart';
//Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
//{
 // print('on message background ');
 // showToast(text: 'on message background', state: ToastStates.SUCCESS);
//}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DesktopWindow.setMinWindowSize(const Size(650, 650));

 // await Firebase.initializeApp();
 // var token= FirebaseMessaging.instance.getToken();
 // print(token);
  //FCM MESSAGING//
  //ونحنا فاتحين على التطبيق ومنستقبل
 // FirebaseMessaging.onMessage.listen((event)
 // {
  //  print(event.data.toString());
  //  showToast(text: 'on message', state: ToastStates.SUCCESS);
//  });
  //ونحنا قافلين التطبيق و بالخلفية شغال و منستقبل
//  FirebaseMessaging.onMessageOpenedApp.listen((event)
//  {
 //   print(event.data.toString());
 //   showToast(text: 'on message opened app', state: ToastStates.SUCCESS);
//  });
  //لما يكون التطبيق مغلق سواء بالخلفية او نهائيا
//  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
 // bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  Widget ? widget;
 String? token = CacheHelper.getData(key: 'token');
   uId=CacheHelper.getData(key:'uId');
  // print(onBoarding);
  //if(onBoarding != null){
  //if(token!=null) widget= ShopLayout();
  //else widget=ShopLogin();
  //} else {
  // widget= OnBoardingScreen();
  //}
  if(uId!=null){
    widget=const SocialLayout();
  }
  else{
    widget=SocialLoginScreen();
  }

  runApp(MyApp(
      isDark,
      widget
  ));
}

class MyApp extends StatelessWidget
{
  final bool ? isDark;
  final Widget startWidget;
  MyApp(this.isDark,this.startWidget, {super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(

      providers: [
        BlocProvider(create: (context)=> NewsCubit()..getBusiness()..getScience()..getSports(),),
        BlocProvider(
          create: (BuildContext context) => AppCubit()..changeAppMode(fromShared:isDark),),
        BlocProvider(
            create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData()),
        BlocProvider(
            create: (BuildContext context) => SocialCubit()..getUserData()..getPosts()),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener:(context,state) {} ,
        builder: (context,state) {
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            //AppCubit.get(context).isDark ? ThemeMode.dark :
            themeMode: ThemeMode.light,
            home: Builder(builder: (BuildContext context){

              MediaQuery.of(context).size.width;
              if(MediaQuery.of(context).size.width.toInt() <= 560)
                return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaleFactor: 0.5
                    ),
                    child: MobileScreen());
              return DesktopScreen();
            })
          );
        },
      ),
    );
  }
}
