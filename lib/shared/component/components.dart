import 'package:flutter/material.dart';


Widget defButton({
   double width = double.infinity,
   Color background = Colors.blue,
  @required Function function,
  @required String text,

}) => Container(
    width: width,
    height: 50,
    child: MaterialButton(
      onPressed: function,
      child: Text(text),),
    decoration: BoxDecoration(
  color: background,

    borderRadius: BorderRadius.circular(10),
),
);

Widget defTextForm({

  @required TextEditingController controller,
  @required TextInputType type,
  Function onfeild,
  Function onchange,
  @required  IconData prefix ,
    IconData suf ,
  Function pressed,
  bool ob = true,
  @required String labelTexte,
  Function ontap,

}) => TextFormField(
  validator: (value)
  {
    if( value.isEmpty)
    {
      return 'email not correct';
    }
    return null ;
  },
  controller: controller,
  onChanged:onchange ,
  onFieldSubmitted:onfeild ,
  onTap: ontap,
  keyboardType: type,
  obscureText: ob,
  decoration: InputDecoration(
    labelText: labelTexte,
    border: OutlineInputBorder(),
    prefixIcon: Icon(prefix),
    suffixIcon: IconButton(
      onPressed: pressed,
         icon: Icon(suf),
    ),


  ),
);

Widget buildTaskItem(Map model) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      CircleAvatar(
        radius: 40,
        child: Text('${model['time']}',style: TextStyle(fontSize: 18,color: Colors.white),),
      ),
      SizedBox(width: 10,),
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${model['title']}',style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
          Text('${model['date']}',style: TextStyle(fontSize: 15,color: Colors.black),),
        ],
      ),


    ],


  ),
);

Widget buildArticleItem(article,context) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(
                '${article['urlToImage']}'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      SizedBox(
        width: 20,
      ),
      Expanded(
        child: Container(
          height: 120,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  '${article['title']}',
                  style: Theme.of(context).textTheme.bodyText1,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${article['publishedAt']}',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
);