
import 'package:employee_app/helpers/enumValues.dart';

enum AreaEnum { ADMIN, FINANCIAL, SHOPPING, INFRASTRUCTURE, OPERATION, HUMANTALENT, SERVICES, OTHER }

final areaEnumValues = EnumValues({
    'ADMIN': EnumValue(AreaEnum.ADMIN,'Administrador'), 
    'FINANCIAL': EnumValue(AreaEnum.FINANCIAL,'Finanzas'), 
    'SHOPPING': EnumValue(AreaEnum.SHOPPING,'Compras'), 
    'INFRASTRUCTURE': EnumValue(AreaEnum.INFRASTRUCTURE,'Infraestructura'), 
    'OPERATION': EnumValue(AreaEnum.OPERATION,'Operador'), 
    'HUMANTALENT': EnumValue(AreaEnum.HUMANTALENT,'Talento humano'), 
    'SERVICES': EnumValue(AreaEnum.SERVICES,'Servicios varios'), 
    'OTHER': EnumValue(AreaEnum.OTHER,'Otros'),
});