import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final content;
  final img;
  const Tile({super.key, required this.content, required this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.10,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade900, blurRadius: 4, spreadRadius: 1)
          ]),
      child: Row(
        children: [
          Image.asset(
            img,
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            content,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
