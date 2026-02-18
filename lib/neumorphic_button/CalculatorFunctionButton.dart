import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class CalculatorFunctionButton extends StatelessWidget {

  final String label;
  final VoidCallback onTap;

  const CalculatorFunctionButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    final bool isDarkMode =
        Theme.of(context).brightness == Brightness.dark;

    /// OUTER COLORS
    final Color outerColor = isDarkMode
        ? const Color(0xFF545F71)
        : const Color(0xFFB0B9CA);

    /// LIGHT SHADOW
    final Color lightShadow = isDarkMode
        ? const Color(0xFF636C7D)
        : const Color(0xFFC1C9D4);

    /// DARK SHADOW
    final Color darkShadow = const Color(0x26000000);

    /// GRADIENT
    final List<Color> gradient = isDarkMode
        ? const [
      Color(0xFF465262),
      Color(0xFF626B7C),
    ]
        : const [
      Color(0xFFA0ADC4),
      Color(0xFFC5CEDF),
    ];

    /// TEXT
    final Color textColor =
    isDarkMode ? Colors.white : Colors.black;

    /// SHADOW CONTROL (Figma equivalent)
    ///
    /// Drop shadow: X:3 Y:3 Blur:7
    final double outerDepth = isDarkMode ? 0 : -3;

    /// Inner shadow: X:4 Y:4 Blur:4
    final double innerDepth = isDarkMode ? -4 : -4;

    /// Blur strength approximation
    final double intensity = isDarkMode ? 0.4 : -0.9;

    /// Light direction (X,Y)
    final LightSource lightSource = isDarkMode
        ? LightSource.topLeft
        : LightSource.topLeft;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 77,
        height: 77,

        /// OUTER
        child: Neumorphic(
          style: NeumorphicStyle(

            color: outerColor,

            depth: outerDepth,
            intensity: intensity,

            lightSource: lightSource,

            shadowLightColor: lightShadow,
            shadowDarkColor: darkShadow,

            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(23),
            ),
          ),

          child: Padding(
            padding: const EdgeInsets.all(5.74),

            /// INNER
            child: Neumorphic(
              style: NeumorphicStyle(

                depth: innerDepth,
                intensity: intensity,

                lightSource: lightSource,

                shadowLightColor: lightShadow,
                shadowDarkColor: darkShadow,

                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(18),
                ),
              ),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),

                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: isDarkMode ? 2 : 2,
                    sigmaY: isDarkMode ? 2 : 2,
                  ),

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
                      style: TextStyle(
                        color: textColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
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
