class CommonUtils {
  static String snakeToCamelCase(String snakeCase){
    List<String> splittedString = snakeCase.split('_');
    splittedString = splittedString.map<String>((s) => firstLetterCapital(s)).toList(growable: false);
    String varName = splittedString.join();
    return firstLetterLower(varName) ;
  }

  static String firstLetterCapital(String str){
    if(str.isEmpty){
      return '' ;
    }
    return '${str[0].toUpperCase()}${str.substring(1).toLowerCase()}' ;
  }

  static String firstLetterLower(String str){
    if(str.isEmpty){
      return '' ;
    }
    return '${str[0].toLowerCase()}${str.substring(1)}' ;
  }


}