import 'package:flutter/material.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent(
      {Key? key,
      required this.image,
      required this.title,
      required this.description})
      : super(key: key);

  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/taskoo_logo.png',
              height: 50,
              width: 50,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Taskoo',
              style: TextStyle(
                color: Colors.orange,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Image.asset(
          image,
          height: 320,
        ),
        const Spacer(),
        SizedBox(
          width: 300,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          width: 250,
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
