import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legendapp/main.dart';

class ActionButton extends StatefulWidget {
  const ActionButton({
    Key? key,
    this.filled,
    this.focused,
    this.clear,
    this.color,
    this.backColor,
    this.borderColor,
    this.radius,
    this.text,
    this.action,
    this.hasBorder,
    this.textStyle,
    this.expanded,
    this.wait,
    this.icon,
    this.iconColor,
  }) : super(key: key);
  final TextStyle? textStyle;
  final bool? filled;
  final bool? clear;
  final bool? focused;
  final bool? hasBorder;
  final Color? color;
  final String? text;
  final Function()? action;
  final bool? expanded;
  final double? radius;
  final Color? backColor;
  final Color? borderColor;
  final bool? wait;
  final IconData? icon;
  final Color? iconColor;

  factory ActionButton.simpleBlue(text, action, [wait = false]) {
    var context = globalNavigatorKey.currentContext;
    return ActionButton(
      text: text,
      action: action,
      backColor: Theme.of(context!).colorScheme.secondary,
      filled: true,
      radius: 12,
      wait: wait,
    );
  }
  factory ActionButton.simpleYellow(text, action, [wait = false]) {
    var context = globalNavigatorKey.currentContext;
    return ActionButton(
      text: text,
      action: action,
      backColor: Theme.of(context!).primaryColor,
      color: Theme.of(context).primaryColorDark,
      filled: true,
      radius: 12,
      wait: wait,
    );
  }
  factory ActionButton.floating(text, action, icon) {
    var context = globalNavigatorKey.currentContext;
    return ActionButton(
      text: text,
      action: action,
      backColor: Theme.of(context!).primaryColor,
      filled: true,
      radius: 30,
      color: Theme.of(context).primaryColorDark,
      icon: icon,
    );
  }

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  Widget _button() {
    return OutlinedButton(
      onPressed: () {
        widget.action != null ? widget.action!() : () {};
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.text ?? '',
              style: TextStyle(
                  color: widget.color ?? Theme.of(context).primaryColorLight)),
          widget.icon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(
                    widget.icon,
                    color: widget.iconColor ?? Colors.white,
                    size: 35,
                  ),
                )
              : Container(),
          widget.wait ?? false
              ? Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color:
                            widget.color ?? Theme.of(context).primaryColorLight,
                      )),
                )
              : Container(),
        ],
      ),
      style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(
              widget.expanded ?? false ? Size.fromHeight(60) : null),
          backgroundColor: MaterialStateProperty.all(
            widget.filled ?? false
                ? (widget.backColor ?? Theme.of(context).primaryColor)
                : Colors.transparent,
          ),
          padding: MaterialStateProperty.all(
              const EdgeInsets.fromLTRB(30, 16, 30, 16)),
          shape: (widget.radius ?? 0.0) > 0
              ? MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 0.0),
                ))
              : null,
          side: widget.hasBorder ?? false
              ? MaterialStateProperty.all(BorderSide(
                  color: widget.color ?? Theme.of(context).primaryColor,
                  width: 1))
              : null),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _button();
  }
}
