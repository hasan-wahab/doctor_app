import 'dart:ui';

import 'package:flutter/material.dart';

class CreditCardWidget extends StatefulWidget {
  final double width;
  final double height;
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cvv;
  final String bankName;
  final bool showLogo;

  const CreditCardWidget({
    super.key,
    this.width = 320,
    this.height = 200,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cvv,
    this.bankName = '',
    this.showLogo = true,
  });

  @override
  State<CreditCardWidget> createState() => _CreditCardWidgetState();
}

class _CreditCardWidgetState extends State<CreditCardWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _isFront = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (_isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    _isFront = !_isFront;
  }

  String _formatCardNumber(String number) {
    // Accepts numbers with spaces — keeps groups of 4
    final clean = number.replaceAll(RegExp(r'[^0-9]'), '');
    final groups = <String>[];
    for (var i = 0; i < clean.length; i += 4) {
      groups.add(clean.substring(i, (i + 4).clamp(0, clean.length)));
    }
    // Mask all groups except last one
    for (var i = 0; i < groups.length - 1; i++) {
      groups[i] = '••••';
    }
    return groups.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final double w = widget.width;
    final double h = widget.height;

    return GestureDetector(
      onTap: _flipCard,
      child: SizedBox(
        width: w,
        height: h,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            // rotation value 0.0 -> 1.0
            final angle = _controller.value * 3.1415926535897932;
            final isUnder = angle > 3.1415926535897932 / 2;
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001) // perspective
                ..rotateY(angle),
              child: isUnder
                  ? Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..rotateY(3.1415926535897932),
                      child: _buildBackCard(w, h),
                    )
                  : _buildFrontCard(w, h),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFrontCard(double w, double h) {
    return Container(
      width: w,
      height: h,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(7, 169, 150, 1), // Your primary color
            Color(0xFF37E2CC),             // Light matching shade
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: bank name + logo
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.bankName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              if (widget.showLogo)
                // you can replace this with Image.asset(...) for actual logo
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'VISA',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.6,
                    ),
                  ),
                ),
            ],
          ),
          const Spacer(),

          //
          // Card number
          Text(
            _formatCardNumber(widget.cardNumber),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              letterSpacing: 2,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          // Card holder and expiry
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Card Holder',
                    style: TextStyle(color: Colors.white70, fontSize: 10),
                  ),
                  Text(
                    widget.cardHolderName.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Expires',
                    style: TextStyle(color: Colors.white70, fontSize: 10),
                  ),
                  Text(
                    widget.expiryDate,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackCard(double w, double h) {
    return Container(
      width: w,
      height: h,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF04786E),   // Dark match
            Color(0xFF0E3A38),   // Deep contrast
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Black magnetic stripe
          Container(height: h * 0.16, color: Colors.black87),
          const SizedBox(height: 12),
          // White box with CVV
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: h * 0.12,
                  color: Colors.white70,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Signature',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 1,
                child: Container(
                  height: h * 0.12,
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: Text(
                    widget.cvv,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          // Bottom row with small logo
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.bankName,
                style: const TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'VISA',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.6,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
