import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/widgets/status_tag.dart';

class OrganizationCampaignCard extends StatelessWidget {
  const OrganizationCampaignCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/organization/campaign'),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: TextColor.textColor200)
        ),
        child: Column(
          children: [
            _buildImage(),
            _buildCampaignInfo()
          ],
        )
      ),
    );
  }

  Widget _buildCampaignInfo() {
    return Builder(
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text('Trồng cây gây rừng', style: Theme.of(context).textTheme.titleMedium,),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Đã ủng hộ',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300)
                      ),
                      const Text('145 triệu')
                    ],
                  ),
                  Container(
                    width: 2,
                    height: 20,
                    color: TextColor.textColor200,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Mục tiêu',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300)
                      ),
                      const Text('175 triệu')
                    ],
                  ),
                  Container(
                    width: 2,
                    height: 20,
                    color: TextColor.textColor200,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Tham gia',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300)
                      ),
                      const Text('100 người')
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Cập nhật sự kiện'),
                )
              )
            ],
          ),
        );
      }
    );
  }

  Widget _buildImage() {
    return Builder(
      builder: (context) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/6/6c/Vilnius_Marathon_2015_volunteers_by_Augustas_Didzgalvis.jpg',
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return const SizedBox(
                  width: double.infinity,
                  height: 240,
                  child: Center(
                    child: SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator()
                    ),
                  ),
                );
              },
              width: double.infinity,
              height: 240,
              fit: BoxFit.cover,
            ),
            const Positioned(
                left: 10,
                top: 0,
                child: StatusTag(label: 'Còn lại: 25 ngày')
            ),
            Positioned(
              bottom: -30,
              right: 20,
              child: Container(
                width: 60,
                height: 60,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(color: PrimaryColor.primary500, width: 2),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: PrimaryColor.primary500
                  ),
                  child: Center(
                    child: Text(
                      '100%',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                    )
                  ),
                ),
              ),
            )
          ],
        );
      }
    );
  }
}
