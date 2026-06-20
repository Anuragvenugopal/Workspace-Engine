import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/todo_provider.dart';
import '../../../../utils/responsive_size.dart';

class AddTodoSheet extends StatefulWidget {
  final Color color;

  const AddTodoSheet({super.key, required this.color});

  @override
  State<AddTodoSheet> createState() => _AddTodoSheetState();
}

class _AddTodoSheetState extends State<AddTodoSheet> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  DateTime? _dueDate;
  bool _isImportant = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _submit() {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;

    context.read<TodoProvider>().addTodo(
          title: title,
          description: _descController.text.trim().isNotEmpty ? _descController.text.trim() : null,
          dueDate: _dueDate,
          isImportant: _isImportant,
        );

    Navigator.pop(context);
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: widget.color,
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.w(24),
        right: context.w(24),
        bottom: MediaQuery.of(context).viewInsets.bottom + context.h(24),
        top: context.h(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'New Task',
                style: TextStyle(
                  fontSize: context.h(20),
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          SizedBox(height: context.h(16)),
          TextField(
            controller: _titleController,
            autofocus: true,
            style: TextStyle(fontSize: context.h(16), fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              hintText: 'What needs to be done?',
              hintStyle: TextStyle(color: Colors.black38, fontSize: context.h(16)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: widget.color, width: 2),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: context.w(16), vertical: context.h(16)),
            ),
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: context.h(12)),
          TextField(
            controller: _descController,
            style: TextStyle(fontSize: context.h(14), color: Colors.black87),
            maxLines: 3,
            minLines: 1,
            decoration: InputDecoration(
              hintText: 'Add details (optional)',
              hintStyle: TextStyle(color: Colors.black38, fontSize: context.h(14)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: widget.color, width: 2),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: context.w(16), vertical: context.h(16)),
            ),
          ),
          SizedBox(height: context.h(20)),
          Row(
            children: [
              GestureDetector(
                onTap: _pickDate,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: context.w(12), vertical: context.h(8)),
                  decoration: BoxDecoration(
                    color: _dueDate != null ? widget.color.withAlpha(20) : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _dueDate != null ? widget.color.withAlpha(50) : Colors.grey.shade300),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        size: context.h(16),
                        color: _dueDate != null ? widget.color : Colors.black54,
                      ),
                      SizedBox(width: context.w(6)),
                      Text(
                        _dueDate != null ? '${_dueDate!.day}/${_dueDate!.month}/${_dueDate!.year}' : 'Set Due Date',
                        style: TextStyle(
                          fontSize: context.h(12),
                          fontWeight: FontWeight.w600,
                          color: _dueDate != null ? widget.color : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: context.w(12)),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isImportant = !_isImportant;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: context.w(12), vertical: context.h(8)),
                  decoration: BoxDecoration(
                    color: _isImportant ? const Color(0xFFFFB020).withAlpha(20) : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _isImportant ? const Color(0xFFFFB020).withAlpha(50) : Colors.grey.shade300),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _isImportant ? Icons.star_rounded : Icons.star_outline_rounded,
                        size: context.h(16),
                        color: _isImportant ? const Color(0xFFFFB020) : Colors.black54,
                      ),
                      SizedBox(width: context.w(6)),
                      Text(
                        'Important',
                        style: TextStyle(
                          fontSize: context.h(12),
                          fontWeight: FontWeight.w600,
                          color: _isImportant ? const Color(0xFFFFB020) : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: context.h(24)),
          SizedBox(
            width: double.infinity,
            height: context.h(50),
            child: FilledButton(
              onPressed: _submit,
              style: FilledButton.styleFrom(
                backgroundColor: widget.color,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('Create Task', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
