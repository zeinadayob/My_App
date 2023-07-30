import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/modules/shop_app/login/cubite/cubite.dart';
import 'package:my_app/modules/shop_app/login/cubite/states.dart';
import 'package:my_app/modules/shop_app/register/register_screen.dart';
import 'package:my_app/shared/components/components.dart';
import 'package:my_app/shared/components/constants.dart';
import 'package:my_app/shared/network/local/cache_helper.dart';

import '../../../layout/shop_app/shop_layout.dart';


class ShopLogin extends StatelessWidget {
  ShopLogin({Key? key}) : super(key: key);
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var passwordController=TextEditingController();
    return BlocProvider(
      create: (BuildContext context)=> ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginState>(
        listener:(context,state){
          if( state is ShopLoginSuccssState) {
            if(state.loginModel.status==true){
              print(state.loginModel.message);
              CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token).then((value)  {
                token= state.loginModel.data!.token!;
                navigateAndFinish(context, ShopLayout());
              });
            }
            else{
              print(state.loginModel.message);
              showToast(
                  text: state.loginModel.message!,
                  state: ToastStates.ERROR
              );
            }

          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Text
                          (
                            'LOGIN',
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                                color: Colors.black
                            )
                        ),
                        Text
                          (
                            'Login now to browser our hot offers',
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                                color: Colors.grey
                            )
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField
                          (
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validator: (String? value)
                          {
                            if(value!.isEmpty)
                            {
                              return'please enter your email address';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(height: 15,),
                        defaultFormField
                          (
                          controller: passwordController,
                          type: TextInputType.visiblePassword,

                          onSubmit: (value)
                          {
                            if(formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          isPassword:ShopLoginCubit.get(context).isPassword ,
                          suffixpressed: (){
                            ShopLoginCubit.get(context).changePasswordVisibility();
                          },
                          validator: (String? value)
                          {
                            if(value!.isEmpty)
                            {
                              return'password is too short';
                            }
                            return null;
                          },
                          label: 'Password',
                          prefix: Icons.lock_outlined,
                          suffix:ShopLoginCubit.get(context).suffix ,

                        ),
                        const SizedBox(height: 30,),
                        ConditionalBuilder(
                          condition: true,
                          builder:(context) => defaultButton(
                            function: ()
                            {
                              if(formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }

                            }

                            ,
                            text: 'login',
                            isUpperCase: true,
                          ),

                          fallback:(context) => Center(child: CircularProgressIndicator()) ,

                        ),
                        const SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            const Text
                              (
                                'Don\'t have an account?'
                            ),
                            TextButton(onPressed: ()
                            {
                              navigateTo(context, RegisterShop());
                            }, child:  Text(
                              'Register Now',
                              style: TextStyle(
                                  color: Colors.blue
                              ),
                            )),

                          ],
                        )

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}
