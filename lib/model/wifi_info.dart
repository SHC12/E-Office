class wifi_info {
  String sSID;
  String bSSID;
  String iPADD;

  wifi_info({this.sSID, this.bSSID, this.iPADD});

  wifi_info.fromJson(Map<String, dynamic> json) {
    sSID = json['SSID'];
    bSSID = json['BSSID'];
    iPADD = json['IP_ADD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SSID'] = this.sSID;
    data['BSSID'] = this.bSSID;
    data['IP_ADD'] = this.iPADD;
    return data;
  }
}
