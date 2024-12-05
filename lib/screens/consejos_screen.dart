import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:panthers_gym/providers/consejos_provider.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';

class ConsejosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ConsejosProvider>(context);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onPrimary),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
        title: Text(
          'Consejos',
          style: textTheme.titleLarge
              ?.copyWith(color: theme.colorScheme.onPrimary),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: size.height * 0.02,
        ),
        child: ListView.builder(
          itemCount: provider.consejos.length,
          itemBuilder: (context, index) {
            final consejo = provider.consejos[index];
            final isExpanded = provider.expandedIndex == index;

            return Card(
              elevation: 5,
              margin: EdgeInsets.only(bottom: size.height * 0.02),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: theme.cardColor,
              child: GestureDetector(
                onTap: () {
                  provider.toggleExpansion(index);
                },
                child: AnimatedCrossFade(
                  duration: const Duration(milliseconds: 300),
                  crossFadeState: isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  firstChild: Padding(
                    padding: EdgeInsets.all(size.width * 0.04),
                    child: Text(
                      consejo['title']!,
                      style: textTheme.bodyLarge?.copyWith(
                        fontSize: isLandscape
                            ? size.width * 0.025
                            : size.width * 0.045,
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                  secondChild: Padding(
                    padding: EdgeInsets.all(size.width * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          consejo['title']!,
                          style: textTheme.bodyLarge?.copyWith(
                            fontSize: isLandscape
                                ? size.width * 0.025
                                : size.width * 0.045,
                            fontWeight: FontWeight.bold,
                            color: theme.primaryColor,
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Center(
                          child: Lottie.asset(
                            consejo['lottie']!,
                            height: isLandscape
                                ? size.height * 0.3
                                : size.height * 0.2,
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Text(
                          consejo['content']!,
                          style: textTheme.bodyMedium?.copyWith(
                            fontSize: isLandscape
                                ? size.width * 0.02
                                : size.width * 0.04,
                            color: theme.colorScheme.onSurface,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
