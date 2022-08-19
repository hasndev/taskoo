import 'package:flutter/material.dart';
import 'package:taskoo/Screen/Taskoo.dart';
import 'package:taskoo/Widget/OnboardingContent.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int currntIndex = 0;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: demo_data.length,
                  onPageChanged: (int page) {
                    setState(() {
                      currntIndex = page;
                    });
                  },
                  itemBuilder: (context, index) => OnboardingContent(
                    image: demo_data[index].image,
                    title: demo_data[index].title,
                    description: demo_data[index].description,
                  ),
                ),
              ),
              SizedBox(
                height: 60,
                width: 150,
                child: currntIndex == demo_data.length - 1
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Taskoo()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        child: const Text("Let's Start"),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          _pageController.nextPage(
                              curve: Curves.ease,
                              duration: Duration(milliseconds: 300));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        child: Text("Next"),
                      ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Onboard {
  final String image, title, description;

  Onboard(
      {required this.image, required this.title, required this.description});
}

final List<Onboard> demo_data = [
  Onboard(
    image: 'assets/taskoo_wel1.jpg',
    title: 'Manage Your Team & Everything with Taskoo',
    description: 'Welcome To Taskoo App',
  ),
  Onboard(
    image: 'assets/taskoo_wel2.jpg',
    title: 'Just Think How To Do It',
    description: 'Not How To Plan It',
  ),
  Onboard(
    image: 'assets/taskoo_wel3.jpg',
    title: 'Manage Your Task, Manage Your Life',
    description: "By making a to do list in Taskoo",
  ),
];
