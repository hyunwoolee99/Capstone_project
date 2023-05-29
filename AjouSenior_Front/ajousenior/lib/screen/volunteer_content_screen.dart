import 'package:ajousenior/data/volunteer_post.dart';
import 'package:ajousenior/provider/volunteerprovider.dart';
import 'package:ajousenior/widgets/certify_widget.dart';
import 'package:ajousenior/models/senior_model.dart';
import 'package:flutter/material.dart';

class VolunteerContentScreen extends StatefulWidget {
  final VolunteerPost current;
  const VolunteerContentScreen({
    super.key,
    required this.current,
  });

  @override
  State<VolunteerContentScreen> createState() => _VolunteerContentScreenState();
}

class _VolunteerContentScreenState extends State<VolunteerContentScreen> {
  late List<String> volunteerList;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Center(
          child: Text(
            "Senior App",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.current.content,
              style: const TextStyle(
                fontSize: 32,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              '${widget.current.members} / ${widget.current.max}',
              style: TextStyle(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text(
                  widget.current.date,
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                CertifyWidget(donationid: widget.current.donationid),
              ],
            ),
            const Text('신청자'),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder(
              future: VolunteerProviders().getList(widget.current.donationid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No data');
                } else {
                  return Column(
                    children: snapshot.data!
                        .map((Senior senior) => Text(senior.profile_nickname!))
                        .toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
