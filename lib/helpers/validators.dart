class Validator {


  static String? validate(String? value, 
    {
      bool? require, 
      bool? email, 
      double? min, 
      double? max, 
      int? minLength, 
      int? maxLenth, 
      ValidatorCompare? compare,
      List<String? Function(String? value)?>? customs
    }
  ){

    final regexEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if(value == null) return 'Este campo debe ser diligenciado';

    if(require == true && value.isEmpty) return 'Este campo debe ser diligenciado';

    if(email == true && !regexEmail.hasMatch(value)) return 'Ingrese un email válido';

    if(min != null){
      try {
        if(double.parse(value) < min) return 'El número debe ser mayor que $min';
      }catch(e){
        return "Error en los datos";
      }
    }

    if(max != null){
      try {
        if(double.parse(value) >= max) return 'El número debe ser menor a $max';
      }catch(e){
        return "Error en los datos";
      }
    }

    if(minLength != null && value.length < minLength) return 'El campo debe tener al menos $minLength cáracteres';

    if(maxLenth != null && value.length >= maxLenth) return 'El campo debe tener máximo $maxLenth cáracteres';

    if(compare != null && compare.value != value) return compare.textResult ?? 'Los campos debe ser iguales';

    if(customs != null && customs.length > 0){
      for (var fun in customs) {
        String? result = fun?.call(value);
        if(result != null) return result;
      }
    }
  }

  
}

class ValidatorCompare {

  final String value;
  final String? textResult;

  ValidatorCompare(this.value, this.textResult);
}