import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_screen/layout/cubit/cubit.dart';
import 'package:login_screen/layout/cubit/state.dart';
import 'package:login_screen/shared/component/components.dart';

class SportsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsState>(
      listener: (context,state){},
      builder: (context,state)
      {
        var list = NewsCubit.get(context).Sports;
        return ConditionalBuilder(
          condition: list.length > 0,
          builder: (context)=>ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context,index)=> buildArticleItem(list[index],context),
            separatorBuilder: (context,index)=> Container(width: double.infinity,height: 1,color: Colors.grey,),
            itemCount: 10,
          ),
          fallback: (context)=> Center(child: CircularProgressIndicator()),
        );
      },

    );
  }
}
