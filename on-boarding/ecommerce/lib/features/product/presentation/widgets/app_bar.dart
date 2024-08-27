import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // Remove default back button if needed
      actions: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              // Profile Image
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Image.asset(
                  'assets/fahmi.jpg',
                  width: 40.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 20.0),

              // Date and Greeting
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'July 14, 2023',
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'Hello, Fahmi',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),

        const Spacer(), // Pushes notification icon to the right

        // Notifications Icon with Badge
        Container(
          margin: const EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(5),
          ),
          child: InkWell(
            onTap: () {
              // Add notification tap action
            },
            splashColor: Colors.grey.shade300,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  const Icon(Icons.notifications_none_rounded),
                  Positioned(
                    top: 3,
                    right: 5,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 63, 81, 243),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
