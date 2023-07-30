import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/layout/shop_app/shop_layout.dart';
import 'package:my_app/modules/shop_app/register/cubite/cubite.dart';
import 'package:my_app/modules/shop_app/register/cubite/states.dart';
import 'package:my_app/shared/components/components.dart';
import 'package:my_app/shared/network/local/cache_helper.dart';

import '../../../shared/components/constants.dart';

class RegisterShop extends StatelessWidget {
  RegisterShop({Key? key}) : super(key: key);
  var formKey= GlobalKey<FormState>();
  var emailController =TextEditingController();
  var phoneController =TextEditingController();
  var nameController =TextEditingController();
  var passwordController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (BuildContext context)=> ShopRegisterCubit(),
        child: BlocConsumer<ShopRegisterCubit,ShopRegisterState>(
          listener: (context,state){
            if( state is ShopRegisterSuccssState) {
              if(state.loginModel.status!){
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
                              'REGISTER',
                              style: Theme.of(context).textTheme.headline4!.copyWith(
                                  color: Colors.black
                              )
                          ),
                          Text
                            (
                              'Register now to browser our hot offers',
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  color: Colors.grey
                              )
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          defaultFormField
                            (
                            controller: nameController,
                            type: TextInputType.name,
                            validator: (String? value)
                            {
                              if(value!.isEmpty)
                              {
                                return'please enter your name';
                              }
                              return null;
                            },
                            label: 'User Name',
                            prefix: Icons.person,
                          ),
                          const SizedBox(height: 15,),
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
                            },
                            isPassword:ShopRegisterCubit.get(context).isPassword ,
                            suffixpressed: (){
                              ShopRegisterCubit.get(context).changePasswordVisibility();
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
                            suffix:ShopRegisterCubit.get(context).suffix ,
                          ),
                          const SizedBox(height: 15,),
                          defaultFormField
                            (
                            controller: phoneController,
                            type: TextInputType.phone,
                            validator: (String? value)
                            {
                              if(value!.isEmpty)
                              {
                                return'please enter your phone';
                              }
                              return null;
                            },
                            label: 'Phone',
                            prefix: Icons.phone,
                          ),
                          const SizedBox(height: 30,),
                          ConditionalBuilder(
                            condition: state is! ShopRegisterLoadingState,
                            builder:(context) => defaultButton(
                              function: ()
                              {
                                if(formKey.currentState!.validate()) {
                                  ShopRegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text

                                  );
                                }

                              }

                              ,
                              text: 'register',
                              isUpperCase: true,
                            ),

                            fallback:(context) => Center(child: CircularProgressIndicator()) ,

                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        )
    );
  }
}