enum Flavor {
  PROD,
  DEV,
}

class Enviroment {

  static Flavor appFlavor = Flavor.PROD;

  static String get title {
    switch (appFlavor) {
      case Flavor.PROD:
        return 'Employee';
      case Flavor.DEV:
        return 'Employee Debug';
    }
  }

  static String get flavorName {
    switch (appFlavor) {
      case Flavor.PROD:
        return 'PROD';
      case Flavor.DEV:
        return 'DEV';
    }
  }

  static String get apiUrl {
    switch (appFlavor) {
      case Flavor.PROD:
        return 'https://cidenetapi.herokuapp.com/api/v1/';
      case Flavor.DEV:
        return 'http://localhost:8080/api/v1/';
    }
  }

  static bool get isProd {
    return appFlavor == Flavor.PROD;
  }

}
