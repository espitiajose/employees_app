
import 'package:employee_app/config/enviroment.dart';
import 'package:employee_app/employeeApp.dart';

void main() {
  Enviroment.appFlavor = Flavor.PROD;
  setupApp();
}
