import 'package:google_generative_ai/google_generative_ai.dart';
import 'database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SendRequest{
  final FirestoreService firestoreService=FirestoreService();

  final apiKey = 'AIzaSyDgzWEoGck8n2sf8cAfAKp0VTJVLdV9vwM';

  Future<String?> getreq(prompt) async{
    final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);

    String? res=response.text;
    return res;
  }
  Future<List<String>> getid(id,classification,type,color,description)async{
    List<String> secondIds = [];
    if (classification.toLowerCase()=='upper wear'){


      firestoreService.getUpperwearData('lower wear').then((data)async {
        // print(data);
        String ids='';

        String? response='';
        String format='id : original cloth ,id : matched cloth1 ';


        String txt='I have a  $type which is $color in color with $id and looks like $description and  I have few lowerwear , whose details are these'+'$data'+'recommend 5 outfit from  the first outfit and the given lowerwear  , in this format $format  add,only one lowerwear per outfit , strictly adhere to format for the result,return only none if none is matching';

        response= await getreq(txt);



        List<String> pairs = response!.split("\n");

        pairs.forEach((pair) {

          List<String> parts=pair!.split(',');
          String secondPart = parts[1].trim();
          String secondId = secondPart.split(":")[1].trim();
          secondIds.add(secondId);

        });
        print("HHH");
        print(secondIds);
        // return(secondIds);
        // This will print the combined text string
      });
    }
    else if (classification.toLowerCase()=='lower wear'){


      firestoreService.getUpperwearData('upper wear').then((data)async {
        // print(data);
        String ids='';

        String? response='';
        String format='id : original cloth ,id : matched cloth1 ';

        String txt='I have a  $type which is $color in color with $id and looks like $description and  I have few lowerwear , whose details are these'+'$data'+'recommend 5 outfit from  the first outfit and the given lowerwear  , in this format $format  add,only one lowerwear per outfit , strictly adhere to format for the result,return only none if none is matching';

        response= await getreq(txt);

        List<String> pairs = response!.split("\n");
        pairs.forEach((pair) {

          List<String> parts=pair!.split(',');
          String secondPart = parts[1].trim();
          String secondId = secondPart.split(":")[1].trim();
          secondIds.add(secondId);

        });
        print("HHH");
        print(secondIds);
        // return(secondIds);
        // This will print the combined text string
      });
    }
    return(secondIds);

  }
  // Future <List<String>>getclothes(category)async{
  //   if (category.toLowerCase()=='upper wear'){
  //     final firestore = FirebaseFirestore.instance;
  //     final upperWearCollection = firestore.collection('clothes');
  //     final upperWearQuery = upperWearCollection.where('classification', isEqualTo: category).where('userId', isEqualTo: user!.uid);
  //     final snapshot = await upperWearQuery.get();
  //
  //
  //
  //
  //   }
  //   else{
  //
  //   }
  //   }



}
