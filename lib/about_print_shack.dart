import 'package:flutter/material.dart';

class AboutPrintShack extends StatelessWidget {
  const AboutPrintShack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Page title
          const SizedBox(height: 12),
          Center(
            child: Text(
              'The Union Print Shack',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 18),
          // Images row
          LayoutBuilder(builder: (context, constraints) {
            final isWide = constraints.maxWidth > 700;
            return SizedBox(
              height: isWide ? 220 : 180,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: isWide
                    ? [
                        _imageItem(context, 'assets/images/hoodies.png'),
                        const SizedBox(width: 12),
                        _imageItem(context, 'assets/images/notebook.png'),
                        const SizedBox(width: 12),
                        _imageItem(context, 'assets/images/sweatshirts.png'),
                      ]
                    : [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.asset(
                              'assets/images/hoodies.png',
                              fit: BoxFit.cover,
                              errorBuilder: (c, e, s) => Container(
                                color: Colors.grey[300],
                              ),
                            ),
                          ),
                        ),
                      ],
              ),
            );
          }),
          const SizedBox(height: 18),
          // Content sections (single-column layout to match design)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _section(
                context,
                'Make It Yours at The Union Print Shack',
                'Want to add a personal touch? We\'ve got you covered with heat-pressed customisation on all our clothing. Swing by the shop - our team\'s always happy to help you pick the right gear and answer any questions.',
              ),
              _section(
                context,
                'Uni Gear or Your Gear - We\'ll Personalise It',
                'Whether you\'re repping your university or putting your own spin on a hoodie you already own, we\'ve got you covered. We can personalise official uni-branded clothing and your own items - just bring them in and let\'s get creative!',
              ),
              _section(
                context,
                'Simple Pricing, No Surprises',
                'Customising your gear won\'t break the bank - just £3 for one line of text or a small chest logo, and £5 for two lines or a large back logo. Turnaround time is up to three working days, and we\'ll let you know as soon as it\'s ready to collect.',
              ),
              _section(
                context,
                'Personalisation Terms & Conditions',
                'We will print your clothing exactly as you have provided it to us, whether online or in person. We are not responsible for any spelling errors. Please ensure your chosen text is clearly displayed in either capitals or lowercase. Refunds are not provided for any personalised items.',
              ),
              _section(
                context,
                'Ready to Make It Yours?',
                'Pop in or get in touch today – let\'s create something uniquely you with our personalisation service - The Union Print Shack!',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _section(BuildContext context, String title, String body) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _imageItem(BuildContext context, String asset) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.asset(
          asset,
          fit: BoxFit.cover,
          errorBuilder: (c, e, s) => Container(color: Colors.grey[300]),
        ),
      ),
    );
  }
}
