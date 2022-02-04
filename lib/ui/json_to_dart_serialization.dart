import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen_utils_web/utils/common_utils.dart';
import 'package:flutter_gen_utils_web/utils/ui_utils.dart';

class JsonToDartSerialization extends StatefulWidget {
  static const String routeName = '/home/jsonToDart' ;
  const JsonToDartSerialization({Key? key}) : super(key: key);

  @override
  _JsonToDartSerializationState createState() => _JsonToDartSerializationState();
}

class _JsonToDartSerializationState extends State<JsonToDartSerialization> {
  String _resultText = 'Waiting for Result...' ;
  TextEditingController _txtController = TextEditingController();
  TextEditingController _classNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Beware Of Conversion'),),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                autofocus: true,
                                minLines: 40,
                                maxLines: 70,
                                controller: _txtController,
                                decoration: InputDecoration(
                                hintText: "Enter Json Text here (Copy & Paste)",
                                border: const OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.grey, width: 0.0),
                                ),
                              ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        height: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 2.0,
                              color: Colors.green,
                            ),
                            borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: Center(
                          child: SelectableText('$_resultText',
                            // toolbarOptions: const ToolbarOptions(copy:true, selectAll: true),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 3,
                    child: TextFormField(
                      controller: _classNameController,
                      decoration: InputDecoration(
                        hintText: 'Class Name',
                        border: const OutlineInputBorder(
                          borderSide:
                          const BorderSide(color: Colors.grey, width: 0.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Flexible(
                    flex: 1,
                    child: ElevatedButton(
                      child: Text('Convert'),
                      onPressed: (){
                        debugPrint('Convert clicked');
                        if(_txtController.text.isEmpty){
                          UIUtils.displaySnackbar(context, 'Please Enter Json Text') ;
                          return ;
                        }
                        if(_classNameController.text.isEmpty){
                          UIUtils.displaySnackbar(context, 'Please Enter Class Name') ;
                          return ;
                        }
                        convertToDart(className: _classNameController.text);
                      },
                    ),
                  ),
                  SizedBox(width: 20,),
                  Flexible(
                    flex: 1,
                    child: IconButton(
                      icon: const Icon(Icons.copy_all, size: 36,),
                      onPressed: () async {
                        if(_resultText.isNotEmpty){
                          await Clipboard.setData(ClipboardData(text: _resultText));
                        }
                    },),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _txtController.dispose();
    _classNameController.dispose();
    super.dispose();
  }

  void convertToDart({String className = 'ClassName'}){
    // _resultText = '' ;
    // String className = 'ClassName' ;
    var resultString = StringBuffer("import 'package:json_annotation/json_annotation.dart'; \n\n") ;
    resultString.write("part '${className.toLowerCase()}.g.dart' ; ///todo: confirm file name\n\n");
    Map<String, dynamic> jsonMap = jsonDecode(_txtController.text);
    // debugPrint('------ Keys -------');
    // debugPrint('${jsonMap.keys.toList()}');
    // debugPrint('------ Entries -------');
    // debugPrint('${jsonMap.entries.toList()}');
    resultString.write('@JsonSerializable()\n');
    resultString.write('class $className {\n');
    int fieldsCount = jsonMap.keys.length ;
    for(int i=0 ; i < fieldsCount ; ++i){
    // for(String key in jsonMap.keys.toList()){
      resultString.write("@JsonKey(name: '${jsonMap.keys.elementAt(i)}')\n");
      // variableName = "$variableName\n\n" ;
      bool nullSafeMark = jsonMap.entries.elementAt(i).value==null ;
      resultString.write("final String${nullSafeMark ? '?' : ''} ${CommonUtils.snakeToCamelCase(jsonMap.keys.elementAt(i) ) } ;\t // ${jsonMap.entries.elementAt(i).value}\n\n");
    }
    resultString.write('$className({\n'); // start constructor
    for(int i=0 ; i < fieldsCount ; ++i){
      resultString.write("required this.${CommonUtils.snakeToCamelCase(jsonMap.keys.elementAt(i))},\n");
    }
    resultString.write('}) ;\n\n'); // close constructor
    resultString.write('factory $className.fromJson(Map<String, dynamic> jsonValue) => _\$${className}FromJson(jsonValue) ;\n\n'); // factory constructor: fromJson
    resultString.write('Map<String, dynamic> toJson() =>  _\$${className}ToJson(this) ;\n\n'); // toJson
    resultString.write('@override\n'); // toString
    resultString.write("String toString() => '$className("); // toString
    addToStringValues(resultString, jsonMap.keys, fieldsCount);
    // if(fieldsCount > 4 ){
    //   for(int i=0 ; i < 4 ; ++i){
    //     if(i==0) {
    //       resultString.write(' ');
    //     } else {
    //       resultString.write(' | ');
    //     }
    //     resultString.write('${CommonUtils.snakeToCamelCase(jsonMap.keys.elementAt(i))}'); // toString
    //   }
    // }else{
    //   for(int i=0 ; i < fieldsCount ; ++i){
    //     if(i==0) {
    //       resultString.write(' ');
    //     } else {
    //       resultString.write(' | ');
    //     }
    //     resultString.write('${CommonUtils.snakeToCamelCase(jsonMap.keys.elementAt(i))}'); // toString
    //   }
    // }
    //
    resultString.write(" )' ;\n\n"); // toString
    resultString.write('}\n'); // close class

    setState(() {
      _resultText = resultString.toString();
      debugPrint('-----resultString-------');
      debugPrint('$_resultText');
    });
  }

  void addToStringValues(StringBuffer resultString, Iterable<String> flields, int fieldsCount){
    // int fieldsCount = flields.length ;
    if(fieldsCount > 4 ){
      for(int i=0 ; i < 4 ; ++i){
        if(i==0) {
          resultString.write(' ');
        } else {
          resultString.write(' | ');
        }
        resultString.write('${CommonUtils.snakeToCamelCase(flields.elementAt(i))}=\$${CommonUtils.snakeToCamelCase(flields.elementAt(i))}'); // toString
      }
    }else{
      for(int i=0 ; i < fieldsCount ; ++i){
        if(i==0) {
          resultString.write(' ');
        } else {
          resultString.write(' | ');
        }
        resultString.write('${CommonUtils.snakeToCamelCase(flields.elementAt(i))}=\$${CommonUtils.snakeToCamelCase(flields.elementAt(i))}'); // toString
      }
    }

  }

}
