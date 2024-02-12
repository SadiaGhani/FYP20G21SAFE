import 'package:flutter/material.dart';

class Post {
  final String text;
  final String imageUrl;
  final List<Reply> replies;

  Post({required this.text, required this.imageUrl, required this.replies});
}

class Reply {
  final String text;

  Reply({required this.text});
}

class NotificationsPage extends StatelessWidget {
  final List<Post> posts = [
    Post(
      text: 'Top 5 Cybersecurity Threats in 2024',
      imageUrl:
          'https://www.google.com/url?sa=i&url=https%3A%2F%2Funsplash.com%2Fs%2Fphotos%2Fcyber-security&psig=AOvVaw1-gmUV5CX0SiTL4TSqu14a&ust=1707823022138000&source=images&cd=vfe&opi=89978449&ved=0CBMQjRxqFwoTCKCR9drWpYQDFQAAAAAdAAAAABAE',
      replies: [
        Reply(
            text:
                'I think ransomware attacks will continue to be a major threat. Organizations need to strengthen their defenses against them.'),
        Reply(
            text:
                'Agreed. Phishing attacks are also on the rise and becoming more sophisticated.'),
      ],
    ),
    Post(
      text: 'Zero-Day Vulnerability Discovered in Popular Software',
      imageUrl:
          'https://www.google.com/url?sa=i&url=https%3A%2F%2Funsplash.com%2Fs%2Fphotos%2Fcyber-security&psig=AOvVaw1-gmUV5CX0SiTL4TSqu14a&ust=1707823022138000&source=images&cd=vfe&opi=89978449&ved=0CBMQjRxqFwoTCKCR9drWpYQDFQAAAAAdAAAAABAE',
      replies: [
        Reply(
            text:
                'This is concerning. Patching systems as soon as updates are available is critical to mitigating risks associated with zero-day vulnerabilities.'),
        Reply(
            text:
                'Absolutely. It highlights the importance of proactive security measures and regular software updates.'),
      ],
    ),
    Post(
      text: 'New Data Protection Regulations Coming into Effect',
      imageUrl: 'https://via.placeholder.com/150',
      replies: [
        Reply(
            text:
                'Organizations need to ensure compliance with these regulations to avoid hefty fines and protect sensitive information.'),
        Reply(
            text:
                'Indeed. Its a good opportunity for organizations to review and enhance their data protection policies and practices.'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cybersecurity Notifications'),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(posts[index].imageUrl),
            ),
            title: Text(posts[index].text),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var reply in posts[index].replies) Text(reply.text),
              ],
            ),
          );
        },
      ),
    );
  }
}
