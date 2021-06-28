
import 'package:employee_app/helpers/enumValues.dart';

enum DocumentTypeEnum { CEDULA, EXTRANJERIA, PASSPORT, ESPECIALPERMISSION }

final documentsTypeEnumValues = EnumValues({
    'CC': EnumValue(DocumentTypeEnum.CEDULA, 'C. Ciudadanía'),
    'CE': EnumValue(DocumentTypeEnum.EXTRANJERIA, 'C. Extranjería'),
    'PP': EnumValue(DocumentTypeEnum.PASSPORT, 'Pasaporte'),
    'PE': EnumValue(DocumentTypeEnum.ESPECIALPERMISSION, 'Permiso Especial'),
});