import 'package:ajousenior/screen/junior_screen.dart';
import 'package:ajousenior/screen/juniorvollist_screen.dart';
import 'package:ajousenior/services/volunteerlist_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/senior_model.dart';
import '../services/junior_postvolunteer.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const storage = FlutterSecureStorage();
  dynamic userInfo = '';
  // storage에 있는 유저 정보를 저장

  _asyncMethod() async {
    // read 함수로 key값에 맞는 정보를 불러오고 데이터타입은 String 타입
    userInfo = await storage.read(key: 'login');
  }

  Future<bool?> _showApplyDialog(Map<String, dynamic> location) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "신청하시겠습니까?",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "장소 : " + location['seniorcenter'],
              ),
              Text("내용 : " + location['content']),
              Text("시간 : "
                  "${DateTime.parse(location['date']).month}월${DateTime.parse(location['date']).day}일${DateTime.parse(location['date']).hour}시${DateTime.parse(location['date']).minute}분"),
              Text("최대 인원: ${location['maxpeople']}"),
              Text("현재 인원: ${location['currentpeople']}")
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("취소"),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: const Text("신청"),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );
  }

  Set<Marker> getMarkers() {
    Set<Marker> markers = {};
    for (Map<String, dynamic> location in locations) {
      final LatLng position = LatLng(double.parse(location['latitude']),
          double.parse(location['longitude']));
      final Marker marker = Marker(
        markerId: MarkerId(location['seniorcenter']),
        position: position,
        infoWindow: InfoWindow(
          title: location['seniorcenter'],
          //     +" "
          //         "${DateTime.parse(location['date']).month}월${DateTime.parse(location['date']).day}일${DateTime.parse(location['date']).hour}시${DateTime.parse(location['date']).minute}분",
          snippet: location['content'],
          onTap: () async {
            print("포스트실행");
            if (location['currentpeople'] < location['maxpeople']) {
              Senior a = StringTo(userInfo);
              final apply = await _showApplyDialog(location);
              print("다이아로그실행완료");
              if (apply == true) {
                JuniorPostVolunteer.sendVolunteer(location['_id'], a.id,
                    location['currentpeople'].toString());
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => super.widget));
              }
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('안내'),
                    content: const Text('신청인원이 다 찼습니다.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('확인'),
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
      );
      markers.add(marker);
    }
    return markers;
  }

  late GoogleMapController mapController;

  List<Map<String, dynamic>> locations = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
    _loadLocations();
  }

  void _loadLocations() async {
    try {
      final list = await GetVolListService().getVolList();
      setState(() {
        locations = list.cast<Map<String, dynamic>>();
        print("성공");
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false; // 뒤로가기 버튼을 무시하고 아무 동작도 하지 않음
      },
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                // 홈 버튼을 눌렀을 때 수행할 동작
                // 예를 들어, 홈 화면으로 이동하는 코드를 작성할 수 있습니다.
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const JuniorScreen()));
              },
            ),
            backgroundColor: Colors.white,
            foregroundColor: Colors.green,
            title: const Text('          재능기부 맵'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.map_outlined),
                onPressed: () {
                  // 아이콘 버튼 실행
                },
              ),
              IconButton(
                icon: const Icon(Icons.list_alt), // 검색 아이콘 생성
                onPressed: () {
                  // 아이콘 버튼 실행
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VolunteerListScreen(),
                    ),
                  );
                },
              ),
            ]),
        body: GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
          initialCameraPosition: const CameraPosition(
            target: LatLng(37.283653, 127.045009),
            zoom: 14,
          ),
          markers: getMarkers(),
        ),
      ),
    );
  }
}
