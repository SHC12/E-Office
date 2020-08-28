import 'dart:convert';

import 'package:e_office/util/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RiwayatTab extends StatefulWidget {
  @override
  _RiwayatTabState createState() => _RiwayatTabState();
}

class _RiwayatTabState extends State<RiwayatTab> {
  final double _smallFontSize = Sizes.s20;
  final double _valFontSize = Sizes.s30;
  final FontWeight _smallFontWeight = FontWeight.w500;
  final FontWeight _valFontWeight = FontWeight.w700;
  final Color _fontColor = Color(0xff5b6990);
  final double _smallFontSpacing = 1.3;

  SharedPreferences pref;

  getRiwayatAbsen() async {
    pref = await SharedPreferences.getInstance();
    String id_user = pref.getString('id_user');
    var response = await http.get(
        "https://mobileabsensi.pasamanbaratkab.go.id/api_android/riwayat_absen.php?id_user=" +
            id_user);
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    );
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setSp(30),
            vertical: ScreenUtil().setSp(25)),
        alignment: Alignment.topCenter,
        child: FutureBuilder(
            future: getRiwayatAbsen(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                var listData = snapshot.data['data'];
                return ListView.builder(
                    itemCount: listData.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Color(0xffdde9f7),
                          width: 1.5,
                        ))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  listData[index]['status_absen'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: _fontColor),
                                ),
                                Text(
                                  listData[index]['tanggal_absen'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: _fontColor),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "Masuk : " + listData[index]['jam_masuk'],
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: _smallFontSpacing,
                                      color: _fontColor),
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                Expanded(
                                  child: Text(
                                    "Pulang : " + listData[index]['jam_pulang'],
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: _smallFontSpacing,
                                        color: _fontColor),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Kehadiran : " +
                                        listData[index]['waktu_kerja'] +
                                        " menit",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: _smallFontSpacing,
                                        color: _fontColor),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            })
        // child: Column(
        //   children: <Widget>[
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: <Widget>[
        //         Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: <Widget>[
        //             Text("Jumlah Kehadiran",
        //                 style: TextStyle(
        //                   fontWeight: _smallFontWeight,
        //                   fontSize: _smallFontSize,
        //                   letterSpacing: _smallFontSpacing,
        //                   color: _fontColor,
        //                 )),
        //             SizedBox(height: ScreenUtil().setHeight(10)),
        //             Text("6.45h",
        //                 style: TextStyle(
        //                   fontWeight: _valFontWeight,
        //                   fontSize: _valFontSize,
        //                   color: _fontColor,
        //                 )),
        //           ],
        //         ),
        //         Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: <Widget>[
        //             Text("Jumlah Telat",
        //                 style: TextStyle(
        //                   fontWeight: _smallFontWeight,
        //                   fontSize: _smallFontSize,
        //                   letterSpacing: _smallFontSpacing,
        //                   color: _fontColor,
        //                 )),
        //             SizedBox(height: ScreenUtil().setHeight(10)),
        //             Text("6.45h",
        //                 style: TextStyle(
        //                   fontWeight: _valFontWeight,
        //                   fontSize: _valFontSize,
        //                   color: _fontColor,
        //                 )),
        //           ],
        //         ),
        //         // Container(
        //         //   height: 200,
        //         //   width: ScreenUtil().setWidth(200),
        //         //   decoration: BoxDecoration(
        //         //       color: Color(0xfff0f5fb),
        //         //       border: Border.all(
        //         //         width: 8,
        //         //         color: Color(0xffd3e1ed),
        //         //       ),
        //         //       borderRadius: BorderRadius.circular(3)),
        //         //   padding: EdgeInsets.all(15),
        //         //   child: Column(
        //         //     crossAxisAlignment: CrossAxisAlignment.start,
        //         //     children: <Widget>[
        //         //       Text(
        //         //         "THIS WEEK",
        //         //         style: TextStyle(
        //         //             fontSize: _smallFontSize,
        //         //             fontWeight: _smallFontWeight,
        //         //             letterSpacing: _smallFontSpacing,
        //         //             color: _fontColor),
        //         //       ),
        //         //       SizedBox(
        //         //         height: 15,
        //         //       ),
        //         //       Container(
        //         //         height: ScreenUtil().setHeight(120),
        //         //         padding: EdgeInsets.symmetric(horizontal: 10),
        //         //         width: double.infinity,
        //         //         child: CustomPaint(
        //         //           foregroundPainter: GraphPainter(),
        //         //         ),
        //         //       )
        //         //     ],
        //         //   ),
        //         // )
        //       ],
        //     ),
        //     SizedBox(
        //       height: 25,
        //     ),

        //     // RecordItem(
        //     //     fontColor: _fontColor,
        //     //     smallFontSpacing: _smallFontSpacing,
        //     //     day: "HADIR"),
        //     // RecordItem(
        //     //     fontColor: _fontColor,
        //     //     smallFontSpacing: _smallFontSpacing,
        //     //     day: "ABSEN"),
        //     // RecordItem(
        //     //     fontColor: _fontColor,
        //     //     smallFontSpacing: _smallFontSpacing,
        //     //     day: "IJIN"),
        //     // RecordItem(
        //     //     fontColor: _fontColor,
        //     //     smallFontSpacing: _smallFontSpacing,
        //     //     day: "DINAS LUAR"),
        //     // RecordItem(
        //     //     fontColor: _fontColor,
        //     //     smallFontSpacing: _smallFontSpacing,
        //     //     day: "DINAS LUAR"),
        //     // RecordItem(
        //     //     fontColor: _fontColor,
        //     //     smallFontSpacing: _smallFontSpacing,
        //     //     day: "HADIR"),
        //     // RecordItem(
        //     //     fontColor: _fontColor,
        //     //     smallFontSpacing: _smallFontSpacing,
        //     //     day: "HADIR"),
        //   ],
        // ),
        );
  }
}

// FutureBuilder(
//               future: getRiwayatAbsen(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   print(snapshot.data);
//                   var listData = snapshot.data['data'];
//                   return ListView.builder(
//                       itemCount: listData.length,
//                       itemBuilder: (context, index) {
//                         return RecordItem(
//                             fontColor: _fontColor,
//                             smallFontSpacing: _smallFontSpacing,
//                             day: "HADIR");
//                       });
//                 }
//               })

class RecordItem extends StatelessWidget {
  const RecordItem({
    Key key,
    @required Color fontColor,
    @required double smallFontSpacing,
    @required this.day,
  })  : _fontColor = fontColor,
        _smallFontSpacing = smallFontSpacing,
        super(key: key);

  final Color _fontColor;
  final double _smallFontSpacing;
  final String day;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Color(0xffdde9f7),
        width: 1.5,
      ))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                day,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _fontColor),
              ),
              Text(
                "12-12-2020",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _fontColor),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              Text(
                "Masuk : 08:00 ",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    letterSpacing: _smallFontSpacing,
                    color: _fontColor),
              ),
              SizedBox(
                width: 25,
              ),
              Expanded(
                child: Text(
                  "Pulang : 16:00 ",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      letterSpacing: _smallFontSpacing,
                      color: _fontColor),
                ),
              ),
              Expanded(
                child: Text(
                  "Kehadiran : 800 Menit",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      letterSpacing: _smallFontSpacing,
                      color: _fontColor),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class GraphPainter extends CustomPainter {
  //the one in the foreground
  Paint trackBarPaint = Paint()
    ..color = Color(0xff818aab)
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 12;

  //the one in the background
  Paint trackPaint = Paint()
    ..color = Color(0xffdee6f1)
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 12;

  @override
  void paint(Canvas canvas, Size size) {
    List val = [
      size.height * 0.8,
      size.height * 0.5,
      size.height * 0.9,
      size.height * 0.8,
      size.height * 0.5,
    ];
    double origin = 8;

    Path trackBarPath = Path();
    Path trackPath = Path();

    for (int i = 0; i < val.length; i++) {
      trackPath.moveTo(origin, size.height);
      trackPath.lineTo(origin, 0);

      trackBarPath.moveTo(origin, size.height);
      trackBarPath.lineTo(origin, val[i]);

      origin = origin + size.width * 0.22;
    }

    canvas.drawPath(trackPath, trackPaint);
    canvas.drawPath(trackBarPath, trackBarPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
