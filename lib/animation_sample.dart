import 'package:flutter/material.dart';
import 'package:verbinden/presentation/pages/message/widgets/widgets.dart';

class AnimationSample extends StatefulWidget {
  const AnimationSample({
    super.key,
  });

  @override
  State<AnimationSample> createState() => _AnimationSampleState();
}

class _AnimationSampleState extends State<AnimationSample> {
  bool busy =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppbarDecorate(
        'Animation',
      ),
      body: Padding(
        padding:  const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AnimationBusyButton(title: 'Save', onPressed: (){ 
              setState(() {
                busy =!busy;
              });
            },
            busy: busy,)
          ],
        ),
      ),
    );
  }
}

class AnimationBusyButton extends StatefulWidget {
  final bool busy;
  final String title;
  final VoidCallback onPressed;
  final bool enabled;
  const AnimationBusyButton({
    super.key,
    this.busy = false,
    required this.title, 
    required this.onPressed,
    this.enabled = true,
  });

  @override
  State<AnimationBusyButton> createState() => _AnimationBusyButtonState();
}

class _AnimationBusyButtonState extends State<AnimationBusyButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap:  widget.onPressed,
        child: AnimatedContainer(
                  height: widget.busy ? 60 : 75,
                  width: widget.busy ? 60 : 200,
                  curve: Curves.easeIn,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
          horizontal: widget.busy ? 10 : 15,
          vertical: widget.busy ? 10 : 10),
                  decoration: BoxDecoration(
          color: widget.enabled ? Colors.blue[800] : Colors.blue[300],
          borderRadius: BorderRadius.circular(5)),
                  duration: const Duration(seconds: 1),
                  child: !widget.busy
          ? Text(
              widget.title,
              style: const TextStyle(color: Colors.white),
            )
          : const CircularProgressIndicator(
              strokeWidth: 3,
              valueColor:
                  AlwaysStoppedAnimation<Color>(Colors.yellowAccent),
            ),
                ));
  }
}
