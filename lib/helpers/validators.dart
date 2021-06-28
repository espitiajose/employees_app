class Validator {


  static String? validate(String? value, 
    {
      bool? require, 
      bool? email, 
      bool? accents = true, 
      double? min, 
      double? max, 
      int? minLength, 
      int? maxLenth, 
      ValidatorCompare? compare,
      String? custom
    }
  ){

    final regexEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final regexAccents = RegExp(r"[^A-Za-z0-9]+");

    if(value == null) return 'Este campo debe ser diligenciado';

    if(require == true && value.isEmpty) return 'Este campo debe ser diligenciado';

    if(email == true && !regexEmail.hasMatch(value)) return 'Ingrese un email válido';

    if(!(accents ?? false) && regexAccents.hasMatch(value)) return 'No se permiten acentos';

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

    if(custom != null) return custom;
  }

  
}

class ValidatorCompare {

  final String value;
  final String? textResult;

  ValidatorCompare(this.value, this.textResult);
}