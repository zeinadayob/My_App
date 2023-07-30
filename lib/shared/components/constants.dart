
import 'package:my_app/modules/shop_app/login/login_screen.dart';
import 'package:my_app/shared/components/components.dart';
import 'package:my_app/shared/network/local/cache_helper.dart';
void signOut(context){
  CacheHelper.removeData(key: 'token').then((value) {
    if(value){
      navigateAndFinish(context, ShopLogin());
    }});}
String ?token;
String? uId;