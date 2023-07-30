import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/layout/social_app/social_layout.dart';
import 'package:my_app/modules/social_app/social_login/cubite/cubit.dart';
import 'package:my_app/modules/social_app/social_login/cubite/states.dart';
import 'package:my_app/modules/social_app/social_register/social_register_screen.dart';
import 'package:my_app/shared/components/components.dart';
import 'package:my_app/shared/network/local/cache_helper.dart';

class SocialLoginScreen extends StatelessWidget {
  SocialLoginScreen({Key? key}) : super(key: key);
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var passwordController=TextEditingController();
    return BlocProvider(
      create: (BuildContext context)=> SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginState>(
        listener: (context,state){
          if(state is SocialLoginErrorState){
            showToast(text: state.error, state: ToastStates.ERROR);
          }
          if(state is SocialLoginSuccssState){
            CacheHelper.saveData(
                key: 'uId',
                value: state.uId).then((value) {
                  navigateAndFinish(context, SocialLayout());
            });
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
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black
                          ),

                        ),
                        SizedBox(height: 15,),
                        Text(
                          'Login now to communicate with friends',
                          style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: Colors.grey
                          ),

                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          controller:emailController,
                          validator:(String? value)
                          {
                            if(value!.isEmpty){
                              return 'please enter your email address';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,

                        ),
                        const SizedBox(height: 15,),
                        defaultFormField(
                            controller:passwordController,
                            isPassword:SocialLoginCubit.get(context).isPassword ,
                            suffixpressed: (){
                              SocialLoginCubit.get(context).changePasswordVisibility();
                            },
                            onSubmit: (value)
                            {
                              if(formKey.currentState!.validate()) {
                              }
                            },
                            validator:(String? value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'please enter your email address';
                              }
                              return null;
                            },
                            label: 'Password',
                            prefix: Icons.lock_outlined,
                            suffix: Icons.visibility_outlined

                        ),
                        const SizedBox(
                          height:30,
                        ),
                        ConditionalBuilder(
                          condition: true,
                          builder:(context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate())
                              {
                                SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },      text: 'login',
                            isUpperCase: true,
                          ),
                          fallback:(context) => const Center(child: CircularProgressIndicator()) ,),
                        const SizedBox(height: 15,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text
                              (
                                'Don\'t have an account?'
                            ),
                            TextButton(onPressed: ()
                            {
                              navigateTo(context, SocialRegister());
                            }, child:  const Text(
                              'Register Now',
                              style: TextStyle(
                                  color: Colors.blue
                              ),
                            )),

                          ],
                        ),
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