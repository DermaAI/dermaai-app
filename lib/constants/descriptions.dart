String getDescription(String label) {
  String normalPara = 'We have not detected any disease in your skin. '
      'You can continue with your daily routine. '
      'If you have any concerns, please consult a dermatologist.';

  String diseasePara =
      'From our intelligent technologies, it has been concluded that you have a severe skin disease $label. If this is the first time that a situation has arise, contact a dermatologist to determine the need for treatment and exclude threats to health.';

  String cancerPara =
      'From our intelligent technologies, it has been concluded that you have a Malignant (Cancerous) disease. We advice you to seek dermatological assistance at the earliest.';

  String nonCancerPara =
      'From our intelligent technologies, it has been concluded that you have a Benign (Non-Cancerous) disease. Please consult your dermatologist for further treatment.';

  switch (label) {
    case 'Normal':
      return normalPara;
    case 'None':
      return normalPara;
    case 'malignant':
      return cancerPara;
    case 'benign':
      return nonCancerPara;
    default:
      return diseasePara;
  }
}
