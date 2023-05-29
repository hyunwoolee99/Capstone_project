import 'package:ajousenior/provider/volunteerprovider.dart';
import 'package:ajousenior/services/certify_service.dart';
import 'package:flutter/material.dart';

class ApplyListWidget extends StatelessWidget {
  final String donationid;
  const ApplyListWidget({
    Key? key,
    required this.donationid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: VolunteerProviders().getList(donationid),
      builder: (context, snapshot) {
        print(snapshot.data);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No data');
        } else {
          return SingleChildScrollView(
            child: Column(
              children: ListTile.divideTiles(
                context: context,
                tiles: snapshot.data!.map((item) {
                  return ListTile(
                    title: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item.profile_nickname!,
                                style: const TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final certify = await showDialog<bool>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("인증하시겠습니까?"),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text("예"),
                                            onPressed: () =>
                                                Navigator.of(context).pop(true),
                                          ),
                                          TextButton(
                                            child: const Text("아니오"),
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pop(false),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  if (certify == true) {
                                    CertifyService(context)
                                        .certify(donationid, item);
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(45),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 10,
                                    ),
                                    child: Text(
                                      "인증",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ).toList(),
            ),
          );
        }
      },
    );
  }
}
