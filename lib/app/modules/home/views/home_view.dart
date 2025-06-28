import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gmail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Text(
                      'U',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'User Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'user@example.com',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.inbox),
              title: const Text('Inbox'),
              selected: controller.currentView.value == 'inbox',
              onTap: () => controller.changeView('inbox'),
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Starred'),
              selected: controller.currentView.value == 'starred',
              onTap: () => controller.changeView('starred'),
            ),
            ListTile(
              leading: const Icon(Icons.send),
              title: const Text('Sent'),
              selected: controller.currentView.value == 'sent',
              onTap: () => controller.changeView('sent'),
            ),
            ListTile(
              leading: const Icon(Icons.drafts),
              title: const Text('Drafts'),
              selected: controller.currentView.value == 'drafts',
              onTap: () => controller.changeView('drafts'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Trash'),
              selected: controller.currentView.value == 'trash',
              onTap: () => controller.changeView('trash'),
            ),
            ListTile(
              leading: const Icon(Icons.warning),
              title: const Text('Spam'),
              selected: controller.currentView.value == 'spam',
              onTap: () => controller.changeView('spam'),
            ),
          ],
        ),
      ),
      body: Obx(
        () => ListView.separated(
          itemCount: controller.emails.length,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final email = controller.emails[index];
            return Dismissible(
              key: Key(email.id.toString()),
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                controller.deleteEmails([email.id]);
              },
              child: ListTile(
                leading: Checkbox(
                  value: controller.selectedEmails.contains(email.id),
                  onChanged: (bool? value) {
                    controller.toggleEmailSelection(email.id);
                  },
                ),
                title: Text(
                  email.sender,
                  style: TextStyle(
                    fontWeight: email.isRead ? FontWeight.normal : FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      email.subject,
                      style: TextStyle(
                        fontWeight: email.isRead ? FontWeight.normal : FontWeight.bold,
                      ),
                    ),
                    Text(
                      email.message,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      email.time,
                      style: const TextStyle(fontSize: 12),
                    ),
                    IconButton(
                      icon: Icon(
                        email.isStarred ? Icons.star : Icons.star_border,
                        color: email.isStarred ? Colors.yellow : Colors.grey,
                      ),
                      onPressed: () => controller.toggleStar(email.id),
                    ),
                  ],
                ),
                onTap: () {
                  controller.markAsRead(email.id);
                  // Navigate to email detail view
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to compose email view
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
