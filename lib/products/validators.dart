class Validators {
  static String? imageValidator (String? value) {
    if (value == null || value.isEmpty) {
      return 'Image is required';
    }
  }

  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
  }

  static String? priceValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'price is required';
    }
  }

  static String? descriptionValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'description is required';
    }
  }
}
