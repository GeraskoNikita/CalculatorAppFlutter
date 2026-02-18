import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class CalculatorOperatorButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const CalculatorOperatorButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    /// OUTER COLOR
    final Color outerColor = isDarkMode
        ? const Color(0xFFD07419) // dark theme
        : const Color(0xFFD9781F); // light theme

    /// INNER LIGHT SHADOW
    final Color lightShadow = isDarkMode
        ? const Color(0xFFE28927)
        : const Color(0xFFDC862D);

    /// DARK SHADOW (same)
    const Color darkShadow = Color(0x26000000);

    /// GRADIENT
    final List<Color> gradient = isDarkMode
        ? const [Color(0xFFC15D17), Color(0xFFDF8419)]
        : const [Color(0xFFDD732F), Color(0xFFE28D21)];

    /// TEXT COLOR
    const Color textColor = Colors.white;

    return GestureDetector(
      onTap: onTap,

      child: SizedBox(
        width: 77,
        height: 77,

        /// OUTER NEUMORPHIC
        child: Neumorphic(
          style: NeumorphicStyle(
            color: outerColor,

            depth: 0,
            // Drop shadow X:3 Y:3 Blur:7
            intensity: -0.9,

            shadowLightColor: lightShadow,
            shadowDarkColor: darkShadow,

            lightSource: LightSource.topLeft,

            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(23)),
          ),

          child: Padding(
            padding: const EdgeInsets.all(5.74),

            /// INNER NEUMORPHIC
            child: Neumorphic(
              style: NeumorphicStyle(
                depth: -4,
                // Inner shadow X:4 Y:4 Blur:4
                intensity: isDarkMode ? -0.9 : 0.45,

                shadowLightColor: lightShadow,
                shadowDarkColor: darkShadow,

                lightSource: LightSource.topLeft,

                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(18),
                ),
              ),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),

                /// LAYER BLUR = 2
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),

                  child: Container(
                    alignment: Alignment.center,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),

                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: gradient,
                      ),
                    ),

                    child: Text(
                      label,
                      style: const TextStyle(
                        color: textColor,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        fontFamily: "SF Pro",
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
