class UserConfigModel{
  final int id;
  final String loginWithPin;
  final String loginWithFinger;
  final String fontStyle;
  final int fontSize;
  final String bubbleBackground;
  final String bubbleTextColor;
  final String messageTone;
  final String conversationTone;
  final String callRingTone;
  final String vibration;
  final String mobileNetwork;
  final String paymentNumber;
  final String themeColor;


  UserConfigModel({
  this.id,
  this.loginWithPin,
  this.loginWithFinger,
  this.fontStyle,
  this.fontSize,
  this.bubbleBackground,
  this.bubbleTextColor,
  this.messageTone,
  this.conversationTone,
  this.callRingTone,
  this.vibration,
  this.mobileNetwork,
  this.paymentNumber,
  this.themeColor,
  });

  Map<String, dynamic> toMap(){
    return {
      "id": id,
      "loginWithPin":loginWithPin,
      "loginWithFinger":loginWithFinger,
      "fontStyle": fontStyle,
      "fontSize": fontSize,
      "bubbleBackGround": bubbleBackground,
      "bubbleTextColor": bubbleTextColor,
      "messageTone": messageTone,
      "conversationTone": conversationTone,
      "vibration": vibration,
      "mobileNetwork": mobileNetwork,
      "paymentNumber": paymentNumber,
      "themeColor": themeColor,
    };
}

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "loginWithPin":loginWithPin,
      "loginWithFinger":loginWithFinger,
      "fontStyle": fontStyle,
      "fontSize": fontSize,
      "bubbleBackGround": bubbleBackground,
      "bubbleTextColor": bubbleTextColor,
      "messageTone": messageTone,
      "conversationTone": conversationTone,
      "vibration": vibration,
      "mobileNetwork": mobileNetwork,
      "paymentNumber": paymentNumber,
      "themeColor": themeColor,
    };
  }


  @override
  String toString() {
    return 'UserConfigModel{id: $id, loginWithPin: $loginWithPin, loginWithFinger: $loginWithFinger, fontStyle: $fontStyle, fontSize: $fontSize, bubbleBackground: $bubbleBackground, bubbleTextColor: $bubbleTextColor, messageTone: $messageTone, conversationTone: $conversationTone, callRingTone: $callRingTone, vibration: $vibration, mobileNetwork: $mobileNetwork, paymentNumber: $paymentNumber, themeColor: $themeColor}';
  }

}