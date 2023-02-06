class InputValidator{
  static bool nameValidation(String? name){
    return name != null && name.length>3;
  }
  static bool notNullValidation(String? input){
    return input != null;
  }
}