import 'package:flutter/material.dart';

class JobFilterDrawer extends StatefulWidget {
  final VoidCallback? onApply;
  final VoidCallback? onReset;

  const JobFilterDrawer({Key? key, this.onApply, this.onReset}) : super(key: key);

  @override
  State<JobFilterDrawer> createState() => _JobFilterDrawerState();
}

class _JobFilterDrawerState extends State<JobFilterDrawer> {
  String selectedCountry = 'us';
  String datePosted = 'today';
  String employmentType = 'Full-time';
  String experienceLevel = 'Mid';
  bool remoteOnly = true;
  double radius = 25;

  final Color primaryColor = Color(0xFF0066FF);
  final Color chipUnselectedBg = Color(0xFFF0F5FF);
  final Color chipUnselectedText = Color(0xFF4A5568);
  final Color borderLight = Color(0xFFE2E8F0);
  final Color surfaceLight = Colors.white;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: double.infinity,
              color: surfaceLight,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 0, bottom: 16, left: 16),
                        decoration: BoxDecoration(
                          color: surfaceLight,
                          border: Border(bottom: BorderSide(color: borderLight)),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.close, size: 28, color: Colors.black87),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "Filters",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              const Text(
                                "Country",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.black87),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 52,
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: Color(0xFFF8FAFC),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: borderLight),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: selectedCountry,
                                    isExpanded: true,
                                    icon: const Icon(Icons.expand_more, color: Colors.grey),
                                    items: const [
                                      DropdownMenuItem(value: 'us', child: Text('United States')),
                                      DropdownMenuItem(value: 'uk', child: Text('United Kingdom')),
                                      DropdownMenuItem(value: 'ca', child: Text('Canada')),
                                      DropdownMenuItem(value: 'de', child: Text('Germany')),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        selectedCountry = value!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              const Divider(height: 32),
                              const Text(
                                "Date Posted",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                              ),
                              const SizedBox(height: 12),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    _buildChip("Any", "datePosted", "any"),
                                    const SizedBox(width: 8),
                                    _buildChip("Today", "datePosted", "today"),
                                    const SizedBox(width: 8),
                                    _buildChip("3 Days", "datePosted", "3days"),
                                    const SizedBox(width: 8),
                                    _buildChip("Week", "datePosted", "week"),
                                    const SizedBox(width: 8),
                                    _buildChip("Month", "datePosted", "month"),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                "Employment Type",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                              ),
                              const SizedBox(height: 12),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    _buildChip("Full-time", "employmentType", "Full-time"),
                                    const SizedBox(width: 8),
                                    _buildChip("Part-time", "employmentType", "Part-time"),
                                    const SizedBox(width: 8),
                                    _buildChip("Contract", "employmentType", "Contract"),
                                    const SizedBox(width: 8),
                                    _buildChip("Intern", "employmentType", "Intern"),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                "Experience Level",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                              ),
                              const SizedBox(height: 12),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    _buildChip("Entry", "experienceLevel", "Entry"),
                                    const SizedBox(width: 8),
                                    _buildChip("Mid", "experienceLevel", "Mid"),
                                    const SizedBox(width: 8),
                                    _buildChip("Senior", "experienceLevel", "Senior"),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text("Remote Jobs Only", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
                                    ],
                                  ),
                                  Switch.adaptive(
                                    value: remoteOnly,
                                    activeColor: primaryColor,
                                    activeTrackColor: primaryColor.withOpacity(0.3),
                                    onChanged: (val) {
                                      setState(() {
                                        remoteOnly = val;
                                      });
                                    },
                                  )
                                ],
                              ),

                              const SizedBox(height: 24),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Radius", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: primaryColor.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text("${radius.round()} miles",
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: primaryColor)),
                                      )
                                    ],
                                  ),
                                  SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      trackHeight: 6,
                                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
                                      thumbColor: surfaceLight,
                                      overlayColor: primaryColor.withOpacity(0.2),
                                      activeTrackColor: primaryColor,
                                      inactiveTrackColor: borderLight,
                                      valueIndicatorTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                    child: Slider(
                                      min: 0,
                                      max: 100,
                                      divisions: 100,
                                      value: radius,
                                      label: "${radius.round()} mi",
                                      onChanged: (value) {
                                        setState(() {
                                          radius = value;
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 120),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                      decoration: BoxDecoration(
                        color: surfaceLight.withOpacity(0.95),
                        border: Border(top: BorderSide(color: borderLight)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: widget.onReset,
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: borderLight),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              child: const Text("Reset", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 3,
                            child: ElevatedButton(
                              onPressed: widget.onApply,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              child: const Text("Apply Filters", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label, String group, String value) {
    final bool isSelected;
    switch (group) {
      case "datePosted":
        isSelected = datePosted == value;
        break;
      case "employmentType":
        isSelected = employmentType == value;
        break;
      case "experienceLevel":
        isSelected = experienceLevel == value;
        break;
      default:
        isSelected = false;
    }

    final Color bgColor = isSelected ? primaryColor : chipUnselectedBg;
    final Color textColor = isSelected ? Colors.white : chipUnselectedText;

    return GestureDetector(
      onTap: () {
        setState(() {
          switch (group) {
            case "datePosted":
              datePosted = value;
              break;
            case "employmentType":
              employmentType = value;
              break;
            case "experienceLevel":
              experienceLevel = value;
              break;
          }
        });
      },
      child: Container(
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(50),
        ),
        alignment: Alignment.center,
        child: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: textColor)),
      ),
    );
  }
}