import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class CalculatorKeyButton extends StatelessWidget {

  final String label;
  final VoidCallback onTap;

  const CalculatorKeyButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    final bool isDarkMode =
        Theme.of(context).brightness == Brightness.dark;

    /// OUTER COLOR
    final Color outerColor = isDarkMode
        ? const Color(0xFF252B38) // dark theme
        : const Color(0xFFD0D3E2); // light theme

    /// INNER LIGHT SHADOW
    final Color lightShadow = isDarkMode
        ? const Color(0xFF383E4E)
        : const Color(0xFFDDE1EC);

    /// DARK SHADOW
    final Color darkShadow = isDarkMode
        ? const Color(0x3D393E51) // 24%
        : const Color(0x26000000); // 15%

    /// GRADIENT
    final List<Color> gradient = isDarkMode
        ? const [
      Color(0xFF2A303E),
      Color(0xFF393E51),
    ]
        : const [
      Color(0xFFCED2DE),
      Color(0xFFECEFF4),
    ];

    /// TEXT COLOR
    final Color textColor =
    isDarkMode ? Colors.white : Colors.black;

    /// SHADOW INTENSITY
    final double intensity = isDarkMode ? 0.85 : -0.9;

    /// DROP SHADOW DEPTH
    final double outerDepth = isDarkMode ? 0 : -3;

    /// INNER SHADOW DEPTH
    final double innerDepth = isDarkMode ? 4 : -0.1;

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

            lightSource: LightSource.bottomRight,

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

                lightSource: LightSource.topLeft,

                shadowLightColor: lightShadow,
                shadowDarkColor: darkShadow,

                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(18),
                ),
              ),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),

                /// LAYER BLUR = 2
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 2,
                    sigmaY: 2,
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
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
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
