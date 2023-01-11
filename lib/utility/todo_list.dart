import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/utility/colors.dart';

class ToDoTile extends StatefulWidget {
  final String taskName;
  bool? checkTask;
  Function(BuildContext)? onDelete;
  Function(bool?)? onChanged;
  ToDoTile(
      {super.key,
      required this.taskName,
      required this.onDelete,
      required this.checkTask,
      required this.onChanged});

  @override
  State<ToDoTile> createState() => _ToDoTileState();
}

class _ToDoTileState extends State<ToDoTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 25, left: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              foregroundColor: darkText,
              icon: Icons.delete,
              backgroundColor: redButton,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              onPressed: widget.onDelete,
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  offset: const Offset(0, 2.5),
                  blurRadius: 8,
                )
              ],
              color: widget.checkTask!
                  ? const Color.fromARGB(255, 104, 126, 151)
                  : taskCard,
              borderRadius: BorderRadiusDirectional.circular(5)),
          child: Center(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                checkColor: Colors.black,
                activeColor: Colors.white,
                value: widget.checkTask,
                onChanged: widget.onChanged,
              ),
              //
              //
              Flexible(
                child: Text(
                  widget.taskName,
                  style: TextStyle(
                    fontSize: 17,
                    color: whiteText,
                    decorationColor: Colors.black,
                    decorationThickness: 3,
                    decoration: widget.checkTask!
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
