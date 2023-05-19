import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading({super.key, required this.songname, required this.artist});
  final String songname;
  final String artist;
  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    setState(() {});
    delay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: CircularProgressIndicator()),
    );
  }

  delay() async {
    await Future.delayed(const Duration(seconds: 2));
    // ignore: use_build_context_synchronously
    //
    setState(() {});
    // Navigator.pop(context);
  }
}
