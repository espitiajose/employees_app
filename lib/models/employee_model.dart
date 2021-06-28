

import 'package:employee_app/models/enums/area_enum.dart';
import 'package:employee_app/models/enums/country_enum.dart';
import 'package:employee_app/models/enums/documentType_enum.dart';
import 'package:intl/intl.dart';

class EmployeeModel {
    EmployeeModel({
        required this.surname,
        required this.secondSurname,
        required this.firstName,
        required this.secondName,
        required this.country,
        required this.documentType,
        required this.document,
        required this.dateOfAdmission,
        required this.area,
        this.id,
        this.email,
        this.createdDate,
        this.status,
    });

    final String surname;
    final String secondSurname;
    final String firstName;
    final String secondName;
    final CountryEnum country;
    final DocumentTypeEnum documentType;
    final String document;
    final AreaEnum area;
    final int dateOfAdmission;
    final String? id;
    final String? email;
    final int? createdDate;
    final bool? status;

    EmployeeModel copyWith({
        bool? status,
        int? createdDate,
        String? id,
        String? surname,
        String? secondSurname,
        String? firstName,
        String? secondName,
        CountryEnum? country,
        DocumentTypeEnum? documentType,
        String? document,
        int? dateOfAdmission,
        AreaEnum? area,
        String? email,
    }) => 
        EmployeeModel(
            status: status ?? this.status,
            createdDate: createdDate ?? this.createdDate,
            id: id ?? this.id,
            surname: surname ?? this.surname,
            secondSurname: secondSurname ?? this.secondSurname,
            firstName: firstName ?? this.firstName,
            secondName: secondName ?? this.secondName,
            country: country ?? this.country,
            documentType: documentType ?? this.documentType,
            document: document ?? this.document,
            dateOfAdmission: dateOfAdmission ?? this.dateOfAdmission,
            area: area ?? this.area,
            email: email ?? this.email,
        );

    factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        status: json["status"],
        createdDate: json["createdDate"],
        id: json["_id"],
        surname: json["surname"],
        secondSurname: json["secondSurname"],
        firstName: json["first_name"],
        secondName: json["second_name"],
        country: countryEnumValues.map[json["country"]]?.value,
        documentType: documentsTypeEnumValues.map[json["documentType"]]?.value,
        document: json["document"],
        dateOfAdmission: json["dateOfAdmission"],
        area: areaEnumValues.map[json["area"]]?.value,
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "createdDate": createdDate,
        "_id": id,
        "surname": surname,
        "secondSurname": secondSurname,
        "first_name": firstName,
        "second_name": secondName,
        "country": countryEnumValues.reverse[country],
        "documentType": documentsTypeEnumValues.reverse[documentType],
        "document": document,
        "dateOfAdmission": dateOfAdmission,
        "area": areaEnumValues.reverse[area],
        "email": email,
    };

    Map<String, dynamic> toRegisterJson() => {
        "surname": surname,
        "secondSurname": secondSurname,
        "first_name": firstName,
        "second_name": secondName,
        "country": countryEnumValues.reverse[country],
        "documentType": documentsTypeEnumValues.reverse[documentType],
        "document": document,
        "dateOfAdmission": dateOfAdmission,
        "area": areaEnumValues.reverse[area],
    };

    String get name {
      return '$firstName $surname';
    }

    String get doc {
      return '${documentsTypeEnumValues.reverse[documentType]} $document';
    }

    String get proffesionalArea{
      return '${areaEnumValues.reverseName(area)}';
    }

    String get dateOfAdmissionFormatted {
      return DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(dateOfAdmission));
    }
}
