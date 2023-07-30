import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/layout/shop_app/cubite/cubite.dart';
import 'package:my_app/layout/shop_app/cubite/state.dart';
import 'package:my_app/shared/components/components.dart';
import 'package:my_app/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  var formKey =GlobalKey<FormState>();
  var emailController =TextEditingController();
  var nameController =TextEditingController();
  var phoneController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state)
      {
      },
      builder: (context,state){

        var model = ShopCubit.get(context);
        nameController.text= model.userModel!.data!.name!;
        emailController.text= model.userModel!.data!.email!;
        phoneController.text= model.userModel!.data!.phone!;
        return ConditionalBuilder(
          condition:
          ShopCubit.get(context).userModel !=null,
          builder: (context)=> Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if(state is  ShopLoadingUpdateUserState)
                    LinearProgressIndicator(),
                  const SizedBox(height: 20,),
                  defaultFormField(
                    controller: nameController,
                    validator: (String? value){
                      if(value!.isEmpty)
                      {
                        return'name must not empty';
                      }
                      return null;
                    },
                    label: 'User Name',
                    prefix: Icons.person,
                  ),
                  const SizedBox(height: 20,),
                  defaultFormField(
                      controller: emailController,
                      validator: (String? value)
                      {
                        if(value!.isEmpty) {
                          return 'please enter your email address';
                        }
                        return null;
                      },
                      label:'Email Address',
                      prefix: Icons.email
                  ),
                  const SizedBox(height: 20,),
                  defaultFormField(
                      controller: phoneController,
                      validator: (String? value)
                      {
                        if(value!.isEmpty)
                        {
                          return'please enter your phone';
                        }
                        return null;
                      },
                      label: 'User Phone',
                      prefix: Icons.phone
                  ),
                  const SizedBox(height: 20,),
                  defaultButton(
                      function: ()
                      {
                        if(formKey.currentState!.validate())
                        {
                          ShopCubit.get(context).updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text);
                        }
                      },
                      text: 'Update'),
                  const SizedBox(height: 20,),
                  defaultButton(
                      function: ()
                      {
                        signOut(context);
                      },
                      text: 'Login')
                ],
              ),
            ),
          ) ,
          fallback: (context)=> Center(child: CircularProgressIndicator()),

        );
      },
    );
  }
}