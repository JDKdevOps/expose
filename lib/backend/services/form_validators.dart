class FormValidators {
  static String? Function(String?)? emailValidator = (value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value ?? '') ? null : 'Escribe un correo válido';
  };

  static String? Function(String?)? passwordValidator = (value) {
    return (value != null && value.length >= 6)
        ? null
        : 'La contraseña debe de ser de 6 caracteres';
  };

  static String? Function(String?)? defaultValidator = (value) {
    return ((value ?? '').trim().isNotEmpty)
        ? null
        : 'Debes rellenar todos los campos';
  };
}
