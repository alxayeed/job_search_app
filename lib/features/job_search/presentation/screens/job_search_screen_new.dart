// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:job_search_app/features/job_search/presentation/screens/widgets/job_card_widget.dart';
// import 'package:lottie/lottie.dart';
//
// import '../blocs/job_search_bloc.dart';
// import '../blocs/job_search_event.dart';
// import '../blocs/job_search_state.dart';
// import 'widgets/job_filter_drawer.dart';
//
// final sl = GetIt.instance;
//
// class JobSearchScreenNew extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider.value(
//       value: sl<JobSearchBloc>()..add(ResetJobSearchEvent()),
//       child: Scaffold(
//         backgroundColor: Color(0xFFF8FAFC),
//         body: NestedScrollView(
//           headerSliverBuilder: (context, innerBoxIsScrolled) => [
//             SliverAppBar(
//               title: Text('Job Search', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
//               backgroundColor: Colors.white,
//               elevation: 0,
//               floating: true,
//               pinned: true,
//               centerTitle: true,
//             ),
//           ],
//           body: JobSearchBodyNew(),
//         ),
//       ),
//     );
//   }
// }
//
// class JobSearchBodyNew extends StatefulWidget {
//   @override
//   _JobSearchBodyNewState createState() => _JobSearchBodyNewState();
// }
//
// class _JobSearchBodyNewState extends State<JobSearchBodyNew> {
//   final TextEditingController _queryController = TextEditingController(text: "Software Engineer");
//   bool _remoteJobsOnly = false;
//   String _datePosted = 'any';
//
//   void _searchJobs() {
//     BlocProvider.of<JobSearchBloc>(context).add(
//       SearchJobsEvent(
//         query: _queryController.text,
//         remoteJobsOnly: _remoteJobsOnly,
//         // employmentType: _employmentType,
//         datePosted: _datePosted,
//       ),
//     );
//   }
//
//   void _openFilterDrawer() {
//     showGeneralDialog(
//       context: context,
//       barrierDismissible: true,
//       barrierLabel: 'Filter',
//       barrierColor: Colors.black.withOpacity(0.4),
//       transitionDuration: Duration(milliseconds: 300),
//       pageBuilder: (context, animation1, animation2) {
//         return Align(
//           alignment: Alignment.centerRight,
//           child: Material(
//             color: Colors.transparent,
//             child: JobFilterDrawer(
//               onApply: () {
//                 Navigator.of(context).pop();
//                 _searchJobs();
//               },
//               onReset: () {
//                 setState(() {
//                   _remoteJobsOnly = false;
//                   // _employmentType = 'Full-time';
//                   _datePosted = 'Today';
//                 });
//                 Navigator.of(context).pop();
//                 _searchJobs();
//               },
//             ),
//           ),
//         );
//       },
//       transitionBuilder: (context, animation, secondaryAnimation, child) {
//         return SlideTransition(
//           position: Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0)).animate(animation),
//           child: child,
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SearchBarWidgetNew(
//           controller: _queryController,
//           onSearch: _searchJobs,
//           onFilterTap: _openFilterDrawer,
//         ),
//         // FilterChipsRow(
//         //   remoteOnly: _remoteJobsOnly,
//         //   employmentType: _employmentType,
//         //   datePosted: _datePosted,
//         // ),
//         Expanded(
//           child: BlocBuilder<JobSearchBloc, JobSearchState>(
//             builder: (context, state) {
//               if (state is JobSearchLoading) {
//                 return Center(child: Lottie.asset('assets/loading.json', width: 200));
//               } else if (state is JobSearchError) {
//                 return Center(child: Text('Error: ${state.failure}'));
//               } else if (state is JobSearchLoaded) {
//                 if (state.jobs.isEmpty) return Center(child: Text('No jobs found'));
//                 return ListView.builder(
//                   padding: EdgeInsets.all(16),
//                   itemCount: state.jobs.length,
//                   itemBuilder: (context, index) => JobCardWidgetNew(job: state.jobs[index]),
//                 );
//               }
//               return Center(child: Text('Search for your next career move'));
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class SearchBarWidgetNew extends StatelessWidget {
//   final TextEditingController controller;
//   final VoidCallback onSearch;
//   final VoidCallback onFilterTap;
//
//   const SearchBarWidgetNew({
//     required this.controller,
//     required this.onSearch,
//     required this.onFilterTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(16),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: Colors.grey.shade200),
//                   ),
//                   child: TextField(
//                     controller: controller,
//                     decoration: InputDecoration(
//                       hintText: 'Job title or keywords',
//                       prefixIcon: Icon(Icons.search, color: Colors.grey),
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 10),
//               GestureDetector(
//                 onTap: onFilterTap,
//                 child: Container(
//                   padding: EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: Colors.grey.shade200),
//                   ),
//                   child: Icon(Icons.tune, color: Color(0xFF0066FF)),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 12),
//           SizedBox(
//             width: double.infinity,
//             height: 48,
//             child: ElevatedButton(
//               onPressed: onSearch,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xFF0066FF),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 elevation: 0,
//               ),
//               child: Text("Search Jobs", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class FilterChipsRow extends StatelessWidget {
//   final bool remoteOnly;
//   final String employmentType;
//   final String datePosted;
//
//   const FilterChipsRow({
//     required this.remoteOnly,
//     required this.employmentType,
//     required this.datePosted,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 35,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         padding: EdgeInsets.symmetric(horizontal: 16),
//         children: [
//           _buildStaticChip(remoteOnly ? "Remote Only" : "On-site/Remote", remoteOnly),
//           SizedBox(width: 8),
//           _buildStaticChip(employmentType, true),
//           SizedBox(width: 8),
//           _buildStaticChip(datePosted, true),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildStaticChip(String label, bool isActive) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: isActive ? Color(0xFF0066FF).withOpacity(0.1) : Colors.grey.shade100,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: isActive ? Color(0xFF0066FF).withOpacity(0.3) : Colors.grey.shade300),
//       ),
//       child: Center(
//         child: Text(
//           label,
//           style: TextStyle(
//             color: isActive ? Color(0xFF0066FF) : Colors.grey.shade600,
//             fontSize: 12,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }
// }