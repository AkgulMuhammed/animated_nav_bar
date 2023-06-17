import 'package:animation_navbar/utils/rive_utils.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({Key? key}) : super(key: key);

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  RiveAssets selectedBottomNav = bottomNavs.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Muhammed Akgül"),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              
              height: 500,
              width: 500,
              child: RiveAnimation.asset(
                "assets/RiveAsset/stroke_train.riv",
                artboard: "AS",
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFF72585), // Çizgi rengi
                  width: 2,
                ), // Çizgi kalınlığı,
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(24))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...List.generate(
                    bottomNavs.length,
                    (index) => GestureDetector(
                          onTap: () {
                            bottomNavs[index].input?.change(
                                true); // Animasyon başlangıç durumuna dönüyor
                            Future.delayed(const Duration(seconds: 1), () {
                              bottomNavs[index].input?.change(
                                  false); // Animasyon başlangıç durumuna dönüyor
                            });
                          },
                          child: SizedBox(
                            height: 60,
                            width: 60,
                            child: RiveAnimation.asset(
                              bottomNavs.first.src,
                              artboard: bottomNavs[index].artboard,
                              onInit: (artboard) {
                                StateMachineController? controller =
                                    RiveUtils.getRiveController(artboard,
                                        stateMachineName:
                                            bottomNavs[index].stateMachineName);
                                bottomNavs[index].input =
                                    controller.findSMI("active") as SMIBool?;
                              },
                            ),
                          ),
                        ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RiveAssets {
  final String artboard, stateMachineName, title, src;
  SMIBool? input;

  RiveAssets({
    required this.src,
    required this.artboard,
    required this.stateMachineName,
    required this.title,
    this.input,
  });

  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAssets> bottomNavs = [
  RiveAssets(
      src: "assets/RiveAsset/icon.riv",
      artboard: "home",
      stateMachineName: "State Machine 1",
      title: "home"),
  RiveAssets(
      src: "assets/RiveAsset/icon.riv",
      artboard: "filtter",
      stateMachineName: "State Machine 1",
      title: "Person"),
  RiveAssets(
      src: "assets/RiveAsset/icon.riv",
      artboard: "favorite ",
      stateMachineName: "State Machine 1",
      title: "List"),
  RiveAssets(
      src: "assets/RiveAsset/icon.riv",
      artboard: "chat",
      stateMachineName: "State Machine 1",
      title: "Chat"),
  RiveAssets(
      src: "assets/RiveAsset/icon.riv",
      artboard: "person 2",
      stateMachineName: "State Machine 1",
      title: "Person"),
];
