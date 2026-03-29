import 'package:flutter/material.dart';
import 'package:segura_app/theme/app_colors.dart';

class PrimaryActionCard extends StatefulWidget {
  final String title;
  final IconData? icon;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const PrimaryActionCard({
    super.key,
    required this.title,
    this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  State<PrimaryActionCard> createState() => _PrimaryActionCardState();
}

class _PrimaryActionCardState extends State<PrimaryActionCard> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    widget.onPressed();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedScale(
        scale: _isPressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, color: widget.foregroundColor ?? AppColors.primary, size: 28),
                const SizedBox(width: 12),
              ],
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: widget.foregroundColor ?? AppColors.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
