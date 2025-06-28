import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxList<Email> emails = <Email>[].obs;
  final RxList<int> selectedEmails = <int>[].obs;
  final RxString currentView = 'inbox'.obs;

  @override
  void onInit() {
    super.onInit();
    loadEmails();
  }

  void loadEmails() {
    // Simulated email data
    emails.value = [
      Email(
        id: 1,
        sender: "John Doe",
        subject: "Meeting Tomorrow",
        message: "Hi, let's discuss the project tomorrow at 10 AM.",
        time: "10:30 AM",
        isRead: false,
        isStarred: false,
      ),
      Email(
        id: 2,
        sender: "Jane Smith",
        subject: "Project Update",
        message: "Here's the latest update on the ongoing project.",
        time: "9:15 AM",
        isRead: true,
        isStarred: true,
      ),
      Email(
        id: 3,
        sender: "Alex Johnson",
        subject: "Weekly Report",
        message: "Please find attached the weekly progress report.",
        time: "Yesterday",
        isRead: true,
        isStarred: false,
      ),
    ];
  }

  void toggleEmailSelection(int id) {
    if (selectedEmails.contains(id)) {
      selectedEmails.remove(id);
    } else {
      selectedEmails.add(id);
    }
  }

  void toggleStar(int id) {
    final index = emails.indexWhere((email) => email.id == id);
    if (index != -1) {
      final email = emails[index];
      emails[index] = email.copyWith(isStarred: !email.isStarred);
    }
  }

  void markAsRead(int id) {
    final index = emails.indexWhere((email) => email.id == id);
    if (index != -1) {
      final email = emails[index];
      emails[index] = email.copyWith(isRead: true);
    }
  }

  void deleteEmails(List<int> ids) {
    emails.removeWhere((email) => ids.contains(email.id));
    selectedEmails.clear();
  }

  void changeView(String view) {
    currentView.value = view;
  }
}

class Email {
  final int id;
  final String sender;
  final String subject;
  final String message;
  final String time;
  final bool isRead;
  final bool isStarred;

  Email({
    required this.id,
    required this.sender,
    required this.subject,
    required this.message,
    required this.time,
    this.isRead = false,
    this.isStarred = false,
  });

  Email copyWith({
    int? id,
    String? sender,
    String? subject,
    String? message,
    String? time,
    bool? isRead,
    bool? isStarred,
  }) {
    return Email(
      id: id ?? this.id,
      sender: sender ?? this.sender,
      subject: subject ?? this.subject,
      message: message ?? this.message,
      time: time ?? this.time,
      isRead: isRead ?? this.isRead,
      isStarred: isStarred ?? this.isStarred,
    );
  }
}
