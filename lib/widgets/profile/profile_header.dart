import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              width: double.infinity,
              height: 180,
              child: Image.network(
                'https://ispe.org/sites/default/files/styles/hero_banner_large/public/banner-images/volunteer-page-hero-1900x600.png.webp?itok=JwOK6xl2',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 15,
              bottom: -80,
              child: Container(
                width: 120,
                height: 120,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: PrimaryColor.primary500,
                  borderRadius: BorderRadius.circular(100)
                ),
                child: const CircleAvatar(
                  radius: 120,
                  backgroundImage: NetworkImage(
                    'https://media.istockphoto.com/id/1335941248/photo/shot-of-a-handsome-young-man-standing-against-a-grey-background.jpg?s=612x612&w=0&k=20&c=JSBpwVFm8vz23PZ44Rjn728NwmMtBa_DYL7qxrEWr38=',
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(150, 10, 15, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thoại Lê nè',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 30,
                      child: FilledButton(
                        onPressed: () { print('hii'); },
                        child: Text('Kết bạn', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Visibility(
                    visible: false,
                    child: SizedBox(
                      height: 30,
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text('Kết bạn', style: Theme.of(context).textTheme.bodySmall),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }


}
