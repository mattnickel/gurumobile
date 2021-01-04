import 'package:pull_to_refresh/pull_to_refresh.dart';

// RefreshController _refreshController = RefreshController(initialRefresh: false);
//
// void _onRefresh() async{
//   // call api
//   if(mounted){
//     setState(() {
//
//     });
//   }
//   _refreshController.refreshCompleted();
// }
// void _onLoading() async{
//   _refreshController.loadComplete();
//
// }
//
// @override
// void initState() {
//   super.initState();
// }
//
//
//
// @override
// Widget build(BuildContext context){
//   return SmartRefresher(
//     controller:_refreshController,
//     onLoading: _onLoading,
//     onRefresh: _onRefresh,
//     enablePullDown: true,
//     enablePullUp: true,
//     child: ListView(
//       children:<Widget>[
//         HabitsRow(category: "Daily Habits"),
//         BigRow(category:"For Today"),
//       ],
//     ),
//   );
// }