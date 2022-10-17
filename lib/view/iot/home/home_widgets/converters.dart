bool switchValueToBool(dynamic itemState) {
  return itemState == '1' ||
      itemState == 'On' ||
      itemState == 'on' ||
      itemState == 1;
}
