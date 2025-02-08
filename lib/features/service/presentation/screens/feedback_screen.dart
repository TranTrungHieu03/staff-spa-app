import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:spa_mobile/core/utils/constants/exports_navigators.dart';
import 'package:spa_mobile/core/utils/constants/sizes.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  double _rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hãy đánh giá dịch vụ của chúng tôi:',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Bạn đã đánh giá: $_rating sao',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              Form(
                child: TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Enter your feedback ...",
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: TSizes.sm, vertical: TSizes.md),
                    hintStyle: Theme.of(context).textTheme.bodySmall,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSubmitted: (value) {
                    setState(() {});
                  },
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.sm),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  _submitRating();
                },
                child: Text(
                  'Gửi đánh giá',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitRating() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cảm ơn bạn!'),
          content: Text('Bạn đã đánh giá $_rating sao.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                goHome();
              },
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }
}
