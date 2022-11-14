String getMainLabals(int index) {
  switch (index) {
    case 0:
      return 'pigmented benign keratosis';
    case 1:
      return 'melanoma';
    case 2:
      return 'vascular lesion';
    case 3:
      return 'actinic keratosis';
    case 4:
      return 'squamous cell carcinoma';
    case 5:
      return 'basal cell carcinoma';
    case 6:
      return 'seborrheic keratosis';
    case 7:
      return 'dermatofibroma';
    case 8:
      return 'nevus';
    default:
      return 'normal';
  }
}

String getCancerLabels(int index) {
  switch (index) {
    case 0:
      return 'benign';
    case 1:
      return 'malignant';
    default:
      return 'normal';
  }
}
